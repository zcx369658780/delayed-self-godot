# Task 0024Z GPT acceptance — Sequence 10 key-route commitment machine validation

- Verdict: `TASK_0024Z_SEQUENCE_10_KEY_ROUTE_COMMITMENT_MACHINE_VALIDATION_ACCEPTED`
- Reviewed result commit: `b8378bc2e1e96642ff99eded436df65e2435cc9f`
- Accepted predecessor: `TASK_0024Y_SEQUENCE_9_CRATE_SHADOW_TIMING_MACHINE_VALIDATION_ACCEPTED`
- Review date: 2026-07-22

## Accepted result

The uncatalogued schema-v2 candidate `key_route_commitment / The Key Is Yours` is accepted as the machine-validated future sequence-10 core candidate.

Accepted measured facts:

- footprint `9×7`;
- one delay-2 ECHO, one `main` key, one matching `main` lock, one v1 Plate and one initially closed v1 Door;
- zero crates, typed sensors, grouped barriers and latches;
- solver status `SOLVED`;
- `L*=19`;
- exact `N*=8`;
- visited states `1,063` and maximum frontier `152` within the frozen limits;
- deterministic shared-Simulation replay and exact restart;
- canonical keys distinguish remaining-key, held-key and removed-lock states.

## Ordered mechanic proof

The retained witness and independent all-shortest search establish the required curriculum chain:

1. YOU alone collects `key_main` and gains one held `main` key;
2. ECHO contact cannot collect the key or gain inventory;
3. ECHO contact cannot enter or remove intact `lock_main`;
4. YOU consumes the held key, removes the matching lock and enters its former cell on the same accepted turn;
5. after that irreversible commitment, ECHO alone occupies `plate_route` and YOU crosses `door_route` from an open start snapshot;
6. YOU alone completes at EXIT.

All eight shortest solutions contain the full ordered event mask. Completed shortest paths are `8/8`, omissions are `0`, and the instrumented proof uses shared `Simulation.transition` rather than a parallel transition implementation.

## Necessity and shortcut acceptance

The controls establish that the key/lock is structural rather than cosmetic:

- no-key is schema-valid and complete finite-state unsolved;
- displaced-key is schema-valid and complete finite-state unsolved;
- no-ECHO is schema-valid and complete finite-state unsolved;
- no-lock solves at `L*=11`, exact `N*=7`, materially changing the room and eliminating the same-turn lock event;
- ECHO changes neither remaining keys, held inventory nor removed-lock state and cannot cross the intact lock.

The lock is a route articulation. There is no direct EXIT or Door bypass, YOU without a key cannot remove the lock, ECHO on EXIT is nonterminal, the blocked-input macro remains bounded, and restart leaves zero key/lock/inventory/Plate/Door/history/completion residue.

## Regression and lifecycle acceptance

Retained invocation `e0b62d7e-539e-415e-aea9-a9bc40d16c26` executed exactly once each:

- focused Task 0024Z;
- accepted focused Task 0024Y;
- Aggregate with exact `621 assertions / 9 vectors` and only `LEVEL_ID_MISMATCH` stderr;
- corrected complete-v2.

All four passed with wrapper/native exit zero. Cleanup ran exactly once per case, no owned or unproven PID remained, and final Godot count was zero. The 53 Task 0024W-sealed repository identities, 12 historical external evidence identities, accepted wrapper and sequence-9 artifacts retained exact hashes.

## Scope boundary

Acceptance covers only the uncatalogued machine-validated sequence-10 candidate and its validation evidence.

It does not authorize:

- catalog admission or progression changes;
- finale movement or Profile migration/read/write/reset;
- owner playthrough acceptance;
- sequence-11 implementation except through a new task;
- Gameplay/UI, localization, assets, audio, build/export, release, upload or submission.

The candidate remains:

- `owner_playthrough_status = PENDING_LATER_CURRICULUM_GATE`;
- `catalog_admission_status = NOT_AUTHORIZED`.
