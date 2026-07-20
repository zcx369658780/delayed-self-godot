# GPT acceptance — Task 0023ZP production Profile static bootstrap implementation

- Reviewed implementation commit: `afe8c6fffdc98992b732fce46f206ad0dc8553a1`
- Startup base: `27efe5df1227b059df8223419465a2691317638d`
- Prerequisite authority: `TASK_0023ZO_PRODUCTION_PROFILE_ACTIVATION_DESIGN_ACCEPTED`
- Verdict: `TASK_0023ZP_PRODUCTION_PROFILE_STATIC_BOOTSTRAP_ACCEPTED`
- Player-data authorization granted by this acceptance: **none**

## 1. Scope and repository adjudication

The reviewed commit is exactly one normal descendant of the Task 0023ZP startup base. Its changed paths are limited to the five authorized product paths, two focused test paths, the implementation report, and the seven authorized CURRENT documents.

No historical Profile adapter, MemoryProgress, RouteRequest, catalog/formal data, UI/gameplay scene, canonical matrix artifact, `project.godot`, export configuration, binary asset or unrelated path changed.

The implementation commit and report use the required terminal verdict and commit message. The repository main scene remains `res://scenes/app/app_root.tscn`; no autoload or global store was introduced.

## 2. Accepted implementation findings

### Bootstrap composition

`DelayedSelfAppBootstrap`:

- defaults to `MEMORY_ONLY`;
- allowlists exactly `MEMORY_ONLY`, `PRODUCTION_READ_ONLY`, and `PRODUCTION_WRITE_ON_INTENT`;
- classifies command-line user arguments before any production configuration call;
- forces valid development-direct and invalid direct requests to memory-only;
- instantiates exactly one AppRoot;
- configures a production policy before tree entry and adds AppRoot only after successful configuration;
- owns no route, catalog, store, persistence, recovery, reset or screen behavior.

The bootstrap scene exists but is not the project main scene.

### AppRoot production seam

AppRoot now exposes a separate immutable pre-tree production configuration surface that is mutually exclusive with test configuration. Configured boot preserves:

```text
catalog
→ adapter configuration
→ defensive catalog facts
→ mode-specific store configuration
→ load
→ hydrate
```

Configured completion preserves:

```text
prepare
→ NO_CHANGE short circuit
→ persist
→ commit
```

Production boot and completion errors are bounded. Public progress remains exactly the accepted three-key surface. The general session snapshot exposes only bounded mode, write authorization, status and progress facts.

### Store and schema behavior

The store:

- accepts no caller-supplied production path;
- binds only the private fixed production target internally;
- configures production mode without filesystem I/O;
- keeps test and production modes one-time and mutually exclusive;
- rejects read-only persistence before normalization or filesystem mutation;
- keeps reset and failure seams test-only;
- uses bounded production-owned sibling names distinct from the accepted test fixture names;
- keeps production sibling names and target paths out of production result dictionaries;
- retains NO_CHANGE-before-backup and activation-backup-before-replacement ordering.

The codec classifier is pure and distinguishes invalid root, invalid version, supported v1 and unsupported integer version without returning the raw value or unsupported number.

## 3. Validation evidence accepted

The Task 0023ZP report records:

- compile smoke: exit 0, empty stderr, pass marker once;
- static contract: 60 assertions, exit 0, empty stderr, pass marker once;
- all ten authorized 0023R/T/V/X/ZC/ZF zero-I/O regression processes: exit 0, empty stderr, required marker once;
- 361 frozen tracked-path hashes unchanged;
- unchanged `project.godot` hash and main-scene setting;
- zero residual Godot processes;
- clean final worktree and pushed implementation commit.

No post-validation source correction occurred, so the task's conditional second focused rerun was not required.

## 4. Protected-data adjudication

The task had zero player-data authority. The retained audit states that it did not:

- open, read, parse, hash, compare, copy, rename, back up, delete, reset, repair, write or refresh metadata for the production Profile;
- enumerate the production player-data directory;
- access or enumerate the test root or any fixture;
- invoke production configuration, load, persistence, recovery or reset at runtime;
- run Task 0023W, the canonical runner/full matrix, aggregate, project main scene, export or build.

This is consistent with the permitted static/compile scope.

## 5. Acceptance boundary and next gate

This acceptance establishes only that the production composition/API seam is source-, parser-, compile- and static-contract ready while normal product boot remains memory-only.

It does **not** establish:

- production-policy runtime behavior;
- missing/valid/sanitizable/malformed/unsupported Profile behavior;
- recovery-copy or activation-backup behavior;
- first-write or NO_CHANGE behavior;
- access to the existing production Profile;
- default activation;
- aggregate registration;
- Menu New/Continue/Reset;
- settings, localization, export, RC, release, upload or festival submission readiness.

The next authorized gate is an isolated production-policy behavior matrix using a process-local external APPDATA sandbox. It must prove the effective `user://` root is inside the exact sandbox before invoking any production policy and must never access the real production Profile, real user-data root or `user://delayed_self_test_profiles/`.

```text
TASK_0023ZP_PRODUCTION_PROFILE_STATIC_BOOTSTRAP_ACCEPTED
```
