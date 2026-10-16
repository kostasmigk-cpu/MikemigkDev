# CI Findings — 2026-10-16

Read-only review of multiple existing GitHub Actions runs and PR-head metadata. No workflow was triggered by this review.

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


## asep-job-match1 — PR #44 Android reliability candidate
Observed current PR-head workflow lookups returned two failed runs:
- [Build and tests #98](https://github.com/kostasmigk-cpu/asep-job-match1/actions/runs/30918907978) — failed.
- [Build Android APK #3](https://github.com/kostasmigk-cpu/asep-job-match1/actions/runs/30918907875) — failed.

The connector could return the job summaries but the underlying log blob was unavailable when requested, so the exact failure cause is **not established here**. Do not infer a fix from the failure alone. The open Dependabot PRs #50 (setup-android v4), #51 (gradle/actions v6), and #53 (setup-java v6) returned no PR-triggered workflow runs in the lookup. Validate compatibility and required checks before merging them. The separate local-agent security issue #54 remains open; branch search did not find the issue's named security branch.


## WhoIsGR — PR #1 Play-readiness candidate
Run: https://github.com/kostasmigk-cpu/WhoIsGR/actions/runs/30741783592

The Android CI run for PR #1 completed successfully. This is a separate branch from PR #5, the Firestore-rules/caller-data change; it does not validate PR #5. PR #1 still needs the normal review and explicit release/merge decision, and GitHub CI does not verify Play Console state.

## bachelor-trip-dashboard — PR #1 Trip Crew public-product candidate
Run: https://github.com/kostasmigk-cpu/bachelor-trip-dashboard/actions/runs/34688096178

Trip Crew CI completed successfully for the draft PR. The PR body still requires a new isolated production D1 database, only the public migrations, and further release checks. The private September 11–14, 2026 bachelor-trip date window documented in the current README has passed as of this snapshot; treat the original group trip as historical and validate whether the separate public product has an active product owner/buyer before further investment.

## stake-super-bet-scanner — frozen production baseline
- [PR #2](https://github.com/kostasmigk-cpu/stake-super-bet-scanner/pull/2) remains open/draft and targets main from `dev-intelligence`.
- [PR #5](https://github.com/kostasmigk-cpu/stake-super-bet-scanner/pull/5) remains open/draft and targets `dev-intelligence` from `android-portable`.
- The workflow lookup returned no PR-triggered runs for PR #2's head. Keep both drafts unmerged under the frozen/golden-baseline rule. New intelligence/Android experiments belong in the isolated PreGame or separate development project, not the frozen production baseline.


## SuperBet-iPhone-Scanner — corner feature PRs
- [PR #30 shadow collector run](https://github.com/kostasmigk-cpu/SuperBet-iPhone-Scanner/actions/runs/36599993038) failed its matcher regression tests. The log shows failures for “accepts fresh live 1X2 Novibet quote” and “accepts fresh prematch corners for inventory but never lag” (2 failing tests). Keep PR #30 unmerged until the matcher behavior and tests are reconciled.
- [PR #26 corner market availability run](https://github.com/kostasmigk-cpu/SuperBet-iPhone-Scanner/actions/runs/36551387260) completed successfully. This is limited evidence for that branch's test suite and does not resolve the repository's open security issue #13 or prove production readiness.


## DiplaMou — PR #1 V9 build verification
Run: https://github.com/kostasmigk-cpu/DiplaMou/actions/runs/30730157265

The run failed at “Restore Android project” before compilation. The workflow reconstructed `project.zip` from base64 parts, but `unzip` reported a missing end-of-central-directory signature. This is a packaging/restore failure; it provides no evidence that the app source compiles or fails. The run is dated 2026-08-02, so it is historical. Fix and validate the source bundle/reconstruction process before treating PR #1 as a verified build; the separate privacy/security issue #6 remains open.


### Confirmed remediation direction for the StayGuide SDK setup failure
The upstream `android-actions/setup-android` README documents that Google no longer serves the legacy `tools` SDK package and that requesting it causes “Failed to find package 'tools'”. It documents `android-actions/setup-android@v4` and a `packages` input to avoid the removed package. Reference: https://github.com/android-actions/setup-android#additional-packages and https://github.com/android-actions/setup-android#the-deprecated-tools-package

Recommended code change for a future approved fix: update StayGuide's workflow to a supported setup-android v4 configuration (or explicitly set packages to the required SDK packages), then run the Android lint/tests. This is a recommendation only; no workflow code was changed and no run was triggered.


## StayGuide — Stripe dependency PR #9
Run: https://github.com/kostasmigk-cpu/StayGuide_Marke-/actions/runs/31163914975

This historical run (2026-08-07) failed at the project audit before dependency installation. The log's concrete message was `ERROR: Functions lock mismatch: firebase-functions.` The run does not establish whether that mismatch still exists on current main. Before considering PR #9, rerun the current project audit and ensure `functions/package.json` and its lockfile are consistent; the later PR #20 also has separate dependency-audit and Android SDK setup failures.


## DogMapGreece — PR #15 product candidate and PR #5 iOS bootstrap
- [PR #15 Android CI](https://github.com/kostasmigk-cpu/DogMapGreece/actions/runs/34492189265) completed successfully for the 5.5.0 candidate's Android build/test workflow. It remains an open PR, not a release.
- PR #5 (native iOS bootstrap) is open and no PR-triggered workflow run was returned for its current head. Treat iOS build/readiness as unverified until an appropriate macOS/Xcode validation path is available.


### StockCheckGR follow-up on the historical compile failure
The current main branch now contains the missing status color/drawable resources reported by the 2026-08-03 run. The open Dependabot branch `dependabot/github_actions/actions/upload-artifact-7` still has an older `colors.xml` without the four status aliases. Because the PR's declared diff is only the artifact-action version change, do not assume it deletes the newer main resources; instead, rerun CI against the current PR merge base and ensure the PR is not validated solely on its stale head commit.


## Swap — duplicate guided-tour branches
Open PR #16 is a draft on `feature/first-run-guided-tour`; open PR #18 is a non-draft on `feature/first-run-guided-tour-v2`. Both touch the same guided-tour UI files. PR #18 has the observed successful Android build/test run above; PR #16 is an overlapping alternative and has no PR-triggered workflow run returned by the lookup. Keep the work consolidated into one reviewed implementation; do not merge both independently.
