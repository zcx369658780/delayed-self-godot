# Task 0024Y GPT acceptance — sequence-9 crate-shadow timing machine validation

- Verdict: `TASK_0024Y_SEQUENCE_9_CRATE_SHADOW_TIMING_MACHINE_VALIDATION_ACCEPTED`
- Reviewed result commit: `445122ab035a4c9210f3280af58d054a35bef2bd`
- Accepted scope predecessor: `TASK_0024X_SUBMISSION_CORE_LEVELS_9_12_SCOPE_ACCEPTED`
- Accepted mechanics foundation: `TASK_0024W_COMPLETE_CORE_MECHANICS_FOUNDATION_ACCEPTED`
- Review date: 2026-07-22

## Accepted candidate

The uncatalogued schema-v2 candidate `crate_shadow_timing / Crate-Shadow Timing` is accepted as the machine-validated future sequence-9 content candidate.

Accepted exact facts:

- footprint `9 × 7`;
- one delay-2 ECHO, one YOU-only crate, one Plate and one initially closed Door;
- zero keys, locks, typed sensors, grouped barriers and latches;
- solver status `SOLVED`;
- `L*=14`;
- exact `N*=6`;
- visited states `2559`, maximum frontier `396`;
- one consequential push, zero waits and zero blocked-YOU actions in the retained witness;
- deterministic shared-Simulation replay and exact restart;
- crate position is represented in the canonical key.

The retained witness proves the required ordered temporal chain: YOU pushes the crate, the delayed ECHO later replays into the crate and is blocked, the changed ECHO phase alone holds the Plate while YOU enters the open Door, and only YOU reaches EXIT.

## All-shortest and controls

The instrumented search uses the accepted `Simulation.transition` and canonical state with an event mask, not a parallel transition system. It counts six completed shortest paths at depth 14, equal to solver `N*`; all six contain the full required event mask, zero omit the event, and the maximum shortest-path push count is one.

Accepted necessity evidence:

- no-push control: complete finite-state unsolved;
- displaced-crate control: complete finite-state unsolved;
- no-ECHO control: complete finite-state unsolved;
- static-wall substitution: reproduces numerical `14/6`, but cannot reproduce the YOU-push and later ECHO-crate-block temporal structure.

The static-wall numerical match is an observation, not a blocker. Task 0024Y required that static substitution not reproduce both the baseline metrics and the intended temporal event structure. That conjunction is false, and the all-shortest proof independently establishes that the actual candidate requires the crate event in every shortest solution.

Shortcut probes for Door articulation, ECHO crate immobility, illegal push behavior/history, repeated blocked-input macros, ECHO-on-EXIT, ECHO-held Door necessity and restart residue all pass.

## Regression and lifecycle acceptance

Final invocation `0d9ee9ef-3213-4266-a94c-6b8e8a0ae44b` ran the focused sequence-9 test, Aggregate and corrected complete-v2 once each. All passed with native exit zero and exact markers/stderr policy. Cleanup ran exactly once per case; no owned or unproven PID remained; final Godot count was zero.

The Task 0024W seal and all 53 bound repository identities plus 12 historical external evidence identities remained exact before and after the retained cycle. No protected Profile or user-data boundary was crossed.

## Boundary

This acceptance establishes only an uncatalogued, machine-validated sequence-9 candidate. It does not:

- add the candidate to the catalog;
- authorize progression, finale or Profile changes;
- complete owner/manual playthrough;
- authorize Gameplay/UI, localization, asset/audio, build/export, release, upload or submission work.

`owner_playthrough_status` remains `PENDING_LATER_CURRICULUM_GATE` and `catalog_admission_status` remains `NOT_AUTHORIZED`.
