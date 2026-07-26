# Task 0024AYR C03 next-turn Door retry report

## Verdict

`PASS_FOR_GPT_REVIEW`.

The contract-reconciled C03 retry is machine validated as an uncatalogued, unsequenced, owner-unreviewed candidate. This is not catalog admission or final acceptance.

## Candidate and solver

Fresh candidate `phase_1_c03_crate_delayed_door / Held Window` uses one delay-2 ECHO, one crate, one Plate, one initially closed Door and one YOU-only EXIT. It contains no sensors, barriers, keys, locks or latches.

- Shared BFS: `SOLVED`
- `L*=14`
- exact `N*=2`
- visited states `4,507`; frontier `706`; retained elapsed `1,013 ms`
- deterministic witness: `DOWN RIGHT RIGHT LEFT DOWN DOWN DOWN RIGHT RIGHT UP RIGHT UP RIGHT RIGHT`

Both shortest solutions contain the revised seven-event chain. Complete enumeration is `2/2`, omissions `0`; every shortest solution uses exactly two pushes and one ECHO-crate block. Plate entry precedes Door crossing strictly in `2/2`: Plate-entry transition starts closed and ends open, while crossing occurs later from an open start snapshot.

## Separate blocked-Door diagnostic

A reachable shared-Simulation diagnostic passes independently of shortest solutions. Prefix plus crossing:

`DOWN RIGHT DOWN DOWN DOWN RIGHT UP RIGHT RIGHT UP RIGHT RIGHT`

At turn 11 YOU at `[4,4]` attempts `RIGHT` toward the closed Door while ECHO enters Plate. YOU remains blocked; Door changes from closed to open after resolution. Turn 12 starts open and the same `RIGHT` crosses Door `[5,4]`.

## Controls

No-push and no-ECHO are complete finite-state unsolved. Displaced crate and no-block are also complete-unsolved. No-crate changes baseline `14/2` to `12/2`; pre-positioned crate changes it to `12/4`; static wall is `13/2` with revised mask zero. Dependency removal and initially-open variants are `13/2`; timing bypass is `15/20`. All controls public-load and no limit result is called unsolved.

Replay determinism, exact restart, crate-sensitive canonical identity, no Door bypass, ECHO crate restrictions, illegal push stability, start-snapshot Door semantics, YOU-only completion and zero restart residue pass.

## Bounded iteration

Three topology families and five variants were used. Variants 1–4 were rejected for control weakness, pre-position equivalence, direct bypass or history resynchronization. Family-3 variant-5 converts the resynchronization wall hit into a real isolated dead-end, forcing the two-push commitment without opening the ECHO lane to YOU. Per-variant record hashes and dispositions are in the validation JSON.

## Qualification and retained lifecycle

Focused qualifications `16921223-198b-404d-9331-3eb5e1b603ad` and `cab306e3-b77e-49ea-bf27-75a2dab5cb57` passed. Matrix qualification `83f36494-0ead-4e2b-ad63-05462f257493` passed current Aggregate and complete-v2.

Manifest `a5850880-314a-49e7-a67c-860313c14158` was consumed exactly once. Focused retry, Aggregate and complete-v2 all passed. Aggregate marker was exactly `TASK_0003_TESTS_PASS assertions=621 vectors=9` with stderr exactly `LEVEL_ID_MISMATCH`; other stderr was empty. Cleanup ran once per case, no owned/unproven PID remained, and final Godot count was zero. The cycle is immutable and must never be repaired, rerun, replaced or reconstructed.

## Boundaries

Catalog remains eight entries and sequence 8 remains the sole formal finale. Profile, schema, Simulation, solver, Aggregate, existing levels/tests, scenes and presentation code were unchanged. Profile was not accessed and DeepSeek was not invoked. C03 remains `NOT_AUTHORIZED` for catalog and `NOT_REVIEWED` by the owner. S03/0024AZ remains closed pending explicit GPT adjudication.
