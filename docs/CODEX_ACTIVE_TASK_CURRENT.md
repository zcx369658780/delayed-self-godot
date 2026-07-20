# Codex active task (CURRENT)

- Status: `APP_ROOT_PROFILE_SESSION_ASSERTION_CARDINALITY_NORMALIZATION_READY_FOR_GPT_REVIEW`
- Active task: `tasks/0023ZM_assertion_case_cardinality_normalization_gate.md`
- Last GPT-accepted gate: `TASK_0023ZL_APP_ROOT_PROFILE_SESSION_CLEANUP_AND_CAPTURE_REPAIR_ACCEPTED`
- Latest adjudication: `TASK_0023ZJ_BEHAVIOR_PASS_CANDIDATE_BLOCKED_BY_DUPLICATE_CASE_ID_CARDINALITY_MISMATCH`
- Required checkpoint: `31cc1f58a106abc61f618d199aac8b69bee6dde7`
- Accepted harness checkpoint to revise: `413727fc804355c00f0900d98e668e8e69b4876b`
- Gate: `PROTECTED PLAYER DATA / CASE-ASSERTION CARDINALITY NORMALIZATION + ZERO-FIXTURE REQUALIFICATION`
- Formal scope: exactly eight levels
- Formal finale: sequence 8 `two_echo_convergence`
- Current plan: `docs/production/COMPLETE_FLOW_PRODUCTION_CLOSURE_PLAN_CURRENT.md`

Tasks 0023R, 0023T, 0023V, 0023W, 0023X, 0023ZC, 0023ZD, 0023ZF, 0023ZG and 0023ZL are GPT-accepted and frozen within their stated scopes. AppRoot, MemoryProgress, store, adapter, Gameplay, product data, accepted prerequisite tests and diagnostics remain frozen.

Task 0023ZJ Attempt 1 passed all 18 ordered stages, emitted no assertion failure or abort, retained 17/17 evidence, completed exact cleanup, preserved protected/frozen state, and was classified `PASS_CANDIDATE`. It stopped only because the task expected 41 runtime assertions while the behavior emitted 42.

GPT review identified a deterministic metadata defect: `single_active_screen_router` is used by both the fresh-reload single-screen assertion and the full router-contract assertion. The manifest therefore has 41 unique case IDs while the behavior executes 42 assertions. No product or configured-session behavior defect is established.

Task 0023ZM gives the fresh-reload single-screen assertion the unique case ID `fresh_reload_single_active_screen`, retains `single_active_screen_router` only for the full router contract, and normalizes the manifest to schema 2 with 42 unique cases and `expected_assertion_count = 42`. The behavior has a typed non-counting count-consistency guard, and the validator proves 38 direct plus four delegated one-to-one case mappings.

All five canonical harness artifacts now target inert future Task 0023ZN. Draft/final parser passes, the validator passes 328 assertions, no-guard exits 2 before behavior start, two 11/11 zero-I/O Qualifications pass, and pre/post frozen regressions match. Runner Execute, 0023ZN guard-passing commands, future-fixture commands and full behavior executions remain zero. See `docs/reports/0023ZM_ASSERTION_CASE_CARDINALITY_NORMALIZATION_REPORT.md`.

Normal unconfigured AppRoot remains memory-only. Production Profile content/default persistence, actual full-matrix execution, aggregate, menus, settings, localization, scenes, export, release, upload and festival submission remain closed.

Do not resume Tasks 0023Y, 0023Z, 0023ZA, 0023ZB, 0023ZE, 0023ZF, 0023ZH, 0023ZI, 0023ZK, 0023ZL or 0023ZJ, or reuse their fixtures. Historical blocked tasks 0023, 0023S and 0023U remain closed. Sequence 9 remains `DEFERRED_CONCEPT_NOT_PRODUCT_SCOPE`.

Expected terminal verdict:

```text
APP_ROOT_PROFILE_SESSION_ASSERTION_CARDINALITY_NORMALIZATION_READY_FOR_GPT_REVIEW
BLOCKED_APP_ROOT_PROFILE_SESSION_ASSERTION_CARDINALITY_NORMALIZATION
```
