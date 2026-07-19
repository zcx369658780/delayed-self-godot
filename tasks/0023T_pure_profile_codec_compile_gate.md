# Task 0023T — Establish the pure Profile codec compile gate

- Status: `READY`
- Gate: `PROTECTED PLAYER DATA / ZERO-I/O PROFILE CODEC + TYPE-CHECK`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Accepted isolation gate: `tasks/0023R_profile_test_isolation_gate_repair.md`
- Parent blocked retry: `tasks/0023S_persistent_local_profile_core_retry_after_isolation_gate.md`
- GPT blocker adjudication: `docs/reports/0023S_GPT_PROFILE_CORE_RETRY_COMPILE_BLOCKER_ADJUDICATION.md`
- Required checkpoint: `243f0b395f6215e9b461184d39169bdd45acf59e`

## 1. Objective

Create and validate one explicitly typed, zero-I/O Profile v1 codec/model surface that can be preloaded and executed under the pinned Godot 4.7 toolchain.

This task resolves the Phase-A GDScript type-inference blocker before any filesystem store, recovery, replacement, AppRoot integration, fixture creation, aggregate regression, or production Profile access is authorized.

## 2. Startup and protected metadata

Before editing or running Godot:

- require root exactly `D:\Delayed_Self`;
- require branch `main`, expected SSH origin, clean tracked/untracked worktree;
- fetch and fast-forward only;
- require `HEAD == origin/main` and ancestry of `243f0b395f6215e9b461184d39169bdd45acf59e`;
- verify Godot `4.7.stable.steam.5b4e0cb0f` or exact documented equivalent;
- require no residual Godot process.

Using PowerShell outside Godot, record only production Profile:

```text
Test-Path
Length
LastWriteTimeUtc
```

Do not open, parse, hash, copy, rename, back up, delete, repair, or reset its content. Record only whether `user://delayed_self_test_profiles/` exists; do not enumerate or alter it.

Print a concise type-check, pure-codec, synthetic-test, source-audit, cleanup, rollback, and stop-condition plan.

## 3. Mandatory isolation preflight

Before editing the codec, rerun exactly:

```text
godot.windows.opt.tools.64.exe --headless --path D:\Delayed_Self --script res://tests/app/task_0023r_profile_test_isolation_gate.gd
```

Require:

```text
123 assertions
4 positive paths
39 negative paths
exit 0
stderr empty
TASK_0023R_PROFILE_TEST_ISOLATION_GATE_PASS exactly once
```

Recheck protected metadata. Any difference or content-oriented access is `BLOCKED_PROFILE_ISOLATION_REGRESSION`.

## 4. Frozen path policy

The accepted path-policy constants and methods in `scripts/app/local_profile.gd` remain authoritative and semantically unchanged:

```text
PRODUCTION_PROFILE_PATH
TEST_PROFILE_ROOT
PROFILE_FILENAME
MAX_FIXTURE_ID_LENGTH
build_test_profile_path
validate_test_profile_path
_validate_fixture_id
_is_ascii_alphanumeric
_rejected
```

Do not normalize, decode, globalize, simplify, replace separators, add arbitrary roots, read command-line arguments, or read environment variables.

The final standalone isolation test must still pass exactly after codec changes.

## 5. Zero-I/O boundary

This task must contain no filesystem or product integration behavior.

Forbidden in changed product/test source:

```text
FileAccess
DirAccess
ResourceLoader
ResourceSaver
ProjectSettings.globalize_path
OS.get_cmdline_args
OS.get_cmdline_user_args
OS.get_environment
AppRoot
SceneTree product routing
MemoryProgress file integration
create_production
create_test
configure_test_profile_path
```

Do not create, inspect, enumerate, read, write, rename, copy, delete, or hash any Profile or fixture file. Do not run Task 0023S store tests, AppRoot tests, or aggregate.

## 6. Pure Profile v1 codec contract

Extend the policy class or add one narrow pure helper under `scripts/app/` to provide explicitly typed, deterministic in-memory operations only.

Required public behavior may use equivalent names but must include:

```text
default_profile() -> Dictionary
normalize_profile(raw_value: Variant, catalog_facts: Dictionary) -> Dictionary
serialize_profile(profile: Dictionary) -> Dictionary
build_progress_candidate(current_profile: Dictionary, level_id: String, turns: int, catalog_facts: Dictionary) -> Dictionary
```

All results are structured Dictionaries with explicit `ok`, `status`, and payload keys where applicable. Rejections must not mutate inputs.

### Canonical v1 shape

```json
{
  "profile_schema_version": 1,
  "progress": {
    "completed_level_ids": [],
    "best_turns": {}
  },
  "settings": {
    "language": "en",
    "window_mode": "windowed",
    "reduced_motion": false
  }
}
```

### Normalization rules

- root must be a Dictionary with version exactly `1` and Dictionary `progress`/`settings`;
- completed IDs are unique catalog-known Strings;
- retained completion must be prerequisite-consistent; iteratively remove entries without prerequisite closure;
- best turns are positive integers and retained only for retained completed IDs;
- settings allow language `en|zh-Hans`, window mode `windowed|fullscreen`, and Boolean reduced motion;
- invalid individual entries are deterministically sanitized to defaults/valid retained values;
- wrong root or unknown version returns a structured invalid result rather than recovery or I/O behavior;
- unlocks are never serialized;
- inputs are deep-duplicated or treated immutably;
- output completed IDs and best-turn keys are deterministically sorted.

### Candidate progress behavior

The pure candidate builder must distinguish:

```text
PROGRESS_REJECTED
NO_CHANGE
CANDIDATE_READY
```

It must preserve existing catalog-derived semantics:

- unknown/locked level or turns < 1 is rejected;
- a first completion is a candidate change;
- a lower best turn is a candidate change;
- an equal/higher turn for an already completed level is `NO_CHANGE`;
- it does not write or mutate the committed input Profile.

### Deterministic serialization

Return the canonical normalized Dictionary and JSON text. Repeated serialization of equivalent inputs must be byte-identical. Use explicit stable insertion order for root/section fields, sorted completed IDs, and sorted best-turn keys.

## 7. Explicit typing requirements

Treat this section as a hard compile contract.

- Add explicit return types to every new function.
- Explicitly type locals receiving `Variant`, `Dictionary.get`, JSON-like data, ternaries, lambda/callable returns, array elements, or duplicated values.
- Prefer `var value: Variant = ...`, `var dictionary: Dictionary = ...`, `var array: Array = ...`, `var text: String = ...`, and explicit numeric/Boolean types.
- Do not use `:=` where the right-hand side is `Variant`, `Dictionary.get`, a conditional expression, an untyped collection element, or an engine API with ambiguous return type.
- Do not assign `null` to a statically non-null inferred type.
- Do not suppress parser/type errors or weaken project-wide warning/error settings.
- Do not use dynamic calls to hide missing methods.

## 8. Compile-first execution

Create a standalone compile smoke script, preferably:

```text
tests/app/task_0023t_profile_codec_compile_smoke.gd
```

It may preload only the path-policy/codec classes and run no filesystem API.

Run the compile smoke immediately after the first complete codec draft and before the behavior suite. Require exit 0 and empty stderr.

If any parser or type-inference error occurs:

- preserve the exact diagnostic externally;
- correct only within this task's authorized source/test paths;
- rerun compile smoke;
- do not start behavior tests until compile smoke is clean.

Maximum compile correction attempts: 5. If still failing, rollback and return `BLOCKED_PURE_PROFILE_CODEC_COMPILE_GATE`.

## 9. Standalone synthetic behavior tests

Add:

```text
tests/app/task_0023t_pure_profile_codec.gd
```

Use only in-memory synthetic dictionaries and the tracked catalog file through an existing read-only loader only if necessary. Prefer a synthetic minimal catalog-facts Dictionary to keep this test independent of filesystem I/O; reading formal/Profile files is forbidden.

Cover at minimum:

1. exact defaults and no shared mutable defaults;
2. valid v1 normalization;
3. duplicate, unknown, out-of-order, and prerequisite-inconsistent completion IDs;
4. invalid best-turn types/values and completed-ID dependency;
5. invalid settings defaulting;
6. wrong root/version/container structured rejection;
7. deterministic ordering and byte-identical JSON output;
8. input immutability;
9. progress rejected/no-change/first-completion/better-turn candidates;
10. candidate input remains unchanged;
11. accepted Task 0023R builder/validator semantics still exact;
12. repeated calls are deterministic.

Required output exactly once:

```text
TASK_0023T_PROFILE_CODEC_COMPILE_SMOKE_PASS
TASK_0023T_PURE_PROFILE_CODEC_TESTS_PASS
```

The codec behavior test must report its assertion count and exit 0 with empty stderr.

Do not register these tests in `tests/run_all.gd` in this task.

## 10. Source audit and protected metadata

After tests, audit changed source/test files and require zero hits for all forbidden I/O/integration surfaces in Section 5.

Run Task 0023R standalone preflight again and require the exact accepted result.

Recheck production Profile existence/size/modified time and test-root existence. They must match the startup baseline. Do not inspect contents.

## 11. Authorized paths

Product:

```text
scripts/app/local_profile.gd
scripts/app/profile_codec.gd   # optional; use only if separation materially improves typing
```

Tests:

```text
tests/app/task_0023t_profile_codec_compile_smoke.gd
tests/app/task_0023t_pure_profile_codec.gd
```

Documentation:

```text
docs/reports/0023T_PURE_PROFILE_CODEC_COMPILE_GATE_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/production/COMPLETE_FLOW_PRODUCTION_CLOSURE_PLAN_CURRENT.md
```

Do not modify AppRoot, MemoryProgress, UI/scenes, tests/run_all.gd, existing AppRoot tests, formal data, catalog, Simulation, solver, schema, Gameplay, project.godot, assets, localization, export, release, or submission surfaces.

## 12. Evidence, report, Git, and rollback

Use only:

```text
D:\Delayed_Self_Evidence\0023T_pure_profile_codec_compile_gate\
```

Record startup/protected metadata, isolation preflights, compile attempts and exact diagnostics, standalone commands/stdout/stderr/exits, assertion counts, source audit, changed paths, cleanup, and final Git state.

Create `docs/reports/0023T_PURE_PROFILE_CODEC_COMPILE_GATE_REPORT.md`.

Require one commit:

```text
feat: add Delayed Self pure profile codec gate
```

Finish with clean worktree, `HEAD == origin/main`, divergence `0/0`, and no residual Godot process.

Rollback removes only this pure codec/type-check topic and its tests/report/current-document updates. Never access or alter the production Profile or pre-existing test-root contents.

## 13. Stop conditions

Stop immediately on:

- production Profile metadata change or content-oriented access;
- any filesystem API or fixture materialization;
- any AppRoot/MemoryProgress/product integration;
- Task 0023R regression;
- parser/type error remaining after five compile correction attempts;
- input mutation, nondeterministic serialization, or invalid progress invention;
- unexpected stderr, generated residue, or unauthorized path change.

## 14. Terminal verdict

Return exactly one:

```text
PURE_PROFILE_CODEC_COMPILE_GATE_READY_FOR_GPT_REVIEW
BLOCKED_PURE_PROFILE_CODEC_COMPILE_GATE
BLOCKED_PROFILE_ISOLATION_REGRESSION
```

Include commit SHA if produced, changed paths, compile-attempt count, synthetic assertion count, both marker counts, isolation preflight results, source-audit result, protected metadata comparison, evidence root, cleanup, and final Git state.

This task does not authorize Profile filesystem I/O, recovery/write/replace/reset, AppRoot integration, aggregate, menus/settings/localization/font/asset/export/RC/release/submission work.
