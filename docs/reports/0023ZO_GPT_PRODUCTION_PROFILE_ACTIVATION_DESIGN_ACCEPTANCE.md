# Task 0023ZO GPT production Profile activation-design acceptance

- Reviewed planning commit: `d8fd787d978183836d703d7c0a0e9abfc5a3cb97`
- Verdict: `TASK_0023ZO_PRODUCTION_PROFILE_ACTIVATION_DESIGN_ACCEPTED`
- Accepted scope: production activation composition decision, boot/read/write contracts, player-data authorization boundaries, rollback policy, and future gate decomposition
- Product source or runtime production activation: not accepted or authorized by this report

## 1. Accepted composition decision

Task 0023ZO selects option B: a dedicated `DelayedSelfAppBootstrap` composition root configures `DelayedSelfAppRoot` before adding it to the tree.

The accepted ownership model is:

```text
bootstrap chooses a bounded boot policy
→ bootstrap instantiates AppRoot
→ bootstrap optionally configures AppRoot before tree entry
→ bootstrap adds AppRoot as its only composed application child
→ AppRoot remains the sole catalog, Profile, route and screen owner
```

This extends the already accepted configure-before-tree seam. It does not create a second router, autoload/global store, slot manager, account service, cloud service or migration service.

Option A is rejected as the default owner because placing production configuration directly in ordinary AppRoot `_ready()` would make landing the code equivalent to activating player-data access and would make development-direct classification occur too late. Option C is rejected because global mutable store ownership exceeds the required lifetime and weakens test isolation.

## 2. Accepted policy separation

The composition design distinguishes exactly:

```text
MEMORY_ONLY
PRODUCTION_READ_ONLY
PRODUCTION_WRITE_ON_INTENT
```

These are internal composition policies, not user-facing settings.

The current main scene remains the existing memory-only AppRoot through implementation and fixture gates. Development-direct and invalid direct-level launches remain memory-only. Only a separately authorized final activation task may make a no-argument normal product boot select `PRODUCTION_WRITE_ON_INTENT` by default.

## 3. Accepted store and AppRoot boundaries

A later production store API must:

- accept no caller-supplied production path;
- bind only `user://delayed_self_profile.json` internally;
- preserve one-time immutable configuration and catalog validation;
- keep test failure seams and reset APIs test-only;
- use bounded production-owned sibling names distinct from Task 0023W fixture names;
- reject every write path in `PRODUCTION_READ_ONLY`;
- preserve transactional replacement, write-disable, recovery and `NO_CHANGE` invariants in `PRODUCTION_WRITE_ON_INTENT`;
- disclose no production path, content, raw error or sibling filename.

A later AppRoot API must remain mutually exclusive with `configure_test_profile()`, be accepted only before tree entry and boot start, and preserve:

```text
catalog load
→ adapter.configure
→ store.configure_production
→ store.load_profile
→ adapter.load_profile
→ Main Menu or bounded Safe Error
```

Completion remains:

```text
adapter.prepare_completion
→ NO_CHANGE: no store operation and no adapter commit
→ store.persist_profile
→ adapter.commit_profile
```

The existing three-key public progress snapshot remains exact.

## 4. Accepted boot-state contract

The design accepts these bounded outcomes:

- Missing production Profile: clean in-memory v1 state, Main Menu, and no boot-time file creation.
- Valid partial or completed Profile: validated read/hydration with no boot-time target write or metadata change.
- Valid but sanitizable Profile: hydrate only normalized known data, preserve the original source, and require durable recovery before a later target replacement.
- Malformed, unreadable or oversize data in read-only mode: bounded recovery-required Safe Error with no write.
- Malformed, unreadable or oversize data in write-enabled mode: clean fallback only after an authorized bounded recovery copy succeeds; the target remains untouched until an intentional persistent change.
- Unsupported schema in read-only mode: bounded unsupported-version Safe Error and no write.
- Unsupported schema in write-enabled mode: preserve the source through an authorized recovery copy, use a bounded clean fallback if allowed, and keep the process write-disabled so an older build cannot replace newer data.
- Recovery-copy failure or collision exhaustion: Safe Error and process-wide Profile write disablement.

Unknown version must be classified separately from generic malformed structure without adding a migration or accepting another schema.

## 5. Existing Profile protection accepted

The existing recorded metadata:

```text
exists = true
Length = 473
LastWriteTimeUtc = 2026-07-19T08:15:02.2089459Z
```

proves neither validity nor schema. Task 0023ZO correctly did not refresh metadata or access content.

Until a later explicit authorization, no task may open, parse, hash, copy, rename, delete, reset, repair, compare or back up the production Profile, enumerate its parent directory, or infer progress/settings/version/provenance.

A controlled read authorization does not authorize a recovery copy or target write. Recovery-copy authorization does not authorize target replacement. One first-write authorization does not authorize retry, reset or default activation.

## 6. Rollback and compatibility accepted

Code rollback changes only bootstrap/composition policy and source. It never deletes, rewrites, renames, restores or cleans the production target or recovery copies.

Profile v1 remains the only supported schema. No v0 import, multi-slot migration, broad migration table or schema-v2 save format is authorized. Unsupported/newer data is preserved and leaves the older process write-disabled. Recovery-copy inspection or restoration remains a separate player-data operation.

## 7. Accepted future sequence

The future sequence is accepted as separate gates:

1. production-mode compile/static implementation with zero production I/O and unchanged main scene;
2. isolated fixed-fixture activation-policy behavior;
3. explicit-user-authorized controlled production read-only boot;
4. conditional explicit recovery-copy authorization only if the read gate requires it;
5. explicit-user-authorized first intentional write plus `NO_CHANGE` proof;
6. final default activation with a separately authorized normal production acceptance run;
7. aggregate registration using isolated profiles only;
8. Menu New/Continue/Reset and pause/quit confirmation flow.

No general implementation task may silently include a production read or write.

## 8. Next gate

A new Task 0023ZP may implement only the production composition/API surface and focused compile/static contracts while:

- leaving `project.godot` and the current main scene unchanged;
- performing no production Profile or test-root filesystem access;
- never executing production configuration;
- preserving all accepted test-only behavior and historical harness artifacts;
- proving by parser/compile/static evidence that production paths are hard-coded, policies are mutually exclusive, direct-development remains memory-only, errors/snapshots are bounded, and no activation occurs merely because the code exists.

Fixture behavior and every production player-data operation remain separately closed.

```text
TASK_0023ZO_PRODUCTION_PROFILE_ACTIVATION_DESIGN_ACCEPTED
```
