# Codex startup snapshot (CURRENT)

- Status: `CURRENT`
- Repository: `zcx369658780/delayed-self-godot` (public)
- Default branch: `main`
- Local root: `D:\Delayed_Self`
- Working title: `迟到的我 / Delayed Self`
- Product: offline single-player; primary target Windows
- Prior accepted gate: Task 0011RV (`TASK_0011RV_STANDALONE_WINDOW_RETEST_ACCEPTED`)
- Current gate: Task 0012 — difficult Level 6 implementation and formal validation
- Current task: `tasks/0012_difficult_level_6_staggered_doors.md`
- Environment record: `docs/environment/DEVELOPMENT_ENVIRONMENT_CURRENT.md`
- Simulation contract: `docs/game_design/GAMEPLAY_SIMULATION_CONTRACT_CURRENT.md`
- Level schema: `schemas/level_v1.schema.json`
- Current report: `docs/reports/0012_LEVEL_6_STAGGERED_DOORS_REPORT.md`
- Current architecture plan: `docs/architecture/SYSTEM_SKELETON_PLAN_CURRENT.md`
- Catalog contract: `docs/architecture/LEVEL_CATALOG_V1_CURRENT.md`
- Next recommended gate after GPT review: separately authorized fresh/independent Level 6 sequence review

## Startup

Follow the canonical read order in `AGENTS.md`. Before any write, verify root, branch, `HEAD`, remotes, and worktree. Task 0012 implements only the authorized schema-v1 Level 6, catalog progression, tests, capture, and documentation. Level 7, assets/audio, Gate, save, export, and release surfaces remain frozen.

## Pending

Task 0012 is implemented and formally validated pending GPT review. `staggered_doors` has one delay-3 ECHO, two necessary Plates, two unavoidable Doors with distinct dependencies, `L*=15`, `N*=4 EXACT`, 6,772 visited states, frontier 1,179, and complete no-ECHO/Plate controls. Full regression passes at 349 assertions/9 vectors with eight markers. Fresh/independent review, candidate status, Level 7, assets, complete flow, export, Web, and release remain separate gates.
