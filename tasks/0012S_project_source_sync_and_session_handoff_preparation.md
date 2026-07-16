# Task 0012S — Project-source synchronization and session-handoff preparation

- Status: `READY`
- Gate: `DOCUMENTATION / PROJECT SOURCE CHECKPOINT`
- Repository: `zcx369658780/delayed-self-godot`
- Expected branch: `main`
- Expected local root: `D:\Delayed_Self`
- Issued by: GPT Project Sources advisor
- Date: 2026-07-16
- Prior accepted gate: `TASK_0012_STAGGERED_DOORS_ACCEPTED_INTERNAL_PLAYABLE`
- Accepted implementation commit: `1e43e9baa82a578fdb14f556e4895d42863513d9`
- Acceptance artifact: `docs/reports/0012_GPT_FINAL_ACCEPTANCE.md`

## 1. Objective

Synchronize the repository's current project-source documents after Task 0012 acceptance and prepare a clean continuation point for a ChatGPT/Codex session handoff.

This is documentation-only. It must not implement the next review, Level 7, assets, or any runtime change.

The synchronization must:

1. record Task 0012 as GPT accepted at `INTERNAL_PLAYABLE`;
2. record the six-level catalog and exact Level 6 evidence;
3. preserve the next recommended gate as a separately authorized fresh/independent Level 6 sequence review;
4. add the durable Codex task-dispatch rule requested by the project owner;
5. leave startup, active-task, plan, index, handoff, and memory documents mutually consistent;
6. produce one concise synchronization report;
7. end at a clean repository state ready for session handoff.

## 2. Mandatory startup gate

Before any write:

```powershell
Get-Location
git branch --show-current
git rev-parse HEAD
git rev-parse origin/main
git remote -v
git status --short --untracked-files=all
git log -28 --oneline --decorate
```

Required:

- root is exactly `D:\Delayed_Self`;
- branch is `main`;
- origin is the expected repository;
- worktree is fully clean;
- local `HEAD` and `origin/main` contain this task and `docs/reports/0012_GPT_FINAL_ACCEPTANCE.md`.

If clean local `main` is behind, use only:

```powershell
git fetch origin
git merge --ff-only origin/main
```

Stop on divergence, conflict, unexpected files, wrong root/remote, or inability to fast-forward.

## 3. Required reads

Read:

1. `AGENTS.md`;
2. current startup/active-task/handoff documents;
3. this task;
4. `docs/reports/0012_GPT_FINAL_ACCEPTANCE.md`;
5. `docs/reports/0012_LEVEL_6_STAGGERED_DOORS_REPORT.md`;
6. `docs/level_design/INITIAL_LEVEL_ROADMAP_AND_VALIDATION_MATRIX_CURRENT.md`;
7. `docs/level_design/FIVE_LEVEL_DIFFICULTY_RECOVERY_AND_LEVELS_6_8_PLAN.md`;
8. `docs/project_memory.md`;
9. current documentation index and development plan.

Before editing, print the exact documentation files selected and the facts to synchronize.

## 4. Durable task-dispatch rule

Add the following durable project rule to `docs/project_memory.md` in concise language:

> GitHub task files are the complete execution-authorization carrier. Every task file must contain the applicable scope, constraints, acceptance criteria, Git discipline, stop conditions, and terminal verdict. The prompt sent to local Codex should therefore default to a minimal instruction naming the task file, normally: `请读取并严格执行： tasks/<task-file>.md`. Add prompt text beyond that only when a live Git/worktree deviation, unresolved blocker, human prerequisite, or safety fact is not yet represented in the task file.

Also preserve the existing rule that Codex prompts are placed in one plain Markdown code block when shown to the owner.

Do not reinterpret this rule as permission to make task files incomplete. The task file remains the authoritative detailed specification; the launch prompt becomes short because the details already exist there.

## 5. Accepted facts to synchronize

Record without inflation:

- Task 0012 verdict: `TASK_0012_STAGGERED_DOORS_ACCEPTED_INTERNAL_PLAYABLE`;
- implementation commit: `1e43e9baa82a578fdb14f556e4895d42863513d9`;
- acceptance commit/artifact present on current `main`;
- six formal catalog entries;
- Level 6 is the sole current catalog final entry and unlocks after Level 5;
- Level 6 formal facts: one delay-3 ECHO, two Plates, two distinct dependency Doors;
- `L*=15`, `N*=4 EXACT`, visited `6772`, frontier `1179`;
- Level 6 SHA-256 `3f14c19b50775e36dd5b52664798381cf1292b0a30b377641c03435f45696bc8`;
- two open-snapshot Door windows and complete no-ECHO/Plate controls;
- aggregate exit `0`, `349 assertions / 9 vectors`, eight markers;
- Levels 1–5 remain accepted and unchanged;
- Task 0012 is machine/internal evidence, not fresh-player, candidate, balance, fun, export, or release acceptance;
- next recommended gate: fresh/independent Level 6 sequence review, not yet authorized;
- Level 7, assets/fonts/audio/narrative, Gate, persistence, export, and release remain separately gated;
- WAIT remains `DEFERRED_VALIDATION_RESEARCH`;
- latched/one-shot Gate remains `DRAFT_NOT_ACCEPTED`.

## 6. Authorized files

Create:

```text
docs/reports/0012S_PROJECT_SOURCE_SYNC_REPORT.md
```

Update only the necessary subset of:

```text
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/level_design/INITIAL_LEVEL_ROADMAP_AND_VALIDATION_MATRIX_CURRENT.md
docs/level_design/FIVE_LEVEL_DIFFICULTY_RECOVERY_AND_LEVELS_6_8_PLAN.md
```

Do not modify `AGENTS.md` unless a contradiction makes the durable rule impossible to record accurately. If such a contradiction exists, stop rather than broaden scope.

Do not modify any task, prior report/acceptance, source, project setting, scene, formal level, catalog, schema, test, fixture, asset, import, audio, plugin, dependency, or project rule file.

## 7. Current-state wording

After synchronization, current documents must clearly state:

- Task 0012 is accepted at `INTERNAL_PLAYABLE`;
- no implementation task is currently authorized;
- the repository is paused at a session-handoff checkpoint;
- the next recommended gate is fresh/independent Level 6 review;
- a future GPT advisor must issue a new GitHub task before any review execution or implementation;
- launch prompts should be minimal because the GitHub task file contains all detailed requirements.

Do not mark a future review task as active or ready unless it has actually been issued.

## 8. Synchronization report

`docs/reports/0012S_PROJECT_SOURCE_SYNC_REPORT.md` must include:

- starting and final Git facts;
- exact files changed;
- Task 0012 accepted facts synchronized;
- the new durable minimal-prompt/task-file-authority rule;
- current six-level state;
- next recommended but unauthorized gate;
- protected surfaces and non-claims;
- confirmation that no tests were required because no executable or formal data changed;
- session-handoff readiness statement.

## 9. Validation

Before staging:

```powershell
git status --short --untracked-files=all
git diff --check
git diff --stat
```

Check:

- only authorized Markdown paths changed;
- all internal links added resolve;
- all current documents agree on Task 0012 acceptance and the next gate;
- no future task is falsely authorized;
- the task-dispatch rule appears in `docs/project_memory.md`;
- no implementation/formal-data/test path changed.

No Godot regression run is required. Do not launch Godot.

## 10. Git discipline

Stage explicit files only. Commit exactly once:

```text
docs: sync Delayed Self after Level 6 acceptance
```

Then fetch and require no remote drift. Push normally to `origin/main`.

Forbidden:

- broad staging;
- rebase;
- amend;
- force-push;
- reset;
- broad restore;
- `git clean`;
- merge commit.

## 11. Terminal verdict

After successful commit and push:

```text
PROJECT_SOURCE_SYNC_READY_FOR_SESSION_HANDOFF
```

On any scope or Git problem, stop without partial commit and report the exact blocker.
