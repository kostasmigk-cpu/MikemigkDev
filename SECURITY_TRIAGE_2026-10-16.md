# Security Triage — 2026-10-16

Read-only GitHub issue inventory. This is a prioritized review queue, not a claim that every finding is still exploitable or that every proposed patch is missing from the current main branch. Before changing code, compare the open issue with the current branch, relevant PR diff, tests and deployment state.

## Open security issues found

| Priority | Project / issue | Main review areas | Current linked work |
|---|---|---|---|
| P0 | [StayGuide #21](https://github.com/kostasmigk-cpu/StayGuide_Marke-/issues/21) | Firebase/Storage rules, Functions secrets, deploy permissions, auth/CORS, rate limits, Android manifest/backup, logs/artifacts | Billing PR #20 is draft and CI failed; see CI findings |
| P0 | [Fysiokinisi #2](https://github.com/kostasmigk-cpu/Fysiokinisi/issues/2) | Real auth/roles, booking ownership, rate limits/CORS, sensitive health data, audit trail | No open PR found in the sampled search |
| P0 | [FindMeNow #10](https://github.com/kostasmigk-cpu/FindMeNow/issues/10) | CORS, password KDF, rate limits, session expiry/revocation, IDOR/role escalation, booking authorization | Draft PR #13; no PR-triggered run returned for current head |
| P0 | [AgroOrder #8](https://github.com/kostasmigk-cpu/AgroOrder/issues/8) | Firestore ownership, producer/customer authorization, WebView, XSS, cache privacy, secrets | Draft PR #10; no PR-triggered run returned |
| P0 | [MyTurn #9](https://github.com/kostasmigk-cpu/MyTurn/issues/9) | Firebase rules, exported components, deep links, cleartext/backup, secrets, local storage/logs | Draft PR #11; no PR-triggered run returned |
| P0 | [SuperBet-iPhone-Scanner #13](https://github.com/kostasmigk-cpu/SuperBet-iPhone-Scanner/issues/13) | Manual scan endpoint authentication, fixed agent allowlist, trusted update behavior, secret configuration | Several feature/probe PRs are open; keep probe PR #27 unmerged until re-reviewed |
| P0 | [swap #13](https://github.com/kostasmigk-cpu/swap/issues/13) | Local-agent approval/expiry/replay, no silent self-update, prevent raw UI/chat/token data publishing, Firebase restrictions | No security PR surfaced in the sampled open-PR list; guided tour PR #18 is separate |
| P0 | [DiloseTo #20](https://github.com/kostasmigk-cpu/DiloseTo/issues/20) | Local-agent approval/expiry/replay, local-only sanitized status, no silent replacement, allowlist | Draft PR #23; no PR-triggered run returned |
| P0 | [asep-job-match1 #54](https://github.com/kostasmigk-cpu/asep-job-match1/issues/54) | Local-agent approval/expiry/replay, local sanitized status, no raw stdout/stderr/logcat upload, allowlist | No matching security PR surfaced in the sampled open-PR list |
| P0 | [iCar-AndroidStudio #3](https://github.com/kostasmigk-cpu/iCar-AndroidStudio/issues/3) | Local-agent one-time approval/replay, fixed allowlist, sanitized status, prevent unsafe device targeting | Draft PR #6; PR body indicates tests/build still need validation |
| P1 | [DogMapGreece #16](https://github.com/kostasmigk-cpu/DogMapGreece/issues/16) | Firebase/API restrictions, Firestore/Storage rules, secret sync, exported components, CI logs/artifacts | PR #18 passed Android CI for narrowed artifact paths; broader audit remains open |
| P1 | [WashnoW #4](https://github.com/kostasmigk-cpu/WashnoW/issues/4) | Android backup, owner token handling, rate limiting, CORS, endpoint abuse | No open PR surfaced in sampled results |
| P1 | [WhoIsGR #6](https://github.com/kostasmigk-cpu/WhoIsGR/issues/6) | Firebase client key restrictions, Firestore rules, report abuse/rate limits, bundled phone data, manifest/logging | PR #5 adds rules and caller entries; no PR-triggered run returned; issue still open |
| P1 | [vek-boutique #2](https://github.com/kostasmigk-cpu/vek-boutique/issues/2) | WordPress nonce/CSRF, capabilities, sanitization/escaping, SQL safety, redirects, payment secrets | Open PR #1 is native iOS foundation, separate from theme security |
| P1 | [StockCheckGR #10](https://github.com/kostasmigk-cpu/StockCheckGR/issues/10) | URL allowlist/SSRF, HTTPS-only, user-shared URL boundaries, no CAPTCHA/anti-bot bypass, data minimization | Dependabot PR #1 only changes artifact action; a historical CI run failed at Kotlin compile |
| P1 | [DiplaMou #6](https://github.com/kostasmigk-cpu/DiplaMou/issues/6) | SOS/call permission disclosure, location privacy, local speech processing, emergency UX, logs | No security PR surfaced in sampled results |
| P1 | [gunsgr #13](https://github.com/kostasmigk-cpu/gunsgr/issues/13) | Local agent trust, data isolation, sensitive service context, local-only status and allowlist | No matching security PR surfaced in sampled open-PR list |
| P1 | [Dunkman- #2](https://github.com/kostasmigk-cpu/Dunkman-/issues/2) | Read-only bookmaker access, credentials/profile isolation, no bet/cashout automation, rate limits and logs | No matching security PR surfaced in sampled open-PR list |
| P1 | [buildcheck #6](https://github.com/kostasmigk-cpu/buildcheck/issues/6) | Privacy, secrets, server-side authorization, limits on user-submitted property data and safe demo labeling | Separate issue #2 describes a project-manager workflow; inspect before enabling any automation |
| P1 | [stake-super-bet-scanner #7](https://github.com/kostasmigk-cpu/stake-super-bet-scanner/issues/7) | Frozen baseline protection, credentials/log hygiene, no experimental modifications to production scanner | Keep repository frozen; do not merge unrelated experiments |

## Immediate management rules

1. Do not merge or deploy security PRs until the actual diff, required CI, project tests, and affected runtime path are reviewed.
2. A passing narrow CI run does not close a broader security issue.
3. For local agents, do not install or run a watchdog, startup task, remote command, build, emulator, or device action from a PR during this read-only review.
4. For Firebase projects, repository rules are not proof that production rules have been deployed.
5. For betting/crypto research, keep projects read-only, paper/simulation-only as specified; no bet submission or live financial action.
6. Keep all repositories isolated and preserve project-specific approval rules.

## Inventory boundary

The GitHub account currently exposes 24 project repositories plus the central manager repository. The inventory is based on GitHub-visible metadata and docs; local worktree state, production deployments, Play Console status and live customer/revenue status remain unverified.


## Additional code-review finding — WhoIsGR PR #5

**Blocker identified:** the proposed `firestore.rules` contains `allow list: if request.query.limit != null && request.query.limit <= 20;` for `/reports/{reportId}`, without requiring authentication or restricting the listed records to their owner. The report schema includes phone, company, note, status, timestamp and UID. This appears to permit unauthenticated queries for report records capped at 20 per query.

**Required fix before merge:** make report reads authenticated and purpose-limited, and preferably expose only an explicitly public/moderated projection rather than raw user submissions. Add Firestore Rules Emulator tests proving unauthenticated list denial and that one user cannot read another user's private report data. Do not rely on the client UI to enforce access. The PR currently has no PR-triggered workflow run in the lookup performed on 2026-10-16; no merge/deployment is approved by this review.
