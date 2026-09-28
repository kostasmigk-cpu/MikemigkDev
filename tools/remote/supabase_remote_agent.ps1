$ErrorActionPreference = "Stop"

$BaseDir = Join-Path $env:LOCALAPPDATA "MikeRemote"
$TokenFile = Join-Path $BaseDir "agent.token"
$LogFile = Join-Path $BaseDir "agent.log"
$Endpoint = "https://vfkcuhxwdmnrqxdsxbhz.supabase.co/functions/v1/remote-agent"
$DeviceId = "MIKEMIGK"
$Version = "1.0.2"
$PollSeconds = 15
$HeartbeatSeconds = 60

New-Item -ItemType Directory -Path $BaseDir -Force | Out-Null
if (-not (Test-Path $TokenFile)) { throw "Missing token file: $TokenFile" }
$Token = (Get-Content $TokenFile -Raw).Trim()
if (-not $Token) { throw "Empty token" }

function Write-AgentLog([string]$Message) {
  try {
    $line = ("{0} {1}" -f (Get-Date).ToString("s"), $Message)
    Add-Content -Path $LogFile -Value $line -Encoding UTF8
    $item = Get-Item $LogFile -ErrorAction SilentlyContinue
    if ($item -and $item.Length -gt 2097152) {
      Get-Content $LogFile -Tail 1000 | Set-Content $LogFile -Encoding UTF8
    }
  } catch {}
}

function Invoke-AgentPost([hashtable]$Payload) {
  $headers = @{ "x-agent-token" = $Token }
  $json = $Payload | ConvertTo-Json -Depth 8 -Compress
  Invoke-RestMethod -Method Post -Uri $Endpoint -Headers $headers -ContentType "application/json" -Body $json -TimeoutSec 20
}

function Send-Heartbeat([string]$Status, [string]$LastCommandId = "") {
  $body = @{
    action = "heartbeat"
    device_id = $DeviceId
    hostname = $env:COMPUTERNAME
    agent_version = $Version
    status = $Status
  }
  if ($LastCommandId) { $body.last_command_id = $LastCommandId }
  [void](Invoke-AgentPost $body)
}

function Run-RemoteCommand($CommandRow) {
  $id = [string]$CommandRow.id
  $shell = ([string]$CommandRow.shell).ToLowerInvariant()
  $cwd = [string]$CommandRow.cwd
  $cmd = [string]$CommandRow.command
  $timeout = [int]$CommandRow.timeout_seconds

  if (-not $cwd -or -not (Test-Path -LiteralPath $cwd -PathType Container)) { $cwd = $env:USERPROFILE }
  if ($timeout -lt 1) { $timeout = 60 }
  if ($timeout -gt 900) { $timeout = 900 }

  [void](Invoke-AgentPost @{ action = "start"; device_id = $DeviceId; id = $id })

  $work = Join-Path $BaseDir ("job-" + $id)
  New-Item -ItemType Directory -Path $work -Force | Out-Null

  try {
    if ($shell -eq "cmd") {
      $job = Join-Path $work "command.cmd"
      [IO.File]::WriteAllText($job, "@echo off" + [Environment]::NewLine + $cmd + [Environment]::NewLine, [Text.Encoding]::Default)
      $fileName = $env:ComSpec
      $arguments = '/d /c "' + $job + '"'
    } else {
      $job = Join-Path $work "command.ps1"
      [IO.File]::WriteAllText($job, $cmd, (New-Object Text.UTF8Encoding($false)))
      $fileName = "powershell.exe"
      $arguments = '-NoProfile -ExecutionPolicy Bypass -File "' + $job + '"'
    }

    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName = $fileName
    $psi.Arguments = $arguments
    $psi.WorkingDirectory = $cwd
    $psi.UseShellExecute = $false
    $psi.CreateNoWindow = $true
    $psi.RedirectStandardOutput = $true
    $psi.RedirectStandardError = $true

    $proc = New-Object System.Diagnostics.Process
    $proc.StartInfo = $psi
    if (-not $proc.Start()) { throw "Failed to start command process" }

    $outTask = $proc.StandardOutput.ReadToEndAsync()
    $errTask = $proc.StandardError.ReadToEndAsync()

    $finished = $proc.WaitForExit($timeout * 1000)
    if (-not $finished) {
      try { & taskkill.exe /PID $proc.Id /T /F | Out-Null } catch {}
      try { $proc.Kill() } catch {}
      throw "Command timed out after $timeout seconds"
    }

    try { $proc.WaitForExit() } catch {}
    $out = $outTask.GetAwaiter().GetResult()
    $err = $errTask.GetAwaiter().GetResult()
    if ($null -eq $out) { $out = "" }
    if ($null -eq $err) { $err = "" }
    if ($out.Length -gt 180000) { $out = $out.Substring($out.Length - 180000) }
    if ($err.Length -gt 18000) { $err = $err.Substring($err.Length - 18000) }

    $status = if ($proc.ExitCode -eq 0) { "completed" } else { "failed" }
    [void](Invoke-AgentPost @{
      action = "result"
      device_id = $DeviceId
      id = $id
      status = $status
      exit_code = $proc.ExitCode
      output = $out
      error = $err
    })
  } catch {
    $msg = $_.Exception.Message
    try {
      [void](Invoke-AgentPost @{
        action = "result"
        device_id = $DeviceId
        id = $id
        status = "failed"
        exit_code = -1
        output = ""
        error = $msg
      })
    } catch {}
    Write-AgentLog ("JOB_FAIL id=$id " + $msg)
  } finally {
    try { Remove-Item $work -Recurse -Force -ErrorAction SilentlyContinue } catch {}
  }
}

Write-AgentLog "START version=$Version device=$DeviceId"
$lastHeartbeat = [DateTime]::MinValue

while ($true) {
  try {
    if (((Get-Date) - $lastHeartbeat).TotalSeconds -ge $HeartbeatSeconds) {
      Send-Heartbeat "online"
      $lastHeartbeat = Get-Date
    }

    $headers = @{ "x-agent-token" = $Token }
    $url = $Endpoint + "?device_id=" + [Uri]::EscapeDataString($DeviceId)
    $response = Invoke-RestMethod -Method Get -Uri $url -Headers $headers -TimeoutSec 20
    if ($null -ne $response.command) {
      $cid = [string]$response.command.id
      Write-AgentLog ("JOB_START id=$cid")
      Run-RemoteCommand $response.command
      try { Send-Heartbeat "online" $cid } catch {}
      Write-AgentLog ("JOB_END id=$cid")
    }
  } catch {
    Write-AgentLog ("LOOP_ERROR " + $_.Exception.Message)
  }
  Start-Sleep -Seconds $PollSeconds
}
