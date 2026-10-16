# Project Portfolio — Working Manager View

Snapshot date: 2026-10-16 (GitHub-only follow-up audit)
Source: repository README / explicit project status documents inspected on GitHub. This is a preliminary triage, not a claim that all builds, devices, Play Console submissions, production deployments, or live services were tested.

## Operating rules
- Project-specific truth stays in each repository. Check its AGENTS.md, knowledge library, status docs, recent commits/issues and current code before making changes.
- Separate projects stay separate. Cross-project reuse must be justified and adapted.
- For each substantive change, record the rationale, files, tests and outcome in that repository and update this portfolio.
- Never claim a release, successful test, or revenue readiness without evidence.
- Avoid running hosted builds for documentation-only changes when that repo's policy says manual-only.
- Respect each repo's own safety/approval gates. Production deployment, financial exposure, and changes to live betting/crypto behavior need their own risk controls.
- Revenue priority means shortest credible path to a paying customer, not a promise of income.

## Preliminary revenue-focused queue
These are candidates for further validation, not guarantees or final rankings.

### P1 — Validate commercial path first
1. **vek-boutique** — WooCommerce child theme; README documents syntax/structure/security checks and installable ZIP build. Most direct service/product path if there is an actual store/client. Verify theme compatibility, package output, demo/storefront quality, licensing and customer acquisition. Commercial Flatsome parent theme is not included.
2. **StayGuide_Marke-** — Firebase web application for digital accommodation guides; production Firebase project and manual deploy workflow documented. Validate live app, owner/host onboarding, pricing, privacy/legal pages, deployment status and whether any paying pilot exists. No Android module/APK currently.
3. **MyTurn** — Android queue/appointment/kiosk product. BUILD_TEST_STATUS.md reports 20/20 web UI tests and configured CI, but PRODUCTION_STATUS.md and NEXT_STEPS_ONE_BY_ONE.md identify blockers: secure online multi-business sync/auth, owner/staff roles and rules, push notifications, signed AAB, real-device testing, store/legal setup and a monetization mechanism (Play Billing).
4. **AgroOrder** — customer/producer ordering beta with inventory, delivery scheduling and route grouping. Before public production: real authentication, restrictive Firestore rules, tenant separation and owner-controlled signing. Validate a real producer/customer pilot and unit economics before adding features.
5. **VÉK / StayGuide / MyTurn / AgroOrder** are service/business models; verify actual buyer demand and willingness to pay before expanding scope.

### P2 — Strong use cases, but security/product validation remains
- **FindMeNow** — appointment marketplace (Athens, Larissa, Elassona); requires careful review of auth, role/booking authorization, rate limiting, session security and sensitive-data handling before any deployment. Open security issue #10 records these areas.
- **Fysiokinisi** — physiotherapy scheduling/product prototype. Real authentication/authorization and health-data privacy review are blockers; keep production booking writes fail-closed. Open security issue #2.
- **iCar-AndroidStudio** — documented Release Candidate/Beta v1.0 with real-device tests and signed AAB generation reported by project docs; no billing, ads, analytics or backend currently. Verify latest build, Play Console state, release/legal/privacy and monetization strategy.
- **DogMapGreece** — Android app for registered dog areas and community suggestions. Validate data quality, moderation, map/legal requirements and an actual monetization model.
- **WhoIsGR** — Android caller identification app; needs local Firebase config and production review of Auth/Firestore/privacy/Play declarations.
- **WashnoW** — Android car-wash discovery, with a future live-bay availability direction. Review knowledge library and open security issue #4 before substantive changes.
- **StockCheckGR** — Android app to check availability from a user-shared public URL; deliberately avoids crawling/login/CAPTCHA bypass. Validate usefulness, Play policy and whether a lawful revenue model exists.
- **DiloseTo** — Android app for public-space issue reporting; explicitly independent and not an official municipal app. Production blockers include real HTTPS backend, release signing and camera/GPS device tests. Explore municipal/organization adoption only after validating demand.
- **swap** — Android item-exchange app with Firebase and server-side moderation; v1 is documented as free, without billing/subscriptions/ads. A monetization decision is needed before investing in paid features.

### P3 — Research, tools, or longer path to revenue
- **buildcheck** — property BuildScore MVP/demo; currently explicitly not a technical/legal property inspection. Requires expert validation, clear liability boundaries, source quality and paying-customer discovery.
- **bachelor-trip-dashboard** — focused travel planning PWA for a specific group; no clear recurring commercial model documented.
- **Dunkman-** — read-only betting-tip monitor; no bet submission/cash-out automation. Treat as a tool/research project, not guaranteed income.
- **SuperBet-iPhone-Scanner** — Cloudflare live football scanner with surebet and hard-error alerts. Security hardening issue #13 remains open in the repository; verify SCAN_API_TOKEN and endpoint protections before merging/deploying. Revenue cannot be inferred from alerts.
- **PreGame-scanner-** — isolated pregame Stake/Superbet scanner. Must stay isolated from the frozen production stake-super-bet-scanner; run offline tests and forward validation before considering operational value.
- **stake-super-bet-scanner** — explicitly frozen/golden production baseline. Historical notes report a Bybit/Binance arbitrage lead was net-negative after costs; do not assume profitable opportunities. Do not experiment in this repo.
- **GreyhoundLab** — live research/data collection, PAPER / research only. Follow AGENTS.md, SECURITY_SHIELD.md, fixed research gates and trial ledger; no automatic betting. Do not prioritize as near-term income.
- **AutoCryptoBot** — AutoCryptoLab is simulation-only and does not send real or Binance Demo orders. Prior remembered blocker: .env was not being read; diagnose only when local runtime is available. Preserve testnet-first safety rule (100–200 test trades before Live Mode; then small size and hard safety limits).

### Needs project identity/status verification
- **asep-job-match1** — advisory PWA/Android/iOS wrappers for ASEP/DYPA/ESPA/opportunities. Product guidance only; no guaranteed eligibility. Verify current data freshness, official-source links, Play status, and safe privacy model.
- **gunsgr** — offline static prototype for application-progress tracking; explicitly not an official Hellenic Police app and contains no real sensitive/service data. No Android module yet; production would require written service approval and formal privacy/security review.
- **MyTurn** — status documents disagree on version (1.0.3 vs 1.0.4); reconcile the actual current code/tag/build before release.
- **stake-super-bet-scanner, MyTurn, GreyhoundLab** have no root README.md at the expected path; their alternate status/docs must be treated as their entry point.

## Known cross-project blockers / work to confirm
- A global GitHub issue search surfaced open security-hardening tasks in multiple repos (including SuperBet-iPhone-Scanner #13, Fysiokinisi #2, WashnoW #4 and FindMeNow #10). Recheck each issue and its patch branch before any deployment; issue existence alone does not prove the patch is still missing.
- The user reports that many Android projects were submitted to Google Play Console for testing. That status has not yet been independently verified per app. For each Android app, verify Play Console track, package/applicationId, versionCode, uploaded artifact, tester access, review status, Data Safety, app access, privacy policy and required declarations.
- A README or configured workflow is not proof of a current successful build, deployment, active backend, or paying customer.

## First local-laptop session — planned order
1. Inventory local folders and map each to its exact GitHub remote; do not overwrite dirty worktrees.
2. For every Android project, run the repo's own doctor/security audit/tests/build in isolated folders; preserve logs locally and summarize pass/fail/blockers.
3. Prioritize store-test fixes and real-device tests for the closest-to-release apps; do not sign/release without verifying owner-controlled signing materials and declarations.
4. For web/business projects, verify production endpoints and deployment health read-only first; no deploy until tests/security gates pass.
5. For each candidate with a plausible commercial path, write a short offer/pricing hypothesis, target buyer and validation action before building additional features.
6. Update each project's own status/knowledge file and this portfolio after verified work.

## Project inventory
- stake-super-bet-scanner — frozen live scanner; no experimentation
- DiloseTo — public-space reporting Android app
- asep-job-match1 — benefits/opportunity matching PWA + mobile wrappers
- iCar-AndroidStudio — vehicle maintenance Android app
- MyTurn — queue/appointment/kiosk Android product
- gunsgr — offline application-progress prototype
- DogMapGreece — dog-area Android map
- buildcheck — property BuildScore demo
- StayGuide_Marke- — digital accommodation guide web app
- vek-boutique — WooCommerce child theme
- swap — item-exchange Android app
- WhoIsGR — caller identification Android app
- DiplaMou — MyGuard personal safety Android app
- StockCheckGR — shared-URL stock availability Android app
- AgroOrder — producer ordering PWA/Android beta
- Dunkman- — read-only betting-tip monitor
- FindMeNow — professional booking marketplace
- WashnoW — car-wash discovery Android app
- Fysiokinisi — physiotherapy scheduling Android app
- SuperBet-iPhone-Scanner — live football scanner on Cloudflare
- GreyhoundLab — paper-only racing research platform
- bachelor-trip-dashboard — bachelor trip PWA
- AutoCryptoBot — crypto strategy research/simulation lab
- PreGame-scanner- — isolated pregame scanner
- MikemigkDev — central management protocol and portfolio


## Verified follow-up — 2026-10-16

The GitHub-only follow-up audit now has separate supporting records:
- [Management snapshot](AUDIT_SNAPSHOT_2026-10-16.md)
- [Observed CI findings](CI_FINDINGS_2026-10-16.md)
- [Cross-project security triage](SECURITY_TRIAGE_2026-10-16.md)

New evidence that changes priorities:
- DogMapGreece PR #18: the observed Android CI run succeeded for build/lint/unit tests and selected artifact upload. This is narrow PR evidence only.
- StayGuide PR #20: observed CI failed. The production dependency audit reported five advisories (including one critical), and Android setup failed before Android tests due to the unavailable `sdkmanager tools` package.
- StockCheckGR: a historical CI run from 2026-08-03 failed Kotlin compilation on missing resource references; it does not prove current main is broken, but the dependency-action PR itself does not resolve that failure.
- Swap guided-tour PR #18: observed Android build/test run succeeded and uploaded a debug APK artifact; release publishing was skipped. Swap's separate local-agent security issue #13 remains open.
- WhoIsGR PR #5: code review found a proposed Firestore rule that allows listing report documents without requiring authentication, with potential exposure of phone/note/UID fields. This is a merge blocker until rules and emulator tests are corrected.
- DiloseTo PR #23: the security branch exists, but no PR-triggered CI run was returned in the lookup. The installer starts a persistent watchdog; review its install/start/stop lifecycle before any local execution.
- Swap and asep-job-match1: the named `security/hardening-2026-09-24` branch could not be found in branch searches, and no matching security PR was surfaced. Treat those local-agent fixes as unavailable for review until a branch/PR is restored or identified.

This remains a GitHub-only audit. No local laptop, emulator, Play Console, production Firebase/Cloudflare deployment, or customer/revenue status was verified.


### StayGuide PR #20 — data-retention review
The draft changes the Free plan limit from three guides to one and updates the guide-limit guard that removes excess entries. Existing Free users with multiple guides may be affected when the guard runs. Before merge, define an explicit grandfathering/migration policy and add tests to ensure the plan change does not cause unintended loss of existing guide content or associated files. This is separate from the observed CI failures. The PR remains draft and was not changed by this audit.


### Cross-project risk count — 2026-10-16
A GitHub-wide open-issue search returned 20 security-hardening issues across the project repositories. The complete current review queue is in [SECURITY_TRIAGE_2026-10-16.md](SECURITY_TRIAGE_2026-10-16.md). Do not interpret an open issue as proof that the finding is still present on main; inspect the actual branch and deployment path. Equally, an issue saying “patch staged” is not proof that a reviewable branch exists: the named security branch was not found for Swap or asep-job-match1.


### MyTurn — expanded version-source mismatch (verified 2026-10-16)
The current main-branch `app/build.gradle` declares versionName `1.0.9` and versionCode `10`. Repository docs still label MyTurn as 1.0.3 (`PRODUCTION_STATUS.md`), 1.0.4 (`BUILD_TEST_STATUS.md`), and 1.0.2 / “v1.2” (`README_GOOGLE_PLAY.md`). The current CI artifact name says `myturn-1.0.9-firebase-locked-debug-apk`. Treat the Gradle file as the current code declaration, but do not infer the actual Play Console/uploaded version. Reconcile the docs and release evidence before any store submission.


### Frozen scanner — version documentation and open PR boundary
The current `extension/manifest.json` in `stake-super-bet-scanner/main` declares version `6.7.7`, while the root `README.txt` still says `v6.4`. PR #2 remains open/draft and targets `main` from `dev-intelligence`; its body says the extension is unchanged but adds a separate intelligence backend/dashboard and launcher. Under the frozen/golden-baseline rule, keep PR #2 unmerged and do not use this repository for experiments. Correct the README version only through a separately reviewed documentation change if/when authorized.
