# Codex multi-subagent and model routing

The main thread owns scope interpretation, protected-surface decisions, final file review, explicit staging, commit, push, and task verdict.

When a task explicitly permits and the work is bounded, configured GPT roles may be used:

- `docs_reader`: read-only source extraction;
- `docs_writer`: Markdown drafting only;
- `code_reviewer`: staged documentation/config contradiction and omission review;
- `planner_high`: document/system decomposition only when genuinely needed.

Subagents receive exact inputs, allowed paths, forbidden surfaces, output format, and stop conditions. They must not commit, push, alter repository settings, use accounts/secrets, publish, or expand gameplay scope. Their results are advisory and must be verified by the main thread. Unavailable roles are recorded honestly; never fabricate a review result.

## DeepSeek status after Task 0024AR

- The User-scope wrapper remains accepted at SHA-256 `f604001d001cd206e742e5252a69995c29f96c983e6520ec6fd0374ae4908750`.
- The configured DeepSeek MCP route proved bounded direct editing of one pre-existing regular file.
- Task 0024AR scored DeepSeek code quality `23/100 / NOT_ACCEPTABLE`: the first pass ignored the frozen public API and implemented an unrelated codec; the single repair turn produced no change.
- DeepSeek MCP and wrapper/CLI are therefore **not authorized for tracked project code implementation**.
- Do not route GDScript, tests, production code, refactors, bug fixes, Simulation, solver, levels, Profile, build, release, or code review to DeepSeek.
- No automatic DeepSeek routing is permitted.
- DeepSeek may be used only for disposable transport probes or a later separately authorized reevaluation after a material model/configuration change.
- GPT-5.6 Sol/Terra retains planning, code implementation, review, tests, Git, and final acceptance.
