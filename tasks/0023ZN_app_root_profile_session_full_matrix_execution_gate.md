# Task 0023ZN — Execute the normalized AppRoot Profile-session full matrix twice

- Status: `READY`
- Gate: `PROTECTED PLAYER DATA / NORMALIZED FIXED-FIXTURE APPROOT FULL-MATRIX EXECUTION`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- GPT prerequisite acceptance: `docs/reports/0023ZM_GPT_ASSERTION_CASE_CARDINALITY_NORMALIZATION_ACCEPTANCE.md`
- Required checkpoint: `f57090341b32d76a0a6ce5bc467cec5808cfef49`
- Accepted harness implementation checkpoint: `d11e52d2fbdd5b9878182730673cca5d570aad87`
- Fixed task-owned fixture ID: `task_0023zn_app_root_profile_session`
- Canonical target: `user://delayed_self_test_profiles/task_0023zn_app_root_profile_session/delayed_self_profile.json`
- Execution guard: `--task-0023zn-fixture-execution`

## 1. Objective

Execute the accepted normalized canonical AppRoot/Profile harness against the exact Task 0023ZN fixture and determine whether the full configured-session matrix passes twice from separately clean fixture states.

The frozen path is:

```text
fresh exact 0023ZN fixture
→ guarded 18-stage / 42-case harness
→ configured AppRoot boot and hydration
→ real Tutorial-0 persistence and fresh reload
→ NO_CHANGE
→ transactional rollback failures
→ malformed / unknown-version recovery and recovery failure
→ public snapshots and router contract
→ exact-owned-path cleanup
→ protected-state verification
```

This is an execution/evidence gate only. No product, harness, runner, manifest, parser, validator, diagnostic, scene, formal-data, or task assertion repair is authorized.

## 2. Task acquisition and startup

There is no pre-fetch evidence requirement.

If this task file is absent locally, one normal `git fetch` is allowed to obtain the published task/document commits. After the task is readable and before any Godot, PowerShell validation, fixture check, or documentation edit:

1. require absolute root `D:\Delayed_Self`, branch `main`, expected origin, and no Git operation in progress;
2. require a clean tracked/untracked worktree and no staged changes;
3. fetch normally and fast-forward only;
4. require `HEAD == origin/main` and ancestry of `f57090341b32d76a0a6ce5bc467cec5808cfef49`;
5. require ancestry of harness checkpoint `d11e52d2fbdd5b9878182730673cca5d570aad87`;
6. read the complete 0023ZM GPT acceptance, 0023ZM implementation report, 0023ZJ blocker report, and current active/startup documents;
7. verify pinned Godot `4.7.stable.steam.5b4e0cb0f` or the documented equivalent;
8. require zero residual Godot processes.

Record Git blobs or SHA-256 values for every frozen product, prerequisite, diagnostic, and canonical harness artifact before execution. Stop on divergence, conflict, unexpected local changes, missing checkpoints, remote mismatch, or process residue.

## 3. Closed historical scopes

Do not execute, resume, edit, or reuse fixtures from Tasks 0023Y, 0023Z, 0023ZA, 0023ZB, 0023ZE, 0023ZF, 0023ZH, 0023ZI, 0023ZK, 0023ZL, 0023ZJ, or 0023ZM.

Do not reuse:

```text
task_0023ze_app_root_profile_session
task_0023zf_tutorial_persist_diagnostic
task_0023zh_app_root_profile_session
task_0023zj_app_root_profile_session
```

Task 0023ZM is accepted and frozen. Do not alter its normalized harness or 0023ZN contract.

## 4. Protected production and test-root boundary

Before and after every Godot or PowerShell group, record only production Profile non-content metadata:

```text
exists = true
Length = 473
LastWriteTimeUtc = 2026-07-19T08:15:02.2089459Z
```

Do not open, read, parse, hash, copy, rename, back up, delete, reset, repair, compare, or write production Profile content.

For `user://delayed_self_test_profiles/`, record only whether the root exists. Do not enumerate, list, inspect, clean, or modify unrelated fixtures.

For Task 0023ZN, only the exact fixture directory, canonical target, and these 24 known owned sibling paths may be checked or operated:

```text
.delayed_self_0023w_temp_0.json ... _7.json
.delayed_self_0023w_transaction_0.json ... _7.json
.delayed_self_0023w_recovery_0.json ... _7.json
```

Never enumerate the fixture directory. Exact path checks are allowed; directory listing is not. Any production metadata change, production-content access, test-root enumeration, unrelated-fixture operation, or unexpected non-owned file is an immediate safety stop.

## 5. Exact accepted execution artifacts

Use only these canonical artifacts as committed at `d11e52d2fbdd5b9878182730673cca5d570aad87`:

```text
tests/app/task_0023zd_app_root_profile_session_full_matrix.gd
tests/app/task_0023zd_full_matrix_parser_smoke.gd
tests/app/task_0023zd_full_matrix_harness_validator.gd
tests/app/task_0023zd_full_matrix_manifest.json
tests/app/task_0023zd_capture_profile_session.ps1
```

The fixed contract is:

```text
future_task = 0023ZN
fixture_id = task_0023zn_app_root_profile_session
canonical_profile_path = user://delayed_self_test_profiles/task_0023zn_app_root_profile_session/delayed_self_profile.json
execution_guard = --task-0023zn-fixture-execution
schema_version = 2
expected_assertion_count = 42
```

Do not copy, rename, regenerate, or replace these artifacts.

## 6. Frozen authorities

Do not modify:

```text
scripts/app/app_root.gd
scripts/app/profile_codec.gd
scripts/app/local_profile.gd
scripts/app/profile_progress_adapter.gd
scripts/app/memory_progress.gd
all existing 0023R–0023ZC tests
all 0023ZF diagnostic/parser/capture files
formal catalog and level data
Simulation / solver / schema / canonical state
Gameplay / Help / Timeline / Level Select / final acknowledgment
scenes / project.godot
```

All accepted path, codec, store, adapter, AppRoot ordering, sorted progress, 42-case mapping, count guard, rollback, recovery, router, cleanup, portable SHA-256, and fail-closed evidence-finalization contracts remain frozen. No source correction is permitted after any failure.

## 7. Mandatory pre-execution regressions

Before the first fixture check or runner `Execute`, run fresh processes for:

```text
0023R = 123 assertions / 4 positive / 39 negative
0023T = compile marker + 34 assertions
0023V = compile marker + 28 assertions
0023W = compile marker + 68 assertions
0023X = compile marker + 31 assertions
0023ZC = parser marker + compile contract 17 assertions
0023ZF = parser marker only
0023ZM parser = TASK_0023ZM_FULL_MATRIX_PARSER_SMOKE_PASS
0023ZM validator = TASK_0023ZM_VALIDATOR_ASSERTIONS=328 + TASK_0023ZM_CASE_CARDINALITY_VALIDATOR_PASS
```

Every process must exit 0, have empty stderr, print each required marker exactly once, preserve production metadata/test-root existence, leave the 0023W fixture absent, and leave zero Godot processes.

Do not run aggregate or `tests/run_all.gd`.

## 8. Mandatory no-guard proof

Before the first fixture check, run the exact full behavior script once without the 0023ZN guard in a separately captured process.

Require:

```text
Godot exit = 2
TASK_0023ZN_EXECUTION_GUARD_BLOCKED count = 1
TASK_0023ZN_BEHAVIOR_PROCESS_STARTED count = 0
TASK_0023ZN_STAGE_BEGIN count = 0
TASK_0023ZN_ASSERTIONS count = 0
TASK_0023ZN_APP_ROOT_PROFILE_SESSION_FULL_MATRIX_PASS count = 0
stderr empty
production metadata unchanged
test-root existence unchanged
worktree unchanged
Godot processes before/after = 0 / 0
```

The command must not include `--task-0023zn-fixture-execution`. Retain independent evidence.

## 9. Mandatory pre-Qualification

Run the accepted runner in `Qualify` mode once before Attempt 1 into:

```text
D:\Delayed_Self_Evidence\0023ZN_app_root_profile_session_full_matrix_execution\qualification_pre\
```

Require all 11 files, parser marker once, exit 0, empty stderr, `ExecutionGuardPassed=False`, `PortableSha256Passed=True`, unchanged production metadata/test-root existence, and zero Godot processes.

If Qualification fails, stop before fixture operation and create a docs-only evidence-incomplete blocker report.

## 10. Exact fixture freshness gate

After pre-Qualification, build the canonical virtual path only through the accepted path policy and require exact equality to the frozen target.

Before each Execute attempt, check only:

```text
exact fixture directory absent
canonical target absent
all 24 known owned siblings absent
```

Do not enumerate the test root or fixture directory. If any exact owned path already exists, stop without opening or deleting it.

Attempt 2 may begin only after Attempt 1 proves exact cleanup and the runner post-attempt state reports every owned path absent.

## 11. Attempt 1

Use only the accepted runner:

```powershell
-Mode Execute
-AttemptNumber 1
-ScriptPath res://tests/app/task_0023zd_app_root_profile_session_full_matrix.gd
```

Use evidence root:

```text
D:\Delayed_Self_Evidence\0023ZN_app_root_profile_session_full_matrix_execution\attempts\
```

The runner must append the exact 0023ZN guard. Do not invoke the behavior script directly with the guard.

Immediately after the process and before cleanup, edits, or report drafting, require the full canonical 17-file inventory for Attempt 1. Missing evidence is `DIAGNOSTIC_CAPTURE_INCOMPLETE` and an immediate stop.

## 12. Attempt acceptance audit

A runner `PASS_CANDIDATE` becomes task-level `PASS_COMPLETE_MATRIX` only if an external audit proves:

```text
exit code = 0
stderr length = 0
runner classification = PASS_CANDIDATE
behavior-process-start marker count = 1
18 TASK_0023ZN_STAGE_BEGIN markers exactly once in manifest order
18 TASK_0023ZN_STAGE_PASS markers exactly once in manifest order
assert-fail marker count = 0
abort marker count = 0
TASK_0023ZN_ASSERTIONS=42 exactly once
TASK_0023ZN_APP_ROOT_PROFILE_SESSION_FULL_MATRIX_PASS exactly once
17/17 inventory complete
worktree patch empty and SHA-256 valid
production metadata unchanged
test-root existence unchanged
process before/after zero
fixture directory absent after process
canonical target absent after process
all 24 owned siblings absent after process
```

Parse marker order from retained stdout/stage summary. Do not infer success from exit code alone.

If any condition fails, classify exactly one of:

```text
ASSERTION_FAILURE
CONTROLLED_ABORT
PROCESS_OR_RUNTIME_FAILURE
DIAGNOSTIC_CAPTURE_INCOMPLETE
PLAYER_DATA_SAFETY_FAULT
FROZEN_SOURCE_DRIFT
FIXTURE_RESIDUE
UNCLASSIFIED_NONPASS
```

Stop immediately. Do not repair or rerun.

## 13. Attempt 2

Attempt 2 is authorized only if Attempt 1 is externally audited as `PASS_COMPLETE_MATRIX`, the worktree is unchanged, no source/document edit occurred, protected state remains unchanged, no Godot process remains, and the exact fixture plus all owned paths are absent.

Run:

```powershell
-Mode Execute
-AttemptNumber 2
-ScriptPath res://tests/app/task_0023zd_app_root_profile_session_full_matrix.gd
```

Apply the identical 17-file inventory and external audit.

Acceptance requires:

```text
Attempt 1 = PASS_COMPLETE_MATRIX
Attempt 2 = PASS_COMPLETE_MATRIX
```

There must be no intervening edit, commit, source regeneration, assertion adjustment, or manual fixture manipulation between attempts.

## 14. Failure evidence and cleanup

On any nonpass:

1. preserve and audit all runner evidence before cleanup;
2. record the last passed stage, first failing stage, assertion/abort label if present, runner classification, process and protected-state facts;
3. retain the worktree patch and hash/sentinel;
4. do not modify source, harness, validator, runner, manifest, parser, or assertions;
5. inspect only the exact fixture directory, target, and 24 owned siblings;
6. after evidence preservation, delete only existing exact owned files;
7. remove the exact fixture directory non-recursively only after every known owned path is absent;
8. do not enumerate the fixture directory or test root;
9. verify protected state unchanged and zero Godot processes.

If an unexpected non-owned file prevents non-recursive removal, stop as `PLAYER_DATA_SAFETY_FAULT`; do not enumerate or delete it. Attempt 2 must not run after any Attempt 1 nonpass.

## 15. Post-execution validation

After two consecutive `PASS_COMPLETE_MATRIX` attempts:

1. run a fresh accepted runner `Qualify` into:

```text
D:\Delayed_Self_Evidence\0023ZN_app_root_profile_session_full_matrix_execution\qualification_post\
```

2. rerun the complete regression matrix from Section 7;
3. require validator remains 328 assertions;
4. require all frozen source and harness blobs/hashes match pre-execution values;
5. require no unauthorized changed path;
6. require 0023W, 0023ZE, 0023ZF, 0023ZH, 0023ZJ, and 0023ZN fixtures absent;
7. require production metadata/test-root existence unchanged and zero Godot processes;
8. require no `project.godot`, `.gd.uid`, or `.godot/` pollution.

Do not run aggregate or export.

## 16. Repository outputs

### Passing

Create:

```text
docs/reports/0023ZN_APP_ROOT_PROFILE_SESSION_FULL_MATRIX_EXECUTION_REPORT.md
```

Include both attempt audits, exact stage order, complete inventories, guard proof, pre/post Qualifications, regressions, cleanup/protected-state facts, frozen hash audit, and explicit non-claims.

Commit only authorized report/current documentation with:

```text
docs: record Delayed Self normalized full-matrix execution
```

### Blocked

Create only:

```text
docs/reports/0023ZN_APP_ROOT_PROFILE_SESSION_FULL_MATRIX_BLOCKER_REPORT.md
```

Commit message:

```text
docs: classify Delayed Self normalized full-matrix blocker
```

No failed source, harness, runner, parser, validator, manifest, fixture, or external evidence may be committed.

## 17. Authorized repository paths

```text
docs/reports/0023ZN_APP_ROOT_PROFILE_SESSION_FULL_MATRIX_EXECUTION_REPORT.md
docs/reports/0023ZN_APP_ROOT_PROFILE_SESSION_FULL_MATRIX_BLOCKER_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/production/COMPLETE_FLOW_PRODUCTION_CLOSURE_PLAN_CURRENT.md
```

Do not modify any other repository path.

## 18. Evidence root

Use only:

```text
D:\Delayed_Self_Evidence\0023ZN_app_root_profile_session_full_matrix_execution\
```

Retain startup facts, frozen hashes, guard proof, pre/post Qualifications, both 17-file attempts, external acceptance audits, exact cleanup audits, regressions, protected-state snapshots, command audit, and final Git/process state.

## 19. Git closeout

Stage authorized documentation paths explicitly. Run `git diff --cached --check`. Fetch and stop on remote drift. Push normally.

Finish with:

```text
clean tracked/untracked worktree
HEAD == origin/main
divergence 0/0
zero Godot processes
production metadata unchanged
test-root existence unchanged
all owned fixtures absent
all frozen source/harness paths unchanged
```

## 20. Terminal verdict and non-claims

Return exactly one:

```text
APP_ROOT_PROFILE_SESSION_FULL_MATRIX_EXECUTION_READY_FOR_GPT_REVIEW
BLOCKED_APP_ROOT_PROFILE_SESSION_EXECUTION_CLASSIFIED
BLOCKED_APP_ROOT_PROFILE_SESSION_EXECUTION_EVIDENCE_INCOMPLETE
```

A passing verdict establishes only that the frozen normalized test-only AppRoot/Profile matrix passed twice with complete evidence. It does not activate production Profile persistence, enable default product persistence, register aggregate coverage, implement menus/settings/localization, prove build/export/RC readiness, or authorize release, upload, or festival submission.
