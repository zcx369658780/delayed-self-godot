# Task 0024AR — Retry DeepSeek code-quality evaluation with a pre-existing regular target

- Status: `READY`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Required checkpoint in ancestry: `8cd9b68775383dd09e7187c65b4c7b2fc5a4bdb6`
- Previous accepted infrastructure gate: `TASK_0024AO_DEEPSEEK_PROJECT_PILOT_ACCEPTED`
- Task 0024AQ overall result: `BLOCKED`
- Accepted 0024AQ subgate:
  - `wrapper_reconciliation = ACCEPT_CURRENT_SAFE_STRICTER`
  - authoritative wrapper SHA-256:
    `f604001d001cd206e742e5252a69995c29f96c983e6520ec6fd0374ae4908750`
  - negative wrapper probes passed;
  - isolated positive wrapper smoke passed.
- 0024AQ MCP blocker: authoring was rejected before code creation because the target path was not a pre-existing regular file.
- DeepSeek target model: `deepseek-v4-pro`
- Main agent: `GPT-5.6 Sol`; fallback `GPT-5.6 Terra`

## 1. Objective

1. Preserve Tasks 0024AP and 0024AQ as historical attempts.
2. Accept the F604 wrapper hash without repeating the full forensic audit.
3. Repeat MCP ping/tool discovery without changing MCP registration.
4. Create an isolated benchmark worktree.
5. Create the public contract and a pre-existing regular target file before delegation.
6. Prove the target is regular, non-reparse, inside the worktree and the only writable path.
7. Delegate one pure GDScript implementation through MCP.
8. Freeze first-pass code before hidden tests exist.
9. Create GPT-owned hidden tests after first-pass freeze.
10. Allow at most one DeepSeek repair.
11. Evaluate MCP transport and model code quality separately.
12. Use the accepted wrapper once as a labelled control only when MCP still produces no auditable code.
13. Score code only when actual DeepSeek-authored code exists.
14. Retain benchmark code only when all tests pass and score is at least 70.
15. Leave all production, Profile, Simulation, solver, level, catalog, build and release surfaces unchanged.

## 2. GPT adjudication of 0024AQ

Accept:

```text
TASK_0024AQ_WRAPPER_SAFE_STRICTER_ACCEPTED
authoritative_wrapper_sha256 =
f604001d001cd206e742e5252a69995c29f96c983e6520ec6fd0374ae4908750
```

Do not accept an MCP or code-quality result from 0024AQ. No code was produced, so:

```text
deepseek_code_quality_status = NOT_EVALUATED
```

Treat its MCP rejection as:

```text
MCP_TARGET_MUST_BE_PRE_EXISTING_REGULAR_FILE
```

This task corrects only that fixture precondition.

## 3. Ownership

GPT-5.6 exclusively owns:

- repository/worktree operations;
- wrapper/MCP identity checks;
- public contract and initial stub;
- hidden tests;
- exact prompt and allowed paths;
- invocation and output materialization;
- test execution;
- diff/security review;
- scoring;
- Git and verdict.

DeepSeek may only read the public contract and minimal style context, then replace one pre-existing implementation file. It may not inspect hidden tests, run tools, access config/secrets/Profile data, touch production code, or perform Git.

## 4. Hard prohibitions

Do not:

- modify the F604 wrapper;
- modify user-level config, agents, MCP registration or worker core;
- weaken `shell_environment_policy`;
- enable `ignore_default_excludes`;
- expose credentials or raw endpoints;
- delegate a missing path, directory, symlink, junction or reparse point;
- give workspace-wide write access;
- reveal hidden tests before first-pass freeze;
- count transport failure as poor code quality;
- report wrapper fallback as MCP success;
- merge failing benchmark code.

## 5. State machine

```text
STARTUP_GATE
→ WRAPPER_AND_MCP_IDENTITY_CHECK
→ MCP_PING_AND_TOOL_DISCOVERY
→ ISOLATED_WORKTREE_CREATION
→ PUBLIC_CONTRACT_AUTHORING
→ PRE_EXISTING_TARGET_CREATION
→ TARGET_REGULAR_FILE_GATE
→ INDEPENDENT_PRE_DELEGATION_REVIEW
→ MCP_FIRST_PASS
→ FIRST_PASS_CAPTURE_AND_FREEZE
→ HIDDEN_TEST_AUTHORING
→ FIRST_PASS_TESTS
→ OPTIONAL_ONE_TURN_REPAIR
→ FINAL_TEST_AND_CODE_REVIEW
→ TRANSPORT_AND_QUALITY_SCORING
→ RETAIN_OR_DISCARD
→ REPORT_AND_CURRENT_DOC_SYNC
→ PRE_COMMIT_AUDIT
→ COMMIT_AND_PUSH
→ WORKTREE_CLEANUP
→ PASS_FOR_GPT_REVIEW
```

## 6. Startup gate

Require:

1. root `D:\Delayed_Self`;
2. branch `main`;
3. expected origin;
4. fetch and fast-forward only;
5. `HEAD == origin/main`, divergence `0/0`;
6. Task 0024AR and current pointers present;
7. checkpoint `8cd9b68775383dd09e7187c65b4c7b2fc5a4bdb6` in ancestry;
8. no tracked/staged changes;
9. only untracked `.codex/config.toml`;
10. project config SHA-256:
    `d4c670da3c2404921a1ab177f4e5405449bc8321d713cc0b42b8046201fd33cc`;
11. wrapper SHA-256:
    `f604001d001cd206e742e5252a69995c29f96c983e6520ec6fd0374ae4908750`;
12. user config, MCP registration and worker identities unchanged from 0024AQ;
13. Godot count zero;
14. no stale `D:\Delayed_Self_DeepSeek_MCP_0024AR`.

Do not repeat the full wrapper forensic audit.

## 7. Required reads

```text
AGENTS.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
tasks/0024AR_deepseek_mcp_preexisting_target_code_quality_retry.md
tasks/0024AQ_deepseek_wrapper_drift_reconciliation_and_mcp_quality_continuation.md
tasks/0024AP_deepseek_mcp_bounded_gdscript_code_quality_pilot.md
docs/reports/0024AQ_DEEPSEEK_WRAPPER_DRIFT_AND_MCP_CODE_QUALITY_REPORT.md
docs/reports/0024AO_GPT_DEEPSEEK_PROJECT_PILOT_ACCEPTANCE.md
docs/workflows/DEEPSEEK_FILE_WORKER_CLI_PILOT_WORKFLOW.md
docs/agents/PROJECT_RULE_CODEX_MULTI_SUBAGENT_MODEL_ROUTING.md
docs/project_sources/DELAYED_SELF_PROJECT_SOURCE_DEEPSEEK_FILE_WORKER_PILOT_CURRENT_2026_07_23.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
```

Inspect only minimal safe MCP registration facts. Do not record raw private config.

## 8. MCP transport gate

Repeat no-write ping and tool discovery.

Allowed transport verdicts:

```text
PASS_DIRECT_FILE_EDIT
PASS_PATCH_RETURN
BLOCKED
```

Do not repair MCP configuration.

## 9. Isolated worktree

Create:

```text
D:\Delayed_Self_DeepSeek_MCP_0024AR
```

from synchronized main.

The worktree must be clean, non-reparse, contain no Profile data or secrets, and be removed at closeout. Main worktree must remain clean.

## 10. Benchmark files

GPT creates:

```text
tests/deepseek_quality/task_0024ar_action_sequence_codec_contract.md
```

GPT also creates the target before delegation:

```text
tests/deepseek_quality/action_sequence_codec.gd
```

Initial target must contain exactly:

```gdscript
# Task 0024AR pre-existing implementation target.
# DeepSeek must replace this file according to the public contract.
```

After first-pass freeze, GPT creates:

```text
tests/deepseek_quality/task_0024ar_action_sequence_codec_validation.gd
tests/deepseek_quality/task_0024ar_action_sequence_codec_hidden_cases.json
```

DeepSeek must never read or modify the hidden files.

## 11. Mandatory target gate

Before delegation prove:

- target exists;
- target is a regular file;
- target is not a directory, symlink, junction or reparse point;
- canonical target is beneath the isolated worktree;
- target contains the exact stub;
- target SHA-256 is recorded;
- only target is writable;
- contract/style context is read-only;
- hidden tests do not exist;
- there are no unexpected worktree changes.

Repair GPT-authored fixture defects before calling DeepSeek.

## 12. Public contract

Use the exact functional contract from Task 0024AP section 12.

Required class:

```gdscript
class_name ActionSequenceCodec
extends RefCounted
```

Constants:

```gdscript
const MAX_ACTIONS: int = 256
const VALID_ACTIONS: PackedStringArray = PackedStringArray([
    "UP", "DOWN", "LEFT", "RIGHT", "WAIT",
])
```

Functions:

```gdscript
static func normalize(raw_actions: Array) -> Dictionary
static func encode_runs(actions: PackedStringArray) -> Dictionary
static func decode_runs(encoded: String) -> Dictionary
```

Preserve all 0024AP normalization, encoding, decoding, error-code, error-index, 256-action and determinism requirements. The contract may not change after first-pass code is produced.

## 13. MCP first pass

DeepSeek receives only:

- public contract;
- exact target path;
- target stub;
- one short GDScript style excerpt;
- explicit single-file boundary.

Preferred:

- direct edit of the pre-existing target; or
- complete-file/patch return materialized exactly by GPT.

After response:

1. prove target remains regular;
2. prove only target changed;
3. record first-pass SHA-256 and line count;
4. preserve an external evidence copy;
5. freeze first pass;
6. only then create hidden tests.

If MCP still says the target is not regular despite the passed target gate, record a transport contradiction and use wrapper control.

## 14. Wrapper control

Use only if MCP remains blocked.

The wrapper control must use an isolated workspace containing a pre-existing regular `action_sequence_codec.gd`, the public contract as context, and exactly one writable relative path.

Invoke only:

```powershell
& "C:\Users\zcxve\.codex\helpers\Invoke-DeepSeekFileTask.ps1" `
  -TaskFile "<absolute task JSON path>"
```

If it produces auditable code:

```text
quality_evaluation_transport = ACCEPTED_WRAPPER_CONTROL
```

If it again returns no auditable code, close honestly as `BLOCKED / NOT_EVALUATED`.

## 15. Hidden tests and execution

After first-pass freeze, GPT hidden tests must cover at least:

- parse/load and public surface;
- empty inputs;
- case and whitespace normalization;
- every valid action;
- non-string and invalid-action errors;
- exact 256 and overflow 257;
- input immutability;
- deterministic repeated calls;
- run encoding;
- invalid canonical tokens;
- decode whitespace/case handling;
- every malformed segment classification from 0024AP;
- overflow in later segment;
- round trips;
- large alternating sequence;
- result non-aliasing;
- no file/network/process/Profile/project-setting access;
- no production dependency.

Emit:

```text
TASK_0024AR_DEEPSEEK_CODEC_PASS assertions=<n> cases=<n>
```

Only GPT launches Godot. Run parse, public, hidden, fresh-process repeat, static checks and `git diff --check`. Do not run retained manifests or full gameplay regression.

## 16. Optional repair

Permit at most one DeepSeek repair when actual code exists and only functional/style tests fail.

Provide only sanitized failure names and expected/actual values. Do not reveal hidden-test source. Rerun all tests afterward.

If GPT directly fixes implementation:

```text
gpt_direct_code_correction = YES
```

and the quality verdict cannot exceed `CONDITIONAL_MECHANICAL_ONLY`.

## 17. Quality scoring

Use unchanged 0024AP rubric:

- Functional correctness: 45
- Boundary discipline: 15
- Code quality: 20
- Revision burden: 15
- Explanation/self-consistency: 5

Verdicts:

```text
85–100 = ACCEPTABLE_FOR_BOUNDED_IMPLEMENTATION
70–84  = CONDITIONAL_MECHANICAL_ONLY
0–69   = NOT_ACCEPTABLE
```

Do not score transport failures.

Unauthorized writes, secret/config access, hidden-test tampering, production changes or unresolved P0/P1 defects force `NOT_ACCEPTABLE`.

## 18. Retention

Retain benchmark implementation/tests only when all tests pass and score is at least 70. Otherwise remove benchmark code/tests from the candidate commit and retain only reports/current docs.

Benchmark code is test-only and must never be imported by production code.

## 19. Authorized repository paths

```text
tests/deepseek_quality/action_sequence_codec.gd
tests/deepseek_quality/task_0024ar_action_sequence_codec_contract.md
tests/deepseek_quality/task_0024ar_action_sequence_codec_validation.gd
tests/deepseek_quality/task_0024ar_action_sequence_codec_hidden_cases.json
docs/reports/0024AR_DEEPSEEK_MCP_PREEXISTING_TARGET_CODE_QUALITY_REPORT.md
docs/agents/PROJECT_RULE_CODEX_MULTI_SUBAGENT_MODEL_ROUTING.md
docs/workflows/DEEPSEEK_FILE_WORKER_CLI_PILOT_WORKFLOW.md
docs/project_sources/DELAYED_SELF_PROJECT_SOURCE_DEEPSEEK_FILE_WORKER_PILOT_CURRENT_2026_07_23.md
docs/handoffs/DELAYED_SELF_SESSION_HANDOFF_AFTER_TASK_0024AR_DEEPSEEK_QUALITY_2026_07_26.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
```

Local-only:

```text
D:\Delayed_Self_DeepSeek_MCP_0024AR\
C:\Users\zcxve\.codex\reports\delayed-self\0024AR\
```

No other path may change.

## 20. Protected surfaces

Do not modify:

```text
tasks/0024AP_deepseek_mcp_bounded_gdscript_code_quality_pilot.md
tasks/0024AQ_deepseek_wrapper_drift_reconciliation_and_mcp_quality_continuation.md
C:\Users\zcxve\.codex\helpers\Invoke-DeepSeekFileTask.ps1
C:\Users\zcxve\.codex\config.toml
C:\Users\zcxve\.codex\AGENTS.md
C:\Users\zcxve\.codex\agents\**
C:\Users\zcxve\.codex\external-agents\deepseek-file-worker-stdlib\**
project.godot
scenes/**
scripts/**
data/**
schemas/**
tests/run_all.gd
tests/simulation/**
tests/levels/**
tests/curriculum/**
tests/playtest/**
tests/presentation/**
tests/tools/run_owned_godot_headless.ps1
docs/playtest/SUBMISSION_CORE_1_12_OWNER_CURRICULUM_REVIEW_CURRENT.md
localization/**
assets/**
audio/**
build/**
export/**
release/**
submission/**
all Task 0024AF–0024AQ historical artifacts
```

Do not inspect production Profile/player data.

## 21. Required report

Create:

```text
docs/reports/0024AR_DEEPSEEK_MCP_PREEXISTING_TARGET_CODE_QUALITY_REPORT.md
```

Include:

- start/final HEAD;
- accepted F604 wrapper hash;
- MCP capability summary;
- target-stub hash and regular-file proof;
- MCP verdict;
- wrapper-control result if used;
- first-pass and repair hashes when code exists;
- changed paths;
- first/final test results;
- assertion/case counts;
- score breakdown;
- GPT direct correction;
- code-quality verdict;
- retained/discarded decision;
- future allowed/prohibited work;
- limitations.

Do not include private config, endpoints, credentials or hidden-test source.

## 22. Current docs and Project Sources

Update current docs with:

- 0024AQ wrapper subgate accepted;
- authoritative F604 wrapper hash;
- 0024AR transport and quality results;
- benchmark retention;
- production/catalog/Profile/owner-review state unchanged.

Project Sources file remains upload-ready; actual import is a user/advisor action.

## 23. Commit and push

After final review:

1. fetch origin, require divergence `0/0`;
2. explicitly stage authorized retained files;
3. never stage local worktree/reports/config;
4. run `git diff --cached --check`;
5. review full staged diff;
6. commit:

```text
test(codex): retry DeepSeek quality with existing target
```

7. push `main`;
8. verify `HEAD == origin/main`;
9. require no tracked/staged changes;
10. require only `.codex/config.toml` untracked;
11. remove temporary worktree;
12. require Godot zero.

## 24. Stop conditions

Stop for wrapper F604 mismatch, config/MCP/worker drift, remote divergence, inability to prove a regular target, credential disclosure, unauthorized write, hidden-test access, unreliable harness, protected change or cleanup failure.

MCP blocking does not prevent wrapper control. Lack of any auditable code ends quality evaluation honestly.

## 25. Required final fields

```text
wrapper_subgate =
  TASK_0024AQ_WRAPPER_SAFE_STRICTER_ACCEPTED

authoritative_wrapper_sha256 =
  f604001d001cd206e742e5252a69995c29f96c983e6520ec6fd0374ae4908750

target_precondition =
  PRE_EXISTING_REGULAR_FILE_PASS / FAIL

deepseek_mcp_transport_status =
  PASS_DIRECT_FILE_EDIT
  or PASS_PATCH_RETURN
  or BLOCKED

quality_evaluation_transport =
  MCP
  or ACCEPTED_WRAPPER_CONTROL
  or NOT_RUN

deepseek_code_quality_score =
  <0-100 or NOT_EVALUATED>

deepseek_code_quality_status =
  ACCEPTABLE_FOR_BOUNDED_IMPLEMENTATION
  or CONDITIONAL_MECHANICAL_ONLY
  or NOT_ACCEPTABLE
  or NOT_EVALUATED

first_pass_tests =
  PASS / FAIL / NOT_RUN

repair_turns_used =
  0 / 1

gpt_direct_code_correction =
  YES / NO

unauthorized_paths_modified =
  YES / NO / UNVERIFIED

benchmark_code_retained =
  YES / NO

gpt_5_6_review_passed =
  YES / NO

owner_playthrough_status =
  NOT_YET_REVIEWED

final_task_verdict =
  PASS_FOR_GPT_REVIEW
  or PASS_WITH_OBSERVATIONS_FOR_GPT_REVIEW
  or BLOCKED
  or FAIL
```

## 26. Next gate

After GPT review:

- permit MCP only if its transport passes;
- retain wrapper-only delegation if MCP blocks but wrapper code quality is acceptable;
- restrict DeepSeek to mechanical work if quality is conditional;
- stop further integration work if quality remains unevaluated again.

Owner subjective 1–12 playthrough remains a separate later product gate.
