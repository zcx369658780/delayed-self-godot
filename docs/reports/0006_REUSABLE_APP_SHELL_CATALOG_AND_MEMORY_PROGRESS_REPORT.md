# Task 0006 reusable app shell, catalog, and memory progress report

- Verdict: `PASS_FOR_GPT_REVIEW`
- Task: `tasks/0006_reusable_app_shell_catalog_routing_and_memory_progress.md`
- Starting HEAD and `origin/main`: `93a9985267b9affcacf3ac985f80601cac8c235a`
- Final implementation: the single Task 0006 commit containing this report; exact commit is authoritative in Git history and the external evidence index
- Toolchain: Godot `4.7.stable.steam.5b4e0cb0f`, GDScript, Compatibility renderer, 960×540 logical viewport

## Outcome

The project now boots `scenes/app/app_root.tscn`. AppRoot validates the complete tracked catalog before constructing product UI, owns one memory-only progress adapter, and replaces exactly one active routed screen. The implemented routes are `BOOT`, `MAIN_MENU`, `LEVEL_SELECT`, `GAMEPLAY`, and `SAFE_ERROR`.

Main Menu exposes Play and desktop Quit without implying Continue or persisted progress. Level Select renders normalized entries in catalog sequence, exposes lock/prerequisite state, and emits a catalog ID. The single tracked entry is initially unlocked. Unknown routes, unknown level IDs, malformed catalogs, missing/invalid formal levels, and catalog/formal ID mismatch cannot construct partial menu or Gameplay state.

## Changed surfaces and responsibilities

- `project.godot`: changes only the main scene to AppRoot; input, renderer, and viewport remain unchanged.
- `schemas/catalog_v1.schema.json`, `data/catalog/level_catalog_v1.json`, and `docs/architecture/LEVEL_CATALOG_V1_CURRENT.md`: machine schema, one-entry runtime catalog, and matching human contract.
- `scripts/app/`: strict loader/cross-validator, direct-level argument parser, memory progress, AppRoot/router, and three UI controllers.
- `scenes/app/` and `scenes/ui/`: AppRoot, Main Menu, Level Select, and Safe Error scenes.
- `scripts/gameplay/vertical_slice.gd`: narrow pre-tree route-payload configuration plus hosted completion/back signals. Its default formal path and direct-scene behavior remain available.
- `tests/run_all.gd` and `tests/app/`: 48 public-interface assertions beyond the accepted 135, invalid repository fixtures, and a game-root viewport evidence harness.
- current startup/task/index/plan/handoff/memory documents and this report: live handoff state only.

No change was required to `scenes/vertical_slice/vertical_slice.tscn`.

## Catalog v1 and diagnostics

Catalog v1 is independent from `level_v1`. It owns catalog version, ordered entries, title key, formal path, classification, prerequisites, HUD mode, current-catalog final flag, and an optional evidenced best-turn threshold. The tracked catalog contains only `vertical_slice_delay_3`, omits a best-turn threshold, and temporarily marks it final solely as the last implemented catalog entry.

The validator rejects JSON/read failure, unknown fields, unsupported version, missing/type/range/format failures, duplicate IDs/sequences, non-contiguous sequence, unknown classification/HUD mode, duplicate/self/unknown prerequisites, cycles/unreachable entries, missing/invalid formal levels, ID mismatch, and zero/multiple final entries. Stable codes are enumerated in the catalog contract. Every invalid result contains `catalog={}`.

The Level Select development-title fallback comes from the accepted formal level `title`; `display_title_key` remains in normalized catalog data. No hidden title registry or localization implementation exists.

## Gameplay compatibility seam

AppRoot resolves the selected ID against the already validated catalog and constructs one payload with `level_id`, `level_path`, `hud_mode`, `classification`, `development_direct`, and `final_level`. It instantiates the accepted vertical-slice scene, configures that payload before adding the scene to the tree, and the scene loads the formal path through the unchanged `LevelLoader`.

The direct scene still defaults to `res://data/levels/vertical_slice_delay_3.json`. The development app route is `--level-id=vertical_slice_delay_3`; it reads only user arguments, accepts no user file path, and still resolves through catalog validation. This is not the Task 0007 GameplayController/BoardView/HUD refactor.

## In-memory progress

The isolated adapter exposes `snapshot()`, `is_unlocked(level_id)`, `record_completion(level_id, turns)`, and `reset_test_profile()`. Root entries begin unlocked; all prerequisites are required; locked, unknown, or non-positive completion input fails; completion is idempotent; lower positive best turns win; reset is deterministic. A completed hosted level records the logical move count and returns to Level Select.

The test compares `user://` file listings before and after progress operations. They remain identical. The adapter contains no filesystem API, persistence path, migration, deletion, registry, settings, or backup behavior and never calls simulation transitions.

## Automated evidence

Baseline before implementation:

- `TASK_0003_TESTS_PASS assertions=135 vectors=9`;
- `SOLVED`, `L*=9`, `N*=31 (EXACT)`, 1,318 visited states;
- echo-isolated `UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE`, 1,006 visited states.

Final repository suite:

- `TASK_0003_TESTS_PASS assertions=183 vectors=9`;
- `TASK_0006_APP_SHELL_TESTS_PASS`;
- unchanged solver and echo-isolated summaries above;
- 48 Task 0006 assertions: catalog 25, progress 7, direct-argument parsing 4, app/routing 12.

Coverage includes the complete catalog failure matrix, no-partial-catalog result, deterministic unlock/reset/best turns and no-write observation, app scene frames, Menu→Select→Gameplay payload, direct-scene default, completion progress event, one-screen replacement, invalid catalog, and unknown route/level/direct ID Safe Error behavior.

## Runtime and external evidence

Authorized evidence root: `D:\Delayed_Self_Evidence\0006_app_shell_catalog\`.

- `baseline_tests.log`: accepted pre-edit baseline;
- `final_tests.log`: final automated suite;
- `app_shell_launch.log`: real project main-scene window launch;
- `direct_level_launch.log`: catalog-validated development direct-level launch;
- `viewport_capture.log`: bounded root-viewport capture run;
- `main_menu.png`, `level_select.png`, `gameplay_route.png`, `safe_error.png`: 960×540 game-root-only captures;
- `EVIDENCE_INDEX.md`: commands, timestamps, sizes, and SHA-256 hashes.

No screenshot, raw log, `.godot/`, import, or external evidence is staged.

## Protected surfaces and non-claims

Unchanged protected authorities include `scripts/simulation/level_loader.gd`, `scripts/simulation/simulation.gd`, `scripts/solver/bfs_solver.gd`, `data/levels/`, `schemas/level_v1.schema.json`, accepted fixtures/contracts, GDD, project rules, input mapping, saves/player data, dependencies/plugins, assets, exports, builds, releases, accounts, and repository settings.

This report does not claim Tutorial 0–1, a reusable final Gameplay architecture, progressive HUD completion, persistent progress, Pause/Results/Final Completion, localization rollout, complete product flow, fresh-player acceptance, final art/audio, export, Web, candidate readiness, release, or submission readiness.

## Next gate

Only after GPT acceptance, the recommended next gate is Task 0007 — reusable gameplay loading and Tutorial 0–1 formal levels. Task 0006 completion does not authorize it automatically.
