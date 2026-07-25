# Task 0024AQ — Reconcile DeepSeek wrapper drift and continue the MCP code-quality pilot

- Status: `READY`
- Gate: `WRAPPER DRIFT FORENSICS / SAFE ACCEPT-OR-REBUILD / MCP CODE-QUALITY CONTINUATION`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Required predecessor checkpoint: `26354b4fdaa0ad8bd5ebba046b526a7aa2b1d0cb`
- Previous accepted infrastructure gate: `TASK_0024AO_DEEPSEEK_PROJECT_PILOT_ACCEPTED`
- Historical stopped task: `tasks/0024AP_deepseek_mcp_bounded_gdscript_code_quality_pilot.md`
- 0024AP stop point: `STARTUP_GATE`
- Previously accepted wrapper SHA-256: `56289229ffa0e975f9f9751a5998c777e5827b5c2639f7f74ae6c7cbbb07c1d1`
- Observed wrapper SHA-256 at 0024AP startup: `f604001d001cd206e742e5252a69995c29f96c983e6520ec6fd0374ae4908750`
- Wrapper: `C:\Users\zcxve\.codex\helpers\Invoke-DeepSeekFileTask.ps1`
- Main model: `GPT-5.6 Sol`; constrained fallback `GPT-5.6 Terra`
- DeepSeek target: `deepseek-v4-pro`

## 1. Objective

1. Preserve Task 0024AP as an immutable stopped attempt.
2. Back up and audit the current wrapper before any change.
3. Classify the drift as byte-only, safe equivalent, safe stricter, unsafe/unknown, or blocked.
4. Accept the current wrapper only after complete static and runtime requalification.
5. Otherwise rebuild the canonical wrapper from Task 0024AN; do not restore its pre-repair backup blindly.
6. Freeze one new authoritative wrapper hash.
7. Repeat MCP ping/tool discovery and continue the bounded GDScript quality benchmark defined by Task 0024AP.
8. Keep MCP transport and DeepSeek code quality as separate verdicts.
9. Leave gameplay, Simulation, solver, levels, catalog, Profile, owner review and release surfaces unchanged.

0024AP performed only repository synchronization and a no-write MCP ping. It created no worktree, delegated no code, ran no tests and modified no file. Its ping may be recorded as preliminary only and must be repeated.

## 2. Ownership

GPT-5.6 exclusively owns wrapper forensics, backup/replacement, MCP inspection, benchmark contract, hidden tests, prompts, tool calls, materialization of returned code, tests, review, scoring, Git and verdict.

DeepSeek may author or revise only `tests/deepseek_quality/action_sequence_codec.gd`, read only the public contract/minimal style context, and respond through MCP or the accepted wrapper control when MCP is blocked.

DeepSeek may not inspect hidden tests, modify the wrapper/configuration, run Shell/Git/Godot/tests/builds, access secrets/Profile data, touch production files, or decide acceptance.

## 3. Hard prohibitions

Do not:

- accept a wrapper hash merely because it exists;
- expose or derive metadata from `DEEPSEEK_API_KEY`;
- write the key to JSON, config, logs, reports, command lines or Git;
- change `C:\Users\zcxve\.codex\config.toml`, user agents, provider/model definitions or the frozen worker core;
- set `ignore_default_excludes = true` or weaken `shell_environment_policy`;
- install/upgrade MCP components;
- claim wrapper fallback as MCP success;
- merge failing benchmark code;
- modify Task 0024AP or any Task 0024AF–0024AO historical artifact.

## 4. State machine

```text
STARTUP_GATE
→ STOPPED_0024AP_RECONCILIATION
→ CURRENT_WRAPPER_BYTE_BACKUP
→ WRAPPER_FORENSIC_DIFF
→ INDEPENDENT_GPT_5_6_SECURITY_REVIEW
→ ACCEPT_CURRENT_OR_REBUILD_CANONICAL
→ WRAPPER_STATIC_REQUALIFICATION
→ WRAPPER_NEGATIVE_RUNTIME_PROBES
→ WRAPPER_POSITIVE_ISOLATED_SMOKE
→ AUTHORITATIVE_WRAPPER_HASH_FREEZE
→ MCP_REGISTRATION_READ_ONLY_AUDIT
→ MCP_PING_AND_TOOL_DISCOVERY
→ ISOLATED_BENCHMARK_WORKTREE
→ GPT_5_6_CONTRACT_FREEZE
→ INDEPENDENT_PRE_DELEGATION_REVIEW
→ DEEPSEEK_FIRST_PASS
→ FIRST_PASS_CAPTURE_AND_FREEZE
→ GPT_5_6_HIDDEN_TEST_AUTHORING
→ FIRST_PASS_TEST_AND_DIFF_REVIEW
→ OPTIONAL_SINGLE_DEEPSEEK_REPAIR
→ FINAL_TEST_AND_CODE_REVIEW
→ TRANSPORT_AND_QUALITY_SCORING
→ RETAIN_OR_DISCARD_BENCHMARK_CODE
→ REPORT_AND_CURRENT_DOC_SYNC
→ PRE_COMMIT_AUDIT
→ COMMIT_AND_PUSH
→ WORKTREE_CLEANUP_AND POST_PUSH_AUDIT
→ HANDOFF_AND_PASS_FOR_GPT_REVIEW
```

## 5. Startup gate

Require:

1. root `D:\Delayed_Self`, branch `main`, expected `origin`;
2. fetch and fast-forward only;
3. `HEAD == origin/main`, divergence `0/0`;
4. Task 0024AQ and current pointers present;
5. checkpoint `26354b4fdaa0ad8bd5ebba046b526a7aa2b1d0cb` in ancestry;
6. no tracked/staged changes;
7. only untracked `.codex/config.toml`;
8. project config SHA-256 `d4c670da3c2404921a1ab177f4e5405449bc8321d713cc0b42b8046201fd33cc`;
9. Godot count zero;
10. no stale `D:\Delayed_Self_DeepSeek_MCP_0024AQ` worktree;
11. record current wrapper, user config/agents/MCP files and worker-root hashes without exposing contents.

A wrapper hash mismatch is the subject of this task and is not itself a blocker.

## 6. Required reads

Read `AGENTS.md`, current pointers, this task, Tasks 0024AP and 0024AN, Task 0024AO GPT acceptance/report/workflow/routing/Project Sources delta, and the current development/index/handoff/memory documents.

Confidentially inspect only the minimum necessary files under:

```text
C:\Users\zcxve\.codex\helpers\
C:\Users\zcxve\.codex\config.toml
C:\Users\zcxve\.codex\agents\
C:\Users\zcxve\.codex\external-agents\
C:\Users\zcxve\.codex\reports\delayed-self\0024AN\
C:\Users\zcxve\.codex\reports\delayed-self\0024AO\
```

Do not report raw endpoints, headers, credentials or confidential config.

## 7. Wrapper backup and forensics

Before modifying the wrapper, create a byte-identical backup:

```text
C:\Users\zcxve\.codex\reports\delayed-self\0024AQ\rollback\Invoke-DeepSeekFileTask.current_before_0024AQ.ps1
```

Verify backup and current hashes match. Preserve it after closeout.

Compare current wrapper against the canonical implementation embedded in Task 0024AN and the security contract accepted by Task 0024AO. Record encoding/BOM, line endings, parameters, executable/worker paths, User-scope read, Process-scope set/clear, `finally`, exit-code handling, extra commands, logging/transcript/file writes, Git/install/network/shell-policy behavior and User/Machine credential writes.

The pre-0024AN backup is provenance only and is not automatically an accepted restoration source.

## 8. Wrapper classification

Choose exactly one:

```text
ACCEPT_CURRENT_BYTE_ONLY_DRIFT
ACCEPT_CURRENT_SAFE_EQUIVALENT
ACCEPT_CURRENT_SAFE_STRICTER
REBUILD_CANONICAL_WRAPPER
BLOCKED_UNRESOLVED_WRAPPER_DRIFT
```

Accept current only when it:

- accepts exactly one mandatory absolute `TaskFile`;
- uses only the approved Python/worker pair;
- reads the credential only from Windows User scope;
- injects only Process scope;
- clears Process scope and local credential in `finally`;
- preserves worker exit code;
- performs no logging/transcript, Git, install, unrelated child process or User/Machine credential write;
- does not weaken shell filtering or add authority;
- passes all static/runtime probes and the accepted relative-path task contract.

If unsafe/incompatible/unprovable, rebuild from the canonical Task 0024AN implementation: write to a temp file, parse and review, atomically replace, record the new hash, and requalify. Do not require reconstruction to reproduce the old historical hash.

## 9. Wrapper tests

Static proof must cover AST parsing, one `TaskFile` parameter, one User-scope read, no User/Machine writes, Process set/clear in `finally`, local variable clearing, exact Python/worker, no key interpolation, no transcript/log/Git/install/policy mutation/extra process.

Runtime probes:

- reject relative task path;
- reject missing absolute task file;
- reject malformed JSON through the frozen worker;
- preserve User-scope credential;
- leave no Process-scope credential in the parent;
- preserve user config/agents/worker hashes;
- Godot zero.

Then run one positive isolated wrapper smoke in `D:\Delayed_Self_DeepSeek_Wrapper_0024AQ` using absolute workspace and relative `allowed_paths`/`context_files`. Require exit 0, parseable `completed`, one target change, context identity, Process cleanup, no tracked change, and exact workspace cleanup.

Freeze:

```text
authoritative_wrapper_sha256 = <full lowercase hash>
```

This supersedes the exact hash pinned by 0024AO/0024AP only after successful requalification.

## 10. MCP and quality continuation

Repeat the no-write MCP ping/tool discovery. Report separately:

```text
deepseek_mcp_transport_status = PASS_DIRECT_FILE_EDIT | PASS_PATCH_RETURN | BLOCKED
quality_evaluation_transport = MCP | ACCEPTED_WRAPPER_CONTROL | NOT_RUN
```

Do not repair MCP configuration. If MCP cannot provide bounded code, use the reconciled wrapper once only as a clearly labeled model-quality control.

Create clean temporary worktree:

```text
D:\Delayed_Self_DeepSeek_MCP_0024AQ
```

Use the same pure GDScript action-sequence codec benchmark, public API, error rules, 256-action bound and 100-point rubric defined by Task 0024AP.

Create:

```text
tests/deepseek_quality/task_0024aq_action_sequence_codec_contract.md
tests/deepseek_quality/action_sequence_codec.gd
tests/deepseek_quality/task_0024aq_action_sequence_codec_validation.gd
tests/deepseek_quality/task_0024aq_action_sequence_codec_hidden_cases.json
```

DeepSeek may modify only `action_sequence_codec.gd`. Freeze its first-pass hash before GPT creates hidden tests. Run parse/public/hidden/fresh-process tests. Allow at most one DeepSeek repair using sanitized failures; no third turn. Record any GPT direct code correction.

Score unchanged from 0024AP:

- correctness 45;
- boundary discipline 15;
- code quality 20;
- revision burden 15;
- explanation/self-consistency 5.

Verdicts:

```text
85–100 = ACCEPTABLE_FOR_BOUNDED_IMPLEMENTATION
70–84  = CONDITIONAL_MECHANICAL_ONLY
0–69   = NOT_ACCEPTABLE
```

Unauthorized writes, hidden-test tampering, secret/config access, production changes or unresolved P0/P1 yield `NOT_ACCEPTABLE` regardless of score.

Retain benchmark code/tests only if all final tests pass and score is at least 70; otherwise commit reports/current docs only.

## 11. Authorized repository paths

```text
tests/deepseek_quality/action_sequence_codec.gd
tests/deepseek_quality/task_0024aq_action_sequence_codec_contract.md
tests/deepseek_quality/task_0024aq_action_sequence_codec_validation.gd
tests/deepseek_quality/task_0024aq_action_sequence_codec_hidden_cases.json
docs/reports/0024AQ_DEEPSEEK_WRAPPER_DRIFT_AND_MCP_CODE_QUALITY_REPORT.md
docs/agents/PROJECT_RULE_CODEX_MULTI_SUBAGENT_MODEL_ROUTING.md
docs/workflows/DEEPSEEK_FILE_WORKER_CLI_PILOT_WORKFLOW.md
docs/project_sources/DELAYED_SELF_PROJECT_SOURCE_DEEPSEEK_FILE_WORKER_PILOT_CURRENT_2026_07_23.md
docs/handoffs/DELAYED_SELF_SESSION_HANDOFF_AFTER_TASK_0024AQ_DEEPSEEK_MCP_QUALITY_2026_07_26.md
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
C:\Users\zcxve\.codex\reports\delayed-self\0024AQ\
D:\Delayed_Self_DeepSeek_Wrapper_0024AQ\
D:\Delayed_Self_DeepSeek_MCP_0024AQ\
```

## 12. Protected surfaces

Do not modify Task 0024AP, user-level config/AGENTS/agents, frozen worker core, `project.godot`, production `scenes/**`, `scripts/**`, `data/**`, `schemas/**`, production/aggregate tests, owner worksheet, localization/assets/audio/build/export/release/submission surfaces, or historical Task 0024AF–0024AO artifacts. Do not inspect production Profile/player data.

## 13. Report and synchronization

Create `docs/reports/0024AQ_DEEPSEEK_WRAPPER_DRIFT_AND_MCP_CODE_QUALITY_REPORT.md` containing stopped-0024AP facts, wrapper before/after hashes, backup, forensic classification/diff, accept/rebuild decision, tests/smoke, authoritative hash, MCP capability/verdict, benchmark hashes/tests/score/repair burden, unauthorized-path result, retention decision, future allowed/prohibited scopes and limitations.

Update current docs and Project Sources delta with the new authoritative wrapper hash, MCP result, quality verdict and benchmark retention. Actual Project Sources UI import remains user/advisor-owned. Owner playthrough remains `NOT_YET_REVIEWED`; production catalog/finale/Profile remain unchanged.

## 14. Validation and Git

Run Git status/diff checks, wrapper probes, benchmark tests and Markdown-link/secret scans. Do not run full gameplay regression or retained manifests; record `full_gameplay_regression = NOT_RUN_NOT_REQUIRED_NO_PRODUCTION_CHANGE`.

After all gates pass:

1. fetch and require divergence `0/0`;
2. explicitly stage only authorized retained repository files;
3. never stage wrapper, backups, local reports or worktrees;
4. run `git diff --cached --check` and review full staged diff;
5. commit `test(codex): reconcile DeepSeek wrapper and evaluate MCP quality`;
6. push `main`, verify `HEAD == origin/main`;
7. leave no tracked/staged changes and only `.codex/config.toml` untracked;
8. remove temporary workspaces/worktree;
9. require Godot zero.

## 15. Stop conditions

Stop for inability to back up current wrapper, unresolved/unsafe semantics, failed canonical rebuild, credential exposure, global config/agent/worker drift, shell-policy weakening, remote drift, unauthorized DeepSeek write, hidden-test access, unreliable test harness, protected change or cleanup failure. MCP failure alone does not prevent wrapper-control quality evaluation.

## 16. Required final fields

```text
stopped_0024ap_adjudication = EXACT_WRAPPER_HASH_DRIFT_REQUIRES_NEW_GATE
wrapper_sha256_before = <actual>
wrapper_reconciliation = ACCEPT_CURRENT_BYTE_ONLY_DRIFT | ACCEPT_CURRENT_SAFE_EQUIVALENT | ACCEPT_CURRENT_SAFE_STRICTER | REBUILD_CANONICAL_WRAPPER | BLOCKED_UNRESOLVED_WRAPPER_DRIFT
authoritative_wrapper_sha256 = <hash or BLOCKED>
shell_environment_policy_unchanged = YES | NO | UNVERIFIED
deepseek_mcp_transport_status = PASS_DIRECT_FILE_EDIT | PASS_PATCH_RETURN | BLOCKED
quality_evaluation_transport = MCP | ACCEPTED_WRAPPER_CONTROL | NOT_RUN
deepseek_code_quality_score = <0-100 or NOT_EVALUATED>
deepseek_code_quality_status = ACCEPTABLE_FOR_BOUNDED_IMPLEMENTATION | CONDITIONAL_MECHANICAL_ONLY | NOT_ACCEPTABLE | NOT_EVALUATED
first_pass_tests = PASS | FAIL | NOT_RUN
repair_turns_used = 0 | 1
gpt_direct_code_correction = YES | NO
unauthorized_paths_modified = YES | NO | UNVERIFIED
benchmark_code_retained = YES | NO
gpt_5_6_review_passed = YES | NO
owner_playthrough_status = NOT_YET_REVIEWED
final_task_verdict = PASS_FOR_GPT_REVIEW | PASS_WITH_OBSERVATIONS_FOR_GPT_REVIEW | BLOCKED | FAIL
```

## 17. Next gate

After GPT advisor review, accept the new wrapper hash only if proven, authorize MCP only if its transport separately passes, and scope future coding delegation according to the measured quality verdict. Core Simulation, solver, Profile, security, build, release and final acceptance remain GPT-5.6-owned. Owner subjective 1–12 playthrough remains a separate later product gate.
