# Task 0015 Level 7 two-ECHO convergence implementation report

- Task: `tasks/0015_level_7_two_echo_convergence_implementation.md`
- Start checkpoint: `HEAD == origin/main == e5f9a856ac2e1b921830aef5fa720d56d5f666c1`
- Branch: `main`
- Toolchain: Godot `4.7.stable.steam.5b4e0cb0f`, Compatibility renderer
- Godot command note: the PowerShell `godot` alias is unresolved; every run used `D:\Program Files (x86)\Steam\steamapps\common\Godot Engine\godot.windows.opt.tools.64.exe`
- Result: `INTERNAL_PLAYABLE / PASS_FOR_GPT_REVIEW`
- Formal SHA-256: `772410d3b8bb807e35472ee2a7d07b703de66e1e0e92ffb4d1ff8433a345d5fd`

## Bounded authoring result

Eight geometry iterations were evaluated against the frozen 9×7/two-ECHO/A+B envelope. Early candidates were rejected for automatic corridor traversal, complete unsolvability, a repeated blocked-input macro, or `N*=12` above the hard band. Candidate 8 adds one readable crossover to the Task 0014 figure-eight seed and is the first candidate satisfying all quantitative, necessity, bypass, recovery, and presentation gates. No target or limit was weakened.

Final formal facts: shared spawn `[1,5]`; `echo_near` delay 2; `echo_late` delay 4; `plate_a=[6,3]`; `plate_b=[7,5]`; initially closed `door_convergence=[7,2]` depending exactly on A+B; player-only EXIT `[7,1]`. The Door is an unavoidable terrain articulation.

## Exact solver and proof evidence

Limits: depth 64, states 500,000, time 30,000 ms, count cap 1,000,000. Shared BFS returned `L*=19`, `N*=6 EXACT`, visited 61,975, maximum frontier 21,449. The solver API exposes no solver-only elapsed time.

Witness:

```text
RIGHT RIGHT RIGHT RIGHT RIGHT RIGHT UP UP UP LEFT RIGHT DOWN DOWN UP DOWN UP UP UP UP
```

The selected witness has no WAIT. It contains one non-repeated closed-Door probe at turn 9, not a wall-collision macro and not a counted decision. At turn 17, E2 is on A and E4 is on B; Door becomes open. Turn 18 begins from that open snapshot and YOU enters the Door; turn 19 reaches EXIT. The required two-ECHO convergence lasts one result turn. All six shortest solutions use this exact role event; bypass count is zero.

## Control and difficulty audit

Complete-unsolved controls: only E2 (750/140), only E4 (18,750/3,500), no ECHO (30/5), relocate A (18,750/3,500), relocate B (18,750/3,500), 2/2 (750/140), and 4/4 (18,750/3,500), where each pair is visited/frontier. A-only becomes `L=11, N=70 EXACT`; B-only becomes `L=10, N=1 EXACT`; Door removal becomes `L=10, N=30 EXACT`. Overlap cannot satisfy two distinct Plate cells; EXIT, restart, replay, articulation, and side-route controls passed.

Six meaningful decisions have exact recoverable penalties `+2, +2, +5, +2, +3, +2`; this exceeds the required four decisions and three +2–6 recoveries. Three shortest solutions include optional WAIT-equivalent timing and three do not. WAIT is not necessary or taught, and no WAIT research claim is made.

## Catalog, runtime, presentation, and capture

The catalog has exactly seven entries. Level 6 is no longer final; Level 7 is the sole final entry and requires Level 6. Initial progress unlocks only Tutorial 0, completion unlocks Levels 2–7 in order, direct routing accepts Level 7, and reset is exact.

The only Gameplay change is a reusable multi-ECHO/AND cue primitive in `scripts/gameplay/vertical_slice.gd`: A/triangle, B/circle, `A+B` independent pips, E2 solid outline, E4 double-dashed outline, and overlap-preserving badges. It is data-derived and contains no route or solution hardcoding. Timeline indexing/layout and Help architecture/copy remain unchanged.

Eight game-window-only captures passed: locked, unlocked, initial cues, overlap, convergence, following open-snapshot crossing, completion, and grayscale decision frame. No desktop or hosted preview was used.

## Regression

Focused marker: `TASK_0015_LEVEL_7_TWO_ECHO_CONVERGENCE_TESTS_PASS`.

Aggregate native exit is 0 with `367 assertions / 9 vectors`. All markers appear exactly once:

```text
TASK_0003_TESTS_PASS assertions=367 vectors=9
TASK_0006_APP_SHELL_TESTS_PASS
TASK_0007_TUTORIAL_LEVELS_TESTS_PASS
TASK_0008_PROGRESSIVE_HUD_TESTS_PASS
TASK_0009AR_LEVELS_4_5_TESTS_PASS
TASK_0011_PRESENTATION_RECOVERY_TESTS_PASS
TASK_0011R_WINDOW_FILL_TESTS_PASS
TASK_0012_LEVEL_6_STAGGERED_DOORS_TESTS_PASS
TASK_0015_LEVEL_7_TWO_ECHO_CONVERGENCE_TESTS_PASS
```

Aggregate stderr contains only the accepted intentional `LEVEL_ID_MISMATCH` negative-path diagnostic. All six prior level hashes and accepted metrics are unchanged.

## Scope, evidence, rollback, and non-claims

Repository changes stay within the Task 0015 authorized level, catalog, reusable Gameplay cue, focused tests/capture harness, aggregate, validation/report, and current-source paths. No project setting, simulation, solver, app, scene, schema, prior level, fixture, Timeline model, asset, dependency, user data, build, export, release, account, or repository setting changed.

External evidence root: `D:\Delayed_Self_Evidence\0015_two_echo_convergence\`; its index records commands, separated stdout/stderr, native exits, candidate ledger, controls, captures, sizes, and SHA-256. Nothing there is staged.

Rollback is one ordinary revert of the Task 0015 implementation commit; no history rewrite is required.

This report does not claim fresh/independent or authenticated-owner Level 7 review, human difficulty/fun/balance, candidate acceptance, final presentation, assets/audio/narrative, complete flow, export, release, or submission readiness. The owner remains the only available playtester. Level 8 and all production/release surfaces remain unauthorized. Recommended next gate: GPT review of the exact diff and evidence, followed only if accepted by a separately bounded authenticated-owner Level 7 review.
