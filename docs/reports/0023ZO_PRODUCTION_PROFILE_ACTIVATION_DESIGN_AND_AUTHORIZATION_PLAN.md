# Task 0023ZO production Profile activation design and authorization plan

- Task: `tasks/0023ZO_production_profile_activation_design_and_authorization_gate.md`
- Planning base: `3c2cffb955965ee8fffcf86af2f6c37e71928da3`
- Required checkpoint: `72dc42448261b8847c224a903743d815cf9e6136`
- Prerequisite acceptance: `TASK_0023ZN_APP_ROOT_PROFILE_SESSION_FULL_MATRIX_ACCEPTED`
- Result: `PRODUCTION_PROFILE_ACTIVATION_DESIGN_READY_FOR_GPT_REVIEW`
- Product/runtime changes: none
- Production Profile content access: none
- Test-root access: none

## 1. Accepted architecture and frozen facts

The accepted Profile stack is:

```text
DelayedSelfProfileCodec
→ DelayedSelfLocalProfile
→ DelayedSelfProfileProgressAdapter
→ DelayedSelfMemoryProgress
→ DelayedSelfAppRoot
```

The canonical configured-session tests have accepted:

```text
schema v1
65,536-byte source bound
exact catalog/type/version validation
unknown-ID deterministic filtering
missing = clean memory with no mandatory write
malformed/unknown source preservation before clean recovery
recovery failure = writes disabled
unique temp + flush/close + readback + replace/rollback
prepare → persist → commit
NO_CHANGE = no persist and no adapter commit
sorted runtime snapshots
test-path isolation
configured load/hydrate order
18 stages / 42 cases / two complete clean-fixture passes
```

`scripts/app/app_root.gd` currently calls `boot_with_user_args()` from
`_ready()`. If `configure_test_profile()` was called before the node entered
the tree, `_boot_configured_test_profile()` configures the adapter and
test-only store, loads, then hydrates. Otherwise normal boot creates
`DelayedSelfMemoryProgress` and remains `MEMORY_ONLY_READY`.

`scripts/app/local_profile.gd` contains the fixed production constant
`user://delayed_self_profile.json`, but its only configuration entry point is
`configure_test()`, which rejects that production path. Production activation
therefore does not exist accidentally.

The main scene is currently `res://scenes/app/app_root.tscn`, whose root is
`DelayedSelfAppRoot`. There is no autoload, global store, second router, save
slot, account, cloud service, or migration service.

The formal product remains exactly eight levels. Sequence 8
`two_echo_convergence`, the final acknowledgement, Gameplay, Help, Timeline,
Level Select, catalog, Simulation, solver, schema and formal data remain
frozen.

The only permitted fact about the existing production Profile is the accepted
record:

```text
exists = true
Length = 473
LastWriteTimeUtc = 2026-07-19T08:15:02.2089459Z
```

This task did not refresh that metadata and did not access the file or the
test-root filesystem.

## 2. Activation-seam decision

### 2.1 Comparison

| Option | Assessment | Decision |
|---|---|---|
| A. AppRoot self-configures production during its own startup | Small source diff, but landing the code would make ordinary `_ready()` the production-I/O switch. It cannot cleanly separate code implementation, fixture validation, controlled read-only boot and final default activation. Direct-development launches could also touch player data before their route was classified. | Reject as the default activation owner. |
| B. Dedicated boot/composition object configures AppRoot before adding it to the tree | Extends the already accepted configure-before-tree seam. It can choose memory-only, guarded production-read-only or production-write-enabled mode before AppRoot `_ready()`, while AppRoot remains the only router. The current main scene can remain unchanged until the final activation task. | **Select.** |
| C. Project/autoload-level store ownership | Gives the store a broader lifetime than routes and tests require, risks hidden production access in test/development launches, introduces global mutable ownership and complicates teardown. | Reject. |

### 2.2 Selected composition contract

A future `DelayedSelfAppBootstrap` is a composition root, not a router:

```text
bootstrap enters tree
→ reads only command-line arguments and a frozen activation policy
→ classifies normal boot versus development-direct boot
→ instantiates AppRoot
→ calls exactly one pre-tree configuration method, or leaves memory-only
→ adds AppRoot as its child
→ AppRoot owns catalog load, Profile boot, routes and screens
```

The bootstrap must support exactly these internal policies:

```text
MEMORY_ONLY
PRODUCTION_READ_ONLY
PRODUCTION_WRITE_ON_INTENT
```

They are code/test policies, not a public settings menu.

- Implementation and fixture tasks leave the repository main scene pointing
  to the existing memory-only AppRoot.
- A separately authorized controlled read task directly invokes the accepted
  bootstrap in `PRODUCTION_READ_ONLY`.
- A separately authorized first-write task invokes
  `PRODUCTION_WRITE_ON_INTENT` with an exact task guard.
- Only the final default-activation task may change the normal main-scene
  composition to select `PRODUCTION_WRITE_ON_INTENT` for a no-argument product
  boot.

Any command-line development-direct request, invalid direct request, parser
smoke or test launch remains memory-only. Development-direct completion must
never be allowed to persist production progress. The bootstrap may reuse
`RouteRequest.parse_user_args()` for this classification, but must not create
a second navigation framework or consume the request instead of AppRoot.

## 3. Production store and AppRoot contract

### 3.1 Store configuration

`DelayedSelfLocalProfile` needs a separate one-time entry point such as:

```gdscript
configure_production(catalog_facts, access_policy)
```

It must:

- accept no caller-supplied path;
- internally bind only `PRODUCTION_PROFILE_PATH`;
- validate the same defensive catalog facts as `configure_test()`;
- reject reconfiguration and test/production mode switching;
- expose no production path in result snapshots;
- keep `reset_test_profile()` and `set_test_failure_seam()` test-only;
- use production-owned bounded sibling names distinct from all 0023W fixture
  sibling names;
- reject writes in `PRODUCTION_READ_ONLY`;
- retain the existing transactional and write-disable invariants in
  `PRODUCTION_WRITE_ON_INTENT`.

Internally, `_test_profile_path` should become a mode-neutral private target
field only if the refactor is fully covered. `validate_test_profile_path()`
must remain the sole caller-path validator and must continue rejecting the
production path.

### 3.2 AppRoot configuration

`DelayedSelfAppRoot` needs a separate pre-tree method such as:

```gdscript
configure_production_profile(access_policy)
```

It must be mutually exclusive with `configure_test_profile()`, immutable after
the first valid configuration, and rejected once the node is inside the tree
or boot has started.

The configured boot order remains:

```text
catalog load
→ adapter.configure(catalog)
→ store.configure_production(catalog_facts, policy)
→ store.load_profile()
→ adapter.load_profile(profile)
→ Main Menu or bounded Safe Error
```

Completion remains:

```text
adapter.prepare_completion()
→ NO_CHANGE: return success without store or adapter mutation
→ store.persist_profile(candidate)
→ adapter.commit_profile(candidate)
```

The existing test path continues through `configure_test_profile()`. Shared
private helpers may remove duplication, but test behavior, markers, failure
seams and canonical harnesses remain frozen.

Production errors use bounded allowlisted codes such as
`APP_PROFILE_BOOT_FAILED` and `APP_PROFILE_COMPLETION_FAILED`. They must not
contain a virtual/global path, bytes, JSON body, raw filesystem error,
recovery filename, store object or adapter object.

Public progress remains exactly:

```text
completed_level_ids
best_turns
unlocked_level_ids
```

A bounded session snapshot may expose only mode, write authorization state,
boot/load/persist status and the existing bounded progress snapshot.

## 4. Exact boot-state contract

| Production state | Read/load result | Runtime and route | Boot-time write |
|---|---|---|---|
| Missing | `MISSING_CLEAN` with canonical in-memory v1 default | Main Menu; first level unlocked from catalog-derived runtime | None. No target, directory or recovery sibling is created merely by booting. |
| Valid partial | `LOADED` | Validate, hydrate completed IDs/best turns, derive sorted unlocks, show Main Menu | None; target metadata must remain exact. |
| Valid completed | `LOADED` | Hydrate all accepted progress and permit normal replay; Continue/New Game UI remains later | None; target metadata must remain exact. |
| Valid but sanitizable | `SANITIZED_PENDING_RECOVERY` | Hydrate only normalized known progress; keep source unchanged and mark durable recovery required before a later target write | None during boot. |
| Malformed/truncated/unreadable/oversize in read-only policy | `RECOVERY_REQUIRED_READ_ONLY` | Bounded Safe Error; no clean-write continuation | None. |
| Malformed/truncated/unreadable/oversize in write-enabled normal policy | `RECOVERED_CLEAN` only after a bounded recovery copy succeeds | Clean in-memory profile and Main Menu with bounded recovery status | Recovery sibling only; target remains untouched until a later intentional persistent change. |
| Unsupported/unknown schema version in read-only policy | `UNSUPPORTED_VERSION_READ_ONLY` | Bounded Safe Error; no clean fallback is entered because recovery preservation is not authorized | None. |
| Unsupported/unknown schema version in write-enabled policy | `UNSUPPORTED_VERSION_PRESERVED` after recovery copy | Clean in-memory fallback and Main Menu with bounded status, but writes remain disabled for the process so an older build cannot replace newer data | Recovery sibling only; target remains untouched. |
| Recovery copy unavailable/collided/failed | `RECOVERY_FAILED` | Safe Error; Profile writes disabled for the process | No target write and no unrelated deletion. |

Unknown version must be distinguished from generic malformed structure before
normalization. This does not add a migration or accept another schema; it
creates only a bounded compatibility status.

Successful valid read-only boot never serializes normalized data back to the
target. A recovery copy is not a target rewrite, but it is still a
player-data write and therefore cannot occur in the controlled read-only gate.

## 5. Runtime persistence-failure contract

For an intentional completion:

1. `prepare_completion()` is pure.
2. `NO_CHANGE` records bounded status and performs no filesystem operation or
   adapter commit.
3. `CANDIDATE_READY` is the only state that may request persistence.
4. The first authorized live target write must first preserve a bounded durable
   activation-recovery copy when a target already exists.
5. Temp write, temp readback, replacement and post-replace verification retain
   the accepted transactional behavior.
6. Any persistence failure prevents `commit_profile()`.
7. Runtime progress remains at its pre-completion snapshot.
8. The known-good target is restored or remains intact.
9. AppRoot shows only the bounded Safe Error surface and the process disables
   further Profile writes when target integrity cannot be proven.

The durable first-write recovery copy is not a save slot and is not
automatically restored or deleted. Its later inspection, restoration or
removal requires another explicit player-data task.

## 6. First-read and first-write authorization matrix

| Stage | Reads production content | Can modify production data/metadata | Explicit user authorization | Code revert alone fully rolls back effects | Backup/recovery proof |
|---|---:|---:|---:|---:|---|
| Docs/design | No | No | No player-data authorization | Yes | Not applicable |
| Code + parser/static implementation with main scene still memory-only | No | No | No player-data authorization | Yes | Static proof only |
| Isolated fixed-fixture validation | No | Test fixture only | No production authorization | Yes after exact fixture cleanup | Fixture rollback/recovery tests |
| Controlled production read-only boot | **Yes, once** | No | **Yes, must explicitly authorize content read** | Code can revert; the fact of access cannot | Pre/post target metadata equality; no sibling creation |
| Conditional production recovery-copy operation | Yes | May create one bounded recovery sibling; target unchanged | **Yes, must explicitly authorize recovery write** | No | Exact pre/post metadata, bounded copy status, no content disclosure |
| Controlled first intentional write + NO_CHANGE | Yes | **Yes** | **Yes, must name the action and authorize target/recovery writes** | **No**; code rollback must leave player data alone | Durable first-write recovery proof, transaction proof, metadata before/after |
| Normal default activation | Yes on normal boot; writes only on intentional change/recovery | Yes | **Yes, separate final activation authorization** | Code can return to memory-only, but data is retained | Accepted controlled-read/write gates |
| Aggregate registration | No new authority | No production I/O in aggregate | Separate task | Yes | Aggregate must use isolated profiles only |

No general implementation task may silently include a controlled production
read or write.

## 7. Existing 473-byte Profile policy

The existing metadata is plausible but proves neither validity nor schema.
Until explicit authorization:

- do not open, parse, hash, copy, compare, rename, delete, reset, repair or
  back up the file;
- do not refresh its metadata from the filesystem;
- do not infer completed levels, settings, version or provenance;
- do not enumerate its parent directory or the test root.

The controlled read-only task must use only the production store code path in
`PRODUCTION_READ_ONLY`. It may retain only:

```text
bounded load classification
bounded boot/route result
bounded runtime progress keys/counts needed for the gate
target non-content metadata before/after
zero production sibling creation
zero raw content/path/error disclosure
```

If the result is malformed, unreadable, oversize or unsupported, the task
stops before recovery. A new recovery task must name the exact allowed
operation.

The controlled first-write action is:

> Through the normal Main Menu and Level Select, the owner completes the
> lowest-sequence currently unlocked level that is not already completed, and
> the adapter returns `CANDIDATE_READY`.

If no such level exists, or the prepared result is `NO_CHANGE`, the task
records `NO_ELIGIBLE_FIRST_WRITE_ACTION` or the NO_CHANGE proof and stops
without trying another action. It must not fabricate a probe field, worsen
progress, reset data or use a development-direct route.

For a valid existing target, first-write authorization includes exactly one
bounded activation-recovery copy before the first target replacement. For a
sanitized target, it includes the accepted recovery preservation before
replacement. The report records only bounded status and target metadata:

```text
before: exists / length / LastWriteTimeUtc
after candidate persist: exists / length / LastWriteTimeUtc
after equal-or-worse replay: identical metadata to the post-persist snapshot
prepare / persist / commit / route statuses
```

No content, content hash, JSON, best-turn value from disk, virtual/global path,
or recovery filename enters the report.

## 8. Implementation file/function map

| Likely path | Likely functions/surface | Planned responsibility |
|---|---|---|
| `scripts/app/app_bootstrap.gd` (new) | `_ready()`, `_select_boot_policy()`, `_is_development_launch()` | Composition only: choose mode, configure AppRoot before `add_child`, never route or persist. |
| `scenes/app/app_bootstrap.tscn` (new) | Bootstrap root only | Hosts one AppRoot instance; remains non-default until final activation. |
| `scripts/app/app_root.gd` | `configure_test_profile()`, new `configure_production_profile()`, `boot_with_user_args()`, configured boot helper, `_on_gameplay_completed()`, `_record_configured_completion()`, bounded session snapshot | Mutually exclusive pre-tree configuration; preserve load/hydrate and prepare/persist/commit ordering; production-safe errors/snapshots. |
| `scripts/app/local_profile.gd` | `configure_test()`, new `configure_production()`, `load_profile()`, `persist_profile()`, recovery/transaction helpers | Hard-code production target, enforce access policy, separate production sibling inventory, preserve first-write recovery, distinguish unsupported version, keep reset/failure seam test-only. |
| `scripts/app/profile_codec.gd` | `normalize_profile()` or a narrow version-classification helper | Distinguish unsupported schema without migration; keep v1 normalization/serialization frozen. |
| `scripts/app/profile_progress_adapter.gd` | `configure()`, `load_profile()`, `prepare_completion()`, `commit_profile()` | Expected unchanged; remains pure boundary and atomic runtime commit authority. |
| `scripts/app/memory_progress.gd` | `replace_profile_progress()`, `snapshot()`, `record_completion()` | Expected unchanged; remains sorted runtime authority. |
| `project.godot` | `run/main_scene` only | **Final default-activation task only**: point normal boot at the accepted bootstrap scene. |

No change is planned to Gameplay, Menu, Level Select, Safe Error scene
structure, catalog, formal data, Simulation, solver, schema, Help, Timeline,
localization, assets or export settings.

## 9. Focused fixture and evidence plan

### 9.1 Frozen accepted coverage

Keep Tasks 0023R–0023ZN frozen. In particular:

- 0023R test-path grammar and production-path rejection;
- 0023T codec behavior;
- 0023V one-time store configuration;
- 0023W filesystem, recovery, transaction, rollback and cleanup;
- 0023X adapter;
- 0023ZC AppRoot source ordering and bounded snapshot;
- 0023ZF diagnostic;
- 0023ZG/ZL/ZM harness ordering, capture and cardinality;
- 0023ZN two complete matrix executions.

Do not rewrite or retarget the canonical five-file harness, and do not rerun
the large full matrix after every implementation edit.

### 9.2 New narrow tests

New focused test-owned files should cover:

1. bootstrap/parser/compile contract with default main scene still memory-only;
2. mutual exclusion and pre-tree timing of test versus production
   configuration;
3. no caller-supplied production path and no path disclosure;
4. development-direct/invalid-user-argument launches choose memory-only;
5. production-read-only policy rejects every persist/recovery/reset path;
6. isolated fixture missing, valid partial, valid completed, sanitizable,
   malformed and unsupported-version states;
7. recovery-copy success/failure and collision exhaustion;
8. durable first-write recovery proof;
9. prepare → persist → commit and runtime rollback on every failure;
10. first candidate write followed by equal/worse `NO_CHANGE`;
11. process restart/fresh reload;
12. exact three-key public progress and bounded session disclosure;
13. exact task-owned fixture/sibling cleanup without directory enumeration.

All dynamic tests use only a new canonical test fixture. Production
configuration itself remains unexecuted until the explicit read-only task.

### 9.3 Production evidence sequence

The later production gates retain:

- exact command and guard;
- source/commit/frozen hashes;
- process before/after;
- target metadata before/after only;
- exact known production-owned sibling existence checks only when authorized;
- bounded stdout/stderr markers and native exit;
- worktree patch/sentinel;
- bounded boot/load/persist/commit/route/progress evidence;
- explicit proof that no test fixture or unrelated player data was touched.

They must not enumerate the player-data directory, test root or production
sibling directory.

## 10. Rollback and compatibility

### Code rollback

- Before default activation, remove/revert only the new bootstrap and
  production-mode code; the existing main scene remains memory-only.
- After default activation, a code rollback changes the main scene/policy back
  to memory-only.
- A code rollback never deletes, rewrites, renames, restores or cleans the
  production target or any recovery copy.
- Test fixture cleanup remains exact and task-owned.

### Schema compatibility

- v1 is the only supported schema.
- No v0/legacy import, slot migration, broad migration table or schema v2 is
  introduced.
- Malformed v1 may recover clean only after source preservation.
- An unsupported/newer version is preserved and makes the older process
  write-disabled even after a recovery copy; this prevents downgrade writes.
- Reading or restoring a recovery copy is not automatic and requires a later
  explicit task.

### Safe development disable

- Parser/static and fixture tasks leave `run/main_scene` unchanged.
- Tests instantiate AppRoot directly and use only `configure_test_profile()`.
- Development-direct launches select `MEMORY_ONLY` in the bootstrap.
- Disabling production activation changes code/composition policy only; it
  never changes player data.

## 11. Future task sequence

### Gate 1 — production-mode compile/static implementation, zero production I/O

- Authorized: `app_root.gd`, `local_profile.gd`, `profile_codec.gd`, new
  bootstrap script/scene, new parser/static tests, report/current docs.
- Forbidden: `project.godot`, production/test-root filesystem access, runtime
  production configuration, aggregate, Menu/settings/localization/export.
- Evidence: parser/compile/static order, mode isolation, hard-coded path,
  bounded errors/snapshots, zero product runtime I/O.
- Stop: any default main-scene change, caller-controlled production path,
  test-path weakening or source drift.
- Non-claim: no fixture behavior and no production activation.

### Gate 2 — isolated activation-policy fixture behavior

- Authorized: narrowly named activation source/test files and one new
  task-owned fixture runner/report.
- Forbidden: production configuration execution, existing canonical harness
  edits, test-root enumeration, aggregate.
- Evidence: all states and failure branches in Section 9, exact cleanup,
  frozen 0023R–0023ZN hashes.
- Stop: any production metadata change, fixture residue, path escape,
  prepare/persist/commit violation or disclosure.
- Non-claim: no production content read/write.

### Gate 3 — explicit-user-authorized controlled production read-only boot

- Authorized: no source changes; exact accepted build/guard, external evidence,
  one docs-only report/current update.
- Forbidden: copy, backup, recovery, target/sibling write, reset, retry,
  content disclosure and test-root access.
- Evidence: one production read classification, bounded runtime result, exact
  before/after metadata equality, zero known sibling creation.
- Stop: any write attempt, unsafe status, evidence gap or unexpected process.
- Non-claim: no recovery, first write or default activation.

### Gate 4 — conditional explicit recovery authorization

- Run only if Gate 3 reports recovery required.
- Authorized: one bounded production recovery-copy attempt through accepted
  code, exact known sibling checks and docs evidence.
- Forbidden: target replacement, reset, restore, inspection/disclosure,
  repeated copy attempts or unrelated cleanup.
- Evidence: target metadata unchanged, bounded recovery status, write-disabled
  proof on unsupported version/failure.
- Stop: copy failure/collision, target change, unknown file or disclosure.
- Non-claim: no persistent progress write or default activation.

### Gate 5 — explicit-user-authorized first intentional write and NO_CHANGE

- Prerequisites: accepted read gate; accepted recovery gate if required; an
  eligible normal-flow action.
- Authorized: exact single candidate completion, durable activation-recovery
  copy, one transactional persist/commit, then one equal-or-worse replay.
- Forbidden: reset, development-direct route, retries, fabricated probe data,
  settings/menu implementation, manual file operation.
- Evidence: before/post-write/post-NO_CHANGE metadata, bounded statuses,
  runtime atomicity, restart/fresh reload, recovery/transaction proof.
- Stop: `NO_ELIGIBLE_FIRST_WRITE_ACTION`, unexpected `NO_CHANGE` before first
  persist, failure, residue, disclosure or protected-state drift.
- Non-claim: no normal default activation.

### Gate 6 — final default-activation acceptance

- Authorized: accepted bootstrap/main-scene policy change, focused activation
  tests and one separately authorized normal production acceptance run.
- Forbidden: Profile reset/migration, menu/settings/localization, aggregate,
  export/build/release.
- Evidence: missing/valid/recovery policy, no-argument normal boot, direct
  development memory-only proof, restart, frozen hashes and player-data
  evidence.
- Stop: any unexpected write on valid/missing boot, unsafe older-build
  behavior, route regression or disclosure.
- Non-claim: no aggregate or complete product flow.

### Gate 7 — aggregate registration

- Authorized: test registration and aggregate marker only after Gates 1–6 are
  accepted.
- Forbidden: production Profile access, product behavior repair, harness
  retargeting.
- Evidence: isolated-profile aggregate, focused activation tests and all
  existing aggregate markers.
- Stop: production access, nondeterminism or unrelated regression.
- Non-claim: no menu/settings/export readiness.

### Gate 8 — Menu New/Continue/Reset and pause/quit confirmations

- Authorized only by a new product-flow task after activation acceptance.
- Reset requires its own destructive confirmation and player-data
  authorization sub-gate.
- Forbidden: settings/localization/build/release expansion.
- Evidence: clean/partial/completed menu states, confirmation/cancel behavior,
  route and final-acknowledgement preservation.
- Non-claim: no settings/localization/RC readiness.

## 12. Operations requiring explicit user authorization

The following remain closed until the user explicitly authorizes the exact
operation in a later task:

1. first opening/parsing of production Profile content;
2. any recovery, activation-backup or transaction sibling creation;
3. any target replacement or metadata/content change;
4. the named first intentional completion write;
5. normal default production activation;
6. reset, deletion, restore, rename, migration, cleanup or inspection of
   production player data;
7. access to or disclosure of recovery-copy content;
8. any build/export/RC/release/upload/submission operation.

Authorization to read does not authorize copying or writing. Authorization to
create a recovery copy does not authorize target replacement. Authorization
for one first-write attempt does not authorize retry, reset or default
activation.

## 13. Non-claims

This plan does not:

- read, validate or characterize the existing 473-byte Profile;
- implement or execute production configuration;
- enable default persistence;
- implement Continue/New Game/Reset, settings, localization or pause/quit
  confirmations;
- register aggregate coverage;
- prove save migration or multi-version compatibility;
- build, export, produce an RC, release, upload or submit the game.

GPT Project Sources retains final plan acceptance. Player-data read/write,
default activation and every irreversible action remain separately
user-authorized gates.
