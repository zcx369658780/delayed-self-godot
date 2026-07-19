# Task 0023S — Retry the persistent local Profile core after the accepted isolation gate

- Status: `READY`
- Gate: `PROTECTED LOCAL PLAYER DATA / PHASED PROFILE CORE RETRY`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Parent blocked task: `tasks/0023_persistent_local_profile_core_implementation.md`
- Accepted isolation gate: `tasks/0023R_profile_test_isolation_gate_repair.md`
- GPT isolation acceptance: `docs/reports/0023R_GPT_PROFILE_TEST_ISOLATION_GATE_ACCEPTANCE.md`
- Required acceptance checkpoint: `93ea2e45690f94d231f7fb8cb0329b724211c13c`

## 1. Objective

Implement and integrate one versioned local Profile core that persists completed level IDs, best turns and the minimum future settings ownership, while proving that no automated test opens or modifies the real production Profile.

This is a phased retry, not a resumption of the rolled-back Task 0023 implementation. The accepted Task 0023R path policy is a prerequisite and must remain authoritative.

The slice must preserve the eight-level catalog, unlock semantics, final acknowledgment, record-once behavior and all existing routes. It does not implement New Game/Continue/Reset UI, pause, confirmations, Settings UI/application, localization, fonts, Credits, assets, audio, export, release or submission.

## 2. Startup and protected metadata

Before any edit or Godot process:

- require root exactly `D:\Delayed_Self`;
- require `main`, expected SSH origin and clean tracked/untracked worktree;
- fetch and fast-forward only;
- require `HEAD == origin/main` and ancestry of `93ea2e45690f94d231f7fb8cb0329b724211c13c`;
- verify Godot `4.7.stable.steam.5b4e0cb0f` or the exact documented equivalent;
- require no residual Godot process.

Using PowerShell outside Godot, record only these production Profile metadata fields:

```text
Test-Path
Length
LastWriteTimeUtc
```

for:

```text
user://delayed_self_profile.json
```

Do not open, parse, hash, copy, rename, back up, delete or repair its content. The current metadata is a protection baseline, not proof of the file's original content.

Record only whether `user://delayed_self_test_profiles/` exists. Do not enumerate or alter any pre-existing contents.

Read Task 0023R, its report and GPT acceptance before the blocked Task 0023 materials. Print a concise phase, path-isolation, storage, recovery, write-failure, AppRoot-integration, regression, cleanup, rollback and stop plan.

## 3. Mandatory Phase 0 isolation preflight

Before editing storage or integration code, run exactly the standalone Task 0023R test:

```text
godot.windows.opt.tools.64.exe --headless --path D:\Delayed_Self --script res://tests/app/task_0023r_profile_test_isolation_gate.gd
```

Require:

```text
assertions = 123
positive paths = 4
negative paths = 39
exit = 0
stderr = empty
TASK_0023R_PROFILE_TEST_ISOLATION_GATE_PASS exactly once
```

Recheck production existence/size/modified time and test-root existence after the preflight. Any change or any content-oriented access is an immediate `BLOCKED_PROFILE_ISOLATION_REGRESSION`.

The accepted constants and static methods currently in `scripts/app/local_profile.gd` must retain their semantics exactly:

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

Storage behavior may be appended below the accepted policy block. Do not add normalization, decoding, arbitrary base paths, command-line paths or environment paths.

## 4. Frozen product authorities

Preserve exactly:

- all eight formal level files, hashes and metrics;
- the eight-entry catalog hash/order/prerequisites and sequence 8 as sole final;
- Simulation, solver, schema and canonical state;
- Task 0021 final acknowledgment and successful record-once behavior;
- non-final automatic return and final retained Gameplay acknowledgment;
- Level Select scrolling/focus, Safe Error, Help, Timeline, resize/letterbox and reduced-motion semantics;
- owner-only evidence boundary and deferred sequence-9 scope.

No formal data, catalog, Simulation, solver, schema, Gameplay, Help, Timeline, scene, project setting, UI, asset, audio, export, release or submission change is authorized.

## 5. Architecture and creation interfaces

Keep `DelayedSelfMemoryProgress` as a pure catalog-derived model with no file I/O. Preserve its existing public semantics and add only the minimum validated import/export or candidate-clone methods required for transaction safety.

Extend `DelayedSelfLocalProfile` as the store/adapter. It owns Profile validation, recovery, transactional writes, settings defaults, structured status and one composed MemoryProgress instance.

Do not expose a generic arbitrary-path constructor. Provide two explicit creation paths:

```text
DelayedSelfLocalProfile.create_production(catalog)
DelayedSelfLocalProfile.create_test(catalog, canonical_test_profile_path)
```

`create_production` always uses the fixed `PRODUCTION_PROFILE_PATH`.

`create_test` must first call the accepted `validate_test_profile_path`; failure returns a structured rejection and performs zero I/O. It may use only the exact validated returned path.

AppRoot receives one pre-tree method such as:

```text
configure_test_profile_path(path: String) -> bool
```

It must:

- work only before AppRoot enters the tree or boots;
- accept only an exact Task 0023R-valid path;
- return false and retain no fallback path on rejection;
- never accept the production path;
- select `create_test` for that AppRoot instance.

Without test configuration, production AppRoot uses `create_production`. Automated tests are forbidden from exercising that default.

Do not introduce an autoload, service locator, resource database, multiple slots, cloud/account layer, background thread or new router.

## 6. Single AppRoot test fixture authority

Create one helper, preferably:

```text
tests/app/app_root_profile_test_fixture.gd
```

It must:

1. generate a unique valid fixture ID;
2. obtain the path only through `build_test_profile_path`;
3. instantiate AppRoot without adding it to the tree;
4. call `configure_test_profile_path` and require success;
5. add/boot AppRoot only after configuration;
6. track and clean only its own canonical fixture directory;
7. never enumerate, open or modify the production Profile or unrelated test-root contents.

Before running any AppRoot/Profile focused test or aggregate suite, perform and retain a source audit proving:

- every `tests/app/` AppRoot instantiation uses this helper;
- no other test constructs an AppRoot directly;
- no test references `PRODUCTION_PROFILE_PATH` except to assert rejection or compare the fixed literal without I/O;
- no test calls `create_production`;
- no arbitrary or normalized test path is constructed.

If the audit cannot prove this, stop before starting Godot.

## 7. Profile v1 contract

Production path remains:

```text
user://delayed_self_profile.json
```

Canonical root:

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

Rules:

- maximum accepted input size `65536` bytes;
- exact version `1` and Dictionary root/progress/settings;
- unique catalog-known completed IDs;
- iteratively discard completion IDs lacking prerequisite closure;
- retain positive integer best turns only for retained completed IDs;
- settings allow only `en|zh-Hans`, `windowed|fullscreen` and Boolean reduced motion;
- sanitize invalid individual entries deterministically and never invent progress;
- derive unlocks from the validated catalog; never serialize unlocks;
- deterministic serialization with sorted completed IDs and stable best-turn keys;
- no in-progress puzzle state, timestamp, ending-seen flag, slot, account, cloud, witness or unbounded migration.

Settings are stored/defaulted only; no UI or application is authorized.

## 8. Load, recovery and write statuses

Use structured results. At minimum distinguish:

```text
MISSING_CLEAN
LOADED
SANITIZED
RECOVERED_CLEAN
RECOVERY_FAILED
PERSISTED
NO_CHANGE
PROGRESS_REJECTED
WRITE_FAILED
```

Missing file creates only a clean in-memory v1 Profile until an intentional persistent change.

Valid v1 loads without rewriting.

Salvageable v1 returns `SANITIZED`; preserve one collision-safe sibling recovery copy before the first replacement write.

Malformed, truncated, unreadable, oversized, wrong-root or unknown-version data must be preserved before activating a clean Profile. If preservation fails, leave the source untouched, disable writes and return `RECOVERY_FAILED`.

No raw Profile content, full filesystem path, username or unrelated data may enter UI diagnostics.

For every persistent change:

1. build a candidate without mutating the committed MemoryProgress/settings;
2. deterministically serialize;
3. write a unique same-directory temp sibling;
4. check write result, flush, close and parse back;
5. replace the target using the pinned Godot 4.7 API;
6. commit the candidate in memory only after replacement succeeds;
7. on failure, preserve the previous target and active model and remove only the owned temp.

Use the retained successful Windows overwrite-replacement probe from the blocked Task 0023 evidence when the same API is used. Record its evidence identity. If a different replacement API is selected, run a new synthetic-only probe and stop if it cannot be proven.

## 9. Phased execution

### Phase A — Store only

Implement `local_profile.gd`, the minimal pure-model changes in `memory_progress.gd`, and a store-focused test using only a unique canonical fixture path.

Do not modify AppRoot yet. Do not run any AppRoot test or aggregate.

Require the Task 0023R preflight immediately before the store test and unchanged production metadata immediately after it.

Store tests cover missing/load/sanitize/recovery/write/replace failure/temp cleanup/reset primitive and deterministic serialization using synthetic fixture content only.

Stop and roll back if Phase A cannot pass without touching the production Profile.

### Phase B — AppRoot integration

Only after Phase A passes, integrate AppRoot through the explicit production/test creation paths and add the single AppRoot test fixture helper. Update the minimum existing AppRoot tests to use the helper.

Run the source audit before any AppRoot test. Then run focused integration tests only.

### Phase C — Aggregate

Run aggregate only after:

- Task 0023R preflight passes again;
- source audit passes;
- focused store and integration tests pass;
- production existence/size/modified time remain unchanged;
- no fixture residue exists for this task.

After aggregate, repeat the production metadata comparison and clean only task-owned fixture paths.

## 10. Required tests and markers

Create:

```text
tests/app/task_0023s_persistent_local_profile_core.gd
```

Cover at minimum:

1. accepted isolation preflight remains exact;
2. missing-file clean state and no eager write;
3. first completion persistence and adapter reconstruction;
4. non-improving and improving best turns;
5. deterministic JSON order;
6. invalid, duplicate, unknown and prerequisite-inconsistent progress sanitation;
7. invalid settings sanitation;
8. oversized/malformed/truncated/wrong-root/unknown-version recovery;
9. recovery-copy collision safety and preservation failure;
10. existing-target replacement using the proven Windows API;
11. injected write/replace failure preserving target and active model;
12. unique temp ownership and cleanup;
13. reset primitive under a canonical isolated fixture only;
14. AppRoot restart persistence through normal non-final completion;
15. final record-once, acknowledgment, replay and routing after successful persistence;
16. locked development-direct final remains non-recording without false I/O error;
17. Safe Error behavior for recovered-clean, recovery-failed and write-failed statuses;
18. rejected test paths cause zero I/O/store construction and no fallback;
19. all AppRoot tests use the single fixture helper;
20. production existence/size/modified-time metadata remain unchanged;
21. exact catalog/eight-level hashes and metrics;
22. no Profile/settings value changes Simulation, canonical state, Help, Timeline or presentation contracts.

Focused output exactly once:

```text
TASK_0023S_PERSISTENT_LOCAL_PROFILE_CORE_FOCUSED_PASS
TASK_0023S_PERSISTENT_LOCAL_PROFILE_CORE_TESTS_PASS
```

Register the new test in `tests/run_all.gd` without changing nine solver vectors.

Aggregate requirements:

```text
assertions > 621
vectors = 9
prior fourteen stable markers exactly once
TASK_0023S_PERSISTENT_LOCAL_PROFILE_CORE_TESTS_PASS exactly once
exit = 0
stderr = intentional LEVEL_ID_MISMATCH only
```

Task 0023R remains a mandatory standalone preflight and is not required to become an aggregate marker.

## 11. External evidence and production protection

Use only:

```text
D:\Delayed_Self_Evidence\0023S_persistent_local_profile_core_retry\
```

Record:

- startup/Git/toolchain;
- all Task 0023R preflight runs;
- AppRoot-instantiation source audits;
- focused/aggregate commands, stdout, stderr and exits;
- synthetic fixture paths, hashes, statuses and cleanup;
- retained or new Windows replacement probe identity;
- production existence/size/modified-time comparisons only;
- exact formal/catalog hashes;
- changed paths, rollback and final Git state.

Never read, hash, copy, rename, back up, delete, repair or reset the real production Profile. Do not list or clean unrelated pre-existing test-root contents.

## 12. Authorized repository paths

Product:

```text
scripts/app/local_profile.gd
scripts/app/memory_progress.gd
scripts/app/app_root.gd
```

Tests:

```text
tests/app/app_root_profile_test_fixture.gd
tests/app/task_0023s_persistent_local_profile_core.gd
tests/app/*.gd        # only existing AppRoot tests migrated to the single helper
tests/run_all.gd
```

Documentation:

```text
docs/reports/0023S_PERSISTENT_LOCAL_PROFILE_CORE_RETRY_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/production/COMPLETE_FLOW_PRODUCTION_CLOSURE_PLAN_CURRENT.md
```

Do not modify scenes, `project.godot`, formal data, catalog, Simulation, solver, schema, Gameplay, UI scripts/scenes, localization, fonts, assets, audio, licenses, export presets, README, release or submission surfaces.

## 13. Stop conditions

Stop immediately on:

- Task 0023R preflight failure or policy regression;
- any rejected/invalid test path reaching file/store construction;
- any test fallback to production path;
- any automated-test read/write/delete/hash/copy/rename/backup of the production Profile;
- production existence/size/modified-time change;
- inability to prove all AppRoot tests use the single fixture helper;
- I/O outside the exact production or accepted test paths;
- destructive/silent recovery or inability to preserve a known-good target;
- unsafe reset, schema/catalog/progression/finale drift;
- unexpected UI/scene/Simulation scope;
- parser/runtime/assertion error, unexpected stderr or fixture residue.

On a protected-data stop, roll back repository changes and do not delete or repair the production Profile.

## 14. Report, commit and terminal verdict

Create `docs/reports/0023S_PERSISTENT_LOCAL_PROFILE_CORE_RETRY_REPORT.md` describing architecture, interfaces, phase gates, schema, statuses, recovery/write table, source audit, tests, production protection, hashes, cleanup, rollback and non-claims.

Require one implementation commit:

```text
feat: add Delayed Self isolated persistent profile core
```

Push normally. Finish clean with `HEAD == origin/main`, divergence `0/0` and no Godot process.

Return exactly one:

```text
PERSISTENT_LOCAL_PROFILE_CORE_RETRY_READY_FOR_GPT_REVIEW
BLOCKED_PERSISTENT_LOCAL_PROFILE_CORE_RETRY
BLOCKED_PROFILE_ISOLATION_REGRESSION
```

Include commit SHA if produced, phase results, preflight counts, focused/aggregate counts, status/recovery/write results, AppRoot source-audit result, replacement probe identity, production metadata invariance, hashes, evidence root, cleanup and final Git state.

This task does not establish menu/settings/localization/font/asset/export/RC/release/submission readiness and does not authorize the next slice automatically.
