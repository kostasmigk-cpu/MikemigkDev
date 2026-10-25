# AI Knowledge Hub — Cross-Project Rollout

**Date:** 2026-10-20  
**Scope:** Documentation-only review and knowledge-library rollout across repositories owned by kostasmigk-cpu.

## Operating rules

- Repositories remain separate. Do not copy implementation code or secrets between projects.
- Documentation PRs stay **draft/open** until reviewed. Nothing in this rollout is merged or deployed.
- No CI, build, local CMD/PowerShell, production API, account, billing, exchange order, cloud deployment or secret-rotation operation was performed.
- A documentation checklist is not proof that the described control exists. Each item must be checked against the current code/configuration and a recorded test result.
- The frozen production repository `stake-super-bet-scanner` must not be edited, tested, committed to, merged into or used for experiments. Continue all new pregame work only in `PreGame-scanner-`.

## Draft pull requests opened

**Current total: 23 project-level documentation PRs, plus this central tracking PR.**

### Existing Knowledge Library refreshes

| Project | Draft PR | Scope |
|---|---|---|
| Swap | [#27](https://github.com/kostasmigk-cpu/swap/pull/27) | OWASP WebView risks, Firebase Rules tests, Cloudflare Worker boundary, billing/deletion release gates |
| GreyhoundLab | [#6](https://github.com/kostasmigk-cpu/GreyhoundLab/pull/6) | Direct-to-main research workflow risk, GitHub Actions least privilege, probability calibration/evaluation |
| AutoCryptoBot | [#7](https://github.com/kostasmigk-cpu/AutoCryptoBot/pull/7) | Exchange API key boundaries, demo/testnet isolation, net-of-cost research gates, emergency-stop review |
| Φυσιοκίνηση | [#5](https://github.com/kostasmigk-cpu/Fysiokinisi/pull/5) | Health/progress data privacy, Worker/D1 authorization, booking concurrency, negative tests |
| SuperBet iPhone Scanner | [#46](https://github.com/kostasmigk-cpu/SuperBet-iPhone-Scanner/pull/46) | Workflow publishing controls, quote freshness, quota and deployment-truth checks |

### New Knowledge Libraries bootstrapped

| Project | Draft PR | Scope |
|---|---|---|
| Δικαιούμαι / ASEP Job Match | [#57](https://github.com/kostasmigk-cpu/asep-job-match1/pull/57) | Official-source provenance, advisory-only matching, privacy, accessibility |
| Δήλωσέ Το | [#24](https://github.com/kostasmigk-cpu/DiloseTo/pull/24) | Location/photo privacy, non-affiliation, backend authorization |
| Πορεία Αίτησης / gunsgr | [#15](https://github.com/kostasmigk-cpu/gunsgr/pull/15) | Offline prototype, synthetic-only data, Windows script safety |
| DogMap Greece | [#19](https://github.com/kostasmigk-cpu/DogMapGreece/pull/19) | Official vs community place provenance, location privacy, map attribution |
| iCar | [#7](https://github.com/kostasmigk-cpu/iCar-AndroidStudio/pull/7) | Vehicle data privacy, backup/restore integrity, photo/PDF sharing |
| Dunkman | [#4](https://github.com/kostasmigk-cpu/Dunkman-/pull/4) | Read-only monitoring, odds freshness, browser/session safety, Telegram secret follow-up |
| Find Me Now | [#14](https://github.com/kostasmigk-cpu/FindMeNow/pull/14) | Appointment authorization, professional verification, booking race conditions |
| PreGame Scanner | [#3](https://github.com/kostasmigk-cpu/PreGame-scanner-/pull/3) | Market identity, freshness, passive-only boundary and frozen-repo separation |
| Bachelor Trip Dashboard | [#4](https://github.com/kostasmigk-cpu/bachelor-trip-dashboard/pull/4) | Invite-link privacy, Duffel token handling, quote expiry and planning-vs-booking distinction |
| WhoIsGR | [#9](https://github.com/kostasmigk-cpu/WhoIsGR/pull/9) | Caller-identification privacy, phone-number enumeration, permissions and Firebase boundaries |
| MyTurn | [#12](https://github.com/kostasmigk-cpu/MyTurn/pull/12) | Queue state consistency, role authorization, QR privacy, Firebase rules |
| BuildCheck GR | [#9](https://github.com/kostasmigk-cpu/buildcheck/pull/9) | Property score provenance, uncertainty, privacy and non-professional-advice boundary |
| VÉK Boutique | [#5](https://github.com/kostasmigk-cpu/vek-boutique/pull/5) | WooCommerce child-theme safety, customer/payment data, ZIP and dependency review |
| StayGuide | [#24](https://github.com/kostasmigk-cpu/StayGuide_Marke-/pull/24) | Stripe webhook authority, guest/public guide boundaries, CSP and deployment truth |
| MyGuard / DiplaMou | [#11](https://github.com/kostasmigk-cpu/DiplaMou/pull/11) | SOS safety tests, Android permissions, location/privacy and versioned safety evidence |
| StockCheckGR | [#12](https://github.com/kostasmigk-cpu/StockCheckGR/pull/12) | SSRF-safe URL fetch review, DNS/redirect/private-IP checks, conservative availability |
| AgroOrder | [#11](https://github.com/kostasmigk-cpu/AgroOrder/pull/11) | Producer/customer isolation, order state machine, local-first and cloud reactivation gates |
| WashnoW | [#7](https://github.com/kostasmigk-cpu/WashnoW/pull/7) | OSM tile/source policy, location privacy and future LIVE-status authorization/freshness |

## Findings that need separate follow-up

### P0 — GreyhoundLab workflow publication

Current main-branch inspection found three research workflows with `contents: write` and a direct `git push origin HEAD:main` pattern:

- `.github/workflows/dog-alt-public-odds.yml`
- `.github/workflows/dog-public-odds-probe.yml`
- `.github/workflows/public-odds-shadow.yml`

This is a potential review-bypass path, not evidence of a confirmed exploit. The documentation PR [GreyhoundLab #6](https://github.com/kostasmigk-cpu/GreyhoundLab/pull/6) records the finding. A separate, unmerged draft remediation PR [GreyhoundLab #7](https://github.com/kostasmigk-cpu/GreyhoundLab/pull/7) now proposes `contents: read`, removal of direct commits/pushes to `main`, and 14-day Actions artifacts for generated evidence. Static read-back checks were performed on the proposed files; no workflow, build, CI job, or test was run. Branch protection/rulesets, token scope, workflow syntax and artifact contents still require review. The remediation is proposed only and is not active on `main`.

### P0 — Dunkman legacy Telegram token

The Dunkman README states that an old prototype ZIP contained a Telegram token and says it must be revoked/replaced before notifications are used. Treat revocation as **unverified and outstanding** until the owner checks it in Telegram/BotFather. No token was copied into this report, and no credential was changed.

### P1 — Swap release blockers

The existing library records unfinished server-side purchase verification and account-deletion hardening. The new draft PR adds test/release gates; it does not imply these blockers are resolved.

### P1 — Φυσιοκίνηση authorization

The existing library records incomplete end-user authentication/authorization and says production mutations should remain fail-closed until this is complete. Verify current code and deployed state before changing that status.

### Documentation drift

The SuperBet iPhone Scanner library previously noted a mismatch between README entrypoint wording and `wrangler.jsonc`. For runtime truth, inspect the current configuration, entrypoint and deployed version together; do not infer deployment state from docs alone.

## Remaining portfolio work

All accessible non-frozen repositories in this rollout are now either covered by an existing Knowledge Library or have a draft PR to create/refresh one. The next portfolio pass should review the draft PRs, then move from source/checklist documentation to code-backed verification: inspect the active implementation, run only explicitly approved safe tests, and record exact results rather than generating more generic documentation.

The [stake-super-bet-scanner](https://github.com/kostasmigk-cpu/stake-super-bet-scanner) repository is explicitly frozen and is excluded from all edits.

## Audit trail / limitations

- This rollout created documentation commits on separate branches and opened draft PRs only.
- No PR was merged, no workflow was run, and no deployment was performed.
- A branch named `docs/knowledge-library-bootstrap-2026-10-20` was inadvertently created on the frozen `stake-super-bet-scanner` repository during batch setup. No file was changed, no commit or PR was created there, and the available GitHub connection did not expose a branch-deletion operation. Do not use that branch; remove it through the repository UI when convenient.
- Source links and checklists are references for future implementation. Current code, local laptop state, deployed cloud settings and live provider behavior remain unverified unless explicitly stated above.

## Next sequence

1. Review the 23 project-level draft PRs plus one central tracking PR for scope and source accuracy; keep all unmerged until reviewed.
2. Review the existing GreyhoundLab remediation draft PR #7; verify workflow syntax, artifact contents/retention, branch rules and token permissions before any merge.
3. Verify the Dunkman Telegram token revocation outside GitHub without exposing the old/new token.
4. Continue the library refresh for the remaining projects and record concrete code/test evidence per repository.


## Progress log — 2026-10-25

### GreyhoundLab workflow hardening proposal

- Created draft PR [#7 — Harden public odds workflows](https://github.com/kostasmigk-cpu/GreyhoundLab/pull/7) on branch `security/restrict-workflow-write-2026-10-20`, targeting `main`.
- The proposed change covers the three workflows listed above: permissions reduced from `contents: write` to `contents: read`; direct git commit/pull/push publishing removed; generated status/snapshot files uploaded as GitHub Actions artifacts with 14-day retention; workflow-YAML self-trigger paths removed while script-change triggers, schedules and manual triggers are retained.
- Static read-back checks confirmed the three proposed files contain no `contents: write`, no `git push origin HEAD:main`, no workflow-YAML self-trigger in the push paths, and do contain `contents: read` plus artifact uploads.
- No workflow runs, builds, tests or laptop commands were executed by us. The PR remains draft/open and unmerged. GitHub's connected deployment integration posted a failed deployment status for the PR head; this was not initiated by our work, and we did not run a deployment. Because this repo's default branch protection was found disabled and rulesets were not fully verifiable through the available connection, branch governance remains an explicit outstanding item.
- This update records proposal/status only; it does not imply the fix is active on `main`.

### Working boundary

- Continue documentation and source review through GitHub only unless the user explicitly authorizes laptop commands/tests.
- Do not merge or deploy any PR without explicit approval.
- Keep `stake-super-bet-scanner` frozen and untouched.


### Swap UX handoff captured — 2026-10-25

- Updated the existing draft Knowledge Library branch for [Swap PR #27](https://github.com/kostasmigk-cpu/swap/pull/27) with a requirements note: slightly longer animation, a trial of petrol/teal in the requested section instead of purple, and efood as a high-level interaction reference.
- The note explicitly marks implementation/device verification as unknown. It also records that the user requested direct in-app changes rather than a standalone mock-up.
- This is documentation only. Per the user's latest instruction, laptop activity remains paused: no local commands, build, device test, APK generation, or Actions run was initiated. No PR was merged and no deployment was performed.
