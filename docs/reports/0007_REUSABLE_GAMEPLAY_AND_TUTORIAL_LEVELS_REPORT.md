# Task 0007 reusable gameplay and Tutorial 0–1 report

- Verdict: `PASS_FOR_GPT_REVIEW`
- Task: `tasks/0007_reusable_gameplay_and_tutorial_0_1.md`
- Starting HEAD and `origin/main`: `7ed330b08d561e5e5a2346cd8e8ddb6cd7727b81`
- Final implementation: the single Task 0007 commit containing this report; exact commit is authoritative in Git history and the external evidence index
- Toolchain: Godot `4.7.stable.steam.5b4e0cb0f`, GDScript, Compatibility renderer, 960×540 logical viewport

## Outcome and reusable boundary

Task 0007 uses Approach B. `scenes/vertical_slice/vertical_slice.tscn` and `scripts/gameplay/vertical_slice.gd` retain their historical names as a direct-development compatibility artifact, while the script now accepts a validated pre-tree catalog payload, verifies formal/catalog ID parity, loads the selected formal JSON through the unchanged `LevelLoader`, constructs/transitions state through the unchanged `Simulation`, and safely renders zero-or-one Echo/Plate/Door cardinalities. All three catalog levels use this single scene/script; no per-level scene, controller, or puzzle-rule branch was added.

The interim HUD maps validated catalog modes only: `INTRO_MINIMAL` removes absent concepts, `GUIDED_ECHO` adds role/causality/delay information, and `STANDARD_COMPACT` preserves the accepted vertical-slice presentation. The Tutorial 1 objective was kept within the left HUD region after viewport inspection. Task 0008 still owns final information-density and progressive-timeline design.

## Changed files

- Formal content/catalog: `data/levels/tutorial_reach_exit.json`, `data/levels/tutorial_echo_bridge.json`, `data/catalog/level_catalog_v1.json`
- Gameplay: `scripts/gameplay/vertical_slice.gd`
- Tests: `tests/run_all.gd`, `tests/levels/tutorial_validation.gd`, `tests/gameplay/capture_tutorial_levels.gd`
- Contracts/validation: `docs/architecture/LEVEL_CATALOG_V1_CURRENT.md`, `docs/level_design/validation/TUTORIAL_REACH_EXIT_VALIDATION.md`, `docs/level_design/validation/TUTORIAL_ECHO_BRIDGE_VALIDATION.md`
- Current/reporting docs: `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`, `docs/CODEX_ACTIVE_TASK_CURRENT.md`, `docs/DOC_INDEX_CURRENT.md`, `docs/DEVELOPMENT_PLAN_CURRENT.md`, `docs/HANDOFF_MASTER_CURRENT.md`, `docs/project_memory.md`, and this report

No gameplay scene file or AppRoot/app-shell implementation required modification.

## Formal levels and machine evidence

### Tutorial 0 — `tutorial_reach_exit`

The 5×4 bordered room contains a distinct player spawn and EXIT, no Echoes, Plates, or Doors, and the explicit zero-Echo tutorial allowance. Strict loading returns `VALID_LEVEL`. The bounded solver returns `SOLVED`, `L*=3`, `N*=3 (EXACT)`, 6 visited states, and maximum frontier 2 under depth 12, 10,000 states, 10,000 ms, and count cap 1,000,000. Witness `["UP", "RIGHT", "RIGHT"]` replays to completion with player `[3,1]`, turn index 4, and history `[]`. Restart is exact.

### Tutorial 1 — `tutorial_echo_bridge`

The horizontal-gate layout contains one shared-spawn delay-3 Echo, one Plate, one combinational Door, and a distinct player-only EXIT. Strict loading returns `VALID_LEVEL`. The bounded solver returns `SOLVED`, `L*=9`, `N*=12 (EXACT)`, 1,975 visited states, and maximum frontier 509 under depth 64, 100,000 states, 10,000 ms, and count cap 1,000,000. Witness `["RIGHT", "RIGHT", "UP", "DOWN", "LEFT", "DOWN", "DOWN", "RIGHT", "RIGHT"]` replays to completion at turn index 10. Restart is exact.

At witness action index 5 (`DOWN`), ECHO occupies Plate `[3,1]`, Door `[2,3]` is open in the start snapshot, and YOU moves from `[2,2]` into that Door cell through the shared transition. A controlled no-Echo variant completely exhausts unsolved after 10 visited states with maximum frontier 3 under the same limits. No player bypass completion exists in that complete controlled state space, and ECHO occupancy of EXIT does not complete the level.

## Catalog, progress, and routing

The tracked catalog has exactly: (1) `tutorial_reach_exit`, root tutorial, `INTRO_MINIMAL`; (2) `tutorial_echo_bridge`, requiring Tutorial 0, `GUIDED_ECHO`; (3) `vertical_slice_delay_3`, requiring Tutorial 1, `STANDARD_COMPACT`, the sole current-catalog final entry. No entry has `best_turn_threshold`.

Tests prove only Tutorial 0 is initially unlocked, each completion unlocks only its direct successor, reset restores the exact initial state, and no filesystem progress is introduced. All three catalog IDs route through the same gameplay scene; locked/invalid IDs retain Safe Error and construct no partial gameplay state. Normal AppRoot and both tutorial direct-level routes launch successfully.

## Regression and protected metrics

Baseline markers were `TASK_0003_TESTS_PASS assertions=183 vectors=9` and `TASK_0006_APP_SHELL_TESTS_PASS`. The final suite records `TASK_0003_TESTS_PASS assertions=220 vectors=9`, `TASK_0006_APP_SHELL_TESTS_PASS`, and `TASK_0007_TUTORIAL_LEVELS_TESTS_PASS`.

`data/levels/vertical_slice_delay_3.json` remains byte-for-byte unchanged at SHA-256 `8751DA5051FBEBAAA5AE7C895D9BE9F086E8D8F2E87876A80C379DC06262F1D8`. Its accepted result remains `SOLVED`, `L*=9`, `N*=31 (EXACT)`, 1,318 visited states; its Echo-isolated variant remains complete finite-state unsolved with 1,006 visited states.

Unchanged protected surfaces include `scripts/simulation/level_loader.gd`, `scripts/simulation/simulation.gd`, `scripts/solver/bfs_solver.gd`, `schemas/level_v1.schema.json`, normative fixtures/contracts, the accepted vertical-slice JSON, GDD/project rules, persistence/player data, dependencies/plugins, assets, exports, builds, releases, accounts, and repository settings.

## External evidence and non-claims

Authorized external root: `D:\Delayed_Self_Evidence\0007_tutorial_levels\`. Its index records baseline/final tests, standalone solver/replay and Echo-necessity evidence, AppRoot/direct-route logs, six game-root captures, commands, timestamps, sizes, and hashes. No raw log or screenshot is staged.

This task proves schema/solver/replay conformance and internal playability only. It does not claim fresh-player/tutorial acceptance, `FRESH_PLAYER_REVIEWED`, `CANDIDATE_ACCEPTED`, final progressive HUD, persistence, export, release, upload, or submission readiness.

## Next gate

Only after GPT acceptance, the recommended next gate is Task 0008 — progressive HUD modes and fresh-player Tutorial 0–1 review. This report does not authorize it automatically.
