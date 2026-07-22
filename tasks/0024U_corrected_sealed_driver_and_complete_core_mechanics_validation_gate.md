# Task 0024U — Correct the sealed-driver precondition harness and execute one fresh complete core-mechanics validation

- Status: `READY`
- Gate: `VALIDATION CORRECTION / NEW ARTIFACT IDENTITIES + NEW SEAL + ONE FRESH FINAL DRIVER`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Required GPT adjudication checkpoint: `34e3d721a98708dc49811e5118fd2fd08e4727d4`
- Closed predecessor: Task `0024T`
- Accepted wrapper implementation: `7c0712d6a602dc23200ccb147d0096acc6333305`
- Accepted wrapper blob: `5f14eb0feff903b40311c1c7283b20e2eabbffc2`
- Provisional foundation implementation: `fdaf2b81fc71c60e4b3548422be94953146f25f4`
- Historical 0024T seal SHA-256: `c9f7f2eb1f781280bc9d4a778367da2cde2dfc805ce20578c42098e9bb3caf29`
- Recommended Codex model: `GPT-5.6 Sol Max`; fallback `GPT-5.6 Sol High`

## 1. Objective

Preserve the complete Task 0024T sealed blocker evidence, create a new Task 0024U validation package whose PowerShell preconditions are statically and behaviorally qualified before sealing, and execute one fresh complete core-mechanics final driver exactly once.

This task is validation-only. It must not modify the provisional schema-v2 implementation, accepted wrapper, Task 0012, UID sidecars, catalog, formal levels, Profile or product surfaces.

## 2. Binding Task 0024T facts

Task 0024T is terminally closed.

It proved only:

- four ordered cases were statically defined;
- 44 coverage IDs and 26 frozen hashes passed static validation;
- one external read-only seal was written;
- the driver was invoked once;
- zero wrapper/Godot cases ran.

Its driver failed on:

```powershell
Assert-True (Get-GodotCount -eq 0) 'Godot process exists at final-session start'
```

Actual Godot count was zero. PowerShell treated `-eq` and `0` as function arguments rather than comparing the returned value.

Do not edit, copy over, reseal, rerun or reinterpret any Task 0024T sealed artifact or evidence.

## 3. Startup gate

Before editing or execution:

1. require root `D:\Delayed_Self`, branch `main`, expected origin and no Git operation in progress;
2. fetch and fast-forward only;
3. require `HEAD == origin/main`, ancestry of `34e3d721a98708dc49811e5118fd2fd08e4727d4`, and zero remote divergence;
4. require a clean worktree and zero staged paths;
5. require zero pre-existing Godot processes; do not close external processes;
6. read the Task 0024T blocker report and GPT adjudication;
7. verify the historical Task 0024T seal SHA and exact committed hashes for all Task 0024T artifacts;
8. record frozen hashes for the accepted wrapper, provisional implementation, schema-v1 vectors, catalog and all eight formal-level JSON files;
9. require accepted wrapper blob `5f14eb0feff903b40311c1c7283b20e2eabbffc2`;
10. stop on unrelated dirty paths, process ambiguity, protected-data access, frozen drift or need to modify the provisional foundation.

No production Profile, ordinary user data or test-profile root access is authorized.

## 4. Historical 0024T artifacts are frozen evidence

Do not modify:

```text
tests/tools/task_0024t_core_mechanics_final_validation_manifest.json
tests/tools/task_0024t_core_mechanics_final_validation_static_validator.ps1
tests/tools/task_0024t_core_mechanics_final_validation.ps1
tests/simulation/task_0024t_v2_solver_replay_canonical_malformed.gd
docs/reports/0024T_COMPLETE_CORE_MECHANICS_FINAL_VALIDATION_REPORT.md
```

Do not modify or replace the external 0024T evidence root or seal.

The new gate must use Task 0024U names and a separate external evidence root.

## 5. Authorized Task 0024U artifacts

Create only:

```text
tests/tools/task_0024u_core_mechanics_final_validation_manifest.json
tests/tools/task_0024u_core_mechanics_final_validation_static_validator.ps1
tests/tools/task_0024u_core_mechanics_final_validation_driver.ps1
tests/tools/task_0024u_driver_precondition_qualification.ps1
tests/tools/task_0024u_driver_precondition_qualification_summary.json
```

The fixed case-4 GDScript may reference the immutable Task 0024T complete-v2 script:

```text
res://tests/simulation/task_0024t_v2_solver_replay_canonical_malformed.gd
```

Do not duplicate or modify that sealed GDScript.

Optional Task 0024U-only JSON/PowerShell helpers may use:

```text
tests/tools/task_0024u_*.json
tests/tools/task_0024u_*.ps1
```

## 6. Corrected driver precondition doctrine

Every function result used in a comparison must first be captured as a scalar variable, then compared explicitly.

Required pattern:

```powershell
$initialGodotCount = Get-GodotCount
Assert-True ($initialGodotCount -eq 0) 'Godot process exists at final-session start'
```

Equivalent assigned-scalar patterns are allowed. The driver must not use:

```powershell
Assert-True (Get-GodotCount -eq 0) '...'
```

or any bare command/function invocation embedded in a comparison-looking assertion argument.

Apply the same doctrine to:

- pre-session Godot count;
- before-case Godot count;
- after-case Godot count;
- final Godot count;
- any function result compared to a scalar, hash or collection cardinality.

## 7. Preparation qualification before seal

Preparation is repairable until the new Task 0024U seal is created. No Godot validation case may run during preparation.

The precondition qualification must prove, using pure PowerShell/static behavior only:

1. scalar count `0` passes the zero-count assertion;
2. scalar count `1` fails the zero-count assertion;
3. the exact driver precondition source uses assigned variables followed by binary comparison;
4. the driver AST contains no assertion whose condition is a command invocation with comparison tokens passed as arguments;
5. the validator rejects the historical bad expression;
6. the validator accepts the corrected expression;
7. every process-count assertion has one corresponding scalar assignment;
8. no Godot executable or wrapper is launched;
9. no attempt record or external seal is created during qualification;
10. qualification output is bounded and deterministic.

The qualification may be repaired and rerun before seal creation.

## 8. Fixed four-case manifest

The new manifest must define exactly four ordered cases:

1. `aggregate_v1_formal_regression`
   - script: `res://tests/run_all.gd`
   - marker: `TASK_0003_TESTS_PASS`
   - accepted wrapper;
   - bounded aggregate stderr allowlist only.

2. `task_0012_standalone_regression`
   - script: `res://tests/levels/task_0012_staggered_doors_validation.gd`
   - marker: `TASK_0012_FOCUSED_PASS`
   - stderr policy: `ForbidNonempty`.

3. `v2_focused_foundation`
   - script: `res://tests/simulation/task_0023zx_core_mechanics_foundation.gd`
   - marker: `TASK_0023ZX_PASS`
   - stderr policy: `ForbidNonempty`.

4. `v2_complete_solver_replay_canonical_malformed`
   - script: `res://tests/simulation/task_0024t_v2_solver_replay_canonical_malformed.gd`
   - marker: `TASK_0024T_V2_COMPLETE_PASS`
   - stderr policy: `ForbidNonempty`.

Do not reference or execute the historical incomplete matrix:

```text
res://tests/simulation/task_0023zx_core_mechanics_complete_matrix.gd
TASK_0023ZX_COMPLETE_MATRIX_PASS
```

## 9. Static validator requirements

Before seal creation, the Task 0024U static validator must prove:

- exactly four manifest cases in exact order;
- exact script, marker, stderr policy and wrapper arguments;
- every script exists;
- required markers appear exactly once;
- historical incomplete matrix path and marker are absent;
- immutable Task 0024T complete-v2 script retains all 44 required coverage IDs;
- only accepted wrapper is invoked;
- no retry loop, fallback attempt or case rerun path exists;
- driver precondition qualification passed;
- every process-count comparison uses an assigned scalar variable;
- historical bad PowerShell expression is absent;
- output and records are bounded;
- only authorized paths are dirty;
- all frozen hashes match;
- historical 0024T artifacts and seal identities remain exact.

## 10. New external seal

After all static and pure-PowerShell qualification checks pass, create exactly one new seal at:

```text
D:\Delayed_Self_Evidence\0024U_corrected_complete_core_mechanics_final_validation\pre_execution_seal.json
```

The new seal must include SHA-256 for:

- Task 0024U manifest;
- static validator;
- corrected driver;
- precondition qualification script and summary;
- immutable Task 0024T complete-v2 GDScript;
- accepted wrapper;
- provisional implementation files;
- schema-v1 vectors;
- catalog and all eight formal-level JSON files;
- historical 0024T artifacts and historical seal identity.

Write once, verify immediately and mark read-only.

After the new seal exists:

- do not edit sealed artifacts;
- do not overwrite or reseal;
- any mismatch blocks before final execution.

Seal creation does not itself consume the one driver invocation.

## 11. Exactly one fresh final driver

The Task 0024U driver may be invoked exactly once.

Before invocation require:

- exact CURRENT task/status for Task 0024U;
- exact new seal and all hashes;
- zero Godot processes using assigned-scalar comparison;
- absence of Task 0024U attempt and summary records;
- zero staged paths and only sealed authorized dirty paths.

The driver must create an immutable attempt record before the first wrapper case.

Execute the four manifest cases in order, each once, through the accepted wrapper.

Continue after a case nonpass only to collect bounded diagnostics. Never rerun a case.

Each case must record:

- top-level wrapper status;
- underlying status;
- native exit;
- marker result;
- stderr policy result;
- cleanup invocation count;
- cleanup order;
- remaining owned/unproven PIDs;
- bounded stdout/stderr;
- zero Godot count before and after the case.

After all cases, write one bounded final summary and terminal classification.

The driver itself may not be rerun.

A substantive harness, test, process, hash, path or protected-boundary failure is terminal for Task 0024U.

Mandatory owned-process cleanup remains part of every wrapper invocation.

## 12. Frozen implementation and protected surfaces

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

## 13. Authorized repository paths

```text
tests/tools/task_0024u_*.ps1
tests/tools/task_0024u_*.json
docs/reports/0024U_CORRECTED_COMPLETE_CORE_MECHANICS_FINAL_VALIDATION_REPORT.md
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

## 14. Output

On pass, report:

```text
COMPLETE_CORE_MECHANICS_FOUNDATION_VALIDATION_READY_FOR_GPT_REVIEW
```

On honest nonpass:

```text
BLOCKED_COMPLETE_CORE_MECHANICS_FOUNDATION_VALIDATION
```

Protected boundary breach:

```text
PROTECTED_DATA_BOUNDARY_BREACH
```

Suggested pass commit:

```text
test: complete corrected sealed core mechanics validation
```

A blocked result may commit only Task 0024U validation artifacts and honest blocker/current documents.

## 15. Terminal verdict

Return exactly one:

```text
COMPLETE_CORE_MECHANICS_FOUNDATION_VALIDATION_READY_FOR_GPT_REVIEW
BLOCKED_COMPLETE_CORE_MECHANICS_FOUNDATION_VALIDATION
PROTECTED_DATA_BOUNDARY_BREACH
```

A pass establishes only the schema/Simulation/solver foundation and validation harness. It does not authorize sequence 9–12, catalog/finale/Profile migration, Gameplay/UI, presentation, localization, asset/font/audio import, build/export, release, upload or submission.