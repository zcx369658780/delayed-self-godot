# Task 0023ZP — Implement the production Profile bootstrap/API surface without player-data I/O

- Status: `READY`
- Gate: `PROTECTED PLAYER DATA / PRODUCTION BOOTSTRAP STATIC IMPLEMENTATION + ZERO-I/O COMPILE CONTRACT`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- GPT prerequisite acceptance: `docs/reports/0023ZO_GPT_PRODUCTION_PROFILE_ACTIVATION_DESIGN_ACCEPTANCE.md`
- Required checkpoint: `9495043e6e54c5c2cfc0872c033747a2704b1cff`
- Implementation base: `d8fd787d978183836d703d7c0a0e9abfc5a3cb97`
- Production Profile path: `user://delayed_self_profile.json`
- Player-data authorization: **none**

## 1. Objective

Implement the accepted option-B composition and production-mode API surface while proving that merely landing the code does not activate or access production player data.

The completed source must provide:

```text
DelayedSelfAppBootstrap composition root
+ MEMORY_ONLY / PRODUCTION_READ_ONLY / PRODUCTION_WRITE_ON_INTENT policies
+ pre-tree AppRoot production configuration
+ hard-coded production-store configuration
+ unsupported-version classification
+ production-safe bounded status/error/snapshot surfaces
+ focused parser/compile/static contracts
```

The repository main scene must remain the existing memory-only AppRoot scene. This task performs no fixture behavior and no production Profile read or write.

## 2. Task acquisition and startup

There is no pre-fetch evidence requirement.

If this task file is absent locally, one normal `git fetch` is allowed. After the task is readable and before edits or validation:

1. require absolute root `D:\Delayed_Self`, branch `main`, expected origin and no Git operation in progress;
2. require a clean tracked/untracked worktree and no staged changes;
3. fetch and fast-forward only;
4. require `HEAD == origin/main` and ancestry of `9495043e6e54c5c2cfc0872c033747a2704b1cff`;
5. require ancestry of implementation base `d8fd787d978183836d703d7c0a0e9abfc5a3cb97`;
6. read the complete 0023ZO plan and GPT acceptance, 0023ZN acceptance, current production-closure plan, and current startup/active documents;
7. require zero residual Godot processes.

Stop on divergence, conflict, unexpected changes, missing checkpoint or process residue.

## 3. Absolute player-data boundary

This task has no authorization to inspect player data.

Do not:

- open, read, parse, hash, copy, rename, back up, delete, reset, repair, compare, write or refresh metadata for `user://delayed_self_profile.json`;
- enumerate or inspect the production player-data directory;
- access or enumerate `user://delayed_self_test_profiles/` or any fixture;
- invoke `configure_production()`, `configure_production_profile()`, a production bootstrap policy, `load_profile()` on a production-configured store, or any production persist/recovery/reset path at runtime;
- run the canonical runner, runner `Execute`, aggregate tests, `tests/run_all.gd`, project main scene, export or build;
- change `project.godot` or the current `run/main_scene`;
- create external evidence inside the repository.

Do not refresh the historical production metadata. It remains only the accepted record:

```text
exists = true
Length = 473
LastWriteTimeUtc = 2026-07-19T08:15:02.2089459Z
```

Any accidental player-data or test-root access is an immediate stop with no implementation commit.

## 4. Frozen authorities

Do not modify:

```text
scripts/app/profile_progress_adapter.gd
scripts/app/memory_progress.gd
scripts/app/route_request.gd
scripts/app/catalog_loader.gd
Gameplay / Help / Timeline / Level Select / Main Menu / Safe Error scripts and scenes
formal catalog and level data
Simulation / solver / schema / canonical state
all existing Tasks 0023R–0023ZN tests, diagnostics, manifests, parsers, runners and harnesses
project.godot
```

Tasks 0023R–0023ZN remain accepted historical authorities. Do not update their frozen hashes or retarget the canonical five-file matrix harness. Product-source changes in this new slice do not retroactively alter the accepted historical evidence.

## 5. Authorized implementation paths

Only these product paths may change:

```text
scripts/app/app_bootstrap.gd                         # new
scenes/app/app_bootstrap.tscn                        # new
scripts/app/app_root.gd
scripts/app/local_profile.gd
scripts/app/profile_codec.gd
```

Only these focused tests may be added:

```text
tests/app/task_0023zp_production_activation_compile_smoke.gd
tests/app/task_0023zp_production_activation_static_contract.gd
```

Authorized report/current documentation paths:

```text
docs/reports/0023ZP_PRODUCTION_PROFILE_STATIC_BOOTSTRAP_IMPLEMENTATION_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/production/COMPLETE_FLOW_PRODUCTION_CLOSURE_PLAN_CURRENT.md
```

Do not modify any other path.

## 6. Codec classification contract

Add one pure, zero-I/O schema-classification helper to `DelayedSelfProfileCodec`, equivalent to:

```gdscript
static func classify_profile_schema(raw_value: Variant) -> Dictionary:
```

It must distinguish bounded internal statuses:

```text
PROFILE_ROOT_INVALID
PROFILE_VERSION_INVALID
PROFILE_VERSION_SUPPORTED
PROFILE_VERSION_UNSUPPORTED
```

Requirements:

1. supported means exactly integer schema version 1;
2. unsupported means an integer version other than 1;
3. missing or non-integer version is invalid, not unsupported;
4. the helper performs no catalog normalization, serialization or I/O;
5. existing `normalize_profile()`, `serialize_profile()`, candidate construction and all Task 0023T outcomes remain unchanged;
6. public errors/snapshots must never disclose the unsupported numeric value or raw root.

## 7. Store configuration and policy contract

Refactor `DelayedSelfLocalProfile` only as needed to support mode-neutral private target ownership while preserving exact existing test behavior.

### 7.1 Modes and access policies

Define typed string constants equivalent to:

```text
MODE_TEST
MODE_PRODUCTION
ACCESS_READ_ONLY
ACCESS_WRITE_ON_INTENT
```

A store instance remains one-time configured. Test and production modes are mutually exclusive and cannot be switched.

### 7.2 Existing test configuration

`configure_test(catalog_facts, canonical_test_profile_path)` must preserve:

- Task 0023R canonical-path validation and production-path rejection;
- Task 0023V one-time configuration behavior and existing bounded test configuration snapshot;
- Task 0023W store, recovery, rollback, reset, failure-seam and exact sibling behavior;
- no semantic change to existing test statuses.

`reset_test_profile()` and `set_test_failure_seam()` must reject non-test mode before any filesystem operation.

### 7.3 Production configuration

Add a separate entry point equivalent to:

```gdscript
func configure_production(catalog_facts: Dictionary, access_policy: String) -> Dictionary:
```

It must:

1. accept no path argument;
2. bind only `PRODUCTION_PROFILE_PATH` internally;
3. accept only `ACCESS_READ_ONLY` or `ACCESS_WRITE_ON_INTENT`;
4. reuse the same defensive catalog-facts validation;
5. perform no `FileAccess`, `DirAccess`, globalize, existence check or other I/O during configuration;
6. reject late/repeated/mode-switch configuration;
7. return only bounded mode/policy/configured status, with no path or catalog facts;
8. keep the production target private;
9. define bounded production-owned temp/transaction/recovery/activation-backup sibling naming distinct from every `.delayed_self_0023w_*` fixture name;
10. expose no sibling name through public result dictionaries.

### 7.4 Read/write policy in source

The source must enforce, without executing it in this task:

- `PRODUCTION_READ_ONLY` may load but rejects persist, recovery-copy, activation-backup and reset before filesystem mutation;
- malformed/oversize/unreadable read-only load returns a bounded recovery-required status and does not call a recovery-copy helper;
- unsupported read-only load returns a distinct bounded unsupported-version status and does not write;
- `PRODUCTION_WRITE_ON_INTENT` retains accepted transactional replacement and process write-disable behavior;
- unsupported/newer data may be preserved only through the later authorized recovery path and keeps the older process write-disabled;
- an existing valid target marks one bounded durable activation-backup as required before its first target replacement;
- a missing target requires no activation backup;
- `NO_CHANGE` occurs before backup/transaction and performs no filesystem operation;
- no recovery or activation backup is automatically deleted or restored.

## 8. AppRoot production configuration contract

Add bounded mode/policy state and a separate pre-tree API equivalent to:

```gdscript
func configure_production_profile(access_policy: String) -> Dictionary:
```

Requirements:

1. mutually exclusive with `configure_test_profile()`;
2. immutable after the first valid configuration;
3. rejected inside the tree or after boot starts;
4. no production path argument or path disclosure;
5. configuration itself performs no player-data I/O;
6. existing memory-only and test configuration results remain compatible with accepted tests;
7. configured boot preserves adapter → catalog facts → store → load → hydrate ordering;
8. test mode continues calling `configure_test()` and production mode calls `configure_production()`;
9. production boot statuses are bounded and use production-safe error codes such as `APP_PROFILE_BOOT_FAILED`, not test wording;
10. completion in either configured mode preserves prepare → persist → commit and `NO_CHANGE` ordering;
11. production completion failure uses bounded `APP_PROFILE_COMPLETION_FAILED` without path/content/raw-error disclosure;
12. memory-only completion behavior remains unchanged;
13. `get_progress_snapshot()` remains exactly the three accepted keys;
14. add a bounded general Profile-session snapshot only if needed, while preserving `get_test_profile_session_snapshot()` compatibility for existing tests;
15. `set_test_profile_failure_seam()` remains unavailable outside test mode.

Do not enable production configuration from ordinary AppRoot `_ready()`.

## 9. Bootstrap composition contract

Create `DelayedSelfAppBootstrap` as a composition root, not a router.

It must:

1. default to `MEMORY_ONLY`;
2. support exactly the three accepted policies;
3. expose at most one immutable pre-tree configuration method for focused future gates;
4. parse/classify user arguments before any production configuration call;
5. force direct-level and invalid direct-level launches to memory-only;
6. instantiate exactly one AppRoot;
7. for a normal boot, call at most one AppRoot production configuration method before `add_child()` when the selected policy is production;
8. add AppRoot only after configuration succeeds; internal configuration failure is bounded and fail-closed;
9. never route, load a catalog, persist, recover, reset or own screens;
10. expose only bounded composition status with no path/content/store/adapter disclosure.

Create `scenes/app/app_bootstrap.tscn` with the bootstrap script and memory-only default. It must not become the project main scene in this task.

## 10. Focused compile/static tests

### 10.1 Compile smoke

`task_0023zp_production_activation_compile_smoke.gd` may only:

- preload/load the five authorized product artifacts;
- load the bootstrap scene as a resource;
- instantiate scripts or nodes without adding Bootstrap/AppRoot to the tree;
- call pure codec classification and memory-only/pre-tree validation helpers that perform no I/O;
- verify the current project main-scene path remains `res://scenes/app/app_root.tscn` by repository/project configuration inspection;
- emit one bounded pass marker.

It must not call any production configure/load/persist/recovery/reset method.

### 10.2 Static contract validator

`task_0023zp_production_activation_static_contract.gd` must read only authorized repository source/scene/project files and prove at minimum:

1. bootstrap class/scene exist and are not the main scene;
2. `project.godot` remains byte-identical to the implementation baseline;
3. no autoload/global store is introduced;
4. bootstrap default is memory-only;
5. argument classification precedes production configuration and AppRoot tree entry;
6. direct/invalid development launches select memory-only;
7. production configure APIs accept policy but no path;
8. production path is hard-coded only in the store;
9. production configuration blocks contain no I/O;
10. test/production modes and policies are allowlisted and immutable;
11. read-only rejection occurs before persist/recovery/reset mutation paths;
12. unsupported schema classification is distinct and pure;
13. test reset/failure seams are mode-gated;
14. AppRoot configured boot and prepare/persist/commit ordering remain intact;
15. public progress remains exactly three keys;
16. errors/snapshots contain no production path, content, JSON, raw filesystem errors, sibling names, store or adapter objects;
17. adapter, MemoryProgress, RouteRequest, catalog/formal data, scenes outside the new bootstrap scene, and all historical harness/test artifacts remain frozen;
18. no source path outside the authorization list changed.

Print a deterministic assertion count and exactly one pass marker.

## 11. Authorized validation

Only the following fresh-process validation is allowed:

```text
new Task 0023ZP compile smoke
new Task 0023ZP static contract validator
Task 0023R path-policy test (zero I/O)
Task 0023T codec compile + pure codec test
Task 0023V store-instance compile/configuration test (configuration only)
Task 0023X adapter compile + pure adapter test
Task 0023ZC parser + zero-I/O compile contract
Task 0023ZF parser only
```

Requirements:

- native expected exit code;
- empty stderr;
- each required marker exactly once;
- zero Godot processes before/after;
- no project main-scene run;
- no 0023W filesystem test, canonical full matrix, runner, fixture or aggregate;
- command audit shows zero calls to production configuration/load/persist/recovery/reset and zero player-data/test-root filesystem commands;
- production metadata is not refreshed or checked.

Run the new compile/static tests once before final documentation and once from the final source state if any source correction occurred. Record corrections honestly.

## 12. Evidence and safety audit

Use only:

```text
D:\Delayed_Self_Evidence\0023ZP_production_profile_static_bootstrap\
```

Retain:

- startup Git facts;
- baseline and final changed-path lists;
- baseline/final hashes for all frozen files;
- parser/compile/static stdout/stderr/exit/process facts;
- command audit;
- `project.godot` and main-scene unchanged proof;
- no-autoload proof;
- no production configuration invocation proof;
- no player-data/test-root command proof;
- final worktree/divergence/process facts.

External evidence must not enter Git.

## 13. Stop conditions

Stop without implementation commit on any:

- production Profile or test-root access;
- production configuration/runtime invocation;
- `project.godot` or main-scene change;
- autoload/global store introduction;
- caller-controlled production path;
- test-path validation weakening;
- existing test semantic regression;
- hidden path/content/error disclosure;
- unauthorized changed path;
- parser/compile/static failure unresolved within the authorized paths;
- fixture, aggregate, runner, export or build execution.

Do not repair unrelated product behavior.

## 14. Repository output

Create:

```text
docs/reports/0023ZP_PRODUCTION_PROFILE_STATIC_BOOTSTRAP_IMPLEMENTATION_REPORT.md
```

The report must include exact changed paths, source/API decisions, compile/static assertions, all zero-I/O regression results, command audit, frozen hashes, main-scene proof, explicit player-data non-access statement and non-claims.

Commit authorized paths only with:

```text
feat: add Delayed Self production profile bootstrap seam
```

Push normally after `git diff --cached --check`, remote-drift check and clean final audit.

## 15. Terminal verdict and non-claims

Return exactly one:

```text
PRODUCTION_PROFILE_STATIC_BOOTSTRAP_READY_FOR_GPT_REVIEW
BLOCKED_PRODUCTION_PROFILE_STATIC_BOOTSTRAP
```

A passing verdict establishes only source/compile/static readiness with zero player-data I/O. It does not establish fixture behavior, production read, recovery, first write, default activation, aggregate registration, Menu flow, settings/localization, build/export, release, upload or submission readiness.
