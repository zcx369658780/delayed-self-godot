# Task 0024AZ — S03 ECHO-only sensor machine-validation report

## Verdict

`PASS_FOR_GPT_REVIEW`

Task 0024AZ authored one fresh, uncatalogued schema-v2 candidate:
`S03 / phase_1_s03_echo_only_sensor / Echo Signal / 回声感应`.
It remains `UNASSIGNED`, `NOT_REVIEWED` and `NOT_AUTHORIZED` for catalog admission.

## Exact machine result

- Shared BFS: `SOLVED`, `L*=13`, exact `N*=11`.
- Search: 1,340 visited states, maximum frontier 193, observed solver time 269 ms.
- Complete all-shortest enumeration: `11/11` full ordered event mask, omissions `0`.
- Ordered witness: BODY route commitment turn 2; ECHO-only sensor and resulting barrier-open turn 6; YOU crosses from an open start snapshot turn 7; YOU reaches EXIT turn 13.
- Replay deterministic and restart exact.
- Accepted witness has no WAIT, one non-repeated blocked action and no repeated blocked macro.

## Controls and role proof

- No ECHO: complete finite-state unsolved, 12 states.
- `YOU_ONLY`: complete finite-state unsolved, 880 states.
- Body route removed: complete finite-state unsolved, 237 states.
- ECHO route removed: complete finite-state unsolved, 178 states.
- `ANY_ACTOR`: baseline metrics remain possible, while an independent public-state probe proves YOU can substitute on the sensor.
- Dependency/body-sensor shortcut: `12/2`, event mask 25.
- Initially-open variant: `12/6`, event mask 26.
- Direct body bypass: `12/60`, event mask 17.
- Symmetric path: `12/60`, materially different from baseline.

YOU cannot activate the baseline sensor; ECHO can. ECHO cannot complete the YOU-only EXIT. The barrier crossing is recorded only when the transition begins open, proving next-turn entry semantics.

## Qualification and retained lifecycle

Focused qualifications `d68b0503-5694-427a-8df2-e0e819192b79` and
`d88b5763-d41d-494d-9bf0-f35ee85ca0af` passed. Matrix qualification
`a3fc7213-f1d1-4749-92c2-cccbc8f7872e` passed Aggregate and complete-v2.

PRE_FINAL froze the candidate, focused test, UID, worker and orchestrator.
Manifest `e41c771e-0df0-4ac5-a7d6-545b2175cc3b` was then consumed exactly once.
Focused S03, current Aggregate and current complete-v2 all passed. Aggregate
marker/stderr were exactly `TASK_0003_TESTS_PASS assertions=621 vectors=9` /
`LEVEL_ID_MISMATCH`; other stderr was empty. Cleanup ran once per case, no owned
or unproven PID remained and final Godot count was zero.

This manifest and its retained cases must never be rerun, repaired, replaced or reconstructed.

## Static presentation boundary

The level data exposes stable ECHO, sensor and barrier identities, distinct body/ECHO routes, explicit `ECHO_ONLY` eligibility, delayed opening and wrong-actor failure. These data cues support color-independent glyph/text and route-link presentation under the existing schema-v2 presentation contract. No scene or rendering code changed. Status is `MACHINE_CONTRACT_READY_OWNER_REVIEW_PENDING`, not owner acceptance.

## Protected surfaces

Catalog remains exactly eight entries and sequence 8 remains the sole formal finale. No existing level, schema, loader, Simulation, BFS, Aggregate, complete-v2, wrapper, scene, gameplay/presentation code or Profile surface changed. Profile was not accessed. DeepSeek was not invoked.

C07/0024BA is not authorized. Only explicit GPT acceptance can open it.
