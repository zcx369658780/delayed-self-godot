# Task 0023ZC AppRoot Profile orchestration compile gate

`APP_ROOT_PROFILE_ORCHESTRATION_COMPILE_GATE_READY_FOR_GPT_REVIEW`

Task 0023ZC adds a bounded pre-tree test-profile configuration surface to
AppRoot and encodes the configured orchestration branch without executing it.
Only the frozen `LocalProfile.validate_test_profile_path` policy can authorize
the retained virtual test path. Invalid and production paths reject without
fallback; a valid retry is allowed after rejection; the first valid
configuration is immutable; and configuration rejects after tree entry or
boot.

The configured source order is adapter configuration, defensive catalog facts,
store construction/configuration, one store load, accepted-status filtering,
then adapter hydration. Completion source preserves the active-Gameplay and
record-once guards and orders candidate preparation before persistence and
runtime commit. Adapter commit occurs only after store `PERSISTED` or
`NO_CHANGE`; failures route to the existing Safe Error without claiming
navigation success. Normal unconfigured boot remains MemoryProgress-only and
constructs no store or adapter.

The classified public snapshot defect is corrected.
`get_progress_snapshot()` always returns exactly:

```text
completed_level_ids
best_turns
unlocked_level_ids
```

Memory mode returns a defensive MemoryProgress snapshot. Configured mode
selects and defensively copies only the adapter snapshot's nested `runtime`
dictionary. A separate bounded session snapshot contains only mode,
configuration/boot/load/persist status identifiers and the public progress
snapshot; it exposes no path, Profile content, store, adapter, handle, or
diagnostic payload.

## Evidence

- Parser smoke: attempt 1 passed; final fresh-process rerun passed.
- Compile contract: 17 assertions; initial and final fresh-process runs passed.
- Task 0023R: 123 assertions, 4 positive and 39 negative paths.
- Task 0023T: compile marker plus 34 assertions.
- Task 0023V: compile marker plus 28 assertions.
- Task 0023W: compile marker plus 68 assertions; fixed fixture absent after cleanup.
- Task 0023X: compile marker plus 31 assertions.
- Every final process exited 0, emitted its marker exactly once, and had empty stderr.
- Static typing, ordering, path-leak, forbidden-selector and zero-Profile-I/O audits passed.
- Frozen codec/store/adapter/MemoryProgress sources and all existing 0023R–0023X tests match their pre-task Git blobs.

Production Profile content was not opened or accessed. Its protected
non-content metadata remained:

```text
exists = true
Length = 473
LastWriteTimeUtc = 2026-07-19T08:15:02.2089459Z
```

The pre-existing test-root existence fact remained `true`; it was not
enumerated, inspected, created, cleaned, or modified by Task 0023ZC. Task
0023ZC has no fixture ID, no successfully configured AppRoot entered the tree,
and no configured store load/persist/reset/recovery behavior ran. No aggregate
or export was run. Evidence is retained at
`D:\Delayed_Self_Evidence\0023ZC_app_root_profile_orchestration_compile_gate\`.

This gate establishes compile-level AppRoot architecture and unchanged
default-memory behavior only. It does not establish configured filesystem
integration, persistence, rollback, recovery, restart behavior, complete
harness coverage, production Profile activation, menus/settings/localization,
aggregate coverage, build/export, RC, release, upload, or submission readiness.
