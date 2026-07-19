# Codex active task (CURRENT)

- Status: `PROFILE_FILESYSTEM_STORE_AFTER_INSTANCE_GATE_READY_FOR_GPT_REVIEW`
- Active task: `tasks/0023W_profile_filesystem_store_after_instance_gate.md`
- Last GPT-accepted gate: `TASK_0023V_PROFILE_STORE_INSTANCE_CONFIGURATION_GATE_ACCEPTED`
- Required checkpoint: `3d796d74884ef123cb9ea32f4a5101d7f1ee7340`
- Gate: `PROTECTED PLAYER DATA / CONFIGURED TEST-ONLY FILESYSTEM STORE`
- Formal scope: exactly eight levels
- Formal finale: sequence 8 `two_echo_convergence`
- Current plan: `docs/production/COMPLETE_FLOW_PRODUCTION_CLOSURE_PLAN_CURRENT.md`

Task 0023V is accepted. External callers preload `scripts/app/local_profile.gd`, construct a `RefCounted`, and call `configure_test` once. Tasks 0023R, 0023T and 0023V remain frozen prerequisites.

Task 0023W implementation is complete and awaiting GPT review. It appends bounded filesystem behavior only to a successfully configured instance and operates only in the fixed task-owned canonical fixture. All I/O methods reject before configuration with zero I/O; fixed-fixture recovery, transactional replacement/rollback and reset passed the standalone 68-assertion suite.

Production Profile content remains unopened and protected. Only its accepted non-content metadata may be compared. `create_production`, AppRoot, MemoryProgress, existing AppRoot tests, aggregate, menus, settings, localization, scenes, export, release, upload and festival submission remain closed.

Do not resume historical blocked tasks 0023, 0023S or 0023U. Sequence 9 remains `DEFERRED_CONCEPT_NOT_PRODUCT_SCOPE`; B007 and candidate A/B/C continuation remain historical and closed.

Expected terminal verdict:

```text
PROFILE_FILESYSTEM_STORE_AFTER_INSTANCE_GATE_READY_FOR_GPT_REVIEW
BLOCKED_PROFILE_FILESYSTEM_STORE_AFTER_INSTANCE_GATE
```
