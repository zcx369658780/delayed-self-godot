# Task 0023W GPT configured Profile filesystem-store gate acceptance

- Reviewed implementation commit: `057b17b1d6d77c81b423cb09d803ca4b7c6ad075`
- Verdict: `TASK_0023W_PROFILE_FILESYSTEM_STORE_AFTER_INSTANCE_GATE_ACCEPTED`
- Scope accepted: configured-instance, fixed-fixture-only Profile v1 filesystem behavior
- Production Profile operation and product integration: not accepted and not authorized by this report

## Accepted implementation boundary

Task 0023W preserves the accepted Task 0023R canonical test-path policy, Task 0023T pure Profile v1 codec, and Task 0023V external `RefCounted` construction plus one-time `configure_test` configuration.

Filesystem-capable methods remain unavailable before successful configuration. The accepted store surface is:

```text
load_profile()
persist_profile(candidate_profile)
reset_test_profile()
get_committed_profile()
set_test_failure_seam(stage)
```

Every operation is bound to the exact canonical path retained by `configure_test`; there is no `create_test` factory, `create_production`, production fallback, arbitrary path setter, command-line/environment path, AppRoot integration, MemoryProgress integration, scene integration, or aggregate registration.

## Accepted behavior

The reviewed source and standalone fixture suite establish:

- missing target returns `MISSING_CLEAN` without eager creation;
- valid canonical target loads as `LOADED` without rewrite;
- salvageable Profile v1 data loads as `SANITIZED`, defers replacement, and preserves one bounded collision-safe recovery sibling before the first later persist;
- malformed, truncated, empty, wrong-root, unknown-version, and oversized sources preserve an exact bounded recovery sibling and activate clean in-memory state as `RECOVERED_CLEAN`;
- recovery-copy failure preserves the source, returns `RECOVERY_FAILED`, and disables persist/reset;
- canonical serialization is deterministic and equivalent persistence returns `NO_CHANGE` without metadata rewrite;
- changed persistence uses same-directory owned temp and transaction siblings, read-back/canonical verification, target verification, and in-memory commit only after success;
- TEMP_WRITE, TEMP_READBACK, REPLACE, and POST_REPLACE_VERIFY failure seams return `WRITE_FAILED` while preserving the exact old target and committed in-memory state;
- reset removes only the exact configured target, returns `RESET`, and leaves a clean in-memory default without eager recreation;
- returned committed Profile snapshots are defensive copies;
- owned recovery/temp/transaction names are bounded and no directory enumeration is used.

## Evidence accepted

```text
Task 0023R: 123 assertions / 4 positive / 39 negative
Task 0023T: compile marker + 34 assertions
Task 0023V: compile marker + 28 assertions
Task 0023W compile smoke: attempt 1 pass
Task 0023W behavior: 68 assertions
All final commands: exit 0, stderr empty, marker exactly once
Fixed fixture: removed after cleanup
Residual Godot process: none
```

Production Profile protection remained:

```text
exists = true
Length = 473
LastWriteTimeUtc = 2026-07-19T08:15:02.2089459Z
```

Only non-content metadata was compared. The production Profile content was not opened, read, parsed, hashed, copied, renamed, backed up, deleted, reset, repaired, compared, or written. The pre-existing test root was not enumerated or cleaned.

## Frozen authorities

Later work must preserve:

1. Task 0023R exact canonical test-path grammar and standalone path gate.
2. Task 0023T pure, explicitly typed Profile v1 codec and deterministic serialization.
3. Task 0023V external construction and immutable one-time test configuration.
4. Task 0023W configured-instance-only filesystem contract, recovery preservation, verified replacement, rollback, and exact cleanup.
5. The production Profile non-content metadata protection boundary.
6. The eight-level catalog, formal hashes/metrics, Simulation, solver, schema, final acknowledgment, owner-evidence, Help, Timeline, and Level Select boundaries.

## Next gate authorized separately

The next implementation task may build a **pure Profile-to-MemoryProgress adapter gate**. It must remain zero-I/O and must not yet connect AppRoot or the production Profile. The adapter should normalize and hydrate runtime progress, derive unlocks from the catalog, prepare completion candidates without mutating committed runtime state, and apply a candidate only after a later caller confirms persistence success.

The accepted Task 0023W store and `profile_codec.gd` remain frozen in that gate. AppRoot production/test integration, single-AppRoot fixture authority, focused product integration, aggregate persistence regression, menus, settings, localization, build/export, RC, release, upload, and festival submission remain later gates.

## Non-claims

This acceptance does not establish production Profile loading/writing/reset, process-restart product persistence, MemoryProgress or AppRoot integration, aggregate coverage, New Game/Continue/Reset confirmations, persistent settings, localization, build/export, RC, release, upload, or festival submission readiness.

```text
TASK_0023W_PROFILE_FILESYSTEM_STORE_AFTER_INSTANCE_GATE_ACCEPTED
```
