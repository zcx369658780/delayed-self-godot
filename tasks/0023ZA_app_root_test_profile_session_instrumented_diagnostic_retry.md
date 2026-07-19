# Task 0023ZA — Retry the AppRoot test-profile session with retained diagnostics

- Status: `READY`
- Gate: `PROTECTED PLAYER DATA / INSTRUMENTED APPROOT SESSION REPRODUCTION + CLASSIFIED CORRECTION`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- GPT blocker adjudication: `docs/reports/0023Z_GPT_APP_ROOT_TEST_PROFILE_SESSION_UNCLASSIFIED_EXIT_ADJUDICATION.md`
- Required checkpoint: `661361e7409cb4811c9946f75d28cda68b91de89`
- Fixed task-owned fixture ID: `task_0023za_app_root_profile_session`

## 1. Objective

Retry the bounded AppRoot test-profile session goal while making every behavior-process failure observable and classifiable before any correction.

The target test-only flow remains:

```text
validated catalog
→ explicitly pre-tree configured AppRoot test path
→ configured Task 0023W store
→ Profile load/recovery
→ Task 0023X adapter hydration
→ real Gameplay completion
→ non-mutating completion candidate
→ verified filesystem persistence
→ explicit runtime/Profile commit only after persistence success
→ existing non-final return or final acknowledgment behavior
```

This task may finish either with a fully validated implementation or with a durable, evidence-classified blocker report. It must never lose the failing draft or process output before rollback.

## 2. Historical task closure

Do not execute, resume, edit, or reuse fixtures from:

```text
tasks/0023Y_app_root_test_profile_session_gate.md
tasks/0023Y_profile_test_app_root_session_orchestration_gate.md
tasks/0023Z_app_root_test_profile_session_retry_after_parser_gate.md
```

They are historical blocked/superseded scopes.

## 3. Startup and remote gate

Before edits or Godot processes:

1. require root `D:\Delayed_Self`, branch `main`, expected origin, and clean tracked/untracked worktree;
2. run the startup Git facts required by `AGENTS.md`;
3. fetch and fast-forward only;
4. require `HEAD == origin/main` and ancestry of `661361e7409cb4811c9946f75d28cda68b91de89`;
5. read the complete Tasks 0023W/0023X GPT acceptances and the 0023Y/0023Z blocker adjudications;
6. verify pinned Godot `4.7.stable.steam.5b4e0cb0f` or the exact documented equivalent;
7. require no residual Godot process.

Stop on divergence, conflict, unexpected tracked/untracked work, remote mismatch, or missing checkpoint.

## 4. Protected production metadata boundary

Before any Godot process and after every pre/post regression or behavior attempt, record only:

```text
exists
Length
LastWriteTimeUtc
```

for the fixed production Profile. Expected baseline:

```text
exists = true
Length = 473
LastWriteTimeUtc = 2026-07-19T08:15:02.2089459Z
```

Do not open, read, parse, hash, copy, rename, back up, delete, reset, repair, compare, or write production Profile content.

For `user://delayed_self_test_profiles/`, record only whether the root exists. Do not enumerate, clean, or inspect unrelated fixtures.

Build the Task 0023ZA path only through:

```gdscript
DelayedSelfLocalProfile.build_test_profile_path("task_0023za_app_root_profile_session")
```

Before the first behavior attempt, check only whether that exact fixture directory exists. If it already exists, stop without opening, enumerating, or deleting it.

Any production metadata change, production-content access, test-root enumeration, or pre-existing fixed fixture is an immediate safety stop.

## 5. Mandatory accepted prerequisites

Before editing, rerun the accepted standalone gates exactly:

```text
0023R path isolation
0023T codec compile + behavior
0023V store-instance compile + configuration
0023W store compile + filesystem behavior
0023X adapter compile + behavior
```

Require:

```text
0023R = 123 assertions / 4 positive / 39 negative
0023T = compile marker + 34 assertions
0023V = compile marker + 28 assertions
0023W = compile marker + 68 assertions
0023X = compile marker + 31 assertions
```

Every command must exit 0 with empty stderr and its marker exactly once. Require the 0023W fixture absent and no Godot process. Recheck protected metadata afterward.

## 6. Frozen accepted authorities

Preserve exactly:

- `scripts/app/profile_codec.gd`;
- `scripts/app/local_profile.gd`;
- `scripts/app/profile_progress_adapter.gd`;
- `scripts/app/memory_progress.gd`;
- all existing 0023R–0023X tests;
- all formal levels/catalog facts and hashes;
- Simulation, solver, schema, canonical state;
- Gameplay, Help, Timeline, Level Select, final acknowledgment, scenes, and presentation;
- normal unconfigured AppRoot memory-only route and record-once semantics.

Do not modify any frozen source. Stop if an essential change to codec/store/adapter/MemoryProgress/Gameplay/scenes is discovered.

## 7. Authorized AppRoot boundary

Modify only `scripts/app/app_root.gd` for product source behavior.

Add the same bounded pre-tree test-only configuration contract previously authorized:

```text
configure_test_profile(canonical_test_profile_path: String) -> Dictionary
```

It must validate through the frozen Task 0023R path policy, retain exactly one canonical virtual test path, permit valid retry after initial rejection, reject reconfiguration/late configuration, and expose no OS path, file handle, source content, store/adapter reference, or production fallback.

Normal unconfigured AppRoot must remain pure memory-only behavior and must not construct a store/adapter or inspect any Profile path.

Configured test mode must preserve the exact store-load → adapter-hydration → prepare → persist → commit ordering and existing route/finale semantics defined by Task 0023Z.

No production constructor, production mode flag, environment/command-line Profile path, arbitrary dependency injection, second router, autoload, or background thread is allowed.

## 8. Mandatory explicit typing

In changed AppRoot source and all new Task 0023ZA tests:

- explicitly type locals receiving dynamic method results, `Dictionary.get`, scene instantiation, active-screen access, adapter/store calls, await results, JSON results, ternaries, and untyped collection access;
- use `Variant` when no narrower stable type is available;
- do not use `:=` with a dynamically typed right-hand side;
- explicitly type arrays/dictionaries crossing helper boundaries;
- explicitly type loop elements where element type is not static.

Audit the authorized files for unsafe inference before parser smoke.

## 9. Required instrumented test files

Create:

```text
tests/app/task_0023za_full_session_parser_smoke.gd
tests/app/task_0023za_app_root_test_profile_session_compile_smoke.gd
tests/app/task_0023za_app_root_test_profile_session.gd
```

The complete behavior script must exist before either smoke is run.

### 9.1 Parser smoke

Preload the complete behavior script, changed AppRoot source/scene, frozen store, and frozen adapter without instantiating the behavior test or entering the tree.

It must perform zero fixture/Profile I/O and print exactly once:

```text
TASK_0023ZA_FULL_SESSION_PARSER_SMOKE_PASS
```

Allow at most five parser-only correction attempts inside authorized files.

### 9.2 Interface compile smoke

Instantiate AppRoot off-tree and compile the exact pre-tree configuration, bounded session-snapshot, and failure-seam calls using canonical virtual strings only.

It must perform zero fixture/Profile I/O and print exactly once:

```text
TASK_0023ZA_APP_ROOT_TEST_PROFILE_SESSION_COMPILE_SMOKE_PASS
```

Allow at most five compile-only correction attempts. Do not inspect or create the fixture before both smoke gates pass.

## 10. Behavior-script diagnostic markers

The complete behavior test must maintain one explicit `current_stage: String` and emit deterministic markers.

Before every major stage:

```text
TASK_0023ZA_STAGE_BEGIN=<stage_id>
```

After every successful stage:

```text
TASK_0023ZA_STAGE_PASS=<stage_id>
```

Required stage IDs include at least:

```text
startup
invalid_configuration
normal_memory_boot
missing_profile_boot
tutorial_0_persist
fresh_reload
no_change
temp_write_failure
temp_readback_failure
replace_failure
post_replace_verify_failure
malformed_recovery
unknown_version_recovery
public_snapshot
cleanup
final
```

Every expectation failure must print to stderr:

```text
TASK_0023ZA_ASSERT_FAIL stage=<stage_id> label=<bounded_label>
```

Every controlled abort must print to stderr:

```text
TASK_0023ZA_ABORT stage=<stage_id> reason=<bounded_reason>
```

At process start print exactly once:

```text
TASK_0023ZA_BEHAVIOR_PROCESS_STARTED
```

On successful completion print exactly once:

```text
TASK_0023ZA_APP_ROOT_TEST_PROFILE_SESSION_TESTS_PASS
```

Do not print Profile content, virtual/globalized paths, recovery/temp names, or raw filesystem errors.

## 11. Mandatory external process capture

Run every behavior attempt through a PowerShell invocation that independently retains:

```text
attempt_<N>_command.txt
attempt_<N>_stdout.txt
attempt_<N>_stderr.txt
attempt_<N>_exit_code.txt
attempt_<N>_process_before.txt
attempt_<N>_process_after.txt
attempt_<N>_production_metadata_before.txt
attempt_<N>_production_metadata_after.txt
attempt_<N>_fixture_exact_state_before.txt
attempt_<N>_fixture_exact_state_after.txt
attempt_<N>_worktree.patch
attempt_<N>_worktree_patch_sha256.txt
```

Use direct stdout/stderr redirection that preserves files even when Godot exits nonzero. Do not rely only on terminal scrollback, pipelines, summarized shell output, or an exception-prone wrapper.

Immediately after every failed behavior attempt, before any edit or rollback:

1. record exit code;
2. retain stdout and stderr files;
3. create `git diff --binary` output for the uncommitted authorized draft;
4. hash the patch;
5. record the last stage-begin and stage-pass markers;
6. record exact owned-fixture state without enumerating the test root;
7. record production metadata and residual Godot processes.

If any required evidence file is missing or empty where content is required, classify the attempt as `DIAGNOSTIC_CAPTURE_INCOMPLETE` and stop without correction.

## 12. Classification before correction

The first fixture behavior run is `DIAGNOSTIC_ATTEMPT_1`. A nonzero exit is allowed for diagnosis and is not automatically the whole-task terminal result.

Before any correction, write one classification record using exactly one of:

```text
TEST_ASSERTION_CLASSIFIED
TEST_RUNTIME_CLASSIFIED
APPROOT_IMPLEMENTATION_CLASSIFIED
FROZEN_DEPENDENCY_OR_CROSS_LAYER
PROCESS_CRASH_NO_DIAGNOSTIC
PLAYER_DATA_SAFETY_FAULT
DIAGNOSTIC_CAPTURE_INCOMPLETE
UNCLASSIFIED
```

Classification requirements:

- `TEST_ASSERTION_CLASSIFIED`: exact stage and bounded assertion label are present; no product-source stack is implicated.
- `TEST_RUNTIME_CLASSIFIED`: exact new test file and line/stack are present.
- `APPROOT_IMPLEMENTATION_CLASSIFIED`: exact AppRoot stage plus AppRoot file/line or deterministic status mismatch is present and the issue is confined to the authorized contract.
- all other categories stop without repair.

No inference from exit code alone is allowed.

## 13. Bounded evidence-based corrections

Only after classification:

- `TEST_ASSERTION_CLASSIFIED` or `TEST_RUNTIME_CLASSIFIED`: allow at most three targeted corrections in new Task 0023ZA test files only;
- `APPROOT_IMPLEMENTATION_CLASSIFIED`: allow at most two targeted corrections in `app_root.gd` and/or new tests, each tied to the retained exact evidence;
- every correction requires a new numbered attempt with complete retained evidence.

Do not broaden the implementation, alter frozen sources, suppress failures, weaken assertions, skip stages, change formal data, or delete evidence to obtain a pass.

If correction limits are exhausted, stop with a classified blocker.

## 14. Required behavior coverage

After both zero-I/O preflights, the fixed-fixture suite must cover:

1. invalid/production pre-tree configuration rejects with zero fixture I/O;
2. post-tree configuration and reconfiguration reject;
3. normal unconfigured AppRoot remains memory-only with only Tutorial 0 unlocked and no Profile I/O;
4. configured missing target boots clean without eager write;
5. real Tutorial 0 completion persists canonical Profile, commits after persistence, returns Level Select, records 3 turns, unlocks only Tutorial 1;
6. fresh configured AppRoot reloads identical progress/unlocks;
7. equal/worse replay follows `NO_CHANGE` without metadata rewrite;
8. TEMP_WRITE and TEMP_READBACK failures preserve target/runtime and enter Safe Error;
9. REPLACE and POST_REPLACE_VERIFY failures preserve exact target/runtime and enter Safe Error;
10. malformed/unknown-version target follows frozen recovery preservation and clean hydration without source overwrite during load;
11. every AppRoot retains one active screen and the existing router;
12. public progress snapshots retain exact shape and defensive copies;
13. cleanup removes only the exact tracked Task 0023ZA target, owned recovery/temp/transaction siblings, and fixed fixture directory;
14. no owned residue, no Godot process, unchanged production metadata, unchanged test-root existence.

Use accepted Tutorial 0/1 actions. Do not alter formal data, Gameplay, scenes, or UI.

Exit 0 and empty stderr are mandatory for a passing final run. No aggregate marker is added.

## 15. Passing path

If a clean fixture run passes:

1. rerun parser smoke, interface smoke, and behavior from clean fixture state;
2. rerun 0023R/0023T/0023V/0023W/0023X;
3. repeat static and explicit-typing audits;
4. confirm frozen files unchanged;
5. confirm production metadata/test-root existence unchanged;
6. confirm 0023W and 0023ZA fixtures absent;
7. require no Godot process;
8. create the implementation report and one implementation commit.

Required commit:

```text
feat: add instrumented Delayed Self AppRoot test profile session
```

## 16. Blocked path and durable report

If the task remains blocked after classification or because classification is impossible:

1. preserve every attempt evidence file and patch in the evidence root;
2. create `docs/reports/0023ZA_APP_ROOT_TEST_PROFILE_SESSION_DIAGNOSTIC_REPORT.md` with the exact classification, last successful stage, first failing stage, evidence file inventory, patch SHA-256, cleanup state, protected metadata, and non-claims;
3. precisely rollback all uncommitted AppRoot/test/current-document implementation changes;
4. retain only the diagnostic report as a docs-only repository change;
5. commit the report with:

```text
docs: classify Delayed Self AppRoot session diagnostic
```

Do not commit failed product/test drafts or evidence files.

## 17. Authorized repository paths

```text
scripts/app/app_root.gd
tests/app/task_0023za_full_session_parser_smoke.gd
tests/app/task_0023za_app_root_test_profile_session_compile_smoke.gd
tests/app/task_0023za_app_root_test_profile_session.gd
docs/reports/0023ZA_APP_ROOT_TEST_PROFILE_SESSION_DIAGNOSTIC_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/production/COMPLETE_FLOW_PRODUCTION_CLOSURE_PLAN_CURRENT.md
```

Do not modify any other source, existing test, task file, scene, project setting, formal data, localization, asset, export, release, or submission surface.

## 18. Evidence and Git

Use only:

```text
D:\Delayed_Self_Evidence\0023ZA_app_root_test_profile_session_instrumented_retry\
```

Stage authorized paths explicitly, run `git diff --cached --check`, fetch and stop on drift, then push normally.

Finish with clean worktree, `HEAD == origin/main`, divergence `0/0`, no Godot process, unchanged production metadata, and absent fixed fixtures.

## 19. Terminal verdict

Return exactly one:

```text
APP_ROOT_TEST_PROFILE_SESSION_INSTRUMENTED_READY_FOR_GPT_REVIEW
BLOCKED_APP_ROOT_TEST_PROFILE_SESSION_DIAGNOSTIC_CLASSIFIED
BLOCKED_APP_ROOT_TEST_PROFILE_SESSION_DIAGNOSTIC_UNCLASSIFIED
```

Include the implementation/report commit SHA if produced, parser/compile results, behavior attempt classifications, last/pass stage markers, assertion counts if available, 0023R–0023X regressions when applicable, production metadata, exact cleanup, evidence root, changed paths, and final Git state.

This task does not authorize production Profile activation, default product persistence, New Game/Continue/Reset UI, persistent settings, aggregate registration, localization, build/export, RC, release, upload, or festival submission.
