# Task 0012 Level 6 `staggered_doors` report

- Task: `tasks/0012_difficult_level_6_staggered_doors.md`
- Gate: `IMPLEMENTATION + FORMAL VALIDATION / DIFFICULT CONTENT`
- Baseline `HEAD == origin/main`: `cf73aedb26022b2a8e4db82a42f5d2e7e4eb1bc0`
- Toolchain: Godot `4.7.stable.steam.5b4e0cb0f`, Compatibility renderer
- Result: `INTERNAL_PLAYABLE / PASS_FOR_GPT_REVIEW`
- Formal level SHA-256: `3f14c19b50775e36dd5b52664798381cf1292b0a30b377641c03435f45696bc8`

## Authoring result

Two bounded candidates were evaluated. Candidate 1 met the numerical bands but was rejected because the late dependency line crossed `door_early`, making the primitive relationship display ambiguous. Candidate 2 was selected after solver, runtime, capture, and visual review.

The final 9×7 room uses shared YOU/ECHO spawn `[1,5]`, one delay-3 ECHO, `plate_early` at `[2,4]`, `plate_late` at `[3,5]`, `door_early` at `[4,4]` depending on `plate_early`, `door_late` at `[6,4]` depending on `plate_late`, and EXIT `[4,1]`. There are 16 traversable terrain cells. Each Door is a terrain articulation point on every YOU-to-EXIT route. The two dependency lines remain visually separate and do not cross or pass through the other Door.

## Exact solver evidence

Limits were depth `64`, states `500000`, time `30000 ms`, and solution-count cap `1000000`. The solver returned:

- `SOLVED`, `L*=15`;
- `N*=4`, status `EXACT`;
- visited states `6772`;
- maximum frontier `1179`;
- witness: `UP RIGHT RIGHT DOWN UP RIGHT RIGHT RIGHT RIGHT UP UP UP LEFT LEFT LEFT`.

The solver API does not expose elapsed time. The complete aggregate process, including all prior suites, took approximately `10379 ms`; this is not represented as solver-only timing. The witness has no literal `WAIT` and no blocked YOU move. Shared Simulation replay reaches EXIT in exactly 15 actions, and restart reconstructs the exact initial state.

## Two distinct Door windows

Early window:

1. Before action 5, `door_early` is closed, YOU is `[3,5]`, ECHO is `[1,4]`, and history is `RIGHT RIGHT DOWN`.
2. Action 5 `UP` moves ECHO to `[2,4]`, pressing `plate_early`; the result opens `door_early` with YOU `[3,4]`.
3. Action 6 starts from that open snapshot; `RIGHT` moves YOU into `[4,4]`.
4. Settlement closes the Door around/behind YOU because the ECHO has left `plate_early`.

Late window:

1. Before action 7, `door_late` is closed, YOU is `[4,4]`, ECHO is `[3,4]`, and history is `DOWN UP RIGHT`.
2. Action 7 `RIGHT` moves ECHO to `[3,5]`, pressing `plate_late`; the result opens `door_late` with YOU `[5,4]`.
3. Action 8 starts from that open snapshot; `RIGHT` moves YOU into `[6,4]`.
4. Settlement closes the Door around/behind YOU because the ECHO has left `plate_late`.

Exact enumeration showed all four shortest solutions cross both Door positions from open start-turn snapshots; event-mask counts were `{both:4, neither:0, early_only:0, late_only:0}`.

## Necessity and bypass controls

All controls used the same exact limits unless noted:

| Control | Result |
|---|---|
| no ECHO | complete finite-state unsolved; visited 6, frontier 2 |
| isolate `plate_early` | complete finite-state unsolved; visited 750, frontier 325 |
| isolate `plate_late` | complete finite-state unsolved; visited 3911, frontier 875 |
| remove `door_early` | `L=13`, `N=1 EXACT`, visited 2936, frontier 847 |
| remove `door_late` | `L=15`, `N=48 EXACT`, visited 6865, frontier 1309 |
| make `door_early` depend on `plate_late` | `L=15`, `N=11 EXACT`, visited 6554, frontier 1121 |
| make `door_late` depend on `plate_early` | `L=15`, `N=14 EXACT`, visited 6743, frontier 1367 |

The no-ECHO and Plate-isolation searches ended by complete finite-state exhaustion, not resource limits. ECHO on EXIT does not complete. YOU completion, exact restart, and solver/runtime replay parity passed. Terrain removal audits prove neither Door can be bypassed. Legal actor overlap does not make a single actor or Plate hold the full route open; both windows close after entry. The accepted witness is not a wall-follow, repeated movement-cycle, long-wait, or blocked-input exploit.

## Meaningful decisions and WAIT boundary

Three non-repeated route/timing decisions were measured on the witness:

| Turn | Chosen / alternative | Outcome |
|---:|---|---|
| 3 | `RIGHT` / `LEFT` | recoverable; minimum total 17, penalty +2 |
| 9 | `RIGHT` / `LEFT` | recoverable; minimum total 22, penalty +7 |
| 12 | `UP` / `DOWN` | recoverable; minimum total 17, penalty +2 |

Each alternative creates a distinct canonical successor and misses the shortest route or timing window. None is a repeated blocked action. Literal WAIT is absent from the selected shortest witness, and no WAIT-relevance claim is made; WAIT remains `DEFERRED_VALIDATION_RESEARCH`.

## Catalog, progression, runtime, and presentation

The strict catalog now contains six entries. Level 5 is no longer final; Level 6 is the sole `final_level=true` entry and requires `two_keys_one_door`. Initial progress unlocks only Tutorial 0. Level 6 remains locked through Level 4 completion, Level 5 completion unlocks it, and reset restores the exact initial snapshot. Generic direct-level parsing accepts `staggered_doors` without parser changes.

AppRoot and reusable Gameplay smoke passed: matching level ID, `STANDARD_COMPACT`, Help modal/zero-turn, both primitive window cues inspectable, 15-action completion, normal return/progress recording, restart equality, and accepted input/window behavior. A bounded native Compatibility-renderer capture produced locked/unlocked Level Select, initial room, both windows, and completion images. Visual review found no material dependency-line ambiguity.

## Regression and immutable prior levels

Final aggregate exit code was `0`; stdout reported `349 assertions / 9 vectors`. Stderr contained only the accepted negative-path `LEVEL_ID_MISMATCH` diagnostic. Markers:

```text
TASK_0003_TESTS_PASS assertions=349 vectors=9
TASK_0006_APP_SHELL_TESTS_PASS
TASK_0007_TUTORIAL_LEVELS_TESTS_PASS
TASK_0008_PROGRESSIVE_HUD_TESTS_PASS
TASK_0009AR_LEVELS_4_5_TESTS_PASS
TASK_0011_PRESENTATION_RECOVERY_TESTS_PASS
TASK_0011R_WINDOW_FILL_TESTS_PASS
TASK_0012_LEVEL_6_STAGGERED_DOORS_TESTS_PASS
```

Prior formal files remained byte-identical:

| Level | SHA-256 | Accepted exact metrics |
|---|---|---|
| `tutorial_reach_exit` | `38e466bb5922f1987a99d79c7527a4a8eab8e6cfdbe76fd8159f80b0a40cf2c4` | `L*=3`, `N*=3`, visited 6, frontier 2 |
| `tutorial_echo_bridge` | `681d99057c4e6034a490644d75960ff23d8f43bd1b91850f48179b79fc04a3cf` | `L*=9`, `N*=12`, visited 1975, frontier 509 |
| `vertical_slice_delay_3` | `8751da5051fbebaaa5ae7c895d9be9f086e8d8f2e87876a80c379dc06262f1d8` | `L*=9`, `N*=31`, visited 1318, frontier 393 |
| `door_one_turn_late` | `1775cf89ae4a94f65a76dac2b791a31395443de88205d0ed1b6233331dbda577` | `L*=9`, `N*=7`, visited 291, frontier 116 |
| `two_keys_one_door` | `f4c6791dfc84d17fb450721e654091a2baeb522e55d660a5d73878cd977651cd` | `L*=12`, `N*=1`, visited 1260, frontier 225 |

## Evidence, scope, and rollback

External evidence is indexed at `D:\Delayed_Self_Evidence\0012_staggered_doors\EVIDENCE_INDEX.md`. It contains the candidate ledger, final separated stdout/stderr, native exit codes, exact traces/control results, and hashes for the six game-window captures. Nothing under the external evidence root is staged.

Repository changes are limited to the new formal level, the exact catalog append/final-flag transfer, focused validation/capture tests, aggregate assertions, this report, two Level 6 planning-status updates, and six narrow current documents. No project setting, runtime, solver, app/gameplay script, scene, schema, accepted fixture/contract, old level, asset, dependency, save, export, build, or release surface changed.

Rollback is one ordinary revert of the Task 0012 commit; no history rewrite is required.

## Non-claims and recommendation

This evidence establishes strict validity, exact solver metrics, necessity/bypass controls, replay parity, progression, primitive visibility, and internal playability. It does not establish fresh-player comprehension, human difficulty, fun, balance, candidate acceptance, final presentation, asset completeness, export, or release readiness.

Recommendation: `PASS_FOR_GPT_REVIEW`, followed only after GPT adjudication by a separately authorized fresh/independent Level 6 sequence review. Level 7 is not authorized.
