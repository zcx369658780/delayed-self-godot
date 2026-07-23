# Task 0024AN — Secure Windows User-scope DeepSeek credential wrapper and continue the project pilot

- Status: `READY`
- Gate: `USER-SCOPE CREDENTIAL WRAPPER / WRAPPER-ONLY CLI SMOKE / GPT-5.6 REVIEW / PROJECT SYNC`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Required start commit in ancestry: `22c38d33275d737bd6bb5327cf7930a53260ac70`
- Predecessor: `tasks/0024AM_deepseek_v4_pro_external_file_worker_project_pilot_and_sync_gate.md`
- Predecessor result: `BLOCKED_BEFORE_WRITE_INVALID_PROCESS_ENVIRONMENT_PREFLIGHT`
- DeepSeek model: `deepseek-v4-pro`
- Required main agent: `GPT-5.6 Sol`; fallback `GPT-5.6 Terra`
- Authorized transport: `Invoke-DeepSeekFileTask.ps1 → accepted CLI worker`
- Possible project recommendation: `DEEPSEEK_PROJECT_PILOT_ENABLED` or `DEEPSEEK_PROJECT_PILOT_BLOCKED`

## 1. Root-cause correction

Task 0024AM incorrectly treated an empty current-process variable:

```powershell
$env:DEEPSEEK_API_KEY
```

as proof that the credential was absent.

Codex shell environment filtering may omit names containing `KEY`, `SECRET`, or `TOKEN` from ordinary child-process environments. Therefore:

```text
empty $env:DEEPSEEK_API_KEY
!=
missing Windows User-scope DEEPSEEK_API_KEY
```

Do not edit Task 0024AM. Preserve it as historical evidence. Task 0024AN supersedes only its credential preflight and direct Python invocation rules.

The previous attempt created no smoke fixture, invoked no worker, changed no project or user-level file, and made no commit. Restart from a fresh startup gate.

## 2. Objective

1. Inspect and create or repair:

```text
C:\Users\zcxve\.codex\helpers\Invoke-DeepSeekFileTask.ps1
```

2. Read the key only from Windows User scope.
3. Inject it only into the wrapper Process scope immediately around the one approved Python worker invocation.
4. Clear the Process-scope value in `finally`.
5. Never print, hash, log, serialize or persist the key.
6. Do not weaken `shell_environment_policy`.
7. Make the wrapper the only project-authorized DeepSeek invocation.
8. Continue the configuration audit and real project smoke intended by Task 0024AM.
9. Keep planning, review, testing, Git and acceptance with GPT-5.6.
10. Synchronize governance, Project Sources export, reports and handoff only after a successful smoke.

This task is infrastructure-only. It authorizes no gameplay, level, Simulation, solver, catalog, Profile, player-data, release or submission work.

## 3. Hard prohibitions

Never:

- block because `$env:DEEPSEEK_API_KEY` is empty;
- set `ignore_default_excludes = true`;
- weaken or bypass `shell_environment_policy`;
- write the key to any TOML, JSON, Markdown, log, transcript, Git file or command line;
- print any key-derived prefix, suffix, length or hash;
- modify `C:\Users\zcxve\.codex\config.toml`;
- modify the accepted worker core;
- modify GPT-5.6 or DeepSeek model/provider definitions;
- use MCP delegate;
- call Python or `deepseek_file_task_cli.py` directly for the real smoke;
- let DeepSeek edit tracked repository files in this task.

## 4. Ownership

GPT-5.6 Sol/Terra exclusively owns:

- wrapper design and review;
- project-config audit;
- task JSON;
- workspace, context and allowed paths;
- wrapper invocation;
- diff/path/secret review;
- tests and validation;
- Git commit and push;
- terminal verdict.

DeepSeek may read the smoke context and edit exactly one smoke target. It may not create the wrapper, inspect configuration, run Shell/Git/tests/builds, access player data, review itself or decide acceptance.

## 5. State machine

```text
STARTUP_GATE
→ PREDECESSOR_NO_WRITE_CONFIRMATION
→ USER_LEVEL_WRAPPER_AUDIT
→ GPT_5_6_PRE_WRITE_SECURITY_REVIEW
→ WRAPPER_BACKUP_IF_NEEDED
→ ATOMIC_WRAPPER_CREATE_OR_REPAIR
→ WRAPPER_STATIC_AND_NEGATIVE_RUNTIME_VALIDATION
→ PROJECT_CONFIG_AND_ROUTING_AUDIT
→ SMOKE_JSON_AND_FIXTURE_AUTHORING
→ REAL_DEEPSEEK_SMOKE_VIA_WRAPPER
→ GPT_5_6_PATH_CONTENT_AND_SECRET_REVIEW
→ TEMPORARY_PROJECT_SMOKE_CLEANUP
→ GOVERNANCE_PROJECT_SOURCE_AND_ROLLBACK_SYNC
→ PRE_COMMIT_AUDIT
→ COMMIT_AND_PUSH
→ POST_PUSH_AUDIT
→ HANDOFF_AND_PASS_FOR_GPT_REVIEW
```

Wrapper defects before the real smoke are repairable. Credential disclosure or an unauthorized write after the real smoke begins is terminal.

## 6. Startup gate

Require:

1. root `D:\Delayed_Self`;
2. branch `main`;
3. expected origin;
4. fetch and fast-forward only;
5. `HEAD == origin/main`, divergence `0/0`;
6. Task 0024AN and current pointers from `origin/main`;
7. no tracked/staged changes;
8. only untracked `.codex/config.toml`;
9. its unchanged SHA-256:

```text
d4c670da3c2404921a1ab177f4e5405449bc8321d713cc0b42b8046201fd33cc
```

10. Godot count zero; never launch Godot;
11. exact Python and worker paths exist;
12. hashes for user-level config, agents and worker core;
13. no current-process key-presence check.

Read the current pointers, this task, Task 0024AM, the Task 0024AL handoff/acceptance, model-routing rules, workflow and current documents.

## 7. Wrapper audit and backup

Target:

```text
C:\Users\zcxve\.codex\helpers\Invoke-DeepSeekFileTask.ps1
```

If absent, create it.

If present:

- record size and SHA-256;
- reuse byte-identically if compliant;
- otherwise back it up to:

```text
C:\Users\zcxve\.codex\reports\delayed-self\0024AN\rollback\Invoke-DeepSeekFileTask.before_0024AN.ps1
```

- verify backup hash;
- atomically replace only the target wrapper.

Do not delete the backup in this task.

## 8. Required wrapper implementation

Use this exact implementation unless GPT-5.6 identifies and independently reviews a PowerShell-runtime correction:

```powershell
#Requires -Version 7.0

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$TaskFile
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$pythonExecutable =
    "C:\Users\zcxve\AppData\Local\Programs\Python\Python311\python.exe"
$workerScript =
    "C:\Users\zcxve\.codex\external-agents\deepseek-file-worker-stdlib\deepseek_file_task_cli.py"

if (-not [System.IO.Path]::IsPathFullyQualified($TaskFile)) {
    throw "TaskFile must be an absolute path."
}
if (-not (Test-Path -LiteralPath $pythonExecutable -PathType Leaf)) {
    throw "The approved Python executable was not found."
}
if (-not (Test-Path -LiteralPath $workerScript -PathType Leaf)) {
    throw "The approved DeepSeek file worker was not found."
}

$resolvedTaskFile =
    (Resolve-Path -LiteralPath $TaskFile -ErrorAction Stop).Path

if (-not (Test-Path -LiteralPath $resolvedTaskFile -PathType Leaf)) {
    throw "TaskFile does not resolve to a file."
}

$credential = $null
$workerExitCode = 1

try {
    $credential = [Environment]::GetEnvironmentVariable(
        "DEEPSEEK_API_KEY",
        [EnvironmentVariableTarget]::User
    )

    if ([string]::IsNullOrWhiteSpace($credential)) {
        throw "The DeepSeek credential is not configured in Windows User scope."
    }

    [Environment]::SetEnvironmentVariable(
        "DEEPSEEK_API_KEY",
        $credential,
        [EnvironmentVariableTarget]::Process
    )

    & $pythonExecutable $workerScript "--task-file" $resolvedTaskFile
    $workerExitCode = [int]$LASTEXITCODE
}
finally {
    [Environment]::SetEnvironmentVariable(
        "DEEPSEEK_API_KEY",
        $null,
        [EnvironmentVariableTarget]::Process
    )
    Remove-Item Env:DEEPSEEK_API_KEY -ErrorAction SilentlyContinue
    $credential = $null
}

exit $workerExitCode
```

The wrapper must accept only `-TaskFile`, require an absolute existing file, invoke only the exact approved Python/worker pair, preserve the worker exit code, write no files itself, perform no Git/dependency/network operation itself and add no credential-derived output.

## 9. Correct credential preflight

Use only Windows User scope:

```powershell
$credentialPresent = -not [string]::IsNullOrWhiteSpace(
    [Environment]::GetEnvironmentVariable(
        "DEEPSEEK_API_KEY",
        [EnvironmentVariableTarget]::User
    )
)
```

Record only:

```text
windows_user_scope_deepseek_credential = PRESENT
```

or:

```text
windows_user_scope_deepseek_credential = MISSING
```

Do not record any other credential metadata.

Current-process absence while User scope is present is expected filtering behavior, not a blocker.

## 10. Wrapper validation

Before the real smoke, GPT-5.6 must prove:

- PowerShell parser/AST succeeds;
- exactly one User-scope key read exists;
- no User/Machine-scope key write exists;
- Process-scope set and `finally` clear exist;
- `Env:DEEPSEEK_API_KEY` is removed in `finally`;
- only the exact Python/worker is launched;
- no `ignore_default_excludes`, shell-policy mutation, transcript, Git or install command exists;
- no credential literal exists;
- only `TaskFile` is accepted.

Negative runtime probes:

1. relative task path must fail before worker launch;
2. missing absolute task file must fail;
3. User-scope credential remains configured;
4. user-level config/agents/worker hashes remain unchanged;
5. Godot remains zero.

Do not use a fake credential or overwrite the real one.

## 11. Project config and routing audit

Complete the original 0024AM audit:

- compare project-local and user-level routing;
- keep GPT-5.6 provider/model unchanged;
- keep DeepSeek external, opt-in and implementation-only;
- detect duplicates/conflicts;
- prefer documentation-only alignment over unsupported TOML keys;
- never alter global shell filtering.

Choose one:

```text
PATH_A_SUPPORTED_MINIMAL_PROJECT_DECLARATION
PATH_B_DOCUMENTATION_ONLY_WRAPPER_ALIGNMENT
PATH_C_BLOCKED
```

Any project-local config change is limited to the existing untracked:

```text
D:\Delayed_Self\.codex\config.toml
```

Every DeepSeek invocation under any path must use the wrapper.

## 12. Real smoke test

Create:

```text
D:\Delayed_Self\.codex\smoke\0024AN\context.md
D:\Delayed_Self\.codex\smoke\0024AN\target.md
C:\Users\zcxve\.codex\reports\delayed-self\0024AN\deepseek_smoke_task.json
```

Initial target token:

```text
DEEPSEEK_SMOKE_PENDING
```

Task JSON:

```json
{
  "workspace": "D:\\Delayed_Self",
  "allowed_paths": [
    "D:\\Delayed_Self\\.codex\\smoke\\0024AN\\target.md"
  ],
  "context_files": [
    "D:\\Delayed_Self\\.codex\\smoke\\0024AN\\context.md"
  ],
  "task": "Edit only target.md. Replace the exact token DEEPSEEK_SMOKE_PENDING with DEEPSEEK_SMOKE_PASS and add the exact final line worker=deepseek-v4-pro. Preserve all other bytes and do not touch any other file.",
  "acceptance_criteria": [
    "target.md contains DEEPSEEK_SMOKE_PASS exactly once",
    "target.md contains worker=deepseek-v4-pro exactly once",
    "DEEPSEEK_SMOKE_PENDING is absent",
    "no path outside allowed_paths is modified"
  ],
  "max_turns": 8,
  "max_files_read": 40,
  "max_total_read_bytes": 400000,
  "max_total_write_bytes": 200000
}
```

The JSON must not contain the key.

Invoke only:

```powershell
& "C:\Users\zcxve\.codex\helpers\Invoke-DeepSeekFileTask.ps1" `
  -TaskFile "C:\Users\zcxve\.codex\reports\delayed-self\0024AN\deepseek_smoke_task.json"
```

Direct Python invocation and MCP delegate are forbidden.

## 13. Mandatory post-smoke review

GPT-5.6 independently verifies:

- wrapper exit code;
- worker JSON parseability;
- exact target content and hashes;
- context identity;
- only the one target changed;
- no tracked repository change;
- no key/secret in JSON, output, reports or Git diff;
- user config/agents/worker core unchanged;
- Process-scope variable cleared;
- User-scope credential remains present;
- only the approved worker launched;
- Godot remains zero.

DeepSeek self-report is not acceptance.

## 14. Cleanup

Delete only:

```text
D:\Delayed_Self\.codex\smoke\0024AN\
```

Preserve sanitized user-level reports, smoke task JSON and any wrapper backup.

Final repository state must have no tracked/staged changes before governance authoring and only `.codex/config.toml` untracked. Do not use repo-wide clean/restore.

## 15. Project-wide invocation normalization

Search for:

```text
deepseek_file_task_cli.py
DEEPSEEK_API_KEY
Invoke-DeepSeekFileTask.ps1
ignore_default_excludes
shell_environment_policy
```

- Keep Task 0024AM unchanged as history.
- Current/new governance must state its direct Python command and current-process check are superseded by Task 0024AN.
- Every current/new invocation example must use the wrapper.
- The variable name may appear; its value may not.
- No policy weakening may appear.

## 16. Authorized repository paths

Create or modify only:

```text
AGENTS.md
docs/agents/PROJECT_RULE_CODEX_MULTI_SUBAGENT_MODEL_ROUTING.md
docs/workflows/DEEPSEEK_FILE_WORKER_CLI_PILOT_WORKFLOW.md
docs/reports/0024AN_DEEPSEEK_USER_SCOPE_CREDENTIAL_WRAPPER_AND_PROJECT_PILOT_REPORT.md
docs/reports/0024AN_DEEPSEEK_PROJECT_SYNC_AND_ROLLBACK_REPORT.md
docs/project_sources/DELAYED_SELF_PROJECT_SOURCE_DEEPSEEK_FILE_WORKER_PILOT_CURRENT_2026_07_23.md
docs/handoffs/DELAYED_SELF_SESSION_HANDOFF_AFTER_TASK_0024AN_DEEPSEEK_PROJECT_PILOT_2026_07_23.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
```

Local-only authorized paths:

```text
C:\Users\zcxve\.codex\helpers\Invoke-DeepSeekFileTask.ps1
C:\Users\zcxve\.codex\reports\delayed-self\0024AN\
D:\Delayed_Self\.codex\config.toml
D:\Delayed_Self\.codex\smoke\0024AN\
```

No other path may change.

## 17. Protected surfaces

Do not modify:

```text
tasks/0024AM_deepseek_v4_pro_external_file_worker_project_pilot_and_sync_gate.md
C:\Users\zcxve\.codex\config.toml
C:\Users\zcxve\.codex\AGENTS.md
C:\Users\zcxve\.codex\agents\**
C:\Users\zcxve\.codex\external-agents\deepseek-file-worker-stdlib\**
project.godot
scenes/**
scripts/**
data/**
schemas/**
tests/**
docs/playtest/SUBMISSION_CORE_1_12_OWNER_CURRICULUM_REVIEW_CURRENT.md
localization/**
assets/**
audio/**
build/**
export/**
release/**
submission/**
all Task 0024AF–0024AL historical artifacts and retained identities
```

Do not inspect production Profile/player data.

## 18. Required reports and synchronization

Create:

```text
docs/reports/0024AN_DEEPSEEK_USER_SCOPE_CREDENTIAL_WRAPPER_AND_PROJECT_PILOT_REPORT.md
docs/reports/0024AN_DEEPSEEK_PROJECT_SYNC_AND_ROLLBACK_REPORT.md
docs/project_sources/DELAYED_SELF_PROJECT_SOURCE_DEEPSEEK_FILE_WORKER_PILOT_CURRENT_2026_07_23.md
docs/handoffs/DELAYED_SELF_SESSION_HANDOFF_AFTER_TASK_0024AN_DEEPSEEK_PROJECT_PILOT_2026_07_23.md
```

Reports must cover:

- invalid predecessor preflight;
- wrapper status and hashes;
- User-scope presence only;
- static/negative/runtime smoke evidence;
- Path A/B/C;
- GPT-5.6 model/provider invariants;
- unchanged global policy and worker core;
- secret/path review;
- cleanup;
- GitHub commit;
- rollback.

Project Sources export must state:

```text
project_source_import_status = READY_FOR_GPT_PROJECT_SOURCE_IMPORT
```

It must not claim actual import.

Update current pointers and indexes consistently. The owner subjective 1–12 review remains pending.

## 19. Validation scope

Run:

```powershell
git status --short --untracked-files=all
git diff --check
git diff --name-only
git diff --stat
```

Validate wrapper parsing, User-scope read, Process cleanup, unchanged policies/config/worker, wrapper-based smoke, JSON, changed paths, Markdown links, secret scan, final cleanliness and Godot zero.

Do not launch Godot or rerun historical retained cycles.

Record:

```text
project_test_scope = CREDENTIAL_WRAPPER_CONFIGURATION_DOCUMENTATION_AND_EXTERNAL_WORKER_SMOKE_ONLY
full_gameplay_regression = NOT_RUN_NOT_REQUIRED_NO_GAMEPLAY_CHANGE
```

## 20. Gate logic

Recommend `DEEPSEEK_PROJECT_PILOT_ENABLED` only if:

- wrapper is compliant;
- User-scope credential is present;
- shell filtering remains unchanged;
- GPT-5.6 native provider/model is unchanged;
- worker core is unchanged;
- real smoke succeeds through the wrapper;
- only the target changes;
- output is parseable;
- Process-scope key is cleared;
- secret scan passes;
- temporary project files are removed;
- governance uses the wrapper;
- commit/push succeeds;
- Project Sources delta is ready.

Otherwise recommend `DEEPSEEK_PROJECT_PILOT_BLOCKED`.

Codex verdicts:

```text
PASS_FOR_GPT_REVIEW
BLOCKED
FAIL
```

## 21. Commit and push

After all gates pass:

1. fetch and require divergence `0/0`;
2. explicitly stage only authorized repository files;
3. never stage `.codex/config.toml`, wrapper, local reports, backup or smoke JSON;
4. run `git diff --cached --check`;
5. review full staged diff;
6. commit:

```text
chore(codex): secure DeepSeek credential wrapper and continue pilot
```

7. push `main`;
8. verify `HEAD == origin/main`;
9. require no tracked/staged changes, only `.codex/config.toml` untracked, and Godot zero.

## 22. Stop conditions

Stop for:

- genuinely missing Windows User-scope credential;
- required shell-policy weakening;
- any credential disclosure;
- unexpected user-level change;
- worker-core change;
- unapproved process launch;
- direct Python use for the smoke;
- unauthorized DeepSeek write;
- malformed result;
- remote drift;
- unavailable GPT-5.6 review;
- protected project change;
- cleanup failure.

Do not stop merely because `$env:DEEPSEEK_API_KEY` is empty.

## 23. Required final fields

```text
predecessor_blocker_adjudication =
  INVALID_PROCESS_ENVIRONMENT_PREFLIGHT_SUPERSEDED

windows_user_scope_deepseek_credential =
  PRESENT / MISSING

current_process_variable_visibility =
  FILTERED_EXPECTED / PRESENT / UNVERIFIED

wrapper_status =
  REUSED_COMPLIANT / CREATED / REPAIRED / BLOCKED

wrapper_sha256_before =
  <sha256 or ABSENT>

wrapper_sha256_after =
  <sha256>

shell_environment_policy_unchanged =
  YES / NO / UNVERIFIED

ignore_default_excludes_enabled =
  NO / YES / UNVERIFIED

direct_python_invocation_used =
  NO / YES

real_smoke_test_passed =
  YES / NO

deepseek_modified_only_authorized_target =
  YES / NO / UNVERIFIED

process_scope_credential_cleared =
  YES / NO / UNVERIFIED

gpt_5_6_native_model_provider_unchanged =
  YES / NO / UNVERIFIED

user_level_worker_core_unchanged =
  YES / NO / UNVERIFIED

project_local_config_path =
  PATH_A_SUPPORTED_MINIMAL_PROJECT_DECLARATION
  or PATH_B_DOCUMENTATION_ONLY_WRAPPER_ALIGNMENT
  or PATH_C_BLOCKED

secret_scan_passed =
  YES / NO

github_main_synchronized =
  YES / NO

project_source_import_status =
  READY_FOR_GPT_PROJECT_SOURCE_IMPORT
  or BLOCKED

final_gate_recommendation =
  DEEPSEEK_PROJECT_PILOT_ENABLED
  or DEEPSEEK_PROJECT_PILOT_BLOCKED
```

## 24. Rollback

If later rejected:

- stop wrapper use for this project;
- restore a replaced wrapper from verified backup;
- remove a newly created wrapper only under a later explicit cleanup task;
- restore project-local config when changed;
- do not modify the Windows User-scope credential;
- do not weaken filtering or modify worker core;
- revert governance only through a new Git task;
- preserve 0024AN reports;
- continue GPT-5.6-only operation.

## 25. Next gate

After GPT acceptance, later tasks may opt into the wrapper-based DeepSeek worker only with explicit allowed paths and GPT-5.6 review.

The next gameplay gate remains owner subjective playthrough of sequences 1–12. It must use a later task identity and must not start under Task 0024AN.
