# Task 0001 — Read-only environment and release-target inventory

- Status: `READY`
- Gate: `ENVIRONMENT / READ-ONLY INVENTORY`
- Repository: `zcx369658780/delayed-self-godot`
- Expected branch: `main`
- Expected local root: `D:\Delayed_Self`
- Issued by: GPT Project Sources advisor
- Date: 2026-07-14
- Prior accepted gate: `TASK_0000_PROJECT_BOOTSTRAP_ACCEPTED`
- Prior accepted implementation commit: `67089cc0546a83b2842d2e2fc4985cb9e20f00df`
- Prior acceptance artifact: `docs/reports/0000_GPT_FINAL_ACCEPTANCE.md`

## 1. Objective

Perform a bounded, evidence-first, read-only inventory of the local Godot development environment and release-target readiness. Produce a concise canonical environment record and a decision matrix for the GPT advisor.

This task may write repository documentation only. It must not install, upgrade, download, initialize, launch a writable Godot editor session, create `project.godot`, create gameplay/runtime files, generate imports, export a build, or modify machine configuration.

## 2. Mandatory startup gate

Before any repository write:

```powershell
Get-Location
git branch --show-current
git rev-parse HEAD
git rev-parse origin/main
git remote -v
git status --short --untracked-files=all
git log -5 --oneline --decorate
```

Required conditions:

- absolute root is `D:\Delayed_Self`;
- branch is `main`;
- origin is the expected GitHub repository;
- local `HEAD` and `origin/main` contain this task and the Task 0000 acceptance artifact;
- tracked worktree is clean before Task 0001 edits.

If local is behind and clean, use only:

```powershell
git fetch origin
git merge --ff-only origin/main
```

Stop on divergence, conflict, remote mismatch, unexpected tracked changes, unsafe local root, or inability to obtain this task by fast-forward.

## 3. Required reads

Read in this order:

1. `AGENTS.md`
2. `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`
3. `docs/CODEX_ACTIVE_TASK_CURRENT.md`
4. this task file
5. `docs/reports/0000_GPT_FINAL_ACCEPTANCE.md`
6. `docs/DOC_INDEX_CURRENT.md`
7. `docs/DEVELOPMENT_PLAN_CURRENT.md`
8. `docs/HANDOFF_MASTER_CURRENT.md`
9. `docs/project_memory.md`
10. `docs/project_rules/PROJECT_RULE_GODOT_SAFETY_AND_RELEASE_GATES_CURRENT.md`
11. `docs/project_rules/PROJECT_RULE_EVIDENCE_AND_INDEPENDENT_REVIEW_CURRENT.md`
12. `docs/game_design/DELAYED_SELF_GAME_DESIGN_DOCUMENT_CURRENT.md`

Before inspection, print a concise summary of objective, allowed writes, non-goals, protected surfaces, planned commands, commit policy, and stop conditions.

## 4. Environment inventory scope

Inspect only what is needed to make the next project decisions. Keep command output bounded and redact user-specific noise that is not relevant.

### 4.1 Operating system and hardware

Record:

- Windows edition, version, build, and architecture;
- CPU model and logical core count;
- total physical memory;
- GPU name(s), driver version(s), and reported adapter RAM when available;
- active display resolution(s) and refresh rate(s) when available;
- free space for the project drive and likely export/evidence drive;
- any obvious hardware caveat relevant to a small Godot 2D project.

Preferred read-only sources include bounded `Get-ComputerInfo`, `Get-CimInstance`, `Get-Volume`, and display-related PowerShell/CIM queries. Do not dump full system inventories.

### 4.2 Godot installations

Locate Godot executables using bounded methods:

- `Get-Command godot* -All -ErrorAction SilentlyContinue`;
- `where.exe godot` and likely executable names;
- inspect common install locations and user-supplied PATH entries;
- inspect the configured Codex workspace and common application folders only;
- do not recursively scan entire drives.

For every credible executable, record:

- full path;
- file version metadata;
- output of `--version` or equivalent read-only version command;
- standard versus .NET/Mono build when identifiable;
- console binary availability;
- architecture;
- whether multiple conflicting versions are present.

Do not open the editor UI. Do not pass flags that create a project, import resources, or write editor state.

### 4.3 Export templates and platform readiness

Inspect the normal Godot export-template location(s), including `%APPDATA%\Godot\export_templates`, without modifying them. Record:

- installed template version directories;
- whether any template exactly matches an installed Godot version;
- Windows desktop template presence;
- Web template presence;
- .NET export implications if only a .NET editor is found;
- template/version mismatch;
- status for each platform using only:
  - `AVAILABLE_FOR_LATER_SMOKE_TEST`
  - `LIKELY_AVAILABLE_BUT_UNVERIFIED`
  - `BLOCKED_MISSING_TEMPLATE`
  - `BLOCKED_VERSION_MISMATCH`
  - `NOT_APPLICABLE`
  - `UNKNOWN`

Do not export or create `export_presets.cfg`.

### 4.4 Development tools

Record presence and versions, where available, for:

- Git;
- GitHub CLI;
- PowerShell;
- Python and `pip`;
- Node.js/npm only if already installed;
- FFmpeg;
- ImageMagick;
- common image editors already installed or discoverable without broad scanning;
- archive/hash tools useful for later release evidence;
- any existing Godot-specific test utility already available without installation.

Do not install packages and do not modify PATH or execution policy.

### 4.5 Repository and evidence locations

Confirm:

- canonical repo root `D:\Delayed_Self`;
- repository filesystem type if readily available;
- whether a safe repository-external evidence root already exists;
- candidate evidence root `D:\Delayed_Self_Evidence` and its parent-drive free space;
- whether that candidate conflicts with an existing unrelated directory.

Do not create the evidence directory. Recommend one exact path for GPT/user approval.

### 4.6 Release-target decision matrix

Using only observed local facts and the canonical GDD, prepare a matrix for:

- Windows desktop as primary target;
- Web as optional/backup target.

For each, report:

- local prerequisites observed;
- missing prerequisites;
- what remains unverified because no Godot project exists;
- likely risk level: `LOW`, `MEDIUM`, `HIGH`, or `UNKNOWN`;
- safest next verification after Task 0002/0003;
- no final claim of export readiness.

### 4.7 Decision recommendations, not final freezes

Recommend, with explicit evidence and uncertainty:

- one preferred installed Godot version candidate, if a suitable installation exists;
- whether standard GDScript or .NET should be used;
- a renderer candidate for a small 2D Windows-first project with possible Web support;
- whether Windows should remain the only committed target for the vertical slice;
- whether Web should remain a later compatibility gate;
- one evidence-root path.

These are `RECOMMENDATIONS_FOR_GPT_DECISION`, not frozen project decisions. Do not finalize the renderer or version on Codex authority.

Do not decide art style, logic resolution, final license, independent reviewer, or undo support in this task.

## 5. Safe command rules

Allowed:

- read-only PowerShell/CIM/system-info commands;
- executable `--version` and bounded `--help` queries;
- directory/file metadata listing;
- hash/version inspection;
- Git read commands;
- writing the authorized Markdown files inside the repository.

Forbidden:

- package managers or installers;
- downloads or network retrieval beyond the required `git fetch` safety sync;
- registry writes;
- environment-variable writes;
- PATH changes;
- execution-policy changes;
- editor launch;
- creating or importing a Godot project;
- commands that write Godot user/editor state;
- export/build/test project generation;
- recursive full-drive searches;
- opening private credentials, browser profiles, tokens, SSH keys, or unrelated user files;
- deleting or moving any file.

If a version command unexpectedly writes files, stop and record the event; do not clean it up without authorization.

## 6. Authorized repository writes

Create:

- `docs/environment/DEVELOPMENT_ENVIRONMENT_CURRENT.md`
- `docs/reports/0001_READONLY_ENVIRONMENT_AND_RELEASE_TARGET_INVENTORY_REPORT.md`

Update only as needed:

- `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`
- `docs/CODEX_ACTIVE_TASK_CURRENT.md`
- `docs/DOC_INDEX_CURRENT.md`
- `docs/HANDOFF_MASTER_CURRENT.md`
- `docs/project_memory.md`

Rules for current docs:

- record Task 0000 as GPT accepted;
- point the active/current gate to Task 0001;
- distinguish observed environment facts from frozen project decisions;
- do not claim Godot project initialization or export readiness;
- keep exact version/renderer decisions pending GPT review unless they were previously frozen, which they were not;
- add links to the environment record, Task 0001 report, and Task 0000 acceptance artifact.

Do not modify:

- `AGENTS.md`;
- the canonical GDD;
- the rule seed or split rules;
- Task 0000 or its report;
- Task 0000 acceptance artifact;
- README unless a broken factual statement makes an update necessary, in which case stop and report rather than editing it;
- any runtime/project/source directory.

## 7. Required report structure

`docs/environment/DEVELOPMENT_ENVIRONMENT_CURRENT.md` must be a concise canonical facts-and-decisions table with:

- observation date;
- machine/OS summary;
- installed Godot candidates;
- export-template matrix;
- development-tool matrix;
- drive/evidence-path facts;
- Windows/Web readiness classification;
- recommendations awaiting GPT decision;
- unresolved items;
- exact commands or source categories used, without large raw outputs.

The execution report must include:

- verdict;
- task path;
- branch, start/final HEAD and origin;
- commands run;
- observed facts;
- unavailable or inconclusive checks;
- files created/updated;
- validation;
- protected surfaces not touched;
- whether subagents were used;
- recommended frozen decisions for GPT review;
- recommended next gate.

## 8. Validation

Before staging:

```powershell
git status --short --untracked-files=all
git diff --check
git diff --stat
```

Review all changed files for:

- no machine secrets or unrelated personal data;
- no huge raw command dumps;
- no absolute paths except approved project/tool/environment facts required by the inventory;
- no unsupported readiness claims;
- observed versus recommended versus frozen status clearly separated;
- current links resolve;
- no runtime/Godot project files were created;
- no generated `.godot` state exists in the repository;
- no external directory was created.

Stage only the explicitly authorized Markdown paths. Never use broad staging.

Then run:

```powershell
git diff --cached --check
git diff --cached --stat
git diff --cached --name-only
```

## 9. Commit and push authorization

This task authorizes one documentation-only commit on `main` and one normal push to `origin/main` if all gates pass.

Required commit message:

```text
docs: inventory Delayed Self development environment
```

Immediately before push:

```powershell
git fetch origin
git rev-parse HEAD
git rev-parse origin/main
git status --short --untracked-files=all
```

If remote moved after Task 0001 began, stop. Do not merge, rebase, amend, force-push, overwrite, or create a second commit without a new instruction.

## 10. Stop conditions

Stop with `BLOCKED` if:

- startup Git/root gate fails;
- the worktree is unexpectedly dirty;
- local/remote diverged;
- this task or prior acceptance artifact is missing;
- environment inspection would require installation, download, editor launch, broad drive scan, privileged write, or secret access;
- a command creates unexpected project/editor state;
- authorized documentation cannot be produced without guessing a material fact;
- remote drifts before push.

A missing Godot installation or export template is not by itself a task failure. Record it as an environment finding and still complete the documentation if safe.

## 11. Terminal verdicts

Use exactly one:

- `PASS_FOR_GPT_REVIEW`
- `PASS_WITH_OBSERVATIONS_FOR_GPT_REVIEW`
- `BLOCKED`

## 12. Next gate

Do not begin implementation. Recommend one of:

- Task 0001R — narrow retry/clarification if inventory is materially incomplete;
- Task 0002 — deterministic gameplay simulation and level-schema contract;
- a separately authorized installation/version-alignment task if required prerequisites are missing.
