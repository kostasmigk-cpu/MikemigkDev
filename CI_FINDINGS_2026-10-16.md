# CI Findings — 2026-10-16

Read-only review of two existing GitHub Actions runs. No workflow was triggered by this review.

## DogMapGreece — PR #18
Run: https://github.com/kostasmigk-cpu/DogMapGreece/actions/runs/38214703986

The Android CI run completed successfully. Its job reports success for Android SDK 36 setup, Gradle wrapper validation, clean debug build, lint, unit tests, and upload of the selected APK/reports. This supports the narrow artifact-path change in PR #18 only. It does not close the separate Firebase/API security issue or prove deployment.

## StayGuide_Marke- — PR #20
Run: https://github.com/kostasmigk-cpu/StayGuide_Marke-/actions/runs/38066181548

The run failed in both jobs.

- Cloud Functions: project audit, dependency install, and syntax checks passed. The production dependency audit failed and reported five advisories: two moderate, two high, one critical. Named affected packages include @grpc/grpc-js, brace-expansion, proxy-addr, and uuid. Do not apply a broad automated dependency fix without reviewing the dependency tree, lockfile changes, compatibility, and tests.
- Android: setup failed before SDK installation and before lint/tests. The setup action called sdkmanager with the obsolete/unavailable package name "tools", which returned "Failed to find package 'tools'". This is a CI setup failure, not a failed Android code test.

Management decision: keep billing PR #20 as draft. First perform targeted dependency remediation and correct Android SDK setup, then rerun required checks. Do not merge or deploy billing based on this run.

## Other current security PR heads
Workflow-run lookup returned no PR-triggered runs for MyTurn #11, FindMeNow #13, AgroOrder #10, and iCar #6. This is not proof that no other workflow runs exist, but this lookup provided no passing PR-run evidence. All four remain draft/unmerged.

## Boundaries
No merge, deploy, secret changes, local command, or device operation was performed.

## StockCheckGR — dependency PR #1
Run: https://github.com/kostasmigk-cpu/StockCheckGR/actions/runs/30857415382

The Android CI run failed during Kotlin compilation before lint/build/artifact upload. Reported unresolved resource references in MainActivity.kt include `status_green`, `bg_status_likely`, `bg_status_icon_likely`, `status_amber`, `bg_status_unavailable`, `bg_status_icon_unavailable`, `status_red`, and `text_secondary`. This run is from 2026-08-03 and is historical evidence, not proof of the current main branch state. The Dependabot artifact-action version change itself does not fix these compile errors.

## Swap — guided tour PR #18
Run: https://github.com/kostasmigk-cpu/swap/actions/runs/36965483438

The Android Manual Build workflow completed successfully for its PR head: backend JavaScript syntax, unit tests, debug APK build, and APK artifact upload all reported success. The release publishing job was skipped. This is evidence for that build/test run, not a Play release or security sign-off. Swap security issue #13 remains open, so local-agent hardening is still a separate track.

## DiloseTo and WhoIsGR security work
- DiloseTo PR #23 is open/draft and its current PR-head lookup returned no PR-triggered workflow run. The diff adds command expiry, local approval/signature checks, replay protection, and tests, but the installer also creates/starts a persistent watchdog and removes an existing STOP marker. Do not run the installer or promote this PR until the full installer/update/stop behavior and the Windows-specific secret initialization are reviewed and the security test workflow has actually run.
- WhoIsGR PR #5 is open and not draft, but the current PR-head lookup returned no PR-triggered workflow run. The patch adds Firestore rules and caller-number entries marked as verified using official URLs; validate each number and source before treating the entries as current verified data. The repo's own security issue #6 remains open. Do not infer deployed Firestore rules from a rules file in Git.

No workflow was triggered during this review.
