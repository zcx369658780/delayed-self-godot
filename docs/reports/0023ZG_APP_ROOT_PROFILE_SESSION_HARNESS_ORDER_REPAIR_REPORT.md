# Task 0023ZG AppRoot Profile-session harness order-repair report

- Verdict: `APP_ROOT_PROFILE_SESSION_HARNESS_ORDER_REPAIR_READY_FOR_GPT_REVIEW`
- Baseline HEAD: `21bd066e1a5159c8fa7b712349fd4db531ee3fcd`
- Required checkpoint: `f3236c636c924718d7621897a9889641c5c5fb94`
- Godot: `4.7.stable.steam.5b4e0cb0f`
- Evidence:
  `D:\Delayed_Self_Evidence\0023ZG_app_root_harness_order_repair\`

## Outcome

The canonical five-file full-matrix harness now repairs the accepted unlocked
ID ordering defect without modifying product behavior. The behavior source
defines one explicitly typed helper:

```gdscript
func _expected_tutorial_unlocked_ids() -> Array[String]:
    var expected: Array[String] = [TUTORIAL_0_ID, TUTORIAL_1_ID]
    expected.sort()
    return expected
```

Both exact two-level comparisons now use a fresh result from this helper:

```text
tutorial_0_persist
fresh_reload
```

The comparisons still require exactly two IDs in deterministic order. No
membership-only, size-only, set-only, or otherwise weakened assertion replaced
the exact equality. No raw equality against
`[TUTORIAL_0_ID, TUTORIAL_1_ID]` remains outside the helper construction.
Completed IDs, best turns, route, screen, persist, byte, reload, failure,
recovery, and cleanup requirements remain unchanged.

## Future Task 0023ZH contract

All five harness artifacts now consistently target:

```text
future_task = 0023ZH
fixture_id = task_0023zh_app_root_profile_session
canonical_profile_path = user://delayed_self_test_profiles/task_0023zh_app_root_profile_session/delayed_self_profile.json
execution_guard = --task-0023zh-fixture-execution
```

Behavior protocol markers use the `TASK_0023ZH_` namespace. The revised
task-owned validation markers are:

```text
TASK_0023ZG_FULL_MATRIX_PARSER_SMOKE_PASS
TASK_0023ZG_FULL_MATRIX_HARNESS_VALIDATOR_PASS
TASK_0023ZG_CAPTURE_QUALIFICATION_PASS
```

No executable harness artifact retains the closed 0023ZE task token, fixture
ID, guard, or protocol namespace.

## Manifest and static validator

The manifest remains schema version 1 and preserves exactly:

```text
18 ordered stages
41 unique stable case IDs
6 accepted failure stages
11 Qualification evidence files
17 Execute evidence files
7 forbidden disclosure categories
```

No stage or case was added, removed, renamed, merged, reordered, or weakened.

The reinforced validator proves the exact 0023ZH contract, absence of the old
executable contract, helper construction/sort/return, both helper call sites,
absence of the raw unsorted equality, and the frozen
`memory_progress.gd` sort-before-return behavior. It retains all prior
manifest, protocol, evidence, failure, ordering, disclosure, AppRoot-ordering,
and frozen-hash checks, and adds accepted Task 0023ZF diagnostic hashes.

Validator result:

```text
TASK_0023ZG_VALIDATOR_ASSERTIONS=279
TASK_0023ZG_FULL_MATRIX_HARNESS_VALIDATOR_PASS
exit = 0
stderr = empty
terminal marker count = 1
```

## Parser evidence

The first complete repair draft passed parser smoke on attempt 1. The final
fresh-process parser smoke also passed:

```text
parser corrections = 0
both exits = 0
both stderr = empty
both marker counts = 1
```

Neither parser run executed the full behavior source or performed Profile or
fixture I/O.

## No-guard proof

The revised behavior script was invoked exactly once without the 0023ZH guard.
It stopped before deferred or sensitive work:

```text
Godot exit = 2
TASK_0023ZH_EXECUTION_GUARD_BLOCKED count = 1
TASK_0023ZH_BEHAVIOR_PROCESS_STARTED count = 0
TASK_0023ZH_OBSERVATION count = 0
TASK_0023ZH_APP_ROOT_PROFILE_SESSION_FULL_MATRIX_PASS count = 0
stderr = empty
production metadata unchanged = true
test-root existence unchanged = true
worktree unchanged = true
Godot processes before/after = 0 / 0
```

The 0023ZH guard was not passed.

## Capture-runner Qualifications

Two consecutive runner Qualifications targeted only the revised parser smoke.
Each retained all 11 required files and reported:

```text
exit = 0
outer stderr = empty
parser marker count = 1
ExecutionGuardPassed = False
QualificationPassed = True
production metadata unchanged = true
test-root existence unchanged = true
Godot processes before/after = 0 / 0
```

Command audit:

```text
Qualify commands = 2
Execute commands = 0
guard-passing commands = 0
future-fixture commands = 0
full behavior executions = 0
full-matrix pass markers = 0
```

## Frozen regressions

All mandatory frozen regressions passed both before editing and after all
repair validation:

| Gate | Result |
|---|---|
| 0023R | 123 assertions / 4 positive / 39 negative |
| 0023T | compile marker + 34 assertions |
| 0023V | compile marker + 28 assertions |
| 0023W | compile marker + 68 assertions |
| 0023X | compile marker + 31 assertions |
| 0023ZC | parser marker + compile contract 17 assertions |
| 0023ZF | parser marker only |

Every command exited 0, had empty stderr, and printed its required marker
exactly once. Aggregate and `tests/run_all.gd` were not run.

## Protected-data and zero-fixture boundary

Production Profile content was not opened, read, parsed, hashed, copied,
renamed, backed up, deleted, reset, repaired, compared, or written. Its
non-content metadata remained:

```text
exists = true
Length = 473
LastWriteTimeUtc = 2026-07-19T08:15:02.2089459Z
```

The test-root existence fact remained true without enumeration. The 0023W,
0023ZE, and 0023ZF fixture directories are absent. Task 0023ZG never
globalized, tested, checked, created, inspected, cleaned, or modified the
reserved 0023ZH fixture path. No successfully configured AppRoot entered the
tree, and no configured store load/persist/reset/recovery behavior ran.

## Final audits

```text
static parser errors = 0
dynamic unsafe := occurrences = 0
PowerShell parser errors = 0
unauthorized changed paths = 0
frozen product/0023R-0023ZC/0023ZF diffs = 0
project.godot/.gd.uid/.godot pollution = 0
residual Godot processes = 0
```

## Repository scope

The change set is limited to the thirteen paths authorized by Task 0023ZG:

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

No product source, accepted prerequisite test, scene, project setting, formal
data, asset, localization, export, release, or submission surface changed.

## Non-claims

This gate establishes only that the identified harness order defect is
repaired and the retargeted future harness is parsed, statically validated,
guard-proven, and zero-I/O requalified. It does not establish that the full
matrix passes, that every later stage is correct, that configured product
persistence is complete, or that production persistence, aggregate,
menus/settings/localization, build/export, RC, release, upload, or festival
submission is ready. Actual fixture execution remains separately gated by
future Task 0023ZH.
