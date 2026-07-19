# Task 0023V GPT Profile-store instance-configuration gate acceptance

- Reviewed implementation commit: `44adadb4992968bd9641d4a8bb9cf9fb907c4509`
- Verdict: `TASK_0023V_PROFILE_STORE_INSTANCE_CONFIGURATION_GATE_ACCEPTED`
- Scope accepted: zero-I/O external instance construction and one-time test configuration
- Filesystem-store implementation: not accepted and not authorized by this report

## Accepted construction pattern

The Task 0023U self-type compile blocker is resolved through the Godot-4.7-compatible external construction pattern:

```gdscript
const LocalProfileScript = preload("res://scripts/app/local_profile.gd")
var store: RefCounted = LocalProfileScript.new()
var configured: Dictionary = store.configure_test(catalog_facts, canonical_test_profile_path)
```

`local_profile.gd` does not use a class-internal static factory and does not reference `DelayedSelfLocalProfile` as a type inside its own script.

## Accepted configuration behavior

The instance exposes only the bounded zero-I/O configuration surface required by this gate:

```text
configure_test(catalog_facts: Dictionary, canonical_test_profile_path: String) -> Dictionary
is_configured() -> bool
get_configuration_snapshot() -> Dictionary
```

The accepted behavior is:

- a fresh instance validates the exact Task 0023R canonical virtual test path before retaining it;
- the production Profile path and all invalid paths are rejected without a retained fallback;
- catalog facts require non-empty unique String level IDs and a prerequisite Array for every known ID;
- prerequisite entries must be known unique Strings and cannot be self-dependencies;
- accepted catalog facts are defensively copied;
- failed first configuration leaves the instance unconfigured and permits a later valid attempt;
- the first successful configuration is immutable for that instance;
- later reconfiguration attempts are rejected without changing the original configuration;
- returned configuration snapshots are defensive copies and expose no OS path, filesystem handle, production fallback or mutable internal reference.

## Evidence accepted

```text
Compile smoke: attempt 1, exit 0, stderr empty, marker exactly once
Configuration behavior: 28 assertions, exit 0, stderr empty, marker exactly once
Task 0023R regression: 123 assertions / 4 positive / 39 negative, stderr empty
Task 0023T regression: compile marker plus 34 assertions, stderr empty
Forbidden I/O/integration source-audit hits: 0
```

Production Profile protection remained:

```text
exists = true
Length = 473
LastWriteTimeUtc = 2026-07-19T08:15:02.2089459Z
```

Only non-content metadata was compared. The production Profile contents were not opened, read, parsed, hashed, copied, renamed, backed up, deleted, reset or repaired. Test-root existence remained unchanged; no fixture was created or enumerated.

## Frozen prerequisites

The following authorities remain accepted and must be preserved in any later work:

1. Task 0023R exact canonical test-path policy and 123-assertion standalone gate.
2. Task 0023T explicitly typed, zero-I/O Profile v1 codec and its 34-assertion behavior gate.
3. Task 0023V external RefCounted construction and one-time defensive test configuration.
4. The production Profile non-content metadata protection boundary.
5. The eight-level catalog, formal hashes/metrics, Simulation, final acknowledgment and owner-evidence boundaries.

## Closed tasks and prohibited resumptions

Do not resume these task files directly:

```text
tasks/0023_persistent_local_profile_core_implementation.md
tasks/0023S_persistent_local_profile_core_retry_after_isolation_gate.md
tasks/0023U_profile_filesystem_store_gate.md
```

They are historical blocked scopes. A later filesystem-store task must be newly written around the accepted Task 0023V instance pattern.

## Recommended next scope, not authorized here

The next task should be a revised **test-fixture-only filesystem-store gate**. It should:

- append filesystem behavior to the accepted configured instance;
- require successful `configure_test` before any I/O-capable method can run;
- keep `create_production`, AppRoot, MemoryProgress, existing AppRoot tests and aggregate closed;
- operate in exactly one task-owned canonical fixture;
- verify missing/load/sanitize/recovery preservation/transactional replace/failure rollback/reset;
- preserve and re-run Tasks 0023R, 0023T and 0023V before and after;
- keep the real production Profile unopened and metadata-unchanged.

No next implementation task is created by this adjudication because the current session is being handed off.

## Non-claims

This acceptance does not establish Profile filesystem loading, writing, recovery, transactional replacement, reset, production Profile operation, AppRoot or MemoryProgress integration, process-restart persistence, aggregate regression, menu/settings/localization readiness, build/export, RC, release, upload or festival submission readiness.

```text
TASK_0023V_PROFILE_STORE_INSTANCE_CONFIGURATION_GATE_ACCEPTED
```
