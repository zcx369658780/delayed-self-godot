# Task 0023ZG GPT AppRoot Profile-session harness order-repair acceptance

- Reviewed implementation commit: `cfbcbf6c8c7990db232a2fa6fbb22d937e0b623a`
- Verdict: `TASK_0023ZG_APP_ROOT_PROFILE_SESSION_HARNESS_ORDER_REPAIR_ACCEPTED`
- Scope accepted: deterministic unlocked-array expectation repair, complete retargeting to Task 0023ZH, parser/static/guard/Qualification validation
- Full-matrix execution and configured product persistence: not accepted or authorized by this report

## 1. Accepted harness repair

The canonical full-matrix behavior source now defines:

```gdscript
func _expected_tutorial_unlocked_ids() -> Array[String]:
    var expected: Array[String] = [TUTORIAL_0_ID, TUTORIAL_1_ID]
    expected.sort()
    return expected
```

The helper returns a fresh, explicitly typed local array in the same deterministic sorted order returned by the frozen `DelayedSelfMemoryProgress.snapshot()` contract.

Both exact two-level comparisons now use this helper:

```text
tutorial_0_persist
fresh_reload
```

The repair preserves exact-array semantics. It still requires exactly the two expected unlocked IDs with no extras; it does not weaken the contract to membership-only, size-only, or set-only checks. No raw equality against `[TUTORIAL_0_ID, TUTORIAL_1_ID]` remains outside the helper construction.

Completed IDs, best turns, route, active-screen count, persist status, canonical bytes, reload, `NO_CHANGE`, failure seams, rollback, recovery, snapshot, router, cleanup, and protected-state requirements remain unchanged.

## 2. Accepted Task 0023ZH future contract

All five canonical harness artifacts consistently target:

```text
future_task = 0023ZH
fixture_id = task_0023zh_app_root_profile_session
canonical_profile_path = user://delayed_self_test_profiles/task_0023zh_app_root_profile_session/delayed_self_profile.json
execution_guard = --task-0023zh-fixture-execution
```

Behavior markers use the `TASK_0023ZH_` namespace. Parser, validator, and capture Qualification markers use the Task 0023ZG namespace.

No executable harness artifact retains the closed Task 0023ZE fixture, guard, or behavior-protocol contract.

## 3. Accepted deterministic matrix and validator

The manifest remains schema version 1 and preserves:

```text
18 ordered stages
41 unique stable case IDs
6 accepted failure stages
11 Qualification evidence files
17 Execute evidence files
7 forbidden disclosure categories
```

No stage or case was added, removed, renamed, merged, reordered, or weakened.

The reinforced validator proves:

1. exact 0023ZH task/fixture/path/guard values;
2. absence of closed 0023ZE executable tokens;
3. helper definition, exact two IDs, local sort, and return;
4. helper use in Tutorial-0 persistence and fresh reload;
5. absence of the raw unsorted equality;
6. frozen `memory_progress.gd` sort-before-return behavior;
7. all existing stage, case, protocol, evidence, disclosure, AppRoot-ordering, and frozen-hash contracts.

Accepted validator result:

```text
TASK_0023ZG_VALIDATOR_ASSERTIONS=279
TASK_0023ZG_FULL_MATRIX_HARNESS_VALIDATOR_PASS
exit 0
stderr empty
marker exactly once
```

## 4. Accepted parser, guard, and Qualification evidence

```text
Parser smoke: attempt 1 pass + final fresh-process pass
Parser corrections: 0
No-guard proof: Godot exit 2
TASK_0023ZH_EXECUTION_GUARD_BLOCKED: exactly once
TASK_0023ZH_BEHAVIOR_PROCESS_STARTED: zero
Full-matrix pass marker: zero
Capture Qualifications: two consecutive passes
Each Qualification: complete 11-file inventory, exit 0, stderr empty, parser marker once
Execute commands: 0
Guard-passing commands: 0
Full behavior executions: 0
```

The revised runner remains restricted to `Qualify` and `Execute`; `Qualify` runs only parser smoke, while future `Execute` requires a positive attempt number, the exact behavior script, and the exact 0023ZH guard.

## 5. Frozen regressions and protected data

Mandatory pre/post regressions passed:

```text
0023R: 123 assertions / 4 positive / 39 negative
0023T: compile marker + 34 assertions
0023V: compile marker + 28 assertions
0023W: compile marker + 68 assertions
0023X: compile marker + 31 assertions
0023ZC: parser marker + 17 assertions
0023ZF: parser marker only
```

Production Profile content was not accessed. Protected metadata remained:

```text
exists = true
Length = 473
LastWriteTimeUtc = 2026-07-19T08:15:02.2089459Z
```

The test-root existence fact remained unchanged without enumeration. Tasks 0023W, 0023ZE, and 0023ZF fixtures remained absent. Task 0023ZG did not check or operate the reserved 0023ZH fixture. No configured AppRoot entered the tree and no Godot process remained.

## 6. Frozen authorities

Later work must preserve:

1. Tasks 0023R–0023W path, codec, store, recovery, rollback, reset, and cleanup contracts.
2. Task 0023X adapter and atomic runtime hydration behavior.
3. Task 0023ZC AppRoot orchestration, persistence-before-commit ordering, public progress shape, bounded failure routing, and normal memory-only behavior.
4. Task 0023ZF diagnostic sources and accepted narrow result.
5. The revised five-file canonical full-matrix harness, manifest, validator, parser smoke, and capture runner at commit `cfbcbf6c8c7990db232a2fa6fbb22d937e0b623a`.
6. Production Profile metadata protection and the no-test-root-enumeration boundary.
7. The eight-level catalog, formal hashes/metrics, Simulation, solver, schema, canonical state, Gameplay, finale, Help, Timeline, Level Select, and presentation boundaries.

## 7. Next gate authorized separately

A new Task 0023ZH may execute the accepted revised harness against exactly:

```text
task_0023zh_app_root_profile_session
```

using only the accepted runner's `Execute` mode.

That task must freeze all product and harness source, prove the no-guard exit-2 boundary, requalify capture, require the exact fixture and all owned siblings absent before each pass, and obtain two consecutive complete clean-fixture runs without intervening edits.

Each passing run must produce the complete 17-file inventory, all 18 stage begin/pass markers in order, the exact assertion count emitted by the harness, one final success marker, exit 0, empty stderr, exact cleanup, unchanged production metadata/test-root existence, and zero residual Godot processes.

Any assertion failure, abort, evidence gap, protected-state change, residue, or frozen-file drift must stop without source repair and produce a docs-only classified blocker report.

Production Profile activation/default persistence, aggregate registration, menus/settings/localization, build/export, RC, release, upload, and festival submission remain closed.

## 8. Non-claims

This acceptance does not establish that the revised full matrix passes, that later stages are defect-free, that configured product persistence is complete, or that production persistence, aggregate, menus/settings/localization, build/export, RC, release, upload, or festival submission is ready.

```text
TASK_0023ZG_APP_ROOT_PROFILE_SESSION_HARNESS_ORDER_REPAIR_ACCEPTED
```