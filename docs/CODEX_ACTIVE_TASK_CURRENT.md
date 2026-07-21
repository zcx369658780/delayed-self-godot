# Codex active task (CURRENT)

- Status: `OWNED_GODOT_TEST_LIFECYCLE_AND_CORE_MECHANICS_CLOSEOUT_READY_FOR_CODEX`
- Active task: `tasks/0024_owned_godot_headless_test_lifecycle_and_core_mechanics_closeout_gate.md`
- Closed predecessors: all Tasks through `0023ZZ`; none may be resumed directly
- Latest GPT adjudication: `TASKS_0023ZX_0023ZY_0023ZZ_CLOSED_ON_TEST_PROCESS_LIFECYCLE_CONTRACT_DEFECT`
- Last GPT-accepted product gate: `TASK_0023ZW_GAMEPLAY_PRESENTATION_ROADMAP_REBASELINE_ACCEPTED_WITH_BINDING_SEQUENCE_POLICY`
- Required checkpoint: `dab500f605ffb70ca06624fc9de1a559290b6cc8`
- Task publication commit: `fc1cb6dd7957fe7cfe409ad299ec8a9b69fa7819`
- Durable lifecycle memory: `docs/project_memory/HEADLESS_GODOT_TEST_PROCESS_LIFECYCLE_FAILURE_AND_POLICY_CURRENT.md`
- Implemented product baseline: exactly eight formal levels
- Accepted product target: 12 core levels + 2 conditional stretch rooms
- Binding sequence policy: preserve sequences/IDs 1–8; append future 9–12
- Gate: `IMPLEMENTATION / OWNED HEADLESS TEST-PROCESS LIFECYCLE + PRESERVED CORE-MECHANICS CLOSEOUT`

All earlier task files are historical authorization records only. Accepted historical results remain frozen within their scopes, but no task before 0024 is active or resumable.

Tasks 0023ZX, 0023ZY and 0023ZZ are closed because their process contracts allowed only pre-test reconciliation while later tests could create new Godot processes, required zero final residue, and prohibited cleanup of those task-owned processes. This was a harness/authorization design defect, not an established schema-v2, Simulation, replay, solver or formal-level defect.

Task 0024 is the only active scope. It must preserve the current local continuation state, reconcile only independently proven startup residual processes, implement one ownership-aware Godot headless wrapper, and make exact owned-PID/descendant cleanup mandatory in `finally` for every invocation. Owned cleanup after a test is part of that invocation and is not a retry or second remediation phase.

After wrapper qualification, Task 0024 may finish the preserved schema-v2/Simulation/canonical-state/restart/replay/BFS, UID and narrow Task 0012 work. Exactly one complete final core-mechanics validation is authorized; its mandatory owned-process cleanup must still run after pass, failure or timeout, but the validation itself may not be rerun after a substantive failure.

Formal catalog and eight formal level JSON files, final flag, production Profile, Gameplay/UI, project settings, assets, fonts, audio, localization, build/export, release, upload and submission remain closed.

Expected terminal verdict:

```text
OWNED_GODOT_TEST_LIFECYCLE_AND_CORE_MECHANICS_FOUNDATION_READY_FOR_GPT_REVIEW
BLOCKED_OWNED_GODOT_TEST_LIFECYCLE_OR_CORE_MECHANICS_FOUNDATION
PROTECTED_DATA_BOUNDARY_BREACH
```