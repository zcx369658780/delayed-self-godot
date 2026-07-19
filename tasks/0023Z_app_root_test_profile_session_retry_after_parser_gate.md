# Task 0023Z — Retry the AppRoot test-profile session after the full-script parser gate

- Status: `READY`
- Gate: `PROTECTED PLAYER DATA / APPROOT TEST-PROFILE SESSION + FULL-SCRIPT PARSER PREFLIGHT`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- GPT blocker adjudication: `docs/reports/0023Y_GPT_APP_ROOT_TEST_PROFILE_SESSION_PARSER_BLOCKER_ADJUDICATION.md`
- Required checkpoint: `cbab911ea368d4754265aead888d084caa32b356`
- Fixed task-owned fixture ID: `task_0023z_app_root_profile_session`

## 1. Objective

Retry the bounded AppRoot test-profile session orchestration goal while closing the Task 0023Y compile-coverage gap.

Prove this exact test-only flow:

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

The complete behavior-test script must parse successfully before any fixture directory is created or any Profile I/O-capable behavior is run.

## 2. Historical task closure

Do not execute or resume either Task 0023Y file:

```text
tasks/0023Y_app_root_test_profile_session_gate.md
tasks/0023Y_profile_test_app_root_session_orchestration_gate.md
```

They are historical blocked/superseded scopes. Do not delete or edit them in this task.

## 3. Startup and remote gate

Before edits or Godot processes:

1. require root `D:\Delayed_Self`, branch `main`, expected origin, and clean tracked/untracked worktree;
2. run the startup Git facts required by `AGENTS.md`;
3. fetch and fast-forward only;
4. require `HEAD == origin/main` and ancestry of `cbab911ea368d4754265aead888d084caa32b356`;
5. read the complete Tasks 0023W/0023X GPT acceptances and the 0023Y blocker adjudication;
6. verify pinned Godot `4.7.stable.steam.5b4e0cb0f` or the exact documented equivalent;
7. require no residual Godot process.

Stop on divergence, conflict, unexpected tracked/untracked work, remote mismatch, or missing checkpoint.

## 4. Protected production metadata boundary

Before any Godot process and after every pre/post regression group, record only:

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

Build the Task 0023Z path only through:

```gdscript
DelayedSelfLocalProfile.build_test_profile_path("task_0023z_app_root_profile_session")
```

Before the first behavior run, check only whether that exact fixture directory exists. If it already exists, stop without opening, enumerating, or deleting it.

Any production metadata change, production-content access, test-root enumeration, or pre-existing fixed fixture is an immediate safety stop with no implementation commit.

## 5. Mandatory accepted prerequisites

Before editing, rerun exactly the accepted standalone gates:

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

Every command must exit 0 with empty stderr and its required marker exactly once. Require the 0023W fixture absent and no Godot process. Recheck protected metadata afterward.

## 6. Frozen accepted authorities

Preserve exactly:

- `scripts/app/profile_codec.gd`;
- `scripts/app/local_profile.gd`;
- `scripts/app/profile_progress_adapter.gd`;
- `scripts/app/memory_progress.gd`;
- all existing 0023R–0023X tests;
- all formal levels/catalog facts and hashes;
- Simulation, solver, schema, canonical state;
- Gameplay, Help, Timeline, Level Select, final acknowledgment and presentation;
- normal unconfigured AppRoot memory-only route and record-once semantics.

Do not modify any frozen source. Stop if an essential change to codec/store/adapter/MemoryProgress/Gameplay/scenes is discovered.

## 7. Authorized AppRoot test-only boundary

Modify only `scripts/app/app_root.gd` for product source behavior.

Add an explicit pre-tree test-only configuration surface equivalent to:

```text
configure_test_profile(canonical_test_profile_path: String) -> Dictionary
```

It must:

1. be callable only before tree entry, `_ready`, or boot;
2. validate through the frozen Task 0023R path policy before retaining anything;
3. reject production/invalid paths with zero I/O and no fallback;
4. retain exactly one canonical virtual test path;
5. permit a valid retry after a failed first attempt;
6. reject reconfiguration after first success or boot start;
7. expose no OS path, file handle, source content, store/adapter reference, or production fallback.

Do not add `create_production`, a production-mode flag, environment/command-line Profile paths, arbitrary OS-path injection, autoloads, background threads, dependency injection, or a second router.

## 8. Normal unconfigured behavior

When no test path is configured before tree entry:

- AppRoot must use the existing `DelayedSelfMemoryProgress` path;
- no store or adapter is constructed;
- no Profile path is checked or touched;
- existing Main Menu/direct-level behavior is unchanged;
- existing completion recording, non-final return, and final acknowledgment remain unchanged.

The Task 0023Z test must prove this without aggregate.

## 9. Configured test-session boot

After validated catalog load in configured test mode:

1. construct/configure the frozen Task 0023X adapter with the catalog;
2. obtain defensive codec facts;
3. construct the frozen Task 0023W store and `configure_test` it with the facts and retained path;
4. call store `load_profile` once;
5. accept only `MISSING_CLEAN`, `LOADED`, `SANITIZED`, or `RECOVERED_CLEAN` as usable;
6. hydrate the adapter from the returned normalized Profile;
7. use the adapter as AppRoot's progress/unlock authority;
8. continue through the existing router.

On catalog/configuration/load/hydration failure, expose no partial progress authority and show one existing bounded Safe Error with a stable code and no content/path disclosure.

`get_progress_snapshot()` must retain exactly the existing public shape:

```text
completed_level_ids
best_turns
unlocked_level_ids
```

A separate bounded test-session snapshot may expose only mode/configured/boot/load/persist status identifiers and public progress, never paths, Profile content, sibling names, or raw filesystem errors.

## 10. Completion ordering

Preserve the existing Gameplay-instance and record-once guards.

In configured test mode:

1. validate active Gameplay and routed level ID;
2. call adapter `prepare_completion(level_id, turns)`;
3. on `NO_CHANGE`, treat the completion as recorded without write or second commit;
4. on `CANDIDATE_READY`, call store `persist_profile(candidate_profile)`;
5. accept only `PERSISTED` or store `NO_CHANGE` as persistence success;
6. call adapter `commit_profile(candidate_profile)` only after persistence success;
7. consider completion recorded only after commit succeeds;
8. preserve existing non-final return/final acknowledgment behavior.

Before persistence success, retained Profile, completed IDs, best turns, and unlocks must remain unchanged.

On `RECOVERY_FAILED`, `WRITE_FAILED`, candidate rejection, or any other persistence failure:

- do not call adapter commit;
- preserve the exact pre-completion runtime/Profile snapshot;
- rely on the frozen store rollback for the target;
- enter one bounded existing Safe Error with a stable code;
- do not falsely return to Level Select or show recorded final acknowledgment;
- expose no content/path/temp/recovery/raw filesystem data.

Adapter commit failure after persistence success is a consistency fault: enter Safe Error and do not perform a second write or speculative repair.

A test-only failure-seam forwarder may accept only the frozen Task 0023W stage enum and no path/operation argument.

## 11. Mandatory explicit-typing policy

Task 0023Y failed because the complete behavior script was not parsed in the compile phase. Therefore, in changed AppRoot source and all new Task 0023Z tests:

- explicitly type every local receiving a dynamic method result, `Dictionary.get`, scene `instantiate`, `get_active_screen`, adapter/store call, await result, JSON result, ternary result, or untyped collection access;
- use `Variant` when a narrower stable type is not available;
- do not use `:=` when the right-hand side is dynamically typed or may resolve to Variant;
- explicitly type arrays/dictionaries used across helper boundaries;
- explicitly type loop elements when collection element type is not static;
- source-audit the new/changed files for unsafe inference patterns before parser smoke.

This policy is limited to authorized files and does not require broad style changes.

## 12. Full behavior-script parser gate — before all fixture operations

Create the complete behavior test source first:

```text
tests/app/task_0023z_app_root_test_profile_session.gd
```

Then add a zero-I/O parser smoke:

```text
tests/app/task_0023z_full_session_parser_smoke.gd
```

The parser smoke must preload, without instantiating the behavior test:

```text
scripts/app/app_root.gd or the AppRoot scene/script
tests/app/task_0023z_app_root_test_profile_session.gd
frozen store and adapter scripts
```

It must perform no fixture check, directory creation, file read/write, scene tree entry, or Profile operation and print exactly once:

```text
TASK_0023Z_FULL_SESSION_PARSER_SMOKE_PASS
```

Run this immediately after the first full behavior-test draft. Allow at most **five parser-only correction attempts** inside authorized files. Parser/type errors during these attempts are correction-loop input, not an immediate whole-task stop.

If the fifth attempt still fails, precisely roll back Task 0023Z source/test additions and return the blocked verdict.

After parser smoke passes, add/run a separate zero-I/O interface compile smoke:

```text
tests/app/task_0023z_app_root_test_profile_session_compile_smoke.gd
```

It may instantiate AppRoot off-tree and compile pre-tree configuration/snapshot/failure-seam calls using canonical virtual strings only. It must perform no filesystem behavior and print once:

```text
TASK_0023Z_APP_ROOT_TEST_PROFILE_SESSION_COMPILE_SMOKE_PASS
```

Allow at most five compile-only corrections before behavior. Do not create the fixture until both parser and interface smoke pass.

## 13. Standalone fixed-fixture behavior test

Only after both zero-I/O preflights and static audit pass, execute the complete behavior script in exactly the Task 0023Z fixture.

Cover at minimum:

1. invalid/production pre-tree configuration rejects with zero fixture I/O;
2. post-tree configuration and reconfiguration reject;
3. normal unconfigured AppRoot remains memory-only with only Tutorial 0 unlocked and no Profile I/O;
4. configured missing target boots clean without eager write;
5. real Tutorial 0 completion persists canonical Profile, commits after persistence, returns Level Select, records 3 turns, unlocks only Tutorial 1;
6. fresh configured AppRoot reloads identical progress/unlocks;
7. equal/worse replay follows `NO_CHANGE` without metadata rewrite;
8. TEMP_WRITE and TEMP_READBACK failures preserve target/runtime and enter Safe Error;
9. REPLACE and POST_REPLACE_VERIFY failures preserve exact target/runtime through frozen rollback and enter Safe Error;
10. malformed/unknown-version target follows frozen recovery preservation and clean hydration without source overwrite during load;
11. every AppRoot retains one active screen and the existing router;
12. public progress snapshots retain exact shape and defensive copies;
13. cleanup removes only the exact tracked Task 0023Z target, owned recovery/temp/transaction siblings, and fixed fixture directory;
14. no owned residue, no Godot process, unchanged production metadata, unchanged test-root existence.

Use accepted Tutorial 0/1 action sequences. Do not alter formal data, Gameplay, scenes, or UI.

Required marker exactly once:

```text
TASK_0023Z_APP_ROOT_TEST_PROFILE_SESSION_TESTS_PASS
```

Exit 0 and empty stderr are mandatory. No aggregate marker is added.

After both compile preflights have passed, a parser/runtime error in the behavior phase is an immediate stop unless it is clearly caused by a test assertion failure rather than parsing/type compilation. Do not blind-fix beyond the authorized parser/compile loops.

## 14. Post-test regressions

After behavior cleanup:

1. rerun Task 0023Z parser smoke, interface smoke, and behavior from clean fixture state;
2. rerun 0023R/0023T/0023V/0023W/0023X;
3. rerun the unchanged default-memory AppRoot focused checks authorized in the Task 0023Z test;
4. repeat static audit;
5. confirm frozen files unchanged;
6. confirm production metadata/test-root existence unchanged;
7. confirm 0023W and 0023Z fixtures absent;
8. require no Godot process.

Do not run `tests/run_all.gd` or aggregate.

## 15. Authorized repository paths

```text
scripts/app/app_root.gd
tests/app/task_0023z_full_session_parser_smoke.gd
tests/app/task_0023z_app_root_test_profile_session_compile_smoke.gd
tests/app/task_0023z_app_root_test_profile_session.gd
docs/reports/0023Z_APP_ROOT_TEST_PROFILE_SESSION_RETRY_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/production/COMPLETE_FLOW_PRODUCTION_CLOSURE_PLAN_CURRENT.md
```

Do not modify any other source, existing test, task file, scene, project setting, formal data, localization, asset, export, release, or submission surface.

## 16. Evidence and Git

Use only:

```text
D:\Delayed_Self_Evidence\0023Z_app_root_test_profile_session_retry\
```

Record startup facts, protected metadata, prerequisite results, explicit-typing audit, every parser/compile attempt, behavior assertions, persistence/commit ordering, rollback traces, cleanup inventory, changed/staged paths, and final Git state.

Create:

```text
docs/reports/0023Z_APP_ROOT_TEST_PROFILE_SESSION_RETRY_REPORT.md
```

Require one implementation commit:

```text
feat: add Delayed Self AppRoot test profile session after parser gate
```

Stage authorized paths explicitly, run `git diff --cached --check`, fetch and stop on drift, then push normally.

Finish with clean worktree, `HEAD == origin/main`, divergence `0/0`, no Godot process, unchanged production metadata, and absent fixed fixtures.

## 17. Terminal verdict

Return exactly one:

```text
APP_ROOT_TEST_PROFILE_SESSION_RETRY_READY_FOR_GPT_REVIEW
BLOCKED_APP_ROOT_TEST_PROFILE_SESSION_RETRY
```

This task does not authorize production Profile activation, default product persistence, New Game/Continue/Reset UI, persistent settings, aggregate registration, localization, build/export, RC, release, upload, or festival submission.
