# Task 0023ZE — Execute the accepted AppRoot Profile-session full matrix twice

- Status: `READY`
- Gate: `PROTECTED PLAYER DATA / FIXED-FIXTURE APPROOT FULL-MATRIX EXECUTION`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- GPT prerequisite acceptance: `docs/reports/0023ZD_GPT_APP_ROOT_PROFILE_SESSION_FULL_MATRIX_HARNESS_ACCEPTANCE.md`
- Required checkpoint: `3e205044f87120117b6e2237595404ec1ad03b91`
- Fixed task-owned fixture ID: `task_0023ze_app_root_profile_session`
- Canonical target: `user://delayed_self_test_profiles/task_0023ze_app_root_profile_session/delayed_self_profile.json`

## 1. Objective

Execute the frozen Task 0023ZD full-matrix behavior harness against exactly the reserved test fixture and establish two consecutive complete clean-fixture passes with complete retained process evidence.

This task may establish only the configured **test-profile** AppRoot behavior:

```text
validated canonical fixture path
→ configured Task 0023W store load/recovery
→ Task 0023X adapter hydration
→ real Gameplay completion
→ persistence before runtime commit
→ fresh AppRoot reload
→ NO_CHANGE
→ transactional failure rollback
→ recovery preservation/failure
→ exact public progress shape/router behavior
→ exact owned-fixture cleanup
```

No product or harness source may change. This task does not activate or access the production Profile content and does not make persistence the default product behavior.

## 2. Frozen authorities

Freeze every product and harness file, including:

```text
scripts/app/app_root.gd
scripts/app/profile_codec.gd
scripts/app/local_profile.gd
scripts/app/profile_progress_adapter.gd
scripts/app/memory_progress.gd
all existing 0023R–0023ZC tests
tests/app/task_0023zd_app_root_profile_session_full_matrix.gd
tests/app/task_0023zd_full_matrix_parser_smoke.gd
tests/app/task_0023zd_full_matrix_harness_validator.gd
tests/app/task_0023zd_full_matrix_manifest.json
tests/app/task_0023zd_capture_profile_session.ps1
formal catalog/level data
Simulation/solver/schema/canonical state
Gameplay/Help/Timeline/Level Select/final acknowledgment
scenes/project.godot
```

Do not edit any source, harness, test, runner, manifest, scene, project setting, formal data, asset, or localization file.

Do not resume Tasks 0023Y, 0023Z, 0023ZA, or 0023ZB. Task 0023ZC and Task 0023ZD are accepted and frozen.

## 3. Startup and remote gate

Before any Godot, PowerShell runner, fixture check, or edit:

1. require absolute root `D:\Delayed_Self`, branch `main`, expected origin, and clean tracked/untracked worktree;
2. run all startup Git facts required by `AGENTS.md`;
3. fetch and fast-forward only;
4. require `HEAD == origin/main` and ancestry of `3e205044f87120117b6e2237595404ec1ad03b91`;
5. read the complete 0023W/0023X/0023ZC/0023ZD GPT acceptance reports and the 0023ZD implementation report;
6. verify pinned Godot `4.7.stable.steam.5b4e0cb0f` or the exact documented equivalent;
7. require no residual Godot process;
8. require the accepted 0023ZD validator to report all frozen hashes unchanged.

Stop on divergence, conflict, unexpected worktree content, remote mismatch, missing checkpoint, hash drift, or Godot process residue.

## 4. Protected production and test-root boundary

Before and after every Godot or runner process, record only production Profile non-content metadata:

```text
exists = true
Length = 473
LastWriteTimeUtc = 2026-07-19T08:15:02.2089459Z
```

Do not open, read, parse, hash, copy, rename, back up, delete, reset, repair, compare, or write production Profile content.

For `user://delayed_self_test_profiles/`, record only whether the root exists. Do not enumerate, inspect, clean, or list unrelated fixture contents.

Only the exact Task 0023ZE fixture and frozen owned filenames may be checked or operated:

```text
user://delayed_self_test_profiles/task_0023ze_app_root_profile_session/
delayed_self_profile.json
.delayed_self_0023w_temp_0.json ... _7.json
.delayed_self_0023w_transaction_0.json ... _7.json
.delayed_self_0023w_recovery_0.json ... _7.json
```

No other test-root path may be opened, inspected, renamed, copied, deleted, or enumerated.

Any production metadata change, production-content access, test-root enumeration, unrelated fixture access, or unexpected path operation is an immediate safety stop.

## 5. Evidence root

Use only:

```text
D:\Delayed_Self_Evidence\0023ZE_app_root_profile_session_full_matrix_execution\
```

Use these subdirectories:

```text
guard_check\
qualification_pre\
attempts\
qualification_post\
final_regressions\
```

Do not put external evidence files into the repository.

## 6. Mandatory pre-execution regressions

Before checking the exact future fixture, rerun:

```text
0023R = 123 assertions / 4 positive / 39 negative
0023T = compile marker + 34 assertions
0023V = compile marker + 28 assertions
0023W = compile marker + 68 assertions
0023X = compile marker + 31 assertions
0023ZC parser marker + compile contract 17 assertions
0023ZD parser marker + static validator 251 assertions
```

Every command must exit 0, print its required marker exactly once, and have empty stderr. Require the 0023W fixture absent after its own cleanup, unchanged production metadata/test-root existence, and no Godot process.

Do not run `tests/run_all.gd` or aggregate.

## 7. No-guard execution boundary proof

Before any exact Task 0023ZE fixture check, run the frozen full-matrix behavior script **without** the execution guard through independently captured stdout/stderr/exit-code/process/metadata/test-root files under `guard_check\`.

The command must be exactly equivalent to:

```text
godot --headless --path D:\Delayed_Self --script res://tests/app/task_0023zd_app_root_profile_session_full_matrix.gd
```

Require:

```text
exit code = 2
stdout contains TASK_0023ZD_EXECUTION_GUARD_BLOCKED exactly once
stderr empty
no TASK_0023ZE_BEHAVIOR_PROCESS_STARTED marker
production metadata unchanged
test-root existence unchanged
Godot process count before/after = 0
worktree unchanged
```

This proof must not check or operate the Task 0023ZE fixture. Any different result is an immediate blocker with no Execute run.

## 8. Runner qualification before fixture execution

Run the frozen runner in `Qualify` mode using `qualification_pre\` as its evidence root:

```powershell
& tests/app/task_0023zd_capture_profile_session.ps1 `
  -Mode Qualify `
  -EvidenceRoot <qualification_pre>
```

Require the complete accepted 11-file inventory, parser marker exactly once, exit 0, empty stderr, `ExecutionGuardPassed=False`, unchanged production metadata/test-root existence, and zero Godot processes before/after.

The qualification command must not pass the execution guard or check the fixture.

If qualification fails or its inventory is incomplete, stop before fixture execution with `DIAGNOSTIC_CAPTURE_INCOMPLETE`.

## 9. Exact fixture freshness gate

Only after Sections 6–8 pass, check whether the exact directory exists:

```text
user://delayed_self_test_profiles/task_0023ze_app_root_profile_session/
```

Do not enumerate the test root or the directory.

If the exact fixture directory already exists, stop without opening, enumerating, inspecting, deleting, or cleaning it. Report `PREEXISTING_FIXED_FIXTURE`.

Record only:

```text
FixtureDirectoryExists=False
TargetExists=False
Owned temp/transaction/recovery paths all False
```

using the frozen exact owned-path list.

## 10. Execute Attempt 1

Require a clean repository worktree and no edits since startup. Run the frozen runner exactly in Execute mode:

```powershell
& tests/app/task_0023zd_capture_profile_session.ps1 `
  -Mode Execute `
  -AttemptNumber 1 `
  -ScriptPath res://tests/app/task_0023zd_app_root_profile_session_full_matrix.gd `
  -EvidenceRoot <attempts>
```

Do not run the behavior script directly with the guard. Only the accepted runner may supply the guard.

Immediately after the runner returns and before any edit, cleanup, rerun, or second attempt, require all 17 accepted attempt files:

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
attempt_1_stage_summary.txt
attempt_1_classification.txt
attempt_1_inventory.txt
```

### 10.1 Attempt 1 acceptance audit

Create externally:

```text
attempt_1_acceptance_audit.txt
```

Require all of the following:

```text
runner classification = PASS_CANDIDATE
exit code = 0
stderr file exists and is empty
TASK_0023ZE_BEHAVIOR_PROCESS_STARTED exactly once
all 18 STAGE_BEGIN markers exactly once in manifest order
all 18 matching STAGE_PASS markers exactly once in manifest order
no ASSERT_FAIL marker
no ABORT marker
TASK_0023ZE_ASSERTIONS=41 exactly once
TASK_0023ZE_APP_ROOT_PROFILE_SESSION_FULL_MATRIX_PASS exactly once
process before/after = Count=0
production metadata before = after = accepted baseline
test-root existence before = after
fixture state before and after show directory/target/all owned paths absent
worktree patch exists, is empty, and its SHA-256 record is valid
inventory lists all 17 files and reports InventoryComplete=True
```

The acceptance audit must record each check as `True` or `False`, the exact stage sequence, assertion count, marker counts, and final result:

```text
PASS_COMPLETE_MATRIX
```

Any missing evidence, nonzero exit, stderr content, marker mismatch, assertion mismatch, residue, metadata drift, process residue, or invalid patch hash stops the task before Attempt 2.

## 11. Failure handling and exact emergency cleanup

If Attempt 1 or Attempt 2 is not `PASS_COMPLETE_MATRIX`:

1. preserve all runner evidence and acceptance-audit output before cleanup;
2. do not edit product or harness source;
3. classify using one of:

```text
ASSERTION_FAILURE
CONTROLLED_ABORT
UNCLASSIFIED_NONPASS
DIAGNOSTIC_CAPTURE_INCOMPLETE
PLAYER_DATA_SAFETY_FAULT
FIXTURE_RESIDUE
FROZEN_FILE_DRIFT
```

4. after evidence preservation, an emergency cleanup may target only the exact canonical target and the frozen 24 owned sibling paths;
5. remove the exact fixture directory only with a non-recursive empty-directory removal after all known owned files are absent;
6. do not enumerate the fixture or test root;
7. if the exact directory cannot be removed non-recursively, stop and report unknown residue without deleting anything else;
8. record emergency-cleanup before/after exact-state files and production metadata;
9. create a docs-only blocker report and do not run another attempt.

No correction, assertion weakening, harness edit, AppRoot edit, rerun after failure, or speculative repair is allowed in Task 0023ZE.

## 12. Execute Attempt 2

Attempt 2 is allowed only if Attempt 1 is `PASS_COMPLETE_MATRIX`, the exact fixture is absent, the repository remains unedited and clean, production metadata/test-root existence are unchanged, frozen hashes still match, and no Godot process remains.

Run:

```powershell
& tests/app/task_0023zd_capture_profile_session.ps1 `
  -Mode Execute `
  -AttemptNumber 2 `
  -ScriptPath res://tests/app/task_0023zd_app_root_profile_session_full_matrix.gd `
  -EvidenceRoot <attempts>
```

Require the same complete 17-file inventory and create:

```text
attempt_2_acceptance_audit.txt
```

Apply the exact Attempt 1 acceptance audit. The required final result is again:

```text
PASS_COMPLETE_MATRIX
```

There must be no repository edit, source modification, runner modification, harness modification, or cleanup intervention between the two passes.

## 13. Two-pass acceptance condition

Task 0023ZE may pass only with:

```text
Attempt 1 = PASS_COMPLETE_MATRIX
Attempt 2 = PASS_COMPLETE_MATRIX
```

Both attempts must originate from separately clean, absent fixture states and end with the exact fixture directory, target, and all 24 owned sibling paths absent.

Write externally:

```text
two_pass_summary.txt
```

It must record:

```text
attempt_1=PASS_COMPLETE_MATRIX
attempt_2=PASS_COMPLETE_MATRIX
consecutive_without_edits=True
fixture_clean_before_after_each=True
production_metadata_unchanged=True
test_root_existence_unchanged=True
frozen_hashes_unchanged=True
residual_godot_processes=0
```

## 14. Post-execution qualification and regressions

After the second clean pass:

1. rerun the frozen runner in `Qualify` mode using `qualification_post\`;
2. rerun 0023ZD parser smoke and 251-assertion static validator;
3. rerun 0023R/0023T/0023V/0023W/0023X/0023ZC;
4. require all final commands exit 0, empty stderr, and marker exactly once;
5. require all frozen hashes unchanged;
6. require production metadata/test-root existence unchanged;
7. require the 0023W and 0023ZE fixtures absent;
8. require no residual Godot process;
9. require a clean worktree before documentation edits.

Do not run aggregate or `tests/run_all.gd`.

## 15. Passing report and repository changes

On two-pass success, create only:

```text
docs/reports/0023ZE_APP_ROOT_PROFILE_SESSION_FULL_MATRIX_EXECUTION_REPORT.md
```

Update only authorized CURRENT/project documents as needed.

The report must include:

- both attempt classifications and complete audit results;
- 18-stage ordered marker counts for each attempt;
- assertion count 41 for each attempt;
- complete 17-file inventory confirmation for each attempt;
- qualification-pre and qualification-post results;
- all prerequisite/post regressions;
- frozen hash result;
- production metadata/test-root boundary;
- exact fixture cleanup result;
- no-edit-between-passes statement;
- evidence root;
- changed paths and final Git state;
- explicit non-claims.

Require one docs-only commit:

```text
docs: record Delayed Self AppRoot full-matrix execution
```

## 16. Blocked report

On any blocker, create only:

```text
docs/reports/0023ZE_APP_ROOT_PROFILE_SESSION_FULL_MATRIX_BLOCKER_REPORT.md
```

Commit message:

```text
docs: classify Delayed Self AppRoot full-matrix execution blocker
```

The blocker report must identify the exact classification, last completed gate/stage, evidence inventory, cleanup outcome, production metadata, fixture state, frozen hashes, and non-claims.

Do not commit external evidence, source changes, harness changes, test changes, or failed fixture data.

## 17. Authorized repository paths

```text
docs/reports/0023ZE_APP_ROOT_PROFILE_SESSION_FULL_MATRIX_EXECUTION_REPORT.md
docs/reports/0023ZE_APP_ROOT_PROFILE_SESSION_FULL_MATRIX_BLOCKER_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/production/COMPLETE_FLOW_PRODUCTION_CLOSURE_PLAN_CURRENT.md
```

Do not modify any other repository path.

## 18. Git closeout

Before staging documentation:

1. require the repository worktree clean from all source/harness/test changes;
2. create only the authorized report/current-document edits;
3. stage authorized paths explicitly;
4. run `git diff --cached --check`;
5. fetch and stop on remote drift;
6. commit and push normally.

Finish with clean worktree, `HEAD == origin/main`, divergence `0/0`, no Godot process, unchanged production metadata/test-root existence, absent 0023W/0023ZE fixtures, and all frozen hashes unchanged.

## 19. Terminal verdict

Return exactly one:

```text
APP_ROOT_PROFILE_SESSION_FULL_MATRIX_EXECUTION_READY_FOR_GPT_REVIEW
BLOCKED_APP_ROOT_PROFILE_SESSION_EXECUTION_CLASSIFIED
BLOCKED_APP_ROOT_PROFILE_SESSION_EXECUTION_EVIDENCE_INCOMPLETE
```

Include the report commit SHA, guard proof, qualification results, both attempt classifications, ordered stage markers, assertion counts, inventory completeness, cleanup results, regressions, frozen hashes, protected metadata, evidence root, changed paths, and final Git state.

## 20. Non-claims

A passing Task 0023ZE establishes only configured **test-profile** AppRoot load/persist/reload/NO_CHANGE/failure/rollback/recovery/snapshot/router/cleanup behavior under the frozen fixture harness.

It does not authorize or establish production Profile access, default product persistence, production New Game/Continue/Reset UI, persistent settings, aggregate registration, localization, build/export, RC, release, upload, or festival submission readiness.