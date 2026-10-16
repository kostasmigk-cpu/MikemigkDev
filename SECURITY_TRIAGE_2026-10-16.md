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


## Branch-existence verification — local-agent security issues

The branch search on 2026-10-16 returned no branch matching `security` in either `kostasmigk-cpu/swap` or `kostasmigk-cpu/asep-job-match1`. Their open security issues mention a hardening patch staged on `security/hardening-2026-09-24`, but that branch name is not currently present in the branch search results, and no matching security PR appeared in the open-PR inventory. Treat those fixes as **not available for review in GitHub at this time**, not as completed work. Do not assume the patches are present on main.

For DiloseTo, `security/hardening-2026-09-24` does exist and PR #23 is open/draft. It must still pass review and CI; the installer starts a persistent watchdog, so the install/start/stop behavior needs explicit review before it is run.


## Additional MyTurn review — PR #6 public queue rules and overlapping changes

MyTurn PR #6 is open and not draft, and PR #11 is a separate open/draft security patch. Both touch `MainActivity.java`/Firebase rules or related runtime behavior, so they must be reconciled before either is merged.

PR #6 proposes publicly readable `publicState` and `publicResults`, plus unauthenticated creation of `joinRequests` and `ticketActions`. The public ticket validation blocks a short list of known fields (such as name, phone, clientSecret and feedbackComment) but does not define a complete allowlist for every public ticket field. Before release, define an explicit public schema with only safe fields, test it with the Firebase Realtime Database emulator, and assess abuse/rate-limiting for unauthenticated writes. Do not infer deployed rules from the PR diff.


## Additional AgroOrder review — active rules path is unconfirmed

The security PR #10 changes `firestore.rules.next`. In the root paths checked on 2026-10-16, a root `firebase.json` and a file named `firestore.rules` were not found, while `firestore.rules.next` exists. This does not prove the file is unused, but it means the deployment/activation path must be established before calling the change effective. Verify the exact rules file used by the release workflow and add emulator tests for the customer-field allowlist before any deployment.


## Additional WhoIsGR PR #5 — caller-authenticity wording

The PR's new hardcoded supplemental entries construct a `CallerInfo` with `status = "Επίσημος εταιρικός αριθμός"` and `confidence = 100`. In a caller-identification product, this must not be presented as proof that an incoming call genuinely originated from that organization: caller ID can be spoofed. Preserve the distinction between “this number is listed by the organization as an official contact” and “this incoming call is authentic.” Add a clear UI disclaimer and source/date provenance, and verify each exact number against the linked current official source before marking it current.


## MyTurn — rules deployment path is unverified

A direct lookup of `firebase.json` at the current main branch returned NOT_FOUND. The repository contains both `FIREBASE/database.rules.json` and `firebase/database.rules.json` in the public-queue PR context, while the security PR #11 modifies only the lowercase path. Until the intended canonical file and actual deployment procedure are documented, do not assume either file is deployed to production. Add a safe, explicit rules validation/deployment workflow or document the controlled console/manual process, and keep a test that detects drift between canonical rules and any duplicate copy.


## Additional FindMeNow review — confirmed account enumeration and data minimization items

Current `backend/src/index.js` returns HTTP 409 with the explicit message `Email already registered` from `/api/auth/register`. This confirms the account-enumeration concern in issue #10. Prefer a response that does not disclose whether an email already has an account while preserving a safe account-recovery flow. The public professional listing/detail handlers also select `p.*`; review whether internal fields such as `user_id` should be excluded from public JSON responses. PR #13 only addresses CORS allowlisting and adds CORS tests, so these separate findings remain outside its current scope.


## Confirmed WashnoW main-branch finding — Android backup still enabled

Current `app/src/main/AndroidManifest.xml` on main declares `android:allowBackup="true"`. Open issue #4 says a patch was staged to change this, but branch search returned no security branch and no open PR was found. The current repository therefore does not show the proposed hardening. Before release, decide whether backup is required; if not, set it to false, or implement explicit Android data-extraction/backup rules that exclude owner/session tokens and private data. Add a manifest/static test so the setting cannot regress. No code change was made during this review.


## Positive controls observed — DiplaMou and StockCheckGR

- DiplaMou main manifest currently has `allowBackup=false`, cleartext traffic disabled, and explicit backup/data-extraction exclusions for shared preferences, databases, internal files and external files. Activities, the microphone foreground service, and receivers are non-exported except the launcher activity. This is positive evidence for those specific controls, but does not close issue #6's runtime permission, SOS action, notification-intent, or local-storage review.
- StockCheckGR main manifest has `allowBackup=false`, cleartext traffic disabled and a network security config. Its URL fetch code requires HTTPS, rejects user-info/localhost/local addresses, revalidates redirects, limits redirects and response size, and handles 403/429 without bypass. DNS validation and connection are separate operations, so review redirect/DNS-rebinding edge cases in tests; the current user-initiated single-URL design is otherwise aligned with the project's documented safety boundary.


## MyTurn PR #6 — setup defaults conflict with the user's explicit-approval safety rule

The draft `setup.ps1` defaults to installing missing software through winget, accepting/installing Android SDK packages, creating local `.env` and `local.properties`, replacing local Git hooks, running tests/build, and registering a recurring Task Scheduler job unless corresponding `-Skip...` switches are passed. This is a substantial local-machine side effect, not a read-only setup. Do not run it on the user's laptop. Before this PR is considered, make recurring automation and system/package installation separate, explicit opt-in steps, preserve existing hooks rather than replacing them silently, and document every local side effect in plain Greek. No local command or script was executed during this review.


## asep-job-match1 — current setup defaults to local automation

Current main `setup.ps1` installs Node dependencies, may accept/install Android SDK packages and sync local secrets, and by default installs local Git hooks plus Task Scheduler automation (unless `-SkipAutomation` or `-WebOnly` is passed). The README also says setup can start a background pull/test/build pipeline. Do not run this setup on the user's laptop under the current explicit-approval rule. A safer default is setup without persistent automation; require a separate, clearly explained opt-in command for Task Scheduler/hooks and any local-secret sync.


## Confirmed P0 — asep-job-match1 local agent remains un-hardened on main

Current main `laptop/agent/local_agent.py`:
- polls `runtime-control/local_agent_command.json` from `origin/main`;
- dispatches allowlisted actions without an independent local approval, expiry validation, or replay protection;
- writes status containing the command output/message tail to `runtime-data/local_agent_status.json`, then runs Git add/commit/push to `main`.

Current main `INSTALL_LOCAL_AGENT.bat`:
- clones the repository or fetches and runs `git reset --hard origin/main` on the existing dedicated clone;
- creates a watchdog loop;
- registers a Task Scheduler `ONLOGON` task and starts the watchdog immediately.

The open issue [asep-job-match1 #54](https://github.com/kostasmigk-cpu/asep-job-match1/issues/54) calls for local approval, expiry, one-time/replay protection, sanitized local-only status and no raw output upload. Branch search did not find `security/hardening-2026-09-24`, and no matching security PR appeared in the open-PR inventory. Therefore the documented hardening is not currently available for review through that branch/PR. Do not run the installer; do not merge or deploy anything until the security changes are restored to a reviewable branch and tests prove the local-approval and local-only logging requirements.


### Swap #13 status nuance
The open issue #13 describes a local agent, but current-main code searches for `local_agent_command` and `watchdog` returned no matches, and expected paths such as `laptop/agent/local_agent.py` and `INSTALL_LOCAL_AGENT.bat` were not found. Therefore the issue's described agent behavior is **not confirmed present on current main**; it may refer to removed/legacy files or a local-only copy. Keep the issue open until the local-only/runtime inventory is checked, but do not label it a confirmed current-main vulnerability based solely on the issue text.


## Confirmed P0 — iCar local agent on main lacks local approval/expiry

Current main `laptop/agent/local_agent.py` polls `runtime-control/local_agent_command.json`, accepts any action in its allowlist, and executes the action without expiry validation, one-time local approval, or replay protection. Its allowlist includes emulator start, APK install, app launch and smoke-test actions. It writes command output to `runtime-data/local_agent_status.json`. The current control file has a bootstrap `icar_status` command, which the agent can execute on startup. The installer pulls main and starts the agent.

PR #6 is the proposed hardening path, but its current head has no PR-triggered workflow run in the lookup. Do not run `INSTALL_LOCAL_AGENT.bat` or any remote-agent flow. Require review of approval/expiry/replay enforcement, sanitized local-only status, fixed safe allowlist and tests before any installation.


## Confirmed P0 — DiloseTo local agent on main still trusts remote control without local approval

Current main `laptop/agent/local_agent.py` fetches `origin/main` to read the command file, accepts commands if enabled/project/agent/action match, but expiry is optional and there is no independent local approval or replay-protection check. `push_status()` fetches and runs `git reset --hard origin/main`, then commits and pushes status/results to `main`; payloads can include build output, device/emulator details and exception text. PR #23 proposes hardening this, but remains draft and its current head has no PR-triggered workflow run in the lookup. Do not run `INSTALL_LOCAL_AGENT.bat`; require review and CI for the hardening branch before any local installation.


## Confirmed P0 — MyTurn Firebase owner-claim rule is client-gated, not server-gated

Current main `firebase/database.rules.json` permits any authenticated UID to write its own UID to `businesses/{businessId}/ownerUid` when that field does not yet exist. The web client checks `allowOwnerClaim` before calling the PUT, but this flag is client-side configuration and is not referenced by the database rules. Therefore, if an unclaimed business ID is known, a user can bypass the UI and attempt the same claim directly against the Firebase REST API. PR #11 narrows ownerUid reads but does not change this initial-claim write condition; PR #6's proposed rules retain it as well.

Required before any multi-business/production use: remove public self-claim from the client-writable rules and use an owner provisioning/invitation mechanism enforced by trusted server code or an independently verified claim secret. Add Firebase Realtime Database emulator tests proving an arbitrary authenticated user cannot claim an unassigned business, even when the client config says owner claim is disabled.


### DiloseTo PR #23 installer follow-up
The proposed installer still removes `%LOCALAPPDATA%\DiloseToAgent\STOP` if present and then starts a persistent watchdog immediately. That behavior should not silently override an existing stop marker. A safer installer should preserve STOP by default and require a separate explicit “install and start” action before removing it or registering Startup persistence.


### DiplaMou security branch comparison
The branch `security/integrated-guardian-hardening` exists, but GitHub compare reports it is **behind main by 13 commits and ahead by 0 commits** (no unique commits/files). It is not a usable hardening patch relative to current main. Issue #6 remains open; current manifest controls are positive, but the full runtime/notification/permission audit still needs a fresh branch based on current main and a validated CI run.


## Security branch freshness check — 2026-10-16

Compared six open hardening branches against their current `main`:
- MyTurn: ahead 3, behind 0.
- FindMeNow: ahead 8, behind 0.
- AgroOrder: ahead 2, behind 0.
- DogMapGreece: ahead 2, behind 0.
- iCar-AndroidStudio: diverged, ahead 9 and behind 2.
- DiloseTo: diverged, ahead 19 and behind 2.

iCar and DiloseTo hardening branches must be reconciled with current main before review/merge; do not force-push or reset local work to do so. The other four branches are based on current main according to the compare endpoint, but still have no passing PR-triggered workflow evidence from the lookups in this audit.


### Current control-file state nuance
- asep-job-match1's committed control file currently names the read-only `findnext_status` action, but the agent's allowlist includes build/emulator/install/launch/smoke-test actions and does not enforce local approval/expiry/replay.
- DiloseTo's committed main control currently has `enabled: false` and empty command fields, so no action is requested by that file as inspected. The design still lacks independent local approval/replay protection if the remote control is later enabled, and its installer starts persistence.
- iCar's committed control file currently requests `icar_status` at startup, but the same agent accepts other allowlisted build/emulator/install/launch actions without local approval.
These are code/design findings; no agent was started or command file changed.
