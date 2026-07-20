# Task 0023ZK — Complete the existing cleanup/capture repair draft without fixture execution

- Status: `READY`
- Gate: `PROTECTED PLAYER DATA / CONTROLLED DIRTY-DRAFT CONTINUATION + CAPTURE FINALIZATION`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- GPT adjudication: `docs/reports/0023ZI_GPT_AUTHORIZED_DRAFT_FINALIZATION_INCOMPLETE_ADJUDICATION.md`
- Required remote checkpoint: `85887850ee45e4c76c0f3e555246e5944e35497f`
- Required pre-fetch local draft baseline: `fb8f2acc7d021bb7f01febb358e548f3b26b07bf`
- Future execution task: `0023ZJ`
- Future fixture ID: `task_0023zj_app_root_profile_session`
- Fixture status: **inert constants only; no fixture check or operation is authorized**

## 1. Objective

Continue the five existing uncommitted Task 0023ZI harness drafts and finish the two incomplete deliverables:

```text
portable and fail-closed canonical 17-file runner finalization
+ complete static validator reinforcement
```

Then validate the entire repaired five-file harness set from its final source state through parser, validator, no-guard proof, two final zero-I/O Qualifications, frozen regressions, and protected-state audits.

This task must not discard, reset, overwrite, stash, or silently replace the existing authorized drafts. It must not execute the full matrix or touch any fixture.

## 2. Special controlled dirty-worktree startup

This task intentionally begins with an authorized dirty worktree. Do not apply the ordinary clean-worktree requirement until the draft has been captured and the new remote task commits have been fast-forwarded.

Before `git fetch`, require:

```text
absolute root = D:\Delayed_Self
branch = main
local HEAD = fb8f2acc7d021bb7f01febb358e548f3b26b07bf
no merge/rebase/cherry-pick in progress
no staged changes
the only modified or untracked repository paths are exactly the five canonical harness artifacts
```

The only permitted dirty paths are:

```text
tests/app/task_0023zd_app_root_profile_session_full_matrix.gd
tests/app/task_0023zd_full_matrix_parser_smoke.gd
tests/app/task_0023zd_full_matrix_harness_validator.gd
tests/app/task_0023zd_full_matrix_manifest.json
tests/app/task_0023zd_capture_profile_session.ps1
```

All five need not be modified, but no sixth path may be dirty.

Stop without changing anything if:

- local HEAD differs;
- any change is staged;
- any unauthorized path is dirty/untracked;
- an operation is in progress;
- the local branch is not `main`;
- origin is unexpected.

Do not delete, reset, restore, stash, clean, or overwrite the draft on a startup failure.

## 3. Mandatory pre-existing draft capture

Before fetching the new task commits, retain under:

```text
D:\Delayed_Self_Evidence\0023ZK_cleanup_capture_repair_continuation\draft_intake\
```

at minimum:

```text
pre_fetch_head.txt
pre_fetch_status_porcelain_v2.txt
pre_fetch_dirty_paths.txt
pre_fetch_worktree_binary.patch
pre_fetch_worktree_patch_sha256.txt
pre_fetch_diff_stat.txt
pre_fetch_staged_diff.txt
pre_fetch_untracked_inventory.txt
```

Requirements:

1. `pre_fetch_staged_diff.txt` must be empty;
2. dirty paths must be a subset of the exact five paths above;
3. capture the complete binary patch with `git diff --binary --no-ext-diff`;
4. compute SHA-256 using direct .NET cryptography or another already available deterministic method, not `Get-FileHash`;
5. do not open production Profile content or inspect any fixture;
6. do not include external evidence files in Git.

The intake patch is continuity evidence only, not an accepted implementation source.

## 4. Safe fast-forward with preserved draft

After intake capture:

1. `git fetch` normally;
2. require `origin/main` contains `85887850ee45e4c76c0f3e555246e5944e35497f`;
3. require the remote commits since the local baseline modify no canonical harness artifact;
4. fast-forward local `main` to `origin/main` without merge or rebase;
5. require the five-file draft remains present and byte-identical to its pre-fetch patch application;
6. recapture status and binary patch;
7. require no new dirty path appeared.

Stop without reset/stash/overwrite if fast-forward cannot preserve the draft cleanly.

After this successful fast-forward, the active implementation baseline is the new remote HEAD plus the captured five-file draft.

## 5. Protected-data and zero-fixture boundary

Before and after every Godot or PowerShell group, record only production Profile non-content metadata:

```text
exists = true
Length = 473
LastWriteTimeUtc = 2026-07-19T08:15:02.2089459Z
```

Do not open, read, parse, hash, copy, rename, back up, delete, reset, repair, compare, or write production Profile content.

For `user://delayed_self_test_profiles/`, record only whether the root exists. Do not enumerate or inspect its contents.

The Task 0023ZJ contract may appear only as inert source constants:

```text
future_task = 0023ZJ
fixture_id = task_0023zj_app_root_profile_session
canonical_profile_path = user://delayed_self_test_profiles/task_0023zj_app_root_profile_session/delayed_self_profile.json
execution_guard = --task-0023zj-fixture-execution
```

Do not:

- call `build_test_profile_path` for the 0023ZJ ID;
- globalize or test the future fixture path;
- check the fixture directory, target, or owned siblings;
- pass the 0023ZJ guard;
- run runner `Execute`;
- enter a successfully configured AppRoot into the tree;
- perform configured Profile load/persist/reset/recovery behavior.

Any fixture operation or production metadata change is an immediate stop with no implementation commit.

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
formal catalog/level data
Simulation/solver/schema/canonical state
Gameplay/Help/Timeline/Level Select/final acknowledgment
scenes/project.godot
```

AppRoot, store, adapter, MemoryProgress sorted snapshots, product routing, Gameplay behavior, and formal data remain frozen.

## 7. Authorized implementation paths

Only these five existing canonical harness artifacts may be edited:

```text
tests/app/task_0023zd_app_root_profile_session_full_matrix.gd
tests/app/task_0023zd_full_matrix_parser_smoke.gd
tests/app/task_0023zd_full_matrix_harness_validator.gd
tests/app/task_0023zd_full_matrix_manifest.json
tests/app/task_0023zd_capture_profile_session.ps1
```

They must remain canonical filenames and consistently target Task 0023ZJ.

Authorized reports/current documentation are listed in Section 18.

## 8. Preserve completed Task 0023ZI repair work

Before adding further edits, audit the existing draft and preserve any correct completed work, including where present:

- removal of runtime self-source inspection;
- exact-owned-path cleanup helper;
- absence of enumeration APIs in behavior source;
- 0023ZJ task/fixture/path/guard retargeting;
- `TASK_0023ZJ_*` behavior protocol;
- parser/validator/Qualification marker retargeting;
- direct .NET SHA-256 implementation;
- existing validator improvements.

Do not rewrite working portions merely for style. Do not weaken any original 18-stage/41-case behavior contract.

## 9. Required cleanup assertion final state

The behavior source must contain no runtime self-source read and none of these tokens:

```text
list_dir_begin
get_files_at
get_directories_at
get_file_as_string("res://tests/app/task_0023zd_app_root_profile_session_full_matrix.gd")
```

Keep the stable case ID:

```text
cleanup_no_test_root_enumeration
```

Its runtime condition must call a bounded exact-owned-path helper equivalent to:

```gdscript
func _cleanup_uses_exact_owned_paths_only() -> bool:
    if fixture_dir != CANONICAL_PROFILE_PATH.get_base_dir():
        return false
    if owned_paths.size() != 25 or _unique_string_count(owned_paths) != 25:
        return false
    if owned_paths[0] != CANONICAL_PROFILE_PATH:
        return false
    for owned_path: String in owned_paths:
        if owned_path != CANONICAL_PROFILE_PATH and owned_path.get_base_dir() != fixture_dir:
            return false
    return true
```

Preserve:

- exact 25-path inventory;
- unique paths;
- canonical target first;
- 24 bounded store siblings;
- exact file deletion only;
- non-recursive exact fixture-directory removal;
- final exact absence checks;
- no test-root or fixture-directory enumeration.

The case must not become unconditional, membership-only, size-only, or weaker.

## 10. Required portable SHA-256 final state

No executable runner path may contain or call:

```text
Get-FileHash
```

Use direct .NET SHA-256 through a helper such as `System.Security.Cryptography.SHA256` and `System.IO.File.OpenRead`.

The implementation must:

1. close/dispose stream and hash object in `finally` blocks;
2. return lowercase 64-character hexadecimal text on success;
3. return a bounded explicit failure result rather than throwing past finalization;
4. never hash production Profile content;
5. work in the same PowerShell invocation environment used by Qualifications.

Each final Qualification must prove the known SHA-256 of an empty task-owned evidence file:

```text
e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
```

## 11. Canonical 17-file finalization contract

For runner `Execute`, once the Godot process has been launched, the runner must attempt to finalize all 17 canonical files regardless of:

- Godot exit code;
- behavior assertion or abort;
- empty/nonempty stderr;
- patch capture failure;
- SHA-256 failure;
- stage-summary parsing failure;
- classification ambiguity.

The canonical files remain exactly:

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

Required post-process order:

```text
capture exit code
→ capture process/protected/test-root/fixture after-state
→ write stage summary or bounded unavailable marker
→ write initial classification
→ capture patch or create an empty/bounded failure patch artifact
→ compute portable SHA-256 or write HASH_UNAVAILABLE
→ write final classification
→ write inventory last
→ assert 17/17 presence
→ return pass/nonpass exit
```

Use `try`/`catch`/`finally` or an equivalent fail-closed structure so a hash exception cannot prevent post-state, classification, or inventory files from being written.

### 11.1 Bounded failure contents

If a step fails, retain the canonical file with a bounded status rather than omitting it. Examples:

```text
HASH_UNAVAILABLE
PATCH_CAPTURE_FAILED
STAGE_SUMMARY_UNAVAILABLE
POST_STATE_UNAVAILABLE
```

Do not print raw filesystem errors, unrestricted exception objects, paths outside bounded task constants, or production content.

### 11.2 Final classification priority

The final classification must use a deterministic priority such as:

```text
PLAYER_DATA_SAFETY_FAULT
DIAGNOSTIC_CAPTURE_INCOMPLETE
CONTROLLED_ABORT
ASSERTION_FAILURE
PROCESS_OR_RUNTIME_FAILURE
PASS_CANDIDATE
UNCLASSIFIED_NONPASS
```

Any missing/unreadable canonical file, unavailable patch hash, unavailable required post-state, or incomplete inventory must force `DIAGNOSTIC_CAPTURE_INCOMPLETE` even if Godot printed a pass marker.

`PASS_CANDIDATE` requires exit 0, empty stderr, exactly one success marker, valid 64-character patch hash, and complete 17-file inventory.

## 12. Non-executing finalization proof

Because runner `Execute` is forbidden, the strengthened validator must statically prove the 17-file finalization structure.

It must verify at minimum:

1. all 17 filenames remain in manifest and runner;
2. `Get-FileHash` is absent;
3. direct .NET SHA-256 helper exists and disposes resources;
4. known empty-file SHA-256 qualification logic exists;
5. post-state files are written before hash calculation;
6. stage summary and initial classification are written before hash calculation;
7. final classification is written after hash status is known;
8. inventory is written last;
9. 17/17 presence is checked after inventory creation;
10. hash failure produces a canonical hash file and forces incomplete classification;
11. post-state/finalization logic is inside a fail-closed `try`/`finally` or equivalent structure;
12. no executable 0023ZH or older fixture/guard/protocol token remains;
13. all five artifacts use the exact 0023ZJ contract.

## 13. Preserve matrix contracts

The manifest and behavior must preserve exactly:

```text
schema version 1
18 ordered stages
41 unique stable case IDs
6 accepted failure stages
11 Qualification evidence files
17 Execute evidence files
7 forbidden disclosure categories
```

Do not add, remove, rename, reorder, merge, skip, or weaken stages/cases.

Preserve the sorted exact Tutorial-0/Tutorial-1 unlocked-array repair from Task 0023ZG.

## 14. Mandatory final validator

Finish the validator before final evidence runs.

It must retain all prior accepted checks and add complete coverage for Sections 9–13. It must validate frozen product/prerequisite/diagnostic hashes.

Print:

```text
TASK_0023ZK_VALIDATOR_ASSERTIONS=<exact_count>
TASK_0023ZK_CLEANUP_CAPTURE_VALIDATOR_PASS
```

Require exit 0, empty stderr, and each marker exactly once. Record the exact final assertion count in the report.

Do not count the earlier draft validator run as final evidence.

## 15. Mandatory final parser and no-guard proof

After the source is complete:

1. run parser smoke from a fresh Godot process;
2. run the complete behavior script once without the 0023ZJ guard;
3. run parser smoke again from a final fresh process.

Required revised markers:

```text
TASK_0023ZK_FULL_MATRIX_PARSER_SMOKE_PASS
TASK_0023ZJ_EXECUTION_GUARD_BLOCKED
```

No-guard proof must show:

```text
Godot exit = 2
guard marker = 1
behavior-process-start = 0
stage-begin = 0
assertion/final-pass markers = 0
stderr empty
production metadata unchanged
test-root existence unchanged
worktree unchanged by execution
Godot processes before/after = 0 / 0
```

Do not pass the guard.

## 16. Two mandatory final Qualifications

After final parser and validator pass, run two consecutive runner `Qualify` operations into separate directories under:

```text
D:\Delayed_Self_Evidence\0023ZK_cleanup_capture_repair_continuation\qualification_final_1\
D:\Delayed_Self_Evidence\0023ZK_cleanup_capture_repair_continuation\qualification_final_2\
```

Each must:

- target parser smoke only;
- retain all 11 Qualification files;
- exit 0;
- have empty stderr;
- contain parser marker once;
- record `ExecutionGuardPassed=False`;
- prove the portable SHA-256 empty-file known vector;
- preserve production metadata/test-root existence;
- leave zero Godot processes.

The earlier preliminary Qualification does not count toward these two final runs.

Command audit must prove:

```text
final Qualify commands = 2
Execute commands = 0
guard-passing commands = 0
future-fixture commands = 0
full behavior executions = 0
```

## 17. Frozen regressions and final audits

Run the mandatory accepted regressions before completing edits if not already retained under the new evidence root, and rerun all after final validation:

```text
0023R = 123 assertions / 4 positive / 39 negative
0023T = compile marker + 34 assertions
0023V = compile marker + 28 assertions
0023W = compile marker + 68 assertions
0023X = compile marker + 31 assertions
0023ZC = parser marker + compile contract 17 assertions
0023ZF = parser marker only
```

Require every process exit 0, empty stderr, marker exactly once, unchanged production metadata/test-root existence, absent 0023W fixture, and no Godot process.

Final audits must show:

- static parser errors = 0;
- unsafe dynamic `:=` = 0 in revised GDScript;
- PowerShell parser errors = 0;
- no `Get-FileHash` executable occurrence;
- no runtime source-self-inspection;
- no enumeration APIs in behavior source;
- no old 0023ZH/0023ZE executable contract tokens;
- exact 0023ZJ contract across all five artifacts;
- 18 stages / 41 cases / evidence counts unchanged;
- no unauthorized changed path;
- frozen product/prerequisite/diagnostic files unchanged;
- no `project.godot`, `.gd.uid`, or `.godot/` pollution;
- no fixture check/operation;
- production metadata unchanged;
- test-root existence unchanged;
- no residual Godot process.

Do not run aggregate, `tests/run_all.gd`, export, or build.

## 18. Authorized repository paths

```text
tests/app/task_0023zd_app_root_profile_session_full_matrix.gd
tests/app/task_0023zd_full_matrix_parser_smoke.gd
tests/app/task_0023zd_full_matrix_harness_validator.gd
tests/app/task_0023zd_full_matrix_manifest.json
tests/app/task_0023zd_capture_profile_session.ps1
docs/reports/0023ZK_CLEANUP_CAPTURE_REPAIR_CONTINUATION_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/production/COMPLETE_FLOW_PRODUCTION_CLOSURE_PLAN_CURRENT.md
```

Do not modify any other repository path.

## 19. Evidence and report

Use only:

```text
D:\Delayed_Self_Evidence\0023ZK_cleanup_capture_repair_continuation\
```

Retain draft intake, pre/post regressions, source audits, parser ledger, validator output, no-guard proof, both final Qualification inventories, portable-hash known-vector evidence, command audit, changed-path audit, frozen hashes, protected-state snapshots, and final Git/process state.

Create:

```text
docs/reports/0023ZK_CLEANUP_CAPTURE_REPAIR_CONTINUATION_REPORT.md
```

The report must distinguish:

- inherited Task 0023ZI draft state;
- changes completed by Task 0023ZK;
- preliminary evidence that does not count;
- final evidence used for acceptance.

## 20. Git closeout

After all final evidence passes:

1. update only authorized current docs;
2. stage authorized paths explicitly;
3. run `git diff --cached --check`;
4. fetch and stop on remote drift;
5. commit once:

```text
test: finalize Delayed Self cleanup and capture repair
```

6. push normally.

Finish with:

```text
clean tracked/untracked worktree
HEAD == origin/main
divergence 0/0
no Godot process
production metadata unchanged
test-root existence unchanged
no fixture operation
all frozen files unchanged
```

## 21. Terminal verdict and non-claims

Return exactly one:

```text
APP_ROOT_PROFILE_SESSION_CLEANUP_AND_CAPTURE_REPAIR_READY_FOR_GPT_REVIEW
BLOCKED_APP_ROOT_PROFILE_SESSION_CLEANUP_AND_CAPTURE_REPAIR
```

Include commit SHA if produced, draft-intake facts, completed repair details, final validator count, parser/no-guard results, two final Qualification inventories, portable SHA-256 known-vector proof, frozen regressions, protected-state facts, zero Execute/fixture count, changed paths, evidence root, and final Git state.

A passing verdict establishes only that the cleanup assertion and runner evidence-finalization defects are repaired and the retargeted Task 0023ZJ harness is parsed, statically validated, guard-proven, and zero-I/O requalified. It does not establish a passing full matrix, configured production persistence, default product persistence, aggregate coverage, menus/settings/localization, build/export/RC readiness, release, upload, or festival submission readiness.