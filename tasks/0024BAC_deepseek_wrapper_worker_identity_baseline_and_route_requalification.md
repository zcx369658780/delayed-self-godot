# Task 0024BAC — DeepSeek wrapper/worker identity baseline and wrapper-only route requalification

- Status: `READY`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Required checkpoint: `b648317f8b65e074dca8607cd0f2f7ba60140179`
- Previous result: `TASK_0024BAB_VISUAL_AUDIO_PLANNING_ACCEPTED_DEEPSEEK_ROUTE_REQUALIFICATION_REQUIRED`
- User gate: `DEEPSEEK_MCP_CONFIG_REMOVAL_ACCEPTED`
- Current route: `FAIL_CLOSED_PENDING_WORKER_SHA_BASELINE`
- Multi-subagent: `MANDATORY`
- DeepSeek invocation/smoke: `NOT_AUTHORIZED`
- User-scope modification/copy/replacement: `NOT_AUTHORIZED`
- Godot/solver/build/Profile/product changes: `NOT_AUTHORIZED`

## 1. Objective

Establish the first accepted candidate byte identity for the wrapper-backed DeepSeek file worker without invoking or modifying it.

Required result:

```text
accepted wrapper SHA verified
+ deterministic worker package aggregate SHA captured twice
+ CLI entry SHA captured
+ MCP/native/automatic routes absent
+ environment state verified as booleans only
+ live rules and Project Source synchronized
→ PASS_FOR_GPT_REVIEW
```

This task does not itself final-accept the route. GPT acceptance is required afterward.

## 2. Fixed read-only targets

```text
wrapper =
C:\Users\zcxve\.codex\helpers\Invoke-DeepSeekFileTask.ps1

worker_root =
C:\Users\zcxve\.codex\external-agents\deepseek-file-worker-stdlib

CLI_entry =
C:\Users\zcxve\.codex\external-agents\deepseek-file-worker-stdlib\deepseek_file_task_cli.py

accepted_wrapper_SHA256 =
f604001d001cd206e742e5252a69995c29f96c983e6520ec6fd0374ae4908750
```

Historical pilot evidence proves the CLI-worker contract previously worked, but does not prove current worker bytes. The new aggregate is seeded from:

```text
OWNER_CONFIRMED_CURRENT_INFRASTRUCTURE
READ_ONLY_DOUBLE_CAPTURE
HISTORICAL_PILOT_CONTRACT_CONTINUITY
```

Do not claim historical smoke byte identity.

## 3. Mandatory GPT subagents

Use at least five distinct configured GPT roles:

```text
planner_high
docs_reader
code_mapper
docs_writer
code_reviewer
```

The main agent alone performs bounded user-scope commands, repository writes, staging, commit, push and verdict.

Routing ledger fields:

```text
role
scope
route_class
inputs
paths
summary
main_disposition
Git_write=NO
DeepSeek_invocation=NO
Godot_solver=NO
Profile_access=NO
secret_value_access=NO
```

If fewer than three usable GPT roles exist, return `BLOCKED_MULTI_SUBAGENT_UNAVAILABLE`. DeepSeek does not count as a GPT role.

## 4. Allowed user-scope inspection

Authorize only:

- existence/type checks;
- regular-file and reparse/symlink/junction checks;
- file size;
- SHA-256;
- deterministic relative-path inventory;
- `codex mcp list`;
- boolean environment-variable presence.

Forbidden:

- printing/copying/storing wrapper or worker content;
- importing or executing worker modules;
- invoking wrapper, worker or DeepSeek;
- smoke testing;
- modifying user scope or environment;
- reading unrelated user files;
- logging secret values, lengths, prefixes or suffixes.

Subagents do not inspect user-scope files directly.

## 5. Environment and MCP gates

Record booleans only:

```text
DEEPSEEK_API_KEY User scope configured = true
ANTHROPIC_API_KEY User scope configured = false
ANTHROPIC_AUTH_TOKEN User scope configured = false
```

Run read-only:

```powershell
codex mcp list
```

Require:

```text
DeepSeek_MCP_present = NO
DeepSeek_native_provider_active = NO
DeepSeek_automatic_native_subagent_active = NO
MCP_fallback_authorized = NO
```

On mismatch, return `BLOCKED_USER_SCOPE_ROUTE_STATE_MISMATCH`. Do not repair.

## 6. Wrapper gate

Require exact wrapper path:

```text
exists = YES
regular_file = YES
reparse_point = NO
SHA256 = f604001d001cd206e742e5252a69995c29f96c983e6520ec6fd0374ae4908750
```

Record path, filename, size and SHA only. Any mismatch fails closed; do not inspect or repair content.

## 7. Worker aggregate algorithm

Require worker root directory and CLI entry to exist, remain inside the root, be regular/non-reparse, and resolve without path escape.

Recursively enumerate regular worker-package files.

Exclude only:

```text
directories:
__pycache__, .pytest_cache, .mypy_cache, .ruff_cache,
cache, logs, tmp, temp

suffixes:
.pyc, .pyo, .log, .tmp, .temp, .bak

files:
Thumbs.db, .DS_Store, desktop.ini
```

Reject included symlinks, junctions, reparse points, devices or non-regular files.

For each included file calculate:

```text
relative_path
size_bytes
lowercase_SHA256
```

Normalize relative path to forward slashes and ordinal-sort it.

Build UTF-8/no-BOM logical stream:

```text
<relative_path>\t<size_bytes>\t<sha256>\n
```

Calculate:

```text
algorithm_id = DS_WORKER_TREE_SHA256_V1
worker_package_aggregate_SHA256 =
SHA256(UTF8_NO_BOM(logical_stream))
```

Record only:

```text
worker_root
algorithm_id
included_file_count
excluded_count_by_class
total_included_bytes
CLI_entry_relative_path
CLI_entry_SHA256
worker_package_aggregate_SHA256
```

Do not commit per-file hashes.

## 8. Double-capture proof

Run the full inventory/aggregate calculation twice in separate fresh PowerShell processes.

Require exact equality of:

```text
relative paths
sizes
per-file hashes
CLI hash
aggregate hash
file counts
total bytes
```

No worker file may change between captures.

If unequal, return `BLOCKED_NONDETERMINISTIC_OR_CHANGED`.

Temporary per-file evidence may exist only in a task-specific OS temp directory outside the repository and user Codex roots. Delete it before staging and prove zero remains.

## 9. Required repository reads

```text
AGENTS.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
tasks/0024BAC_deepseek_wrapper_worker_identity_baseline_and_route_requalification.md
docs/reports/0024BAB_GPT_VISUAL_AUDIO_PLANNING_ACCEPTANCE_AND_DEEPSEEK_ROUTE_BLOCKER_ADJUDICATION.md
docs/reports/0024BAB_SUBMISSION_MINIMUM_VISUAL_AUDIO_PLANNING_REPORT.md
docs/agents/PROJECT_RULE_CODEX_MULTI_SUBAGENT_MODEL_ROUTING.md
docs/project_rules/PROJECT_RULE_MULTI_SUBAGENT_AND_SUBMISSION_EXECUTION_CURRENT.md
docs/workflows/PROJECT_BOOTSTRAP_AND_TASK_WORKFLOW.md
docs/workflows/DEEPSEEK_FILE_WORKER_CLI_PILOT_WORKFLOW.md
docs/reports/0024AM_DEEPSEEK_EXTERNAL_FILE_WORKER_PROJECT_PILOT_REPORT.md
docs/reports/0024AO_DEEPSEEK_RELATIVE_PATH_CONTRACT_AND_PROJECT_PILOT_REPORT.md
docs/reports/0024AR_GPT_DEEPSEEK_MCP_CODE_QUALITY_ADJUDICATION.md
docs/PROJECT_SOURCE_INDEX_CURRENT.md
docs/project_source/DELAYED_SELF_PROJECT_SOURCE_SYNC_CURRENT_AFTER_0024BAB_2026_07_27.md
docs/production/OWNER_VISUAL_AUDIO_DECISION_SHEET_CURRENT.md
docs/production/VISUAL_AUDIO_PARALLEL_EXECUTION_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
```

If a report filename differs, locate the evidence-bearing current name read-only and record the correction. Do not edit historical evidence.

## 10. Machine-readable candidate baseline

Create:

```text
docs/agents/DEEPSEEK_WRAPPER_WORKER_IDENTITY_BASELINE_CURRENT.json
```

Required fields:

```json
{
  "schema_version": 1,
  "status": "CANDIDATE_BASELINE_FOR_GPT_REVIEW",
  "user_level_gate": "DEEPSEEK_MCP_CONFIG_REMOVAL_ACCEPTED",
  "formal_route": "WRAPPER_BACKED_CLI_EXTERNAL_FILE_WORKER",
  "wrapper": {
    "path": "...",
    "size_bytes": 0,
    "sha256": "...",
    "regular_file": true,
    "reparse_point": false
  },
  "worker": {
    "root": "...",
    "algorithm_id": "DS_WORKER_TREE_SHA256_V1",
    "included_file_count": 0,
    "total_included_bytes": 0,
    "cli_entry_relative_path": "deepseek_file_task_cli.py",
    "cli_entry_sha256": "...",
    "package_aggregate_sha256": "...",
    "double_capture_equal": true
  },
  "route_checks": {
    "deepseek_mcp_present": false,
    "deepseek_native_provider_active": false,
    "deepseek_automatic_native_subagent_active": false,
    "mcp_fallback_authorized": false,
    "deepseek_api_key_user_scope_configured": true,
    "anthropic_api_key_user_scope_configured": false,
    "anthropic_auth_token_user_scope_configured": false
  },
  "claims": {
    "historical_smoke_proves_current_bytes": false,
    "current_worker_defect_found": false,
    "worker_invoked": false,
    "wrapper_invoked": false,
    "smoke_run": false,
    "user_scope_modified": false
  },
  "baseline_source": [
    "OWNER_CONFIRMED_CURRENT_INFRASTRUCTURE",
    "READ_ONLY_DOUBLE_CAPTURE",
    "HISTORICAL_PILOT_CONTRACT_CONTINUITY"
  ]
}
```

No per-file worker hashes or timestamps in Git.

## 11. Rule and Project Source synchronization

Update:

```text
AGENTS.md
docs/agents/PROJECT_RULE_CODEX_MULTI_SUBAGENT_MODEL_ROUTING.md
docs/project_rules/PROJECT_RULE_MULTI_SUBAGENT_AND_SUBMISSION_EXECUTION_CURRENT.md
docs/workflows/PROJECT_BOOTSTRAP_AND_TASK_WORKFLOW.md
docs/workflows/DEEPSEEK_FILE_WORKER_CLI_PILOT_WORKFLOW.md
```

Use pending-review wording:

```text
DeepSeek_MCP = REMOVED
native_provider = FORBIDDEN
automatic_native_subagent = FORBIDDEN
formal_route = WRAPPER_BACKED_CLI_EXTERNAL_FILE_WORKER
route_status = IDENTITY_BASELINE_READY_FOR_GPT_REVIEW
scope = GPT_FROZEN_LOW_RISK_BOUNDED_EASY_TO_VERIFY
counts_as_GPT_subagent = NO
GPT_5_6_authority = PLANNING_ALLOWED_PATHS_REVIEW_TEST_GIT_RELEASE_ACCEPTANCE
MCP_fallback = FORBIDDEN
```

Create:

```text
docs/project_source/DELAYED_SELF_PROJECT_SOURCE_SYNC_CURRENT_AFTER_0024BAC_2026_07_27.md
```

Include accepted visual/audio planning, candidate worker aggregate and CLI SHA, algorithm, boolean checks, no invocation/smoke/modification, pending-GPT route status, stable-eight scope and next gate.

Calculate its UTF-8 SHA-256 and update `docs/PROJECT_SOURCE_INDEX_CURRENT.md`.

## 12. Report, handoff and current docs

Create:

```text
docs/reports/0024BAC_DEEPSEEK_WRAPPER_WORKER_IDENTITY_BASELINE_REPORT.md
docs/handoffs/DELAYED_SELF_SESSION_HANDOFF_AFTER_TASK_0024BAC_DEEPSEEK_IDENTITY_2026_07_27.md
```

Update:

```text
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
```

They must agree on candidate baseline, no invocation/smoke, stable eight, S04 deferred, owner visual/audio decisions pending and `HOLD_FOR_OWNER_VISUAL_AUDIO_DECISIONS` after GPT acceptance.

## 13. Authorized repository paths

```text
AGENTS.md
docs/agents/DEEPSEEK_WRAPPER_WORKER_IDENTITY_BASELINE_CURRENT.json
docs/agents/PROJECT_RULE_CODEX_MULTI_SUBAGENT_MODEL_ROUTING.md
docs/project_rules/PROJECT_RULE_MULTI_SUBAGENT_AND_SUBMISSION_EXECUTION_CURRENT.md
docs/workflows/PROJECT_BOOTSTRAP_AND_TASK_WORKFLOW.md
docs/workflows/DEEPSEEK_FILE_WORKER_CLI_PILOT_WORKFLOW.md
docs/project_source/DELAYED_SELF_PROJECT_SOURCE_SYNC_CURRENT_AFTER_0024BAC_2026_07_27.md
docs/PROJECT_SOURCE_INDEX_CURRENT.md
docs/reports/0024BAC_DEEPSEEK_WRAPPER_WORKER_IDENTITY_BASELINE_REPORT.md
docs/handoffs/DELAYED_SELF_SESSION_HANDOFF_AFTER_TASK_0024BAC_DEEPSEEK_IDENTITY_2026_07_27.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
```

No other repository path may change.

## 14. Protected surfaces

Do not modify:

```text
D:\Delayed_Self\.codex\config.toml
C:\Users\zcxve\.codex\helpers\Invoke-DeepSeekFileTask.ps1
C:\Users\zcxve\.codex\external-agents\deepseek-file-worker-stdlib\**
C:\Users\zcxve\.codex\config.toml
C:\Users\zcxve\.codex\AGENTS.md
C:\Users\zcxve\.codex\agents\**
C:\Users\zcxve\.codex\reports\**
Windows User environment variables
docs/project_rules/PROJECT_RULE_SOURCE_SEED_CURRENT.md
all historical reports/evidence
data/**
scripts/**
scenes/**
project.godot
schemas/**
tests/**
localization/**
assets/**
audio/**
shaders/**
build/**
export/**
release/**
submission/**
docs/playtest/**
docs/reviews/**
docs/licenses/**
```

## 15. Startup and validation

Before user-scope inspection require:

```text
root = D:\Delayed_Self
branch = main
HEAD == origin/main
divergence = 0/0
checkpoint b648317f8b65e074dca8607cd0f2f7ba60140179 in ancestry
tracked/staged clean
only untracked = .codex/config.toml
config SHA = D4C670DA3C2404921A1AB177F4E5405449BC8321D713CC0B42B8046201FD33CC
Godot count = 0
five-role ledger initialized
```

Final semantic checks:

```text
distinct_GPT_roles >= 5
DeepSeek/wrapper/worker invoked = NO
smoke = NO
user_scope modified = NO
secret value logged = NO
wrapper SHA exact
worker captures = 2 and equal
worker file count > 0
CLI SHA exact recorded
MCP/native/automatic routes absent
DEEPSEEK_API_KEY configured = YES
Anthropic variables configured = NO
temporary evidence remaining = 0
catalog/finale/assets/audio/Profile/Godot/solver/build modified = NO
```

Parse baseline JSON, verify Project Source SHA, Markdown/UTF-8, allowlist, `git diff --check`, staged diff and final worktree.

## 16. One-commit policy

Exactly one commit:

```text
docs: baseline DeepSeek wrapper worker identity
```

Explicitly stage authorized paths only. No amend/rebase/squash/force push. Push `main`, then require synchronized remote, clean tracked/staged state, only unchanged `.codex/config.toml` untracked and Godot zero.

A post-push omission means `BLOCKED`; no second implementation commit.

## 17. Verdict fields

```text
task_0024bab_status =
  TASK_0024BAB_VISUAL_AUDIO_PLANNING_ACCEPTED_DEEPSEEK_ROUTE_REQUALIFICATION_REQUIRED

distinct_GPT_roles_used = <exact>
wrapper_SHA256 = <exact>
worker_algorithm = DS_WORKER_TREE_SHA256_V1
worker_included_file_count = <exact>
worker_package_aggregate_SHA256 = <exact>
CLI_entry_SHA256 = <exact>
worker_double_capture_equal = YES / NO
DeepSeek_MCP_present = NO / YES
DeepSeek_native_provider_active = NO / YES
DeepSeek_automatic_native_subagent_active = NO / YES
DEEPSEEK_API_KEY_user_configured = YES / NO
ANTHROPIC_API_KEY_user_configured = NO / YES
ANTHROPIC_AUTH_TOKEN_user_configured = NO / YES
DeepSeek_invoked = NO / YES
smoke_run = NO / YES
user_scope_modified = NO / YES
Project_Source_SHA256 = <exact>
production_catalog_modified = NO / YES
formal_finale_modified = NO / YES
next_gate = HOLD_FOR_OWNER_VISUAL_AUDIO_DECISIONS
final_task_verdict = PASS_FOR_GPT_REVIEW / BLOCKED
```

## 18. Next gate

Only GPT acceptance may promote the candidate aggregate to the accepted worker baseline.

After acceptance:

```text
DeepSeek_route_status = IDENTITY_READY_FAIL_CLOSED_ON_MISMATCH
next_product_gate = HOLD_FOR_OWNER_VISUAL_AUDIO_DECISIONS
```

Do not publish a visual/audio implementation task and do not reopen S04.
