# Task 0011RVD — Baseline regression and expected-stderr diagnosis

- Status: `READY`
- Gate: `DIAGNOSTIC / OWNER-RETEST PREFLIGHT`
- Repository: `zcx369658780/delayed-self-godot`
- Expected branch: `main`
- Expected local root: `D:\Delayed_Self`
- Issued by: GPT Project Sources advisor
- Date: 2026-07-16
- Blocked parent task: `tasks/0011RV_short_owner_window_fill_retest.md`
- Accepted implementation: `a07c4be075aaa5c57e9d48869392f29dadaaa1d5`
- Parent task publication: `2187d7a1aaf7af0518c0f770a6c76b280d013698`
- Blocker adjudication: `docs/reports/0011RV_GPT_BASELINE_BLOCKER_ADJUDICATION.md`

## 1. Objective

Determine whether the reported `BLOCKED_BASELINE_REGRESSION` is:

1. a genuine regression or runtime/toolchain failure; or
2. a false blocker caused by treating the suite's intentional `LEVEL_ID_MISMATCH` negative-path stderr as the causal failure.

This task is diagnostic-only. Do not edit, stage, commit, restore, delete, regenerate, import, or otherwise modify repository files.

If and only if the baseline is proven healthy, continue immediately into the already-authorized short owner protocol from Task 0011RV and return `READY_FOR_OWNER_WINDOW_FILL_RETEST`.

## 2. Source fact that must not be misinterpreted

The aggregate suite intentionally performs a reusable-Gameplay parity-failure test:

```text
level_id=tutorial_echo_bridge
level_path=tutorial_reach_exit.json
```

The expected result is:

```text
load_error == LEVEL_ID_MISMATCH
no partial Gameplay level/state
```

The Gameplay script emits this expected result through `printerr`. Therefore:

```text
LEVEL_ID_MISMATCH
```

may legitimately appear on stderr during a passing aggregate run.

Do not classify the run as failed merely because that string appears. The authoritative results are the native process exit code, failed assertions/script errors, and final seven markers.

## 3. Mandatory startup gate

Before running Godot:

```powershell
Get-Location
git branch --show-current
git rev-parse HEAD
git rev-parse origin/main
git remote -v
git status --short --untracked-files=all
git log -28 --oneline --decorate
godot --version
Get-Command godot | Format-List Source,Version,CommandType
```

Required:

- absolute root `D:\Delayed_Self`;
- branch `main`;
- expected origin;
- clean tracked and untracked worktree;
- local `HEAD == origin/main` and both contain this diagnostic task and blocker adjudication;
- Godot `4.7.stable.steam.5b4e0cb0f`, unless the live accepted environment record documents an equivalent accepted executable.

If clean local `main` is behind, use only:

```powershell
git fetch origin
git merge --ff-only origin/main
```

Stop on divergence, conflict, unexpected files, wrong root/remote, inability to fast-forward, or materially different Godot executable/version.

## 4. Required reads

Read in order:

1. `AGENTS.md`;
2. `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`;
3. `docs/CODEX_ACTIVE_TASK_CURRENT.md`;
4. this task;
5. `docs/reports/0011RV_GPT_BASELINE_BLOCKER_ADJUDICATION.md`;
6. `tasks/0011RV_short_owner_window_fill_retest.md`;
7. `docs/reports/0011R_GPT_FINAL_ACCEPTANCE.md`;
8. `docs/reports/0011R_PHYSICAL_WINDOW_FILL_REPAIR_REPORT.md`;
9. `tests/run_all.gd`, especially `_test_catalog_failures`, `_test_gameplay_configuration_failure`, `_expect_catalog_code`, `_expect`, and final marker emission;
10. `scripts/gameplay/vertical_slice.gd`, especially its parity mismatch and `printerr` path;
11. the accepted external evidence index/logs for Task 0011R, only to recover the exact successful aggregate command and executable identity.

Before execution, print a concise diagnosis plan stating:

- exact Godot executable;
- exact aggregate command recovered from accepted evidence;
- why `LEVEL_ID_MISMATCH` can be expected stderr;
- stdout/stderr/exit-code capture method;
- marker and failure-search rules;
- no-write boundary;
- branch outcomes.

## 5. No-write and privacy boundary

Repository writes are forbidden, including documentation updates.

Do not:

- edit code, tests, project settings, scenes, levels, catalog, schemas, fixtures, or docs;
- clear or delete `.godot`, user data, import caches, sessions, configuration, or evidence;
- run Godot with an editor/import mode that writes repository files;
- stage, commit, or push;
- launch the owner protocol before the baseline is proven healthy;
- capture the full desktop automatically.

Authorized external diagnostic root:

```text
D:\Delayed_Self_Evidence\0011RVD_baseline_diagnosis\
```

It may contain only bounded stdout/stderr logs, command/exit summaries, file hashes, and a plain-text diagnostic index. Do not commit it.

## 6. Recover and run the exact aggregate command

Prefer the exact executable and argument sequence recorded by the accepted Task 0011R evidence.

If that evidence only records the standard repository command, use exactly:

```powershell
godot --headless --path D:\Delayed_Self --script res://tests/run_all.gd
```

Do not add:

- `--level-id`;
- project-specific user arguments;
- editor mode;
- debug wrappers that alter Godot exit behavior;
- pipes that replace the native process exit code.

### 6.1 Capture method

Run the aggregate suite in a fresh native process with stdout and stderr redirected separately. Use `Start-Process -Wait -PassThru` or an equivalent method that preserves the actual executable exit code.

Illustrative PowerShell shape:

```powershell
$Evidence = 'D:\Delayed_Self_Evidence\0011RVD_baseline_diagnosis'
New-Item -ItemType Directory -Force $Evidence | Out-Null
$Godot = (Get-Command godot).Source
$Stdout = Join-Path $Evidence 'run1.stdout.log'
$Stderr = Join-Path $Evidence 'run1.stderr.log'
$Args = @('--headless', '--path', 'D:\Delayed_Self', '--script', 'res://tests/run_all.gd')
$Process = Start-Process -FilePath $Godot -ArgumentList $Args -WorkingDirectory 'D:\Delayed_Self' -RedirectStandardOutput $Stdout -RedirectStandardError $Stderr -Wait -PassThru
$Process.ExitCode
```

Adapt quoting only as required by PowerShell. Do not alter semantic arguments.

### 6.2 Required analysis after run 1

Record:

- native exit code;
- stdout byte count and SHA-256;
- stderr byte count and SHA-256;
- every line containing `TASK_`, `FAIL`, `ERROR`, `SCRIPT ERROR`, `Parse Error`, `Invalid`, `LEVEL_ID_MISMATCH`, or crash/exception terms;
- count and exact text of all seven required markers;
- whether `TASK_0003_TESTS_FAIL` appears;
- whether the only mismatch line corresponds to the intentional negative-path test;
- whether any Godot process remains after exit.

Do not infer failure from stderr presence alone.

### 6.3 Fresh-process repeat

Run the identical command a second time in a new Godot process, producing separate `run2.stdout.log` and `run2.stderr.log`.

Record the same facts and compare:

- exit codes;
- seven marker sets;
- failure lines;
- stdout/stderr hashes and expected nondeterministic lines such as timestamps, if any;
- level hashes and reported solver metrics.

## 7. Decision branches

### Branch A — baseline healthy

Use this branch only when both runs satisfy all of the following:

- native exit code `0`;
- all seven required markers present exactly once;
- `TASK_0003_TESTS_PASS assertions=314 vectors=9` exact;
- no `TASK_0003_TESTS_FAIL`;
- no unhandled parser/script/runtime error or crash;
- five formal hashes and accepted metrics unchanged;
- any `LEVEL_ID_MISMATCH` occurrence is confined to the intentional negative-path test;
- repository remains clean and unchanged.

Classify:

```text
FALSE_BLOCKER_EXPECTED_NEGATIVE_PATH_STDERR
```

Then, without creating a commit and without rerunning implementation work, continue the existing Task 0011RV short owner protocol. Launch normal AppRoot and return exactly:

```text
READY_FOR_OWNER_WINDOW_FILL_RETEST
```

Wait for the owner's direct answers. Do not pre-fill or infer them.

### Branch B — baseline genuinely fails

Use this branch if either run exits nonzero, lacks any marker, emits `TASK_0003_TESTS_FAIL`, crashes, or has an unhandled parser/script/runtime error.

Identify the first causal failure rather than the last stderr line. Report:

- exact executable and command;
- both native exit codes;
- first failing assertion/error with surrounding lines;
- complete marker presence/absence matrix;
- whether `LEVEL_ID_MISMATCH` was expected or causal;
- whether failure reproduces in both fresh processes;
- Git status and hashes;
- whether accepted Task 0011R evidence used a different executable or command.

Stop exactly with:

```text
BLOCKED_CONFIRMED_BASELINE_REGRESSION
```

Do not edit code or tests. GPT will issue a separately bounded repair only after reviewing the diagnosis.

### Branch C — command/evidence cannot be resolved safely

If the accepted executable/command cannot be recovered, process exit code cannot be captured reliably, or the environment differs materially, stop exactly with:

```text
BLOCKED_BASELINE_DIAGNOSTIC_ENVIRONMENT_UNRESOLVED
```

## 8. Final Git audit

Before any terminal verdict:

```powershell
git status --short --untracked-files=all
git diff --check
git rev-parse HEAD
git rev-parse origin/main
```

Required:

- no repository changes;
- `HEAD == origin/main`;
- external evidence only under the authorized external root.

## 9. Terminal verdicts

Return exactly one of:

```text
READY_FOR_OWNER_WINDOW_FILL_RETEST
```

```text
BLOCKED_CONFIRMED_BASELINE_REGRESSION
```

```text
BLOCKED_BASELINE_DIAGNOSTIC_ENVIRONMENT_UNRESOLVED
```

Include a concise factual summary immediately above the verdict, including both exit codes and marker counts.
