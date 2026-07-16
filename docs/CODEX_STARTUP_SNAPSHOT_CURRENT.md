# Codex startup snapshot (CURRENT)

- Status: `CURRENT`
- Repository: `zcx369658780/delayed-self-godot` (public)
- Default branch: `main`
- Local root: `D:\Delayed_Self`
- Working title: `迟到的我 / Delayed Self`
- Product: offline single-player; primary target Windows
- Prior accepted gate: Task 0011 (`TASK_0011_PRIMITIVE_PRESENTATION_AND_DOOR_FEEDBACK_ACCEPTED_PENDING_OWNER_REVIEW`), implementation commit `c26d8be1c97dbe057f633b55ea7689f35272c577`
- Current gate: Task 0011V — authenticated-owner presentation review
- Current task: `tasks/0011V_owner_presentation_level4_and_five_level_retest.md`
- Environment record: `docs/environment/DEVELOPMENT_ENVIRONMENT_CURRENT.md`
- Simulation contract: `docs/game_design/GAMEPLAY_SIMULATION_CONTRACT_CURRENT.md`
- Level schema: `schemas/level_v1.schema.json`
- Current report: `docs/reports/0011V_OWNER_PRESENTATION_REVIEW_REPORT.md`
- Current architecture plan: `docs/architecture/SYSTEM_SKELETON_PLAN_CURRENT.md`
- Catalog contract: `docs/architecture/LEVEL_CATALOG_V1_CURRENT.md`
- Next recommended gate after GPT review: focused Task 0011R primitive presentation repair

## Startup

Follow the canonical read order in `AGENTS.md`. Before any write, verify root, branch, `HEAD`, remotes, and clean worktree. Task 0011V records the authenticated owner's completed five-level presentation review. It is documentation-only; content, settings, viewport implementation, imports, assets/audio, Gate, save, export, and release surfaces remain frozen.

## Pending

Task 0011V is `NOT_FRESH_NOT_BLIND_OWNER_PRESENTATION_REVIEW`: all five attempts completed unassisted through normal flow, unlock/return and input worked normally, and the rules/mechanism presentation was much clearer. P0=0, P1=0, P2=1, P3=1. The fixed 960×540 canvas still leaves materially visible right/bottom unused space in the larger physical window; the owner chose priority `B`, so focused Task 0011R is recommended before licensed visual/font work. Dashed dependency paths remain understandable in simple levels but are not recommended as the primary future complex-level relationship language. Fresh/independent review, candidate status, assets, new content, save, complete flow, export, Web, and release remain separate gates.
