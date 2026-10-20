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

## Findings that need separate follow-up

### P0 — GreyhoundLab workflow publication

Current main-branch inspection found three research workflows with `contents: write` and a direct `git push origin HEAD:main` pattern:

- `.github/workflows/dog-alt-public-odds.yml`
- `.github/workflows/dog-public-odds-probe.yml`
- `.github/workflows/public-odds-shadow.yml`

This is a potential review-bypass path, not evidence of a confirmed exploit. Verify branch protection/rulesets, token scope, trigger trust, third-party action pinning and the exact staged file set. The documentation PR records the finding; it does not remediate the workflows.

### P0 — Dunkman legacy Telegram token

The Dunkman README states that an old prototype ZIP contained a Telegram token and says it must be revoked/replaced before notifications are used. Treat revocation as **unverified and outstanding** until the owner checks it in Telegram/BotFather. No token was copied into this report, and no credential was changed.

### P1 — Swap release blockers

The existing library records unfinished server-side purchase verification and account-deletion hardening. The new draft PR adds test/release gates; it does not imply these blockers are resolved.

### P1 — Φυσιοκίνηση authorization

The existing library records incomplete end-user authentication/authorization and says production mutations should remain fail-closed until this is complete. Verify current code and deployed state before changing that status.

### Documentation drift

The SuperBet iPhone Scanner library previously noted a mismatch between README entrypoint wording and `wrangler.jsonc`. For runtime truth, inspect the current configuration, entrypoint and deployed version together; do not infer deployment state from docs alone.

## Remaining portfolio work

Repositories with existing libraries still needing a current, code-backed refresh include:

- [StayGuide](https://github.com/kostasmigk-cpu/StayGuide_Marke-)
- [DiplaMou](https://github.com/kostasmigk-cpu/DiplaMou)
- [StockCheckGR](https://github.com/kostasmigk-cpu/StockCheckGR)
- [AgroOrder](https://github.com/kostasmigk-cpu/AgroOrder)
- [WashnoW](https://github.com/kostasmigk-cpu/WashnoW)

The [stake-super-bet-scanner](https://github.com/kostasmigk-cpu/stake-super-bet-scanner) repository is explicitly frozen and is excluded from all edits. Projects without an existing library and not yet covered by a draft PR also remain to be triaged individually.

## Audit trail / limitations

- This rollout created documentation commits on separate branches and opened draft PRs only.
- No PR was merged, no workflow was run, and no deployment was performed.
- A branch named `docs/knowledge-library-bootstrap-2026-10-20` was inadvertently created on the frozen `stake-super-bet-scanner` repository during batch setup. No file was changed, no commit or PR was created there, and the available GitHub connection did not expose a branch-deletion operation. Do not use that branch; remove it through the repository UI when convenient.
- Source links and checklists are references for future implementation. Current code, local laptop state, deployed cloud settings and live provider behavior remain unverified unless explicitly stated above.

## Next sequence

1. Review the 18 draft PRs for scope and source accuracy; keep all unmerged until reviewed.
2. Separately prepare a security patch for the GreyhoundLab publishing path, after checking actual branch rules and token permissions.
3. Verify the Dunkman Telegram token revocation outside GitHub without exposing the old/new token.
4. Continue the library refresh for the remaining projects and record concrete code/test evidence per repository.
