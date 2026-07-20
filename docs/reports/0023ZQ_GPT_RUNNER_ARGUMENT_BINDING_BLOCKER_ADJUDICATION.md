# Task 0023ZQ GPT runner argument-binding blocker adjudication

- Task: `tasks/0023ZQ_isolated_production_policy_sandbox_matrix_gate.md`
- Accepted implementation under test: `afe8c6fffdc98992b732fce46f206ad0dc8553a1`
- Required checkpoint: `59c9f77d7a744e34ce55a415878b0e03bf28bd02`
- Reported terminal verdict: `BLOCKED_ISOLATED_PRODUCTION_POLICY_SANDBOX_MATRIX`
- GPT classification: `TASK_0023ZQ_BLOCKED_BEFORE_BEHAVIOR_ON_RUNNER_GODOT_PATH_ARGUMENT_BINDING`
- Product defect established: **no**
- Harness behavior defect established: **no**
- Real player-data contact established: **no**

## 1. Accepted evidence boundary

This adjudication accepts the owner/Codex-supplied blocked-run facts with explicit disclosure. The external audit remains at:

```text
D:\Delayed_Self_Evidence\0023ZQ_isolated_production_policy_matrix\blocked_attempt_1_invocation_audit.json
```

The evidence states:

- formal pre-validation passed 14/14;
- the no-guard proof exited 2 with the expected block behavior;
- Attempt 1 failed while the outer PowerShell runner was binding the Godot executable invocation;
- the Godot executable path contained spaces and was split into multiple tokens;
- the runner exited 1 with non-empty stderr;
- runner body, sandbox attestation and every production-policy behavior case remained unstarted;
- Attempt 2 did not run;
- neither `attempt_1` nor `attempt_2` exists;
- 371 frozen path hashes matched;
- no Godot process remained;
- ordinary production Profile/user-data and the test root were not accessed;
- product source was unchanged;
- no commit or push occurred;
- exactly the five Task 0023ZQ-authorized harness artifacts remain untracked.

The external file was not independently read through GitHub. The classification relies on the bounded owner/Codex report and the repository-frozen task contract.

## 2. Adjudication

The failure occurred before any matrix behavior began. Therefore it establishes none of the following:

```text
production read-only behavior
production write-on-intent behavior
sandbox attestation success or failure
missing/valid/sanitizable/malformed/unsupported handling
NO_CHANGE behavior
activation backup or recovery behavior
transaction rollback behavior
complete-matrix success or failure
```

The only established defect is the outer runner's process invocation construction. A path containing spaces must be passed as the process executable filename, not flattened into a shell command string.

The correct repair direction is a bounded PowerShell process-launch helper based on `System.Diagnostics.ProcessStartInfo` with:

```text
FileName = exact Godot executable path
UseShellExecute = false
RedirectStandardOutput = true
RedirectStandardError = true
one ArgumentList entry per Godot argument
```

String-concatenated shell commands, `Invoke-Expression`, `cmd /c`, and flattened `Start-Process -ArgumentList` command strings are not acceptable substitutes.

## 3. Repository and local-work disposition

No Task 0023ZQ implementation commit exists. The five authorized untracked harness files are not accepted or frozen. They may be inherited only by a new continuation task that:

1. permits exactly those five untracked paths and no other dirty state;
2. hashes them before modification;
3. changes only the PowerShell runner for the argument-binding repair unless parser/validator metadata must be updated to prove that repair;
4. reruns parser/static/zero-I/O qualification and a no-behavior invocation-binding check;
5. then performs the two-attempt isolated matrix from absent attempt roots;
6. stops on the first behavior/evidence/cleanup failure without product repair.

The old Task 0023ZQ must not be resumed directly.

## 4. Frozen safety boundary

The following remain closed:

- ordinary production Profile content or metadata;
- ordinary user-data directory and siblings;
- `user://delayed_self_test_profiles/` and historical fixtures;
- product source and project settings;
- default production activation;
- aggregate registration;
- Menu New/Continue/Reset;
- settings/localization;
- build/export, RC, release, upload and festival submission.

## 5. Verdict

```text
TASK_0023ZQ_BLOCKED_BEFORE_BEHAVIOR_ON_RUNNER_GODOT_PATH_ARGUMENT_BINDING
```

A new bounded continuation/retry task is required. This adjudication does not accept the five untracked harness artifacts and does not establish any production-policy runtime result.