# Task 0024W — Seal and execute the corrected complete core-mechanics final validation

- Status: `READY`
- Gate: `MANIFEST-LOCKED CORRECTED FINAL VALIDATION / NEW SEAL / ONE FINAL DRIVER`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Required accepted checkpoint: `3058c03537361ab28e015c6a8a0b244b23db1d37`
- Closed predecessors: all Tasks through `0024V`; none may be resumed directly
- Latest GPT adjudication: `TASK_0024V_TEST_CORRECTION_QUALIFICATION_ACCEPTED_READY_FOR_NEW_FINAL_GATE`
- Accepted wrapper implementation/blob: `7c0712d6a602dc23200ccb147d0096acc6333305` / `5f14eb0feff903b40311c1c7283b20e2eabbffc2`
- Provisional foundation implementation: `fdaf2b81fc71c60e4b3548422be94953146f25f4`
- Historical Task 0024T seal SHA-256: `c9f7f2eb1f781280bc9d4a778367da2cde2dfc805ce20578c42098e9bb3caf29`
- Historical Task 0024U seal SHA-256: `2e2ca41e22f54f73b4566125991e2b1ec47dd4a8d052a7a96b6c51028e4e49ed`
- Recommended Codex model: `GPT-5.6 Sol Max`; fallback `GPT-5.6 Sol High`

## 1. Objective

Create a new Task 0024W manifest, static validator, pure-PowerShell driver qualification, external read-only seal and exactly-once final driver around the already qualified corrected test artifacts, then execute the fixed four-case complete core-mechanics validation exactly once.

This task is validation-only. It must not modify the provisional level-loader, Simulation or BFS implementation, the corrected tests accepted from Task 0024V, formal levels, catalog, Profile/user data or any product/presentation/release surface.

A passing Codex result means only `READY_FOR_GPT_REVIEW`. Foundation acceptance remains a GPT decision.

## 2. Binding Task 0024V acceptance

Task 0024V is accepted as a test-artifact correction and repeatable qualification gate.

Accepted facts:

- `tests/run_all.gd` changed only the stale unsupported-version probe from supported schema version `2` to unsupported version `3`;
- its expectation-call structure remained `253`, and runtime Aggregate passed exactly `621` assertions and nine vectors;
- Aggregate stderr was exactly the accepted `LEVEL_ID_MISMATCH` diagnostic;
- `tests/simulation/task_0024v_v2_solver_replay_canonical_malformed.gd` is semantically equivalent to the immutable Task 0024T test except for 15 explicit declaration types and Task 0024V marker prefixes;
- all 44 required complete-v2 coverage IDs occur exactly once;
- complete-v2 passed with native exit `0`, exact pass marker and empty stderr;
- wrapper cleanup was exactly once per retained case, no owned/unproven PID remained and final Godot count was zero;
- all 26 frozen files and Task 0024T/0024U historical repository/external evidence hashes remained exact;
- no seal or final driver was created in Task 0024V;
- the reproducibility correction commit fixed the semantic-equivalence source ref to `5cd82fbc742bfe2664ea0b0b0df6d48bc8dd717a`, not dynamic `HEAD`.

Task 0024V cycle 001 remains honestly classified as unproven harness-record failure. Cycle 002 is qualification evidence only. Do not rewrite or reinterpret either cycle.

## 3. Startup gate

Before writing or executing anything:

1. require absolute root `D:\Delayed_Self`, branch `main`, expected origin and no Git operation in progress;
2. run `git fetch` and fast-forward only;
3. require `HEAD == origin/main`, divergence `0/0`, and ancestry of `3058c03537361ab28e015c6a8a0b244b23db1d37`;
4. require clean worktree, zero staged paths and no unexpected untracked paths;
5. require zero pre-existing Godot processes; never close unknown or pre-existing processes;
6. read `AGENTS.md`, current startup/active docs, this full task, the Task 0024V report, and the headless lifecycle policy;
7. verify accepted wrapper blob `5f14eb0feff903b40311c1c7283b20e2eabbffc2`;
8. verify the committed SHA-256 identities recorded by Task 0024V for `tests/run_all.gd` and the Task 0024V complete-v2 script;
9. verify all 26 frozen implementation/formal-content hashes and all listed Task 0024T/0024U historical hashes;
10. verify Task 0024V correction/equivalence/qualification files and report exist at the accepted checkpoint;
11. require Godot `4.7.1.stable.steam.a13da4feb` or stop without modifying project settings or installing/upgrading Godot;
12. stop on remote drift, unexpected dirty state, frozen drift, evidence ambiguity, process ambiguity, need to change a qualified test, or any protected-data access need.

Production Profile content/metadata/siblings, ordinary user data and the test-profile root are forbidden.

## 4. Frozen implementation and qualified test artifacts

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
tests/run_all.gd
tests/simulation/task_0023zx_core_mechanics_foundation.gd
tests/simulation/task_0024v_v2_solver_replay_canonical_malformed.gd
tests/simulation/fixtures/task_0023zx_*.json
tests/levels/task_0012_staggered_doors_validation.gd
tests/tools/run_owned_godot_headless.ps1
data/catalog/**
data/levels/**
**/*.uid
scenes/**
scripts/gameplay/**
scripts/app/**
project.godot
assets/**
audio/**
```

Also preserve all Task 0024T, 0024U and 0024V task/report/tool artifacts and all historical external evidence roots byte-for-byte.

The historical incomplete matrix remains excluded:

```text
res://tests/simulation/task_0023zx_core_mechanics_complete_matrix.gd
TASK_0023ZX_COMPLETE_MATRIX_PASS
```

## 5. Authorized Task 0024W preparation artifacts

Create only the following new validation artifacts before execution:

```text
tests/tools/task_0024w_core_mechanics_final_validation_manifest.json
tests/tools/task_0024w_core_mechanics_final_validation_static_validator.ps1
tests/tools/task_0024w_core_mechanics_final_validation_driver.ps1
tests/tools/task_0024w_driver_precondition_and_record_qualification.ps1
tests/tools/task_0024w_driver_precondition_and_record_qualification_summary.json
```

Optional Task 0024W-only static helpers may use:

```text
tests/tools/task_0024w_*.json
tests/tools/task_0024w_*.ps1
tests/tools/task_0024w_*.py
```

No Task 0024W preparation artifact may duplicate game transition logic or execute Godot during preparation.

Preparation is repairable only before the Task 0024W seal is created.

## 6. Fixed four-case manifest

The manifest must define exactly these four cases in this order:

1. `aggregate_v1_formal_regression`
   - script: `res://tests/run_all.gd`
   - required marker: exact prefix `TASK_0003_TESTS_PASS assertions=621 vectors=9`, occurring once;
   - native exit: `0`;
   - stderr policy: exact allowlist containing only `LEVEL_ID_MISMATCH`.

2. `task_0012_standalone_regression`
   - script: `res://tests/levels/task_0012_staggered_doors_validation.gd`
   - required marker: `TASK_0012_FOCUSED_PASS`, occurring once;
   - native exit: `0`;
   - stderr policy: `ForbidNonempty`.

3. `v2_focused_foundation`
   - script: `res://tests/simulation/task_0023zx_core_mechanics_foundation.gd`
   - required marker: `TASK_0023ZX_PASS`, occurring once;
   - native exit: `0`;
   - stderr policy: `ForbidNonempty`.

4. `v2_complete_solver_replay_canonical_malformed`
   - script: `res://tests/simulation/task_0024v_v2_solver_replay_canonical_malformed.gd`
   - required marker: `TASK_0024V_V2_COMPLETE_PASS`, occurring once;
   - native exit: `0`;
   - stderr policy: `ForbidNonempty`.

Each case must use the accepted wrapper and no extra Godot arguments unless explicitly represented and sealed in the manifest. No case, wrapper invocation or final driver may have a retry, fallback or rerun path.

## 7. Required complete-v2 coverage

The manifest and static validator must retain the exact 44 Task 0024V coverage IDs, each exactly once:

```text
V2_FIXTURES_PUBLIC_LOADER_ALL_FIVE
V2_RESTART_EXACT_ALL_FIVE
V2_BFS_SOLVES_ALL_FIVE_BOUNDED
V2_BFS_WITNESS_REPLAY_COMPLETES_ALL_FIVE
V2_REPLAY_COUNT_EQUALS_SHORTEST_ALL_FIVE
V2_WITNESS_REPLAY_DETERMINISTIC_ALL_FIVE
V2_CANONICAL_ID_ARRAY_ORDER_NORMALIZED
V2_CANONICAL_DISTINGUISH_CRATES
V2_CANONICAL_DISTINGUISH_REMAINING_KEYS
V2_CANONICAL_DISTINGUISH_HELD_KEYS
V2_CANONICAL_DISTINGUISH_REMOVED_LOCKS
V2_CANONICAL_DISTINGUISH_BARRIERS
V2_CANONICAL_DISTINGUISH_LATCHES
V2_CANONICAL_DISTINGUISH_PLAYER
V2_CANONICAL_DISTINGUISH_ECHOES
V2_CANONICAL_DISTINGUISH_DOORS
V2_CANONICAL_DISTINGUISH_HISTORY
V2_CANONICAL_DISTINGUISH_COMPLETION
V2_CANONICAL_EXCLUDES_TURN_INDEX
V2_YOU_ONLY_CRATE_PUSH
V2_ECHO_BLOCKED_BY_CRATE
V2_YOU_ONLY_KEY_COLLECTION
V2_SAME_TURN_MATCHING_LOCK_CONSUMPTION
V2_SENSOR_ANY_ACTOR_TYPED_ELIGIBILITY
V2_SENSOR_YOU_ONLY_TYPED_ELIGIBILITY
V2_SENSOR_ECHO_ONLY_TYPED_ELIGIBILITY
V2_SENSOR_EXPLICIT_CRATE_ELIGIBILITY
V2_GROUPED_BARRIER_NEXT_TURN_SEMANTICS
V2_OCCUPIED_CELL_DEFERS_BARRIER_CLOSURE
V2_GROUPED_BARRIER_CLOSE_AFTER_VACATE
V2_ONE_SHOT_LATCH_PERSISTS
V2_RESTART_RESETS_LATCH_IMMUTABLY
V2_MALFORMED_UNKNOWN_TOP_FIELD_ATOMIC
V2_MALFORMED_UNKNOWN_ENTITY_FIELD_ATOMIC
V2_MALFORMED_MISSING_REQUIRED_ARRAY_ATOMIC
V2_MALFORMED_DUPLICATE_IDS_ATOMIC
V2_MALFORMED_UNKNOWN_SENSOR_REFERENCE_ATOMIC
V2_MALFORMED_UNKNOWN_LATCH_REFERENCE_ATOMIC
V2_MALFORMED_INVALID_ACTIVATOR_ATOMIC
V2_MALFORMED_INVALID_KEY_TYPE_ATOMIC
V2_MALFORMED_STATIC_CELL_OVERLAP_ATOMIC
V2_MALFORMED_OUT_OF_BOUNDS_OVERLAY_ATOMIC
V2_MALFORMED_INCONSISTENT_INITIAL_BARRIER_ATOMIC
V1_STRICT_REJECTS_V2_ONLY_FIELDS
```

## 8. Static validator requirements

Before seal creation, the Task 0024W static validator must prove without launching Godot or the accepted wrapper:

- exactly four manifest cases in exact order;
- exact script paths, markers, stderr policies, timeouts and wrapper identity;
- every script exists;
- Aggregate retains the fixed unsupported-version `3` probe, `253` expectation calls and exact marker contract for `621` assertions/nine vectors;
- the Task 0024V complete-v2 script retains all 44 IDs exactly once and its accepted SHA-256;
- the Task 0024V semantic-equivalence validator remains reproducible from fixed source commit `5cd82fbc742bfe2664ea0b0b0df6d48bc8dd717a`, with no dynamic `HEAD` baseline;
- historical incomplete matrix path and marker are absent;
- accepted wrapper is the only wrapper invoked;
- driver contains no retry/fallback/rerun path;
- every process-count comparison uses an assigned scalar followed by an explicit binary comparison;
- no bare command/function invocation appears inside a comparison-looking assertion argument;
- driver writes its invocation/attempt record before the first case;
- driver writes progress immediately after attempt creation, before each case, after each case and before/after final-summary creation;
- records use create-new or atomic replacement semantics and bounded JSON;
- driver always reaches final owned-process isolation audit through a `finally` path where possible;
- static/equivalence checks use fixed commit/blob/hash identities, not dynamic `HEAD` as the historical source of truth;
- only Task 0024W-authorized preparation paths are dirty and zero paths are staged;
- all frozen and qualified-test hashes match;
- Task 0024T/0024U/0024V historical repository and external evidence identities match;
- static validator output is deterministic and bounded;
- wrapper/Godot launch count during static validation is zero.

Any static failure remains repairable only before seal creation.

## 9. Pure-PowerShell driver and record qualification

Before seal creation, execute a repeatable pure-PowerShell qualification that launches neither Godot nor the accepted wrapper and does not create the final Task 0024W seal/attempt/summary.

It must prove:

1. scalar process count `0` passes and `1` fails;
2. historical bad comparison form is rejected and assigned-scalar form is accepted;
3. exact driver AST has zero bad comparison-like command invocations;
4. all driver process-count assignments and comparisons are paired;
5. simulated attempt/progress/case/final-summary records are retained across injected failures before a case, after a case and before final summary;
6. invocation identity is created before simulated case execution;
7. progress checkpoints cannot silently disappear on normal return;
8. create-new protections reject a second invocation against the same simulated root;
9. all simulated records remain bounded valid JSON;
10. no dynamic `HEAD` is used as a historical equivalence baseline;
11. wrapper/Godot launch count is zero;
12. final external evidence root receives no seal, attempt or summary during qualification.

The qualification may be repaired and rerun before seal creation. Its final passing script and summary become sealed artifacts.

## 10. New external seal

After the static validator and pure-PowerShell qualification both pass, create exactly one new seal at:

```text
D:\Delayed_Self_Evidence\0024W_complete_core_mechanics_final_validation\pre_execution_seal.json
```

The Task 0024W external evidence root must be new and initially contain no attempt, progress, case or final-summary record.

The seal must bind SHA-256 identities for at least:

- Task 0024W manifest;
- Task 0024W static validator;
- Task 0024W final driver;
- Task 0024W qualification script and passing summary;
- accepted wrapper;
- `tests/run_all.gd`;
- Task 0012 standalone test;
- focused-v2 test;
- Task 0024V complete-v2 test;
- Task 0024V baseline/equivalence/static/qualification artifacts and report;
- provisional loader, Simulation and BFS implementation;
- schema-v1/v2 contracts, schemas and transition vectors;
- five v2 fixtures;
- catalog and all eight formal-level JSON files;
- all required Task 0024T/0024U historical repository artifacts;
- Task 0024T and 0024U historical external seal/evidence identities;
- accepted Task 0024V commit `3058c03537361ab28e015c6a8a0b244b23db1d37` and its fixed source baseline identity.

Write the seal once, verify it immediately and mark it read-only.

Seal creation does not consume the final-driver invocation.

After seal creation:

- no sealed artifact may change;
- no preparation repair is allowed;
- do not overwrite, delete, replace or reseal;
- any seal/hash/path mismatch blocks execution;
- do not run any individual case outside the final driver.

## 11. Exactly-once final driver

The Task 0024W final driver may be invoked exactly once.

Before invocation require:

- exact current active task/status for Task 0024W;
- exact read-only Task 0024W seal and all bound hashes;
- zero Godot processes, using assigned-scalar comparison;
- absence of Task 0024W attempt, progress, case and final-summary records;
- zero staged paths and only the sealed Task 0024W preparation paths dirty;
- no historical evidence drift.

The driver must:

1. create an immutable invocation/attempt record before the first wrapper case;
2. create a retained progress record immediately;
3. execute the four manifest cases in exact order, once each, through the accepted wrapper;
4. checkpoint progress immediately before and after every case;
5. continue after a nonpass only to collect bounded diagnostics;
6. never rerun a case or itself;
7. preserve bounded stdout/stderr and exact marker/stderr classification;
8. write one case record per case using create-new semantics;
9. perform mandatory cleanup/final process isolation after pass, failure or timeout;
10. write one bounded final summary and terminal classification;
11. mark attempt, case records and final summary read-only after successful write;
12. end with final Godot process count zero.

Per-case evidence must preserve:

- wrapper top-level and underlying classification;
- wrapper process exit and native Godot exit;
- marker count/result;
- stderr policy/result and bounded exact lines;
- cleanup invocation count and cleanup order;
- direct PID and owned descendant facts;
- remaining owned/unproven PID facts;
- Godot count before and after;
- bounded stdout/stderr;
- evidence hash.

Unknown or pre-existing processes remain protected. Never close them.

## 12. Pass conditions

All of the following are mandatory:

- all four cases execute exactly once;
- all four cases have wrapper/native exit `0`;
- every required marker occurs exactly once;
- Aggregate marker states `assertions=621 vectors=9`;
- Aggregate stderr is exactly `LEVEL_ID_MISMATCH` and nothing else;
- all three other cases have empty stderr;
- all 44 complete-v2 IDs remain represented by the qualified script;
- cleanup invocation count equals `1` for every case;
- no owned or unproven PID remains;
- Godot count is zero before/after every case and at final;
- all frozen/sealed/historical hashes remain exact;
- no protected Profile/user-data boundary is crossed;
- no case or driver rerun occurs;
- final summary is complete, bounded and consistent with case records.

## 13. Authorized repository paths

Before final-driver execution, only Task 0024W preparation paths may be changed.

After execution, the final commit may include only:

```text
tests/tools/task_0024w_*.json
tests/tools/task_0024w_*.ps1
tests/tools/task_0024w_*.py
docs/reports/0024W_CORRECTED_COMPLETE_CORE_MECHANICS_FINAL_VALIDATION_REPORT.md
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

## 14. Commit and push policy

After the final driver completes:

- write an honest report whether pass or blocker;
- update current docs consistently;
- explicitly stage only authorized files;
- run `git diff --cached --check` and inspect staged paths;
- create one single-topic Task 0024W result commit; do not amend/rebase/squash;
- fetch before push and stop on remote drift;
- push only a clean fast-forward to `origin/main`;
- require post-push `HEAD == origin/main`, divergence `0/0` and clean worktree;
- report all commits transparently if a separate non-amend correction is genuinely required.

Suggested pass commit:

```text
test: complete corrected sealed core mechanics validation
```

A blocked result may commit only authorized Task 0024W validation artifacts and honest blocker/current documents.

## 15. Terminal verdict

Return exactly one:

```text
COMPLETE_CORE_MECHANICS_FOUNDATION_VALIDATION_READY_FOR_GPT_REVIEW
BLOCKED_COMPLETE_CORE_MECHANICS_FOUNDATION_VALIDATION
PROTECTED_DATA_BOUNDARY_BREACH
```

A pass establishes only that the corrected schema/Simulation/solver foundation and its validation harness are ready for GPT adjudication. It does not authorize sequence 9–12, catalog/finale/Profile migration, Gameplay/UI, presentation, localization, assets/fonts/audio, build/export, release, upload or submission.
