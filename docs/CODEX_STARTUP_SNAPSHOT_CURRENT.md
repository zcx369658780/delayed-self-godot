# Codex startup snapshot (CURRENT)

- Status: `CURRENT`
- Repository: `zcx369658780/delayed-self-godot` (public)
- Default branch: `main`
- Local root: `D:\Delayed_Self`
- Working title: `迟到的我 / Delayed Self`
- Product: offline single-player; primary target Windows
- Prior accepted gate: Task 0011V (`TASK_0011V_OWNER_PRESENTATION_REVIEW_ACCEPTED_WITH_FOCUSED_REPAIR_REQUIRED`), evidence commit `39d0882e90771c1c54ebdb6477f560e81168fa9e`
- Current gate: Task 0011R — physical-window fill, scaling, and centering repair
- Current task: `tasks/0011R_physical_window_fill_scaling_and_centering_repair.md`
- Environment record: `docs/environment/DEVELOPMENT_ENVIRONMENT_CURRENT.md`
- Simulation contract: `docs/game_design/GAMEPLAY_SIMULATION_CONTRACT_CURRENT.md`
- Level schema: `schemas/level_v1.schema.json`
- Current report: `docs/reports/0011R_PHYSICAL_WINDOW_FILL_REPAIR_REPORT.md`
- Current architecture plan: `docs/architecture/SYSTEM_SKELETON_PLAN_CURRENT.md`
- Catalog contract: `docs/architecture/LEVEL_CATALOG_V1_CURRENT.md`
- Next recommended gate after GPT review: short authenticated-owner window-fill retest

## Startup

Follow the canonical read order in `AGENTS.md`. Before any write, verify root, branch, `HEAD`, remotes, and clean worktree. Task 0011R implementation is recorded pending GPT review. Content, logical layout, imports, assets/audio, Gate, save, export, and release surfaces remain frozen.

## Pending

Task 0011R corrects four double-prefixed Godot display/window keys so the exact 960×540 logical canvas uses built-in `canvas_items` keep-aspect scaling. Exact 16:9 clients fill; other clients receive symmetric black bars only on the necessary axis. Main Menu, Level Select, Gameplay/Help, and Safe Error share the same host policy, and resize preserves state/input authorities. Final regression is `314 assertions/9 vectors` with all seven markers and unchanged hashes/metrics. GPT review and a direct owner window-fill retest remain pending; assets, Level 6, fresh/independent review, candidate status, save, complete flow, export, Web, and release remain separate gates.
