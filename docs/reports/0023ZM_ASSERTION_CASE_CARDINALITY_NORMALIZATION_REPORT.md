# Task 0023ZM assertion/case-cardinality normalization report

- Task: `tasks/0023ZM_assertion_case_cardinality_normalization_gate.md`
- Implementation base: `d792d1c0428b364655e44ac80b31f3f6bca8e264`
- Accepted harness base: `413727fc804355c00f0900d98e668e8e69b4876b`
- Godot: `4.7.stable.steam.5b4e0cb0f`
- Result: `APP_ROOT_PROFILE_SESSION_ASSERTION_CARDINALITY_NORMALIZATION_READY_FOR_GPT_REVIEW`
- Evidence root: `D:\Delayed_Self_Evidence\0023ZM_assertion_case_cardinality_normalization\`

## 1. Normalized root cause

Task 0023ZJ Attempt 1 passed all 18 stages and all 42 runtime assertion
invocations, but the manifest contained only 41 unique case IDs. The duplicate
metadata ID was:

```text
single_active_screen_router
```

It identified both the fresh-reload single-screen check and the full router
contract check. Task 0023ZM changes only the fresh-reload assertion case ID:

```text
single_active_screen_router
→ fresh_reload_single_active_screen
```

The condition and bounded label remain unchanged. The router-contract
assertion retains `single_active_screen_router`.

## 2. Cardinality and internal consistency

The manifest is now:

```text
schema_version = 2
ordered stages = 18
unique case_ids = 42
expected_assertion_count = 42
```

`fresh_reload_single_active_screen` appears immediately after
`fresh_reload_progress` and before `single_active_screen_router`.

The behavior defines:

```gdscript
const EXPECTED_ASSERTION_COUNT: int = 42
```

After all 18 stage runners pass and before either success marker, a non-counting
guard compares `assertions` with the constant. A mismatch uses the existing
bounded abort protocol, exits nonzero, and cannot print the assertion or final
pass marker. The guard does not call `_expect_case` or increment `assertions`.

The static mapping proof establishes 38 direct literal case calls plus four
delegated failure-case calls. Every one of the 42 manifest IDs maps to exactly
one case-argument position. The validator passed 328 assertions:

```text
TASK_0023ZM_VALIDATOR_ASSERTIONS=328
TASK_0023ZM_CASE_CARDINALITY_VALIDATOR_PASS
```

## 3. Future Task 0023ZN contract

All five canonical harness artifacts now consistently contain only this inert
future execution contract:

```text
future_task = 0023ZN
fixture_id = task_0023zn_app_root_profile_session
canonical_profile_path = user://delayed_self_test_profiles/task_0023zn_app_root_profile_session/delayed_self_profile.json
execution_guard = --task-0023zn-fixture-execution
```

Behavior protocol markers use `TASK_0023ZN_`. Parser, validator, and
Qualification markers use `TASK_0023ZM_`. Closed 0023ZJ, 0023ZH, and 0023ZE
executable contracts are absent.

No `build_test_profile_path` call was made for Task 0023ZN, and its future path
was not globalized, inspected, or checked. Its guard was not passed, runner
`Execute` was not called, no configured AppRoot entered the tree, and the full
behavior did not execute.

## 4. Parser, guard, and Qualification evidence

The parser passed once after the complete draft and again from a final fresh
Godot process:

```text
TASK_0023ZM_FULL_MATRIX_PARSER_SMOKE_PASS
```

The behavior no-guard proof passed:

```text
exit = 2
TASK_0023ZN_EXECUTION_GUARD_BLOCKED = 1
behavior-process-start = 0
stage markers = 0
assertion markers = 0
final-pass markers = 0
stderr length = 0
worktree patch unchanged = true
Godot process before/after = 0 / 0
```

Two consecutive runner `Qualify` commands each retained all 11 canonical
files and recorded:

```text
ExecutionGuardPassed=False
ParserMarkerCount=1
PortableSha256Passed=True
QualificationPassed=True
exit=0
stderr length=0
production metadata unchanged=true
test-root existence unchanged=true
process before/after=0/0
```

Command audit:

```text
Qualify commands = 2
Execute commands = 0
guard-passing commands = 0
future-fixture commands = 0
full behavior executions = 0
```

## 5. Frozen regressions

The complete required regression matrix passed before edits and after final
validation from fresh processes:

| Gate | Pre | Post |
|---|---:|---:|
| 0023R | 123 assertions / 4 positive / 39 negative | same |
| 0023T | compile marker + 34 assertions | same |
| 0023V | compile marker + 28 assertions | same |
| 0023W | compile marker + 68 assertions | same |
| 0023X | compile marker + 31 assertions | same |
| 0023ZC | parser marker + 17 assertions | same |
| 0023ZF | parser marker | same |

Every process exited 0 with empty stderr and exactly one required marker. The
accepted 0023W focused regression used only its own historical fixture contract
and left that exact fixture absent. No aggregate or `tests/run_all.gd` command
ran.

## 6. Static, frozen, and protected-state audits

Final audits established:

```text
PowerShell parser errors = 0
unsafe dynamic := occurrences = 0
schema/stage/case/assertion = 2/18/42/42
duplicate manifest case IDs = 0
case mapping failures = 0
closed executable contract matches = 0
non-harness frozen paths = 33
non-harness frozen hash mismatches = 0
unauthorized changed paths = 0
project.godot/.gd.uid/.godot status pollution = 0
residual Godot processes = 0
```

Production Profile content was never opened. Its non-content metadata remained:

```text
Exists=True
Length=473
LastWriteTimeUtc=2026-07-19T08:15:02.2089459Z
```

Test-root existence remained true without enumeration. Exact checks already
authorized for historical 0023W, 0023ZE, 0023ZF, 0023ZH, and 0023ZJ fixture
directories found all absent. No Task 0023ZN fixture check occurred.

The initial non-headless version probe returned no text and produced a transient
Godot process that exited naturally before the startup gate was accepted. The
gate was then rerun with the bounded headless version command and passed with
the exact pinned version and zero residual processes before any edit or dynamic
validation.

## 7. Changed scope

Only the five canonical harness artifacts and authorized documentation changed.
Product source, prerequisite tests, diagnostic source, scenes, project
settings, formal catalog/levels, Simulation, solver, schema, Gameplay, Help,
Timeline, Level Select, and final acknowledgment remain unchanged.

## 8. Non-claims

This task does not establish a second successful full-matrix attempt,
configured production persistence, default production persistence, aggregate
coverage, menus/settings/localization, build/export/RC readiness, release,
upload, or festival-submission readiness. Task 0023ZN execution remains a
separate future authorization.
