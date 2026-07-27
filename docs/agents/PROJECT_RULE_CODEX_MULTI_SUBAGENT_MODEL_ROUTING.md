# Codex multi-subagent and model routing

## Mandatory default after Task 0024BAA

`multi_subagent_mode = MANDATORY`; `single_agent_execution = NOT_AUTHORIZED_BY_DEFAULT`; `DeepSeek_tracked_code = DISABLED`; `main_agent_final_scope_and_Git = EXCLUSIVE`.

Documentation/planning requires `planner_high`, `docs_reader`, and `docs_writer_or_code_reviewer`. Code/level implementation requires `planner_high`, `code_mapper`, `impl_worker`, and independent `code_reviewer`. Validation/protected-boundary work requires at least four distinct planning, mapping, evidence, and independent-review roles plus the main agent. The main agent does not count as a subagent.

Only a future GPT-published task containing `single_agent_exception = EXPLICITLY_AUTHORIZED` and a specific `exception_reason` may waive the default. Subagents never stage, commit, push, consume retained manifests, access Profile/player data/accounts/secrets, publish/upload, or make protected-surface decisions. Read-only disjoint work may be concurrent; writers are serialized by path ownership and only one process may launch Godot.

The main thread owns scope interpretation, protected-surface decisions, final file review, explicit staging, commit, push, and task verdict.

Configured GPT roles are mandatory for nontrivial work:

- `docs_reader`: read-only source extraction;
- `docs_writer`: Markdown drafting only;
- `code_reviewer`: staged documentation/config contradiction and omission review;
- `planner_high`: document/system decomposition only when genuinely needed.
- `code_mapper`: read-only implementation and dependency mapping;
- `impl_worker`: bounded implementation under exclusive path ownership.

Subagents receive exact inputs, allowed paths, forbidden surfaces, output format, and stop conditions. They must not commit, push, alter repository settings, use accounts/secrets, publish, or expand gameplay scope. Their results are advisory and must be verified by the main thread. Unavailable roles are recorded honestly; never fabricate a review result.

## DeepSeek status after Task 0024BAC

- Current route contract: `DeepSeek_MCP = REMOVED`, native provider and automatic native subagent are `FORBIDDEN`, `MCP_fallback = FORBIDDEN`, and the sole formal path is `WRAPPER_BACKED_CLI_EXTERNAL_FILE_WORKER` for `GPT_FROZEN_LOW_RISK_BOUNDED_EASY_TO_VERIFY` file work.
- Task 0024BAC candidate status is `IDENTITY_BASELINE_READY_FOR_GPT_REVIEW`. The candidate worker tree uses `DS_WORKER_TREE_SHA256_V1`, aggregate SHA-256 `7949540c811e530ea777d655b5c1882b71b45ab31640702eae8f2180d335cbe8`, and CLI-entry SHA-256 `d0596c70dd102b98a3ed77a02c99195ccff23f6d126fb400ff3c47c25a232a36`. These are pending GPT acceptance, not accepted route authority.
- GPT-5.6 Sol/Terra exclusively owns planning/architecture, task JSON and allowed paths, output/diff review, tests/build/regression, Git, release/submission and verdict/acceptance.
- DeepSeek never counts as a mandatory GPT subagent. Neither DeepSeek nor the wrapper/worker was invoked or smoke-tested in 0024BAC; user-scope infrastructure was not modified.
- The User-scope wrapper remains accepted at SHA-256 `f604001d001cd206e742e5252a69995c29f96c983e6520ec6fd0374ae4908750`.
- Historical note: the former MCP route proved bounded direct editing before its removal.
- Task 0024AR scored DeepSeek code quality `23/100 / NOT_ACCEPTABLE`: the first pass ignored the frozen public API and implemented an unrelated codec; the single repair turn produced no change.
- The wrapper/CLI is **not authorized for tracked project code implementation**.
- Do not route GDScript, tests, production code, refactors, bug fixes, Simulation, solver, levels, Profile, build, release, or code review to DeepSeek.
- No automatic DeepSeek routing is permitted.
- The wrapper may be used only after GPT accepts the candidate baseline, a future task freezes the low-risk file contract, and both accepted identities are freshly verifiable.
- GPT-5.6 Sol/Terra retains planning, code implementation, review, tests, Git, and final acceptance.
