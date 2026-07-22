# Task 0024T — Manifest-lock and execute one complete core-mechanics final validation

- Status: `READY`
- Gate: `VALIDATION ONLY / STATIC MANIFEST SEAL / ONE FINAL DRIVER EXECUTION`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Required GPT acceptance checkpoint: `5495e41aa97a12b239cf86dba48db0cf25b326f6`
- Accepted wrapper implementation: `7c0712d6a602dc23200ccb147d0096acc6333305`
- Provisional foundation implementation: `fdaf2b81fc71c60e4b3548422be94953146f25f4`
- Closed predecessors: Tasks `0024`, `0024R`, `0024S`
- Recommended Codex model: `GPT-5.6 Sol Max`; `GPT-5.6 Sol High` is acceptable if Max would disrupt continuity

## 1. Objective

Construct a complete, statically auditable validation manifest for the provisional schema-v2/Simulation/solver foundation, seal that manifest before any final execution, and then execute the final validation driver exactly once.

This task is validation-only. It may add Task 0024T validation artifacts and reports, but it must not modify the provisional implementation, formal product data or the accepted owned-process wrapper.

The historical `tests/simulation/task_0023zx_core_mechanics_complete_matrix.gd` and marker `TASK_0023ZX_COMPLETE_MATRIX_PASS` are incomplete historical evidence. Do not execute that script and do not emit that marker as new evidence.

## 2. Binding accepted prerequisites

Retain these accepted facts:

- Task 0024S qualified `tests/tools/run_owned_godot_headless.ps1` for exact owned-process lifecycle management;
- Windows path identity uses parsed argv and exact canonical equality;
- cleanup executes exactly once, owned descendants clean deepest-first, unproven descendants are never closed, and every accepted qualification case ended process-clean;
- Task 0024S did not run a core-mechanics matrix;
- the foundation implementation at `fdaf2b8` remains provisional until this task passes.

## 3. Startup gate

Before editing or execution:

1. require root `D:\Delayed_Self`, branch `main`, expected origin and no Git operation in progress;
2. fetch and fast-forward only;
3. require `HEAD == origin/main`, ancestry of `5495e41aa97a12b239cf86dba48db0cf25b326f6`, and zero remote divergence;
4. require a clean worktree and zero staged paths;
5. require zero pre-existing Godot processes; do not close an external process in this task;
6. record SHA-256 for the accepted wrapper, provisional implementation files, schema-v1 reference vectors, catalog and all eight formal-level JSON files;
7. require the accepted wrapper blob SHA to remain `5f14eb0feff903b40311c1c7283b20e2eabbffc2`;
8. stop on any unrelated dirty path, process ambiguity, protected-data access or frozen-path drift.

No production Profile, ordinary user data or test-profile root access is authorized.

## 4. Preparation phase — repairable until manifest seal

Preparation may be repaired and repeated because it performs no final Godot validation session.

Create only:

```text
tests/tools/task_0024t_core_mechanics_final_validation_manifest.json
tests/tools/task_0024t_core_mechanics_final_validation_static_validator.ps1
tests/tools/task_0024t_core_mechanics_final_validation.ps1
tests/simulation/task_0024t_v2_solver_replay_canonical_malformed.gd
```

Optional additional Task 0024T-only helper artifacts may use:

```text
tests/tools/task_0024t_*.json
tests/tools/task_0024t_*.ps1
tests/simulation/task_0024t_*.gd
```

Do not run any Godot script during preparation. PowerShell/static inspection of repository text and hashes is allowed.

### 4.1 Fixed final session cases

The manifest must define exactly four ordered wrapper cases, each executed once by the final driver:

1. `aggregate_v1_formal_regression`
   - script: `res://tests/run_all.gd`
   - required marker: `TASK_0003_TESTS_PASS`
   - proves schema-v1 vectors, all eight formal levels, accepted solver/replay facts, catalog/progression and existing aggregate regressions;
   - wrapper stderr policy may be `Allow` only if the driver separately enforces a bounded exact allowlist of previously accepted aggregate diagnostic lines; all other stderr is failure.

2. `task_0012_standalone_regression`
   - script: `res://tests/levels/task_0012_staggered_doors_validation.gd`
   - required marker: `TASK_0012_FOCUSED_PASS`
   - stderr policy: `ForbidNonempty`;
   - proves the narrow eight-level catalog/progression/final correction and retains all Level 6 solver/replay/runtime evidence.

3. `v2_focused_foundation`
   - script: `res://tests/simulation/task_0023zx_core_mechanics_foundation.gd`
   - required marker: `TASK_0023ZX_PASS`
   - stderr policy: `ForbidNonempty`;
   - proves existing focused crate, key/lock, sensor/barrier, latch, canonical and malformed behavior.

4. `v2_complete_solver_replay_canonical_malformed`
   - script: `res://tests/simulation/task_0024t_v2_solver_replay_canonical_malformed.gd`
   - required marker: `TASK_0024T_V2_COMPLETE_PASS`
   - stderr policy: `ForbidNonempty`.

No case may reference or invoke the historical incomplete complete-matrix script.

### 4.2 Required new v2 coverage

The new Task 0024T GDScript must fail closed and emit one pass marker only after proving all of the following:

- all five v2 fixtures load through the public loader;
- restart exactly reconstructs initial state for every fixture;
- BFS solves every fixture within bounded per-fixture limits;
- each BFS witness replays through the shared Simulation to player completion;
- replay transition count equals the reported shortest turn count;
- replaying the same witness twice yields identical final state and canonical key;
- canonical key is invariant to ordering of ID-bearing arrays after semantic normalization;
- canonical key distinguishes changes in crates, remaining keys, held keys, removed locks, barrier states, latch states, player, echoes, doors, history and completion;
- `turn_index` remains excluded from canonical deduplication if that is the accepted contract;
- YOU-only crate push and ECHO crate blocking are demonstrated;
- YOU-only key collection and same-turn matching lock consumption are demonstrated;
- typed `ANY_ACTOR`, `YOU_ONLY`, `ECHO_ONLY` sensor eligibility and explicit crate eligibility are demonstrated;
- grouped barrier next-turn semantics and occupied-cell deferred closure are demonstrated;
- one-shot latch activation persists through subsequent transitions and restart resets to the immutable initial state;
- malformed schema-v2 inputs fail atomically for at least: unknown top-level/entity field, missing required v2 array, duplicate IDs, unknown sensor/latch reference, invalid activator, invalid key type, static-cell overlap, out-of-bounds overlay and inconsistent initial barrier state;
- schema-v1 loading remains strict and does not accept v2-only fields as schema v1.

The test may construct bounded in-memory variants from the five committed non-catalog fixtures. It must not modify any fixture or product file.

### 4.3 Static validator and manifest seal

Before final execution, the static validator must prove:

- the manifest contains exactly the four ordered cases above;
- every script exists and every required marker appears exactly once in its declared script;
- no declared script or driver contains `TASK_0023ZX_COMPLETE_MATRIX_PASS` or references the historical incomplete matrix path;
- the new v2 script contains a unique machine-readable case ID for every required coverage item in Section 4.2;
- the final driver invokes only the accepted wrapper and only the four manifest cases;
- no automatic retry, loop over attempts or fallback execution path exists;
- final-driver output and process facts are bounded;
- only authorized paths are dirty;
- catalog, eight level JSON files, schema-v1 vectors, wrapper and provisional implementation hashes match startup values.

After all static checks pass, write a pre-execution seal under:

```text
D:\Delayed_Self_Evidence\0024T_complete_core_mechanics_final_validation\pre_execution_seal.json
```

The seal must contain SHA-256 for the manifest, static validator, driver and every Task 0024T GDScript plus the frozen hashes. Verify the seal immediately.

After the seal exists, do not edit any sealed artifact. Any mismatch blocks the task before final execution and does not authorize resealing over the existing file.

## 5. Exactly one final driver execution

The final session is one invocation of:

```text
tests/tools/task_0024t_core_mechanics_final_validation.ps1
```

The driver must independently require:

- exact CURRENT task/status for Task 0024T;
- the accepted wrapper hash;
- the exact pre-execution seal and all sealed hashes;
- zero Godot processes at session start;
- absence of a prior Task 0024T attempt record.

Before launching the first case, create an immutable attempt record in the Task 0024T external evidence directory. The driver may not execute if an attempt record already exists.

The driver executes the four manifest cases in order, each exactly once, through the accepted wrapper. It must collect each wrapper JSON result even after a case nonpass so the one session produces complete diagnostics, but it must never rerun a case.

Each case must prove:

- expected top-level classification `PASS`;
- native exit 0;
- required marker present;
- stderr policy/allowlist satisfied;
- cleanup invocation count exactly one;
- zero remaining owned processes;
- zero Godot processes before the next case.

After the fourth case, the driver must write a bounded final summary and record:

- case order and classifications;
- markers, native exits and stderr facts;
- cleanup counts and zero-process facts;
- pre/post frozen hashes;
- changed-path audit;
- whether any unrelated process was touched;
- one terminal classification.

The driver itself may be invoked only once. A substantive test, harness, process, hash, path or protected-boundary failure stops the task with no final-session rerun.

Mandatory owned-process cleanup remains part of each wrapper invocation and is not a retry.

## 6. Frozen implementation and protected surfaces

Do not modify:

```text
docs/game_design/GAMEPLAY_SIMULATION_CONTRACT_V2_CURRENT.md
docs/level_design/LEVEL_SCHEMA_V2_CURRENT.md
docs/level_design/reference/turn_transition_vectors_v1.json
docs/level_design/reference/turn_transition_vectors_v2.json
schemas/level_v1.schema.json
schemas/level_v2.schema.json
scripts/simulation/level_loader.gd
scripts/simulation/simulation.gd
scripts/solver/bfs_solver.gd
tests/simulation/task_0023zx_core_mechanics_foundation.gd
tests/simulation/task_0023zx_core_mechanics_complete_matrix.gd
tests/simulation/fixtures/task_0023zx_*.json
tests/levels/task_0012_staggered_doors_validation.gd
tests/tools/run_owned_godot_headless.ps1
**/*.uid
data/catalog/**
data/levels/**
scenes/**
scripts/gameplay/**
scripts/app/**
project.godot
assets/**
```

Do not access production Profile content/metadata/siblings, ordinary user data or the test-profile root.

## 7. Authorized repository paths

```text
tests/tools/task_0024t_*.ps1
tests/tools/task_0024t_*.json
tests/simulation/task_0024t_*.gd
docs/reports/0024T_COMPLETE_CORE_MECHANICS_FINAL_VALIDATION_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/project_memory/HEADLESS_GODOT_TEST_PROCESS_LIFECYCLE_FAILURE_AND_POLICY_CURRENT.md
docs/production/EXPANDED_CONTENT_SUBMISSION_ROADMAP_CURRENT.md
```

No other path may change.

## 8. Output and repository discipline

On pass, write the report with verdict:

```text
COMPLETE_CORE_MECHANICS_FOUNDATION_VALIDATION_READY_FOR_GPT_REVIEW
```

On nonpass, write an honest blocker report with verdict:

```text
BLOCKED_COMPLETE_CORE_MECHANICS_FOUNDATION_VALIDATION
```

A protected-boundary violation uses:

```text
PROTECTED_DATA_BOUNDARY_BREACH
```

Commit authorized paths only. Suggested pass commit:

```text
test: complete manifest-locked core mechanics validation
```

Push normally only after zero-process, exact changed-path, frozen-hash, diff and remote-drift audits. A blocked result may commit and push only validation artifacts and honest blocker/current documentation; it may not modify the provisional implementation.

## 9. Terminal verdict

Return exactly one:

```text
COMPLETE_CORE_MECHANICS_FOUNDATION_VALIDATION_READY_FOR_GPT_REVIEW
BLOCKED_COMPLETE_CORE_MECHANICS_FOUNDATION_VALIDATION
PROTECTED_DATA_BOUNDARY_BREACH
```

A pass establishes only the schema/Simulation/solver foundation and validation harness. It does not authorize formal rooms 9–12, catalog/finale/Profile migration, Gameplay/UI, presentation, localization, asset/font/audio import, build/export, release, upload or submission.
