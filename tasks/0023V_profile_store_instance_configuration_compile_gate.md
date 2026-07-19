# Task 0023V — Prove the Profile-store instance configuration compile gate

- Status: `READY`
- Gate: `PROTECTED PLAYER DATA / ZERO-I/O STORE INSTANCE CONFIGURATION + TYPE-CHECK`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Accepted path gate: `tasks/0023R_profile_test_isolation_gate_repair.md`
- Accepted codec gate: `tasks/0023T_pure_profile_codec_compile_gate.md`
- Blocker adjudication: `docs/reports/0023U_GPT_PROFILE_STORE_SELF_TYPE_COMPILE_BLOCKER_ADJUDICATION.md`
- Required checkpoint: `add98e172be4ace6023093d1d5fef2a194f9e992`

## 1. Objective

Replace the failed class-internal self-type factory pattern with one explicitly typed, zero-I/O instance configuration surface that compiles and behaves deterministically on the pinned Godot 4.7 toolchain.

This task does not implement Profile filesystem loading, writing, recovery, replacement, reset, AppRoot, MemoryProgress, fixtures, aggregate regression, production Profile access, menus, settings, localization, assets, export, release or submission.

## 2. Startup and protected metadata

Before edits or Godot processes:

- require root `D:\Delayed_Self`, branch `main`, expected SSH origin and clean tracked/untracked worktree;
- fetch and fast-forward only;
- require `HEAD == origin/main` and ancestry of `add98e172be4ace6023093d1d5fef2a194f9e992`;
- verify Godot `4.7.stable.steam.5b4e0cb0f` or the exact documented equivalent;
- require no residual Godot process.

Outside Godot record only production Profile `Test-Path`, `Length` and `LastWriteTimeUtc`. Do not open, parse, hash, copy, rename, back up, delete or repair its content. Record only whether `user://delayed_self_test_profiles/` exists; do not enumerate or alter it.

## 3. Mandatory prerequisites

Before editing, rerun exactly:

```text
godot.windows.opt.tools.64.exe --headless --path D:\Delayed_Self --script res://tests/app/task_0023r_profile_test_isolation_gate.gd
godot.windows.opt.tools.64.exe --headless --path D:\Delayed_Self --script res://tests/app/task_0023t_profile_codec_compile_smoke.gd
godot.windows.opt.tools.64.exe --headless --path D:\Delayed_Self --script res://tests/app/task_0023t_pure_profile_codec.gd
```

Require the accepted 123-assertion path result, compile marker, 34-assertion codec result, exit 0 and empty stderr. Recheck protected metadata afterward. Stop before edits on any regression.

## 4. Frozen authorities

Preserve exactly:

- Task 0023R constants and static path-policy methods in `scripts/app/local_profile.gd`;
- all accepted semantics and bytes of `scripts/app/profile_codec.gd`;
- production Profile and unrelated test-root contents;
- all eight formal levels, catalog, Simulation, solver, schema, Gameplay, final acknowledgment, Help, Timeline and presentation.

Do not modify `profile_codec.gd`.

## 5. Revised construction pattern

Do not add or restore a class-internal static `create_test` factory and do not reference `DelayedSelfLocalProfile` as a type inside its own script.

External callers use this pattern:

```gdscript
const LocalProfileScript = preload("res://scripts/app/local_profile.gd")
var store: RefCounted = LocalProfileScript.new()
var configured: Dictionary = store.configure_test(catalog_facts, canonical_test_profile_path)
```

Add only these zero-I/O instance surfaces, or an equivalent minimal set recorded in the report:

```text
configure_test(catalog_facts: Dictionary, canonical_test_profile_path: String) -> Dictionary
is_configured() -> bool
get_configuration_snapshot() -> Dictionary
```

`configure_test` must:

1. be callable only on a fresh, unconfigured instance;
2. call the accepted `validate_test_profile_path` before retaining any path;
3. reject invalid and production paths with `ok=false` and no retained path/fallback;
4. validate a bounded catalog-facts shape sufficient for later codec use;
5. defensively deep-copy retained catalog facts;
6. retain exactly the accepted canonical virtual path;
7. return a structured success status;
8. reject every later reconfiguration attempt without changing the first configuration.

The configuration snapshot may contain only the canonical virtual test path, a defensive catalog snapshot and configured state. It must not contain a globalized OS path, production fallback, mutable internal reference or filesystem handle.

## 6. Catalog-facts compile-gate shape

For this gate, accept only:

```text
{
  "level_ids": Array,
  "prerequisites": Dictionary
}
```

Require:

- non-empty unique String level IDs;
- a prerequisite Array for every known ID;
- every prerequisite is a known unique String;
- no self-prerequisite;
- no extra requirement to prove full graph acyclicity in this compile gate.

Reject invalid facts deterministically and retain no partial configuration.

## 7. Absolute zero-I/O boundary

The changed source and tests must have zero hits for:

```text
FileAccess
DirAccess
ResourceLoader
ResourceSaver
ProjectSettings.globalize_path
OS.get_cmdline
OS.get_environment
load_profile
persist_profile
reset_test_profile
create_production
AppRoot
MemoryProgress
```

Do not create, list, read, write or delete any fixture. Do not run Task 0023U behavior tests or aggregate.

## 8. Compile-first test

Add:

```text
tests/app/task_0023v_profile_store_instance_compile_smoke.gd
```

It must preload `local_profile.gd`, instantiate the script externally as `RefCounted`, compile the exact construction/configuration calls, perform no I/O and print exactly once:

```text
TASK_0023V_PROFILE_STORE_INSTANCE_COMPILE_SMOKE_PASS
```

Run this immediately after the first draft. Allow at most five compile-only correction attempts within authorized files. If still failing, fully roll back and return `BLOCKED_PROFILE_STORE_INSTANCE_CONFIGURATION_COMPILE_GATE`.

## 9. Zero-I/O behavior test

Only after compile smoke passes, add:

```text
tests/app/task_0023v_profile_store_instance_configuration.gd
```

Use synthetic in-memory catalog facts and canonical path strings only. Cover at minimum:

1. valid canonical path configures once;
2. production and invalid paths reject with no retained fallback;
3. valid catalog facts are defensively copied;
4. invalid catalog shapes/types/duplicates/unknown prerequisites/self-prerequisites reject;
5. failed first configuration leaves the instance fresh and permits a later valid configuration;
6. second configuration after success rejects and preserves the original snapshot;
7. returned snapshots are defensive copies;
8. repeated rejection and success result shapes are deterministic;
9. Task 0023R path-builder output round-trips exactly;
10. no Profile codec input or accepted policy state is mutated.

Required marker exactly once:

```text
TASK_0023V_PROFILE_STORE_INSTANCE_CONFIGURATION_TESTS_PASS
```

Exit 0 and empty stderr are mandatory.

## 10. Post-test gates

After behavior testing:

- rerun Task 0023R and both Task 0023T tests;
- repeat the zero-I/O source audit;
- confirm production Profile non-content metadata and test-root existence unchanged;
- confirm no fixture or generated file was created;
- require no residual Godot process.

## 11. Authorized paths

```text
scripts/app/local_profile.gd
tests/app/task_0023v_profile_store_instance_compile_smoke.gd
tests/app/task_0023v_profile_store_instance_configuration.gd
docs/reports/0023V_PROFILE_STORE_INSTANCE_CONFIGURATION_COMPILE_GATE_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/production/COMPLETE_FLOW_PRODUCTION_CLOSURE_PLAN_CURRENT.md
```

Do not modify `profile_codec.gd`, `memory_progress.gd`, `app_root.gd`, existing tests, `tests/run_all.gd`, scenes, project settings, formal data, catalog, Simulation, solver, schema, Gameplay, UI, localization, assets, export, release or submission surfaces.

## 12. Evidence, report and Git

Use only:

```text
D:\Delayed_Self_Evidence\0023V_profile_store_instance_compile_gate\
```

Record startup state, protected metadata, prerequisite runs, each compile attempt, behavior output, source audit, changed paths, cleanup and final Git state.

Create `docs/reports/0023V_PROFILE_STORE_INSTANCE_CONFIGURATION_COMPILE_GATE_REPORT.md` documenting the exact interface, type pattern, test matrix, results, data-protection boundary, rollback and non-claims.

Require one commit:

```text
fix: add Delayed Self profile store instance compile gate
```

Push normally. Finish clean with `HEAD == origin/main`, divergence `0/0` and no Godot process.

## 13. Terminal verdict

Return exactly one:

```text
PROFILE_STORE_INSTANCE_CONFIGURATION_GATE_READY_FOR_GPT_REVIEW
BLOCKED_PROFILE_STORE_INSTANCE_CONFIGURATION_COMPILE_GATE
```

This task does not authorize filesystem behavior or resumption of Task 0023U. A later revised filesystem-store task is required after GPT acceptance.
