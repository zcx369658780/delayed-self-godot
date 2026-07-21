# Task 0023ZT — Construct and qualify an inert controlled production read-only observation harness

- Status: `READY`
- Gate: `PROTECTED PLAYER DATA / CONTROLLED PRODUCTION READ-ONLY HARNESS CONSTRUCTION + ZERO REAL-DATA I/O`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- GPT prerequisite acceptance: `docs/reports/0023ZS_GPT_ISOLATED_PRODUCTION_POLICY_MATRIX_ACCEPTANCE.md`
- Required checkpoint: `7739ac26420e4c006b8fc6eba0f6b01a9d641ea1`
- Accepted implementation under future observation: `afe8c6fffdc98992b732fce46f206ad0dc8553a1`
- Real production Profile content authority: **none in this task**
- Real production Profile metadata/sibling authority: **none in this task**
- Test-root authority: **none**
- Future execution task reserved: `0023ZU`

## 1. Objective

Construct, statically validate and no-guard qualify a dedicated harness for a future owner-authorized **single controlled production read-only observation**.

Task 0023ZT must establish only that the future harness is:

```text
guarded twice
+ fail-closed before ordinary user-data discovery
+ production-read-only only
+ bounded in retained output
+ incapable of recovery, target write, reset or test-fixture use
+ prepared to compare exact non-content metadata and exact owned-sibling existence before/after
+ inert until a separately authorized Task 0023ZU
```

This task must not execute a guard-passing production read, refresh the historical Profile metadata, inspect the ordinary user-data directory, probe any production sibling, or create the future execution evidence root.

## 2. Startup and authority checks

Before edits or validation:

1. require absolute root `D:\Delayed_Self`, branch `main`, expected origin and no Git operation in progress;
2. require a clean tracked/untracked worktree and no staged changes;
3. fetch and fast-forward only;
4. require `HEAD == origin/main` and ancestry of checkpoint `7739ac26420e4c006b8fc6eba0f6b01a9d641ea1`;
5. require ancestry of accepted implementation `afe8c6fffdc98992b732fce46f206ad0dc8553a1`;
6. read the complete 0023ZO activation plan, 0023ZP acceptance, 0023ZS task/report/GPT acceptance, current production-closure plan and all CURRENT authority documents;
7. require zero residual Godot processes;
8. freeze hashes for all product source/scenes, project settings, catalog/formal data, historical tests/harnesses and the five accepted 0023ZQ/ZS harness artifacts.

Stop on divergence, dirty state, missing checkpoint, unexpected process residue or any instruction to access real player data.

## 3. Absolute protected-data boundary

### 3.1 Forbidden in Task 0023ZT

Do not open, read, parse, hash, compare, copy, rename, back up, delete, reset, repair, write, stat, refresh metadata for, or probe:

```text
user://delayed_self_profile.json
```

when `user://` resolves to the ordinary project user-data directory.

Do not query, globalize, print, inspect or enumerate:

- the ordinary user-data directory;
- the production Profile parent;
- any production-owned temp, transaction, recovery or activation-backup sibling;
- `user://delayed_self_test_profiles/`;
- any historical fixture;
- any external APPDATA sandbox from Tasks 0023ZQ–0023ZS.

Do not refresh the historical accepted metadata record. It remains only:

```text
exists = true
Length = 473
LastWriteTimeUtc = 2026-07-19T08:15:02.2089459Z
```

The task may quote this frozen record in documentation but must not verify it from the filesystem.

### 3.2 No guard-passing execution

The future observation harness must never run with its exact authorization guards during Task 0023ZT.

Counts for this task must remain:

```text
future guard-passing harness runs = 0
production configuration runtime calls = 0
production Profile content reads = 0
production metadata reads = 0
production sibling probes = 0
production writes/recovery/reset = 0
test-root operations = 0
```

Any accidental real-data or ordinary-user-data contact is an immediate stop with no implementation commit.

## 4. Frozen product and accepted harness authorities

Do not modify:

```text
scripts/app/app_bootstrap.gd
scenes/app/app_bootstrap.tscn
scripts/app/app_root.gd
scripts/app/local_profile.gd
scripts/app/profile_codec.gd
scripts/app/profile_progress_adapter.gd
scripts/app/memory_progress.gd
scripts/app/route_request.gd
project.godot
```

Also freeze:

- all UI/gameplay scenes and scripts;
- catalog/formal data, Simulation, solver and schema;
- all historical tasks/tests/manifests/runners;
- all five accepted 0023ZQ/ZS harness artifacts;
- the 0023ZS report and GPT acceptance.

The current main scene must remain `res://scenes/app/app_root.tscn`; no autoload/global store may be introduced.

## 5. Authorized repository paths

Only these new harness artifacts may be added:

```text
tests/app/task_0023zt_controlled_production_read_only_observation.gd
tests/app/task_0023zt_controlled_production_read_only_parser_smoke.gd
tests/app/task_0023zt_controlled_production_read_only_validator.gd
tests/app/task_0023zt_controlled_production_read_only_manifest.json
tests/app/task_0023zt_capture_controlled_production_read_only.ps1
```

Authorized report/current documentation paths:

```text
docs/reports/0023ZT_CONTROLLED_PRODUCTION_READ_ONLY_HARNESS_CONSTRUCTION_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/production/COMPLETE_FLOW_PRODUCTION_CLOSURE_PLAN_CURRENT.md
```

Do not modify any other repository path.

## 6. Future Task 0023ZU execution contract

Task 0023ZT constructs the contract below but does not activate it.

### 6.1 Exact dual authorization

The PowerShell runner must require an exact parameter equivalent to:

```text
-OwnerAuthorization TASK_0023ZU_OWNER_AUTHORIZED_PRODUCTION_READ_ONLY
```

The child Godot process must independently require exact environment value:

```text
DELAYED_SELF_0023ZU_PRODUCTION_READ_AUTHORIZATION=TASK_0023ZU_OWNER_AUTHORIZED_PRODUCTION_READ_ONLY
```

It must also require an exact engine/user argument:

```text
--task-0023zu-controlled-production-read-only
```

The GDScript harness must check both child guards before:

- `OS.get_user_data_dir()`;
- `ProjectSettings.globalize_path()` for a `user://` target;
- `FileAccess` or `DirAccess`;
- AppRoot/Bootstrap instantiation;
- production configuration;
- any output marker other than a bounded guard-blocked marker.

Any missing or mismatched guard must emit exactly one bounded blocked marker and exit 2.

### 6.2 Active-task authority check

The runner must fail closed unless `docs/CODEX_ACTIVE_TASK_CURRENT.md` identifies Task `0023ZU` as the active task and contains an exact future execution status chosen by the manifest/static validator.

Task 0023ZT itself must leave 0023ZU inactive. The no-authorization runner proof must therefore stop before any user-data discovery or evidence-root creation.

### 6.3 Exact future evidence root

Reserve only:

```text
D:\Delayed_Self_Evidence\0023ZU_controlled_production_read_only\
```

Task 0023ZT must not create, inspect or enumerate that root.

A future Task 0023ZU may create it only after explicit owner authorization and must use it only for bounded stdout/stderr/audit evidence. It must not copy Profile content into evidence.

## 7. Future observation behavior

### 7.1 One production read-only boot only

The guard-passing future harness must perform exactly one Godot process using the accepted production composition path in `PRODUCTION_READ_ONLY`.

It must not:

- use an APPDATA/LOCALAPPDATA override;
- call `configure_test()`, `configure_test_profile()` or any test-root helper;
- use `PRODUCTION_WRITE_ON_INTENT`;
- call persist, recovery, reset or a failure seam;
- run the project main scene;
- perform a second read/boot attempt after any outcome;
- repair malformed/unsupported data;
- create or delete any Profile/sibling file.

The runner may perform only the exact pre/post non-content metadata and exact-known-owned-sibling existence checks defined below.

### 7.2 Allowed future target observations

A future explicitly authorized 0023ZU execution may retain only:

```text
target_exists_before / target_exists_after
length_before / length_after when target exists
last_write_time_utc_before / last_write_time_utc_after when target exists
bounded load_status
bounded boot_status
bounded route
completed_count
best_turn_count
unlocked_count
exact public progress key count
exact owned sibling existence counts before / after
native exit
stderr byte count
bounded marker counts
```

It must not retain:

- raw Profile bytes or JSON;
- a content hash;
- completed level IDs;
- best-turn values;
- settings values;
- unsupported numeric version;
- ordinary absolute user-data or Profile paths;
- sibling filenames;
- raw filesystem errors;
- store/adapter objects.

### 7.3 Allowed status/route matrix

The manifest must freeze these bounded outcomes:

| Load classification | Boot/route expectation |
|---|---|
| `MISSING_CLEAN` | `PRODUCTION_PROFILE_READY` / `MAIN_MENU` |
| `LOADED` | `PRODUCTION_PROFILE_READY` / `MAIN_MENU` |
| `SANITIZED_PENDING_RECOVERY` | `PRODUCTION_PROFILE_READY` / `MAIN_MENU` |
| `RECOVERY_REQUIRED_READ_ONLY` | failed bounded production boot / `SAFE_ERROR` |
| `UNSUPPORTED_VERSION_READ_ONLY` | failed bounded production boot / `SAFE_ERROR` |

The future harness must accept only one of these classifications. Any other status is a bounded failure and no retry is allowed.

### 7.4 Exact no-write proof

The future runner must compare the target's non-content metadata before and after the one Godot process.

It must also check only the exact production-owned sibling candidates implied by the accepted store source, with bounded indices `0..7` and categories:

```text
recovery
activation_backup
temp
transaction
```

Requirements:

1. direct exact-path existence checks only;
2. no parent-directory enumeration;
3. no wildcard/glob search;
4. no sibling name in retained output;
5. record only total pre/post existence count by category;
6. require every category count unchanged;
7. require target exists/length/time unchanged when the target existed before;
8. require no target creation when missing before;
9. no cleanup, deletion or restoration of any real file.

If any metadata or sibling state changes, the future execution must stop as a protected-data incident and preserve only bounded evidence. It must not attempt rollback.

## 8. Harness architecture

### 8.1 Observation GDScript

`task_0023zt_controlled_production_read_only_observation.gd` must:

- extend `SceneTree`;
- check both exact child guards first;
- emit one guard-blocked marker and exit 2 on mismatch;
- perform no pre-guard `user://`, OS user-data, filesystem, Profile or scene operation;
- instantiate the dedicated bootstrap or AppRoot directly only after guards pass;
- configure exactly `PRODUCTION_READ_ONLY` before tree entry;
- add exactly one AppRoot/composition root;
- await only a bounded deterministic frame count;
- read only bounded session/progress/route snapshots;
- emit no raw content/path/settings/IDs/errors;
- exit once after one observation;
- never call persist/recovery/reset/test seams.

### 8.2 PowerShell runner

`task_0023zt_capture_controlled_production_read_only.ps1` must:

- use `System.Diagnostics.ProcessStartInfo.FileName` and one `ArgumentList` entry per argument;
- require the exact owner authorization parameter;
- verify the exact 0023ZU active-task authority before execution;
- add the exact child environment guard only to the child process;
- pass the exact engine/user guard argument;
- perform bounded direct metadata checks only after all runner guards pass;
- avoid another shell, flattened commands and persistent environment mutation;
- never print or retain the Godot executable path or ordinary data path;
- run at most one guard-passing Godot process;
- fail closed on non-zero exit, stderr, unexpected status, metadata drift, sibling drift, disclosure or process residue;
- never repair or clean real player data.

### 8.3 Manifest

The manifest must declare:

- schema version;
- future task ID `0023ZU`;
- exact three guards;
- one-process execution maximum;
- allowed statuses/routes;
- allowed retained fields;
- forbidden disclosure categories;
- exact sibling categories and index bound;
- required evidence files;
- exact deterministic marker cardinalities;
- frozen hashes for product/project and accepted 0023ZQ/ZS harness files.

### 8.4 Parser smoke and static validator

The parser smoke may only preload/parse the five new 0023ZT harness artifacts and accepted product scripts. It must not run the observation or runner.

The validator must prove at minimum:

1. all five new artifacts exist;
2. product/project/historical hashes are frozen;
3. main scene/autoload remain unchanged;
4. exact future task, owner parameter, child environment guard and engine argument are present;
5. all three guards precede ordinary user-data discovery and any filesystem/Profile/configuration/scene operation;
6. guard failure is one marker plus exit 2;
7. the runner checks exact future CURRENT authority;
8. runner uses `ProcessStartInfo.FileName` and separate `ArgumentList` entries;
9. no APPDATA/LOCALAPPDATA override exists in the future real-read runner;
10. production policy is exactly read-only;
11. no write-on-intent, persist, recovery, reset, failure seam or test-root API is referenced by executable behavior;
12. exactly one guard-passing process is possible;
13. retained fields are allowlisted and raw content/IDs/settings/paths/hashes are forbidden;
14. direct exact sibling checks cover four categories × eight indices without enumeration/glob;
15. target metadata and sibling counts require exact pre/post equality;
16. no cleanup/delete/restore action exists;
17. allowed status/route matrix is exact;
18. no retry after any guard-passing outcome;
19. future evidence root is fixed but not created by parser/validator/no-guard paths;
20. deterministic assertion count and pass marker are emitted.

## 9. Authorized validation in Task 0023ZT

Only the following fresh-process validation is authorized:

```text
new 0023ZT parser smoke
new 0023ZT static validator
0023ZP compile smoke
0023ZP static contract
0023ZS parser smoke
0023ZS static validator
0023R path policy
0023T codec compile + pure codec
0023V store configuration compile + pure configuration
0023X adapter compile + pure adapter
0023ZC parser + zero-I/O compile contract
0023ZF parser only
```

All must exit natively with expected code, empty stderr, required markers once and zero residual Godot processes.

### 9.1 GDScript no-guard proof

Run the new observation GDScript exactly once without either future authorization guard:

- native exit 2;
- guard-blocked marker exactly once;
- no user-data-discovered, metadata, sibling, configuration, behavior or observation marker;
- stderr empty;
- no future evidence root creation;
- zero Godot processes afterward.

### 9.2 Runner no-authorization proof

Invoke the new PowerShell runner exactly once without the owner authorization parameter/value:

- fail before CURRENT/user-data/metadata/sibling/Godot behavior work beyond reading repository authority needed to reject;
- no Godot process starts;
- no future evidence root is created;
- no ordinary user-data path is queried or printed;
- bounded rejection only.

Do not run the runner with valid future authorization values. Do not temporarily edit CURRENT to mimic 0023ZU.

Do not run Task 0023W, any fixture, the 0023ZN or 0023ZS full matrix, aggregate, `tests/run_all.gd`, project main scene, export or build.

## 10. Evidence and safety audit

Use only:

```text
D:\Delayed_Self_Evidence\0023ZT_controlled_production_read_only_harness_construction\
```

This construction evidence root may contain only:

- startup/final Git facts;
- changed-path and frozen-hash audits;
- parser/static/regression stdout/stderr/exit facts;
- GDScript no-guard proof;
- runner no-authorization proof;
- source/static disclosure scans;
- command audit proving zero real-data contact;
- final clean/process facts.

It must not contain ordinary user-data paths, production metadata, Profile content or production sibling observations.

## 11. Stop conditions

Stop without implementation commit on any:

- production Profile content, metadata, parent or sibling access;
- ordinary user-data directory query outside the guarded script's unexecuted source text;
- test-root or historical fixture access;
- valid future guard-passing execution;
- future evidence-root creation;
- product/project/historical harness change;
- APPDATA override in the future real-read runner;
- weak/single guard;
- retained raw content, IDs, settings, hash, paths or raw errors;
- directory enumeration, wildcard sibling search or cleanup action;
- write-on-intent/persist/recovery/reset behavior;
- unexpected dirty path;
- residual Godot process;
- remote divergence.

Do not repair unrelated behavior.

## 12. Repository output

Create:

```text
docs/reports/0023ZT_CONTROLLED_PRODUCTION_READ_ONLY_HARNESS_CONSTRUCTION_REPORT.md
```

The report must include:

- exact changed paths;
- future dual/triple guard design;
- retained-field and forbidden-disclosure inventories;
- exact status/route matrix;
- direct sibling-check cardinality and no-enumeration proof;
- parser/static assertion results;
- all zero-I/O regression results;
- both no-authorization proofs;
- frozen hashes and main-scene/autoload proof;
- command audit proving zero production data/metadata/sibling/test-root contact;
- explicit statement that Task 0023ZU requires separate owner authorization.

Commit authorized paths only with:

```text
test: construct Delayed Self controlled production read-only harness
```

Push normally after remote-drift, staged-path, diff-check, process and zero-I/O audits.

## 13. Terminal verdict and non-claims

Return exactly one:

```text
CONTROLLED_PRODUCTION_READ_ONLY_HARNESS_READY_FOR_GPT_REVIEW
BLOCKED_CONTROLLED_PRODUCTION_READ_ONLY_HARNESS
```

A passing result establishes only an inert, statically qualified harness. It does not authorize or establish any real Profile access, metadata refresh, sibling probe, recovery, write, default activation, aggregate registration, Menu flow, settings/localization, build/export, RC, release, upload or festival submission.
