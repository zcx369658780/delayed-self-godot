# Task 0015RC — Literal generated-file cleanup and Task 0015R resume

- Status: `READY`
- Gate: `WORKTREE SAFETY RECOVERY / TASK 0015R CONTINUATION`
- Repository: `zcx369658780/delayed-self-godot`
- Expected branch: `main`
- Expected local root: `D:\Delayed_Self`
- Issued by: GPT Project Sources advisor
- Date: 2026-07-17
- Parent task: `tasks/0015R_level_7_transition_derived_divergence_feedback_repair.md`
- Parent task publication: `6a30403d6f7f456c1e2c7a580a886344da66569f`
- Reported terminal blocker: `BLOCKED_UNEXPECTED_WORKTREE_CHANGE`
- Reported staged state: exactly 15 Task 0015R-authorized paths; `git diff --cached --check` passed
- Reported unexpected state: unstaged `project.godot` rewrite plus exactly 30 untracked `.gd.uid` files
- Reported process state: no residual Godot process

## 1. Objective and adjudication

Safely remove only the known Godot-generated worktree pollution while preserving the complete pre-existing Task 0015R staged patch byte-for-byte, then finish the already-authorized Task 0015R commit and push without rerunning Godot.

The reported stop is accepted as correct. This task provides the missing explicit authorization for exactly two cleanup classes:

1. restore the **worktree copy only** of the literal tracked path:

```text
project.godot
```

from current `HEAD`, provided it is not staged and is the only unstaged tracked change;

2. delete, one by one with literal-path semantics, exactly the 30 currently untracked files whose repository-relative names end in:

```text
.gd.uid
```

provided they are the complete untracked set, are individually frozen and printed before deletion, and no other untracked path exists.

This is not broad cleanup authority. It does not authorize `git clean`, recursive deletion, wildcard deletion, broad restore, reset, checkout, stash, unstaging, restaging, implementation edits, test reruns, or any change to the existing staged patch.

## 2. Known non-clean startup exception

For this task only, the required startup state is intentionally dirty and must match the reported blocker:

- Task 0015R implementation/documentation changes are already staged;
- exactly 15 staged paths exist;
- `project.godot` is modified only in the worktree and is not staged;
- exactly 30 untracked `.gd.uid` paths exist;
- no other staged, unstaged, untracked, conflicted, ignored-sensitive, or unexpected path exists;
- no Godot process remains.

Do not interpret the dirty state itself as a new blocker when it matches this contract exactly.

Any material difference from this contract is a blocker.

## 3. Safe acquisition of this task with a dirty index

Before cleanup, run:

```powershell
Get-Location
git branch --show-current
git rev-parse HEAD
git rev-parse origin/main
git remote -v
git status --short --untracked-files=all
git diff --cached --check
git diff --cached --name-only
git diff --name-only
git log -12 --oneline --decorate
Get-Process | Where-Object { $_.ProcessName -match 'godot' }
```

Expected before fetch:

- root `D:\Delayed_Self`;
- branch `main`;
- expected origin;
- local `HEAD` normally remains the parent publication `6a30403d6f7f456c1e2c7a580a886344da66569f`;
- index contains exactly 15 staged Task 0015R-authorized paths;
- `git diff --cached --check` passes;
- only `project.godot` appears in unstaged tracked diff;
- exactly 30 untracked `.gd.uid` files appear;
- no Godot process appears.

Then:

```powershell
git fetch origin
```

Require that `origin/main` is ahead of local `HEAD` only by the commit(s) that add this Task 0015RC file, with no modification to any staged Task 0015R path or `project.godot`.

Inspect:

```powershell
git diff --name-status HEAD..origin/main
git log --oneline --decorate HEAD..origin/main
```

The remote-only diff must contain only:

```text
tasks/0015RC_literal_generated_file_cleanup_and_repair_resume.md
```

Then use only:

```powershell
git merge --ff-only origin/main
```

A fast-forward is authorized only if Git preserves the dirty index/worktree and succeeds without conflict. Do not stash, reset, commit a temporary snapshot, create a branch, or use another synchronization method.

If fast-forward fails, changes the staged patch, or encounters any overlap, stop with:

```text
BLOCKED_DIRTY_INDEX_SAFE_FAST_FORWARD_FAILED
```

## 4. Required reads

After the safe fast-forward, read:

1. `AGENTS.md`;
2. current startup and active-task documents from the staged/index version as appropriate;
3. this Task 0015RC;
4. parent Task 0015R;
5. `docs/reports/0015D_GPT_FINAL_ACCEPTANCE.md`;
6. `docs/level_design/LEVEL_7_FALSE_UNSOLVABLE_REPAIR_PLAN_CURRENT.md`;
7. the staged Task 0015R implementation report;
8. repository Git-safety and Godot-safety rules relevant to generated-file cleanup.

Do not edit any file while reading.

## 5. Freeze and fingerprint the staged patch

Before any restore or deletion, create an external cleanup evidence directory only:

```text
D:\Delayed_Self_Evidence\0015RC_literal_cleanup\
```

It must not be staged.

Capture the staged patch and inventory without changing the index:

```powershell
$Evidence = 'D:\Delayed_Self_Evidence\0015RC_literal_cleanup'
New-Item -ItemType Directory -Force -Path $Evidence | Out-Null

git diff --cached --binary | Set-Content -LiteralPath (Join-Path $Evidence 'staged_before.patch') -Encoding utf8
git diff --cached --name-status | Set-Content -LiteralPath (Join-Path $Evidence 'staged_before_name_status.txt') -Encoding utf8
git diff --cached --stat | Set-Content -LiteralPath (Join-Path $Evidence 'staged_before_stat.txt') -Encoding utf8

$StagedPatchHashBefore = (Get-FileHash -LiteralPath (Join-Path $Evidence 'staged_before.patch') -Algorithm SHA256).Hash
$StagedNameHashBefore = (Get-FileHash -LiteralPath (Join-Path $Evidence 'staged_before_name_status.txt') -Algorithm SHA256).Hash
```

Also record:

```powershell
git diff --cached --check
git diff --cached --name-only
```

Required:

- exactly 15 staged paths;
- every staged path is authorized by Task 0015R;
- neither `project.godot` nor any `.gd.uid` is staged;
- no conflict/unmerged entry exists;
- no staged patch error exists.

Do not run `git reset`, `git restore --staged`, `git add`, or any index mutation during cleanup.

## 6. Exact tracked-file cleanup authorization

Before restoring, require:

```powershell
git diff --cached --name-only -- project.godot
git diff --name-only
git diff --check
```

Required:

- `git diff --cached --name-only -- project.godot` is empty;
- `git diff --name-only` contains exactly `project.godot` and no other path;
- `project.godot` exists as a tracked file in `HEAD`;
- the file is not conflicted or deleted;
- no process is using Godot.

Then restore only the worktree copy, with this exact command:

```powershell
git restore --worktree --source=HEAD -- project.godot
```

This command is explicitly authorized despite the normal broad-restore prohibition because it names one literal tracked path and excludes the index.

Immediately verify:

```powershell
git diff --name-only -- project.godot
git diff --cached --name-only -- project.godot
git hash-object project.godot
git rev-parse HEAD:project.godot
```

Required:

- no remaining worktree or staged diff for `project.godot`;
- worktree blob hash equals `HEAD:project.godot`.

If any condition fails, stop without further cleanup:

```text
BLOCKED_PROJECT_GODOT_LITERAL_RESTORE_UNSAFE
```

## 7. Exact untracked `.gd.uid` cleanup authorization

Enumerate the untracked set from Git, not from a recursive filesystem wildcard:

```powershell
$AllUntracked = @(git ls-files --others --exclude-standard)
$UidPaths = @($AllUntracked | Where-Object { $_ -like '*.gd.uid' } | Sort-Object -Unique)
```

Print every entry and write the frozen list:

```powershell
$UidPaths
$UidPaths | Set-Content -LiteralPath (Join-Path $Evidence 'uid_paths_frozen.txt') -Encoding utf8
```

Before deletion require all of the following:

- `$AllUntracked.Count -eq 30`;
- `$UidPaths.Count -eq 30`;
- every untracked path is in `$UidPaths`;
- every path ends exactly in `.gd.uid`;
- every path is repository-relative and contains no `..` component;
- every path resolves under `D:\Delayed_Self` after canonicalization;
- every path currently exists as a file, not a directory or link/reparse point;
- none is tracked by Git;
- none is staged;
- no other untracked path exists.

For each path, print a literal deletion line and delete it individually:

```powershell
foreach ($RelativePath in $UidPaths) {
    $LiteralPath = Join-Path 'D:\Delayed_Self' $RelativePath
    Write-Host ('REMOVE_LITERAL ' + $RelativePath)
    Remove-Item -LiteralPath $LiteralPath -Force
}
```

The loop is authorized because `$UidPaths` is the already frozen, exactly 30-entry literal list. Do not use `Remove-Item -Recurse`, wildcards in deletion, `git clean`, `cmd /c del`, `Get-ChildItem | Remove-Item`, or delete any parent directory.

After deletion require:

```powershell
$UidPaths | ForEach-Object { Test-Path -LiteralPath (Join-Path 'D:\Delayed_Self' $_) }
git ls-files --others --exclude-standard
git status --short --untracked-files=all
```

Every `Test-Path` result must be `False`, and no untracked path may remain.

If enumeration differs from exactly the authorized set, stop before deletion with:

```text
BLOCKED_UID_LITERAL_SET_MISMATCH
```

If any deletion fails or another untracked path remains, stop with:

```text
BLOCKED_UID_LITERAL_CLEANUP_INCOMPLETE
```

## 8. Prove the staged patch was preserved exactly

After both cleanup steps, recapture the staged patch:

```powershell
git diff --cached --binary | Set-Content -LiteralPath (Join-Path $Evidence 'staged_after.patch') -Encoding utf8
git diff --cached --name-status | Set-Content -LiteralPath (Join-Path $Evidence 'staged_after_name_status.txt') -Encoding utf8

$StagedPatchHashAfter = (Get-FileHash -LiteralPath (Join-Path $Evidence 'staged_after.patch') -Algorithm SHA256).Hash
$StagedNameHashAfter = (Get-FileHash -LiteralPath (Join-Path $Evidence 'staged_after_name_status.txt') -Algorithm SHA256).Hash
```

Require:

```powershell
$StagedPatchHashBefore -eq $StagedPatchHashAfter
$StagedNameHashBefore -eq $StagedNameHashAfter
git diff --cached --check
git diff --cached --name-only
git diff --name-only
git ls-files --others --exclude-standard
git status --short --untracked-files=all
```

Required final pre-commit cleanup state:

- staged patch hash is byte-identical before and after cleanup;
- staged name/status hash is identical;
- exactly the original 15 Task 0015R paths remain staged;
- no unstaged tracked change remains;
- no untracked path remains;
- `project.godot` matches `HEAD`;
- no `.gd.uid` remains;
- no Godot process exists.

If the staged patch differs, stop without commit:

```text
BLOCKED_STAGED_PATCH_CHANGED_DURING_CLEANUP
```

## 9. No Godot rerun and no further implementation edit

All Task 0015R Godot validation and captures were completed before the blocker. This continuation must **not** launch Godot again because doing so may regenerate the same pollution.

Do not edit, stage, unstage, regenerate, reformat, or rewrite any Task 0015R file after the staged-patch preservation check.

Allowed post-cleanup validation is static only:

```powershell
git diff --cached --check
git diff --cached --stat
git diff --cached --name-status
git status --short --untracked-files=all
```

Review the already staged implementation report and test summaries to ensure the required Task 0015R evidence is present. Do not alter it in this continuation task.

If the staged report lacks required evidence or any original test was not actually completed, stop rather than rerun Godot:

```text
BLOCKED_PRECOMMIT_EVIDENCE_INCOMPLETE_NO_RERUN_AUTHORIZED
```

## 10. Commit and push continuation

The cleanup itself creates no repository diff and no separate cleanup commit.

Commit the existing preserved Task 0015R staged patch exactly once with the parent task's authorized message:

```text
fix: expose Delayed Self echo spacing changes
```

Before commit, require:

```powershell
git diff --cached --check
git diff --cached --name-only
git status --short --untracked-files=all
```

Then commit.

Immediately after commit:

```powershell
git status --short --untracked-files=all
git show --stat --oneline --decorate --summary HEAD
git show --name-only --format= HEAD
```

Require:

- exactly the original 15 Task 0015R paths are in the commit;
- no `project.godot` or `.gd.uid` path is committed;
- worktree is clean.

Then:

```powershell
git fetch origin
git rev-parse HEAD^
git rev-parse origin/main
git status --short --untracked-files=all
```

Require `HEAD^ == origin/main`, meaning the only new local commit is the Task 0015R implementation commit on top of this Task 0015RC publication point. Stop on any remote drift.

Push normally:

```powershell
git push origin main
```

After push require:

```powershell
git status --short --untracked-files=all
git rev-parse HEAD
git rev-parse origin/main
```

Final requirements:

- clean tracked and untracked worktree;
- `HEAD == origin/main`;
- no Godot process;
- no `.gd.uid` path;
- `project.godot` equals committed `HEAD`;
- Task 0015R report and evidence remain the authoritative implementation evidence.

## 11. Protected surfaces and forbidden actions

This task does not authorize:

- modifying any staged Task 0015R file;
- modifying or staging `project.godot`;
- modifying `.gitignore`;
- deleting any path other than the frozen 30 literal `.gd.uid` files;
- any recursive or wildcard deletion;
- `git clean`;
- `git reset` of any form;
- broad `git restore` or checkout;
- `git restore --staged`;
- stash;
- amend, rebase, squash, force-push, merge commit, or temporary commit;
- running Godot, import, editor, capture, aggregate, focused test, or solver again;
- changing formal data, source scope, tests, documentation content, evidence, assets, settings, or project rules;
- activating the geometry fallback;
- starting owner retest or Level 8.

## 12. Terminal verdicts

After successful literal cleanup, preserved-patch commit, push, and clean final audit, return the parent task's normal verdict:

```text
LEVEL_7_DIVERGENCE_FEEDBACK_REPAIR_READY_FOR_GPT_REVIEW
```

Also report:

- cleanup classification: `AUTHORIZED_LITERAL_GENERATED_FILE_CLEANUP_COMPLETED`;
- Task 0015R commit SHA;
- staged patch before/after SHA-256 equality;
- exact count of restored tracked paths (`1`);
- exact count of deleted literal UID paths (`30`);
- committed path count (`15`);
- confirmation that `project.godot` and `.gd.uid` were not committed;
- final clean Git state and `HEAD == origin/main`;
- external cleanup evidence root.

Use a blocker instead when applicable:

```text
BLOCKED_DIRTY_INDEX_SAFE_FAST_FORWARD_FAILED
BLOCKED_PROJECT_GODOT_LITERAL_RESTORE_UNSAFE
BLOCKED_UID_LITERAL_SET_MISMATCH
BLOCKED_UID_LITERAL_CLEANUP_INCOMPLETE
BLOCKED_STAGED_PATCH_CHANGED_DURING_CLEANUP
BLOCKED_PRECOMMIT_EVIDENCE_INCOMPLETE_NO_RERUN_AUTHORIZED
BLOCKED_REMOTE_DRIFT
```

No terminal verdict is final GPT acceptance.

## 13. Next gate

If Task 0015R commits and pushes successfully, GPT reviews the exact implementation diff and evidence. Only after GPT acceptance may a separate authenticated-owner Level 7 retest be issued. Level 8 remains blocked.