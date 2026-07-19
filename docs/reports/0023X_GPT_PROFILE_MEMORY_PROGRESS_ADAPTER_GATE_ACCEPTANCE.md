# Task 0023X GPT Profile-to-MemoryProgress adapter gate acceptance

- Reviewed implementation commit: `4f3b7c8500ed6fcfacef279b024cd3a01b576eda`
- Verdict: `TASK_0023X_PROFILE_MEMORY_PROGRESS_ADAPTER_GATE_ACCEPTED`
- Scope accepted: pure zero-I/O Profile v1 to runtime-progress adaptation and atomic in-memory hydration
- Filesystem store changes, AppRoot integration, and production Profile operation: not accepted or authorized by this report

## Accepted implementation boundary

Task 0023X adds `scripts/app/profile_progress_adapter.gd`, externally constructed as a `RefCounted`, and one minimal pure hydration method in `scripts/app/memory_progress.gd`.

The adapter may depend only on the frozen Task 0023T codec and `DelayedSelfMemoryProgress`. It contains no filesystem, store, AppRoot, scene, route, OS, environment, command-line, or production-path dependency.

The accepted adapter surface is:

```text
configure(catalog)
is_configured()
load_profile(profile)
prepare_completion(level_id, turns)
commit_profile(profile)
reset_to_default()
snapshot()
get_profile_snapshot()
is_unlocked(level_id)
```

## Accepted behavior

The reviewed source and standalone 31-assertion suite establish:

- malformed catalogs and invalid prerequisite references reject without partial configuration;
- a failed first configuration permits a later valid attempt, while the first successful configuration is immutable;
- retained catalog facts and all returned snapshots are defensive copies;
- Profile input is normalized only through the frozen codec;
- runtime completed IDs and best turns are hydrated atomically through `replace_profile_progress`;
- unlocks remain derived solely by `DelayedSelfMemoryProgress` from catalog prerequisites and are never accepted or serialized;
- completed IDs without best-turn entries remain completed without an invented value;
- invalid Profile roots, versions, and runtime hydration inputs reject without changing retained Profile or runtime state;
- `prepare_completion` uses the frozen codec candidate builder, preserves settings, and never mutates retained Profile, completed IDs, best turns, or unlocks;
- `CANDIDATE_READY` and `NO_CHANGE` semantics match the frozen codec;
- runtime/Profile state changes only after an explicit pure `commit_profile` call;
- `reset_to_default` resets only in-memory state to the codec default;
- existing MemoryProgress construction, completion recording, unlock derivation, and reset behavior remain intact.

## Evidence accepted

```text
Task 0023X compile smoke: attempt 1 pass
Task 0023X behavior: 31 assertions
Task 0023R: 123 assertions / 4 positive / 39 negative
Task 0023T: compile marker + 34 assertions
Task 0023V: compile marker + 28 assertions
Task 0023W: compile marker + 68 assertions
All commands: exit 0, stderr empty, marker exactly once
Task 0023W fixed fixture: absent
Residual Godot process: none
```

Production Profile protection remained:

```text
exists = true
Length = 473
LastWriteTimeUtc = 2026-07-19T08:15:02.2089459Z
```

Only non-content metadata was compared. Production Profile content was not opened, read, parsed, hashed, copied, renamed, backed up, deleted, reset, repaired, compared, or written. The test root was not enumerated or cleaned.

## Frozen authorities

Later work must preserve:

1. Task 0023R exact canonical test-path grammar and isolation gate.
2. Task 0023T pure Profile v1 codec and deterministic serialization.
3. Task 0023V external store construction and one-time test configuration.
4. Task 0023W configured-instance-only filesystem behavior, recovery preservation, transactional replacement, rollback, reset, and exact cleanup.
5. Task 0023X pure adapter and atomic MemoryProgress hydration behavior.
6. The production Profile non-content metadata protection boundary.
7. The eight-level catalog, formal hashes/metrics, Simulation, solver, schema, final acknowledgment, Help, Timeline, Level Select, presentation, and owner-evidence boundaries.

## Next gate authorized separately

The next task may implement a **test-profile-only AppRoot session orchestration gate** using exactly one task-owned canonical fixture. It may connect the accepted store and adapter to AppRoot only after an explicit pre-tree test configuration. The normal unconfigured AppRoot boot must remain the existing memory-only behavior and must not access the production Profile.

The test gate should prove catalog load, store configuration/load, adapter hydration, real Gameplay completion preparation, persistence before runtime commit, reload in a fresh AppRoot instance, `NO_CHANGE`, deterministic failure rollback, Safe Error handling, and exact owned-fixture cleanup. It must not create a production constructor or production fallback, register aggregate tests, implement menus/settings/localization, or access the production Profile.

Production Profile activation, default product persistence, New Game/Continue/Reset UI, persistent settings, aggregate registration, build/export, RC, release, upload, and festival submission remain later gates.

## Non-claims

This acceptance does not establish filesystem or AppRoot integration, production Profile loading/writing/reset, process-restart product persistence, product menu flow, aggregate coverage, settings, localization, build/export, RC, release, upload, or festival submission readiness.

```text
TASK_0023X_PROFILE_MEMORY_PROGRESS_ADAPTER_GATE_ACCEPTED
```
