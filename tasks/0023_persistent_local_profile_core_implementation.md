# Task 0023 — Implement the persistent local Profile core

- Status: `READY`
- Gate: `PROTECTED LOCAL PLAYER DATA / PROFILE CORE + ISOLATED TESTS`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Accepted plan: `docs/production/COMPLETE_FLOW_PRODUCTION_CLOSURE_PLAN_CURRENT.md`
- GPT acceptance: `docs/reports/0022_GPT_COMPLETE_FLOW_PRODUCTION_CLOSURE_PLAN_ACCEPTANCE.md`
- Expected acceptance checkpoint: `53fef0b6af0b6a8cb6b06a95e14961de2790799d`

## 1. Objective

Implement and integrate one versioned, local, test-isolated Profile core that persists completed level IDs, best turns, and the minimum future settings ownership under `user://`.

This slice must make normal AppRoot progress survive process restart while preserving the accepted eight-level catalog, unlock semantics, final acknowledgment, record-once behavior, and all existing product routes.

It does **not** implement New Game/Continue/Reset UI, pause, confirmations, Settings UI/application, localization, fonts, Credits, assets, icon/splash, audio, export, release, or submission.

## 2. Startup gate

Before edits or Godot runs:

- require root exactly `D:\Delayed_Self`;
- require branch `main`, expected SSH origin, clean tracked/untracked worktree;
- fetch and fast-forward only;
- require `HEAD == origin/main` and that HEAD contains `53fef0b6af0b6a8cb6b06a95e14961de2790799d`;
- verify Godot `4.7.stable.steam.5b4e0cb0f` or exact documented equivalent;
- require no residual Godot process.

Stop on divergence, conflict, wrong root/remote, unexpected files, or materially different toolchain.

Read in order:

1. `AGENTS.md`, current startup/active-task documents, and this task;
2. Task 0022 plan/report/GPT acceptance;
3. Task 0021/0021V/0021W implementation, acceptance, owner evidence, and adjudication;
4. catalog loader, AppRoot, MemoryProgress, Level Select, Safe Error, route, window/presentation, and testing contracts;
5. all current AppRoot/progress tests and aggregate registration;
6. generated-file and external-evidence rules.

Print a concise implementation, path-isolation, recovery, write-failure, regression, cleanup, rollback, and stop-condition plan before writing.

## 3. Frozen authorities

Preserve exactly:

- eight formal level JSON files, hashes, metrics, and schema-v1 behavior;
- eight-entry catalog hash/order/prerequisites and sequence 8 as sole final;
- Simulation, solver, canonical state, action/history/overlap/door/EXIT contracts;
- Task 0021 final acknowledgment and record-once behavior on successful writes;
- non-final automatic return and final retained-Gameplay acknowledgment;
- Level Select scrolling/focus, Safe Error, Help, Timeline, resize/letterbox, reduced-motion presentation semantics;
- owner-only review boundary and deferred sequence-9 scope.

No formal level, catalog, Simulation, solver, schema, Gameplay, Help, Timeline, scene, project setting, asset, audio, export, release, or submission change is allowed.

## 4. Architecture

Keep `DelayedSelfMemoryProgress` as the pure catalog-derived progress model with **no file I/O**. It may receive the minimum validated import/export methods needed by the adapter, but its existing public semantics must remain compatible:

```text
snapshot()
is_unlocked(level_id)
record_completion(level_id, turns)
```

Add one bounded adapter/store, preferably:

```text
scripts/app/local_profile.gd
class_name DelayedSelfLocalProfile
```

The adapter owns:

- fixed production path;
- Profile schema/defaults;
- bounded read/parse/validation;
- recovery preservation;
- transactional temp-write/replace;
- persistence/error status;
- the composed `MemoryProgress` instance;
- persisted progress and settings snapshots.

AppRoot must use the adapter instead of constructing `MemoryProgress` directly. Level Select and existing route code should continue to consume the same progress-facing interface rather than learning file-format details.

Do not introduce a service locator, autoload, resource database, multiple slots, cloud/account layer, or new navigation framework.

## 5. Fixed Profile contract

Production path:

```text
user://delayed_self_profile.json
```

Root written by v1:

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

- maximum accepted input size: `65536` bytes;
- root must be a Dictionary with schema version exactly `1` and Dictionary `progress`/`settings` containers;
- completed IDs are unique catalog-known strings;
- retained completion must be prerequisite-consistent with the validated catalog; iteratively discard completion entries whose prerequisite closure is absent;
- best turns are positive integers, catalog-known, and retained only for retained completed IDs;
- settings values are limited to language `en|zh-Hans`, window mode `windowed|fullscreen`, and Boolean reduced motion;
- invalid individual entries are deterministically sanitized to valid retained data/defaults and never invent progress;
- unlocks are always derived from the catalog and never serialized;
- no in-progress puzzle state, named slot, account/cloud data, ending-seen flag, timestamps, witness, or unbounded migration is added.

Canonical serialization must be deterministic: stable root shape, sorted completed IDs, and stable best-turn key order before `JSON.stringify`.

Slice 1 stores/defaults settings fields but adds no Settings UI and applies no language/window/reduced-motion change.

## 6. Load and recovery behavior

Return a structured load result/status; do not communicate important failure classes only through stderr.

### Missing file

- produce a clean v1 profile in memory;
- do not create the production file until the first intentional persistent change;
- status is a distinct clean/missing result, not corruption.

### Valid v1

- load and normalize it into `MemoryProgress` plus settings;
- no write occurs merely because the file was read.

### Salvageable v1

- sanitize invalid individual IDs/turns/settings deterministically;
- retain a structured `SANITIZED` status;
- do not silently destroy the original;
- before the first write that replaces the salvaged source, preserve one same-directory recovery copy.

### Malformed, truncated, unreadable, oversized, wrong-root, or unknown-version data

- never overwrite it silently;
- preserve it first as one collision-safe same-directory recovery copy, without exposing file contents or a real user path in product UI/log summaries;
- after successful preservation, activate a clean in-memory profile and return `RECOVERED_CLEAN`;
- if preservation cannot be completed, leave the original untouched, disable Profile writes, and return `RECOVERY_FAILED`.

AppRoot handling:

- `RECOVERED_CLEAN` must enter the existing bounded Safe Error/notice route once, then allow Main Menu with the clean active Profile;
- `RECOVERY_FAILED` must remain in a bounded Safe Error condition and must not enter Gameplay or overwrite the original; a retry may re-run load, but no bypass to writable gameplay is allowed;
- no raw JSON, full filesystem path, credential, username, or unrelated user data appears in UI diagnostics.

## 7. Transactional write contract

For each intentional persistent change:

1. build a candidate Profile snapshot without mutating the active committed model;
2. serialize deterministically;
3. write to a unique temp sibling in the same directory;
4. check `store_string`, call `flush`, explicitly close, and verify the temp file can be parsed back as the intended v1 snapshot;
5. replace the target using the pinned Godot 4.7 filesystem API;
6. only after successful replacement, commit the candidate as the active in-memory Profile;
7. on failure, leave the previous valid target and active Profile unchanged and remove only the temp file created by this attempt when safely identifiable.

Before relying on overwrite replacement, run and retain a native Windows probe proving that the pinned `DirAccess.rename_absolute`/chosen API replaces an existing writable destination as expected. Record exact command, toolchain, return codes, before/after hashes, and cleanup. Documentation alone is insufficient.

Provide a narrow deterministic test seam for replace failure; it must not permit production arbitrary-path or arbitrary-operation injection.

`record_completion` behavior:

- locked/unknown/invalid-turn rejection remains an ordinary progress rejection;
- successful new completion or better turn persists before becoming active;
- a valid completion that makes no persistent change may return success without rewriting;
- I/O/write failure is distinguishable from ordinary rejection through structured status;
- AppRoot routes to bounded Safe Error on Profile write failure rather than silently pretending progress was saved;
- development-direct locked final behavior remains the accepted non-recording final acknowledgment, not an I/O error.

No autosave loop or background thread is allowed.

## 8. Test isolation

Production path access from automated tests is forbidden.

Add a pre-tree test-only configuration seam that accepts only paths under:

```text
user://delayed_self_test_profiles/
```

Reject `res://`, absolute OS paths, path traversal, the production filename outside the test subtree, and configuration after the adapter/AppRoot has loaded.

Every existing test that instantiates AppRoot or the Profile adapter must use a unique test fixture directory. Update the minimum existing `tests/app/` files necessary so aggregate execution never boots an AppRoot against the production path.

Each fixture:

- records its exact test root;
- creates only files under that root;
- removes only its own files/directories;
- verifies no fixture residue after cleanup;
- captures production-profile existence/hash/size/modified-time metadata before and after without reading or altering its content, and proves no change.

Do not delete a pre-existing production Profile to make tests pass.

## 9. Required focused tests

Add:

```text
tests/app/task_0023_persistent_local_profile_core.gd
```

Cover at minimum:

1. missing-file clean state and no eager write;
2. first completion write, process/adapter reconstruction, unlock and best-turn persistence;
3. non-improving and improving best-turn behavior;
4. deterministic JSON shape/order;
5. duplicate/unknown/out-of-order/prerequisite-inconsistent completed IDs;
6. invalid best turns and invalid settings sanitation;
7. oversized, malformed, truncated, unreadable where reproducible, wrong-root, and unknown-version recovery;
8. collision-safe recovery-copy preservation and no raw-content/path disclosure;
9. recovery-preservation failure leaves original unchanged and write-disabled;
10. successful replacement over an existing target plus retained native Windows probe;
11. injected replace/write failure leaves known-good target and active model unchanged and cleans only owned temp;
12. unique temp names and no orphan after success/failure;
13. test-path allowlist/path-traversal rejection and production-profile metadata unchanged;
14. AppRoot restart persistence through normal non-final completion;
15. final record-once, acknowledgment, replay, and non-final routing remain exact after successful persistence;
16. locked development-direct final remains non-recording without false I/O error;
17. AppRoot Safe Error behavior for recovered-clean, recovery-failed, and write-failed statuses;
18. reset core primitive only in isolated tests, with no product Reset UI;
19. exact catalog/eight-level hashes and existing accepted metrics;
20. no Profile/settings value changes Simulation, canonical state, Help, Timeline, or presentation contracts.

Focused output must include exactly once:

```text
TASK_0023_PERSISTENT_LOCAL_PROFILE_CORE_FOCUSED_PASS
TASK_0023_PERSISTENT_LOCAL_PROFILE_CORE_TESTS_PASS
```

## 10. Aggregate regression

Register the new test in `tests/run_all.gd` without changing the existing nine solver vectors.

Final aggregate requirements:

```text
assertions > 621
vectors = 9
prior fourteen stable markers exactly once
TASK_0023_PERSISTENT_LOCAL_PROFILE_CORE_TESTS_PASS exactly once
exit = 0
stderr = intentional LEVEL_ID_MISMATCH only
```

Any parser/script/runtime/assertion/profile-I/O error, real production-profile touch, fixture residue, or unexpected stderr is failure.

## 11. External evidence

Use only:

```text
D:\Delayed_Self_Evidence\0023_persistent_local_profile_core\
```

Record:

- startup/Git/toolchain state;
- API documentation reference and pinned Windows replacement probe;
- focused and aggregate commands/stdout/stderr/exits;
- all fixture roots and cleanup results;
- input/output/recovery/temp hashes and sizes using synthetic test data only;
- structured status traces;
- production-profile metadata before/after without copying or exposing its contents;
- exact formal/catalog hash inventory;
- changed-path and generated-file audit;
- rollback and final Git state.

Do not stage test profiles, recovery copies, temp files, logs, captures, or evidence.

## 12. Authorized repository paths

Product:

```text
scripts/app/local_profile.gd
scripts/app/memory_progress.gd
scripts/app/app_root.gd
```

Tests:

```text
tests/app/task_0023_persistent_local_profile_core.gd
tests/app/*.gd              # only existing AppRoot tests requiring path isolation
 tests/run_all.gd
```

Documentation:

```text
docs/reports/0023_PERSISTENT_LOCAL_PROFILE_CORE_IMPLEMENTATION_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/production/COMPLETE_FLOW_PRODUCTION_CLOSURE_PLAN_CURRENT.md
```

Do not modify scenes, `project.godot`, catalog/formal data, Simulation, solver, schema, Gameplay, UI scripts/scenes, localization/font/asset/audio/license files, export presets, README, release, or submission surfaces.

If an essential change falls outside this list, stop and report the exact blocker instead of widening scope.

## 13. Report, Git, and rollback

Create `docs/reports/0023_PERSISTENT_LOCAL_PROFILE_CORE_IMPLEMENTATION_REPORT.md` with:

- architecture and exact public/status interfaces;
- production/test path contracts;
- schema and normalization rules;
- load/recovery/write state table;
- Windows replacement probe;
- focused/aggregate results;
- AppRoot integration/error behavior;
- hash and regression preservation;
- fixture/evidence inventory;
- cleanup, rollback, and non-claims.

Require one implementation commit:

```text
feat: add Delayed Self persistent local profile core
```

Push normally. Finish with clean worktree, `HEAD == origin/main`, divergence `0/0`, and no residual Godot process.

Rollback is one topic: restore AppRoot to direct MemoryProgress construction, remove the local Profile adapter, restore MemoryProgress/test integration changes, remove Task 0023 test/registration/report/current-document updates. Never delete or modify a real production Profile during rollback.

## 14. Stop conditions

Stop immediately on:

- any read/write/delete outside `user://` or the fixed/test-allowlisted paths;
- any automated-test access that can modify the production Profile;
- destructive or silent corruption recovery;
- inability to preserve the previous target on replace failure;
- inability to prove the pinned Windows replacement behavior;
- schema/catalog/progression/finale semantic drift;
- production path controlled by arbitrary command line or OS path;
- unsafe reset behavior;
- unexpected product/UI/simulation scope requirement;
- P0/P1 regression, parser/runtime error, unexpected stderr, or fixture residue.

## 15. Terminal verdict

Return exactly one:

```text
PERSISTENT_LOCAL_PROFILE_CORE_READY_FOR_GPT_REVIEW
BLOCKED_PERSISTENT_LOCAL_PROFILE_CORE
```

Include commit SHA if produced, changed paths, focused/aggregate counts, status/recovery/write results, Windows probe result, production-path isolation result, hashes, evidence root, cleanup, and final Git state.

This task does not establish menu/settings/localization/font/asset/export/RC/release/submission readiness and does not authorize the next slice automatically.
