# Task 0024Z sequence-10 key-route commitment machine-validation report

- Date: 2026-07-22
- Task: `tasks/0024Z_sequence_10_key_route_commitment_candidate_authoring_and_machine_validation.md`
- Validation baseline: `5180dcacdf29336cde6248f7536f081b88510d9a`
- Terminal verdict: `SEQUENCE_10_KEY_ROUTE_COMMITMENT_MACHINE_VALIDATED_FOR_GPT_REVIEW`
- Classification: uncatalogued sequence-10 core candidate; not GPT accepted or catalog admitted

## Scope and candidate

Task 0024Z authored one schema-v2 candidate, `key_route_commitment / The Key Is Yours`, and validated it directly through public `LevelLoader.load_file`, shared `Simulation` and the accepted BFS solver. The 9×7 room contains one delay-2 ECHO (`echo_route`), one YOU-only `main` key (`key_main`), one matching lock (`lock_main`), one v1 Plate (`plate_route`), one initially closed v1 Door (`door_route`) and one YOU-only EXIT. Crates, grouped barriers, typed sensors and latches are empty.

The key sits in a lower detour off the direct main route. With the intact lock, YOU must enter the detour, collect the key and return; those actions write the delayed history that later puts ECHO alone on the Plate. YOU then spends the key and enters the former lock cell on the same accepted turn. Removing the lock shortens the room from `19/8` to `11/7`, so the key/lock is a route commitment rather than cosmetic walking distance.

The candidate is absent from `data/catalog`, changes no progression/finale/Profile state and has no Gameplay/UI route.

## Authoring history

Every Godot authoring iteration used the accepted ownership-aware wrapper, invoked cleanup exactly once, retained no owned or unproven PID and returned total Godot count to zero.

- Probe 001 found an overly open first geometry at `L*=12`, exact `N*=3`.
- Probe 002 correctly rejected an initially inconsistent Door because ECHO spawned on the Plate while the Door declared closed.
- Probes 003–004 progressively constrained the route (`14/61`, then `15/11`) but remained outside the frozen bands.
- Probes 005–006 exposed right-tail shortcuts (`11/8`, then `13/8`).
- Probe 007 reached `16/50`; delay-3 produced too many equivalent timing actions.
- Probe 008 reached the numerical target `15/8`. Focused 009 rejected it because the no-lock control reproduced the same `15/8`, showing the key remained on a mandatory walking line. Focused 010 retained the diagnostic control result; no assertion was weakened.
- Probe 011 moved the key into a true lower detour and reached the final `L*=19`, exact `N*=8`.
- Focused 012 passed the complete contract with a temporary no-lock diagnostic. Focused 013 removed the diagnostic, retained bounded JSON lines and passed cleanly. It was the last authoring check before the unique retained cycle.

No target band or control was widened. The final retained cycle is consumed and was not rerun.

## Solver, witness and temporal proof

Final focused facts:

- status `SOLVED`;
- `L*=19`;
- exact `N*=8`;
- visited states `1063`, maximum frontier `152`, retained elapsed time `226 ms`;
- limits: depth `56`, states `400000`, time `25000 ms`, count cap `1000000`;
- waits `0`, blocked-YOU actions `1`, maximum repeated identical blocked macro `1`;
- deterministic replay `true`, completion `true`, canonical trace length `20`;
- exact restart `true`; canonical keys distinguish remaining-key, held-key and removed-lock states.

Deterministic shortest witness:

```text
DOWN DOWN RIGHT RIGHT LEFT LEFT UP UP RIGHT RIGHT UP RIGHT RIGHT RIGHT RIGHT UP UP LEFT LEFT
```

Required event evidence is:

1. action 4: YOU enters `key_main` `[3,5]`, removes it from remaining keys and gains one held `main` key;
2. shared-Simulation ECHO-item probe: ECHO enters the key cell while remaining keys and inventory stay unchanged;
3. shared-Simulation intact-lock probe: ECHO targets `lock_main` and remains blocked without inventory or removal changes;
4. action 12: YOU enters `lock_main` `[4,3]`; on that same turn `lock_main` is removed and the held `main` key is consumed;
5. action 13: Door is open in the start snapshot, ECHO alone occupies `plate_route` `[3,1]`, and YOU enters `door_route` `[5,3]`;
6. action 19: YOU reaches EXIT `[5,1]` and completes; a separate ECHO-on-EXIT probe remains nonterminal.

The retained trace includes before/action/after player, ECHO, remaining keys, held keys, removed locks, history, Plate, Door and completion facts.

## All-shortest and necessity proof

The independent instrumented search uses `Simulation.transition` and canonical state plus ordered event mask; it does not implement parallel transitions.

- goal depth `19`;
- completed shortest paths `8`, equal to solver exact `N*`;
- full mask `7`: `8/8`;
- omissions: `0`;
- visited composite states: `1156`.

Controls:

- no key: schema-valid complete finite-state unsolved, `277` states, frontier `86`;
- no lock: schema-valid solved at `L*=11`, exact `N*=7`; metrics materially change and the lock event is absent;
- displaced key at `[6,3]`: schema-valid complete finite-state unsolved, `277` states, frontier `86`, ordered chain eliminated;
- ECHO-item route: ECHO contact changes neither remaining keys, held keys nor removed locks and cannot cross/remove the intact lock;
- no ECHO: schema-valid complete finite-state unsolved, `21` states, frontier `2`.

Shortcut/rule probes pass: the intact lock is a route articulation with no walk-around; YOU without a held `main` key cannot enter/remove it; matching removal consumes exactly one key and enters on the same turn; ECHO cannot collect, hold, remove or cross; the accepted chain collects before removal and has no post-removal key; there is no direct EXIT bypass; ECHO on EXIT is nonterminal; blocked macro length is bounded; restart restores key, lock, inventory, Plate, Door, history and completion with zero residue.

## Final retained qualification

- Invocation: `e0b62d7e-539e-415e-aea9-a9bc40d16c26`
- Started/completed UTC: `2026-07-22T09:43:06.0975913Z` / `2026-07-22T09:44:27.6813688Z`
- Final summary SHA-256: `d0af0ad04fe8d503778269624bd8cedc9014e6778a3e740189b2472d77ed3295`

| Case | Record SHA-256 | Wrapper/native | Marker | stderr | Cleanup | Godot before/after | Result |
|---|---|---:|---|---|---:|---:|---|
| focused 0024Z | `403b0ed9f0e90624d97e979e86e03f7888f93c21cd75cb8215b1ec8b619d6310` | `0/0` | exact once | empty | 1 | `0/0` | PASS |
| accepted focused 0024Y | `e364935346e0801d7539df56ab1e0104ed05781b6b2384bb1976e48d6fb78ad9` | `0/0` | exact once | empty | 1 | `0/0` | PASS |
| Aggregate | `2f78185e74e2865a31ea55f45c42afb705f2e5d1f849d75ea25386580f0ce08f` | `0/0` | exact `TASK_0003_TESTS_PASS assertions=621 vectors=9`, once | exactly `LEVEL_ID_MISMATCH` | 1 | `0/0` | PASS |
| corrected complete-v2 | `835011eac24c2dda50496387259b3793aa57b72f188abb62f26ab201008f2247` | `0/0` | exact once | empty | 1 | `0/0` | PASS |

All four cases recorded direct ownership, no unproven record, no remaining owned/unproven PID and final Godot count zero.

## Frozen hashes and principal artifact identities

Pre-task, pre-final and post-final audits matched Task 0024W seal SHA-256 `0e288adfe29c5881ab1f8cf40adf2df842a6fbbb8c6e5bce7aa14c797cf67ec0`: 53 sealed repository files and 12 historical external evidence files had zero mismatch. Accepted sequence-9 and wrapper hashes also remained exact. No 0024W or 0024Y final driver was rerun and no sealed/external artifact was modified.

| Path | SHA-256 |
|---|---|
| `data/levels/key_route_commitment.json` | `2c44c8cdeeeb6f502f5c5d9dda87883dd762515348ee3c4b6d71d34fde276a2a` |
| `tests/levels/task_0024z_key_route_commitment_validation.gd` | `f80a50cc95190783b1586dd816e6f6cfd156caec9821a7c77a004968afdea709` |
| `tests/tools/task_0024z_run_case.ps1` | `739288c83f0054b10e66691ab9dca05c83778fb07854c7ad05590a7fabac6725` |
| `tests/tools/task_0024z_final_qualification.ps1` | `753dcd86bea0cd9dd0f3cb2512ca6b3739f3d4d3893d2582e1a3118e0c335f70` |
| `tests/tools/task_0024z_final_qualification_summary.json` | `d0af0ad04fe8d503778269624bd8cedc9014e6778a3e740189b2472d77ed3295` |
| `docs/level_design/validation/sequence_10_key_route_commitment_validation.json` | `26acd07fbe476e3b9f2ff7d2923ef3ec527759ae83f38c61349d230d22d23dba` |
| `tests/tools/task_0024z_pre_final_frozen_hash_audit.json` | `fd2cfa8d6103e069118d24e189f2833f5f64fb5eb8b9eebf2630bb6f36d17600` |
| `tests/tools/task_0024z_post_final_frozen_hash_audit.json` | `df0f14fa8099d37baa9249bf292f8e830435173f091c6f62ecf6046e51e5c6c4` |

The exact 36-path changed-file inventory and SHA-256 map is `tests/tools/task_0024z_changed_path_hash_manifest.json`, SHA-256 `cbc682b60294687e81c2fe22f1dcb3e7f0a2244e7865ce314902691d33aef959`. It excludes only itself and this report to avoid self-reference. Together with this named report path, it is the complete 38-path Task 0024Z change inventory. No dedicated `.gd.uid` was generated.

## Boundary and conclusion

Production Profile content, metadata, siblings, ordinary user data and the test-profile root were not accessed. Catalog, progression, finale, accepted sequence-9 artifacts, existing levels/tests, foundation implementation, Gameplay/UI, localization, assets/fonts/audio, build/export, release, upload and submission were not modified or authorized.

Owner playthrough remains `PENDING_LATER_CURRICULUM_GATE`; catalog admission remains `NOT_AUTHORIZED`. This result is machine validation ready for GPT review, not formal admission or final acceptance:

`SEQUENCE_10_KEY_ROUTE_COMMITMENT_MACHINE_VALIDATED_FOR_GPT_REVIEW`
