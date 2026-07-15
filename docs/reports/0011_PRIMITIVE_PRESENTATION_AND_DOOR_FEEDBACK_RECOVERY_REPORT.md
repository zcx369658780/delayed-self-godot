# Task 0011 primitive presentation and Door-feedback recovery report

## Task and Git facts

- Task: `tasks/0011_primitive_board_hud_and_door_feedback_recovery.md`
- Repository/root: `zcx369658780/delayed-self-godot`, `D:\Delayed_Self`
- Branch: `main`
- Starting local `HEAD` and `origin/main`: `03f5610e87e1645088c01e8c34974d057130eaf1`
- Toolchain: Godot `4.7.stable.steam.5b4e0cb0f`, Compatibility renderer
- Commit policy: exactly one scoped commit, `feat: recover Delayed Self board HUD and door feedback`
- External evidence: `D:\Delayed_Self_Evidence\0011_presentation_recovery\EVIDENCE_INDEX.md`

The startup worktree was clean and the expected origin was configured. The implementation does not claim GPT acceptance; the final commit and normal push are performed only after the authorized-path and remote-drift audits.

## Implementation result

Task 0011 recovers the primitive five-level presentation without changing puzzle, level, catalog, solver, route, or progress semantics. All five catalog entries still instantiate `scenes/vertical_slice/vertical_slice.tscn` and use `scripts/gameplay/vertical_slice.gd`.

Changed implementation/test paths:

- `scenes/vertical_slice/vertical_slice.tscn`;
- `scripts/gameplay/vertical_slice.gd`;
- `tests/run_all.gd`;
- `tests/gameplay/task_0011_presentation_recovery.gd`;
- `tests/gameplay/capture_task_0011.gd`.

The only other repository changes are this report and narrowly necessary current-document pointers. No Timeline pointer logic change was needed, so `scripts/gameplay/timeline_model.gd` remains unchanged.

Changed documentation paths:

- `docs/reports/0011_PRIMITIVE_PRESENTATION_AND_DOOR_FEEDBACK_RECOVERY_REPORT.md`;
- `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`;
- `docs/CODEX_ACTIVE_TASK_CURRENT.md`;
- `docs/DOC_INDEX_CURRENT.md`;
- `docs/DEVELOPMENT_PLAN_CURRENT.md`;
- `docs/HANDOFF_MASTER_CURRENT.md`;
- `docs/project_memory.md`.

## Input-timing approach and authority boundary

The implementation uses Approach A, non-blocking presentation. Each gameplay input enters the existing `_unhandled_input` path exactly once; the accepted `Simulation.transition` result commits immediately. A later input replaces the transient presentation record deterministically. No queue, animation-owned rule, collision decision, Door calculation, transition call, or canonical-state field was added.

The presentation record consumes only immutable normalized level definitions, accepted before/result states, accepted actor actions, and the existing pure pressed-Plate query. It contains visual-only ECHO trails, blocked-Door markers, dependency pips, Door/Plate shapes, the teaching badge, geometry, modal state, and reduced-motion state. Snapshot reads are tested not to mutate the level or simulation state.

Rapid-input regression sends the twelve accepted Level 5 actions without frame gaps and compares the resulting state with `Simulation.replay`; action count, order, completion, and exact state agree. Help blocks movement, WAIT, and restart; completion and existing route behavior remain unchanged.

## Board and HUD geometry

- Logical viewport: unchanged `960×540`.
- Cell pitch: `60 px`, with a fixed `3 px` visual cell gap.
- Board zone: `Rect2(24, 84, 540, 420)`.
- Right rail: `Rect2(600, 84, 336, 420)` with approximately 36 px separation.
- Goal/title strip: `Rect2(24, 18, 912, 46)`; the left objective and right title/status occupy separate measured controls.
- Help modal: `Rect2(96, 54, 768, 432)`.
- Fonts: compact/secondary `16 px`, objective/help body `18 px`, title/important state `22 px`, completion `28 px`.

Each formal grid is sized from its normalized `terrain_rows` and centered deterministically inside the board zone. The maximum 9×7 footprint is exactly 540×420. Public geometry/surface snapshots prove that all five grids fit; objective, status, Timeline, legend, and controls do not intersect formal board footprints; labels stay within 960×540. After the first accepted action, the controls surface collapses to the right-rail `H Help` affordance, and the former board-overlapping footer is gone.

## Contextual Timeline and modal Help

Timeline display is presentation-only:

- `INTRO_MINIMAL`: hidden;
- `GUIDED_ECHO`: visible while incomplete;
- `STANDARD_COMPACT`: visible only when `echo_count > 1`, `distinct_delay_count > 1`, or `max_delay >= 4`.

Current standard Levels 3–5 therefore hide their permanent Timeline. Synthetic focused tests cover all three standard-complexity triggers. The model and shared history-index query are unchanged, and Help uses the same model for its oldest-to-newest slots and accessible action labels.

`H` opens a fully keyboard-operable modal reference card. It contains the mode-appropriate objective, controls, entity key, bars/aperture and Plate-pip explanation, plus expanded Timeline meaning when an ECHO exists. It contains no solver metric, witness, route, or next-move advice. Opening/closing preserves turn, history, positions, Door states, completion, and canonical key. While open it blocks movement, WAIT, and restart; `H` closes it; `Esc` closes it before Back/Quit; the next gameplay input works normally.

## Primitive feedback states

- Plate: `HOLLOW_UNPRESSED` versus `FILLED_PRESSED`, supplemented by an outer pressed ring.
- Dependency: one dashed path per exact `all_plate_ids` reference plus stable Plate-ID-ordered hollow/filled pips.
- Door: `BARS_CLOSED` uses a filled obstruction and three bars; `HOLLOW_OPEN` uses split sides and an empty aperture. Right-rail `CLOSED`/`OPEN` text supplements the shapes.
- ECHO: stable outlined `E`, segmented replay trail, and replay glyph distinct from player movement.
- Block: `X_STOP_NOTCH` on the accepted Level 4 critical closed-start boundary.
- Occupancy: Door is drawn before actors, so closed-around/behind-YOU retains the `Y` identity; the public snapshot records the occupant and identity-visible invariant.
- Reduced motion: a test-only presentation switch replaces travel with static segments while retaining shapes, pips, labels, and badge. It adds no settings or persistence surface.

Grayscale captures demonstrate that closed bars and the open aperture remain distinguishable without color.

## Level 4 proof-driven trace

The accepted shortest witness reaches the critical start after `RIGHT, RIGHT, UP, UP`: Door closed, YOU at `[3,3]`, ECHO at `[3,5]`, turn 5. The next accepted `UP` records the player as stationary, replays ECHO to Plate `[3,4]`, presses the Plate, and commits Door open at turn 6.

That committed result simultaneously shows the stop X, ECHO trail/glyph, filled Plate/ring, active dependency path/pip, hollow Door aperture, and `OPEN · NEXT INPUT`. The badge is shown only on the first qualifying open commit in a Gameplay instance, declares a 1.25-second presentation duration, and clears on the next gameplay action or Help toggle. It gives no direction. The next accepted `RIGHT` uses the already-open start snapshot, moves YOU to Door `[4,3]`, clears the badge, and displays the subsequently closed bars behind YOU without hiding `Y`.

## Level 5 dependency proof

After the accepted seven-action prefix `RIGHT, RIGHT, RIGHT, RIGHT, UP, UP, RIGHT`, YOU and ECHO occupy distinct Plates, the accepted Door state is open, and the presentation shows exactly two active pips ordered `plate_echo`, then `plate_you`. This visualizes the existing combinational AND references only; it does not introduce latch or Gate semantics.

## Regression and evidence

Baseline before edits:

```text
TASK_0003_TESTS_PASS assertions=280 vectors=9
TASK_0006_APP_SHELL_TESTS_PASS
TASK_0007_TUTORIAL_LEVELS_TESTS_PASS
TASK_0008_PROGRESSIVE_HUD_TESTS_PASS
TASK_0009AR_LEVELS_4_5_TESTS_PASS
```

Final aggregate:

```text
TASK_0003_TESTS_PASS assertions=301 vectors=9
TASK_0006_APP_SHELL_TESTS_PASS
TASK_0007_TUTORIAL_LEVELS_TESTS_PASS
TASK_0008_PROGRESSIVE_HUD_TESTS_PASS
TASK_0009AR_LEVELS_4_5_TESTS_PASS
TASK_0011_PRESENTATION_RECOVERY_TESTS_PASS
```

Focused Task 0011, Tutorial 0–1 validation, Level 4–5 validation, normal AppRoot launch, and direct Level 4/5 launches all exited zero. The final evidence set contains five initial 960×540 gameplay states, guided and standard Help, Timeline visible/hidden states, the complete Level 4 timing sequence, Level 5 AND-open state, grayscale comparison, and reduced-motion state. Commands, UTC timestamps, sizes, and SHA-256 hashes are recorded in the external evidence index.

Accepted metrics remain unchanged:

| Level | L* | N* | Count status | Visited | Max frontier | Controlled-unsolved evidence |
|---|---:|---:|---|---:|---:|---|
| Tutorial 0 | 3 | 3 | EXACT | 6 | 2 | not applicable |
| Tutorial 1 | 9 | 12 | EXACT | 1,975 | 509 | no ECHO: 10 visited |
| Level 3 | 9 | 31 | EXACT | 1,318 | 393 | isolated ECHO: 1,006 visited |
| Level 4 | 9 | 7 | EXACT | 291 | 116 | no ECHO: 5 visited |
| Level 5 | 12 | 1 | EXACT | 1,260 | 225 | no ECHO: 8 visited |

Formal level SHA-256 values remain:

- Tutorial 0: `38e466bb5922f1987a99d79c7527a4a8eab8e6cfdbe76fd8159f80b0a40cf2c4`;
- Tutorial 1: `681d99057c4e6034a490644d75960ff23d8f43bd1b91850f48179b79fc04a3cf`;
- Level 3: `8751da5051fbebaaa5ae7c895d9be9f086e8d8f2e87876a80c379dc06262f1d8`;
- Level 4: `1775cf89ae4a94f65a76dac2b791a31395443de88205d0ed1b6233331dbda577`;
- Level 5: `f4c6791dfc84d17fb450721e654091a2baeb522e55d660a5d73878cd977651cd`.

## Protected surfaces and non-claims

Unchanged: `project.godot`, simulation, solver, schemas, five level files, catalog, AppRoot/routing/progress/menu/error code, assets/fonts/audio/imports, saves, export, build, release, accounts, and repository settings. WAIT remains `DEFERRED_VALIDATION_RESEARCH`; the latched/one-shot Gate remains `DRAFT_NOT_ACCEPTED`.

This report does not claim owner approval, fresh or independent review, final art, final accessibility, final localization, difficulty closure, candidate readiness, or release readiness. The primitive recovery remains pending GPT Project Sources review and a separate owner-targeted five-level/Level 4 review.

## Recommended next gate

After GPT acceptance, issue the separate owner-targeted review specified by Task 0011. It should evaluate perceived board size, residual clutter/overlap, Level 4 timing clarity, Timeline/Help value, and P0–P3 findings across the normal five-level sequence. Do not start asset acquisition, audio, narrative implementation, Level 6, Gate, save, export, or release work under this task.
