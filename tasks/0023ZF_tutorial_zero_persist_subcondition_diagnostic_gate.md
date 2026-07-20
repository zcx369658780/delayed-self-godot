# Task 0023ZF — Diagnose the Tutorial-0 persisted-progress subcondition failure

- Status: `READY`
- Gate: `PROTECTED PLAYER DATA / TUTORIAL-0 PERSISTENCE SUBCONDITION DIAGNOSTIC`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- GPT adjudication: `docs/reports/0023ZE_GPT_APP_ROOT_PROFILE_SESSION_TUTORIAL_PERSIST_BLOCKER_ADJUDICATION.md`
- Required checkpoint: `bb13eabc72c7c1e996870d52848820df5b0defa3`
- Fixed task-owned fixture ID: `task_0023zf_tutorial_persist_diagnostic`

## 1. Objective

Reproduce only the Task 0023ZE Tutorial-0 persistence failure and identify which bounded subcondition fails.

The diagnostic path is limited to:

```text
fresh exact fixture
→ configured missing-profile AppRoot boot
→ real accepted three-turn Tutorial-0 completion
→ immediate post-completion observation
→ one-additional-frame observation
→ bounded root-subcondition classification
→ evidence retention
→ exact owned cleanup
```

This task performs no source repair and does not resume the full 18-stage matrix.

## 2. Historical task closure

Do not execute or resume:

```text
tasks/0023ZE_app_root_profile_session_full_matrix_execution_gate.md
```

Do not reuse its fixture. Do not modify or execute the accepted 0023ZD full-matrix script through its execution guard.

Tasks 0023Y, 0023Z, 0023ZA, and 0023ZB remain historical closed scopes.

## 3. Startup gate

Before edits or Godot processes:

1. require `D:\Delayed_Self`, branch `main`, expected origin, and a clean tracked/untracked worktree;
2. run the startup Git facts required by `AGENTS.md`;
3. fetch and fast-forward only;
4. require `HEAD == origin/main` and ancestry of `bb13eabc72c7c1e996870d52848820df5b0defa3`;
5. read the complete 0023ZC/0023ZD GPT acceptances, the 0023ZE blocker report, and the GPT adjudication;
6. verify pinned Godot `4.7.stable.steam.5b4e0cb0f` or the exact documented equivalent;
7. require no residual Godot process.

Stop on divergence, unexpected files, missing checkpoint, or process residue.

## 4. Protected-data boundary

Before and after every Godot/PowerShell group, record only production Profile non-content metadata:

```text
exists = true
Length = 473
LastWriteTimeUtc = 2026-07-19T08:15:02.2089459Z
```

Do not open, read, parse, hash, copy, rename, back up, delete, reset, repair, compare, or write production Profile content.

For `user://delayed_self_test_profiles/`, record only whether the root exists. Do not enumerate or inspect unrelated fixtures.

Build the diagnostic path only through:

```gdscript
DelayedSelfLocalProfile.build_test_profile_path("task_0023zf_tutorial_persist_diagnostic")
```

Require exact equality to:

```text
user://delayed_self_test_profiles/task_0023zf_tutorial_persist_diagnostic/delayed_self_profile.json
```

Before execution, check only the exact diagnostic fixture directory, target, and the 24 known owned temp/transaction/recovery siblings. If any exist, stop without opening, enumerating, or deleting them.

Any production metadata change, production-content access, test-root enumeration, or unrelated-fixture operation is an immediate safety stop.

## 5. Mandatory frozen regressions

Before edits and after diagnostic cleanup, rerun:

```text
0023R = 123 assertions / 4 positive / 39 negative
0023T = compile marker + 34 assertions
0023V = compile marker + 28 assertions
0023W = compile marker + 68 assertions
0023X = compile marker + 31 assertions
0023ZC = parser marker + compile contract 17 assertions
0023ZD = parser marker + validator 251 assertions
```

Every process must exit 0, have empty stderr, and print its marker exactly once. Require the 0023W fixture absent and no Godot process.

## 6. Frozen authorities

Do not modify:

```text
scripts/app/app_root.gd
scripts/app/profile_codec.gd
scripts/app/local_profile.gd
scripts/app/profile_progress_adapter.gd
scripts/app/memory_progress.gd
all existing 0023R–0023ZD tests/harness/manifest/runner
formal catalog/level data
Simulation/solver/schema/canonical state
Gameplay/Help/Timeline/Level Select/final acknowledgment
scenes/project.godot
```

The next task may adjudicate a repair only after this diagnostic identifies the failing subcondition.

## 7. Authorized new files

Create only:

```text
tests/app/task_0023zf_tutorial_persist_diagnostic.gd
tests/app/task_0023zf_tutorial_persist_diagnostic_parser_smoke.gd
tests/app/task_0023zf_capture_tutorial_persist_diagnostic.ps1
docs/reports/0023ZF_TUTORIAL_PERSIST_SUBCONDITION_DIAGNOSTIC_REPORT.md
```

Authorized current documentation paths may also be updated as listed in Section 16.

## 8. Diagnostic execution guard

The diagnostic behavior script must require this exact user argument during `_initialize`, before path construction, AppRoot creation, `FileAccess`, `DirAccess`, or deferred execution:

```text
--task-0023zf-tutorial-persist-diagnostic
```

Without it, print exactly once:

```text
TASK_0023ZF_EXECUTION_GUARD_BLOCKED
```

and exit 2 with zero Profile/test-root operation.

Before the authorized run, prove the no-guard boundary in a separately captured process.

## 9. Minimal reproduction contract

After the guard:

1. build and verify the exact canonical fixture path;
2. confirm exact fixture/target/24 owned siblings absent without enumeration;
3. record only protected metadata/test-root existence baselines;
4. create only the exact diagnostic fixture directory;
5. instantiate AppRoot off-tree, call `configure_test_profile` with the canonical path, then enter it into the tree;
6. require Main Menu, one active screen, `MISSING_CLEAN`, no target, and initial Tutorial-0-only unlock;
7. select Tutorial 0 and use the accepted three actions:

```text
move_up
move_right
move_right
```

8. retain the same process-frame placement used by the accepted full harness: first two actions, one process frame, final action, one process frame;
9. collect the immediate observation;
10. await exactly one additional process frame and collect the delayed observation;
11. print one bounded observation marker and one classification marker;
12. exit 0 if observation/classification completed, regardless of whether the product contract passed.

Do not continue to fresh reload, `NO_CHANGE`, failure injection, recovery, router matrix, or full cleanup stage inside the Godot script.

## 10. Required bounded observations

For both `immediate` and `delayed` snapshots, record only:

```text
route_class = LEVEL_SELECT | GAMEPLAY | SAFE_ERROR | MAIN_MENU | OTHER
active_screen_count = bounded integer
completed_count = bounded integer
tutorial_completed = true | false
tutorial_best_turns_present = true | false
tutorial_best_turns_value = bounded integer or -1
tutorial_one_unlocked = true | false
persist_status = bounded status identifier
target_exists = true | false
```

Also record:

```text
load_status = bounded status identifier
boot_status = bounded status identifier
configured = true | false
```

Do not print completed ID arrays, Profile content, settings, virtual/globalized paths, sibling names, file bytes, raw errors, store/adapter objects, or unrestricted dictionaries.

Required marker form:

```text
TASK_0023ZF_OBSERVATION immediate_route=<...> immediate_screen=<N> immediate_completed_count=<N> immediate_tutorial_completed=<bool> immediate_best_present=<bool> immediate_best=<N> immediate_tutorial_one_unlocked=<bool> immediate_persist=<status> immediate_target=<bool> delayed_route=<...> delayed_screen=<N> delayed_completed_count=<N> delayed_tutorial_completed=<bool> delayed_best_present=<bool> delayed_best=<N> delayed_tutorial_one_unlocked=<bool> delayed_persist=<status> delayed_target=<bool> load=<status> boot=<status> configured=<bool>
```

## 11. Deterministic classification

Print exactly one:

```text
TASK_0023ZF_CLASSIFICATION=<classification>
```

Choose only from:

```text
EXPECTED_CONTRACT_OBSERVED
ROUTE_FRAME_TIMING
ROUTE_FAILURE_STABLE
RUNTIME_PROGRESS_COMMIT_MISMATCH
BEST_TURNS_MISMATCH
PERSISTENCE_STATUS_MISMATCH
ACTIVE_SCREEN_CONTRACT_MISMATCH
UNRESOLVED_SUBCONDITION
```

Classification rules, in order:

1. `EXPECTED_CONTRACT_OBSERVED`: immediate and delayed both have Level Select, one screen, Tutorial 0 completed, best turns 3, Tutorial 1 unlocked, committed-after-persist status, and target exists.
2. `ROUTE_FRAME_TIMING`: immediate route is not Level Select, delayed route is Level Select, and delayed progress/persist/target facts satisfy the expected contract.
3. `PERSISTENCE_STATUS_MISMATCH`: delayed persist status is not `COMMITTED_AFTER_PERSISTED` or target is absent.
4. `BEST_TURNS_MISMATCH`: delayed Tutorial 0 is completed but best turns is absent or not 3.
5. `RUNTIME_PROGRESS_COMMIT_MISMATCH`: target exists with committed-after-persist status, but delayed Tutorial 0 completion or Tutorial 1 unlock is false.
6. `ACTIVE_SCREEN_CONTRACT_MISMATCH`: delayed active-screen count is not 1.
7. `ROUTE_FAILURE_STABLE`: delayed progress/persist/target facts satisfy the expected contract but delayed route remains non-Level-Select.
8. otherwise `UNRESOLVED_SUBCONDITION`.

The report must reproduce the complete bounded observation and classification without adding inferred causes.

## 12. Parser smoke

The parser smoke must preload the diagnostic script, AppRoot scene/script, and frozen store/adapter scripts without instantiating the diagnostic or performing I/O.

Print exactly once:

```text
TASK_0023ZF_TUTORIAL_PERSIST_DIAGNOSTIC_PARSER_SMOKE_PASS
```

Allow at most five parser-only corrections in new 0023ZF files.

## 13. Capture wrapper

The PowerShell wrapper must expose only:

```text
GuardProof
Execute
```

`GuardProof` runs the diagnostic without the guard and retains:

```text
guard_command.txt
guard_stdout.txt
guard_stderr.txt
guard_exit_code.txt
guard_process_before.txt
guard_process_after.txt
guard_production_metadata_before.txt
guard_production_metadata_after.txt
guard_test_root_exists_before.txt
guard_test_root_exists_after.txt
guard_inventory.txt
```

Require exit 2, guard marker once, observation/classification markers zero, stderr empty, unchanged protected state, and zero processes.

`Execute` must require attempt number 1, run only the exact diagnostic script with the exact guard, and retain:

```text
attempt_1_command.txt
attempt_1_stdout.txt
attempt_1_stderr.txt
attempt_1_exit_code.txt
attempt_1_process_before.txt
attempt_1_process_after.txt
attempt_1_production_metadata_before.txt
attempt_1_production_metadata_after.txt
attempt_1_test_root_exists_before.txt
attempt_1_test_root_exists_after.txt
attempt_1_fixture_exact_state_before.txt
attempt_1_fixture_exact_state_after.txt
attempt_1_worktree.patch
attempt_1_worktree_patch_sha256.txt
attempt_1_observation.txt
attempt_1_classification.txt
attempt_1_inventory.txt
```

Preserve nonzero output if the diagnostic crashes or aborts. Do not clean before all files and inventory are retained.

## 14. Exact cleanup

After evidence retention:

1. remove only the exact canonical target if present;
2. remove only the 24 known owned temp/transaction/recovery sibling paths if present;
3. non-recursively remove the exact fixture directory only after all known owned paths are absent;
4. do not enumerate the fixture directory or test root;
5. record exact post-cleanup absence, protected metadata, test-root existence, and process state.

If unknown residue prevents non-recursive directory removal, stop and report it; do not enumerate or recursively delete.

## 15. Acceptance and non-claims

A passing diagnostic gate requires:

- parser smoke pass;
- guard proof pass;
- one Execute process with exit 0, empty stderr, one observation marker, and one allowed classification marker;
- complete 17-file Execute inventory;
- exact owned cleanup;
- unchanged production metadata/test-root existence;
- zero Godot processes;
- all frozen regressions and hashes unchanged.

This task does not accept or repair AppRoot/harness behavior, does not resume the full matrix, and does not establish persistence correctness.

## 16. Authorized repository paths

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

Do not modify any other source, test, harness, runner, manifest, task, scene, project setting, formal data, asset, localization, export, release, or submission surface.

## 17. Evidence and Git

Use only:

```text
D:\Delayed_Self_Evidence\0023ZF_tutorial_persist_subcondition_diagnostic\
```

Create:

```text
docs/reports/0023ZF_TUTORIAL_PERSIST_SUBCONDITION_DIAGNOSTIC_REPORT.md
```

Require one commit:

```text
test: diagnose Delayed Self Tutorial 0 persistence subconditions
```

Finish with clean worktree, `HEAD == origin/main`, divergence `0/0`, exact diagnostic fixture absent, 0023W/0023ZE fixtures absent, unchanged production metadata, and no Godot process.

## 18. Terminal verdict

Return exactly one:

```text
TUTORIAL_ZERO_PERSIST_SUBCONDITION_DIAGNOSTIC_READY_FOR_GPT_REVIEW
BLOCKED_TUTORIAL_ZERO_PERSIST_SUBCONDITION_DIAGNOSTIC
```

Include commit SHA, bounded observation, classification, parser/guard/capture results, regression results, cleanup state, protected metadata, changed paths, evidence root, and final Git state.