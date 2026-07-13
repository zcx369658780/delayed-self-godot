# Task 0000 — Project bootstrap and rule materialization

- Status: `READY`
- Gate: `BOOTSTRAP / DOCS-ONLY`
- Repository: `zcx369658780/delayed-self-godot`
- Expected default branch: `main`
- Expected local root: `D:\Delayed_Self`
- Issued by: GPT Project Sources advisor
- Date: 2026-07-14

## 1. Objective

Materialize the Delayed Self repository governance and canonical documentation from the two tracked seed documents already present in `main`:

1. `docs/game_design/DELAYED_SELF_GAME_DESIGN_DOCUMENT_CURRENT.md`
2. `docs/project_rules/PROJECT_RULE_SOURCE_SEED_CURRENT.md`

This task is documentation and repository-governance bootstrap only. Do not create gameplay code, `project.godot`, scenes, scripts, plugins, export presets, builds, or assets.

## 2. Local checkout bootstrap

The intended local path is `D:\Delayed_Self`.

Before any write:

1. Inspect the current directory.
2. If `D:\Delayed_Self` is empty and is not a Git repository, clone the repository into that exact directory:

```powershell
git clone https://github.com/zcx369658780/delayed-self-godot.git D:\Delayed_Self
```

3. If the current Codex workspace is already `D:\Delayed_Self` and is empty, `git clone <url> .` is acceptable.
4. If `.git` already exists, verify that `origin` is exactly the expected repository.
5. If the directory is non-empty but is not the expected Git checkout, stop with `BLOCKED_LOCAL_ROOT_NOT_SAFE` and do not delete, move, or overwrite anything.
6. Do not create a nested `D:\Delayed_Self\delayed-self-godot` checkout.

## 3. Mandatory startup facts

Run and record concise output from:

```powershell
Get-Location
git branch --show-current
git rev-parse HEAD
git remote -v
git status --short --untracked-files=all
git log -5 --oneline --decorate
```

Expected conditions:

- absolute root is `D:\Delayed_Self`;
- branch is `main`;
- origin is `https://github.com/zcx369658780/delayed-self-godot.git` or the equivalent authenticated GitHub URL;
- tracked worktree is clean before bootstrap edits.

If the local checkout is behind and clean, use only:

```powershell
git fetch origin
git merge --ff-only origin/main
```

Stop on divergence, conflicts, unexpected tracked changes, or remote mismatch.

## 4. Required reads

Read in this order before writing:

1. this task file;
2. `docs/project_rules/PROJECT_RULE_SOURCE_SEED_CURRENT.md`;
3. `docs/game_design/DELAYED_SELF_GAME_DESIGN_DOCUMENT_CURRENT.md`.

Then print a concise pre-write summary containing:

- task objective;
- scope;
- non-goals;
- protected surfaces;
- planned files;
- commit and push authorization.

## 5. Authorized scope

Create and populate the following governance files.

### 5.1 Root files

- `AGENTS.md`
- `.gitignore`
- `README.md`

### 5.2 Current canonical documents

- `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`
- `docs/CODEX_ACTIVE_TASK_CURRENT.md`
- `docs/DOC_INDEX_CURRENT.md`
- `docs/DEVELOPMENT_PLAN_CURRENT.md`
- `docs/HANDOFF_MASTER_CURRENT.md`
- `docs/project_memory.md`
- `docs/version_plans/README.md`

### 5.3 Project rules

Create a minimal, non-duplicative split of the seed rules:

- `docs/project_rules/PROJECT_RULE_GITHUB_TASK_HANDOFF_CURRENT.md`
- `docs/project_rules/PROJECT_RULE_GPT_CODEX_GITHUB_WORKFLOW_CURRENT.md`
- `docs/project_rules/PROJECT_RULE_GODOT_SAFETY_AND_RELEASE_GATES_CURRENT.md`
- `docs/project_rules/PROJECT_RULE_PUZZLE_VALIDATION_CURRENT.md`
- `docs/project_rules/PROJECT_RULE_EVIDENCE_AND_INDEPENDENT_REVIEW_CURRENT.md`
- `docs/project_rules/PROJECT_RULE_CONTEXT_BUDGET_CURRENT.md`

### 5.4 Agent and workflow rules

- `docs/agents/PROJECT_RULE_CODEX_MULTI_SUBAGENT_MODEL_ROUTING.md`
- `docs/workflows/PROJECT_BOOTSTRAP_AND_TASK_WORKFLOW.md`

### 5.5 License placeholders

- `docs/licenses/THIRD_PARTY_ASSET_LEDGER_CURRENT.md`
- `docs/licenses/ATTRIBUTION_CURRENT.md`

Both license files must clearly state that no third-party release-cleared assets have yet been accepted. Do not invent asset entries.

### 5.6 Project-source index and execution report

- `docs/PROJECT_SOURCE_INDEX_CURRENT.md`
- `docs/reports/0000_PROJECT_BOOTSTRAP_AND_RULE_MATERIALIZATION_REPORT.md`

## 6. Source handling rules

- Preserve `docs/game_design/DELAYED_SELF_GAME_DESIGN_DOCUMENT_CURRENT.md` as the canonical GDD. Do not shorten or silently rewrite it.
- Preserve `docs/project_rules/PROJECT_RULE_SOURCE_SEED_CURRENT.md` as an auditable seed/source document.
- The split rules may summarize and reorganize the seed, but must not weaken any hard rule.
- Avoid copying identical long passages into every file. `AGENTS.md` should contain durable hard rules and link to detailed documents.
- Dynamic progress belongs in current docs, not in `AGENTS.md`.
- Record the frozen repository facts:
  - repository: `zcx369658780/delayed-self-godot`;
  - visibility: public;
  - default branch: `main`;
  - local root: `D:\Delayed_Self`;
  - working title: `迟到的我 / Delayed Self`;
  - primary target: Windows;
  - offline single-player;
  - candidate milestone: 2026-08-10;
  - final submission deadline: 2026-09-06 23:59;
  - video deadline: 2026-09-10.
- Mark Godot exact version, renderer, logic resolution, Web support, art style, evidence root, independent reviewer, final license, and undo support as `PENDING_TASK_0001_OR_LATER`.

## 7. Required `AGENTS.md` content

`AGENTS.md` must be concise and include at least:

1. project roles and final-acceptance ownership;
2. canonical read order;
3. startup Git facts and clean-worktree gate;
4. forbidden destructive Git operations;
5. explicit staging only; no `git add .` or `git add -A`;
6. single-topic commit rule;
7. no secrets or credentials;
8. no Godot/plugin/export-template upgrade without a separate task;
9. deterministic simulation and solver/runtime consistency as a hard architecture boundary;
10. AI-generated puzzle claims are not evidence until solver-validated;
11. asset license ledger requirement;
12. save, release, upload, public submission, repository settings, and account operations as separately authorized protected surfaces;
13. Codex may report `PASS_FOR_GPT_REVIEW`, but cannot issue final project acceptance;
14. local root and repository identity.

## 8. `.gitignore` baseline

Create a conservative Godot 4-oriented `.gitignore` that at minimum ignores:

```text
.godot/
*.tmp
*.temp
*.log
*.pck
*.exe
*.zip
build/
builds/
dist/
exports/
evidence/
.env
.env.*
*.keystore
*.pfx
*.p12
*.pem
*.key
```

Do not ignore source assets generically. Do not add broad patterns that could hide tracked game data or documentation.

## 9. `README.md` minimum content

Include:

- working title and one-sentence concept;
- GodotHub Festival 2026 and theme `Delay / 滞后`;
- current status: pre-production / bootstrap;
- milestone dates;
- canonical GDD link;
- warning that exact Godot version is not yet frozen;
- no claim that the game is implemented or playable.

## 10. Current document expectations

### Startup snapshot

State that Task 0000 is the current bootstrap gate and Task 0001 is the recommended next gate after GPT acceptance.

### Active task

During execution set status to `ACTIVE`; before final commit set it to `COMPLETED_PENDING_GPT_REVIEW`, with the task path, commit policy, and remaining uncertainties.

### Development plan

Keep the milestone spine from the GDD. Do not fabricate detailed implementation tasks beyond Task 0003. Recommended sequence:

```text
0000 bootstrap
→ 0001 read-only environment inventory
→ 0002 gameplay simulation contract
→ 0003 minimal vertical slice
```

### Handoff master

Provide one current entry point and explicitly state that no gameplay implementation exists yet.

### Project memory

Record durable decisions only. Do not copy the entire GDD.

### Project source index

Explain the relationship among the GDD, rule seed, `AGENTS.md`, split rules, current docs, and task files.

## 11. Multi-subagent guidance

You may use configured subagents for bounded read/write assistance:

- `docs_reader`: read-only source extraction;
- `docs_writer`: draft Markdown only;
- `code_reviewer`: review the staged documentation and `.gitignore` for contradictions or unsafe omissions;
- `planner_high`: only if needed to resolve document decomposition.

Constraints:

- subagents must not commit or push;
- no subagent may change repository settings;
- no gameplay implementation;
- main thread retains staging, commit, push, and final task verdict.

If configured subagents are unavailable, continue in the main thread and record the fallback. Do not fabricate subagent results.

## 12. Non-goals

Do not:

- create or edit `project.godot`;
- install or download Godot, export templates, plugins, fonts, audio, or art;
- create scenes, scripts, tests, game data, shaders, assets, builds, or export presets;
- choose the exact Godot version or renderer;
- choose pixel art versus vector art;
- implement a save system;
- create GitHub Actions;
- change repository visibility, settings, collaborators, branch protection, topics, releases, or Pages;
- create tags or releases;
- upload a game build;
- create a license without user/GPT approval;
- delete or overwrite the two seed documents;
- claim the game is playable, implemented, validated, or submission-ready.

## 13. Protected surfaces

Protected and untouched in this task:

- repository settings and permissions;
- GitHub account operations;
- public game submission;
- releases and tags;
- credentials and secrets;
- Godot installation and version upgrades;
- plugins and external dependencies;
- save files and user data;
- builds and export templates;
- third-party assets;
- gameplay code.

## 14. Validation

Run at minimum:

```powershell
git status --short --untracked-files=all
git diff --check
git diff --stat
```

Before commit, explicitly stage only authorized paths. Do not use broad staging.

Then run:

```powershell
git diff --cached --check
git diff --cached --stat
git diff --cached --name-only
```

Perform a documentation consistency review:

- every canonical link resolves to an existing tracked path;
- no file claims that gameplay exists;
- GDD dates and repository facts are consistent;
- no pending item is presented as frozen;
- no secret-like values or personal tokens are present;
- `.gitignore` does not hide intended source directories;
- `AGENTS.md` is concise and points to detailed rules;
- the GDD remains intact.

## 15. Commit and push authorization

This task authorizes one documentation-only commit on `main` and one normal push to `origin/main`, provided:

- the startup gate passes;
- remote has not drifted;
- only authorized files are staged;
- `git diff --cached --check` passes.

Required commit message:

```text
docs: bootstrap Delayed Self project governance
```

Immediately before push:

```powershell
git fetch origin
git rev-parse HEAD
git rev-parse origin/main
git status --short --untracked-files=all
```

If `origin/main` moved after the task began, stop and report. Do not merge, rebase, force push, or overwrite the remote without a new instruction.

## 16. Completion report

The report and terminal response must contain:

- verdict;
- task path;
- local root;
- branch;
- starting HEAD and origin/main;
- final HEAD and origin/main;
- commit hash;
- created/modified files;
- validation commands and results;
- whether subagents were used;
- confirmation that the GDD was preserved;
- confirmation that no gameplay/Godot project/runtime files were created;
- protected surfaces not touched;
- final `git status`;
- unresolved pending decisions;
- recommended next gate: Task 0001 read-only environment and release-target inventory.

## 17. Terminal verdicts

Use exactly one:

- `PASS_FOR_GPT_REVIEW`
- `PASS_WITH_OBSERVATIONS_FOR_GPT_REVIEW`
- `BLOCKED`
- `FAIL`

Do not use `FINAL_ACCEPTED`.

## 18. Stop conditions

Stop without writing or pushing if:

- the local root is unsafe or contains unrelated material;
- the remote is not the expected repository;
- tracked worktree contains unexpected changes;
- branch or history is divergent;
- either seed document is missing or unreadable;
- the GDD would need substantive design changes to complete the task;
- any instruction requires access to credentials, repository settings, publishing accounts, or external paid services.
