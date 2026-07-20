# Task 0023ZD — Construct the AppRoot Profile-session full-matrix harness without fixture execution

- Status: `READY`
- Gate: `PROTECTED PLAYER DATA / COMPLETE APPROOT HARNESS CONSTRUCTION + ZERO-FIXTURE QUALIFICATION`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- GPT prerequisite acceptance: `docs/reports/0023ZC_GPT_APP_ROOT_PROFILE_ORCHESTRATION_COMPILE_GATE_ACCEPTANCE.md`
- Required checkpoint: `5dc7e68759d2294d83c4d21a4da813a8d49b3306`
- Future execution fixture ID: `task_0023ze_app_root_profile_session`
- Fixture status in this task: **reserved string only; do not build, check, create, inspect, enumerate, modify, or clean it**

## 1. Objective

Construct and validate the complete future fixed-fixture behavior harness for the accepted Task 0023ZC AppRoot orchestration, while executing no configured Profile behavior and touching no task-owned fixture.

This task may establish only:

```text
complete future behavior-test source
+ deterministic stage/case/evidence manifest
+ parser compilation of the complete harness
+ static harness-completeness validation
+ capture-runner qualification against zero-I/O parser smoke
+ no configured AppRoot tree entry
+ no Profile/test-fixture operation
```

This task must not behaviorally test store load, persistence, rollback, recovery, reset, reload, or process-restart persistence. Those operations remain reserved for a later Task 0023ZE execution gate.

## 2. Historical task closure

Do not execute, resume, edit, or reuse fixtures from:

```text
tasks/0023Y_app_root_test_profile_session_gate.md
tasks/0023Y_profile_test_app_root_session_orchestration_gate.md
tasks/0023Z_app_root_test_profile_session_retry_after_parser_gate.md
tasks/0023ZA_app_root_test_profile_session_instrumented_diagnostic_retry.md
tasks/0023ZB_app_root_test_profile_session_evidence_complete_rebuild.md
```

Task 0023ZC is accepted and frozen; do not treat old draft patches as source authority. Build the new harness from the accepted repository and current contracts.

## 3. Startup gate

Before edits or Godot processes:

1. require absolute root `D:\Delayed_Self`, branch `main`, expected origin, and clean tracked/untracked worktree;
2. run all startup Git facts required by `AGENTS.md`;
3. fetch and fast-forward only;
4. require `HEAD == origin/main` and ancestry of `5dc7e68759d2294d83c4d21a4da813a8d49b3306`;
5. read the complete 0023W/0023X/0023ZC GPT acceptances and 0023ZA/0023ZB adjudications;
6. verify pinned Godot `4.7.stable.steam.5b4e0cb0f` or the exact documented equivalent;
7. require no residual Godot process.

Stop on divergence, conflict, unexpected files, remote mismatch, or missing checkpoint.

## 4. Protected-data and absolute zero-fixture boundary

Before every Godot or PowerShell validation group and after every group, record only production Profile non-content metadata:

```text
exists = true
Length = 473
LastWriteTimeUtc = 2026-07-19T08:15:02.2089459Z
```

Do not open, read, parse, hash, copy, rename, back up, delete, reset, repair, compare, or write production Profile content.

For `user://delayed_self_test_profiles/`, record only whether the root exists. Do not enumerate, inspect, create, clean, or modify it.

The future fixture ID and canonical path may appear only as inert constants in the behavior source and manifest:

```text
task_0023ze_app_root_profile_session
user://delayed_self_test_profiles/task_0023ze_app_root_profile_session/delayed_self_profile.json
```

In Task 0023ZD, do not:

- call `DelayedSelfLocalProfile.build_test_profile_path` for that ID;
- call `DirAccess.dir_exists_absolute`, `FileAccess.file_exists`, globalize the path, or check its exact directory;
- instantiate and enter a successfully configured AppRoot into the tree;
- call store `configure_test`, `load_profile`, `persist_profile`, `reset_test_profile`, or any failure seam against a live store;
- create, write, inspect, list, rename, delete, or clean fixture files.

Any Profile/test-root I/O or production metadata change is an immediate stop with no harness commit.

## 5. Mandatory accepted regressions

Before editing and after all harness validation, rerun exactly:

```text
0023R = 123 assertions / 4 positive / 39 negative
0023T = compile marker + 34 assertions
0023V = compile marker + 28 assertions
0023W = compile marker + 68 assertions
0023X = compile marker + 31 assertions
0023ZC parser marker + compile contract 17 assertions
```

Every command must exit 0, print its required marker exactly once, and have empty stderr. Require the 0023W fixture absent after its own cleanup, unchanged production metadata, unchanged test-root existence, and no Godot process.

## 6. Frozen accepted authorities

Do not modify:

```text
scripts/app/app_root.gd
scripts/app/profile_codec.gd
scripts/app/local_profile.gd
scripts/app/profile_progress_adapter.gd
scripts/app/memory_progress.gd
all existing 0023R–0023ZC tests
formal catalog/level data
Simulation/solver/schema/canonical state
Gameplay/Help/Timeline/Level Select/final acknowledgment
scenes/project.godot
```

Task 0023ZC pre-tree configuration, configured source ordering, persistence-before-commit ordering, bounded Safe Error behavior, exact public progress shape, and normal unconfigured memory-only behavior are frozen.

Stop if harness construction appears to require a frozen-source change.

## 7. Required new files

Create exactly these task-owned harness files:

```text
tests/app/task_0023zd_app_root_profile_session_full_matrix.gd
tests/app/task_0023zd_full_matrix_parser_smoke.gd
tests/app/task_0023zd_full_matrix_harness_validator.gd
tests/app/task_0023zd_full_matrix_manifest.json
tests/app/task_0023zd_capture_profile_session.ps1
```

No product source may change.

## 8. Future behavior script contract

Create the complete future behavior script:

```text
tests/app/task_0023zd_app_root_profile_session_full_matrix.gd
```

It must be executable later by Task 0023ZE, but it must not be executed in Task 0023ZD.

### 8.1 Explicit execution authorization guard

At process initialization, before path construction, fixture checking, AppRoot creation, FileAccess/DirAccess use, or any deferred behavior call, require an exact user argument:

```text
--task-0023ze-fixture-execution
```

Without that argument, print exactly once:

```text
TASK_0023ZD_EXECUTION_GUARD_BLOCKED
```

and exit 2 without any Profile/test-root operation.

The future Task 0023ZE capture runner will supply this argument. Task 0023ZD must not supply it.

### 8.2 Fixed future fixture constants

The behavior source must freeze:

```text
FIXTURE_ID = task_0023ze_app_root_profile_session
CANONICAL_PROFILE_PATH = user://delayed_self_test_profiles/task_0023ze_app_root_profile_session/delayed_self_profile.json
```

The script must verify at runtime that the path returned later by `build_test_profile_path(FIXTURE_ID)` exactly equals the frozen canonical path, but that runtime code must remain behind the execution guard and must not run in this task.

### 8.3 Deterministic stage protocol

Maintain one explicit `current_stage: String` and implement deterministic helpers that print:

```text
TASK_0023ZE_BEHAVIOR_PROCESS_STARTED
TASK_0023ZE_STAGE_BEGIN=<stage_id>
TASK_0023ZE_STAGE_PASS=<stage_id>
TASK_0023ZE_ASSERT_FAIL stage=<stage_id> label=<bounded_label>
TASK_0023ZE_ABORT stage=<stage_id> reason=<bounded_reason>
TASK_0023ZE_ASSERTIONS=<count>
TASK_0023ZE_APP_ROOT_PROFILE_SESSION_FULL_MATRIX_PASS
```

Every expectation must use the common assertion helper so the active stage and bounded label are always present on failure. Controlled safety stops must use the common abort helper.

Do not print Profile content, virtual/globalized paths, raw filesystem errors, or recovery/temp/transaction filenames.

### 8.4 Required stages in exact order

The complete source must implement and execute these stage IDs in exact order when later authorized:

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

Every stage must have a distinct function and one begin/pass pair. The `final` stage may pass only after all prior stages and exact cleanup have passed.

## 9. Full future behavior matrix

The behavior source must contain executable assertions for all cases below. Do not replace cases with comments, TODOs, placeholder pass calls, unconditional true assertions, or reduced diagnostic subsets.

### Configuration and default mode

1. production path rejects before tree entry with no configured state;
2. malformed/non-test paths reject before tree entry;
3. rejected attempts permit a later valid canonical configuration;
4. first valid configuration is immutable;
5. post-tree and post-boot valid configuration reject;
6. normal unconfigured AppRoot boots Main Menu, uses memory-only mode, constructs no store/adapter, unlocks only Tutorial 0, and exposes exact defensive three-key progress shape;
7. unconfigured direct-development routing remains unchanged.

### Missing target, persistence, and reload

8. configured missing target boots Main Menu with clean progress and no eager target creation;
9. real Tutorial 0 Gameplay actions complete in 3 turns;
10. before persistence success, runtime/Profile progress remains unchanged;
11. successful persistence precedes adapter commit;
12. after success, AppRoot returns Level Select, records 3 turns, and unlocks only Tutorial 1;
13. target bytes are canonical according to the frozen codec;
14. a fresh configured AppRoot reloads identical completion, best turn, and unlock state;
15. all AppRoot instances retain one active screen and the existing router.

### NO_CHANGE

16. replaying Tutorial 0 with equal/worse turns follows `NO_CHANGE`;
17. target metadata and bytes are unchanged;
18. runtime state remains semantically unchanged;
19. existing route/finale behavior is preserved.

### Failure injection and rollback

For each accepted failure stage below, use a fresh controlled session with a known prior canonical target and exact pre-attempt runtime/Profile snapshots:

20. `TEMP_WRITE`: no adapter commit, exact target preserved, exact runtime/Profile preserved, bounded Safe Error, no new unlock;
21. `TEMP_READBACK`: same guarantees;
22. `REPLACE`: exact old target restored/preserved, no runtime commit, bounded Safe Error;
23. `POST_REPLACE_VERIFY`: exact old target restored/preserved, no runtime commit, bounded Safe Error;
24. each failure leaves one active screen, makes no false Level Select/final-success claim, and exposes no path/content/raw filesystem details;
25. only the frozen failure-stage whitelist is accepted; invalid stages reject.

### Recovery

26. malformed source is preserved exactly to a bounded owned recovery sibling by the frozen store;
27. malformed load yields clean runtime hydration and does not overwrite the source during load;
28. unknown-version source receives the same preservation and clean-hydration guarantees;
29. recovery failure, if induced through the accepted `RECOVERY_COPY` seam, preserves the original target, disables writes/reset through the store contract, and boots bounded Safe Error without partial progress authority;
30. recovery/temp/transaction collision handling stays within the fixed owned fixture and does not enumerate the test root.

### Public snapshots and defensive copies

31. memory-only and configured public progress snapshots have exactly `completed_level_ids`, `best_turns`, and `unlocked_level_ids`;
32. configured public progress comes from adapter nested runtime, never wrapper keys;
33. all returned public progress and bounded session snapshots are defensive;
34. no Profile/settings/path/store/adapter/sibling/raw-error data is exposed.

### Cleanup and final safety

35. cleanup tracks every owned target/recovery/temp/transaction path created by the script;
36. cleanup deletes only tracked owned paths and the exact future fixture directory;
37. cleanup never enumerates or cleans the test root;
38. final fixture and all owned siblings are absent;
39. production Profile metadata and test-root existence equal their baselines;
40. no residual Godot process remains after the external runner completes;
41. final success marker prints only after the complete matrix and cleanup.

The source may include more assertions, but it may not omit or weaken any required case.

## 10. Manifest contract

Create:

```text
tests/app/task_0023zd_full_matrix_manifest.json
```

It must be deterministic JSON with exactly these top-level keys:

```text
schema_version
future_task
fixture_id
canonical_profile_path
execution_guard
stage_order
case_ids
evidence_files
accepted_failure_stages
forbidden_disclosures
```

Requirements:

- `schema_version` is exactly 1;
- `future_task` is exactly `0023ZE`;
- fixture/path/guard match the frozen behavior constants;
- `stage_order` matches Section 8.4 exactly;
- `case_ids` contains one stable ID for every Section 9 case, in order;
- `accepted_failure_stages` matches the frozen store whitelist exactly;
- `forbidden_disclosures` includes Profile content, virtual/globalized paths, raw filesystem errors, store/adapter objects, and sibling filenames;
- `evidence_files` defines the exact capture inventory below.

## 11. Capture runner construction

Create:

```text
tests/app/task_0023zd_capture_profile_session.ps1
```

It must be a strict PowerShell runner with two modes:

```text
-Mode Qualify
-Mode Execute
```

### Qualify mode

- may run only the zero-I/O Task 0023ZD parser smoke;
- must not pass the future execution guard;
- must use `Start-Process -Wait -PassThru`;
- must independently redirect stdout and stderr;
- must retain the qualification inventory below;
- must fail if stdout lacks the parser marker exactly once, stderr is non-empty, exit code is nonzero, or any required file is missing.

Qualification files:

```text
capture_qualification_command.txt
capture_qualification_stdout.txt
capture_qualification_stderr.txt
capture_qualification_exit_code.txt
capture_qualification_process_before.txt
capture_qualification_process_after.txt
capture_qualification_production_metadata_before.txt
capture_qualification_production_metadata_after.txt
capture_qualification_test_root_exists_before.txt
capture_qualification_test_root_exists_after.txt
capture_qualification_inventory.txt
```

### Execute mode

Execute mode is authored for Task 0023ZE but must not run in Task 0023ZD.

It must:

- accept a positive attempt number and evidence root;
- allow only the exact future full-matrix script path;
- pass exactly the future execution guard;
- independently retain the full attempt inventory;
- preserve evidence on nonzero exit;
- generate the worktree patch and SHA-256 before correction/cleanup/rollback;
- extract stage summary and classification without modifying stdout/stderr;
- verify complete inventory before returning control.

Required future attempt files:

```text
attempt_<N>_command.txt
attempt_<N>_stdout.txt
attempt_<N>_stderr.txt
attempt_<N>_exit_code.txt
attempt_<N>_process_before.txt
attempt_<N>_process_after.txt
attempt_<N>_production_metadata_before.txt
attempt_<N>_production_metadata_after.txt
attempt_<N>_test_root_exists_before.txt
attempt_<N>_test_root_exists_after.txt
attempt_<N>_fixture_exact_state_before.txt
attempt_<N>_fixture_exact_state_after.txt
attempt_<N>_worktree.patch
attempt_<N>_worktree_patch_sha256.txt
attempt_<N>_stage_summary.txt
attempt_<N>_classification.txt
attempt_<N>_inventory.txt
```

The runner must not print or copy production Profile content, enumerate the test root, or weaken a failing result.

## 12. Parser smoke

Create:

```text
tests/app/task_0023zd_full_matrix_parser_smoke.gd
```

It must preload:

```text
the complete future behavior script
accepted AppRoot script/scene
accepted LocalProfile store
accepted ProfileProgressAdapter
```

It must not instantiate the behavior script, enter a configured AppRoot into the tree, call the execution guard, or perform Profile/test-root I/O.

Print exactly once:

```text
TASK_0023ZD_FULL_MATRIX_PARSER_SMOKE_PASS
```

Allow at most five parser-only corrections inside authorized 0023ZD files.

## 13. Static harness validator

Create:

```text
tests/app/task_0023zd_full_matrix_harness_validator.gd
```

The validator may read only task-owned `res://tests/app/task_0023zd_*` source/manifest files and accepted source text needed for static cross-checks. Reading repository source is allowed; reading any `user://` Profile or test-root path is forbidden.

It must validate at minimum:

1. manifest top-level shape and exact constants;
2. exact stage order and unique stage IDs;
3. one behavior function and begin/pass invocation for every stage;
4. every required case ID appears in the manifest and behavior source;
5. no TODO, FIXME, placeholder, unconditional pass helper, `assert(true)`, or skipped-stage switch exists;
6. all expectations route through the stage-aware assertion helper;
7. execution guard text appears before any path construction, AppRoot creation, FileAccess, or DirAccess operation in executable initialization flow;
8. future fixture ID/path are exact and unique;
9. accepted failure-stage whitelist is exact;
10. configured public snapshot assertions require the exact three-key nested runtime shape;
11. persistence-before-commit assertions and source calls are present;
12. all failure, rollback, recovery, reload, snapshot, router, and cleanup cases are present;
13. capture runner supports only `Qualify` and `Execute` modes;
14. Qualify mode cannot pass the execution guard or full-matrix script;
15. Execute mode requires the guard, exact script, positive attempt number, and complete inventory;
16. every manifest evidence filename template is represented in the runner;
17. no production Profile content access or test-root enumeration command appears;
18. no frozen source file changed from the accepted 0023ZC checkpoint.

Print assertion count and exactly one terminal marker:

```text
TASK_0023ZD_FULL_MATRIX_HARNESS_VALIDATOR_PASS
```

Require exit 0 and empty stderr.

## 14. Capture qualification in this task

After parser smoke and static validator pass, run the new PowerShell runner only in `Qualify` mode against the parser smoke.

Use evidence root:

```text
D:\Delayed_Self_Evidence\0023ZD_app_root_full_matrix_harness_gate\
```

Require every qualification file, parser marker exactly once, exit 0, empty stderr, unchanged production metadata, unchanged test-root existence, and no residual Godot process.

Do not invoke `-Mode Execute`, do not run the future behavior script directly, and do not pass `--task-0023ze-fixture-execution`.

## 15. Explicit typing and code quality

All GDScript locals receiving dynamic calls, `Dictionary.get`, JSON results, collection elements, scene/script preloads, and Variant-returning expressions must be explicitly typed. Do not use `:=` for dynamic values.

The PowerShell runner must use strict mode, explicit parameter validation, deterministic file names, fail-closed inventory checks, and no catch block that discards exit status or evidence.

Run source audits before and after validation.

## 16. Post-validation gates

After capture qualification:

1. rerun parser smoke and static validator from fresh Godot processes;
2. rerun capture qualification with a fresh qualification evidence subdirectory or deterministic clean qualification files;
3. rerun 0023R/0023T/0023V/0023W/0023X/0023ZC;
4. confirm all accepted source and existing tests are byte-identical to the checkpoint;
5. confirm production metadata and test-root existence unchanged;
6. confirm 0023W fixture absent;
7. require no Godot process;
8. confirm future fixture was never checked or touched.

Do not run `tests/run_all.gd`, aggregate, configured AppRoot boot, or the future full-matrix behavior script.

## 17. Authorized repository paths

```text
tests/app/task_0023zd_app_root_profile_session_full_matrix.gd
tests/app/task_0023zd_full_matrix_parser_smoke.gd
tests/app/task_0023zd_full_matrix_harness_validator.gd
tests/app/task_0023zd_full_matrix_manifest.json
tests/app/task_0023zd_capture_profile_session.ps1
docs/reports/0023ZD_APP_ROOT_PROFILE_SESSION_FULL_MATRIX_HARNESS_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/production/COMPLETE_FLOW_PRODUCTION_CLOSURE_PLAN_CURRENT.md
```

Do not modify product source, accepted tests, tasks, scenes, project settings, formal data, assets, localization, export, release, or submission surfaces.

## 18. Evidence and Git

Use only:

```text
D:\Delayed_Self_Evidence\0023ZD_app_root_full_matrix_harness_gate\
```

Record startup facts, protected metadata, prerequisite results, parser attempts, validator assertions, source audits, capture qualification inventories, changed paths, frozen hashes, and final Git state.

Create:

```text
docs/reports/0023ZD_APP_ROOT_PROFILE_SESSION_FULL_MATRIX_HARNESS_REPORT.md
```

Require one harness commit:

```text
test: add Delayed Self AppRoot full-matrix profile harness
```

Stage authorized paths explicitly, run `git diff --cached --check`, fetch and stop on drift, then push normally.

Finish with clean worktree, `HEAD == origin/main`, divergence `0/0`, no Godot process, unchanged production metadata/test-root existence, absent 0023W fixture, and no future fixture operation.

## 19. Terminal verdict and non-claims

Return exactly one:

```text
APP_ROOT_PROFILE_SESSION_FULL_MATRIX_HARNESS_READY_FOR_GPT_REVIEW
BLOCKED_APP_ROOT_PROFILE_SESSION_FULL_MATRIX_HARNESS_GATE
```

Include commit SHA if produced, parser/validator results and assertion count, capture-qualification inventory, prerequisite regressions, static-audit result, protected metadata, proof of zero future-fixture operation, changed paths, evidence root, and final Git state.

A passing verdict establishes only that the complete future harness and capture procedure are constructed, parsed, statically validated, and zero-I/O-qualified. It does not establish actual configured AppRoot behavior, load/persist/reset/recovery, rollback, process-restart persistence, two-pass fixture success, production Profile operation, default product persistence, menus/settings/localization, aggregate coverage, build/export, RC, release, upload, or festival submission readiness.