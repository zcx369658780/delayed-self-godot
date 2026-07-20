# Task 0023ZC GPT AppRoot Profile orchestration compile-gate acceptance

- Reviewed implementation commit: `771df57aa216ce3be06758772720e72f6a2d5157`
- Verdict: `TASK_0023ZC_APP_ROOT_PROFILE_ORCHESTRATION_COMPILE_GATE_ACCEPTED`
- Scope accepted: compile-level AppRoot test-profile orchestration architecture and unchanged normal memory-only behavior
- Configured Profile filesystem behavior, fixture execution, persistence, rollback, recovery, restart behavior, and product persistence: not accepted or authorized by this report

## Accepted implementation boundary

Task 0023ZC adds a bounded pre-tree `configure_test_profile` surface to `DelayedSelfAppRoot` and encodes the configured test-profile branch without executing a successfully configured AppRoot in the scene tree.

The accepted source boundary is:

```text
validated canonical test path
→ adapter configuration
→ defensive catalog facts
→ configured test store
→ one store load
→ accepted load-status filter
→ adapter hydration
→ adapter runtime authority
```

Completion source ordering is:

```text
prepare_completion
→ NO_CHANGE success without write/commit
or
→ persist_profile(candidate)
→ accept PERSISTED / NO_CHANGE
→ commit_profile(candidate) only after persistence success
→ only then claim recorded completion/navigation
```

The source preserves the existing active-Gameplay and record-once guards, non-final return behavior, final acknowledgment behavior, and bounded Safe Error routing on configured-session failure.

## Accepted public progress contract

The classified Task 0023ZA defect is corrected. `get_progress_snapshot()` returns exactly:

```text
completed_level_ids
best_turns
unlocked_level_ids
```

- memory-only mode returns a defensive `DelayedSelfMemoryProgress.snapshot()` result;
- configured test-profile mode selects and defensively copies only the Task 0023X adapter snapshot's nested `runtime` Dictionary;
- adapter wrapper fields, Profile/settings data, paths, sibling names, store/adapter references, and diagnostic payloads are not exposed through the public progress API.

A separate bounded test-session snapshot contains only mode/configured/boot/load/persist status identifiers and the public progress snapshot.

## Accepted zero-I/O evidence

```text
0023ZC parser smoke: attempt 1 pass + final fresh-process pass
0023ZC compile contract: 17 assertions, passed twice
0023R: 123 assertions / 4 positive / 39 negative
0023T: compile marker + 34 assertions
0023V: compile marker + 28 assertions
0023W: compile marker + 68 assertions
0023X: compile marker + 31 assertions
all final commands: exit 0, stderr empty, marker exactly once
```

The reviewed compile contract proves:

- production and invalid paths reject off-tree;
- a rejected first attempt permits a later valid canonical configuration;
- first successful configuration is immutable;
- configured off-tree AppRoot can be freed without boot/tree entry/store construction;
- failure-seam forwarding rejects before store construction;
- normal unconfigured AppRoot boots the existing Main Menu memory-only path;
- the public progress snapshot has exactly three defensive keys and initially unlocks only Tutorial 0;
- valid configuration after tree entry rejects;
- unconfigured direct-development routing remains unchanged.

Static architecture, explicit typing, path-leak, forbidden selector, source-ordering, and frozen-blob audits passed.

## Protected data boundary

Production Profile content was not opened or accessed. Its non-content metadata remained:

```text
exists = true
Length = 473
LastWriteTimeUtc = 2026-07-19T08:15:02.2089459Z
```

The pre-existing test-root existence fact remained unchanged and the root was not enumerated, inspected, created, cleaned, or modified by Task 0023ZC. Task 0023ZC has no fixture ID. No successfully configured AppRoot entered the tree, and no configured load/persist/reset/recovery behavior ran.

## Frozen authorities

Later work must preserve:

1. Tasks 0023R–0023W path, codec, external configuration, filesystem-store, recovery, rollback, reset, and cleanup contracts.
2. Task 0023X pure adapter and atomic MemoryProgress hydration behavior.
3. Task 0023ZC pre-tree configuration, configured-branch source ordering, persistence-before-commit ordering, bounded failure routing, exact public progress shape, and normal memory-only behavior.
4. Production Profile non-content metadata protection.
5. The eight-level catalog, formal hashes/metrics, Simulation, solver, schema, canonical state, Gameplay, final acknowledgment, Help, Timeline, Level Select, presentation, and owner-evidence boundaries.

## Next gate authorized separately

The next task may construct the **complete fixed-fixture behavior harness and evidence-capture runner without executing the fixed fixture**.

It may add a future-execution behavior script containing the complete persistence, reload, NO_CHANGE, failure-injection, rollback, recovery, snapshot, router, and cleanup matrix; a parser smoke; a static harness-completeness validator; a deterministic stage/evidence manifest; and a PowerShell capture runner qualified only against zero-I/O parser smoke.

The next gate must freeze `app_root.gd` and all accepted sources. It must not enter a configured AppRoot into the tree, create/check a task-owned fixture, or execute Profile load/persist/reset/recovery behavior. Actual fixture execution and the two consecutive full-matrix passes remain a later gate.

## Non-claims

This acceptance does not establish configured filesystem integration, actual AppRoot load/persist/reset/recovery, rollback, process-restart persistence, full behavior-harness correctness, two-pass fixture evidence, production Profile operation, default product persistence, menus/settings/localization, aggregate coverage, build/export, RC, release, upload, or festival submission readiness.

```text
TASK_0023ZC_APP_ROOT_PROFILE_ORCHESTRATION_COMPILE_GATE_ACCEPTED
```