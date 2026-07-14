# Task 0006 GPT final acceptance

- Verdict: `TASK_0006_APP_SHELL_CATALOG_AND_MEMORY_PROGRESS_ACCEPTED`
- Accepted implementation commit: `4fc742723b1ea5dbefb19cf4ea27acacc2ad9f36`
- Accepted task: `tasks/0006_reusable_app_shell_catalog_routing_and_memory_progress.md`
- Acceptance date: 2026-07-14
- Accepted by: GPT Project Sources advisor

## Review basis

GitHub review confirmed that the implementation is exactly one commit ahead of the Task 0006 issue point. It changes only the authorized application-shell, catalog, narrow gameplay-compatibility, test, report, and current-document surfaces. The accepted formal level, `level_v1`, `simulation_v1`, normative fixtures, strict level loader, BFS solver, renderer, viewport, input mapping, assets, dependencies, saves, exports, builds, releases, accounts, and repository settings remain unchanged.

The project now boots into a bounded AppRoot shell. The complete separate catalog is validated before Main Menu or Level Select construction; invalid results expose no partial normalized catalog and route to Safe Error. The one tracked catalog entry resolves through the accepted LevelLoader and launches the accepted vertical slice through a validated route payload. The original vertical-slice scene remains directly launchable for development.

## Accepted claims

For commit `4fc742723b1ea5dbefb19cf4ea27acacc2ad9f36`, the following are accepted:

1. `project.godot` boots the AppRoot application shell while preserving the accepted toolchain, renderer, viewport, and input map.
2. The implemented route set is `BOOT`, `MAIN_MENU`, `LEVEL_SELECT`, `GAMEPLAY`, and `SAFE_ERROR`.
3. Catalog v1 is a strict, versioned product-data boundary independent from `level_v1`; unknown fields and invalid cross-references fail the complete catalog with stable diagnostics.
4. The tracked catalog contains only the accepted `vertical_slice_delay_3` formal level and does not introduce placeholders or unsupported best-turn claims.
5. Main Menu and Level Select are catalog-driven and contain no puzzle-transition authority.
6. A validated catalog payload configures the hosted gameplay scene before tree entry; unknown routes, unknown/locked IDs, invalid catalog data, missing/invalid formal levels, and ID mismatches construct no Gameplay state.
7. The development `--level-id` route accepts catalog IDs only and cannot bypass validation with a user-supplied filesystem path.
8. The in-memory progress adapter deterministically records completion and minimum positive best turns, evaluates prerequisites, resets for tests, and performs no persistent write.
9. AppRoot owns exactly one active routed screen at a time.
10. The accepted direct vertical-slice development path remains available.

## Accepted regression evidence

The repository report records:

- baseline: `TASK_0003_TESTS_PASS assertions=135 vectors=9`;
- final: `TASK_0003_TESTS_PASS assertions=183 vectors=9`;
- final shell marker: `TASK_0006_APP_SHELL_TESTS_PASS`;
- unchanged accepted solver result: `SOLVED`, `L*=9`, `N*=31 (EXACT)`, 1,318 visited states;
- unchanged controlled echo-isolated result: `UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE`, 1,006 visited states;
- successful normal app-shell launch, validated direct-level launch, and bounded root-viewport evidence for Main Menu, Level Select, Gameplay, and Safe Error.

## Observations and non-claims

- The current hosted gameplay remains a narrow compatibility seam around the former vertical-slice scene; it is not yet the final reusable GameplayController/BoardView/HUD architecture.
- The sole catalog entry is temporarily `final_level=true` only because it is the last implemented catalog entry. This is not final narrative, candidate, release, or submission evidence.
- Formal titles are a documented development fallback; localization resolution is not implemented.
- In-memory progress is not a save system and does not survive process exit.
- No Tutorial 0, Tutorial 1, progressive HUD acceptance, Results, Pause, Final Completion, settings, persistent Continue, final art/audio, Windows export, Web, release, or submission claim is accepted.

## Next gate

`Task 0007 — reusable gameplay loading and Tutorial 0–1 formal levels` is authorized. It may generalize the gameplay presentation/controller only enough to safely host valid zero-echo/no-door and single-echo tutorial levels; create and catalog Tutorial 0 and Tutorial 1; validate, solve, replay, and record their metrics; and preserve all accepted vertical-slice and app-shell evidence. It must not implement the final progressive HUD redesign, fresh-player acceptance, persistent saves, Results/Pause/Final Completion, settings, assets/audio, export, Web, release, or submission operations.
