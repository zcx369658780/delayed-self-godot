# Task 0023ZB — Rebuild the classified AppRoot test-profile session with complete evidence

- Status: `READY`
- Gate: `PROTECTED PLAYER DATA / CLASSIFIED APPROOT REBUILD + COMPLETE EVIDENCE MATRIX`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- GPT adjudication: `docs/reports/0023ZA_GPT_APP_ROOT_TEST_PROFILE_SESSION_CLASSIFIED_DIAGNOSTIC_ADJUDICATION.md`
- Required checkpoint: `4af0340c6fb626473e7eda3a541dc6c1d9fccb7f`
- Fixed task-owned fixture ID: `task_0023zb_app_root_profile_session`

## 1. Objective

Rebuild the bounded AppRoot test-profile session from the clean accepted repository state, apply the already classified public-progress-shape correction, and prove the complete behavior matrix with complete retained process evidence.

The target remains test-only:

```text
validated catalog
→ explicit pre-tree canonical test-profile configuration
→ Task 0023W store configuration/load
→ Task 0023X adapter hydration
→ real Gameplay completion
→ non-mutating candidate
→ verified persistence
→ explicit adapter commit only after persistence success
→ existing non-final return/final acknowledgment behavior
```

No product/test draft from Tasks 0023Y, 0023Z, or 0023ZA is accepted. Reimplement only from frozen repository authorities plus the classified contract below.

## 2. Historical task closure

Do not execute, resume, edit, or reuse fixtures from:

```text
tasks/0023Y_app_root_test_profile_session_gate.md
tasks/0023Y_profile_test_app_root_session_orchestration_gate.md
tasks/0023Z_app_root_test_profile_session_retry_after_parser_gate.md
tasks/0023ZA_app_root_test_profile_session_instrumented_diagnostic_retry.md
```

External Task 0023ZA evidence may be read only from its known evidence directory when useful. Do not copy evidence into the repository and do not treat an old draft patch as accepted source.

## 3. Startup and protected-data gate

Before edits or Godot processes:

1. require root `D:\Delayed_Self`, branch `main`, expected origin, clean tracked/untracked worktree;
2. run the startup Git facts required by `AGENTS.md`;
3. fetch and fast-forward only;
4. require `HEAD == origin/main` and ancestry of `4af0340c6fb626473e7eda3a541dc6c1d9fccb7f`;
5. read the 0023W/0023X acceptances and 0023Y/0023Z/0023ZA GPT adjudications;
6. verify pinned Godot `4.7.stable.steam.5b4e0cb0f` or documented exact equivalent;
7. require no residual Godot process.

Record only production Profile non-content metadata:

```text
exists = true
Length = 473
LastWriteTimeUtc = 2026-07-19T08:15:02.2089459Z
```

Do not open, read, parse, hash, copy, rename, back up, delete, reset, repair, compare, or write production Profile content.

Record only whether `user://delayed_self_test_profiles/` exists. Do not enumerate, clean, or inspect unrelated fixtures.

Build the new path only through:

```gdscript
DelayedSelfLocalProfile.build_test_profile_path("task_0023zb_app_root_profile_session")
```

Before the first behavior attempt, check only whether that exact fixture directory exists. If present, stop without opening, enumerating, or deleting it.

## 4. Mandatory accepted regressions

Before editing, rerun exactly:

```text
0023R = 123 assertions / 4 positive / 39 negative
0023T = compile marker + 34 assertions
0023V = compile marker + 28 assertions
0023W = compile marker + 68 assertions
0023X = compile marker + 31 assertions
```

Every command must exit 0, have empty stderr, and print its required marker exactly once. Require the 0023W fixture absent, unchanged production metadata, unchanged test-root existence, and no Godot process.

## 5. Frozen authorities

Do not modify:

```text
scripts/app/profile_codec.gd
scripts/app/local_profile.gd
scripts/app/profile_progress_adapter.gd
scripts/app/memory_progress.gd
all existing 0023R–0023X tests
formal catalog/level data
Simulation/solver/schema/canonical state
Gameplay/Help/Timeline/Level Select/final acknowledgment
scenes/project settings
```

Normal unconfigured AppRoot memory-only routing and record-once behavior remain frozen.

## 6. Authorized AppRoot test-only surface

Modify only `scripts/app/app_root.gd` for product source behavior.

Add an explicit pre-tree test-only configuration equivalent to:

```text
configure_test_profile(canonical_test_profile_path: String) -> Dictionary
```

It must validate through the frozen path policy, retain exactly one canonical virtual test path, permit retry after initial rejection, reject reconfiguration or late configuration, and expose no path/content/handle/store/adapter reference or production fallback.

Normal unconfigured AppRoot must construct neither store nor adapter and must touch no Profile path.

Configured mode must preserve store-load → adapter-hydration → prepare → persist → commit ordering and existing routing/finale behavior.

No production constructor, production flag, arbitrary path injection, environment/command-line Profile path, autoload, background thread, second router, or general dependency injection is allowed.

## 7. Mandatory classified correction

The Task 0023ZA diagnostic established one contract-local AppRoot defect. This task must encode the correction directly:

- `get_progress_snapshot()` must keep the exact existing public shape in both modes:

```text
completed_level_ids
best_turns
unlocked_level_ids
```

- in memory-only mode, return the existing `DelayedSelfMemoryProgress.snapshot()` defensive result;
- in configured test-profile mode, return a defensive copy of the Task 0023X adapter snapshot's nested `runtime` Dictionary;
- never return the adapter wrapper fields such as `configured`, `catalog_facts`, or `profile_loaded` through the public progress API;
- do not expose settings, Profile content, paths, sibling names, or diagnostic internals.

A separate bounded test-session snapshot may expose only mode/configured/boot/load/persist status identifiers and the public progress snapshot.

## 8. Explicit typing and complete test sources

Explicitly type every local receiving dynamic method results, `Dictionary.get`, scene instantiation, active-screen access, store/adapter calls, await results, ternaries, JSON results, or untyped collection elements. Do not use `:=` for dynamic/Variant-returning expressions.

Create the complete files before any fixture operation:

```text
tests/app/task_0023zb_full_session_parser_smoke.gd
tests/app/task_0023zb_app_root_test_profile_session_compile_smoke.gd
tests/app/task_0023zb_app_root_test_profile_session.gd
```

Parser smoke must preload the complete behavior test, AppRoot, store, and adapter without entering the tree or performing I/O, and print once:

```text
TASK_0023ZB_FULL_SESSION_PARSER_SMOKE_PASS
```

Interface smoke may instantiate AppRoot off-tree and compile the bounded pre-tree configuration/session-snapshot/failure-seam calls with canonical virtual strings only. It must perform zero filesystem behavior and print once:

```text
TASK_0023ZB_APP_ROOT_TEST_PROFILE_SESSION_COMPILE_SMOKE_PASS
```

Allow at most five parser-only and five interface-compile-only corrections inside authorized files. Do not check or create the fixture before both pass.

## 9. Capture-procedure qualification

Before the first fixture behavior run, define one PowerShell capture procedure using `Start-Process -Wait -PassThru` with independent `-RedirectStandardOutput` and `-RedirectStandardError` files.

Qualify that same procedure by running the parser smoke and retaining under the new evidence root:

```text
capture_qualification_command.txt
capture_qualification_stdout.txt
capture_qualification_stderr.txt
capture_qualification_exit_code.txt
capture_qualification_process_before.txt
capture_qualification_process_after.txt
```

Require:

- exit code file exists and contains `0`;
- stdout exists and contains the parser marker exactly once;
- stderr file exists and is empty;
- process before/after files exist;
- command file exists and contains the exact invocation.

If qualification fails, stop before fixture behavior with `DIAGNOSTIC_CAPTURE_INCOMPLETE` and create a docs-only blocker report.

## 10. Behavior markers and assertions

The behavior script must maintain `current_stage: String` and print:

```text
TASK_0023ZB_BEHAVIOR_PROCESS_STARTED
TASK_0023ZB_STAGE_BEGIN=<stage_id>
TASK_0023ZB_STAGE_PASS=<stage_id>
TASK_0023ZB_ASSERT_FAIL stage=<stage_id> label=<bounded_label>
TASK_0023ZB_ABORT stage=<stage_id> reason=<bounded_reason>
TASK_0023ZB_APP_ROOT_TEST_PROFILE_SESSION_TESTS_PASS
```

Required stages:

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

Do not print Profile content, virtual/globalized paths, sibling filenames, or raw filesystem errors.

## 11. Mandatory evidence for every behavior attempt

Use only:

```text
D:\Delayed_Self_Evidence\0023ZB_app_root_test_profile_session_complete_rebuild\
```

For every attempt, including successful attempts, independently retain:

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
attempt_<N>_stage_summary.txt
attempt_<N>_classification.txt
```

`worktree.patch` must be generated with `git diff --binary` before cleanup, correction, or rollback. Empty stderr on a passing run is valid, but the stderr file must still exist. The patch file may be empty only after a committed/final clean state; otherwise it must contain the current authorized draft.

After each run, verify the complete filename inventory before any edit. Missing required files produce `DIAGNOSTIC_CAPTURE_INCOMPLETE` and immediate stop.

## 12. Full behavior matrix

The complete behavior test must cover all of the following, not a reduced diagnostic subset:

1. invalid and production pre-tree configuration reject with zero fixture I/O;
2. reconfiguration and post-tree configuration reject;
3. normal unconfigured AppRoot boots memory-only, exposes exact public snapshot shape, unlocks only Tutorial 0, and touches no Profile path;
4. configured missing target boots clean without eager write;
5. real Tutorial 0 completion persists canonical Profile, commits only after persistence, returns Level Select, records 3 turns, and unlocks only Tutorial 1;
6. a fresh configured AppRoot reloads identical progress/unlocks;
7. equal/worse replay follows `NO_CHANGE` without target metadata rewrite;
8. TEMP_WRITE failure preserves exact target and runtime/Profile state, enters bounded Safe Error, and unlocks nothing new;
9. TEMP_READBACK failure proves the same;
10. REPLACE failure proves frozen target rollback and no runtime commit;
11. POST_REPLACE_VERIFY failure proves frozen target rollback and no runtime commit;
12. malformed source follows frozen recovery preservation, clean hydration, and no source overwrite during load;
13. unknown-version source follows frozen recovery preservation, clean hydration, and no source overwrite during load;
14. every AppRoot instance retains one active screen and the existing router contract;
15. public progress snapshots have exactly the three required keys and are defensive copies in both modes;
16. cleanup removes only the exact tracked 0023ZB target, owned temp/transaction/recovery siblings, and fixed fixture directory;
17. no owned residue, no Godot process, unchanged production metadata, and unchanged test-root existence.

Use accepted Tutorial 0/1 action sequences. Do not alter formal data, Gameplay, scenes, or UI.

## 13. Attempt and correction policy

The first full behavior run is Attempt 1. Before correction, classify using exactly one:

```text
PASS_COMPLETE_MATRIX
TEST_ASSERTION_CLASSIFIED
TEST_RUNTIME_CLASSIFIED
APPROOT_IMPLEMENTATION_CLASSIFIED
FROZEN_DEPENDENCY_OR_CROSS_LAYER
PLAYER_DATA_SAFETY_FAULT
PROCESS_CRASH_NO_DIAGNOSTIC
DIAGNOSTIC_CAPTURE_INCOMPLETE
UNCLASSIFIED
```

Only the first three non-pass local categories permit correction:

- test assertion/runtime: at most three targeted corrections in new 0023ZB tests;
- AppRoot implementation: at most two targeted corrections in `app_root.gd` and/or new tests;
- every correction must cite exact retained stage/label/line/status evidence and produce a new complete attempt inventory.

Do not weaken assertions, skip matrix stages, suppress diagnostics, alter frozen sources, or broaden scope.

All other categories stop and produce a docs-only classified blocker report.

## 14. Two-pass acceptance requirement

One exit-0 run is insufficient.

Acceptance requires two consecutive complete-matrix behavior runs from separately clean fixture states:

```text
PASS_COMPLETE_MATRIX
PASS_COMPLETE_MATRIX
```

Both runs must:

- contain every required stage-begin and stage-pass marker exactly once in order;
- contain the final pass marker exactly once;
- exit 0 with empty stderr;
- have all required independent capture files;
- finish with exact cleanup and unchanged protected metadata.

After the second pass, rerun parser smoke, interface smoke, and 0023R/0023T/0023V/0023W/0023X. Confirm frozen files unchanged, both 0023W/0023ZB fixtures absent, and no Godot process.

Do not run `tests/run_all.gd` or aggregate.

## 15. Passing and blocked outputs

### Passing

Create:

```text
docs/reports/0023ZB_APP_ROOT_TEST_PROFILE_SESSION_EVIDENCE_COMPLETE_REPORT.md
```

Require one implementation commit:

```text
feat: add evidence-complete Delayed Self AppRoot test profile session
```

### Blocked

Precisely rollback all uncommitted AppRoot/test/current implementation drafts, retain external evidence, and commit only:

```text
docs/reports/0023ZB_APP_ROOT_TEST_PROFILE_SESSION_BLOCKER_REPORT.md
```

Commit message:

```text
docs: classify Delayed Self AppRoot session rebuild blocker
```

Do not commit failed product/test drafts or external evidence.

## 16. Authorized repository paths

```text
scripts/app/app_root.gd
tests/app/task_0023zb_full_session_parser_smoke.gd
tests/app/task_0023zb_app_root_test_profile_session_compile_smoke.gd
tests/app/task_0023zb_app_root_test_profile_session.gd
docs/reports/0023ZB_APP_ROOT_TEST_PROFILE_SESSION_EVIDENCE_COMPLETE_REPORT.md
docs/reports/0023ZB_APP_ROOT_TEST_PROFILE_SESSION_BLOCKER_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/production/COMPLETE_FLOW_PRODUCTION_CLOSURE_PLAN_CURRENT.md
```

Do not modify any other path.

## 17. Terminal verdict

Return exactly one:

```text
APP_ROOT_TEST_PROFILE_SESSION_EVIDENCE_COMPLETE_READY_FOR_GPT_REVIEW
BLOCKED_APP_ROOT_TEST_PROFILE_SESSION_EVIDENCE_CLASSIFIED
BLOCKED_APP_ROOT_TEST_PROFILE_SESSION_EVIDENCE_INCOMPLETE
```

Include commit SHA if produced, parser/interface results, capture qualification, every behavior attempt classification, two-pass evidence when applicable, complete matrix coverage, regression counts, protected metadata, fixture cleanup, evidence root, changed paths, and final Git state.

This task does not authorize production Profile activation, default persistence, New Game/Continue/Reset UI, persistent settings, aggregate registration, localization, build/export, RC, release, upload, or festival submission.
