# Codex multi-subagent and model routing

The main thread owns scope interpretation, protected-surface decisions, final file review, explicit staging, commit, push, and task verdict.

When a task explicitly permits and the work is bounded, configured roles may be used:

- `docs_reader`: read-only source extraction;
- `docs_writer`: Markdown drafting only;
- `code_reviewer`: staged documentation/config contradiction and omission review;
- `planner_high`: document/system decomposition only when genuinely needed.

Subagents receive exact inputs, allowed paths, forbidden surfaces, output format, and stop conditions. They must not commit, push, alter repository settings, use accounts/secrets, publish, or expand gameplay scope. Their results are advisory and must be verified by the main thread. Unavailable roles are recorded honestly; never fabricate a review result.
