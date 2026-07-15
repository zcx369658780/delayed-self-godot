# Task 0009AR door timing and AND-door content report

- Terminal verdict: `PASS_FOR_GPT_REVIEW`
- Task: `tasks/0009AR_door_timing_and_and_door_replacement_batch.md`
- Repository root: `D:\Delayed_Self`
- Branch: `main`
- Starting HEAD and `origin/main`: `4d685efe70ebd5f9706bafdb97b2a10957543573`
- Toolchain: Godot `4.7.stable.steam.5b4e0cb0f`, Compatibility renderer
- Final implementation: the single commit containing this report; exact commit hash is authoritative in Git history and the final Codex handoff

## Superseded task relationship

Task 0009A stopped cleanly because its strict literal-WAIT proof was not established. The GPT blocker adjudication deferred `wait_for_the_echo` as `DEFERRED_VALIDATION_RESEARCH` and authorized this replacement batch. This implementation does not create a WAIT level, weaken the comparison standard, or claim that WAIT is impossible or redundant.

## Formal levels

### `door_one_turn_late`

- Strict loader: `VALID_LEVEL`
- One delay-2 Echo, one Plate, one dependent Door, one player-only EXIT
- Solver: `SOLVED`; `L*=9`; `N*=7 (EXACT)`; 291 visited; maximum frontier 116
- Limits: depth 24, states 100,000, time 10,000 ms, count cap 1,000,000
- Witness: `["RIGHT","RIGHT","UP","UP","UP","RIGHT","RIGHT","UP","UP"]`
- Replay: completed at logical turn 9; restart exact
- No-Echo variant: complete finite-state unsolved, 5 visited/frontier 1
- ECHO on EXIT: `completed=false`; no player bypass exists in the single gated corridor

At turn 5 the start snapshot is closed. Submitted `UP` leaves YOU at `[3,3]`, while ECHO reaches `plate_timing` at `[3,4]`; the result opens the Door. The next `RIGHT` begins open and enters `[4,3]`, after which the result closes. The shortest witness therefore exercises the required two-transition timing lesson.

### `two_keys_one_door`

- Strict loader: `VALID_LEVEL`
- One delay-3 Echo, two distinct Plates, one Door requiring both IDs, one player-only EXIT
- Solver: `SOLVED`; `L*=12`; `N*=1 (EXACT)`; 1,260 visited; maximum frontier 225
- Limits: depth 32, states 500,000, time 20,000 ms, count cap 1,000,000
- Witness: `["RIGHT","RIGHT","RIGHT","RIGHT","UP","UP","RIGHT","RIGHT","UP","UP","LEFT","LEFT"]`
- Replay: completed at logical turn 12; restart exact
- No-Echo variant: complete finite-state unsolved, 8 visited/frontier 1
- Relocating either Plate beyond the closed Door: each complete unsolved, 1,000 visited/frontier 225
- Single-`plate_echo` dependency control: solved at 12, 1,260 visited/frontier 225
- Single-`plate_you` dependency control: solved at 12, 1,261 visited/frontier 229
- ECHO on EXIT: `completed=false`; no corridor bypass

At the simultaneous result, ECHO occupies `plate_echo` `[5,5]`, YOU occupies `plate_you` `[6,3]`, both IDs are pressed, and the AND Door is open. The following `RIGHT` enters `[7,3]` from that open start snapshot. Two distinct Plate positions require separate actors, so legal overlap cannot trivialize the AND state.

## Catalog, progress, and runtime

The tracked catalog validates as exactly five entries in one chain: Tutorial 0 → Tutorial 1 → vertical slice → `door_one_turn_late` → `two_keys_one_door`. Only the first entry is initially unlocked; every completion unlocks only its direct successor; Level 5 remains locked before Level 4; reset restores the exact initial snapshot; no `user://` file is written. Only Level 5 is current-catalog final, with no best-turn thresholds.

All five catalog entries and both development-direct IDs route through the existing reusable Gameplay scene/script. Locked, unknown, invalid-catalog, and formal-ID-mismatch paths retain Safe Error/no-partial-state behavior. Normal AppRoot flow completes all five levels and returns to Level Select; no complete-flow or persistent-save surface was added.

## Regression and immutable content

Final markers:

- `TASK_0003_TESTS_PASS assertions=280 vectors=9`
- `TASK_0006_APP_SHELL_TESTS_PASS`
- `TASK_0007_TUTORIAL_LEVELS_TESTS_PASS`
- `TASK_0008_PROGRESSIVE_HUD_TESTS_PASS`
- `TASK_0009AR_LEVELS_4_5_TESTS_PASS`

Accepted formal hashes remain unchanged:

- `tutorial_reach_exit.json`: `38e466bb5922f1987a99d79c7527a4a8eab8e6cfdbe76fd8159f80b0a40cf2c4`
- `tutorial_echo_bridge.json`: `681d99057c4e6034a490644d75960ff23d8f43bd1b91850f48179b79fc04a3cf`
- `vertical_slice_delay_3.json`: `8751da5051fbebaaa5ae7c895d9be9f086e8d8f2e87876a80c379dc06262f1d8`

Their accepted metrics remain Tutorial 0 `3/3 EXACT/6/2`, Tutorial 1 `9/12 EXACT/1,975/509` plus 10-state no-Echo unsolved, and vertical slice `9/31 EXACT/1,318/393` plus 1,006-state Echo-isolated unsolved.

## Changed repository paths

Created: the two formal JSON files, two validation records, `tests/levels/task_0009ar_validation.gd`, `tests/gameplay/capture_task_0009ar.gd`, and this report. Modified: tracked catalog, catalog contract, roadmap, `tests/run_all.gd`, and the narrowly necessary current snapshot/task/index/plan/handoff/project-memory documents. No other repository path changed.

## External evidence

External root: `D:\Delayed_Self_Evidence\0009AR_levels_4_5\`.

The external evidence index records commands, timestamps, sizes, and SHA-256 hashes for baseline/final headless logs, focused solver/replay output, normal AppRoot and both direct-level launch logs, and seven 960×540 game-root captures. Captures cover five-entry Level Select states plus Level 4/5 initial and mechanically representative progressed states. No screenshot, raw log, `.godot` data, import, or external evidence is staged.

## Protected surfaces and non-claims

Simulation, LevelLoader, BFS solver, schemas, normative fixtures/contracts, accepted levels 1–3, Gameplay/HUD code and scenes, viewport, AppRoot/catalog/progress implementations, project settings, persistence, exports, builds, releases, accounts, and repository settings are unchanged. The carried P2 observations—limited current Help utility and right-side HUD crowding at 960×540—remain open.

This task does not establish fresh-player review, independent review, candidate acceptance, final Help/layout quality, persistent save, complete flow, export, release, or submission readiness.

## Recommended next gate

After GPT acceptance, choose explicitly between a five-level owner sequence review and the next small schema-v1 content batch. A qualifying fresh/independent review remains required before candidate acceptance. Literal-WAIT feasibility remains separate research unless a future task explicitly reopens it.
