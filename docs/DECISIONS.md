# Decisions — MikemigkDev

Last updated: 2026-09-24

- GitHub docs/issues/PRs are the handoff source between chats/agents.
- Low-risk read-only/repo-scoped inspection, lint, syntax and established tests/build checks may run without repeated approval when non-destructive.
- Destructive, privileged, security-sensitive, production, credential, deployment, broad deletion or outside-repo actions require explicit approval.
- Cleanup only verified-unused generated/duplicate/temp/cache/obsolete outputs; uncertain files are reported, not guessed away.
- Never place live secrets in docs.
