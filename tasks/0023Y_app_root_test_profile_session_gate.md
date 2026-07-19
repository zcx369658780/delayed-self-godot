# Task 0023Y — Implement the AppRoot test-profile session orchestration gate

- Status: `READY`
- Gate: `PROTECTED PLAYER DATA / TEST-PROFILE APPROOT SESSION ORCHESTRATION`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- GPT prerequisite acceptance: `docs/reports/0023X_GPT_PROFILE_MEMORY_PROGRESS_ADAPTER_GATE_ACCEPTANCE.md`
- Required checkpoint: `6fea8cee5cea36531dc8d5d588e2ed55a446bdf6`
- Fixed task-owned fixture ID: `task_0023y_app_root_profile_session`

## 1. Objective

Connect the accepted Task 0023W configured test-only filesystem store and Task 0023X pure Profile↔MemoryProgress adapter to `DelayedSelfAppRoot` **only through an explicit pre-tree test-profile configuration**.

Prove one bounded AppRoot-owned session flow:

```text
validated catalog
→ configured test store
→ store load/recovery
→ adapter hydration
→ real Gameplay completion
→ non-mutating completion candidate
→ verified filesystem persist
→ explicit runtime/profile commit only after persist success
→ existing non-final return or final acknowledgment behavior
```

The normal AppRoot boot, when no test Profile is explicitly configured before entering the tree, must remain the current memory-only behavior and must perform no Profile filesystem operation.

This task does **not** create or use a production store, does not access the production Profile content, does not make persistence the default product behavior, does not add New Game/Continue/Reset UI, does not implement persistent settings, and does not register aggregate tests.

## 2. Startup and remote gate

Before edits or Godot processes:

1. require absolute root `D:\Delayed_Self`, branch `main`, expected origin, and clean tracked/untracked worktree;
2. run the startup Git facts required by `AGENTS.md`;
3. fetch and fast-forward only;
4. require `HEAD == origin/main` and ancestry of `6fea8cee5cea36531dc8d5d588e2ed55a446bdf6`;
5. read the complete Tasks 0023W and 0023X GPT acceptance reports and implementation reports;
6. verify pinned Godot `4.7.stable.steam.5b4e0cb0f` or the exact documented equivalent;
7. require no residual Godot process.

Stop on divergence, conflict, unexpected tracked/untracked work, remote mismatch, or missing checkpoint.

## 3. Protected production metadata boundary

Before any Godot process and after every pre/post regression group, record only:

```text
exists
Length
LastWriteTimeUtc
```

for the fixed production Profile. Expected accepted baseline:

```text
exists = true
Length = 473
LastWriteTimeUtc = 2026-07-19T08:15:02.2089459Z
```

Do not open, read, parse, hash, copy, rename, back up, delete, reset, repair, compare, or write the production Profile content.

For `user://delayed_self_test_profiles/`, record only whether the root exists. Do not enumerate, clean, or inspect unrelated fixtures.

Build the fixed Task 0023Y path only through `DelayedSelfLocalProfile.build_test_profile_path("task_0023y_app_root_profile_session")`. Before the first behavior run, check only whether that exact fixture directory exists. If it already exists, stop without opening, enumerating, or deleting it.

Any production metadata change, content-oriented production access, test-root enumeration, or pre-existing fixed fixture is an immediate safety stop with no implementation commit.

## 4. Mandatory accepted prerequisites

Before editing, rerun exactly:

```text
godot.windows.opt.tools.64.exe --headless --path D:\Delayed_Self --script res://tests/app/task_0023r_profile_test_isolation_gate.gd
godot.windows.opt.tools.64.exe --headless --path D:\Delayed_Self --script res://tests/app/task_0023t_profile_codec_compile_smoke.gd
godot.windows.opt.tools.64.exe --headless --path D:\Delayed_Self --script res://tests/app/task_0023t_pure_profile_codec.gd
godot.windows.opt.tools.64.exe --headless --path D:\Delayed_Self --script res://tests/app/task_0023v_profile_store_instance_compile_smoke.gd
godot.windows.opt.tools.64.exe --headless --path D:\Delayed_Self --script res://tests/app/task_0023v_profile_store_instance_configuration.gd
godot.windows.opt.tools.64.exe --headless --path D:\Delayed_Self --script res://tests/app/task_0023w_profile_store_compile_smoke.gd
godot.windows.opt.tools.64.exe --headless --path D:\Delayed_Self --script res://tests/app/task_0023w_profile_filesystem_store.gd
godot.windows.opt.tools.64.exe --headless --path D:\Delayed_Self --script res://tests/app/task_0023x_profile_memory_progress_adapter_compile_smoke.gd
godot.windows.opt.tools.64.exe --headless --path D:\Delayed_Self --script res://tests/app/task_0023x_profile_memory_progress_adapter.gd
```

Require:

- Task 0023R: 123 assertions / 4 positive / 39 negative;
- Task 0023T: compile marker and 34 assertions;
- Task 0023V: compile marker and 28 assertions;
- Task 0023W: compile marker and 68 assertions;
- Task 0023X: compile marker and 31 assertions;
- every command exit 0, required marker exactly once, and empty stderr;
- Tasks 0023W and 0023Y fixed fixtures absent after their applicable cleanup checks;
- no residual Godot process.

Recheck protected metadata and test-root existence afterward. Stop before edits on any regression.

## 5. Frozen accepted authorities

Preserve exactly:

- `scripts/app/profile_codec.gd` and all accepted Task 0023T behavior;
- `scripts/app/local_profile.gd` and all accepted Tasks 0023R/0023V/0023W behavior;
- `scripts/app/profile_progress_adapter.gd` and the accepted Task 0023X adapter behavior;
- `scripts/app/memory_progress.gd` and its accepted Task 0023X atomic hydration behavior;
- all existing Task 0023R–0023X tests;
- the normal memory-only AppRoot route and record-once behavior when test mode is not configured;
- the production Profile and unrelated test-root contents;
- all eight formal levels, catalog order/facts, Simulation, solver, schema, canonical state, Gameplay, final acknowledgment, Help, Timeline, Level Select, presentation, and owner evidence.

Do not modify the codec, store, adapter, MemoryProgress, existing tests, formal data, Simulation, Gameplay, scenes, or UI in this task. Stop if an essential change to a frozen source is discovered.

## 6. AppRoot test-profile configuration boundary

Modify only `scripts/app/app_root.gd` for product source behavior.

Add an explicitly test-only pre-tree configuration surface equivalent to:

```text
configure_test_profile(canonical_test_profile_path: String) -> Dictionary
```

It must:

1. be callable only on a fresh AppRoot instance before `_ready`/boot and before it enters the tree;
2. call the frozen `validate_test_profile_path` before retaining anything;
3. reject the production path and every invalid path with zero I/O and no fallback;
4. retain exactly the accepted canonical virtual path as a defensive immutable value;
5. permit a valid retry after a failed first attempt;
6. reject reconfiguration after the first success or after boot begins;
7. expose no globalized path, filesystem handle, source content, or production fallback.

Do not add `create_production`, a production-mode flag, environment/command-line path selection, arbitrary OS-path injection, autoloads, background threads, or a second router.

## 7. Normal memory-only boot must remain unchanged

When no test Profile was configured before tree entry:

- `_ready` and `boot_with_user_args` retain the existing validated-catalog → `DelayedSelfMemoryProgress` → Main Menu/direct-development-route behavior;
- no store or adapter is constructed;
- no `user://` Profile path is checked or touched;
- existing direct-level development behavior remains unchanged;
- existing AppRoot completion recording and final acknowledgment semantics remain unchanged.

The dedicated Task 0023Y test must prove this unchanged default path without running aggregate.

## 8. Test-profile boot sequence

When the exact canonical Task 0023Y test path was configured before tree entry, AppRoot becomes the sole owner of one store and one adapter for that instance.

After catalog validation, perform exactly this bounded sequence:

1. externally construct and configure the frozen Task 0023X adapter with the validated catalog;
2. obtain its defensive codec facts;
3. externally construct the frozen Task 0023W store and call `configure_test` with those facts and the retained canonical path;
4. call the store `load_profile` once;
5. accept only `MISSING_CLEAN`, `LOADED`, `SANITIZED`, or `RECOVERED_CLEAN` as usable load states;
6. hydrate the adapter from the returned normalized Profile;
7. use the adapter as AppRoot's runtime unlock/progress authority;
8. continue to the existing Main Menu or validated direct-development route.

If catalog, adapter, store configuration, store load, or adapter hydration fails:

- do not expose a partially usable progress authority;
- do not write a fallback Profile;
- show one bounded existing Safe Error screen with a stable AppRoot error code and no Profile contents or paths;
- preserve the original source and accepted recovery behavior;
- retain one active screen and the existing router.

`RECOVERED_CLEAN` may continue with clean runtime progress after the frozen store has already preserved the exact recovery sibling. The error/result surface may record only bounded status identifiers and recovery sibling filename, never source content or an OS path.

## 9. Progress authority compatibility

Level Select must continue to receive an object implementing `is_unlocked`.

`get_progress_snapshot()` must return the existing public runtime shape in both modes:

```text
completed_level_ids
best_turns
unlocked_level_ids
```

It must not expose adapter internals, filesystem paths, source content, settings, temp names, or recovery data through the existing progress snapshot API.

A separate bounded test-session snapshot may be added only if necessary. It may contain mode/configured/boot/load/persist status identifiers and the public runtime snapshot, but no virtual/globalized path or Profile content.

## 10. Real completion persistence ordering

Preserve the existing gameplay-instance and record-once guards.

In test-profile mode, `_on_gameplay_completed` must:

1. validate the active Gameplay instance and exact routed level ID as today;
2. call adapter `prepare_completion(level_id, turns)` without mutation;
3. if the result is `NO_CHANGE`, treat completion as successfully recorded without writing or committing again;
4. if the result is `CANDIDATE_READY`, call store `persist_profile(candidate_profile)`;
5. accept only `PERSISTED` or `NO_CHANGE` as persistence success;
6. call adapter `commit_profile(candidate_profile)` only after persistence success;
7. consider the completion recorded only after the explicit commit succeeds;
8. preserve non-final automatic Level Select return and final retained acknowledgment exactly.

On `CANDIDATE_READY`, runtime Profile, completed IDs, best turns, and unlocks must remain unchanged until store persistence succeeds.

On `RECOVERY_FAILED`, `WRITE_FAILED`, candidate rejection, or any other persistence failure:

- do not call adapter commit;
- retain the exact pre-completion runtime/Profile snapshot;
- rely on the frozen store rollback guarantee for the target;
- transition to one bounded existing Safe Error state with a stable code such as `APP_PROFILE_PERSIST_FAILED`;
- expose no source content, virtual/globalized path, temp/recovery name, or raw filesystem error;
- do not falsely return to Level Select or show the final acknowledgment as recorded.

An adapter commit failure after reported persistence success is a consistency fault: enter bounded Safe Error, report a stable code, and make no success/navigation claim. Do not add speculative repair or a second write.

## 11. Bounded test-only failure seam forwarding

For the standalone Task 0023Y behavior suite only, AppRoot may expose one bounded method equivalent to:

```text
set_test_profile_failure_seam(stage: String) -> Dictionary
```

It must:

- reject outside configured test-profile mode;
- forward only the frozen Task 0023W stages;
- accept no path or operation argument;
- expose no store object or filesystem handle;
- never exist as a production mode selector.

Do not add arbitrary dependency injection, mock filesystem APIs, or caller-provided store instances.

## 12. Compile-first gate

Add:

```text
tests/app/task_0023y_app_root_test_profile_session_compile_smoke.gd
```

It must preload the AppRoot scene/script and frozen prerequisites, instantiate AppRoot without entering the tree, compile the exact pre-tree configuration and bounded snapshot/failure-seam calls, perform zero filesystem operation, and print exactly once:

```text
TASK_0023Y_APP_ROOT_TEST_PROFILE_SESSION_COMPILE_SMOKE_PASS
```

Run it immediately after the first AppRoot draft. Allow at most five compile-only correction attempts inside authorized files. If it still fails, restore the accepted pre-task AppRoot source, remove Task 0023Y additions, and return the blocked verdict.

## 13. Standalone fixed-fixture behavior test

Only after compile smoke and static audit pass, add:

```text
tests/app/task_0023y_app_root_test_profile_session.gd
```

Use only the fixed Task 0023Y fixture and actual existing AppRoot/Gameplay scenes. Do not run `tests/run_all.gd`.

Cover at minimum:

1. invalid and production pre-tree configuration reject with zero fixture I/O;
2. configuration after tree entry/boot and reconfiguration after first success reject;
3. an unconfigured normal AppRoot still boots memory-only to Main Menu with only Tutorial 0 unlocked and no test/production Profile I/O;
4. configured missing target boots to Main Menu with clean runtime progress and no eager target write;
5. actual Tutorial 0 completion through existing Gameplay actions persists canonical Profile bytes, commits runtime only after success, returns to Level Select, records 3 turns, and unlocks only Tutorial 1;
6. a fresh configured AppRoot instance reloads the same target and derives the same progress/unlocks;
7. replaying an already completed level with an equal/worse turn result follows `NO_CHANGE`, performs no metadata rewrite, and preserves existing routing/final-ack rules;
8. a bounded TEMP_WRITE or TEMP_READBACK failure during the next real completion leaves target and runtime/Profile state exact, enters bounded Safe Error, and does not unlock the next level;
9. a bounded REPLACE or POST_REPLACE_VERIFY failure proves the same AppRoot-level non-commit behavior while the frozen store restores the exact old target;
10. malformed or unknown-version synthetic target boots only after frozen recovery preservation and hydrates clean runtime state without overwriting the source during load;
11. every AppRoot instance retains one active screen and the existing router contract;
12. public progress snapshots keep the existing shape and defensive-copy behavior;
13. final cleanup removes only the exact tracked Task 0023Y target, recovery/temp/transaction siblings, and fixed fixture directory;
14. no owned residue, no residual Godot process, unchanged production metadata, and unchanged test-root existence.

Use the existing accepted action sequences for Tutorial 0 and Tutorial 1. Do not alter formal levels or Gameplay to simplify the test.

Required marker exactly once:

```text
TASK_0023Y_APP_ROOT_TEST_PROFILE_SESSION_TESTS_PASS
```

Exit 0 and empty stderr are mandatory. No aggregate marker is added.

## 14. Static source audit

Before behavior testing and again after it, audit authorized source/tests and require:

- no `create_production` or production fallback;
- no production Profile path use except frozen constant comparison inside validation;
- no environment/command-line-derived Profile path;
- no arbitrary OS-path injection;
- no store/adapter construction in normal memory-only mode;
- all test-profile I/O occurs only after accepted pre-tree canonical validation and successful store configuration;
- adapter commit appears only after accepted persistence success;
- no AppRoot commit on any store failure path;
- no Profile content/path in Safe Error or public progress snapshots;
- no second router, scene modification, aggregate registration, menu/settings/localization implementation, or existing-test change;
- frozen codec/store/adapter/MemoryProgress files remain unchanged;
- test paths originate only from the frozen builder;
- no test-root enumeration.

## 15. Execution order

1. Startup Git/environment checks.
2. Protected metadata and test-root-existence snapshot.
3. Pre-edit Tasks 0023R–0023X regressions.
4. Implement minimal AppRoot test-profile configuration and orchestration draft.
5. Run Task 0023Y compile smoke only.
6. Static source audit and protected metadata recheck.
7. Confirm exact fixed Task 0023Y fixture path is absent.
8. Run one standalone Task 0023Y behavior suite.
9. Clean exact tracked owned inventory and fixed fixture directory.
10. Rerun Task 0023Y compile/behavior and Tasks 0023R–0023X from a clean fixed-fixture state.
11. Repeat source audit, protected metadata, test-root existence, and exact fixture-absence checks.
12. Require no residual Godot process.
13. Write report/current-document updates, explicit-stage, commit, and push.

Stop immediately on production metadata change, production content access, unrelated fixture access, test-root enumeration, canonical-path escape, false runtime commit before persistence, unsafe/uncertain rollback, existing route/finale regression, cleanup uncertainty, parser/runtime error outside the bounded compile-correction phase, or unexpected repository drift.

## 16. Authorized repository paths

```text
scripts/app/app_root.gd
tests/app/task_0023y_app_root_test_profile_session_compile_smoke.gd
tests/app/task_0023y_app_root_test_profile_session.gd
docs/reports/0023Y_APP_ROOT_TEST_PROFILE_SESSION_GATE_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/production/COMPLETE_FLOW_PRODUCTION_CLOSURE_PLAN_CURRENT.md
```

Do not modify:

```text
scripts/app/profile_codec.gd
scripts/app/local_profile.gd
scripts/app/profile_progress_adapter.gd
scripts/app/memory_progress.gd
existing tests
tests/run_all.gd
project.godot
scenes
formal level data/catalog
Simulation/solver/schema/canonical state
Gameplay/UI/Help/Timeline/Level Select
localization/assets/export/release/submission surfaces
```

Do not restore or execute historical blocked tasks 0023, 0023S, or 0023U as active scopes.

## 17. Evidence and report

Use only:

```text
D:\Delayed_Self_Evidence\0023Y_app_root_test_profile_session_gate\
```

Record:

- startup Git/environment facts;
- protected metadata before/after every major gate;
- all prerequisite and Task 0023Y commands, stdout/stderr/exit codes, assertions, and marker counts;
- compile-attempt ledger;
- pre-tree configuration contract;
- test-profile boot/load state matrix;
- completion candidate→persist→commit ordering evidence;
- failure-seam target/runtime rollback evidence;
- Safe Error codes and one-screen route evidence;
- exact owned path inventory and cleanup proof;
- source-audit results;
- changed/staged files and final Git state;
- explicit non-claims.

Create:

```text
docs/reports/0023Y_APP_ROOT_TEST_PROFILE_SESSION_GATE_REPORT.md
```

Do not stage evidence, logs, fixture files, generated files, or machine-local artifacts.

## 18. Git policy

Require one implementation commit:

```text
feat: add Delayed Self AppRoot test profile session
```

Stage authorized paths explicitly. Run `git diff --cached --check`. Fetch and stop on remote drift before pushing normally.

Finish with:

- clean worktree;
- `HEAD == origin/main`;
- divergence `0/0`;
- no Godot process;
- production Profile metadata unchanged;
- Tasks 0023W and 0023Y fixed fixtures absent.

## 19. Terminal verdict

Return exactly one:

```text
APP_ROOT_TEST_PROFILE_SESSION_GATE_READY_FOR_GPT_REVIEW
BLOCKED_APP_ROOT_TEST_PROFILE_SESSION_GATE
```

Include commit SHA if produced, compile/behavior assertion counts, pre/post Tasks 0023R–0023X results, test-profile boot/completion/failure matrix, Safe Error evidence, production metadata, exact fixture cleanup, changed paths, evidence root, and final Git state.

This task does not authorize production Profile operation, default product persistence, aggregate registration, New Game/Continue/Reset confirmations, persistent settings, localization, build/export, RC, release, upload, or festival submission.
