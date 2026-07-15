# Codex startup snapshot (CURRENT)

- Status: `CURRENT`
- Repository: `zcx369658780/delayed-self-godot` (public)
- Default branch: `main`
- Local root: `D:\Delayed_Self`
- Working title: `迟到的我 / Delayed Self`
- Product: offline single-player; primary target Windows
- Prior accepted gate: Task 0010 (`TASK_0010_PRESENTATION_DIFFICULTY_AND_PRODUCTION_PLANNING_ACCEPTED`), planning commit `37ab72513ed456d216bfe642282b6cac9e5484bd`
- Current gate: Task 0011 — primitive board/HUD and Door-feedback recovery
- Current task: `tasks/0011_primitive_board_hud_and_door_feedback_recovery.md`
- Environment record: `docs/environment/DEVELOPMENT_ENVIRONMENT_CURRENT.md`
- Simulation contract: `docs/game_design/GAMEPLAY_SIMULATION_CONTRACT_CURRENT.md`
- Level schema: `schemas/level_v1.schema.json`
- Current report: `docs/reports/0011_PRIMITIVE_PRESENTATION_AND_DOOR_FEEDBACK_RECOVERY_REPORT.md`
- Current architecture plan: `docs/architecture/SYSTEM_SKELETON_PLAN_CURRENT.md`
- Catalog contract: `docs/architecture/LEVEL_CATALOG_V1_CURRENT.md`
- Next recommended gate after GPT review: owner-targeted Level 4 plus normal five-level presentation review

## Startup

Follow the canonical read order in `AGENTS.md`. Before any write, verify root, branch, `HEAD`, remotes, and clean worktree. Task 0011 implementation is recorded pending GPT review; content, settings, imports, assets/audio, Gate, save, export, and release surfaces remain frozen.

## Pending

Task 0011 implements the accepted 960×540, 60 px board-first baseline, contextual Timeline, modal Help, and non-semantic primitive Plate/Door/ECHO feedback. Regression is `301 assertions/9 vectors` with all prior markers plus Task 0011 and unchanged hashes/metrics. GPT and owner review are pending; this is not human validation. Asset acquisition, new content, Gate semantics, fresh/independent review, candidate status, persistent save, complete flow, export, Web, and release remain separate gates.
