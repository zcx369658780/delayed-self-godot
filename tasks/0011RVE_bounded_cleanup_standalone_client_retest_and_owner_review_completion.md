# Task 0011RVE — Bounded cleanup, standalone-client retest, and owner-review completion

- Status: `READY`
- Gate: `DIAGNOSTIC + HUMAN EVIDENCE / WINDOW SURFACE DISCRIMINATION`
- Repository: `zcx369658780/delayed-self-godot`
- Expected branch: `main`
- Expected local root: `D:\Delayed_Self`
- Issued by: GPT Project Sources advisor
- Date: 2026-07-16
- Parent task: `tasks/0011RV_short_owner_window_fill_retest.md`
- Prior diagnostic: `tasks/0011RVD_baseline_regression_and_expected_stderr_diagnosis.md`
- Accepted implementation: `a07c4be075aaa5c57e9d48869392f29dadaaa1d5`
- Adjudication: `docs/reports/0011RV_GPT_P2_AND_DIRTY_WORKTREE_ADJUDICATION.md`

## 1. Objective

Safely recover from Godot-generated worktree changes, distinguish editor/host preview behavior from the standalone native game client, and complete the authenticated-owner Task 0011RV review without changing implementation.

Known facts:

- two fresh aggregate runs exited `0` with all seven markers and `314 assertions / 9 vectors`;
- the former right/bottom asymmetric gray L-shaped remainder is gone;
- state and input remained normal;
- the owner observed substantial dark unused area around a centered 960×540 presentation on the tested surface;
- the owner agrees to proceed toward Level 6, but material P2 requires explicit GPT adjudication;
- a Godot process unexpectedly rewrote tracked `project.godot` and generated untracked `.gd.uid` files;
- no owner-review documents, commit, or push were created.

This task authorizes only:

1. bounded evidence capture of the dirty worktree;
2. exact cleanup of confirmed Godot-generated changes;
3. standalone native-client retest;
4. completion of the Task 0011RV owner-review documents;
5. one documentation-only commit and normal push.

It does not authorize code, project-setting, scene, level, test, asset, or gameplay changes.

## 2. Human prerequisite

Before Codex performs cleanup, the authenticated owner must close:

- the current Godot game window;
- any Godot editor window for `D:\Delayed_Self`;
- any embedded-game preview using this project.

Codex must then run:

```powershell
Get-Process godot* -ErrorAction SilentlyContinue |
    Select-Object Id, ProcessName, Path, StartTime
```

If any Godot process remains and Codex cannot prove it is unrelated to this repository, stop and ask the owner to close it. Do not use `Stop-Process` automatically.

## 3. Mandatory live Git gate

Before cleanup:

```powershell
Get-Location
git branch --show-current
git rev-parse HEAD
git rev-parse origin/main
git remote -v
git status --short --untracked-files=all
git log -30 --oneline --decorate
godot --version
Get-Command godot | Format-List Source,Version,CommandType
```

Required:

- root is exactly `D:\Delayed_Self`;
- branch is `main`;
- origin is the expected repository;
- local `HEAD` contains this task and the adjudication;
- Godot is the accepted 4.7 stable executable;
- no user-authored work is present.

If local is behind and the only local changes are the incident files described below, do not merge until bounded cleanup has restored a clean worktree. After cleanup, use only:

```powershell
git fetch origin
git merge --ff-only origin/main
```

Stop on divergence, conflict, wrong root/remote, unknown tracked changes, or uncertainty about file ownership.

## 4. Required reads

Read:

1. `AGENTS.md`;
2. current startup/active-task/handoff documents;
3. this task;
4. `docs/reports/0011RV_GPT_P2_AND_DIRTY_WORKTREE_ADJUDICATION.md`;
5. `tasks/0011RV_short_owner_window_fill_retest.md`;
6. `tasks/0011RVD_baseline_regression_and_expected_stderr_diagnosis.md`;
7. `docs/reports/0011R_GPT_FINAL_ACCEPTANCE.md`;
8. `docs/reports/0011R_PHYSICAL_WINDOW_FILL_REPAIR_REPORT.md`;
9. evidence/privacy/Godot-safety/independent-review rules.

Before any cleanup, print a concise plan containing:

- exact dirty paths;
- tracked versus untracked classification;
- exact `project.godot` diff summary;
- cleanup commands proposed path by path;
- standalone launch command;
- owner questions;
- post-run second-cleanup plan;
- commit boundary and stop conditions.

## 5. External incident evidence

Authorized external root:

```text
D:\Delayed_Self_Evidence\0011RVE_cleanup_and_standalone_retest\
```

Before changing the worktree, record externally:

- `git status --short --untracked-files=all`;
- `git diff -- project.godot`;
- `git diff --stat`;
- `git ls-files --stage -- project.godot`;
- SHA-256 of working-tree `project.godot` and `HEAD:project.godot`;
- exact list, sizes, timestamps, and SHA-256 of every untracked `.gd.uid`;
- current Godot process list;
- the prior screenshot reference and full SHA-256 supplied by the existing evidence index, if available.

Do not copy unrelated files or capture the full desktop automatically.

## 6. Strict cleanup authorization

### 6.1 Tracked `project.godot`

Targeted restore is authorized only when all of the following are true:

- `project.godot` is the only modified tracked file;
- its change occurred during the Godot diagnostic/retest process;
- no owner or Codex implementation edit was made after the accepted baseline;
- the complete diff has been preserved externally;
- current `HEAD` contains the accepted Task 0011R settings;
- no other tracked path is modified.

Then use exactly:

```powershell
git restore --source=HEAD --worktree -- project.godot
```

Do not use checkout, reset, restore on a directory, staged restore, or broad pathspecs.

If any other tracked file is modified, stop with:

```text
BLOCKED_UNEXPECTED_TRACKED_WORKTREE_CHANGE
```

### 6.2 Untracked `.gd.uid`

Deletion is authorized only for individually enumerated files that satisfy all of:

- path is inside `D:\Delayed_Self`;
- filename ends exactly with `.gd.uid`;
- `git ls-files --error-unmatch -- <exact path>` confirms it is not tracked;
- it appeared during the Godot process incident;
- its metadata and SHA-256 were recorded externally;
- it is not referenced by an accepted tracked file as a required committed artifact.

Delete each with an explicit literal path, for example:

```powershell
Remove-Item -LiteralPath '<exact individual path>'
```

Forbidden:

- `git clean`;
- wildcards;
- recursive deletion;
- deleting `.godot`;
- deleting all `.uid` files by pattern;
- modifying `.gitignore`;
- establishing a permanent track/ignore policy.

If an unexpected untracked file is not an individually verified `.gd.uid`, stop with:

```text
BLOCKED_UNEXPECTED_UNTRACKED_WORKTREE_CHANGE
```

### 6.3 Clean-baseline requirement

After cleanup:

```powershell
git status --short --untracked-files=all
git diff --check
git rev-parse HEAD
git rev-parse origin/main
```

The worktree must be exactly clean before any standalone retest.

## 7. Standalone-client discrimination

The prior material-P2 observation must not be adjudicated from an embedded editor/host preview alone.

Launch the product as a separate native game process from PowerShell using the accepted executable:

```powershell
$Godot = (Get-Command godot).Source
$Game = Start-Process -FilePath $Godot `
    -ArgumentList @('--path', 'D:\Delayed_Self') `
    -WorkingDirectory 'D:\Delayed_Self' `
    -PassThru
```

Requirements:

- no `--editor`;
- no `--headless`;
- no embedded-game button;
- no Codex Browser or in-app browser;
- no editor viewport used as product evidence;
- verify a separate native game window/process exists.

Record whether the prior screenshot came from:

- `GODOT_EDITOR_EMBEDDED_PREVIEW`;
- `HOSTED_PREVIEW_OTHER`;
- `STANDALONE_NATIVE_GAME_WINDOW`;
- or `NOT_PROVIDED`.

## 8. Short owner protocol

Use the already accepted Task 0011RV protocol on the standalone native game window:

1. inspect Main Menu at startup;
2. maximize or enlarge to a large 16:9 or near-16:9 client;
3. open Level Select;
4. enter Tutorial 0 normally;
5. open and close `H` Help;
6. resize once to a visibly non-16:9 wide or tall client;
7. return to a large 16:9 shape;
8. submit one movement input.

Ask and record exact answers:

1. Does the standalone native game content fill the enlarged 16:9 client?
2. Is the former right/bottom gray L-shaped region gone?
3. Does the standalone content remain only a small centered 960×540 block?
4. At non-16:9 size, are bars symmetric and intentionally dark?
5. Do Main Menu, Level Select, Gameplay, and Help scale consistently?
6. Did resize change route, level, turn, history, Help state, or input?
7. Did any input drop, duplicate, reorder, or synthesize?
8. Was the earlier material P2 observed only in embedded/hosted preview, or also in standalone?
9. Does the owner still agree to proceed to difficult Level 6 with any remaining P2 deferred?
10. Is any P0, P1, or blocking P2 present?

Missing details remain `NOT_PROVIDED`.

## 9. P2 classification

Choose exactly one:

### Branch A

```text
EMBEDDED_PREVIEW_ONLY_NOT_PRODUCT_WINDOW_BLOCKER
```

Use when standalone fills/scales correctly and the small centered presentation occurs only in an embedded/hosted preview.

### Branch B

```text
MATERIAL_P2_ACCEPTED_AS_DEFERRED_PRESENTATION_RISK_PENDING_GPT_FINAL_ADJUDICATION
```

Use when standalone also retains substantial centered unused area, but:

- P0=0;
- P1=0;
- state/input are healthy;
- asymmetric L-shaped defect is closed;
- game remains usable;
- owner explicitly agrees to proceed.

This branch recommends but does not authorize Level 6.

### Branch C

```text
STANDALONE_WINDOW_BLOCKER_REMAINS
```

Use when standalone is clipped, asymmetric, inconsistent, unusable, or state/input regress. Do not recommend Level 6.

## 10. Post-run generated-file cleanup

After closing the standalone game process, inspect the worktree again.

If the same categories reappear:

- capture their second-wave metadata/diffs externally;
- apply the same exact targeted `project.godot` restore and individually enumerated `.gd.uid` deletion rules;
- require a clean worktree before writing review documents.

If any new category of tracked or untracked file appears, stop rather than broaden cleanup.

## 11. Required review documents

Only after a clean worktree and completed owner protocol, create:

```text
docs/reviews/0011RV_OWNER_WINDOW_FILL_RETEST.md
docs/reports/0011RV_OWNER_WINDOW_FILL_RETEST_REPORT.md
```

Record:

- reviewer `authenticated_project_owner`;
- status `NOT_FRESH_NOT_BLIND_OWNER_WINDOW_FILL_RETEST`;
- accepted implementation commit;
- diagnostic result: two runs exit 0, seven markers, 314/9;
- previous false blocker classification;
- exact dirty-worktree incident and bounded cleanup;
- embedded/hosted versus standalone surface classification;
- direct owner answers;
- P0–P3 counts;
- selected P2 branch;
- screenshot/evidence hashes and external index;
- no implementation changes;
- non-claims;
- recommendation for GPT final adjudication.

Update only narrowly necessary current startup/task/index/plan/handoff/project-memory Markdown files.

Do not modify any prior report, acceptance, task, code, project setting, test, scene, level, catalog, schema, asset, or rule file.

## 12. Regression authority

Do not rerun the full aggregate suite unless needed to verify that cleanup did not change the baseline. The accepted diagnostic result is:

```text
TASK_0003_TESTS_PASS assertions=314 vectors=9
TASK_0006_APP_SHELL_TESTS_PASS
TASK_0007_TUTORIAL_LEVELS_TESTS_PASS
TASK_0008_PROGRESSIVE_HUD_TESTS_PASS
TASK_0009AR_LEVELS_4_5_TESTS_PASS
TASK_0011_PRESENTATION_RECOVERY_TESTS_PASS
TASK_0011R_WINDOW_FILL_TESTS_PASS
```

If rerun, expected negative-path `LEVEL_ID_MISMATCH` stderr is not a failure by itself; native exit code and markers are authoritative.

## 13. Git discipline

Before staging:

```powershell
git status --short --untracked-files=all
git diff --check
git diff --stat
```

The only staged paths may be the two new review/report files and narrowly necessary current Markdown documents.

Stage explicit files only. Commit exactly once:

```text
docs: complete Delayed Self standalone window owner retest
```

Then:

```powershell
git fetch origin
```

Require no remote drift from the task baseline plus authorized task/adjudication commits. Push normally to `origin/main`.

No rebase, amend, force-push, reset, broad restore, broad staging, or merge commit.

## 14. Terminal verdicts

After a successful documentation-only commit and push:

```text
OWNER_STANDALONE_WINDOW_RETEST_RECORDED_FOR_GPT_REVIEW
```

If cleanup cannot be proven safe:

```text
BLOCKED_GENERATED_FILE_CLEANUP_NOT_PROVABLY_SAFE
```

If standalone testing reveals a blocking product-window defect:

```text
BLOCKED_STANDALONE_WINDOW_DEFECT_CONFIRMED
```

If the owner cannot complete the standalone protocol:

```text
BLOCKED_OWNER_STANDALONE_RETEST_INCOMPLETE
```
