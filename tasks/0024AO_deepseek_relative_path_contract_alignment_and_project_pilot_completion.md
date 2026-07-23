# Task 0024AO — Align the DeepSeek smoke task with the frozen worker relative-path contract and complete the project pilot

- Status: `READY`
- Gate: `FROZEN WORKER PATH-CONTRACT AUDIT / RELATIVE-PATH WRAPPER SMOKE / GPT-5.6 REVIEW / PROJECT SYNC`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Required predecessor startup commit in ancestry: `8369cd1beb1e1c4a662081cb7657f01c4a99fb6a`
- Historical predecessors:
  - `0024AM`: invalid current-process credential preflight;
  - `0024AN`: credential wrapper repaired and validated, then blocked because the prescribed smoke JSON used absolute Windows entries where the frozen worker requires workspace-relative entries.
- User-scope credential state: `PRESENT`
- Current-process visibility: `FILTERED_EXPECTED`
- Wrapper: `C:\Users\zcxve\.codex\helpers\Invoke-DeepSeekFileTask.ps1`
- Reported wrapper SHA-256 prefix: `56289229`; record and preserve the full local SHA-256.
- Frozen worker: `C:\Users\zcxve\.codex\external-agents\deepseek-file-worker-stdlib\deepseek_file_task_cli.py`
- DeepSeek model: `deepseek-v4-pro`
- Authorized transport: `user-scope credential wrapper → frozen CLI worker`
- Required main-agent ownership: `GPT-5.6 Sol`; constrained fallback `GPT-5.6 Terra`
- Possible final recommendation: `DEEPSEEK_PROJECT_PILOT_ENABLED` or `DEEPSEEK_PROJECT_PILOT_BLOCKED`

## 1. Objective

1. Preserve Tasks 0024AM and 0024AN as immutable historical attempts.
2. Preserve the 0024AN wrapper and frozen worker byte-for-byte.
3. Read the frozen worker source and existing local tests/docs to extract its actual task-file path schema.
4. Verify the expected contract: absolute `workspace`, workspace-relative `allowed_paths`, and workspace-relative `context_files`.
5. Author a fresh bounded smoke task using only worker-valid relative entries.
6. Invoke the smoke only through `Invoke-DeepSeekFileTask.ps1`.
7. Prove DeepSeek modifies exactly one temporary authorized target.
8. Keep global/project provider-model routing, shell filtering, wrapper and worker core unchanged.
9. Complete the project configuration/routing audit and governance synchronization intended by 0024AM.
10. Create an upload-ready GPT Project Sources delta without claiming actual Project Sources import.
11. Commit and push authorized repository documentation only after GPT-5.6 review and successful smoke.
12. Return `PASS_FOR_GPT_REVIEW`, `BLOCKED`, or `FAIL`.

This is infrastructure-only. It authorizes no gameplay, Simulation, solver, level, catalog, finale, Profile, player-data, build, release or submission work.

## 2. Predecessor adjudication

Task 0024AM's current-process credential check is superseded. Task 0024AN established that the Windows User-scope credential is present and that current-process absence is expected filtering behavior. It also repaired and validated the wrapper, invoked the real smoke only through that wrapper, and reached the frozen worker.

The worker returned parseable JSON:

```json
{"status":"invalid_input","error":"invalid relative path"}
```

The target remained unchanged, cleanup completed, and no repository file, commit or push was produced. This is a task-schema mismatch, not evidence that the wrapper, credential or API is unavailable.

Task 0024AO explicitly authorizes correcting the smoke JSON to the frozen worker's relative-path contract. It does not authorize changing the worker.

## 3. Hard boundaries

Do not:

- edit Tasks 0024AM or 0024AN;
- modify the wrapper; stop on wrapper drift;
- modify the worker or any file beneath its root;
- invoke Python or the worker directly;
- use MCP delegate;
- use absolute paths in `allowed_paths` or `context_files`;
- use drive prefixes, UNC prefixes, leading separators, `..`, symlink escapes or junction escapes in relative entries;
- use `.codex`, user configuration, Profile/player-data or another sensitive directory as the smoke target;
- alter `shell_environment_policy`;
- set `ignore_default_excludes = true`;
- print, hash, partially reveal, log or persist the credential;
- change user-level `config.toml`, `AGENTS.md`, agents or provider/model definitions;
- let DeepSeek edit tracked repository files;
- launch Godot or rerun historical retained cycles.

## 4. Ownership

GPT-5.6 Sol/Terra exclusively owns worker-contract extraction, task JSON, workspace and path authorization, wrapper invocation, output parsing, changed-path/content/secret review, configuration decisions, validation, Git and verdict.

DeepSeek may read one temporary context file, modify one temporary target, and return its worker result. It may not plan, inspect configuration, change the wrapper, run Shell/Git/tests/builds, access player data, review itself or decide acceptance.

## 5. State machine

```text
STARTUP_GATE
→ PREDECESSOR_AND_LOCAL_WRAPPER_RECONCILIATION
→ FROZEN_WORKER_PATH_SCHEMA_EXTRACTION
→ INDEPENDENT_GPT_5_6_SCHEMA_REVIEW
→ RELATIVE_PATH_FIXTURE_AND_TASK_JSON_AUTHORING
→ PRE_SMOKE_PATH_CANONICALITY_AUDIT
→ REAL_DEEPSEEK_SMOKE_VIA_WRAPPER
→ GPT_5_6_OUTPUT_PATH_CONTENT_AND_SECRET_REVIEW
→ TEMPORARY_SMOKE_CLEANUP
→ PROJECT_CONFIG_AND_ROUTING_AUDIT
→ GOVERNANCE_PROJECT_SOURCE_AND_ROLLBACK_SYNC
→ PRE_COMMIT_AUDIT
→ COMMIT_AND_PUSH
→ POST_PUSH_AUDIT
→ HANDOFF_AND_PASS_FOR_GPT_REVIEW
```

Before the real smoke, Task 0024AO-only fixture/JSON defects are repairable. After the real smoke begins, credential disclosure, worker drift or unauthorized write is terminal.

## 6. Startup gate

Require:

1. root `D:\Delayed_Self`, branch `main`, expected origin;
2. fetch and fast-forward only;
3. `HEAD == origin/main`, divergence `0/0`;
4. Task 0024AO and current pointers from `origin/main`;
5. commit `8369cd1beb1e1c4a662081cb7657f01c4a99fb6a` in ancestry;
6. no tracked/staged changes;
7. only untracked `D:\Delayed_Self\.codex\config.toml`;
8. unchanged config SHA-256 `d4c670da3c2404921a1ab177f4e5405449bc8321d713cc0b42b8046201fd33cc`;
9. Godot count zero and no Godot launch;
10. exact wrapper, Python and worker paths exist;
11. Windows User-scope credential is `PRESENT`, checked without revealing derived metadata;
12. full wrapper SHA-256 is recorded and its bytes satisfy the 0024AN contract;
13. user-level config, agents and worker-root hashes are recorded;
14. no current-process credential-presence check is used.

Stop on remote drift, unexpected files, wrapper/worker drift, genuinely missing User-scope credential or protected-surface change.

## 7. Required reads

```text
AGENTS.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
tasks/0024AO_deepseek_relative_path_contract_alignment_and_project_pilot_completion.md
tasks/0024AN_deepseek_user_scope_credential_wrapper_and_project_pilot_continuation.md
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

Confidentially inspect without reproducing secrets or raw private config:

```text
C:\Users\zcxve\.codex\helpers\Invoke-DeepSeekFileTask.ps1
C:\Users\zcxve\.codex\config.toml
C:\Users\zcxve\.codex\AGENTS.md
C:\Users\zcxve\.codex\agents\
C:\Users\zcxve\.codex\reports\delayed-self\0024AN\
C:\Users\zcxve\.codex\external-agents\deepseek-file-worker-stdlib\
D:\Delayed_Self\.codex\config.toml
```

## 8. Frozen-worker path-contract extraction

Before creating the smoke JSON, GPT-5.6 must read the frozen worker source and pre-existing worker tests/readme to determine:

- `workspace`, `allowed_paths`, and `context_files` semantics;
- accepted separators and normalization;
- workspace-relative resolution;
- file/directory allowance;
- traversal, symlink/junction and sensitive-path rejection;
- input-validation order;
- success and `invalid_input` output schema.

Create no patch. Record contract facts, hashes and source line references.

Expected contract to verify:

```text
workspace = absolute existing workspace directory
allowed_paths[] = canonical relative path beneath workspace
context_files[] = canonical relative file path beneath workspace
```

If source contradicts this expectation, follow the source's exact safe schema. Do not invent a workaround.

## 9. Independent schema review

A GPT-5.6 reviewer must verify before smoke:

- wrapper and worker remain unchanged;
- readable/writable entries are relative to workspace;
- no `..`, drive prefix, leading separator, UNC or sensitive path exists;
- the target is untracked;
- target/context resolve exactly beneath `D:\Delayed_Self`;
- only one write target is authorized;
- JSON contains no credential;
- cleanup is exact and safe.

Do not proceed without a usable reviewer verdict.

## 10. Fresh smoke workspace

Create temporary untracked:

```text
D:\Delayed_Self\deepseek_smoke_0024AO\context.md
D:\Delayed_Self\deepseek_smoke_0024AO\target.md
```

Do not place the smoke beneath `.codex`, tracked code/docs/tests, Profile/player-data or another sensitive surface.

Initial `target.md` must contain exactly:

```text
DEEPSEEK_SMOKE_PENDING
```

The context contains only the mechanical transformation. Record pre-smoke hashes and inventory.

## 11. Correct task JSON

Create outside the repository:

```text
C:\Users\zcxve\.codex\reports\delayed-self\0024AO\deepseek_smoke_task.json
```

Unless source audit proves a different safe spelling, use:

```json
{
  "workspace": "D:\\Delayed_Self",
  "allowed_paths": [
    "deepseek_smoke_0024AO/target.md"
  ],
  "context_files": [
    "deepseek_smoke_0024AO/context.md"
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

Rules:

- `workspace` is absolute;
- `allowed_paths` and `context_files` are workspace-relative;
- no drive prefix, leading separator, `.` or `..` segment in relative entries;
- use forward slashes unless frozen source requires another normalized form;
- include no credential;
- resolve each entry under GPT ownership and prove it equals the intended file.

## 12. Real smoke invocation

Invoke only:

```powershell
& "C:\Users\zcxve\.codex\helpers\Invoke-DeepSeekFileTask.ps1" `
  -TaskFile "C:\Users\zcxve\.codex\reports\delayed-self\0024AO\deepseek_smoke_task.json"
```

Direct Python, direct worker invocation, MCP delegate, alternate provider, manual key injection and shell-policy change are forbidden.

Capture only sanitized stdout/stderr and exit code. Stop without persisting unexpected credential-like material.

## 13. Post-smoke GPT-5.6 review

Verify:

- wrapper exit code and worker JSON parseability/status;
- exact target contents;
- context hash unchanged;
- only `deepseek_smoke_0024AO/target.md` changed;
- no tracked file changed;
- no user-level config/agent/worker/wrapper drift;
- Process-scope credential cleared;
- User-scope credential remains present;
- no secret in JSON/output/report/diff;
- no direct Python/MCP path used;
- Godot zero.

Success requires exactly one `DEEPSEEK_SMOKE_PASS`, exactly one `worker=deepseek-v4-pro`, and no `DEEPSEEK_SMOKE_PENDING`.

DeepSeek self-report alone is not evidence.

## 14. Cleanup

After evidence capture, delete only:

```text
D:\Delayed_Self\deepseek_smoke_0024AO\
```

Preserve sanitized 0024AO user-level reports/task JSON and the 0024AN wrapper backup. Final repository state must return to only untracked `.codex/config.toml`. Do not use repo-wide clean/reset/restore/checkout.

## 15. Project configuration and routing decision

Complete the original 0024AM audit and choose exactly one:

```text
PATH_A_SUPPORTED_MINIMAL_PROJECT_DECLARATION
PATH_B_DOCUMENTATION_ONLY_WRAPPER_ALIGNMENT
PATH_C_BLOCKED
```

Use Path A only if the supported project config schema clearly permits a declaration without altering GPT-5.6 provider/model or automatic routing. Otherwise use Path B and leave project `.codex/config.toml` byte-identical. Never invent TOML keys, providers or native DeepSeek agents.

Regardless of Path A/B:

- wrapper-only invocation;
- explicit per-task delegation;
- GPT-5.6 defines relative allowed/context paths and acceptance criteria;
- DeepSeek receives no Shell/Git/test/build/install authority;
- no credentials/config/Profile/player-data/release access;
- GPT-5.6 reviews output and owns Git/acceptance.

## 16. Repository normalization

Search for direct worker invocation, wrapper references, credential-name references, absolute/relative path guidance, `allowed_paths`, `context_files`, `ignore_default_excludes` and `shell_environment_policy`.

Tasks 0024AM/0024AN remain historical. Current governance must state:

- 0024AM process preflight is superseded;
- 0024AN absolute allowed/context paths are superseded;
- `workspace` is absolute;
- allowed/context entries follow the frozen worker's workspace-relative contract;
- wrapper-only invocation is mandatory;
- shell filtering remains enabled.

No credential value may appear.

## 17. Authorized repository paths

```text
AGENTS.md
docs/agents/PROJECT_RULE_CODEX_MULTI_SUBAGENT_MODEL_ROUTING.md
docs/workflows/DEEPSEEK_FILE_WORKER_CLI_PILOT_WORKFLOW.md
docs/reports/0024AO_DEEPSEEK_RELATIVE_PATH_CONTRACT_AND_PROJECT_PILOT_REPORT.md
docs/reports/0024AO_DEEPSEEK_PROJECT_SYNC_AND_ROLLBACK_REPORT.md
docs/project_sources/DELAYED_SELF_PROJECT_SOURCE_DEEPSEEK_FILE_WORKER_PILOT_CURRENT_2026_07_23.md
docs/handoffs/DELAYED_SELF_SESSION_HANDOFF_AFTER_TASK_0024AO_DEEPSEEK_PROJECT_PILOT_2026_07_23.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
```

Local-only authorized paths:

```text
C:\Users\zcxve\.codex\reports\delayed-self\0024AO\
D:\Delayed_Self\deepseek_smoke_0024AO\
D:\Delayed_Self\.codex\config.toml
```

The wrapper is read-only.

## 18. Protected surfaces

Do not modify predecessor task files, the wrapper, user-level config/AGENTS/agents, worker core, `project.godot`, scenes, scripts, data, schemas, tests, owner worksheet, localization, assets, audio, build/export/release/submission surfaces, or Task 0024AF–0024AL historical artifacts/retained identities. Do not inspect production Profile/player data.

## 19. Required deliverables

```text
docs/workflows/DEEPSEEK_FILE_WORKER_CLI_PILOT_WORKFLOW.md
docs/reports/0024AO_DEEPSEEK_RELATIVE_PATH_CONTRACT_AND_PROJECT_PILOT_REPORT.md
docs/reports/0024AO_DEEPSEEK_PROJECT_SYNC_AND_ROLLBACK_REPORT.md
docs/project_sources/DELAYED_SELF_PROJECT_SOURCE_DEEPSEEK_FILE_WORKER_PILOT_CURRENT_2026_07_23.md
docs/handoffs/DELAYED_SELF_SESSION_HANDOFF_AFTER_TASK_0024AO_DEEPSEEK_PROJECT_PILOT_2026_07_23.md
```

The pilot report records predecessor adjudication, full wrapper hash, worker inventory/hash, source-backed path schema, exact relative entries, wrapper invocation, sanitized result, target/context hashes, path proof, credential state without secret metadata, Path A/B/C, provider-model/shell-policy invariants, secret scan, cleanup and recommendation.

Project Sources export must state:

```text
project_source_import_status = READY_FOR_GPT_PROJECT_SOURCE_IMPORT
```

Do not claim actual import.

## 20. Validation scope

Run Git status/diff checks, wrapper/worker identity checks, worker schema extraction, JSON canonicality, real wrapper smoke, changed-path audit, secret scan, Markdown-link/current-document checks, final cleanliness and Godot-zero check.

Do not launch Godot or run gameplay regression.

Record:

```text
project_test_scope = FROZEN_WORKER_PATH_SCHEMA_WRAPPER_SMOKE_CONFIGURATION_AND_DOCUMENTATION_ONLY
full_gameplay_regression = NOT_RUN_NOT_REQUIRED_NO_GAMEPLAY_CHANGE
```

## 21. Gate logic

Recommend `DEEPSEEK_PROJECT_PILOT_ENABLED` only if wrapper and worker are unchanged, User-scope credential is present, the source-backed relative-path schema is followed, the real wrapper smoke succeeds, only the target changes, output parses, Process-scope credential clears, secret scan passes, smoke directory is removed, GPT-5.6 provider/model and shell policy remain unchanged, governance is synchronized, commit/push succeeds, and Project Sources delta is ready.

Otherwise recommend `DEEPSEEK_PROJECT_PILOT_BLOCKED`.

Codex verdicts: `PASS_FOR_GPT_REVIEW`, `BLOCKED`, or `FAIL`.

## 22. Commit and push

After all gates pass:

1. fetch and require divergence `0/0`;
2. explicitly stage only authorized repository files;
3. never stage project config, user reports or smoke artifacts;
4. run `git diff --cached --check` and review full staged diff;
5. commit `chore(codex): align DeepSeek pilot with relative path contract`;
6. push `main`;
7. verify `HEAD == origin/main`;
8. require no tracked/staged changes, only `.codex/config.toml` untracked, and Godot zero.

## 23. Stop conditions

Stop for wrapper/worker drift, genuinely missing User-scope credential, absence of a safe frozen-worker relative-path contract, credential disclosure, shell-policy weakening, direct Python/MCP use, unauthorized write, malformed result, remote drift, unavailable GPT-5.6 review, protected change or cleanup failure.

Do not stop merely because current-process `$env:DEEPSEEK_API_KEY` is empty.

## 24. Required final fields

```text
predecessor_0024AM_adjudication = INVALID_PROCESS_ENVIRONMENT_PREFLIGHT_SUPERSEDED
predecessor_0024AN_adjudication = ABSOLUTE_ALLOWED_CONTEXT_PATHS_SUPERSEDED_BY_FROZEN_WORKER_RELATIVE_CONTRACT
windows_user_scope_deepseek_credential = PRESENT / MISSING
wrapper_sha256 = <full sha256>
wrapper_unchanged = YES / NO
frozen_worker_core_unchanged = YES / NO / UNVERIFIED
workspace_contract = ABSOLUTE
allowed_paths_contract = WORKSPACE_RELATIVE
context_files_contract = WORKSPACE_RELATIVE
direct_python_invocation_used = NO / YES
real_smoke_test_passed = YES / NO
deepseek_modified_only_authorized_target = YES / NO / UNVERIFIED
process_scope_credential_cleared = YES / NO / UNVERIFIED
gpt_5_6_native_model_provider_unchanged = YES / NO / UNVERIFIED
shell_environment_policy_unchanged = YES / NO / UNVERIFIED
project_local_config_path = PATH_A_SUPPORTED_MINIMAL_PROJECT_DECLARATION / PATH_B_DOCUMENTATION_ONLY_WRAPPER_ALIGNMENT / PATH_C_BLOCKED
secret_scan_passed = YES / NO
github_main_synchronized = YES / NO
project_source_import_status = READY_FOR_GPT_PROJECT_SOURCE_IMPORT / BLOCKED
final_gate_recommendation = DEEPSEEK_PROJECT_PILOT_ENABLED / DEEPSEEK_PROJECT_PILOT_BLOCKED
```

## 25. Rollback and next gate

If later rejected, stop DeepSeek delegation, leave wrapper/worker untouched, restore project-local config only if changed, do not modify User-scope credential or shell filtering, revert governance only through a new Git task, preserve 0024AM–0024AO history, and continue GPT-5.6-only operation.

After GPT acceptance, future tasks may delegate bounded implementation only with absolute `workspace`, frozen-worker-compatible relative `allowed_paths/context_files`, wrapper-only invocation, and GPT-5.6 review/tests.

The next gameplay/product gate remains owner subjective playthrough of sequences 1–12 under a later task identity.