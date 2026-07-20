# Task 0023ZM — Normalize full-matrix case/assertion cardinality without fixture execution

- Status: `READY`
- Gate: `PROTECTED PLAYER DATA / CASE-ASSERTION CARDINALITY NORMALIZATION + ZERO-FIXTURE REQUALIFICATION`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- GPT adjudication: `docs/reports/0023ZJ_GPT_ASSERTION_CASE_CARDINALITY_ADJUDICATION.md`
- Required checkpoint: `31cc1f58a106abc61f618d199aac8b69bee6dde7`
- Accepted harness checkpoint to revise: `413727fc804355c00f0900d98e668e8e69b4876b`
- Future execution task: `0023ZN`
- Future fixture ID: `task_0023zn_app_root_profile_session`
- Fixture status: **inert constants only; no fixture check or operation is authorized**

## 1. Objective

Normalize the canonical full-matrix metadata so unique case IDs and runtime assertion invocations are both exactly 42, then retarget the future execution contract to Task 0023ZN and requalify the artifacts without fixture execution.

The accepted root cause is:

```text
DUPLICATE_CASE_ID_CARDINALITY_MISMATCH
```

Task 0023ZJ Attempt 1 passed all 18 stages and emitted 42 successful assertion invocations. The manifest listed 41 unique case IDs because `single_active_screen_router` was reused by both `fresh_reload` and `router_contract`.

This task may establish only:

```text
42 unique case IDs
+ expected_assertion_count = 42
+ one case ID per behavior assertion
+ internal count consistency
+ retargeting to Task 0023ZN
+ parser/static/guard/Qualification evidence
+ zero fixture execution
```

It must not modify product source or execute the full matrix.

## 2. Task-file acquisition and startup

There is no pre-fetch evidence requirement.

If this task file is absent locally, one normal `git fetch` is allowed to obtain published task/document commits. After the task is readable and before edits or Godot/PowerShell validation:

1. require absolute root `D:\Delayed_Self`, branch `main`, expected origin, and no Git operation in progress;
2. require a clean tracked/untracked worktree and no staged changes;
3. fetch and fast-forward only;
4. require `HEAD == origin/main` and ancestry of `31cc1f58a106abc61f618d199aac8b69bee6dde7`;
5. require ancestry of accepted harness checkpoint `413727fc804355c00f0900d98e668e8e69b4876b`;
6. read the complete 0023ZL GPT acceptance, 0023ZJ blocker report, and GPT cardinality adjudication;
7. verify pinned Godot `4.7.stable.steam.5b4e0cb0f` or the documented equivalent;
8. require zero residual Godot processes.

Stop on divergence, conflict, unexpected local changes, missing checkpoints, remote mismatch, or process residue.

## 3. Closed scopes and fixture non-reuse

Do not execute, resume, or reuse fixtures from Tasks 0023ZE, 0023ZF, 0023ZH, or 0023ZJ.

Do not reuse:

```text
task_0023ze_app_root_profile_session
task_0023zf_tutorial_persist_diagnostic
task_0023zh_app_root_profile_session
task_0023zj_app_root_profile_session
```

Tasks 0023Y, 0023Z, 0023ZA, and 0023ZB remain historical closed scopes.

## 4. Protected-data and absolute zero-fixture boundary

Before and after every Godot or PowerShell group, record only production Profile non-content metadata:

```text
exists = true
Length = 473
LastWriteTimeUtc = 2026-07-19T08:15:02.2089459Z
```

Do not open, read, parse, hash, copy, rename, back up, delete, reset, repair, compare, or write production Profile content.

For `user://delayed_self_test_profiles/`, record only whether the root exists. Do not enumerate or inspect its contents.

The future contract is:

```text
future_task = 0023ZN
fixture_id = task_0023zn_app_root_profile_session
canonical_profile_path = user://delayed_self_test_profiles/task_0023zn_app_root_profile_session/delayed_self_profile.json
execution_guard = --task-0023zn-fixture-execution
```

These values may appear only as inert constants in this task. Do not:

- call `build_test_profile_path` for the 0023ZN ID;
- globalize, test, or inspect the future fixture path;
- check the fixture directory, target, or owned siblings;
- pass the 0023ZN guard;
- run runner `Execute`;
- enter a successfully configured AppRoot into the tree;
- perform configured Profile load/persist/reset/recovery behavior.

Any fixture operation or production metadata change is an immediate stop with no implementation commit.

## 5. Frozen authorities

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

AppRoot, store, adapter, MemoryProgress ordering, Gameplay behavior, router behavior, product data, and formal levels remain frozen.

## 6. Authorized canonical harness revisions

Only these five existing artifacts may change:

```text
tests/app/task_0023zd_app_root_profile_session_full_matrix.gd
tests/app/task_0023zd_full_matrix_parser_smoke.gd
tests/app/task_0023zd_full_matrix_harness_validator.gd
tests/app/task_0023zd_full_matrix_manifest.json
tests/app/task_0023zd_capture_profile_session.ps1
```

Do not rename them. Authorized report/current documentation paths are listed in Section 15.

## 7. Mandatory case-ID normalization

### 7.1 Split the duplicate case ID

In `_stage_fresh_reload`, change only the single-screen assertion case ID from:

```text
single_active_screen_router
```

to:

```text
fresh_reload_single_active_screen
```

Keep the condition and bounded label semantically unchanged.

Retain `single_active_screen_router` only in `_stage_router_contract`.

Do not remove, merge, weaken, or otherwise change either assertion.

### 7.2 Manifest cardinality

Update the manifest to:

```text
schema_version = 2
expected_assertion_count = 42
case_ids = 42 unique values
```

Insert:

```text
fresh_reload_single_active_screen
```

immediately after `fresh_reload_progress` and before `single_active_screen_router`.

Preserve all existing stages, failure stages, evidence inventories, and disclosure categories.

### 7.3 Behavior count contract

Add a typed constant:

```gdscript
const EXPECTED_ASSERTION_COUNT: int = 42
```

After all 18 stages pass and before printing the assertion count/final pass marker, require `assertions == EXPECTED_ASSERTION_COUNT` without calling `_expect_case` or incrementing `assertions`.

On mismatch, print exactly one bounded abort marker in the existing protocol and exit nonzero without printing the final pass marker.

The behavior must still print:

```text
TASK_0023ZN_ASSERTIONS=42
TASK_0023ZN_APP_ROOT_PROFILE_SESSION_FULL_MATRIX_PASS
```

only after exact count consistency.

## 8. Retarget the future execution contract

Update all five canonical artifacts consistently to:

```text
future_task = 0023ZN
fixture_id = task_0023zn_app_root_profile_session
canonical_profile_path = user://delayed_self_test_profiles/task_0023zn_app_root_profile_session/delayed_self_profile.json
execution_guard = --task-0023zn-fixture-execution
```

Behavior markers must use `TASK_0023ZN_`.

Task-owned validation markers must be:

```text
TASK_0023ZM_FULL_MATRIX_PARSER_SMOKE_PASS
TASK_0023ZM_VALIDATOR_ASSERTIONS=<count>
TASK_0023ZM_CASE_CARDINALITY_VALIDATOR_PASS
TASK_0023ZM_CAPTURE_QUALIFICATION_PASS
```

No executable harness artifact may retain 0023ZJ/0023ZH/0023ZE fixture, guard, or behavior-protocol contracts after normalization. Historical reports may retain them.

## 9. Static validator reinforcement

The validator must prove at minimum:

1. manifest schema version 2 and exact top-level keys including `expected_assertion_count`;
2. exactly 18 ordered stages;
3. exactly 42 unique case IDs;
4. `expected_assertion_count == 42`;
5. `fresh_reload_single_active_screen` occurs in the fresh-reload assertion;
6. `single_active_screen_router` occurs only in the router-contract assertion;
7. every manifest case ID occurs exactly once as a quoted case string in the behavior source;
8. no case string is duplicated or absent;
9. the behavior defines `EXPECTED_ASSERTION_COUNT: int = 42`;
10. the count-consistency guard occurs after all stage runners and before the assertion/final-pass markers;
11. the guard does not call `_expect_case` and does not increment assertions;
12. exact Task 0023ZN task/fixture/path/guard and marker values;
13. absence of closed 0023ZJ/0023ZH/0023ZE executable contracts;
14. all existing order-repair, cleanup, no-enumeration, portable SHA-256, fail-closed 17-file finalization, AppRoot-ordering, evidence, disclosure, and frozen-hash checks remain active.

Do not weaken or delete an existing validator assertion merely to obtain a pass.

Record the exact final validator assertion count in the report.

## 10. Parser, no-guard, and Qualification gates

Run the revised parser smoke after the first complete draft and again from a final fresh Godot process.

Run the behavior script once without the 0023ZN guard. Require:

```text
Godot exit = 2
TASK_0023ZN_EXECUTION_GUARD_BLOCKED count = 1
TASK_0023ZN_BEHAVIOR_PROCESS_STARTED count = 0
stage/assertion/final-pass markers = 0
stderr empty
production metadata unchanged
test-root existence unchanged
worktree unchanged
Godot process before/after = 0 / 0
```

Run two consecutive runner `Qualify` commands into separate evidence directories. Each must retain 11/11 files and prove:

```text
ExecutionGuardPassed=False
ParserMarkerCount=1
PortableSha256Passed=True
QualificationPassed=True
exit 0
stderr empty
protected state unchanged
Godot process before/after = 0 / 0
```

Audit commands and require:

```text
Qualify commands = 2
Execute commands = 0
guard-passing commands = 0
future-fixture commands = 0
full behavior executions = 0
```

## 11. Mandatory frozen regressions

Before edits and after all validation, run from fresh processes:

```text
0023R = 123 assertions / 4 positive / 39 negative
0023T = compile marker + 34 assertions
0023V = compile marker + 28 assertions
0023W = compile marker + 68 assertions
0023X = compile marker + 31 assertions
0023ZC = parser marker + compile contract 17 assertions
0023ZF = parser marker only
```

Every process must exit 0, have empty stderr, print each required marker exactly once, preserve protected state, leave the 0023W fixture absent, and leave zero Godot processes.

Do not run aggregate or `tests/run_all.gd`.

## 12. Final audits

Before documentation closeout require:

- PowerShell parser errors = 0;
- unsafe dynamic `:=` occurrences = 0;
- schema/stage/case/assertion cardinality = `2 / 18 / 42 / 42`;
- no duplicate case ID in behavior or manifest;
- no product/prerequisite/diagnostic source diff;
- no unauthorized changed path;
- no `project.godot`, `.gd.uid`, or `.godot/` pollution;
- production metadata unchanged;
- test-root existence unchanged without enumeration;
- historical fixtures absent where exact checks are already authorized by their accepted regression tasks;
- no Task 0023ZN fixture check or operation;
- no residual Godot process.

## 13. Evidence root

Use only:

```text
D:\Delayed_Self_Evidence\0023ZM_assertion_case_cardinality_normalization\
```

Retain startup facts, protected-state snapshots, pre/post regressions, parser ledger, validator output, no-guard proof, two Qualification inventories, command audit, changed-path audit, frozen hashes, and final Git state.

## 14. Required report and commit

Create:

```text
docs/reports/0023ZM_ASSERTION_CASE_CARDINALITY_NORMALIZATION_REPORT.md
```

The report must state:

- the duplicate case-ID root cause;
- the exact renamed fresh-reload case;
- manifest schema/case/assertion counts;
- Task 0023ZN contract;
- parser, validator, guard, and Qualification results;
- frozen regressions and protected-state facts;
- zero Execute/full behavior/fixture counts;
- explicit non-claims.

Commit message:

```text
test: normalize Delayed Self full-matrix assertion cardinality
```

## 15. Authorized repository paths

```text
tests/app/task_0023zd_app_root_profile_session_full_matrix.gd
tests/app/task_0023zd_full_matrix_parser_smoke.gd
tests/app/task_0023zd_full_matrix_harness_validator.gd
tests/app/task_0023zd_full_matrix_manifest.json
tests/app/task_0023zd_capture_profile_session.ps1
docs/reports/0023ZM_ASSERTION_CASE_CARDINALITY_NORMALIZATION_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/production/COMPLETE_FLOW_PRODUCTION_CLOSURE_PLAN_CURRENT.md
```

Do not modify any other repository path.

## 16. Git closeout

Stage authorized paths explicitly. Run `git diff --cached --check`. Fetch and stop on remote drift. Push normally.

Finish with:

```text
clean tracked/untracked worktree
HEAD == origin/main
divergence 0/0
zero Godot process
production metadata unchanged
test-root existence unchanged
no Task 0023ZN fixture operation
all frozen product/prerequisite paths unchanged
```

## 17. Terminal verdict and non-claims

Return exactly one:

```text
APP_ROOT_PROFILE_SESSION_ASSERTION_CARDINALITY_NORMALIZATION_READY_FOR_GPT_REVIEW
BLOCKED_APP_ROOT_PROFILE_SESSION_ASSERTION_CARDINALITY_NORMALIZATION
```

A passing verdict establishes only that the case/assertion metadata mismatch is normalized and the retargeted harness is parsed, statically validated, guard-proven, and zero-I/O requalified. It does not establish a second successful full-matrix attempt, production persistence, aggregate coverage, build/export/RC readiness, release, upload, or festival submission readiness.
