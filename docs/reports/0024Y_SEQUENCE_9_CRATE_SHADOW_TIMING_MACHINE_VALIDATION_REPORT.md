# Task 0024Y sequence-9 crate-shadow timing machine-validation report

- Date: 2026-07-22
- Task: `tasks/0024Y_sequence_9_crate_shadow_timing_candidate_authoring_and_machine_validation.md`
- Validation baseline: `bcb46aa80d6df83716124524dacedb1ebdf6ac03`
- Terminal verdict: `SEQUENCE_9_CRATE_SHADOW_TIMING_MACHINE_VALIDATED_FOR_GPT_REVIEW`
- Classification: uncatalogued sequence-9 core candidate; not product admission

## Scope and candidate

Task 0024Y authored one schema-v2 candidate, `crate_shadow_timing / Crate-Shadow Timing`, and validated it directly through public `LevelLoader.load_file`, shared `Simulation` and the accepted BFS solver. The 9×7 room contains one delay-2 ECHO (`echo_phase`), one YOU-only crate (`crate_phase`), one v1 Plate (`plate_window`), one initially closed v1 Door (`door_window`) and one YOU-only EXIT. Keys, locks, grouped barriers, typed sensors and latches are empty.

The room deliberately separates the lower YOU route from the upper ECHO lane. YOU pushes the crate from `[2,2]` to persistent rest `[3,2]`; the delayed ECHO later replays `DOWN` into that occupied cell and remains at `[3,1]`. The resulting phase reaches Plate `[4,2]`, keeps Door `[5,4]` open while YOU enters it, and then leaves a two-diamond exit route that supplies bounded shortest-solution multiplicity without changing the mechanic.

The formal candidate is not in `data/catalog`, does not change progression or finale state and has no Profile route.

## Authoring history

Every Godot authoring iteration used the accepted ownership-aware wrapper, invoked cleanup exactly once, retained no owned or unproven PID and returned total Godot count to zero.

- Search records `003–008` explored the hard-cut one-crate/one-ECHO/one-Plate-Door envelope. Early searches found no candidate or found numerical candidates whose witness lacked the crate-block event. Search 008 found an initial event-bearing geometry, but focused proof later showed shortest-path omissions.
- Focused records `009–018` rejected unsolved layouts, crate-free/no-push bypasses, out-of-band `L*`/`N*`, and candidates where WAIT or static collision substituted for the crate phase event.
- Focused 019 reached `L*=13`, `N*=9`, but only 8/9 shortest solutions had the full event; one leading blocked `RIGHT` resynchronized against a wall.
- Focused 020 opened the resynchronization cell, but this permitted a second push and all eight shortest solutions omitted the ECHO-crate block.
- Focused 021–027 tested a dynamic-door phase barrier. These variants were rejected for `L*=11–12`, excessive `N*`, omissions or the 20,000 ms solver/all-shortest limit.
- Focused 028 achieved `L*=13` with zero omissions but only `N*=1` and therefore failed the hard multiplicity band.
- Focused 029 added two equal post-Door route diamonds and a fixed pre-Door detour. It reached the final `L*=14`, exact `N*=6`, 6/6 full-event proof and zero omissions; only control coordinates/qualification expression still needed correction.
- Focused 030 passed with temporary diagnostics. Focused 031 removed those diagnostics, retained bounded formal JSON lines and passed cleanly. It was the last authoring check before the final retained cycle.

No test condition was weakened to widen an admission band. The static control records separately that its numerical `L*`/`N*` match baseline, while the required crate temporal structure is absent; therefore the conjunction of baseline metrics and temporal structure is not reproduced.

## Solver, witness and temporal proof

Final focused facts:

- status `SOLVED`;
- `L*=14`;
- exact `N*=6`;
- visited states `2559`, maximum frontier `396`, retained elapsed time `580 ms`;
- limits: depth `48`, states `250000`, time `20000 ms`, count cap `1000000`;
- consequential pushes `1`, waits `0`, blocked-YOU actions `0`;
- deterministic replay `true`, completion `true`, canonical trace length `15`;
- exact restart `true`; changing crate position changes the canonical key.

Deterministic shortest witness:

```text
DOWN RIGHT DOWN DOWN DOWN RIGHT RIGHT UP RIGHT UP RIGHT UP RIGHT UP
```

Required event indices are:

1. action 2: YOU legally pushes `crate_phase` from `[2,2]` to `[3,2]`;
2. action 3: delayed ECHO replays `DOWN`, targets the crate-occupied `[3,2]`, remains at `[3,1]`, and does not move the crate;
3. action 9: ECHO alone remains on `plate_window` `[4,2]`, Door is open in the start snapshot, and YOU enters `door_window` `[5,4]`;
4. action 14: YOU reaches EXIT `[7,1]` and completes; ECHO never completes the room.

The retained trace contains before/action/after facts for player, ECHO, crate, history, Plate, Door and completion at all four indices.

## All-shortest and necessity proof

The independent instrumented search uses `Simulation.transition` and canonical state plus ordered event mask; it does not implement a parallel transition system.

- goal depth `14`;
- completed shortest paths `6`, equal to solver exact `N*`;
- full mask `7`: `6/6`;
- omissions: `0`;
- maximum pushes across shortest solutions: `1`;
- visited composite states: `4814`.

Controls:

- no-push: complete finite-state unsolved, `99` states, frontier `46`;
- displaced crate at `[3,5]`: public-schema-valid, complete finite-state unsolved, `3275` states, frontier `368`, no full event chain;
- static wall at intended rest `[3,2]`: solved at the same `14/6` numerical metrics, but has no crate and cannot reproduce the required YOU-push → later ECHO-crate-block temporal structure; combined baseline-metrics-and-temporal reproduction is `false`;
- no ECHO: complete finite-state unsolved, `23` states, frontier `5`.

Shortcut/rule probes pass: Door is a terrain articulation; ECHO contact cannot move the crate; the synthetic illegal YOU push into wall `[5,2]` moves neither YOU nor crate and still records history; the witness has no repeated blocked-input macro; ECHO on EXIT is nonterminal; YOU cannot complete the intended dependency without ECHO; restart leaves no crate/Plate/Door/history/completion residue.

## Final retained qualification

- Invocation: `0d9ee9ef-3213-4266-a94c-6b8e8a0ae44b`
- Started/completed UTC: `2026-07-22T08:17:34.0871477Z` / `2026-07-22T08:18:52.3673184Z`
- Final summary SHA-256: `b5a902aceb52afe613c32f79bb9fd30794bd2daba2f040ac23856368049325d2`

| Case | Record SHA-256 | Wrapper/native | Marker | stderr | Cleanup | Godot before/after | Result |
|---|---|---:|---|---|---:|---:|---|
| focused 0024Y | `91262896fa5f2383b28a696b0be774f33c8dc9d91989eb22b1d0fe2daa05f65d` | `0/0` | exact once | empty | 1 | `0/0` | PASS |
| Aggregate | `02aab856493da65c0c5c79ddfacf6db0d226663629a5d689e40d93ba62c4ac04` | `0/0` | exact `TASK_0003_TESTS_PASS assertions=621 vectors=9`, once | exactly `LEVEL_ID_MISMATCH` | 1 | `0/0` | PASS |
| corrected complete-v2 | `db9d0a911804b60ce60d89e65530267211a5d5907dd02e33b2907546d7acfb37` | `0/0` | exact once | empty | 1 | `0/0` | PASS |

All three cases recorded direct ownership, no unproven record, no remaining owned/unproven PID and final Godot count zero. The final retained cycle is consumed and was not rerun.

## Frozen hashes and principal artifact identities

Pre-final and post-final audits both matched the Task 0024W seal SHA-256 `0e288adfe29c5881ab1f8cf40adf2df842a6fbbb8c6e5bce7aa14c797cf67ec0`: 53 sealed repository files and 12 historical external evidence files had zero mismatch. No 0024W driver/case was rerun and no sealed or external evidence artifact was modified.

The exact 50-path changed-file inventory and SHA-256 map is `tests/tools/task_0024y_changed_path_hash_manifest.json`, SHA-256 `5c635e0e9cda97252d269d2cbbc8b10b654e6ca2d5405b8416cf4b1c9d472c72`. It excludes only itself and this report: the manifest cannot hash itself, and including the report would create a report↔manifest self-reference. Together with this named report path, it is the complete 52-path Task 0024Y change inventory.

| Path | SHA-256 |
|---|---|
| `data/levels/crate_shadow_timing.json` | `1910f4dc07b1ee508ddbc529b0f0d02db5ca8a3a16a7a277ed236b4efbbe50d1` |
| `tests/levels/task_0024y_crate_shadow_timing_validation.gd` | `e81564034bcdf78e62fb2099a11b023d06a8453ca628f15fc2be7617d48a6508` |
| `tests/tools/task_0024y_run_case.ps1` | `9a36e446b00119adcd5203751619af08db5c4b3ffd888473df143232678bc4a9` |
| `tests/tools/task_0024y_final_qualification.ps1` | `09183385c07c3bc619af5bad1e354177a4db29a2dad9ce3678e16c60f697aa57` |
| `docs/level_design/validation/sequence_09_crate_shadow_timing_validation.json` | `3012eaa965b3a90d271006ebaee121c23fcd92c753ad3520c69d663f9b130c4f` |

All authoring/final/audit records and helper paths are inside the Task 0024Y allowlist. No dedicated `.gd.uid` was generated.

## Boundary and conclusion

Production Profile content, metadata, siblings, ordinary user data and the test-profile root were not accessed. Catalog, progression, finale, existing levels/tests, foundation implementation, Gameplay/UI, localization, assets/fonts/audio, build/export, release, upload and submission were not modified or authorized.

Owner playthrough remains `PENDING_LATER_CURRICULUM_GATE`; catalog admission remains `NOT_AUTHORIZED`. This result is machine validation ready for GPT review, not formal level admission or final acceptance:

`SEQUENCE_9_CRATE_SHADOW_TIMING_MACHINE_VALIDATED_FOR_GPT_REVIEW`
