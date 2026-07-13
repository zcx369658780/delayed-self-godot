# Delayed Self repository instructions

## Identity and ownership

- Repository: `zcx369658780/delayed-self-godot` (public); default branch: `main`; local root: `D:\Delayed_Self`.
- Working title: `迟到的我 / Delayed Self`; primary target: Windows; mode: offline single-player.
- GPT Project Sources advisor owns final project acceptance. Codex implements authorized tasks and may report `PASS_FOR_GPT_REVIEW`, but never `FINAL_ACCEPTED`. The user owns product choices, accounts, public submission, and irreversible actions.

## Canonical startup order

Read: this file → `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md` → `docs/CODEX_ACTIVE_TASK_CURRENT.md` when active/blocked → current `tasks/<task>.md` → `docs/DOC_INDEX_CURRENT.md` → development plan → handoff → project memory → version plans → detailed rules → canonical GDD.

Before writing, confirm absolute root, branch, `HEAD`, remote, and `git status --short --untracked-files=all`. Stop on remote mismatch, divergence, conflict, or unexpected tracked changes. A task may narrow these rules but cannot weaken them.

## Hard rules

- Never use `git add .`, `git add -A`, `git reset --hard`, repo-wide restore/checkout, rebase, amend, squash, force-push, or deletion of user work. Stage authorized paths explicitly; keep commits single-topic.
- Never expose or commit secrets, credentials, private keys, account data, machine-local paths beyond approved project facts, caches, builds, or raw evidence.
- Do not upgrade or install Godot, export templates, renderers, plugins, or dependencies without a separate task.
- Keep simulation deterministic and separate from presentation. Runtime and solver must share rules or one verifiable contract; UI/animation must not duplicate or determine puzzle logic.
- AI-generated puzzle, solution, uniqueness, difficulty, or solvability claims are not evidence until machine-validated against the runtime contract.
- Every external asset requires the license ledger before release use. Unknown or unfulfilled licenses are forbidden.
- Saves/player data, releases, uploads, public submission, repository settings/permissions, accounts, tags, builds, and final license decisions are protected surfaces requiring separate explicit authorization.

Detailed rules: `docs/project_rules/`; agent routing: `docs/agents/PROJECT_RULE_CODEX_MULTI_SUBAGENT_MODEL_ROUTING.md`; workflow: `docs/workflows/PROJECT_BOOTSTRAP_AND_TASK_WORKFLOW.md`.
