# Task 0023ZF Tutorial-0 persistence subcondition diagnostic report

- Verdict: `TUTORIAL_ZERO_PERSIST_SUBCONDITION_DIAGNOSTIC_READY_FOR_GPT_REVIEW`
- Classification: `EXPECTED_CONTRACT_OBSERVED`
- Baseline HEAD: `d10966a325275963125d6764ccd129797a3b32f3`
- Required checkpoint: `bb13eabc72c7c1e996870d52848820df5b0defa3`
- Godot: `4.7.stable.steam.5b4e0cb0f`
- Evidence:
  `D:\Delayed_Self_Evidence\0023ZF_tutorial_persist_subcondition_diagnostic\`

## Outcome

The task-owned minimal diagnostic executed exactly once against the fresh
`task_0023zf_tutorial_persist_diagnostic` fixture. It reproduced the accepted
missing-profile boot and exact three-action Tutorial-0 completion sequence,
then recorded the authorized facts immediately after completion and after one
additional process frame.

The complete bounded observation was:

```text
TASK_0023ZF_OBSERVATION immediate_route=LEVEL_SELECT immediate_screen=1 immediate_completed_count=1 immediate_tutorial_completed=true immediate_best_present=true immediate_best=3 immediate_tutorial_one_unlocked=true immediate_persist=COMMITTED_AFTER_PERSISTED immediate_target=true delayed_route=LEVEL_SELECT delayed_screen=1 delayed_completed_count=1 delayed_tutorial_completed=true delayed_best_present=true delayed_best=3 delayed_tutorial_one_unlocked=true delayed_persist=COMMITTED_AFTER_PERSISTED delayed_target=true load=MISSING_CLEAN boot=TEST_PROFILE_READY configured=true
```

The corresponding classification was:

```text
TASK_0023ZF_CLASSIFICATION=EXPECTED_CONTRACT_OBSERVED
```

Within this minimal reproduction, both the immediate and delayed bounded
contracts were observed as expected. This result does not isolate or explain
the cause of the earlier Task 0023ZE compound-assertion failure.

## Parser and guard proof

- PowerShell static parsing reported zero errors.
- The Godot parser smoke passed on its first run with exit 0, one pass marker,
  and empty stderr; a fresh post-cleanup parser run also passed.
- The no-guard proof retained all 11 required files and returned wrapper exit
  0 / Godot exit 2.
- The guard proof printed exactly one
  `TASK_0023ZF_EXECUTION_GUARD_BLOCKED`, zero observation markers, and zero
  classification markers, with empty stderr.
- Guard proof preserved production metadata, test-root existence, fixture
  state, repository state, and zero Godot processes.

## Unique diagnostic capture

The wrapper accepted only `GuardProof` or `Execute`; execution required the
exact diagnostic script and `AttemptNumber=1`. The sole Execute run produced:

```text
wrapper/process exit = 0
stderr length = 0
observation marker count = 1
classification marker count = 1
required evidence files = 17
missing evidence files = 0
worktree patch empty and SHA valid = true
```

Before execution, the exact fixture directory, canonical target, and all 24
known store sibling paths were absent. Immediately after execution, only the
exact fixture directory and canonical target existed; all 24 sibling paths
remained absent. Production metadata and test-root existence were unchanged,
and Godot process counts were zero before and after.

## Exact cleanup

Runner evidence and the 17/17 inventory were preserved before cleanup. Cleanup
then addressed only the exact canonical target and the 24 fixed owned sibling
paths. The target was removed, no sibling existed, and the empty exact fixture
directory was removed non-recursively. Neither the test root nor the fixture
directory was enumerated.

Final fixture state:

```text
Task 0023W fixture absent
Task 0023ZE fixture absent
Task 0023ZF fixture absent
canonical target absent
all 24 fixed sibling paths absent
```

## Frozen regressions

The mandatory frozen regression set passed both before diagnostic execution
and again after exact cleanup:

| Gate | Result |
|---|---|
| 0023R | 123 assertions / 4 positive / 39 negative |
| 0023T | compile marker + 34 assertions |
| 0023V | compile marker + 28 assertions |
| 0023W | compile marker + 68 assertions |
| 0023X | compile marker + 31 assertions |
| 0023ZC | parser marker + 17 assertions |
| 0023ZD | parser marker + validator 251 assertions |

Every required process exited 0, printed its required marker exactly once, had
empty stderr, preserved protected state, and left no Godot process. The fresh
Task 0023ZF parser smoke also passed after cleanup.

All frozen checkpoint hashes/diffs and frozen worktree diffs remained zero.
There was no `project.godot`, `.gd.uid`, or `.godot/` pollution.

## Protected state

Production Profile content was not opened, read, parsed, hashed, copied,
renamed, backed up, deleted, reset, repaired, compared, or written. Its
non-content metadata remained:

```text
exists = true
Length = 473
LastWriteTimeUtc = 2026-07-19T08:15:02.2089459Z
```

The test-root existence fact remained true. Its contents were not enumerated.
No unrelated fixture was inspected, changed, or cleaned.

## Repository scope

The repository change set is limited to the eleven paths authorized by Task
0023ZF Section 16:

```text
tests/app/task_0023zf_tutorial_persist_diagnostic.gd
tests/app/task_0023zf_tutorial_persist_diagnostic_parser_smoke.gd
tests/app/task_0023zf_capture_tutorial_persist_diagnostic.ps1
docs/reports/0023ZF_TUTORIAL_PERSIST_SUBCONDITION_DIAGNOSTIC_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/production/COMPLETE_FLOW_PRODUCTION_CLOSURE_PLAN_CURRENT.md
```

No AppRoot, product source, existing 0023R–0023ZD test/harness/runner/manifest,
scene, project setting, formal data, asset, localization, export, release, or
submission surface changed.

## Non-claims

This diagnostic does not repair AppRoot, change or validate the accepted
full-matrix harness, run Task 0023ZE again, or establish that the full matrix
passes. It does not prove production persistence correctness, production
Profile safety beyond the recorded boundary facts, or the reason for the
earlier Task 0023ZE compound failure. In particular, the expected minimal
observation must not be used to infer an AppRoot, harness, runner, assertion,
route-timing, or filesystem root cause without a separately authorized task.

It does not authorize production Profile access, default persistence, source
repair, aggregate registration, menus, settings, localization, build/export,
RC, release, upload, or festival submission.
