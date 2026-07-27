# Project bootstrap and task workflow

## 1. Establish safe local truth

Confirm the expected root and repository identity. Clone only into an empty intended root. Record branch, HEAD, remotes, status, and recent history. A clean checkout may only fast-forward from the expected remote; otherwise stop.

## 2. Resolve authority

Read `AGENTS.md`, startup snapshot, active-task pointer, full task file, document index, and task-required sources. Summarize objective, scope, non-goals, allowed files, protected surfaces, validation, and commit/push policy before writes.

## 3. Route mandatory subagents

For every nontrivial task, `multi_subagent_mode = MANDATORY`, `single_agent_execution = NOT_AUTHORIZED_BY_DEFAULT`, and `DeepSeek_tracked_code = DISABLED`. Apply the minimum role set in the current routing rule, record a routing ledger, parallelize only disjoint read-only work, serialize writers by path ownership, and keep review independent. Only the main agent may integrate, run Godot/solver or consume a manifest when explicitly authorized, stage, commit, push, and issue the verdict. A single-agent exception is valid only when the active GPT-published task explicitly authorizes it and states a bounded reason.

DeepSeek MCP/native/automatic routing and MCP fallback are forbidden. An active task may optionally authorize only the wrapper-backed external file worker for `GPT_FROZEN_LOW_RISK_BOUNDED_EASY_TO_VERIFY` work. Task 0024BAC establishes `IDENTITY_BASELINE_READY_FOR_GPT_REVIEW`, not final route acceptance. After GPT acceptance, the main agent must still author a secret-free external task JSON, freeze allowed paths and verification, freshly match both accepted identities, review the complete diff and retain all planning/test/Git/release/verdict authority. Missing identity, drift or route failure stops delegation without fallback.

## 4. Execute narrowly

Change only authorized paths. Preserve user work and source documents. Keep dynamic status in current docs, durable decisions in project memory, detailed evidence in reports, and hard rules in `AGENTS.md` plus split rule documents.

## 5. Validate and review

Run task-specific checks plus `git diff --check`, review diff/stat/name lists, resolve canonical links, verify frozen facts and pending labels, scan for overclaims/secrets, and confirm protected surfaces remain untouched.

## 6. Close safely

Set the active-task state to the task-defined terminal status. Stage every authorized path explicitly; inspect cached diff/check/stat/name list. Commit only if authorized. Fetch and compare remote immediately before an authorized normal push; stop on drift. Report hashes, files, commands/results, status, untouched surfaces, uncertainty, and next gate.
