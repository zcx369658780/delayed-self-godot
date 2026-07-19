# Task 0023X — Implement the pure Profile-to-MemoryProgress adapter gate

- Status: `READY`
- Gate: `PROTECTED PLAYER DATA / PURE PROFILE↔RUNTIME PROGRESS ADAPTER`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- GPT prerequisite acceptance: `docs/reports/0023W_GPT_PROFILE_FILESYSTEM_STORE_AFTER_INSTANCE_GATE_ACCEPTANCE.md`
- Required checkpoint: `25f7f7cf26849a722b576d13cee26f225061bc94`

## 1. Objective

Add one explicitly typed, deterministic, **zero-I/O** adapter between the accepted Profile v1 data contract and `DelayedSelfMemoryProgress`.

The adapter must:

1. derive persistable catalog facts from a validated catalog;
2. normalize and hydrate runtime completion/best-turn state from a Profile v1 Dictionary;
3. keep unlocks derived from catalog prerequisites and never serialize them;
4. prepare a completion candidate without mutating current runtime/profile state;
5. apply a Profile candidate to runtime state only through an explicit later commit call;
6. preserve Profile settings unchanged while progress changes;
7. reset only its in-memory state to the codec default.

This task is a pure adapter gate. It does **not** call the filesystem store, create a fixture, access the production Profile, connect AppRoot, change Gameplay/Level Select, register aggregate tests, or implement menus/settings/localization/export/release surfaces.

## 2. Startup and remote gate

Before edits or Godot processes:

1. require absolute root `D:\Delayed_Self`, branch `main`, expected origin, and clean tracked/untracked worktree;
2. run the startup Git facts required by `AGENTS.md`;
3. fetch and fast-forward only;
4. require `HEAD == origin/main` and ancestry of `25f7f7cf26849a722b576d13cee26f225061bc94`;
5. read the complete Task 0023W GPT acceptance and Task 0023W implementation report;
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

Any production metadata change or content-oriented production access is an immediate safety stop with no implementation commit.

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
```

Require:

- Task 0023R: 123 assertions / 4 positive / 39 negative;
- Task 0023T: compile marker and 34 assertions;
- Task 0023V: compile marker and 28 assertions;
- Task 0023W: compile marker and 68 assertions;
- every command exit 0, required marker exactly once, and empty stderr;
- fixed Task 0023W fixture absent after cleanup;
- no residual Godot process.

Recheck protected metadata and test-root existence afterward. Stop before edits on any regression.

## 5. Frozen accepted authorities

Preserve exactly:

- `scripts/app/profile_codec.gd` and all accepted Task 0023T semantics/bytes;
- `scripts/app/local_profile.gd` and all accepted Tasks 0023R/0023V/0023W semantics/bytes;
- Task 0023W compile and filesystem behavior tests;
- the production Profile and unrelated test-root contents;
- all eight formal levels, catalog order/facts, Simulation, solver, schema, canonical state, Gameplay, final acknowledgment, Help, Timeline, Level Select, presentation, and owner evidence.

Do not modify `profile_codec.gd` or `local_profile.gd` in this task. Stop if an essential change to either accepted source is discovered.

## 6. Architecture boundary

Use a new pure adapter:

```text
scripts/app/profile_progress_adapter.gd
```

External callers must preload the script and construct it as a `RefCounted`. Do not introduce a class-internal self-type factory.

The adapter may preload only the frozen codec and `memory_progress.gd`. It must not preload or reference `local_profile.gd`, AppRoot, scenes, route code, OS/environment/command-line APIs, or filesystem APIs.

The existing `DelayedSelfMemoryProgress` remains the sole runtime unlock model. Do not duplicate unlock derivation in UI or the adapter. A minimal pure hydration/replace surface may be added to `memory_progress.gd` so the adapter can atomically restore normalized completed IDs and best turns without inventing missing best-turn values.

## 7. Required adapter surface

Provide an explicitly typed bounded interface equivalent to:

```text
configure(catalog: Dictionary) -> Dictionary
is_configured() -> bool
load_profile(profile: Dictionary) -> Dictionary
prepare_completion(level_id: String, turns: int) -> Dictionary
commit_profile(profile: Dictionary) -> Dictionary
reset_to_default() -> Dictionary
snapshot() -> Dictionary
get_profile_snapshot() -> Dictionary
is_unlocked(level_id: String) -> bool
```

Exact names may vary only if the report records the mapping and behavior remains equivalent.

### Configuration

`configure` must:

- accept only a bounded catalog shape with a non-empty `entries` Array;
- require unique non-empty String level IDs;
- require one prerequisite Array for every entry;
- require every prerequisite to be a known unique String and not self-referential;
- derive codec facts exactly as `{level_ids, prerequisites}`;
- defensively copy retained catalog/facts;
- configure only once; a failed first attempt leaves the adapter fresh, while the first success is immutable;
- create one `DelayedSelfMemoryProgress` instance but perform no Profile load or I/O.

Full graph acyclicity need not be reproved if the supplied catalog is already validated, but invalid shapes and references must reject deterministically.

### Loading and committing

`load_profile` and `commit_profile` must:

- reject before configuration;
- normalize through the frozen codec;
- atomically replace runtime completed IDs and best turns only after all validation succeeds;
- preserve completed IDs that legitimately have no best-turn entry without inventing a value;
- derive unlocks from the retained catalog only;
- retain the full normalized Profile, including settings, as a defensive copy;
- return `LOADED` or `SANITIZED` as appropriate;
- reject invalid input without changing runtime or retained Profile state.

`commit_profile` is only an in-memory commit point. It must not imply or perform filesystem persistence. A later AppRoot integration task will call it only after the accepted store confirms persistence success.

### Completion preparation

`prepare_completion` must:

- reject before configuration or before a Profile has been loaded/defaulted;
- call the frozen codec candidate builder using the retained Profile and catalog facts;
- return the codec-equivalent `CANDIDATE_READY`, `NO_CHANGE`, or structured rejection;
- preserve settings exactly;
- never mutate retained Profile, completed IDs, best turns, or derived unlocks;
- return defensive candidate/profile copies.

A later caller must explicitly invoke `commit_profile` after successful persistence to update runtime state.

### Reset

`reset_to_default` must:

- operate only in memory;
- use the frozen codec default Profile;
- atomically reset completed IDs/best turns and derived unlocks;
- perform zero filesystem operations;
- not call Task 0023W reset and not expose a product Reset UI.

## 8. Minimal MemoryProgress hydration surface

If `memory_progress.gd` is modified, add only one bounded pure method (or an equivalent minimal pair) to atomically restore normalized progress.

It must validate before mutation:

- completed IDs are unique known Strings;
- prerequisite closure is satisfied;
- best-turn keys are completed known IDs;
- best turns are positive integers;
- no unlock list is accepted from the caller.

On rejection, existing runtime state remains byte/semantic-equivalent. Existing constructor, `snapshot`, `is_unlocked`, `record_completion`, and `reset_test_profile` behavior must remain unchanged.

## 9. Absolute zero-I/O source boundary

The changed source and new Task 0023X tests must have zero hits for:

```text
FileAccess
DirAccess
ProjectSettings.globalize_path
ResourceLoader
ResourceSaver
OS.get_cmdline
OS.get_cmdline_user_args
OS.get_environment
DelayedSelfLocalProfile
local_profile.gd
load_profile() on a store
persist_profile() on a store
reset_test_profile() on a store
AppRoot
MemoryProgress filesystem access
```

The strings `load_profile` and `reset_test_profile` are allowed only as the adapter's own pure API/test labels where unambiguous; the source audit must prove there is no store or filesystem call.

Do not create, inspect, list, write, or delete any fixture in the Task 0023X compile/behavior tests.

## 10. Compile-first gate

Add:

```text
tests/app/task_0023x_profile_memory_progress_adapter_compile_smoke.gd
```

It must preload the adapter, codec, and MemoryProgress, externally instantiate the adapter as `RefCounted`, compile the exact configure/load/prepare/commit/snapshot calls with synthetic in-memory Dictionaries only, and print exactly once:

```text
TASK_0023X_PROFILE_MEMORY_PROGRESS_ADAPTER_COMPILE_SMOKE_PASS
```

Run it immediately after the first source draft. Allow at most five compile-only correction attempts inside authorized files. If it still fails, restore the accepted pre-task source state, remove Task 0023X additions, and return the blocked verdict.

## 11. Standalone pure behavior test

Only after compile smoke and source audit pass, add:

```text
tests/app/task_0023x_profile_memory_progress_adapter.gd
```

Use synthetic in-memory catalogs and Profile Dictionaries only. Cover at minimum:

1. all operational methods reject before configuration without mutation;
2. malformed catalogs, duplicate IDs, missing prerequisite arrays, unknown/duplicate/self prerequisites reject;
3. failed first configuration permits a later valid configuration;
4. first successful configuration is immutable and snapshots are defensive;
5. clean default Profile loads with only root entries unlocked;
6. partial Profile hydrates exact completed IDs/best turns and derives the next unlocks;
7. completed IDs without best turns remain completed without invented best-turn values;
8. completed/fully completed Profile states derive exact unlocks for a synthetic chain/join catalog;
9. unknown IDs, duplicate completions, invalid best turns, extra fields, and missing prerequisite closure are sanitized exactly by the frozen codec;
10. invalid root/version/container input rejects atomically without runtime/profile mutation;
11. `prepare_completion` rejects unknown, locked, and invalid-turn attempts without mutation;
12. valid first completion returns a candidate without mutation and preserves settings;
13. lower best-turn candidate and already-worse `NO_CHANGE` behavior match the frozen codec;
14. committing a prepared candidate updates runtime/profile state and derived unlocks exactly;
15. committing invalid input rejects atomically;
16. candidate, profile, catalog, and runtime snapshots are defensive copies;
17. reset returns the codec default, clears progress, derives root unlocks, preserves zero-I/O;
18. repeated results and status shapes are deterministic and expose no filesystem/path data;
19. existing `DelayedSelfMemoryProgress` constructor/record/reset semantics remain unchanged in a focused regression block;
20. no fixture or `user://` access occurs.

Required marker exactly once:

```text
TASK_0023X_PROFILE_MEMORY_PROGRESS_ADAPTER_TESTS_PASS
```

Exit 0 and empty stderr are mandatory. Do not add an aggregate marker.

## 12. Post-test gates

After Task 0023X behavior passes:

1. rerun Task 0023X compile and behavior from a fresh process;
2. rerun Tasks 0023R, 0023T, 0023V, and 0023W exactly as in the prerequisite section;
3. repeat the zero-I/O source audit;
4. confirm `profile_codec.gd` and `local_profile.gd` are unchanged;
5. confirm production Profile non-content metadata and test-root existence are unchanged;
6. confirm the Task 0023W fixed fixture is absent after cleanup;
7. require no residual Godot process.

Do not run `tests/run_all.gd` or any product scene in this gate.

## 13. Authorized repository paths

```text
scripts/app/memory_progress.gd
scripts/app/profile_progress_adapter.gd
tests/app/task_0023x_profile_memory_progress_adapter_compile_smoke.gd
tests/app/task_0023x_profile_memory_progress_adapter.gd
docs/reports/0023X_PROFILE_MEMORY_PROGRESS_ADAPTER_GATE_REPORT.md
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
scripts/app/app_root.gd
existing tests
tests/run_all.gd
project.godot
scenes
formal level data/catalog
Simulation/solver/schema/canonical state
Gameplay/UI/Help/Timeline/Level Select
localization/assets/export/release/submission surfaces
```

## 14. Evidence and report

Use only:

```text
D:\Delayed_Self_Evidence\0023X_profile_memory_progress_adapter_gate\
```

Record:

- startup Git/environment facts;
- protected metadata before/after every regression group;
- all prerequisite and Task 0023X commands, stdout/stderr/exit codes, assertion and marker counts;
- compile-attempt ledger;
- adapter and hydration interface contract;
- pure candidate/commit state-transition matrix;
- source-audit results;
- changed/staged files and final Git state;
- explicit non-claims.

Create:

```text
docs/reports/0023X_PROFILE_MEMORY_PROGRESS_ADAPTER_GATE_REPORT.md
```

Do not stage evidence, logs, generated files, fixtures, or machine-local artifacts.

## 15. Git policy

Require one implementation commit:

```text
feat: add Delayed Self profile memory-progress adapter
```

Stage authorized paths explicitly. Run `git diff --cached --check`. Fetch and stop on remote drift before pushing normally.

Finish with:

- clean worktree;
- `HEAD == origin/main`;
- divergence `0/0`;
- no Godot process;
- production Profile metadata unchanged;
- Task 0023W fixed fixture absent.

## 16. Terminal verdict

Return exactly one:

```text
PROFILE_MEMORY_PROGRESS_ADAPTER_GATE_READY_FOR_GPT_REVIEW
BLOCKED_PROFILE_MEMORY_PROGRESS_ADAPTER_GATE
```

Include commit SHA if produced, compile/behavior assertion counts, pre/post 0023R/0023T/0023V/0023W results, source audit, production metadata, fixture cleanup, changed paths, evidence root, and final Git state.

This task does not authorize production Profile operation, filesystem-store changes, AppRoot integration, single-AppRoot fixture authority, focused product integration, aggregate persistence regression, menus, settings, localization, build/export, RC, release, upload, or festival submission.
