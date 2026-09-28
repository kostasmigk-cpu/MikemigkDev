# Remote access reference

Last verified: 2026-09-28.

Use this file only as a capability reference. Verify that a channel is online before assuming access to the Windows laptop MIKEMIGK. Never commit passwords, app passwords, API secret keys, device tokens, session cookies, or private keys.

Preferred path: Supabase remote command queue. The backend Edge Function is active. The Windows agent is stored at tools/remote/supabase_remote_agent.ps1 and must be running locally. Check for a recent MIKEMIGK heartbeat before sending work.

Fallbacks:
- Gmail remote: existing chatgpt-gmail-remote-v1 protocol; useful only when the local watcher is already running.
- Desktop Commander Remote MCP: use only when the device is online and remote-call quota is available.
- GitHub self-hosted runner or local GitHub control agent: fallback only; verify runner/agent state first.
- Tailscale/SSH: optional direct human-access route.
- Open Interpreter + Ollama: optional separate local AI route; not a direct ChatGPT-to-laptop bridge.

Order of use: Supabase agent, then Gmail bootstrap, then Desktop Commander, then the explicit fallbacks above.
