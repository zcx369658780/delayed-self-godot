# Task 0024 — Establish owned Godot headless-test lifecycle management and close the core-mechanics foundation

- Status: `READY`
- Gate: `IMPLEMENTATION / OWNED TEST-PROCESS LIFECYCLE + PRESERVED CORE-MECHANICS CLOSEOUT`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Required GPT closure checkpoint: `dab500f605ffb70ca06624fc9de1a559290b6cc8`
- Durable lifecycle memory: `docs/project_memory/HEADLESS_GODOT_TEST_PROCESS_LIFECYCLE_FAILURE_AND_POLICY_CURRENT.md`
- Closed predecessors: Tasks `0023ZX`, `0023ZY`, `0023ZZ`
- Existing product baseline: exactly eight formal levels, unchanged
- Product target: twelve core levels plus two conditional stretch rooms
- Production Profile authority: none
- Catalog/formal-level/final-flag authority: none
- Gameplay/UI/asset/font/audio/localization/build authority: none

## 1. Objective

Replace the failed pre-test-only process-reconciliation pattern with one ownership-aware Godot headless test wrapper, then use that wrapper to finish and validate the preserved schema-v2/core-mechanics foundation.

The task has two inseparable outcomes:

1. every Godot test invocation owns and cleans up the exact process set it starts;
2. the preserved schema-v2, Simulation, canonical-state, restart/replay, BFS, UID and stale-regression work completes one final validation.

Tasks 0023ZX, 0023ZY and 0023ZZ remain closed and must not be resumed directly.

## 2. Binding process-lifecycle doctrine

### 2.1 External processes

A Godot process that was not started by the current wrapper is external. It may be closed only when bounded process facts independently prove all of:

- executable identity is Godot;
- command line names the exact Delayed Self repository root;
- command line names an authorized Task 0023ZX/0024 headless test or required formal regression;
- no editor, project-manager, interactive main-scene, export/build or other-project indicator exists.

Ambiguous, unrelated, editor, project-manager or possibly manual processes remain untouched and block isolated validation.

### 2.2 Task-owned processes

A test invocation owns its direct process when the wrapper records the exact PID, start timestamp, executable and complete argument vector at launch. A descendant is owned only when process ancestry is proven to originate from that direct PID and its executable/command facts remain consistent with the same test invocation.

The wrapper's `finally` cleanup of a still-running owned process is part of the original test invocation. It is not:

- a second process-reconciliation phase;
- a second test;
- a validation retry;
- product repair.

A one-attempt validation limit never disables its mandatory owned-process `finally` cleanup.

## 3. Startup and continuation preservation

Before fetch, edit, test or process action:

1. require root, branch, expected origin and no Git operation in progress;
2. inventory every staged, modified, deleted and untracked path;
3. require zero staged paths;
4. require every dirty path to be within the previously authorized 0023ZX/ZY/ZZ continuation scope, the narrow Task 0012 correction, or a reviewed `.uid` sidecar;
5. record path, tracked state, SHA-256, bytes and lines;
6. preserve the complete current post-0023ZZ local state byte-identically under:

```text
D:\Delayed_Self_Evidence\0024_owned_headless_lifecycle_and_core_mechanics\continuation_inputs\
```

7. verify every copy;
8. retain the earlier 77-file Task 0023ZY evidence set unchanged and compare current paths against it, classifying each as unchanged or authorized-evolved;
9. stop on an unrelated path or unexplained change;
10. fetch and fast-forward only after preservation; no broad reset, clean or unreviewed stash.

Remote CURRENT/memory/report/task changes may be reconciled by exact path without overwriting preserved implementation drafts.

## 4. Startup residual-process disposition

Inspect the complete pre-existing Godot process set once before tests.

The owner authorizes exact-PID closure only for a process that satisfies the external-process proof in Section 2.1 and is attributable to the stopped 0023ZZ formal regression. Do not close by process name, wildcard or unbounded result set.

If any process is ambiguous or unrelated, leave it untouched and stop. If every existing process is proven owned by the stopped test chain, close only those exact PIDs and require the pre-test Godot process set to become zero.

This startup disposition is separate from, and does not limit, the automatic `finally` cleanup of later processes created by the new wrapper.

## 5. Implement the owned headless-test wrapper

Create one reusable wrapper at:

```text
tests/tools/run_owned_godot_headless.ps1
```

Additional focused qualification artifacts may use:

```text
tests/tools/task_0024_owned_godot_lifecycle_*.ps1
tests/tools/task_0024_owned_godot_lifecycle_*.json
tests/tools/task_0024_owned_godot_lifecycle_*.gd
```

The wrapper must:

1. use `System.Diagnostics.ProcessStartInfo` with `FileName` and per-argument `ArgumentList`;
2. disable shell execution and redirect stdout/stderr explicitly;
3. record the direct PID, start time, executable and exact arguments;
4. discover descendants only by verified process ancestry rooted at the recorded direct PID;
5. never infer ownership from executable name alone;
6. wait for normal exit under a configurable bounded timeout;
7. allow a bounded post-exit grace period for descendants;
8. capture native exit code and bounded stdout/stderr;
9. always run cleanup in `finally` after pass, failure, timeout or caller interruption;
10. in `finally`, close only the direct owned PID and proven owned descendants that remain alive;
11. wait again and prove the owned set is empty;
12. preserve the original test result independently from cleanup result;
13. classify timeout, nonzero exit, stderr policy failure, marker failure and cleanup failure separately;
14. never rerun the test automatically;
15. emit no raw unrelated process command lines or local absolute paths into Git reports.

A test assertion failure followed by successful cleanup is a normal test nonpass. An owned-process leak that cleanup closes is a reported lifecycle observation, not authority for a retry. Failure to close the owned set is a harness failure.

## 6. Wrapper qualification

Before using the wrapper for the final matrix, prove in fresh invocations:

1. normal exit is captured and leaves zero owned processes;
2. deliberate nonzero test exit is preserved while `finally` still leaves zero owned processes;
3. a bounded timeout/still-running test is closed by exact owned PID and leaves zero owned processes;
4. no process-name-wide action exists in the wrapper;
5. an unrelated or unproven process can never enter the owned cleanup set;
6. direct and descendant ownership records are deterministic and bounded;
7. cleanup executes exactly once per invocation;
8. qualification tests themselves leave zero Godot processes.

Qualification may be rerun while repairing the wrapper because it is not the final core-mechanics validation. It must not access Profile/user data, formal level data beyond read-only required fixtures, main scene, export or build.

## 7. Retain and finish the authorized continuation work

After the wrapper qualifies and the environment is process-clean, continue the preserved work already reached by 0023ZZ:

- explicit backward-compatible schema v2;
- schema-v1 behavior unchanged;
- YOU-only crates;
- YOU-only consumable keys and locks;
- grouped barriers/bridges;
- typed sensors;
- one-shot room-local latches;
- one shared Simulation transition for replay and BFS;
- deterministic canonical state key;
- exact restart behavior;
- bounded non-catalog fixtures;
- reviewed Godot UID sidecar baseline;
- narrow Task 0012 eight-level catalog/progression/final correction.

Accepted intermediate owner/Codex evidence may be reused only after local files and focused tests are revalidated through the new owned wrapper.

### 7.1 UID baseline

Revalidate the reported 66 sidecars individually. Adopt only valid, unique, adjacent sidecars paired with eligible repository `.gd`/`.gdshader` sources. Remove only an individually proven invalid/orphan/duplicate sidecar after external preservation. No wildcard deletion and no blanket ignore rule.

### 7.2 Task 0012 correction

Only catalog/progression/final payload expectations may differ from historical Task 0012:

```text
1 tutorial_reach_exit
2 tutorial_echo_bridge
3 vertical_slice_delay_3
4 door_one_turn_late
5 two_keys_one_door
6 staggered_doors (non-final)
7 echo_spacing_bridge
8 two_echo_convergence (sole final)
```

All Level 6 solver, replay, necessity, door-window, meaningful-decision, Help, presentation and restart evidence remains frozen.

## 8. Exactly one final complete core-mechanics validation

When implementation and wrapper qualification are ready, run the complete Task 0023ZX validation matrix exactly once through the owned wrapper.

The matrix must prove:

1. every schema-v1 reference vector remains exact;
2. all eight formal levels retain validation, restart, solver, shortest-length/count status and replay facts;
3. formal catalog and all eight formal-level SHA-256 values remain unchanged;
4. all v2 mechanic, canonical-key, replay, solver and malformed-input tests pass;
5. the corrected Task 0012 regression passes;
6. every adopted UID has a valid unique eligible source pair;
7. only authorized repository paths changed;
8. the invocation's owned process set is empty after mandatory `finally` cleanup;
9. no unrelated process was touched;
10. Git and remote-drift audits pass.

If the matrix exposes a substantive rules, solver, replay, state-space, formal-level, UID-policy or protected-boundary failure, do not repair and rerun the complete matrix. Mandatory cleanup still runs; preserve the result and stop.

If the matrix passes but the wrapper had to close a leaked owned process, report the lifecycle leak and pass/fail the task according to the wrapper acceptance policy. Do not rerun the matrix merely to obtain a naturally exiting process.

## 9. Authorized repository paths

Core foundation paths:

```text
docs/game_design/GAMEPLAY_SIMULATION_CONTRACT_V2_CURRENT.md
docs/level_design/LEVEL_SCHEMA_V2_CURRENT.md
docs/level_design/reference/turn_transition_vectors_v2.json
schemas/level_v2.schema.json
scripts/simulation/level_loader.gd
scripts/simulation/simulation.gd
scripts/solver/bfs_solver.gd
tests/simulation/task_0023zx_core_mechanics_*.gd
tests/simulation/fixtures/task_0023zx_*.json
tests/levels/task_0012_staggered_doors_validation.gd
```

Lifecycle/UID paths:

```text
tests/tools/run_owned_godot_headless.ps1
tests/tools/task_0024_owned_godot_lifecycle_*.ps1
tests/tools/task_0024_owned_godot_lifecycle_*.json
tests/tools/task_0024_owned_godot_lifecycle_*.gd
docs/engineering/GODOT_UID_SIDECAR_BASELINE_CURRENT.md
```

Also authorized are only the exact individually reviewed valid `.uid` sidecars paired with eligible repository `.gd`/`.gdshader` sources.

Reports/current/memory:

```text
docs/project_memory.md
docs/project_memory/HEADLESS_GODOT_TEST_PROCESS_LIFECYCLE_FAILURE_AND_POLICY_CURRENT.md
docs/reports/0024_OWNED_GODOT_HEADLESS_TEST_LIFECYCLE_AND_CORE_MECHANICS_CLOSEOUT_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/production/EXPANDED_CONTENT_SUBMISSION_ROADMAP_CURRENT.md
```

Freeze without exception:

```text
data/catalog/**
data/levels/**
scenes/**
scripts/gameplay/**
scripts/app/**
project.godot
schemas/level_v1.schema.json
docs/level_design/reference/turn_transition_vectors_v1.json
tests/run_all.gd
assets/**
```

Do not access production Profile content/metadata/siblings, ordinary user data or the test-profile root.

## 10. Project-memory synchronization

Append a concise summary of the durable lifecycle policy and the closure of Tasks 0023ZX/ZY/ZZ to `docs/project_memory.md`. Do not remove or rewrite historical entries. The dedicated lifecycle memory document remains the detailed authority.

## 11. Repository output

On complete pass, commit authorized paths only with:

```text
feat: add owned Godot test lifecycle and complete core mechanics foundation
```

Push normally only after exact changed-path, frozen-hash, UID-pair, process-ownership, diff and remote-drift audits.

If blocked after the final matrix, do not rerun it. Preserve the local continuation and external evidence; write no misleading pass report.

## 12. Terminal verdict

Return exactly one:

```text
OWNED_GODOT_TEST_LIFECYCLE_AND_CORE_MECHANICS_FOUNDATION_READY_FOR_GPT_REVIEW
BLOCKED_OWNED_GODOT_TEST_LIFECYCLE_OR_CORE_MECHANICS_FOUNDATION
PROTECTED_DATA_BOUNDARY_BREACH
```

A pass establishes only the headless-test lifecycle harness, reviewed UID baseline, corrected historical regression and schema/Simulation/solver foundation. It does not authorize formal rooms 9–12, catalog/finale/Profile migration, Gameplay/UI, presentation, localization, asset/font/audio import, build/export, release, upload or submission.