# Task 0024V — Correct the stale schema regression and complete-v2 test artifact, then qualify both corrections before any new seal

- Status: `READY`
- Gate: `TEST CONTRACT CORRECTION / REPEATABLE QUALIFICATION / NO FINAL SEAL`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Required start commit: `58248f545c128a80e0fd8f3c983f5c4e813be806`
- Closed predecessor: Task `0024U`
- Accepted wrapper implementation/blob: `7c0712d6a602dc23200ccb147d0096acc6333305` / `5f14eb0feff903b40311c1c7283b20e2eabbffc2`
- Provisional foundation implementation: `fdaf2b81fc71c60e4b3548422be94953146f25f4`
- Historical Task 0024T seal SHA-256: `c9f7f2eb1f781280bc9d4a778367da2cde2dfc805ce20578c42098e9bb3caf29`
- Historical Task 0024U seal SHA-256: `2e2ca41e22f54f73b4566125991e2b1ec47dd4a8d052a7a96b6c51028e4e49ed`
- Recommended Codex model: `GPT-5.6 Sol Max`; fallback `GPT-5.6 Sol High`

## 1. Objective

Correct exactly two validation-artifact defects established by Task 0024U, then qualify the corrected tests through repeatable, bounded wrapper executions before any new one-shot seal or final driver is designed.

The two defects are:

1. `tests/run_all.gd` still treats `schema_version = 2` as unsupported even though the provisional loader now intentionally supports schema v2. The unsupported-version probe must target an actually unsupported version while preserving the assertion and all other aggregate behavior.
2. The immutable historical `tests/simulation/task_0024t_v2_solver_replay_canonical_malformed.gd` contains 15 Godot 4.7.1 type-inference parse failures. A new Task 0024V test artifact must preserve its complete validation semantics and 44 coverage IDs while correcting only declaration/type-inference syntax and the task-specific terminal marker.

This task is a correction and qualification gate only. It must not establish final foundation acceptance, create a seal, create a one-shot final driver, execute the historical Task 0024U driver, or modify the provisional gameplay implementation.

## 2. Binding Task 0024U adjudication

Task 0024U is terminally closed and its one-shot budget is consumed.

Accepted facts:

- assigned-scalar PowerShell qualification passed;
- the fixed manifest and new seal passed static validation;
- the final driver ran exactly once;
- all four cases ran exactly once;
- Task 0012 standalone passed;
- focused schema-v2 foundation passed;
- Aggregate completed 621 assertions with exactly one stale unsupported-version assertion failure;
- complete-v2 did not enter assertions because of 15 type-inference parse errors;
- cleanup ran exactly once for every wrapper case;
- Godot count was zero before and after every case and at final;
- all frozen and historical hashes remained exact;
- no protected Profile or user-data boundary was crossed.

Task 0024U artifacts, seals, attempt records, summaries and per-case evidence are historical immutable evidence. Do not edit, overwrite, reseal, rerun or reinterpret them.

## 3. Root-cause classification to preserve

### 3.1 Aggregate failure

The failing source is the legacy probe in `tests/run_all.gd`:

```gdscript
value = base.duplicate(true); value.schema_version = 2
_expect_code(loader.validate_dict(value), "UNSUPPORTED_SCHEMA_VERSION", "unsupported version")
```

The current loader intentionally routes integer schema version 2 to `_validate_v2`. Therefore this assertion is stale test logic, not evidence that schema-v1/formal runtime behavior regressed.

The correction must probe an actually unsupported integer version, preferably `3`, and must retain the expected error code `UNSUPPORTED_SCHEMA_VERSION` and description `unsupported version`.

### 3.2 Complete-v2 failure

The historical Task 0024T script is immutable and must remain byte-identical. Its 15 reported parse sites arise from inferred local variables whose expressions are dynamically typed Variants/Dictionaries/Arrays under Godot `4.7.1.stable.steam.a13da4feb`.

The Task 0024V replacement may correct only:

- explicit local type annotations;
- declaration forms that avoid Variant inference;
- splitting semicolon-combined declarations or assignments when required for valid typing;
- typed fallback dictionaries/arrays when an expression otherwise cannot infer a stable type;
- the task-specific terminal marker and task-specific failure prefix.

It must not weaken, delete, invert, bypass or change any validation condition, expected value, fixture path, solver limit, control-flow decision, state mutation, replay check, malformed-input case or canonical-state distinction.

## 4. Startup gate

Before writing or running Godot:

1. require root `D:\Delayed_Self`, branch `main`, expected origin and no Git operation in progress;
2. fetch and fast-forward only;
3. require `HEAD == origin/main`, zero divergence and ancestry of `58248f545c128a80e0fd8f3c983f5c4e813be806`;
4. require a clean worktree and zero staged paths;
5. require zero pre-existing Godot processes and do not close external processes;
6. read `AGENTS.md`, current startup/active-task documents, this full task and the Task 0024U validation report;
7. verify the accepted wrapper blob;
8. verify the historical Task 0024T and Task 0024U seal SHA-256 values and committed artifact hashes where available;
9. record pre-task hashes of the provisional loader, Simulation, BFS solver, schemas, vectors, fixtures, catalog and eight formal levels;
10. stop on unrelated dirty paths, process ambiguity, historical evidence drift, protected-data access or any need to change product implementation.

Do not access production Profile content/metadata/siblings, ordinary user data or the test-profile root.

## 5. Historical immutable artifacts

Do not modify any Task 0024T or Task 0024U validation artifact, including:

```text
tests/tools/task_0024t_*
tests/tools/task_0024u_*
tests/simulation/task_0024t_v2_solver_replay_canonical_malformed.gd
docs/reports/0024T_COMPLETE_CORE_MECHANICS_FINAL_VALIDATION_REPORT.md
docs/reports/0024U_CORRECTED_COMPLETE_CORE_MECHANICS_FINAL_VALIDATION_REPORT.md
```

Do not modify either external evidence root or any seal, attempt record, final summary or per-case record under them.

## 6. Authorized source correction A — stale aggregate assertion

Modify only the stale unsupported-version probe in:

```text
tests/run_all.gd
```

Required correction:

- change the probe from supported schema version `2` to unsupported integer schema version `3`;
- preserve expected code `UNSUPPORTED_SCHEMA_VERSION`;
- preserve description `unsupported version`;
- preserve all other bytes or demonstrate that any unavoidable formatting-only change is nonsemantic;
- preserve total aggregate assertion count `621`;
- do not add schema-v2 coverage to `run_all.gd` in this task;
- do not change accepted `LEVEL_ID_MISMATCH` stderr policy.

A focused static audit must prove that exactly this logical assertion changed and no other aggregate assertion, expected metric, fixture, hash, catalog fact, UI test or formal-level behavior changed.

## 7. Authorized source correction B — new complete-v2 test

Create:

```text
tests/simulation/task_0024v_v2_solver_replay_canonical_malformed.gd
```

The new script must be derived from the immutable Task 0024T script and preserve:

- all five existing v2 fixtures;
- all 44 exact coverage IDs;
- public loader coverage;
- exact restart coverage for all mutable v2 state;
- bounded BFS solution coverage for all five fixtures;
- shared-Simulation replay of every solver witness;
- replay length/shortest-turn equality;
- deterministic replay/canonical equality;
- all canonical-state distinctions and `turn_index` exclusion;
- YOU-only crate push and key collection;
- same-turn matching lock consumption;
- all typed sensor eligibility cases;
- grouped barrier next-turn, occupied-cell defer and close-after-vacate behavior;
- one-shot latch persistence and restart reset;
- all malformed/unknown/reference/overlap/initial-state atomic rejection cases;
- schema-v1 strict rejection of v2-only fields;
- no parallel transition implementation.

Required terminal marker:

```text
TASK_0024V_V2_COMPLETE_PASS
```

Required failure prefix:

```text
TASK_0024V_V2_COMPLETE_FAIL
```

The new file must not reference or execute the historical incomplete matrix or marker:

```text
res://tests/simulation/task_0023zx_core_mechanics_complete_matrix.gd
TASK_0023ZX_COMPLETE_MATRIX_PASS
```

## 8. Static semantic-equivalence validator

Create a Task 0024V static validator under:

```text
tests/tools/task_0024v_test_correction_static_validator.ps1
```

It must run without launching Godot or the accepted wrapper and prove at minimum:

1. historical Task 0024T/0024U artifacts remain hash-exact;
2. provisional loader, Simulation, BFS, schemas, vectors, fixtures, catalog and formal levels remain hash-exact;
3. `tests/run_all.gd` changed only at the unsupported-version probe and now uses integer `3` with the same error code and description;
4. total `_expect`/assertion structure relevant to the aggregate remains unchanged and expected runtime assertion count is still `621`;
5. the new Task 0024V complete-v2 script contains all 44 exact coverage IDs once each;
6. fixture names, solver limits, expected literals, malformed cases and canonical distinctions remain present;
7. the historical Task 0024T script remains byte-identical;
8. the new file differs from the historical script only by authorized typing/declaration normalization and Task 0024V marker/prefix changes;
9. no product implementation, catalog, level, Profile, Gameplay/UI, project-setting, asset, audio, localization, build/export or release path changed;
10. no Godot/wrapper process is launched by static validation;
11. output is bounded and deterministic.

The validator may use a narrowly scoped Python or PowerShell helper under `tests/tools/task_0024v_*` when necessary. It must fail closed on unclassified semantic differences.

## 9. Repeatable qualification runner

Create a bounded qualification runner under:

```text
tests/tools/task_0024v_test_correction_qualification.ps1
```

This is not a final driver and is not one-shot. It may be rerun during Task 0024V until the corrections pass or a substantive blocker is established.

Each qualification cycle must:

1. require zero Godot processes before starting;
2. require static validator pass;
3. invoke only the accepted wrapper;
4. run corrected Aggregate once:
   - script `res://tests/run_all.gd`;
   - required marker `TASK_0003_TESTS_PASS`;
   - expected aggregate assertion count `621`;
   - stderr allowlist exactly `LEVEL_ID_MISMATCH`;
5. run new complete-v2 once:
   - script `res://tests/simulation/task_0024v_v2_solver_replay_canonical_malformed.gd`;
   - required marker `TASK_0024V_V2_COMPLETE_PASS`;
   - stderr policy `ForbidNonempty`;
6. record native exit, marker result, stderr policy, cleanup invocation count/order, remaining owned/unproven PID facts, bounded stdout/stderr and Godot before/after each case;
7. require cleanup invocation count exactly one per wrapper case;
8. require no remaining owned or unproven PID;
9. require final Godot count zero;
10. require frozen/historical hashes exact after execution;
11. write bounded qualification evidence only under:

```text
D:\Delayed_Self_Evidence\0024V_test_correction_qualification
```

12. record every qualification-cycle invocation count and result honestly.

Reruns are allowed only because this gate is explicitly repairable and non-final. Never describe these runs as final validation or foundation acceptance.

## 10. Repair policy

Before the task is terminally reported, Codex may repair only:

```text
tests/run_all.gd
tests/simulation/task_0024v_v2_solver_replay_canonical_malformed.gd
tests/tools/task_0024v_*.ps1
tests/tools/task_0024v_*.py
tests/tools/task_0024v_*.json
```

After each repair, rerun static validation before any Godot qualification.

Stop instead of repairing when:

- a test failure indicates a possible loader/Simulation/BFS defect;
- a required expectation appears incorrect but changing it would alter mechanics semantics;
- a fixture, schema, vector, catalog or level would need modification;
- more than typing/declaration normalization is needed in the new complete-v2 test;
- historical evidence or accepted wrapper identity drifts;
- process ownership or cleanup is ambiguous;
- protected Profile/user data would be accessed.

## 11. Frozen implementation and protected surfaces

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
audio/**
localization/**
build/**
export/**
```

No seal, final driver, release, upload or submission surface is authorized.

## 12. Authorized repository paths

```text
tests/run_all.gd
tests/simulation/task_0024v_v2_solver_replay_canonical_malformed.gd
tests/tools/task_0024v_*.ps1
tests/tools/task_0024v_*.py
tests/tools/task_0024v_*.json
docs/reports/0024V_TEST_CORRECTION_QUALIFICATION_REPORT.md
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

## 13. Required report

Create:

```text
docs/reports/0024V_TEST_CORRECTION_QUALIFICATION_REPORT.md
```

It must include:

- startup Git facts and required-commit ancestry;
- exact pre/post hashes for all frozen and historical artifacts;
- exact `tests/run_all.gd` logical diff;
- historical-to-new complete-v2 transformation audit;
- all 44 coverage IDs and duplicate/missing counts;
- static-validator result;
- every qualification-cycle count and result;
- final Aggregate wrapper evidence;
- final complete-v2 wrapper evidence;
- native exit, marker, stderr, cleanup and process-isolation facts;
- final Godot process count;
- changed-path audit;
- explicit statement that no seal/final driver/foundation acceptance occurred;
- remaining uncertainty and next gate.

## 14. Commit and push policy

On a qualified pass:

```text
test: qualify corrected core mechanics validation tests
```

On an honest blocker:

```text
test: record core validation test correction blocker
```

Requirements:

1. explicitly stage only authorized files;
2. show staged paths;
3. run `git diff --cached --check`;
4. create one task commit;
5. fetch before push and stop on remote drift;
6. push `main` only if fast-forward-safe;
7. report start/final HEAD, commit SHA, origin divergence and final worktree state.

## 15. Terminal verdict

Return exactly one:

```text
CORE_MECHANICS_TEST_CORRECTION_QUALIFIED_FOR_GPT_REVIEW
BLOCKED_CORE_MECHANICS_TEST_CORRECTION_QUALIFICATION
PROTECTED_DATA_BOUNDARY_BREACH
```

A qualified result authorizes only GPT review and design of a separate Task 0024W manifest/seal/final-validation gate. It does not itself accept the schema-v2/Simulation/solver foundation and does not authorize sequence 9–12, catalog/finale/Profile migration, Gameplay/UI, presentation, localization, assets/fonts/audio, build/export, release, upload or submission.
