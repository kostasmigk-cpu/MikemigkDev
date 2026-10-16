# Central Project Management Protocol

Status: Active working agreement
Last updated: 2026-10-16
Owner: kostasmigk-cpu

## Purpose
Use this repository as the central index and management protocol for the user's software projects. This file does not replace any project's own documentation or source of truth.

## Operating rules
1. Every instruction is scoped to the explicitly named project(s). If the user names one project, operate only on that project unless the user explicitly says "all projects".
2. Keep repositories, decisions, credentials, configuration, issues, tests, and release status separate. Never copy code or project-specific assumptions across repositories without checking compatibility and obtaining clear benefit.
3. Cross-project lessons may be reused only when applicable. Record the source, why it applies, and any adaptation needed; preserve each project's original architecture and requirements.
4. Before changing a project, inspect its README, relevant docs, recent commits/issues/PRs, current branch and existing implementation. Check current official documentation for version-sensitive technical decisions.
5. Work in small, reviewable changes. Prefer a dedicated branch and pull request for significant or risky changes; do not silently force-push, overwrite user work, or merge unverified changes.
6. Validate every change with relevant automated tests, static checks, build checks, or a clearly stated manual test plan. Never claim tests passed unless their results were actually observed.
7. Update the project's own knowledge log/docs and status after meaningful work, including: date, scope, changes, rationale, checks/results, remaining risks, next step, and commit/PR links.
8. Update this central index when project status or shared lessons change. Keep project-specific detail in the corresponding repository.
9. Do not write secrets, tokens, passwords, private keys, personal data, or confidential information into GitHub. Check intended diffs for sensitive data before committing.
10. Treat destructive changes, production deployments, paid services/purchases, public disclosures, permission changes, and irreversible external actions as requiring a separate explicit confirmation, even when broad autonomy has been requested.
11. Do not claim access to a local machine, files, app, terminal, or project conversation unless a connected tool actually provides that access. GitHub access alone does not guarantee local builds, emulator tests, deployments, or synchronization with the D: drive.
12. Keep user-facing updates brief: project, status, what was changed, checks, and any blocker.

## Central execution command convention
When the user says "Προχώρα στο [project]", continue that named project's recorded next step.
When the user says "Τρέξε σε όλα τα projects", inventory all accessible projects first, then handle them one by one in isolated scopes. Do not mix worktrees, branches, issue trackers, or artifacts.
When the project name is ambiguous, infer only if the context identifies it unambiguously; otherwise ask one short question.

## Source of truth
- Code and project-specific technical decisions: that project's GitHub repository.
- Cross-project management rules and index: this repository.
- This protocol does not promise that separate ChatGPT conversations automatically synchronize in real time. Before work, check the relevant repository; after work, record verified results in GitHub so other conversations can retrieve them.
- The local D: drive and GitHub are not automatically synchronized by this file. That requires a configured local Git/sync workflow and verification.

## Project inventory
The manager should refresh this inventory from GitHub when needed. Do not assume this is a complete list of every project or local-only repository.

| Repository | Default branch | Current notes |
|---|---|---|
| stake-super-bet-scanner | main | Scanner project |
| DiloseTo | main | Project-specific purpose to verify |
| asep-job-match1 | main | Project-specific purpose to verify |
| iCar-AndroidStudio | main | Android car project |
| MyTurn | main | Project-specific purpose to verify |
| gunsgr | main | Project-specific purpose to verify |
| DogMapGreece | main | Dog map project |
| buildcheck | main | Build/check repository |
| StayGuide_Marke- | main | Travel guide project |
| vek-boutique | main | Boutique / shop project |
| swap | main | Swap marketplace app |
| WhoIsGR | main | Project-specific purpose to verify |
| DiplaMou | main | Project-specific purpose to verify |
| StockCheckGR | main | Stock checking project |
| AgroOrder | main | Ordering project |
| Dunkman- | main | Project-specific purpose to verify |
| FindMeNow | main | Discovery/location project |
| WashnoW | main | Car wash project |
| Fysiokinisi | main | Physiotherapy scheduling project |
| SuperBet-iPhone-Scanner | main | iPhone scanner project |
| GreyhoundLab | main | Greyhound analysis project |
| bachelor-trip-dashboard | main | Trip dashboard |
| AutoCryptoBot | main | Crypto automation project |
| PreGame-scanner- | main | Pre-game scanner |
| MikemigkDev | main | Central management protocol |

## Project status log
- 2026-10-13: Created initial central operating protocol and inventory. No source code or project branches were modified by this protocol change.

- 2026-10-16: Refreshed the GitHub-visible inventory (24 project repositories plus the central manager) and recorded a read-only cross-project audit. Added linked management, CI findings, and security-triage snapshots. Observed CI evidence is scoped to the exact PR head/run; local builds, Play Console state, production deployments and revenue remain unverified. No project source code, local files, deployment, or PR merge was changed by the audit.
