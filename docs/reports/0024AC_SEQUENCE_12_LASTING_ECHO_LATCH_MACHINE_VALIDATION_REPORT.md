# Task 0024AC sequence-12 lasting-echo latch machine-validation report

- Date: 2026-07-22
- Task: `tasks/0024AC_sequence_12_lasting_echo_latch_candidate_authoring_and_machine_validation.md`
- Validation baseline: `add661f5d545156aaf163ec065b31b4340403f1f`
- Terminal verdict: `SEQUENCE_12_LASTING_ECHO_LATCH_MACHINE_VALIDATED_FOR_GPT_REVIEW`
- Classification: `UNCATALOGUED_SEQUENCE_12_CORE_CANDIDATE`
- Finale status: `FINALE_CANDIDATE_ONLY`

## Result

Task 0024AC authored and machine-validated `lasting_echo_latch / The Lasting Echo / 余响落锁` through public `LevelLoader.load_file`, shared `Simulation` and the accepted BFS solver. The candidate remains absent from the catalog and changes no progression, formal finale, Profile, Gameplay/UI or release surface.

The 11×9 candidate contains one delay-2 ECHO, one ECHO-only one-shot latch `latch_phase`, exactly two typed sensors with `include_crates=false`, one two-cell latch target group `barrier_phase` and one two-cell phase-two group `barrier_typed`. Crates, keys, locks, v1 Plates and v1 Doors are empty. Although there are two grouped entities, there is exactly one latch target group, and the critical chain still contains only the three authorized mechanic families: latch, typed sensor and grouped barrier.

The latch permanently opens the paired phase gate. This separate target group is necessary because accepted Simulation gives an activated latch terminal override over its target group; using the same group for the later typed crossing would make the sensor result non-authoritative. Phase two therefore reuses sequence-11 language on `barrier_typed` without introducing another mechanic family.

## Authoring history

Every Godot authoring/qualification execution used the accepted owned-process wrapper, cleanup ran exactly once, no owned/unproven PID remained and Godot returned to zero.

| Attempt | Candidate SHA-256 | Result | Disposition |
|---:|---|---|---|
| 001 | `cf7d90df75179f103a80e0e8ac141545b6c9988aeba08b51e7fdaba0a6c9fee1` | `L*=23`, `N*=17` | discarded: phase-one admitted equivalent repeated blocked-UP histories |
| 002 | same as 001 | `23/17` | diagnostic-only rerun after adding bounded step records |
| 003 | `d0a09d0cd3641f553381583e877fc68e50fd3e0f358af479644599dede83115f` | `23/11` | discarded: bypass closed, but multiplicity and repeated blocked input remained |
| 004 | `12c35c6c5a4bdd7d288f405dc7e3b4c25d11469974b0cbe68a2046c6fe6f88a7` | `22/11` | discarded: gate approach still admitted equivalent waits |
| 005 | `a1d7dcd30832cfdcfe93ead34884fa5a21fd19ef3cafa481860688640bd5ea5f` | `21/6` | selected: structural two-step approach, one blocked YOU action, macro maximum one |

Focused qualification 001 retained a parse failure requiring two explicit `Dictionary` annotations. Qualification 002 retained a validator-state failure because its witness event mask restarted at zero each turn. Neither failure was relabeled. Qualification 003 passed the full contract. After parser qualification, independent qualification 004 also passed.

The first two capture summaries retained correct per-line byte counts but a null maximum aggregate due PowerShell `Measure-Object` behavior over ordered dictionaries. The parser was corrected without rerunning Godot; capture 003 reports the exact maximum of 932 bytes. Missing, duplicate, truncated, non-JSON and over-bound probes passed before and after that aggregation-only correction.

Complete authoring dispositions are retained in `tests/tools/task_0024ac_authoring_history.json`.

## Fresh focused solver and witness

Final focused facts:

- status `SOLVED`;
- `L*=21`;
- exact `N*=6`;
- visited states `13,459`, maximum frontier `1,389`;
- exact fresh `solver.elapsed_ms=3936`;
- limits: depth `80`, states `1,000,000`, time `45,000 ms`, count cap `1,000,000`;
- waits `0`, blocked YOU actions `1`, maximum repeated identical blocked macro `1`;
- deterministic duplicate replay, canonical trace length `22`, exact restart.

Deterministic witness:

```text
RIGHT UP RIGHT UP UP UP UP LEFT LEFT UP UP RIGHT RIGHT RIGHT RIGHT RIGHT RIGHT RIGHT RIGHT DOWN DOWN
```

Ordered retained events:

1. action 3: delayed ECHO replays `RIGHT`, enters `latch_phase`, activates it exactly once and permanently opens `barrier_phase`;
2. action 4: YOU and ECHO each enter their paired phase-gate cell only after activation;
3. action 13: exact YOU-only/ECHO-only occupancy opens `barrier_typed` for the next snapshot;
4. actions 14–15: YOU crosses both typed group cells while requested closure defers;
5. action 16: the typed group closes after vacancy while the latch and phase gate remain permanently active/open;
6. action 21: YOU reaches EXIT; ECHO does not complete.

## All-shortest and necessity proof

The instrumented proof uses only shared `Simulation.transition` and canonical state plus an ordered event mask. At goal depth 21 it counted six completed paths, equal to exact solver `N*`; all `6/6` have full mask `255`, omissions are zero, all have pre- and post-latch states, and none reaches EXIT before activation. The composite search visited 22,049 states.

Controls:

- latch disabled: complete finite-state unsolved, 620 states, frontier 138;
- latch reset/persistence rejected: complete finite-state unsolved, 620 states, frontier 96, 700 persistent transitions rejected;
- target reversed to terminal closed: complete finite-state unsolved, 1,100 states, frontier 190;
- direct post-latch route: solved at `L*=20`, exact `N*=1`, phase transition removed and metrics materially changed;
- no ECHO: complete finite-state unsolved, 7 states, frontier 1;
- ECHO sensor simplified to `ANY_ACTOR`: remains `21/6`, but eligibility expands to YOU/ECHO and eliminates the exact typed-identity claim.

Shortcut probes pass for pre-latch EXIT exclusion, one-time persistent activation, repeated contact, exact restart and no attempt leakage, phase-two typed articulation, ECHO-on-EXIT noncompletion, phase-gate terrain articulation, blocked macro bound and the three-family limit.

## Bounded evidence

The focused validator emits 15 independently parseable records: one metrics, one witness, eight event, one all-shortest, two control, one shortcuts and one replay/restart record. Every line is strictly below 1800 UTF-8 bytes; the exact maximum is 932. The metrics line retains the fresh exact integer `elapsed_ms=3936`.

The parser rejects missing, duplicate, truncated, non-JSON and over-bound records. Final capture SHA-256 is `0584f6e090b9712e9c87049bbb617a2d821f5876332be5bb2434167309768257`.

## Fresh retained six-case cycle

- Invocation: `f56d4606-244b-4b82-b35e-93a413470840`
- Manifest SHA-256: `e5bd4df8d57787e46970f057fec78280e9f5873b6a7c5023fa743a30eb64e8a5`

| Case | Record SHA-256 | Wrapper/native | Marker | stderr | Cleanup | Godot before/after | Result |
|---|---|---:|---|---|---:|---:|---|
| focused 0024AC | `7affb90d787a936555a8df362ee459531927c550320de886213adc9b590207f1` | `0/0` | exact once | empty | 1 | `0/0` | PASS |
| accepted focused 0024AB | `aa97928f48f0582ca6666c369c198574d876b528a801b3f4a122422dd8f9d270` | `0/0` | exact once | empty | 1 | `0/0` | PASS |
| accepted focused 0024Z | `16b01dbf6c762461d7290fac95d34aa3f05cb5a20458d90c8bf96a08f8778d9b` | `0/0` | exact once | empty | 1 | `0/0` | PASS |
| accepted focused 0024Y | `12fe6c55188dd380536b489eed6a0e065f7ef866f5db5a2db29354a0969326b4` | `0/0` | exact once | empty | 1 | `0/0` | PASS |
| Aggregate | `bd22e76e042236f487458363bde581ae09a5fb6268acb63f0cfdba270ede9309` | `0/0` | exact `TASK_0003_TESTS_PASS assertions=621 vectors=9`, once | exactly `LEVEL_ID_MISMATCH` | 1 | `0/0` | PASS |
| corrected complete-v2 | `bb96ca40253cab827d81b02981a566e00fdee2c4f9a80153948e161514380daf` | `0/0` | exact once | empty | 1 | `0/0` | PASS |

Every case retained direct ownership, zero unproven records, zero remaining owned/unproven PIDs and final Godot zero. The final cycle is consumed and may not be rerun.

## Frozen hashes and boundaries

PRE_TASK, PRE_FINAL and POST_FINAL audits all passed:

- Task 0024W seal SHA-256 `0e288adfe29c5881ab1f8cf40adf2df842a6fbbb8c6e5bce7aa14c797cf67ec0`;
- 53 sealed repository and 12 historical external evidence files, zero mismatch;
- catalog and all eight formal levels, zero drift;
- accepted sequence-9/10/11 candidate/test/summary/report identities, zero drift;
- 19 historical Task 0024AA paths and 37 historical Task 0024AB paths, zero drift;
- wrapper blob `5f14eb0feff903b40311c1c7283b20e2eabbffc2` exact.

Production Profile content, metadata, siblings, ordinary user data and the test-profile root were not accessed. Catalog admission, progression, formal finale movement, Profile integration, owner playthrough, Gameplay/UI, localization, assets/fonts/audio, build/export, release, upload and submission remain unauthorized.

`owner_playthrough_status = PENDING_LATER_CURRICULUM_GATE`

`catalog_admission_status = NOT_AUTHORIZED`

`SEQUENCE_12_LASTING_ECHO_LATCH_MACHINE_VALIDATED_FOR_GPT_REVIEW`
