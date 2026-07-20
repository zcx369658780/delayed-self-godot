# Task 0023ZI — Repair the full-matrix cleanup assertion and capture portability without fixture execution

- Status: `READY`
- Gate: `PROTECTED PLAYER DATA / CLEANUP ASSERTION + CAPTURE PORTABILITY REPAIR`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- GPT adjudication: `docs/reports/0023ZH_GPT_CLEANUP_ASSERTION_AND_CAPTURE_PORTABILITY_ADJUDICATION.md`
- Required checkpoint: `5f09ad34d631d3b30661ee0cde66c6215eacabd3`
- Accepted harness checkpoint to revise: `cfbcbf6c8c7990db232a2fa6fbb22d937e0b623a`
- Future execution task: `0023ZJ`
- Future fixture ID: `task_0023zj_app_root_profile_session`
- Fixture status in this task: **reserved inert constants only; no fixture check or operation is authorized**

## 1. Objective

Repair two classified defects in the canonical five-file AppRoot full-matrix harness:

```text
HARNESS_SELF_REFERENTIAL_NO_ENUMERATION_ASSERTION
RUNNER_GET_FILE_HASH_PORTABILITY_FAILURE
```

Retarget the future execution contract from closed Task 0023ZH to fresh Task 0023ZJ, then prove the revised artifacts through parser, static validation, no-guard execution, and two zero-fixture capture Qualifications.

This task may establish only:

```text
non-self-referential cleanup runtime invariant
+ static no-enumeration proof
+ portable .NET SHA-256 capture
+ fail-closed 17-file post-process finalization
+ retargeting to Task 0023ZJ
+ parser/static/guard/Qualification evidence
+ zero fixture execution
```

It must not execute the full matrix, inspect or operate the future fixture, or modify product source.

## 2. Accepted root causes

### 2.1 Self-referential cleanup assertion

The current behavior source reads its own complete text and searches for:

```text
list_dir_begin
get_files_at
get_directories_at
```

Those literals occur in the check expression itself, so the condition is deterministically false.

Remove runtime self-source inspection. Do not weaken exact cleanup semantics.

### 2.2 Nonportable patch-hash capture

The current runner calls `Get-FileHash` after the behavior process and before writing post-state, stage summary, classification, and inventory. In the Task 0023ZH invocation environment the command was unavailable, leaving only 9/17 canonical files.

Remove all executable dependence on `Get-FileHash`. Use direct .NET cryptography and guarantee post-process evidence finalization independently of hash validity.

## 3. Closed scopes and fixture non-reuse

Do not execute, resume, edit, or reuse fixtures from:

```text
tasks/0023ZE_app_root_profile_session_full_matrix_execution_gate.md
tasks/0023ZF_tutorial_zero_persist_subcondition_diagnostic_gate.md
tasks/0023ZH_app_root_profile_session_full_matrix_execution_gate.md
```

Do not reuse:

```text
task_0023ze_app_root_profile_session
task_0023zf_tutorial_persist_diagnostic
task_0023zh_app_root_profile_session
```

Tasks 0023Y, 0023Z, 0023ZA, and 0023ZB remain historical closed scopes.

## 4. Startup gate

Before edits or Godot/PowerShell processes:

1. require absolute root `D:\Delayed_Self`, branch `main`, expected origin, and clean tracked/untracked worktree;
2. run all startup Git facts required by `AGENTS.md`;
3. fetch and fast-forward only;
4. require `HEAD == origin/main` and ancestry of `5f09ad34d631d3b30661ee0cde66c6215eacabd3`;
5. read the 0023ZG GPT acceptance, 0023ZH task and blocker report, and the GPT adjudication;
6. verify pinned Godot `4.7.stable.steam.5b4e0cb0f` or the exact documented equivalent;
7. require no residual Godot process.

Stop on divergence, conflict, unexpected files, missing checkpoint, remote mismatch, or process residue.

## 5. Protected-data and absolute zero-fixture boundary

Before and after every Godot or PowerShell group, record only production Profile non-content metadata:

```text
exists = true
Length = 473
LastWriteTimeUtc = 2026-07-19T08:15:02.2089459Z
```

Do not open, read, parse, hash, copy, rename, back up, delete, reset, repair, compare, or write production Profile content.

For `user://delayed_self_test_profiles/`, record only whether the root exists. Do not enumerate, inspect, create, clean, or modify it.

The new future contract is:

```text
future_task = 0023ZJ
fixture_id = task_0023zj_app_root_profile_session
canonical_profile_path = user://delayed_self_test_profiles/task_0023zj_app_root_profile_session/delayed_self_profile.json
execution_guard = --task-0023zj-fixture-execution
```

In Task 0023ZI these values may appear only as inert constants. Do not:

- call `build_test_profile_path` for the new ID;
- globalize, test, or inspect the new fixture path;
- check the fixture directory, target, or owned siblings;
- run runner `Execute`;
- pass the 0023ZJ execution guard;
- enter a successfully configured AppRoot into the tree;
- perform configured Profile load/persist/reset/recovery behavior.

Any fixture operation or production metadata change is an immediate stop with no repair commit.

## 6. Mandatory pre/post frozen regressions

Before editing and after all validation, rerun from fresh processes:

```text
0023R = 123 assertions / 4 positive / 39 negative
0023T = compile marker + 34 assertions
0023V = compile marker + 28 assertions
0023W = compile marker + 68 assertions
0023X = compile marker + 31 assertions
0023ZC = parser marker + compile contract 17 assertions
0023ZF = parser marker only
```

Every command must exit 0, have empty stderr, and print its marker exactly once. Require the 0023W fixture absent and no Godot process.

Do not run aggregate or `tests/run_all.gd`.

## 7. Frozen authorities

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

AppRoot, store, adapter, MemoryProgress ordering, Gameplay, product routing, and formal data remain frozen.

## 8. Authorized canonical harness artifact revisions

Only these existing files may change:

```text
tests/app/task_0023zd_app_root_profile_session_full_matrix.gd
tests/app/task_0023zd_full_matrix_parser_smoke.gd
tests/app/task_0023zd_full_matrix_harness_validator.gd
tests/app/task_0023zd_full_matrix_manifest.json
tests/app/task_0023zd_capture_profile_session.ps1
```

Do not rename them. They remain the canonical harness artifact set, revised for future Task 0023ZJ.

## 9. Mandatory cleanup assertion repair

### 9.1 Remove self-source runtime inspection

In `_stage_cleanup`, remove every runtime read of the behavior script source, including `FileAccess.get_file_as_string` used for enumeration checking.

The behavior source itself must contain none of these tokens after repair:

```text
list_dir_begin
get_files_at
get_directories_at
get_file_as_string("res://tests/app/task_0023zd_app_root_profile_session_full_matrix.gd")
```

### 9.2 Preserve runtime exact-owned-path semantics

Keep the stable case ID:

```text
cleanup_no_test_root_enumeration
```

Its runtime condition must use only bounded exact-owned-path invariants. Add an explicitly typed helper equivalent to:

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

Requirements:

1. the helper must perform no directory enumeration and no source-file read;
2. the cleanup case must assert this helper;
3. exact 25-path inventory, uniqueness, canonical target, exact fixture base, non-recursive directory removal, and final absence requirements remain unchanged;
4. do not replace the case with unconditional `true`, a constant flag, membership-only proof, or a weakened assertion;
5. no test-root or fixture-directory enumeration API may appear anywhere in the behavior source.

The static validator becomes the authoritative proof that no enumeration API is called.

## 10. Mandatory portable SHA-256 repair

### 10.1 Remove `Get-FileHash`

No executable runner path may contain or call:

```text
Get-FileHash
```

Add a direct .NET implementation equivalent to:

```powershell
function Get-Sha256Hex {
    param([Parameter(Mandatory = $true)][string]$Path)
    $stream = [System.IO.File]::OpenRead($Path)
    try {
        $sha256 = [System.Security.Cryptography.SHA256]::Create()
        try {
            $bytes = $sha256.ComputeHash($stream)
        }
        finally {
            $sha256.Dispose()
        }
    }
    finally {
        $stream.Dispose()
    }
    return ([System.BitConverter]::ToString($bytes)).Replace('-', '').ToLowerInvariant()
}
```

Use the result for the binary worktree patch hash.

### 10.2 Qualification runtime proof

During each `Qualify` run, create an empty task-owned temporary file only inside the supplied EvidenceRoot, hash it with `Get-Sha256Hex`, and require exact equality to:

```text
e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
```

Delete only that temporary qualification file after the check. Record in the existing Qualification inventory:

```text
PortableSha256Passed=True
```

Do not add or remove canonical Qualification evidence files; the count remains 11.

## 11. Mandatory 17-file finalization hardening

After any completed behavior process, the runner must attempt to write all 17 canonical attempt files even when patch hashing or a later audit fails.

Required ordering after process exit:

```text
exit code
→ process-after snapshot
→ production metadata after
→ test-root existence after
→ exact fixture state after
→ stage summary
→ initial bounded classification
→ binary worktree patch
→ portable patch hash or bounded HASH_UNAVAILABLE sentinel
→ classification finalization
→ inventory finalization
```

Requirements:

1. post-process snapshots and stage summary must be written before patch hashing;
2. use `try`/`catch`/`finally` or equivalent so inventory finalization is attempted after any post-process capture error;
3. every canonical path must be created, including patch-hash, classification, and inventory files;
4. if hash computation fails, write `HASH_UNAVAILABLE` to the hash file, classify `DIAGNOSTIC_CAPTURE_INCOMPLETE`, and still write all remaining files;
5. if any other post-process capture fails, record a bounded capture error in classification and inventory without exposing raw paths or production content;
6. passing still requires a valid lowercase 64-character SHA-256 matching the patch bytes; file existence alone is insufficient;
7. runner failure must remain nonzero on any incomplete or invalid capture;
8. runner must never infer task success from exit code alone.

Preserve the exact 17-file manifest and file names.

## 12. Retarget the future execution contract to 0023ZJ

Update all five canonical artifacts consistently:

```text
future_task = 0023ZJ
fixture_id = task_0023zj_app_root_profile_session
canonical_profile_path = user://delayed_self_test_profiles/task_0023zj_app_root_profile_session/delayed_self_profile.json
execution_guard = --task-0023zj-fixture-execution
```

Behavior protocol markers must use `TASK_0023ZJ_`:

```text
TASK_0023ZJ_BEHAVIOR_PROCESS_STARTED
TASK_0023ZJ_STAGE_BEGIN=<stage_id>
TASK_0023ZJ_STAGE_PASS=<stage_id>
TASK_0023ZJ_ASSERT_FAIL stage=<stage_id> label=<bounded_label>
TASK_0023ZJ_ABORT stage=<stage_id> reason=<bounded_reason>
TASK_0023ZJ_ASSERTIONS=<count>
TASK_0023ZJ_APP_ROOT_PROFILE_SESSION_FULL_MATRIX_PASS
TASK_0023ZJ_EXECUTION_GUARD_BLOCKED
```

Task-owned validation markers become:

```text
TASK_0023ZI_FULL_MATRIX_PARSER_SMOKE_PASS
TASK_0023ZI_FULL_MATRIX_HARNESS_VALIDATOR_PASS
TASK_0023ZI_CAPTURE_QUALIFICATION_PASS
```

No executable artifact may retain the closed 0023ZH fixture, guard, or `TASK_0023ZH_` protocol strings. Historical reports may retain them.

## 13. Manifest contract

Preserve exactly:

```text
schema_version = 1
18 ordered stages
41 unique stable case IDs
6 accepted failure stages
11 Qualification evidence files
17 Execute evidence files
7 forbidden disclosure categories
```

Change only future task/fixture/path/guard values. Do not add, remove, rename, reorder, merge, or weaken behavior cases.

## 14. Static validator reinforcement

Revise the validator to prove at minimum:

1. exact 0023ZJ future contract in all executable artifacts;
2. closed 0023ZH executable tokens absent;
3. behavior cleanup contains no runtime self-source read;
4. behavior source contains no `list_dir_begin`, `get_files_at`, or `get_directories_at` token;
5. `_cleanup_uses_exact_owned_paths_only` exists, verifies exact 25-path inventory/uniqueness/base-dir/canonical-target invariants, and is used by `cleanup_no_test_root_enumeration`;
6. no unconditional cleanup assertion replacement exists;
7. runner contains no `Get-FileHash`;
8. runner uses `[System.Security.Cryptography.SHA256]::Create()` and hashes streams directly;
9. Qualification proves the standard empty-file SHA-256 and records `PortableSha256Passed`;
10. post-process snapshots/stage summary precede hash computation;
11. runner has explicit finalization paths for hash/capture failure and writes classification/inventory afterward;
12. manifest remains 18 stages, 41 cases, and 11/17 evidence files;
13. all previous order-repair, protocol, AppRoot-ordering, disclosure, failure, cleanup, and frozen-hash checks remain.

Do not delete or weaken an existing validator assertion merely to pass. Print deterministic assertion count and terminal marker exactly once, exit 0, and have empty stderr.

## 15. Parser gate

Run the revised parser smoke after the first complete draft and again from a final fresh Godot process.

It must preload the revised behavior source, validator dependencies, AppRoot, store, and adapter without executing the guarded behavior source or performing Profile/test-root I/O.

Allow at most five parser-only corrections within the five authorized harness artifacts. Record every attempt.

## 16. No-guard proof

Run the revised full behavior script once without the 0023ZJ guard. Independently retain command/stdout/stderr/exit/process/protected-state/worktree evidence.

Require:

```text
Godot exit = 2
TASK_0023ZJ_EXECUTION_GUARD_BLOCKED count = 1
TASK_0023ZJ_BEHAVIOR_PROCESS_STARTED count = 0
stage/assertion/final-pass marker counts = 0
stderr empty
production metadata unchanged
test-root existence unchanged
worktree unchanged
Godot processes before/after = 0 / 0
```

Do not pass the guard.

## 17. Capture-runner Qualifications

Run two consecutive `Qualify` commands into separate evidence subdirectories.

Each must retain exactly 11 canonical files and prove:

```text
exit = 0
stderr empty
parser marker count = 1
ExecutionGuardPassed = False
PortableSha256Passed = True
QualificationPassed = True
production metadata unchanged
test-root existence unchanged
Godot processes before/after = 0 / 0
```

Command audit must show:

```text
Qualify commands = 2
Execute commands = 0
guard-passing commands = 0
future-fixture commands = 0
full behavior executions = 0
```

## 18. Final audits

Before documentation closeout require:

- static parser errors = 0;
- unsafe dynamic `:=` occurrences in revised GDScript = 0;
- PowerShell parser errors = 0;
- no `Get-FileHash` executable use;
- no behavior self-source read or enumeration API token;
- 18 stages and 41 cases exact;
- 11/17 evidence manifest exact;
- no unauthorized changed path;
- no product or accepted prerequisite/diagnostic diff;
- no `project.godot`, `.gd.uid`, or `.godot/` pollution;
- production metadata unchanged;
- test-root existence unchanged without enumeration;
- 0023W, 0023ZE, 0023ZF, and 0023ZH fixtures absent;
- no task-owned 0023ZJ fixture check or operation;
- no residual Godot process.

## 19. Authorized repository paths

```text
tests/app/task_0023zd_app_root_profile_session_full_matrix.gd
tests/app/task_0023zd_full_matrix_parser_smoke.gd
tests/app/task_0023zd_full_matrix_harness_validator.gd
tests/app/task_0023zd_full_matrix_manifest.json
tests/app/task_0023zd_capture_profile_session.ps1
docs/reports/0023ZI_APP_ROOT_PROFILE_SESSION_CLEANUP_AND_CAPTURE_REPAIR_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/production/COMPLETE_FLOW_PRODUCTION_CLOSURE_PLAN_CURRENT.md
```

Do not modify any other path.

## 20. Evidence and Git

Use only:

```text
D:\Delayed_Self_Evidence\0023ZI_cleanup_and_capture_repair\
```

Record startup facts, protected metadata, regressions, parser ledger, validator output, no-guard proof, both Qualification inventories, portable-hash proof, command audit, changed-path audit, frozen hashes, and final Git state.

Create:

```text
docs/reports/0023ZI_APP_ROOT_PROFILE_SESSION_CLEANUP_AND_CAPTURE_REPAIR_REPORT.md
```

Require one implementation commit:

```text
test: repair Delayed Self cleanup and capture harness
```

Stage authorized paths explicitly, run `git diff --cached --check`, fetch and stop on drift, then push normally.

Finish with clean worktree, `HEAD == origin/main`, divergence `0/0`, no Godot process, unchanged production metadata/test-root existence, no fixture operation, and no full behavior execution.

## 21. Terminal verdict and non-claims

Return exactly one:

```text
APP_ROOT_PROFILE_SESSION_CLEANUP_AND_CAPTURE_REPAIR_READY_FOR_GPT_REVIEW
BLOCKED_APP_ROOT_PROFILE_SESSION_CLEANUP_AND_CAPTURE_REPAIR
```

A passing verdict establishes only that the classified cleanup assertion and capture portability defects are repaired, retargeted, parsed, statically validated, guard-proven, and zero-I/O qualified. It does not establish full-matrix success, configured product persistence completeness, production persistence, aggregate coverage, menus/settings/localization, build/export, RC, release, upload, or festival submission readiness.