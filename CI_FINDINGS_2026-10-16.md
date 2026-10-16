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