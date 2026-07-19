# Task 0021 GPT eight-level finale-presentation acceptance

- Reviewed commit: `ad5d71275e9b218b9bf5dec08f27b460d37398d9`
- Verdict: `TASK_0021_EIGHT_LEVEL_FINALE_PRESENTATION_ACCEPTED_MACHINE_IMPLEMENTATION`
- Accepted state: `FINAL_ACKNOWLEDGEMENT_VISIBLE`
- Formal scope: exactly eight levels; sequence 8 `two_echo_convergence` remains sole final
- Next gate: native machine/capture acceptance only

## Accepted implementation

Task 0021 implements the selected bounded ending through the existing AppRoot/Gameplay seam. AppRoot passes the validated catalog-derived `final_level` fact in the route payload, binds callbacks to the active Gameplay instance, and permits at most one completion-recording attempt for that instance.

The accepted routing behavior is:

```text
non-final completion -> record once -> automatic Level Select return
final completion     -> record once -> remain in Gameplay
```

Gameplay derives the final acknowledgment only from hosted product flow, `route_payload.final_level`, and ordinary Simulation completion. It does not add an ending state to Simulation or the canonical key, hard-code `two_echo_convergence`, inspect coordinates, or alter formal data.

The accepted provisional copy is:

```text
THE SIGNAL ARRIVED LATE.
IT WAS HEARD.

Enter / Space: Level Select
R: Replay
```

While the acknowledgment is visible, movement, Help, and gameplay WAIT cannot enter Simulation. Enter, Space, and Esc request one return through the existing routed back signal. R reconstructs the exact initial state and allows replay; AppRoot's active-instance guard prevents replay from recording completion again in the same Gameplay session.

## Evidence accepted

Focused regression passes 42 assertions with empty stderr. Aggregate regression passes 621 assertions / 9 vectors; all prior thirteen stable markers and `TASK_0021_EIGHT_LEVEL_FINALE_PRESENTATION_TESTS_PASS` appear exactly once. Aggregate stderr contains only the intentional `LEVEL_ID_MISMATCH` fixture diagnostic.

The focused evidence covers catalog-derived final/non-final facts, no hard-coded final ID, record-once behavior, non-final auto-return, final Gameplay retention, exact acknowledgment copy/state, completed-state and canonical-key preservation, guarded Enter/Space/Esc, exact R restart/replay, direct-development behavior, Help/Timeline isolation, Safe Error, Level Select scrolling, and resize baseline.

The catalog and all eight formal level hashes and accepted metrics remain exact. No scene, project setting, progress adapter, formal data, schema, Simulation, solver, Help copy/predicate, Timeline model, persistence, asset, audio, build, export, release, or submission path changed.

## Required next gate

Task 0021 is accepted at implementation plus headless machine-regression level. Native product-flow and capture evidence remains mandatory before owner review.

The next task must independently rerun the focused and aggregate suites, inspect the exact patch and frozen hashes, and capture the native Compatibility-renderer product flow at 960x540 plus bounded resized, grayscale, and reduced-motion cases. It must verify final/non-final routing, final acknowledgment visibility, return inputs, replay behavior, record-once progress, Help/Timeline suppression, no clipping, and Level Select return.

Any product defect requires a separate repair task. The capture-acceptance task may not edit AppRoot, Gameplay, scenes, tests, formal data, catalog, Simulation, solver, schema, persistence, settings, assets, audio, or export configuration.

## Non-claims

This acceptance is not native capture acceptance, owner acceptance, final-copy/localization acceptance, complete-flow readiness, production readiness, build/export readiness, release-candidate acceptance, release, upload, or festival submission readiness.
