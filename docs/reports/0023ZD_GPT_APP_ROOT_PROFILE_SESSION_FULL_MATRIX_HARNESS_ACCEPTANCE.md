# Task 0023ZD GPT AppRoot Profile-session full-matrix harness acceptance

- Reviewed implementation commit: `2651be00468c4458cc40676c0debc354b933a902`
- Verdict: `TASK_0023ZD_APP_ROOT_PROFILE_SESSION_FULL_MATRIX_HARNESS_ACCEPTED`
- Scope accepted: complete future Task 0023ZE behavior harness, deterministic manifest, static validator, parser smoke, and zero-I/O-qualified capture runner
- Fixed-fixture execution and configured AppRoot behavior: not accepted or authorized by this report

## Accepted harness boundary

Task 0023ZD adds exactly five task-owned harness files and modifies no product source:

```text
tests/app/task_0023zd_app_root_profile_session_full_matrix.gd
tests/app/task_0023zd_full_matrix_parser_smoke.gd
tests/app/task_0023zd_full_matrix_harness_validator.gd
tests/app/task_0023zd_full_matrix_manifest.json
tests/app/task_0023zd_capture_profile_session.ps1
```

The accepted future fixture contract is frozen as:

```text
fixture_id = task_0023ze_app_root_profile_session
canonical_path = user://delayed_self_test_profiles/task_0023ze_app_root_profile_session/delayed_self_profile.json
execution_guard = --task-0023ze-fixture-execution
```

These values were inert constants only in Task 0023ZD. The future fixture was not built, checked, created, inspected, enumerated, modified, or cleaned.

## Accepted execution guard

The complete behavior script checks the exact execution guard during `_initialize`, before deferred execution, AppRoot creation, path construction, `FileAccess`, `DirAccess`, or `build_test_profile_path` use.

Without the guard it prints exactly:

```text
TASK_0023ZD_EXECUTION_GUARD_BLOCKED
```

and exits 2.

Task 0023ZD did not pass the guard and did not execute the complete behavior script.

## Accepted deterministic matrix

The manifest and behavior source freeze 18 ordered stages:

```text
startup
invalid_configuration
late_and_reconfiguration
normal_memory_boot
missing_profile_boot
tutorial_0_persist
fresh_reload
no_change
temp_write_failure
temp_readback_failure
replace_failure
post_replace_verify_failure
malformed_recovery
unknown_version_recovery
public_snapshot
router_contract
cleanup
final
```

The manifest freezes 41 unique stable case IDs covering configuration rejection, normal memory boot, missing-profile boot, real Tutorial 0 persistence, fresh reload, `NO_CHANGE`, four transactional failure stages, recovery preservation/failure, exact public snapshot shape, router behavior, owned cleanup, protected metadata, and external process accounting.

The behavior script uses one common stage protocol and assertion/abort helpers:

```text
TASK_0023ZE_BEHAVIOR_PROCESS_STARTED
TASK_0023ZE_STAGE_BEGIN=<stage_id>
TASK_0023ZE_STAGE_PASS=<stage_id>
TASK_0023ZE_ASSERT_FAIL stage=<stage_id> label=<bounded_label>
TASK_0023ZE_ABORT stage=<stage_id> reason=<bounded_reason>
TASK_0023ZE_ASSERTIONS=<count>
TASK_0023ZE_APP_ROOT_PROFILE_SESSION_FULL_MATRIX_PASS
```

## Accepted capture runner

The PowerShell runner exposes only:

```text
Qualify
Execute
```

`Qualify` is restricted to the zero-I/O parser smoke and cannot accept a positive attempt number or alternate script. `Execute` requires a positive attempt number, the exact full-matrix script, and appends the exact execution guard.

The accepted qualification inventory contains 11 independent files. The future Execute attempt inventory contains 17 independent files, including stdout, stderr, exit code, process snapshots, production metadata snapshots, test-root existence snapshots, exact owned-fixture state, worktree patch, patch SHA-256, stage summary, classification, and inventory.

The runner preserves nonzero process evidence and does not infer success from exit code alone; a passing candidate also requires empty stderr and exactly one full-matrix success marker.

## Accepted validation evidence

```text
Harness stages: 18
Stable case IDs: 41
Parser smoke: first pass + final fresh-process pass
Static validator: 251 assertions, exit 0, stderr empty, marker exactly once
Capture qualification 1: complete 11-file inventory; exposed and corrected one runner inventory-format issue
Capture qualification 2: complete 11-file inventory; parser marker once; exit 0; stderr empty
Execute commands: 0
Guard-passing commands: 0
Full behavior-script executions: 0
```

Frozen regressions passed:

```text
0023R: 123 assertions / 4 positive / 39 negative
0023T: compile marker + 34 assertions
0023V: compile marker + 28 assertions
0023W: compile marker + 68 assertions
0023X: compile marker + 31 assertions
0023ZC: parser marker + 17 assertions
```

Every final process exited 0 with empty stderr and its required marker exactly once. Sixteen frozen files matched the checkpoint, with no product-source or accepted-test modification.

## Protected data boundary

Production Profile content was not opened or accessed. Its non-content metadata remained:

```text
exists = true
Length = 473
LastWriteTimeUtc = 2026-07-19T08:15:02.2089459Z
```

The test-root existence fact remained unchanged and the root was not enumerated. The future 0023ZE fixture was never checked or operated. The accepted 0023W fixture remained absent. No Godot process remained.

## Frozen authorities

Later work must preserve:

1. Tasks 0023R–0023W path, codec, store, recovery, rollback, reset, and cleanup contracts.
2. Task 0023X adapter and atomic runtime hydration behavior.
3. Task 0023ZC AppRoot pre-tree configuration, configured source ordering, persistence-before-commit ordering, exact public progress shape, bounded Safe Error behavior, and normal memory-only path.
4. Task 0023ZD future fixture constants, execution guard, 18-stage order, 41 case IDs, evidence manifest, parser smoke, static validator, and capture runner.
5. Production Profile non-content metadata protection and the no-test-root-enumeration boundary.
6. The eight-level catalog, formal hashes/metrics, Simulation, solver, schema, canonical state, Gameplay, final acknowledgment, Help, Timeline, Level Select, presentation, and owner-evidence boundaries.

## Next gate authorized separately

A later Task 0023ZE may execute the accepted full-matrix harness against exactly the reserved fixture using the accepted runner's `Execute` mode.

That execution gate should freeze all product and harness source, qualify the runner again, prove the no-guard exit-2 boundary, require the exact fixture to be absent before each pass, and obtain two consecutive complete clean-fixture runs. Each run must produce the full 17-file inventory, all 18 stage begin/pass markers in order, 41 assertions, exactly one success marker, exit 0, empty stderr, exact cleanup, unchanged production metadata/test-root existence, and zero residual Godot processes.

Any assertion failure, controlled abort, evidence-inventory gap, protected-data change, unexpected fixture residue, or frozen-file drift must stop without source repair and produce a docs-only classified blocker report.

Production Profile activation, default product persistence, aggregate registration, menus/settings/localization, build/export, RC, release, upload, and festival submission remain closed.

## Non-claims

This acceptance does not establish configured AppRoot load/persist/reset/recovery behavior, rollback correctness, restart persistence, actual fixture cleanup, two-pass full-matrix success, production persistence, aggregate coverage, menus/settings/localization, build/export, RC, release, upload, or festival submission readiness.

```text
TASK_0023ZD_APP_ROOT_PROFILE_SESSION_FULL_MATRIX_HARNESS_ACCEPTED
```