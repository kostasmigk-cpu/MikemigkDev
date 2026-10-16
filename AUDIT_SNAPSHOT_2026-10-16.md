# GitHub Management Snapshot — 2026-10-16

This is a read-only management snapshot from GitHub repository documentation, open issue searches, and open pull-request searches. It is not a local build, device test, Play Console verification, production health check, or a complete line-by-line security audit.

## Operating boundaries

- No remote desktop, local terminal, deployment, merge, release, secret rotation, production data change, or device action was performed for this snapshot.
- Open PRs and issues are not evidence that a patch is correct or deployed. Treat draft/security changes as unverified until reviewed and their required tests are observed.
- Keep each repository independent and obey its own security/CI rules.

## Highest-priority management queue

### 1. Security work awaiting review/validation

| Project | Current GitHub evidence | Management decision |
|---|---|---|
| iCar-AndroidStudio | Open draft PR #6 for local-agent hardening; issue #3 still open. PR body says Android Gradle tests/lint/build have not completed. | Keep draft. Review diff and run permitted tests before merge; no local agent/device action until reviewed. |
| DogMapGreece | Open PR #18 narrows Android CI artifact paths; open PR #15 is a product candidate; issue #16 remains a security audit task. | Review security PR separately from product PR. Do not treat #18 as the full Firebase/API security audit. |
| SuperBet-iPhone-Scanner | Open issue #13; multiple open feature/probe PRs (#16, #21, #26, #27, #30). Issue identifies authentication for manual scan POST, trusted update behavior, and SCAN_API_TOKEN as hardening topics. | Security review before merge/deploy. Keep temporary probe PR #27 unmerged unless its purpose and safety are re-confirmed. Do not infer profitability from scanner output. |
| Fysiokinisi | Open issue #2; knowledge library states real end-user authentication/authorization is incomplete and production mutations must remain fail-closed. | No production booking writes until authentication, authorization, privacy, and tests are validated. Health-related data increases risk. |
| WashnoW | Open issue #4; knowledge library says no real shared LIVE backend or Owner Panel exists and project infrastructure must stay at €0 unless approved. | Do not label availability as live. Review Android backup/token/rate-limit/CORS controls; avoid paid infrastructure without explicit approval. |
| FindMeNow | Open draft security PR #13; open issue #10 covers CORS, password hashing, rate limits, session expiry, IDOR/role escalation, and booking authorization. | Inspect PR diff and CI before merge; separately confirm booking authorization and concurrency protections. |
| MyTurn | Open draft security PR #11 and open security issue #9. BUILD_TEST_STATUS.md reports 20/20 web UI tests and syntax/config checks; PRODUCTION_STATUS.md labels 1.0.3 while BUILD_TEST_STATUS.md labels 1.0.4. | Resolve version/source-of-truth mismatch; inspect Firebase rules, Android manifest, deep links, secret handling, auth/roles and CI. No public-sale/release claim yet. |
| AgroOrder | Open draft security PR #10 and open issue #8. Knowledge library requires producer/customer isolation, server-side authorization, atomic stock changes, and legacy Firebase blocking. | Review security rules, immutable order identity/status fields, WebView/service-worker behavior, and tests. No production rollout until validated. |
| StayGuide_Marke- | Open draft monetization PR #20 and open security issue #21; another open PR #9 updates Stripe dependency. README says production deploy is manual workflow only and no Android Gradle module/APK exists. | Do not merge/deploy billing until Play products, verification secrets/API, RTDN, restore/deletion flow, tests and policy requirements are validated. Do not claim an APK exists. |
| vek-boutique | Open PR #1 for native iOS foundation; open issue #2 for WordPress/WooCommerce security review. README requires repo private and secrets excluded. | Review iOS work separately from theme production; preserve private visibility and review WordPress nonce/capability/escaping/payment-secret controls. |

## Verified project-specific notes

### MyTurn
- BUILD_TEST_STATUS.md: reports 20/20 web UI tests, secret-pattern scan, JavaScript syntax and JSON/XML parsing passed; Android build/device test not confirmed in that document.
- PRODUCTION_STATUS.md: states signed AAB needs owner-controlled upload keystore; lists staff roles/auth, billing, push, device tests and legal details as pre-sale blockers.
- The version discrepancy (1.0.3 vs 1.0.4) is confirmed in repository docs and must be resolved against the actual code/tag/build.

### StayGuide_Marke-
- README states the project is a Firebase web application, production deployment is manual via protected workflow, Cloud Functions use Node.js 22, and no real Android Gradle module or APK currently exists.
- Billing PR #20 is explicitly gated on Play Console configuration, purchase verification, RTDN, and policy checks. It is not a production-ready feature merely because the PR exists.

### AgroOrder
- docs/KNOWLEDGE_LIBRARY.md requires server-side authorization, UID-based customer identity, producer isolation by ownership/path, and atomic stock mutations.
- Legacy unscoped Firebase is deliberately blocked in the safe beta. Do not relax these constraints for convenience.

### Fysiokinisi and WashnoW
- Fysiokinisi's knowledge library says authentication/authorization is incomplete, production mutations must remain fail-closed, and tests are not yet present for core booking/roles/time-zone/UI paths.
- WashnoW's knowledge library says shared LIVE availability and an Owner Panel do not yet exist. Current OSM/Overpass discovery is not a guarantee of full coverage or unlimited availability.

### iCar-AndroidStudio
- README describes a Release Candidate/Beta v1.0 and documents real-device tests and signed AAB generation, but the current security PR #6 explicitly says its Android tests/lint/build have not yet completed. Treat release readiness as unconfirmed until the current branch is validated.

## Next work order

1. Review security PR diffs and required checks in this order: MyTurn, FindMeNow, AgroOrder, iCar, DogMapGreece, SuperBet-iPhone-Scanner, StayGuide, then Fysiokinisi/WashnoW/vek-boutique issues.
2. Keep all draft PRs unmerged until diff review and project-specific tests are complete. Do not run CI for documentation-only changes or against projects with manual-only workflows.
3. Reconcile MyTurn's version/build source of truth.
4. After security blockers, verify Android release evidence project by project (package/applicationId, versionCode, artifact, Play Console track/testers, Data Safety, app access, privacy policy and declarations). GitHub alone cannot establish Play Console state.
5. For revenue candidates (vek-boutique, StayGuide, MyTurn, AgroOrder), validate a real buyer/pilot and pricing before expanding scope.
6. Update this snapshot only when a fact changes and cite the exact PR/issue/build evidence.

## Explicitly not verified

- Local laptop folders, dirty worktrees, local builds, emulators or physical-device behavior.
- Whether any listed PR has passing CI after this snapshot, whether patches are deployed, or whether secrets are configured correctly.
- Current Google Play Console submission/review/testing status for any app.
- Production endpoint uptime, actual customers, revenue, or commercial demand.
- Full security audit of all 24 projects.
