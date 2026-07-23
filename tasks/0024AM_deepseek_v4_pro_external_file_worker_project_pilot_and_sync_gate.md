# Task 0024AM — Align the project with the DeepSeek-V4-Pro external file-worker pilot, prove project-level CLI availability, and synchronize governance evidence

- Status: `READY`
- Gate: `PROJECT CONFIG AUDIT / EXTERNAL FILE-WORKER CLI SMOKE / GPT-5.6 REVIEW / GOVERNANCE AND SOURCE SYNC`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Required accepted checkpoint in ancestry: `65656cca16b7e3867685287b1fc9c7ebd4e7ee30`
- Previous accepted gate: `TASK_0024AL_PROCESS_ISOLATED_WRITE_AHEAD_SCHEMA_V2_MINIMUM_OWNER_REVIEW_PRESENTATION_ACCEPTED`
- Current production baseline: exactly eight cataloged levels; sequence 8 remains the sole formal finale
- Current owner-playthrough status: `NOT_YET_REVIEWED`
- User-level external-worker baseline: `ACCEPTED_FOR_USER_LEVEL_CLI_FALLBACK_PILOT`
- Recommended main-agent model: `GPT-5.6 Sol` at maximum available reasoning
- Constrained main-agent fallback: `GPT-5.6 Terra` at maximum available reasoning
- DeepSeek model: `deepseek-v4-pro`
- DeepSeek transport authorized for this task: `CLI fallback only`
- MCP delegate status: `NOT_AUTHORIZED_AS_A_DEPENDENCY / CLIENT TRANSPORT BLOCKED`
- Final project-level gate is not predetermined:
  - `DEEPSEEK_PROJECT_PILOT_ENABLED`, or
  - `DEEPSEEK_PROJECT_PILOT_BLOCKED`

## 1. Objective

Under the new Task 0024AM identity:

1. audit the project-local Codex configuration, routing rules, agent files, skills, task templates, current documents and Git state;
2. compare the project-local configuration with the already accepted user-level DeepSeek-V4-Pro external file-worker infrastructure;
3. preserve the native GPT-5.6 model/provider and preserve GPT-5.6 ownership of planning, architecture, review, testing, Git and final acceptance;
4. make only the minimum project-local configuration and governance changes needed to expose a safe, explicit CLI-fallback delegation route;
5. execute one real, low-risk, reversible DeepSeek-V4-Pro file-editing smoke test through the accepted CLI worker;
6. independently validate the smoke result, changed-path boundary, output JSON, secret boundary and local cleanup using GPT-5.6;
7. document the future task classes that may and may not be delegated to DeepSeek;
8. synchronize repository governance documents, an upload-ready GPT Project Sources delta, GitHub evidence and a local Codex inventory;
9. provide exact rollback instructions;
10. commit and push only the authorized repository documentation after all required checks pass;
11. return a truthful `PASS_FOR_GPT_REVIEW` or `BLOCKED` result for the GPT project advisor.

This is an infrastructure and governance task. It does not conduct owner subjective playtesting and does not authorize any gameplay, catalog, Profile, finale, build, release or submission change.

## 2. User authorization and authority boundaries

The user explicitly authorizes this task to:

- confidentially read the project-local `D:\Delayed_Self\.codex\config.toml`;
- make a minimal project-local change to that file only when the audit proves a change is necessary and supported;
- read the specified user-level Codex configuration and external-worker files for comparison;
- create non-authoritative local audit, smoke and rollback evidence under the user-level Codex reports directory;
- invoke the accepted DeepSeek CLI worker for the bounded smoke test;
- update the authorized repository governance and current-state documents;
- commit and push the authorized repository documentation after successful validation.

This task does **not** authorize:

- changing the user-level GPT/Codex default model or provider;
- changing any GPT-5.6 Sol/Terra provider, endpoint, authentication or routing default;
- changing the accepted DeepSeek worker core;
- printing, copying into Git, logging or otherwise exposing `DEEPSEEK_API_KEY`;
- using MCP delegate as the execution path;
- giving DeepSeek Shell, PowerShell, cmd, Git, testing, build, dependency-installation or unrestricted network authority;
- giving DeepSeek access to production Profile/player data, credentials or other sensitive paths;
- letting DeepSeek modify tracked project files during this pilot task;
- changing gameplay, Simulation, solver, scenes, levels, catalog, Profile, presentation implementation or historical evidence.

If any required change would exceed these boundaries, stop and return `BLOCKED`.

## 3. Frozen user-level external-worker baseline

Treat the following user-level infrastructure as accepted and read-only:

```text
Model:
deepseek-v4-pro

Worker root:
C:\Users\zcxve\.codex\external-agents\deepseek-file-worker-stdlib

CLI entry:
C:\Users\zcxve\.codex\external-agents\deepseek-file-worker-stdlib\deepseek_file_task_cli.py

Python:
C:\Users\zcxve\AppData\Local\Programs\Python\Python311\python.exe
```

Accepted user-level facts to verify without redesigning:

- the real DeepSeek API was previously proven usable;
- the CLI fallback can read and edit authorized files;
- the worker has zero third-party runtime dependencies;
- the worker has no Bash, PowerShell, cmd, Git, dependency-install or arbitrary-network tool;
- the worker implements workspace, allowed-path, sensitive-path, path-escape and junction/symlink protections;
- the API key is supplied only through the user-level environment variable `DEEPSEEK_API_KEY`;
- MCP `ping` may work, but MCP delegate is not a valid dependency for this project pilot.

Do not rewrite, upgrade, refactor, replace, reformat or patch the worker core. Record file inventory and hashes only.

## 4. Mandatory model ownership

### 4.1 GPT-5.6 Sol/Terra retains exclusive ownership

GPT-5.6 Sol/Terra must perform:

- task interpretation and scope freezing;
- architecture and interface decisions;
- protected-surface and security decisions;
- task decomposition;
- the exact DeepSeek task JSON;
- `workspace`, `allowed_paths`, `context_files` and acceptance criteria;
- configuration-diff design;
- review of every project-local configuration change;
- review of every DeepSeek-produced byte;
- Shell commands, tests, validation and regression;
- Git status, diff, stage, commit and push;
- project-source synchronization adjudication;
- task verdict and final recommendation to the GPT project advisor.

For this task, both planning/configuration review and independent security/boundary review must remain on GPT-5.6 Sol/Terra. Do not route those roles to DeepSeek, Spark or another implementation model.

If the Codex client cannot provide or verify the required GPT-5.6 Sol/Terra review route, record the limitation and return `BLOCKED`; do not silently substitute DeepSeek.

### 4.2 DeepSeek-V4-Pro may perform only the pilot file edit

During Task 0024AM, DeepSeek may:

- read the two temporary smoke-test files explicitly listed in the task JSON;
- modify exactly one temporary smoke-test target file;
- return the worker result.

DeepSeek may not modify any tracked repository file in this task.

After a future GPT acceptance enables the pilot, later tasks may authorize DeepSeek for narrowly bounded work such as:

- ordinary GDScript implementation beneath a frozen interface;
- repetitive or mechanical multi-file edits;
- fixtures and ordinary test-code authoring;
- data conversion helpers;
- ordinary non-sensitive UI logic;
- localization or structured-data transformations;
- a narrow bug fix with an exact reproduction and fast regression;
- a narrow refactor whose behavior is already covered by tests.

Even after pilot acceptance, DeepSeek remains ineligible for:

- project architecture or interface design;
- delay-state semantics, Simulation transition rules or solver correctness;
- level solvability, uniqueness, difficulty or curriculum adjudication;
- security, secrets, authentication, payments or irreversible migration;
- production Profile/player-data access;
- build, release, deployment or public submission;
- Git commit, push, PR, tag or repository settings;
- dependency installation or environment mutation;
- final review, task verdict or GPT acceptance;
- autonomous scope expansion.

## 5. Mandatory execution state machine

Use this explicit state machine:

```text
STARTUP_GATE
→ READ_ONLY_PROJECT_AND_USER_CONFIG_AUDIT
→ GPT_5_6_ROUTING_AND_CONFIG_PLAN
→ INDEPENDENT_GPT_5_6_PLAN_REVIEW
→ PROJECT_LOCAL_CONFIG_BACKUP
→ MINIMAL_PROJECT_LOCAL_ALIGNMENT
→ CONFIG_PARSE_AND_INVARIANT_VALIDATION
→ SMOKE_FIXTURE_AND_JSON_AUTHORING
→ REAL_DEEPSEEK_CLI_SMOKE
→ GPT_5_6_CHANGED_PATH_AND_CONTENT_REVIEW
→ GPT_5_6_SECURITY_AND_SECRET_REVIEW
→ TEMPORARY_ARTIFACT_CLEANUP
→ REPOSITORY_GOVERNANCE_AND_PROJECT_SOURCE_EXPORT
→ PROJECT_LEVEL_VALIDATION
→ PRE_COMMIT_AUDIT
→ COMMIT_AND_PUSH
→ POST_PUSH_AND_LOCAL_SYNC_AUDIT
→ HANDOFF_AND_PASS_FOR_GPT_REVIEW
```

Do not skip a state.

Before the real DeepSeek CLI smoke, defects in new Task 0024AM-only documentation, temporary fixture design, task JSON or project-local configuration are repairable. Repair, re-review and revalidate them.

A terminal blocker is required for:

- remote divergence or unsafe drift;
- unexpected tracked/staged changes;
- additional unexplained untracked files at startup;
- inability to preserve or restore the original project-local config;
- unsupported or ambiguous Codex config schema;
- any requirement to modify user-level model/provider or worker core;
- missing Python/CLI worker;
- missing `DEEPSEEK_API_KEY` environment-variable presence;
- DeepSeek CLI failure that cannot be explained without worker-core modification;
- any DeepSeek write outside the authorized temporary target;
- secret exposure;
- inability to obtain GPT-5.6 Sol/Terra planning and review;
- any need to touch protected gameplay or player-data surfaces.

## 6. Startup gate

Before any write or DeepSeek invocation:

1. require absolute root `D:\Delayed_Self`;
2. require branch `main`;
3. confirm remote `origin` is `zcx369658780/delayed-self-godot`;
4. confirm no Git operation is in progress;
5. fetch and fast-forward only;
6. require `HEAD == origin/main` and divergence `0/0`;
7. require accepted checkpoint `65656cca16b7e3867685287b1fc9c7ebd4e7ee30` in ancestry;
8. require the Task 0024AM file and active pointer from current `origin/main`;
9. require no tracked or staged changes;
10. allow only the pre-existing untracked `D:\Delayed_Self\.codex\config.toml`;
11. require its startup SHA-256 to equal:

```text
d4c670da3c2404921a1ab177f4e5405449bc8321d713cc0b42b8046201fd33cc
```

12. do not print or commit the file contents;
13. require zero Godot processes and keep Godot at zero throughout this task;
14. verify, without printing its value, whether `DEEPSEEK_API_KEY` is present in the environment;
15. verify the exact Python executable and CLI entry exist;
16. record Python version;
17. record user-level worker inventory and SHA-256 hashes;
18. stop on any unexplained local or remote mismatch.

No Godot process may be launched in this task. Historical Task 0024AF–0024AL retained identities must not be rerun.

## 7. Required reads

Read the repository files in this order:

```text
AGENTS.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
tasks/0024AM_deepseek_v4_pro_external_file_worker_project_pilot_and_sync_gate.md
docs/handoffs/DELAYED_SELF_SESSION_HANDOFF_AFTER_TASK_0024AL_ACCEPTANCE_2026_07_23.md
docs/reports/0024AL_GPT_PROCESS_ISOLATED_WRITE_AHEAD_SCHEMA_V2_PRESENTATION_ACCEPTANCE.md
docs/agents/PROJECT_RULE_CODEX_MULTI_SUBAGENT_MODEL_ROUTING.md
docs/workflows/PROJECT_BOOTSTRAP_AND_TASK_WORKFLOW.md
docs/DOC_INDEX_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
```

Confidentially inspect, without copying raw contents into reports:

```text
D:\Delayed_Self\.codex\config.toml
D:\Delayed_Self\.codex\
C:\Users\zcxve\.codex\config.toml
C:\Users\zcxve\.codex\AGENTS.md
C:\Users\zcxve\.codex\agents\
C:\Users\zcxve\.codex\reports\
C:\Users\zcxve\.codex\external-agents\deepseek-file-worker-stdlib\
```

Also inventory, when present:

```text
AGENTS.override.md
.codex\agents\
.codex\skills\
agents\
skills\
tasks\
docs\
README*
HANDOFF*
*_SESSION_HANDOFF*
*_ACCEPTANCE*
*_PROJECT_SOURCE*
```

For configuration files, reports may record only:

- path;
- existence;
- size;
- SHA-256;
- parsed top-level key names when safe;
- agent/role names;
- whether model/provider/default-routing invariants match;
- contradictions and required action.

Do not quote tokens, endpoints, headers, environment-variable values, secrets or raw confidential configuration.

## 8. Read-only audit requirements

Produce a complete audit before editing:

1. current repository, remote, branch, HEAD and divergence;
2. current tracked/staged/untracked state;
3. current project-local `.codex` inventory;
4. current user-level `.codex` inventory relevant to routing;
5. existing project role definitions;
6. existing user-level role definitions;
7. whether an old DeepSeek entry exists;
8. whether duplicate DeepSeek agents or conflicting aliases exist;
9. whether any project-local key overrides GPT-5.6 model/provider;
10. whether the project config schema supports a safe external-worker declaration;
11. whether CLI fallback can remain a documented external action without a native provider override;
12. stale or conflicting project-source/current/handoff files;
13. obsolete tasks that are historical but must remain immutable;
14. whether local reports can be stored without becoming a second authority;
15. the exact minimal change set, including a justified no-change decision when appropriate.

The audit must prefer **no configuration change** over an unsupported or decorative change.

Do not create a fake native agent, fake provider or undocumented TOML key merely to make the configuration look complete.

## 9. Project-local configuration alignment decision

After the audit, GPT-5.6 must choose exactly one supported path.

### Path A — Supported minimal project-local declaration

Use this path only if the existing Codex config schema and inherited user-level configuration clearly support a project-local external-worker alias or role without changing native model/provider behavior.

Requirements:

- make the smallest possible edit to `D:\Delayed_Self\.codex\config.toml`;
- preserve all existing GPT roles and settings;
- preserve the native model/provider/default route byte-for-byte wherever not explicitly changed;
- reference the accepted CLI worker without embedding the API key;
- name the role clearly as an external file-editing worker, not a planner or reviewer;
- require explicit task authorization;
- do not enable automatic delegation;
- do not create duplicate agent definitions;
- validate the resulting TOML using Python 3.11 `tomllib`;
- use a documented Codex config-validation command only if such a command is already available and known safe.

### Path B — Documentation-only CLI alignment

Use this path when the project config schema has no supported external-worker declaration or when the CLI route does not belong in native model routing.

Requirements:

- leave `D:\Delayed_Self\.codex\config.toml` byte-identical;
- document the CLI fallback in repository routing/workflow documents;
- keep DeepSeek outside the native provider/model graph;
- define the exact task-JSON and main-agent review contract;
- record that native MCP delegation remains blocked;
- do not claim that DeepSeek is a native Codex subagent.

### Path C — Blocked

Use this path when safe alignment would require changing user-level provider/model, patching the worker, exposing secrets, inventing config keys or weakening current project gates.

Return `DEEPSEEK_PROJECT_PILOT_BLOCKED`.

## 10. Backup and rollback protection

Before any project-local config write:

1. read the original bytes once;
2. record original SHA-256;
3. create a confidential rollback copy at:

```text
C:\Users\zcxve\.codex\reports\delayed-self\0024AM\rollback\project_config_before_0024AM.toml
```

4. do not print or commit its contents;
5. verify the backup hash equals the original hash;
6. write the project-local config atomically;
7. parse and validate the new file;
8. on any failure, restore the original bytes atomically;
9. verify the restored SHA-256;
10. leave the backup available until GPT acceptance, then let a later explicit cleanup decision remove it.

If Path B is selected, still record the original hash but do not create a redundant full-content backup unless a write is attempted.

Never back up or copy `DEEPSEEK_API_KEY`.

## 11. Real project-level DeepSeek smoke test

### 11.1 Temporary workspace

The GPT-5.6 main agent must create these temporary local-only files:

```text
D:\Delayed_Self\.codex\smoke\0024AM\context.md
D:\Delayed_Self\.codex\smoke\0024AM\target.md
C:\Users\zcxve\.codex\reports\delayed-self\0024AM\deepseek_smoke_task.json
```

The temporary files must not contain project secrets, player data or confidential config.

Initial `target.md` must contain a unique exact token:

```text
DEEPSEEK_SMOKE_PENDING
```

The context file must contain only the exact mechanical editing instruction and expected final form.

### 11.2 Task JSON

GPT-5.6 must author a standalone UTF-8 JSON file. Do not splice JSON into the command line.

Use this exact structure, adjusted only for the temporary file contents:

```json
{
  "workspace": "D:\\Delayed_Self",
  "allowed_paths": [
    "D:\\Delayed_Self\\.codex\\smoke\\0024AM\\target.md"
  ],
  "context_files": [
    "D:\\Delayed_Self\\.codex\\smoke\\0024AM\\context.md"
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

Do not put the API key in the JSON.

### 11.3 Authorized CLI invocation

Invoke exactly through the accepted Python/CLI pair:

```powershell
& "C:\Users\zcxve\AppData\Local\Programs\Python\Python311\python.exe" `
  "C:\Users\zcxve\.codex\external-agents\deepseek-file-worker-stdlib\deepseek_file_task_cli.py" `
  --task-file "C:\Users\zcxve\.codex\reports\delayed-self\0024AM\deepseek_smoke_task.json"
```

The GPT-5.6 main agent owns the process invocation. DeepSeek does not receive a Shell tool.

Capture exit code and a sanitized copy of stdout/stderr under:

```text
C:\Users\zcxve\.codex\reports\delayed-self\0024AM\
```

Do not preserve or report any secret if unexpected secret-like output appears. Treat any secret disclosure as a terminal blocker.

### 11.4 Mandatory independent validation

After the CLI returns, GPT-5.6 must independently verify:

- the CLI process exited successfully;
- the returned JSON is parseable;
- the reported model/worker identity is consistent with the accepted worker contract, when exposed;
- the exact target content matches the acceptance criteria;
- the context file is unchanged;
- no other file under the temporary workspace changed;
- no tracked repository file changed;
- no additional repository path was created or modified;
- `git status --short --untracked-files=all` shows only the expected temporary paths and pre-existing config during the smoke;
- `git diff --check` passes;
- no API key, credential, token, auth file or sensitive configuration appears in task JSON, output, reports or Git diff;
- no Git command, test, build, dependency installation or Shell command was delegated to DeepSeek;
- the worker did not read or write production Profile/player data;
- Godot count remains zero.

DeepSeek self-report does not satisfy these checks.

### 11.5 Cleanup

After evidence capture:

1. delete only the Task 0024AM temporary smoke directory;
2. preserve the user-level sanitized report and task JSON;
3. require repository worktree cleanup to leave only `D:\Delayed_Self\.codex\config.toml` untracked;
4. if project-local config was intentionally changed, record its new hash but keep it untracked;
5. stop if any unexpected path remains.

Do not use repo-wide clean, restore or deletion commands.

## 12. Project-level routing rules to materialize

Update the project governance so it clearly states:

1. DeepSeek-V4-Pro is an external file-editing implementation worker.
2. The current transport is CLI fallback.
3. MCP delegate is not a project dependency.
4. DeepSeek is never the main planning, architecture, review or acceptance agent.
5. Delegation is opt-in per task and is forbidden by default.
6. GPT-5.6 must define workspace, allowed paths, context files, exact task and acceptance criteria.
7. DeepSeek receives the minimum readable and writable paths.
8. DeepSeek cannot run Shell, Git, tests, builds or dependency installation.
9. DeepSeek cannot touch secrets, user-level config, Profile/player data or release surfaces.
10. DeepSeek cannot modify tracked files in Task 0024AM.
11. Future tracked-file delegation requires a new task that explicitly names each allowed path.
12. GPT-5.6 independently reviews all changed files and runs all validation.
13. DeepSeek unavailability is reported honestly; it never silently changes the model route.
14. The project native GPT-5.6 model/provider remains unchanged.
15. Core Simulation, solver, level correctness and curriculum decisions remain GPT-5.6-only.
16. DeepSeek output is advisory until GPT-5.6 accepts the diff and tests.
17. Git commit/push remains main-agent-only.
18. Project-source state and final task verdict remain GPT-advisor-owned.

## 13. Authorized repository paths

Create or modify only:

```text
AGENTS.md
docs/agents/PROJECT_RULE_CODEX_MULTI_SUBAGENT_MODEL_ROUTING.md
docs/workflows/DEEPSEEK_FILE_WORKER_CLI_PILOT_WORKFLOW.md
docs/reports/0024AM_DEEPSEEK_PROJECT_CONFIGURATION_AUDIT_REPORT.md
docs/reports/0024AM_DEEPSEEK_PROJECT_SMOKE_TEST_REPORT.md
docs/reports/0024AM_DEEPSEEK_PROJECT_SYNC_AND_ROLLBACK_REPORT.md
docs/project_sources/DELAYED_SELF_PROJECT_SOURCE_DEEPSEEK_FILE_WORKER_PILOT_CURRENT_2026_07_23.md
docs/handoffs/DELAYED_SELF_SESSION_HANDOFF_AFTER_TASK_0024AM_DEEPSEEK_PROJECT_PILOT_2026_07_23.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
```

The task file itself is immutable after execution begins.

Local-only authorized write paths:

```text
D:\Delayed_Self\.codex\config.toml
D:\Delayed_Self\.codex\smoke\0024AM\
C:\Users\zcxve\.codex\reports\delayed-self\0024AM\
```

No other repository or user-level path may change.

## 14. Protected surfaces

Do not modify:

```text
project.godot
scenes/**
scripts/**
data/**
schemas/**
tests/**
localization/**
assets/**
audio/**
build/**
export/**
release/**
submission/**
docs/playtest/SUBMISSION_CORE_1_12_OWNER_CURRICULUM_REVIEW_CURRENT.md
all Task 0024AF–0024AL historical artifacts
all accepted retained manifests, invocations and evidence
C:\Users\zcxve\.codex\config.toml
C:\Users\zcxve\.codex\AGENTS.md
C:\Users\zcxve\.codex\agents\**
C:\Users\zcxve\.codex\external-agents\deepseek-file-worker-stdlib\**
```

Do not inspect production Profile/player data.

Do not create or modify:

- a native DeepSeek provider;
- an OpenAI-compatible provider override;
- a new default model;
- a duplicate user-level agent;
- a project-local skill that grants Shell or Git;
- a committed absolute-path configuration file;
- a second authoritative project-state tree under the user-level reports directory.

## 15. Required repository deliverables

### 15.1 Configuration audit report

Create:

```text
docs/reports/0024AM_DEEPSEEK_PROJECT_CONFIGURATION_AUDIT_REPORT.md
```

It must record:

- startup Git facts;
- project-local config hash before and after;
- user-level config/agent/worker inventory hashes;
- structural comparison without raw confidential content;
- duplicate/conflict findings;
- selected Path A, B or C;
- exact model/provider invariants;
- exact changed local-only files;
- unresolved limitations.

### 15.2 Real smoke-test report

Create:

```text
docs/reports/0024AM_DEEPSEEK_PROJECT_SMOKE_TEST_REPORT.md
```

It must record:

- Python and CLI paths;
- environment-variable presence check without the value;
- task JSON SHA-256;
- workspace and allowed/context paths;
- CLI exit code;
- sanitized result identity;
- target before/after SHA-256;
- changed-path audit;
- JSON parse result;
- secret scan result;
- cleanup result;
- Godot count before/after;
- exact smoke verdict.

Do not commit raw secret-bearing output.

### 15.3 Project-level CLI workflow

Create:

```text
docs/workflows/DEEPSEEK_FILE_WORKER_CLI_PILOT_WORKFLOW.md
```

It must provide:

- role boundaries;
- eligibility decision tree;
- task JSON schema;
- exact CLI invocation;
- allowed-path minimization rules;
- sensitive-path exclusions;
- required GPT-5.6 review;
- validation and cleanup;
- failure behavior;
- rollback behavior;
- a reusable future-task checklist.

### 15.4 Project-source export

Create:

```text
docs/project_sources/DELAYED_SELF_PROJECT_SOURCE_DEEPSEEK_FILE_WORKER_PILOT_CURRENT_2026_07_23.md
```

This is an upload-ready GPT Project Sources delta, not proof that ChatGPT Project Sources have already been updated.

It must record:

- user-level baseline;
- project-level selected alignment path;
- CLI-only transport;
- MCP delegate limitation;
- GPT-5.6 versus DeepSeek responsibility matrix;
- smoke-test result;
- local project-config hash;
- worker paths;
- rollback;
- remaining limitations;
- repository result commit;
- a clear import status field:

```text
project_source_import_status = READY_FOR_GPT_PROJECT_SOURCE_IMPORT
```

Do not claim `PROJECT_SOURCE_SYNCED` unless the GPT advisor or user separately confirms actual import.

### 15.5 Sync and rollback report

Create:

```text
docs/reports/0024AM_DEEPSEEK_PROJECT_SYNC_AND_ROLLBACK_REPORT.md
```

It must reconcile:

- repository files;
- GitHub commit;
- local project `.codex/config.toml`;
- user-level worker inventory;
- user-level non-authoritative reports;
- project-source export;
- temporary-file cleanup;
- exact rollback steps;
- authority hierarchy.

### 15.6 Handoff

Create:

```text
docs/handoffs/DELAYED_SELF_SESSION_HANDOFF_AFTER_TASK_0024AM_DEEPSEEK_PROJECT_PILOT_2026_07_23.md
```

It must include:

- start/final HEAD;
- project-local config before/after hashes;
- worker inventory hash summary;
- smoke evidence;
- changed repository files;
- local-only changed files;
- pushed commit;
- current project gate recommendation;
- protected boundaries;
- remaining limitations;
- GPT Project Sources import requirement;
- next legitimate gameplay gate.

The owner subjective 1–12 playthrough remains pending and must be assigned a later task identity. Do not populate subjective worksheet fields.

## 16. Current-document synchronization

Update the authorized current documents so they agree on:

- Task 0024AM result status;
- DeepSeek project pilot recommendation;
- CLI fallback transport;
- GPT-5.6 planning/review/acceptance ownership;
- project-local config hash and whether Path A or B was selected;
- user-level worker core remaining frozen;
- no gameplay or owner-review change;
- project-source export path and import-pending status;
- next gate.

At closeout, `docs/CODEX_ACTIVE_TASK_CURRENT.md` must use only one of:

```text
TASK_0024AM_DEEPSEEK_PROJECT_PILOT_PASS_FOR_GPT_REVIEW
TASK_0024AM_DEEPSEEK_PROJECT_PILOT_BLOCKED
```

Codex must not write `FINAL_ACCEPTED`.

## 17. Validation requirements

### 17.1 Configuration validation

Using the exact Python 3.11 executable:

- parse the original and final project-local TOML with `tomllib`;
- verify original and final hashes;
- verify no user-level config file changed;
- verify no user-level agent file changed;
- verify no worker-core file changed;
- verify GPT-5.6 model/provider/default-route invariants;
- verify no API key literal appears in project-local config, task JSON, repository diff or reports;
- verify no unsupported config key was invented.

### 17.2 Repository validation

Run:

```powershell
git status --short --untracked-files=all
git diff --check
git diff --name-only
git diff --stat
```

Also verify:

- every changed tracked path is in the allowlist;
- no historical artifact changed;
- no gameplay/test/data/scene path changed;
- all Markdown links added by this task resolve within the repository;
- the project-source export does not contain secrets;
- no absolute local path is added outside the explicitly documented worker and project roots;
- no temporary fixture is staged or committed.

### 17.3 Project test scope

This task changes governance documentation and possibly an untracked project-local Codex config only.

Therefore:

- do not launch Godot;
- do not rerun consumed retained cycles;
- do not claim a full gameplay regression;
- require `Godot count = 0` at every process checkpoint;
- treat TOML parsing, CLI smoke, path-boundary checks, Markdown/link checks, Git diff checks and secret scanning as the complete authorized project-validation scope.

The final report must say:

```text
project_test_scope = CONFIGURATION_DOCUMENTATION_AND_EXTERNAL_WORKER_SMOKE_ONLY
full_gameplay_regression = NOT_RUN_NOT_REQUIRED_NO_GAMEPLAY_CHANGE
```

## 18. Secret and sensitive-data scan

Before commit, scan all authorized changed repository files and local smoke artifacts for:

- `DEEPSEEK_API_KEY`;
- likely API-key values;
- bearer/auth headers;
- private keys;
- tokens;
- user credentials;
- raw user-level config;
- production Profile/player-data paths or contents;
- worker request/response material that contains secrets.

The literal environment-variable name may appear in documentation. Its value may not.

If secret material appears:

1. stop;
2. remove it from all non-authoritative artifacts;
3. do not stage or push;
4. rotate/revoke only if the user separately authorizes;
5. return `BLOCKED`.

## 19. Independent GPT-5.6 review gates

Before the project-local config write, obtain a GPT-5.6 Sol/Terra review of:

- selected Path A/B/C;
- proposed config delta;
- provider/model invariants;
- rollback plan;
- smoke task JSON;
- allowed/context paths.

After the smoke and documentation, obtain a separate GPT-5.6 Sol/Terra review of:

- changed-path evidence;
- target content;
- secret boundary;
- repository diff;
- routing rules;
- project-source export;
- rollback report;
- final gate recommendation.

Reviewers may not modify files, run Git writes or issue final acceptance.

Record model/role identity when the client exposes it. Never fabricate model identity or a reviewer verdict.

## 20. Gate logic

Recommend:

```text
DEEPSEEK_PROJECT_PILOT_ENABLED
```

only when all are true:

- native GPT-5.6 model/provider/default route is unchanged;
- user-level worker core is unchanged;
- project-local config is valid or correctly left unchanged under Path B;
- the real CLI smoke succeeds;
- only the authorized temporary target is modified by DeepSeek;
- worker JSON is parseable;
- the GPT-5.6 content/path/security reviews pass;
- no secret appears;
- temporary repository paths are removed;
- final repository changes are allowlisted;
- documentation and current pointers agree;
- GitHub push succeeds;
- project-source export is ready for GPT Project Sources import;
- all unresolved limitations are honestly recorded.

Recommend:

```text
DEEPSEEK_PROJECT_PILOT_BLOCKED
```

when any required condition fails.

Codex terminal verdicts remain:

```text
PASS_FOR_GPT_REVIEW
BLOCKED
FAIL
```

Codex must not claim final GPT acceptance.

## 21. Commit and push policy

After all pre-commit gates pass:

1. fetch `origin`;
2. require no remote drift and divergence `0/0`;
3. explicitly stage only the authorized repository files;
4. do not stage `D:\Delayed_Self\.codex\config.toml`;
5. do not stage local smoke or user-level report files;
6. show the staged file list;
7. run `git diff --cached --check`;
8. review the complete staged diff;
9. commit with:

```text
chore(codex): align project with DeepSeek file-worker pilot
```

10. push to `origin/main`;
11. verify `HEAD == origin/main`;
12. report final commit SHA;
13. require no tracked/staged changes;
14. require the only untracked project path to be `.codex/config.toml`;
15. require Godot count zero.

Do not amend, rebase, squash or force-push.

## 22. Required final execution report

The Task 0024AM handoff and reports together must explicitly answer:

```text
final_gate_recommendation =
  DEEPSEEK_PROJECT_PILOT_ENABLED
  or
  DEEPSEEK_PROJECT_PILOT_BLOCKED

gpt_5_6_native_model_provider_unchanged =
  YES / NO / UNVERIFIED

deepseek_cli_available =
  YES / NO

real_smoke_test_passed =
  YES / NO

deepseek_modified_only_authorized_temporary_file =
  YES / NO / UNVERIFIED

project_local_config_path =
  PATH_A_SUPPORTED_MINIMAL_DECLARATION
  or PATH_B_DOCUMENTATION_ONLY_CLI_ALIGNMENT
  or PATH_C_BLOCKED

project_local_config_hash_before =
  <sha256>

project_local_config_hash_after =
  <sha256>

user_level_worker_core_unchanged =
  YES / NO / UNVERIFIED

project_validation_passed =
  YES / NO

secret_and_key_scan_passed =
  YES / NO

repository_documents_synchronized =
  YES / NO

github_main_synchronized =
  YES / NO

local_codex_inventory_synchronized =
  YES / NO

project_source_import_status =
  READY_FOR_GPT_PROJECT_SOURCE_IMPORT
  or BLOCKED

remaining_limitations =
  <explicit list>
```

The terminal response must include:

- branch;
- start and final HEAD;
- task result commit;
- all changed tracked files;
- all changed local-only files;
- tests/checks run;
- tests/checks not run;
- smoke verdict;
- config alignment path;
- gate recommendation;
- project-source export path;
- rollback location and steps;
- exact remaining constraints.

## 23. Rollback contract

If the pilot is rejected or later disabled:

1. stop invoking DeepSeek for this project;
2. restore `D:\Delayed_Self\.codex\config.toml` from the verified confidential backup when Path A changed it;
3. verify the restored hash equals:

```text
d4c670da3c2404921a1ab177f4e5405449bc8321d713cc0b42b8046201fd33cc
```

4. leave the user-level worker core untouched;
5. revert repository governance documentation only through a new explicit Git task;
6. do not delete historical Task 0024AM reports;
7. mark the current gate `DEEPSEEK_PROJECT_PILOT_BLOCKED` or `DISABLED_BY_LATER_GATE`;
8. continue using GPT-5.6-only execution;
9. keep owner playthrough, production catalog, finale, Profile and release gates unchanged.

## 24. Stop conditions

Stop immediately and report a blocker if:

- the startup config hash differs unexpectedly;
- the project-local config cannot be parsed;
- the user-level worker path or CLI is missing;
- the API-key environment variable is absent;
- safe alignment would change GPT-5.6 model/provider;
- safe alignment requires editing user-level config or worker core;
- DeepSeek touches a tracked project file or unauthorized path;
- CLI output is malformed or secret-bearing;
- the smoke target does not match the exact acceptance criteria;
- temporary files cannot be removed safely;
- a protected project file changes;
- GitHub remote moves after final review;
- GPT-5.6 Sol/Terra review is unavailable;
- project-source export would overclaim actual import;
- any result would require inventing evidence.

## 25. Next gate

If the GPT project advisor later accepts `DEEPSEEK_PROJECT_PILOT_ENABLED`, future implementation tasks may opt into DeepSeek only through an explicit per-task delegation block.

The next legitimate gameplay/product gate remains owner subjective playthrough of sequences 1–12 through the accepted isolated staging route. It must use a new successor task identity, preserve all Task 0024AF–0024AL evidence, and must not be auto-started by Task 0024AM.
