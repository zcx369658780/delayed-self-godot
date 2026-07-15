# Codex startup snapshot (CURRENT)

- Status: `CURRENT`
- Repository: `zcx369658780/delayed-self-godot` (public)
- Default branch: `main`
- Local root: `D:\Delayed_Self`
- Working title: `迟到的我 / Delayed Self`
- Product: offline single-player; primary target Windows
- Prior accepted gate: Task 0008 (`TASK_0008_PROGRESSIVE_HUD_AND_OWNER_TUTORIAL_RETEST_ACCEPTED_WITH_OBSERVATIONS`)
- Current gate: Task 0009AR — Door timing and AND-door replacement content batch
- Current task: `tasks/0009AR_door_timing_and_and_door_replacement_batch.md`
- Environment record: `docs/environment/DEVELOPMENT_ENVIRONMENT_CURRENT.md`
- Simulation contract: `docs/game_design/GAMEPLAY_SIMULATION_CONTRACT_CURRENT.md`
- Level schema: `schemas/level_v1.schema.json`
- Current report: `docs/reports/0009AR_DOOR_TIMING_AND_AND_DOOR_CONTENT_REPORT.md`
- Current architecture plan: `docs/architecture/SYSTEM_SKELETON_PLAN_CURRENT.md`
- Catalog contract: `docs/architecture/LEVEL_CATALOG_V1_CURRENT.md`
- Next recommended gate after GPT review: decide between five-level owner sequence review and the next small schema-v1 content batch

## Startup

Follow the canonical read order in `AGENTS.md`. Before any write, verify root, branch, `HEAD`, remotes, and clean worktree. Task 0009AR adds two validated schema-v1 levels and extends the tracked catalog to five entries without changing simulation, solver, Gameplay, HUD, viewport, AppRoot, or progress implementation.

## Pending

Task 0009AR implementation is pending GPT review. `door_one_turn_late` is solver/replay validated at `L*=9`, `N*=7 (EXACT)`; `two_keys_one_door` is validated at `L*=12`, `N*=1 (EXACT)` with AND/Plate/Echo necessity evidence. WAIT research remains deferred. `H` Help utility and right-side HUD crowding remain open P2 findings; fresh/independent review, candidate status, persistent save, complete flow, export, Web, and release remain separate gates.
