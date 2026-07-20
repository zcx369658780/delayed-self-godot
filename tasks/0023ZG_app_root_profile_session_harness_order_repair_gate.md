# Task 0023ZG — Repair and retarget the AppRoot full-matrix harness after the unlocked-order defect

- Status: `READY`
- Gate: `PROTECTED PLAYER DATA / HARNESS ORDER REPAIR + ZERO-FIXTURE REQUALIFICATION`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- GPT adjudication: `docs/reports/0023ZF_GPT_TUTORIAL_PERSIST_DIAGNOSTIC_ACCEPTANCE_AND_0023ZE_ROOT_CAUSE_ADJUDICATION.md`
- Required checkpoint: `f3236c636c924718d7621897a9889641c5c5fb94`
- Future execution task: `0023ZH`
- Future fixture ID: `task_0023zh_app_root_profile_session`
- Fixture status in this task: **reserved inert constant only; no fixture operation is authorized**

## 1. Objective

Repair the accepted Task 0023ZD full-matrix harness defect that expected Tutorial 0 and Tutorial 1 in an unsorted exact array, retarget the future execution contract from closed Task 0023ZE to fresh Task 0023ZH, and requalify the revised harness without executing any configured Profile behavior.

This task may establish only:

```text
harness unlocked-order repair
+ future fixture/guard retargeting to 0023ZH
+ consistent behavior/manifest/runner/validator markers
+ parser compilation
+ static harness validation
+ no-guard exit-2 proof
+ zero-I/O runner Qualification
+ no fixture execution
```

It must not execute the full matrix, create/check the future fixture, or modify AppRoot/product source.

## 2. Accepted root cause

The frozen `DelayedSelfMemoryProgress.snapshot()` sorts `unlocked_level_ids` before returning them.

The frozen IDs are:

```text
TUTORIAL_0_ID = tutorial_reach_exit
TUTORIAL_1_ID = tutorial_echo_bridge
```

The deterministic sorted order is:

```text
tutorial_echo_bridge
tutorial_reach_exit
```

The Task 0023ZD behavior source incorrectly used exact comparisons against:

```gdscript
[TUTORIAL_0_ID, TUTORIAL_1_ID]
```

in at least the Tutorial-0 persistence and fresh-reload checks. That expectation is deterministically reversed. The Task 0023ZF diagnostic confirms the semantic product facts while not repairing the harness.

Do not change product ordering. Repair the harness expectation.

## 3. Historical closure and fixture non-reuse

Do not resume or execute:

```text
tasks/0023ZE_app_root_profile_session_full_matrix_execution_gate.md
tasks/0023ZF_tutorial_zero_persist_subcondition_diagnostic_gate.md
```

Do not reuse either fixture:

```text
task_0023ze_app_root_profile_session
task_0023zf_tutorial_persist_diagnostic
```

Tasks 0023Y, 0023Z, 0023ZA, and 0023ZB remain historical closed scopes.

## 4. Startup gate

Before edits or Godot/PowerShell processes:

1. require absolute root `D:\Delayed_Self`, branch `main`, expected origin, and a clean tracked/untracked worktree;
2. run the startup Git facts required by `AGENTS.md`;
3. fetch and fast-forward only;
4. require `HEAD == origin/main` and ancestry of `f3236c636c924718d7621897a9889641c5c5fb94`;
5. read the complete 0023ZC/0023ZD GPT acceptances, 0023ZE blocker report, 0023ZF diagnostic report, and GPT root-cause adjudication;
6. verify pinned Godot `4.7.stable.steam.5b4e0cb0f` or the exact documented equivalent;
7. require no residual Godot process.

Stop on divergence, conflict, unexpected files, remote mismatch, missing checkpoint, or process residue.

## 5. Protected-data and zero-fixture boundary

Before and after every Godot or PowerShell group, record only production Profile non-content metadata:

```text
exists = true
Length = 473
LastWriteTimeUtc = 2026-07-19T08:15:02.2089459Z
```

Do not open, read, parse, hash, copy, rename, back up, delete, reset, repair, compare, or write production Profile content.

For `user://delayed_self_test_profiles/`, record only whether the root exists. Do not enumerate, inspect, create, clean, or modify it.

The new future fixture contract is:

```text
fixture_id = task_0023zh_app_root_profile_session
canonical_path = user://delayed_self_test_profiles/task_0023zh_app_root_profile_session/delayed_self_profile.json
execution_guard = --task-0023zh-fixture-execution
```

These values may appear only as inert source/manifest/runner constants. In Task 0023ZG do not:

- call `build_test_profile_path` for the new ID;
- globalize or test the new fixture path;
- check the fixture directory, target, or owned siblings;
- run runner `Execute`;
- pass the new execution guard to Godot;
- enter a successfully configured AppRoot into the tree;
- perform configured store load/persist/reset/recovery behavior.

Any task-owned fixture operation or production metadata change is an immediate stop with no harness-repair commit.

## 6. Mandatory pre/post frozen regressions

Before editing and after all repair validation, rerun:

```text
0023R = 123 assertions / 4 positive / 39 negative
0023T = compile marker + 34 assertions
0023V = compile marker + 28 assertions
0023W = compile marker + 68 assertions
0023X = compile marker + 31 assertions
0023ZC = parser marker + compile contract 17 assertions
0023ZF = parser marker only; do not execute its diagnostic guard
```

Every command must exit 0, have empty stderr, and print its marker exactly once. Require the 0023W fixture absent and no Godot process.

Do not run aggregate or `tests/run_all.gd`.

## 7. Frozen authorities

Do not modify:

```text
scripts/app/app_root.gd
scripts/app/profile_codec.gd
scripts/app/local_profile.gd
scripts/app/profile_progress_adapter.gd
scripts/app/memory_progress.gd
all existing 0023R–0023ZC tests
all 0023ZF diagnostic/parser/capture files
formal catalog/level data
Simulation/solver/schema/canonical state
Gameplay/Help/Timeline/Level Select/final acknowledgment
scenes/project.godot
```

The AppRoot implementation, MemoryProgress sorted snapshot behavior, store/adapter contracts, and product routing remain frozen.

## 8. Authorized harness artifact revisions

Only these existing harness artifacts may change:

```text
tests/app/task_0023zd_app_root_profile_session_full_matrix.gd
tests/app/task_0023zd_full_matrix_parser_smoke.gd
tests/app/task_0023zd_full_matrix_harness_validator.gd
tests/app/task_0023zd_full_matrix_manifest.json
tests/app/task_0023zd_capture_profile_session.ps1
```

Authorized reports/current documents are listed in Section 17.

Do not rename the five files. They remain the canonical full-matrix harness artifact set, revised for future Task 0023ZH execution.

## 9. Mandatory unlocked-order repair

In the full behavior source, add one explicitly typed helper equivalent to:

```gdscript
func _expected_tutorial_unlocked_ids() -> Array[String]:
    var expected: Array[String] = [TUTORIAL_0_ID, TUTORIAL_1_ID]
    expected.sort()
    return expected
```

Requirements:

1. use the helper for every exact two-level unlocked-array comparison;
2. repair at minimum `tutorial_0_persist` and `fresh_reload`;
3. preserve exact-array semantics: exactly two IDs, no extras, deterministic sorted order;
4. do not replace exact equality with membership-only, size-only, set-only, or weakened assertions;
5. do not alter completed IDs, best-turn, route, screen, persist, byte, reload, failure, recovery, or cleanup requirements;
6. no raw exact comparison against `[TUTORIAL_0_ID, TUTORIAL_1_ID]` may remain outside the helper construction.

The helper must return a fresh local array and must not mutate product snapshots or constants.

## 10. Retarget the future execution contract to 0023ZH

Update the five harness artifacts consistently from the closed 0023ZE contract to:

```text
future_task = 0023ZH
fixture_id = task_0023zh_app_root_profile_session
canonical_profile_path = user://delayed_self_test_profiles/task_0023zh_app_root_profile_session/delayed_self_profile.json
execution_guard = --task-0023zh-fixture-execution
```

Update all behavior protocol markers to the `TASK_0023ZH_` namespace:

```text
TASK_0023ZH_BEHAVIOR_PROCESS_STARTED
TASK_0023ZH_STAGE_BEGIN=<stage_id>
TASK_0023ZH_STAGE_PASS=<stage_id>
TASK_0023ZH_ASSERT_FAIL stage=<stage_id> label=<bounded_label>
TASK_0023ZH_ABORT stage=<stage_id> reason=<bounded_reason>
TASK_0023ZH_ASSERTIONS=<count>
TASK_0023ZH_APP_ROOT_PROFILE_SESSION_FULL_MATRIX_PASS
```

The no-guard marker must be:

```text
TASK_0023ZH_EXECUTION_GUARD_BLOCKED
```

The revised parser marker must be:

```text
TASK_0023ZG_FULL_MATRIX_PARSER_SMOKE_PASS
```

The revised validator terminal marker must be:

```text
TASK_0023ZG_FULL_MATRIX_HARNESS_VALIDATOR_PASS
```

The capture Qualification marker must be:

```text
TASK_0023ZG_CAPTURE_QUALIFICATION_PASS
```

No executable harness artifact may retain `task_0023ze_app_root_profile_session`, `--task-0023ze-fixture-execution`, or `TASK_0023ZE_` protocol strings after the repair.

Historical docs/reports may retain 0023ZE references.

## 11. Manifest contract

Preserve exactly:

```text
schema_version = 1
18 ordered stages
41 unique stable case IDs
6 accepted failure stages
11 qualification evidence files
17 Execute attempt evidence files
7 forbidden disclosure categories
```

Change only the future task/fixture/path/guard values required by Section 10. Do not remove, reorder, rename, merge, weaken, or add behavior cases in this task.

## 12. Static validator reinforcement

Revise the static validator so it proves at minimum:

1. manifest and all executable artifacts use the exact 0023ZH future contract;
2. old 0023ZE executable tokens are absent;
3. the behavior source defines `_expected_tutorial_unlocked_ids`;
4. the helper creates the two IDs, sorts the local array, and returns it;
5. the helper is used in both Tutorial-0 persistence and fresh-reload exact comparisons;
6. no raw unsorted equality against `[TUTORIAL_0_ID, TUTORIAL_1_ID]` remains;
7. the frozen `memory_progress.gd` source still sorts `unlocked_level_ids`;
8. all original 18 stages, 41 cases, evidence inventories, failure stages, protocol helpers, ordering checks, disclosure checks, AppRoot ordering checks, and frozen hashes remain validated;
9. product and accepted diagnostic files match their checkpoint blobs/hashes.

The validator must print a deterministic assertion count and the terminal marker exactly once, exit 0, and have empty stderr. Record the exact final assertion count in the report.

Do not weaken or delete an existing validator assertion merely to obtain a pass.

## 13. Parser gate

Run the revised parser smoke after the first complete repair draft and again from a final fresh Godot process.

It must preload the complete revised behavior source, manifest-related scripts, AppRoot, store, and adapter without executing the behavior source or performing Profile/test-root I/O.

Allow at most five parser-only corrections within the five authorized harness artifacts. Record every attempt.

## 14. No-guard execution proof

Run the revised full behavior script once **without** the 0023ZH guard, using independently retained stdout/stderr/exit/process/protected-state evidence.

Require:

```text
Godot exit = 2
TASK_0023ZH_EXECUTION_GUARD_BLOCKED count = 1
TASK_0023ZH_BEHAVIOR_PROCESS_STARTED count = 0
TASK_0023ZH_OBSERVATION/full-matrix pass markers = 0
stderr empty
production metadata unchanged
test-root existence unchanged
worktree unchanged
Godot processes before/after = 0
```

Do not pass the guard in this task.

## 15. Capture-runner Qualification

The revised PowerShell runner must continue to expose only:

```text
Qualify
Execute
```

`Qualify` must remain restricted to the revised parser smoke. `Execute` must require a positive attempt number, the exact full behavior script, and append the exact 0023ZH guard, but Execute must not be called in Task 0023ZG.

Run two consecutive Qualifications into separate task-owned evidence subdirectories. Each must retain the complete 11-file inventory, parser marker once, exit 0, empty stderr, unchanged production metadata/test-root existence, and zero Godot processes.

Audit evidence commands and require:

```text
Qualify commands = 2
Execute commands = 0
guard-passing commands = 0
full behavior executions = 0
```

## 16. Final audits

Before documentation closeout require:

- static parser errors = 0;
- dynamic unsafe `:=` occurrences in revised GDScript = 0;
- PowerShell parser errors = 0;
- 18 stages and 41 cases exact;
- no unauthorized changed path;
- no product-source diff;
- no accepted 0023R–0023ZC/0023ZF file diff;
- no `project.godot`, `.gd.uid`, or `.godot/` pollution;
- production metadata unchanged;
- test-root existence unchanged without enumeration;
- 0023W, 0023ZE, and 0023ZF fixtures absent;
- no task-owned 0023ZH fixture check or operation occurred;
- no residual Godot process.

## 17. Authorized repository paths

```text
tests/app/task_0023zd_app_root_profile_session_full_matrix.gd
tests/app/task_0023zd_full_matrix_parser_smoke.gd
tests/app/task_0023zd_full_matrix_harness_validator.gd
tests/app/task_0023zd_full_matrix_manifest.json
tests/app/task_0023zd_capture_profile_session.ps1
docs/reports/0023ZG_APP_ROOT_PROFILE_SESSION_HARNESS_ORDER_REPAIR_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/production/COMPLETE_FLOW_PRODUCTION_CLOSURE_PLAN_CURRENT.md
```

Do not modify any other repository path.

## 18. Evidence and Git

Use only:

```text
D:\Delayed_Self_Evidence\0023ZG_app_root_harness_order_repair\
```

Record startup facts, protected metadata, frozen regressions, parser-attempt ledger, validator output, no-guard evidence, both Qualification inventories, command audit, changed-path audit, frozen hashes, and final Git state.

Create:

```text
docs/reports/0023ZG_APP_ROOT_PROFILE_SESSION_HARNESS_ORDER_REPAIR_REPORT.md
```

Require one implementation commit:

```text
test: repair and retarget Delayed Self AppRoot full-matrix harness
```

Stage authorized paths explicitly, run `git diff --cached --check`, fetch and stop on drift, then push normally.

Finish with clean worktree, `HEAD == origin/main`, divergence `0/0`, no Godot process, unchanged production metadata/test-root existence, no task-owned fixture, and no full behavior execution.

## 19. Terminal verdict and non-claims

Return exactly one:

```text
APP_ROOT_PROFILE_SESSION_HARNESS_ORDER_REPAIR_READY_FOR_GPT_REVIEW
BLOCKED_APP_ROOT_PROFILE_SESSION_HARNESS_ORDER_REPAIR
```

Include commit SHA if produced, repaired locations, future 0023ZH contract, parser/validator results and assertion count, guard proof, two Qualification inventories, frozen regressions, protected metadata, zero Execute count, evidence root, changed paths, and final Git state.

A passing verdict establishes only that the identified harness order defect is repaired and the retargeted future harness is parsed, statically validated, guard-proven, and zero-I/O requalified. It does not establish that the full matrix passes, that every later stage is correct, that configured product persistence is complete, or that production persistence, aggregate, menus/settings/localization, build/export, RC, release, upload, or festival submission is ready.