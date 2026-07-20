# Task 0023ZH GPT cleanup-assertion and capture-portability adjudication

- Reviewed blocker commit: `b4ea3628fba7f02a78b46060ab1cf8473c680293`
- Accepted terminal verdict: `BLOCKED_APP_ROOT_PROFILE_SESSION_EXECUTION_EVIDENCE_INCOMPLETE`
- Root-cause adjudication: `TASK_0023ZH_FAILED_ON_SELF_REFERENTIAL_CLEANUP_ASSERTION_AND_NONPORTABLE_HASH_CAPTURE`
- Product-source defect established: no
- Full-matrix success established: no

## 1. Accepted execution and stop boundary

Task 0023ZH correctly stopped after Attempt 1. Startup, all pre-execution regressions, the no-guard proof, pre-Qualification, and exact fixture freshness checks passed. The behavior process started once, passed the first sixteen stages through `router_contract`, began `cleanup`, emitted one assertion failure for `cleanup_no_test_root_enumeration`, and controlled-aborted. Attempt 2 and all post-pass work were correctly not run.

The runner retained only 9/17 canonical attempt files. Therefore the task-level classification remains exactly:

```text
DIAGNOSTIC_CAPTURE_INCOMPLETE
```

The exact owned fixture was absent after the process, production Profile metadata and test-root existence were unchanged, all frozen hashes matched, the worktree was clean, and no Godot process remained.

## 2. Cleanup assertion root cause

The frozen cleanup stage reads the complete behavior-script source and evaluates:

```gdscript
not source_text.contains("list_dir_begin")
and not source_text.contains("get_files_at")
and not source_text.contains("get_directories_at")
```

Those three forbidden literals occur in that same check expression. Therefore the source string necessarily contains them, and the condition is deterministically false even when the behavior script performs no directory enumeration.

The observed failure is classified as:

```text
HARNESS_SELF_REFERENTIAL_NO_ENUMERATION_ASSERTION
```

This does not establish any fixture-cleanup or AppRoot defect. The revised harness must remove runtime self-source inspection. Runtime cleanup must continue to operate only on the exact 25 owned paths and the exact fixture directory. Static validator coverage must become the authoritative proof that the behavior source contains no directory-enumeration API calls.

## 3. Capture runner root cause

After the behavior process exited, the runner captured the binary worktree patch and then called:

```powershell
Get-FileHash -Algorithm SHA256
```

`Get-FileHash` was unavailable in the runner invocation environment. Because the call occurred before post-process snapshots, stage summary, classification, and inventory finalization, PowerShell stopped and those files were never created.

The capture failure is classified as:

```text
RUNNER_GET_FILE_HASH_PORTABILITY_FAILURE
```

The revised runner must:

1. eliminate dependence on `Get-FileHash`;
2. compute SHA-256 through a directly available .NET cryptography API;
3. prove the implementation during zero-fixture Qualification by hashing a task-owned empty evidence file and matching the standard empty-file SHA-256;
4. write post-process snapshots, stage summary, classification, and inventory independently of patch-hash success;
5. retain all 17 canonical files even when a later validation condition fails, while separately marking whether the patch hash is valid.

## 4. Frozen accepted authorities

No repair is authorized in AppRoot, MemoryProgress, LocalProfile, ProfileCodec, the adapter, Gameplay, scenes, formal data, or existing accepted prerequisite tests. Tasks 0023R–0023ZC, 0023ZF, and the product contracts remain frozen.

Task 0023ZH and its fixture are closed and must not be resumed or reused.

## 5. Required next gate

A new Task 0023ZI may revise only the five canonical harness artifacts and current documentation. It must:

1. remove the self-referential runtime source scan;
2. preserve the stable `cleanup_no_test_root_enumeration` case while using bounded exact-owned-path runtime invariants;
3. strengthen the validator to prove the behavior source contains no enumeration API calls and no self-source read in cleanup;
4. replace `Get-FileHash` with portable .NET SHA-256;
5. harden runner finalization so all 17 evidence files are written after every completed behavior process;
6. retarget the future execution contract to fresh Task 0023ZJ and fixture `task_0023zj_app_root_profile_session`;
7. pass parser, static validator, no-guard proof, and two zero-I/O Qualifications;
8. execute no fixture and no full matrix.

Actual full-matrix execution remains a later Task 0023ZJ.

## 6. Protected boundaries and non-claims

Production Profile content remains unopened and protected. Normal unconfigured AppRoot remains memory-only. Production activation/default persistence, aggregate registration, menus/settings/localization, build/export, RC, release, upload, and festival submission remain closed.

This adjudication explains only the reported cleanup assertion and evidence-capture failures. It does not claim that every remaining matrix condition will pass after repair.

```text
TASK_0023ZH_FAILED_ON_SELF_REFERENTIAL_CLEANUP_ASSERTION_AND_NONPORTABLE_HASH_CAPTURE
```