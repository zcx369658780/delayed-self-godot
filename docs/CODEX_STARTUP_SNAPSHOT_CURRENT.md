# Codex startup snapshot (CURRENT)

- Status: `CURRENT`
- Repository: `zcx369658780/delayed-self-godot` (public)
- Default branch: `main`
- Local root: `D:\Delayed_Self`
- Working title: `迟到的我 / Delayed Self`
- Product: offline single-player; primary target Windows
- Latest accepted gate: Task 0012 (`TASK_0012_STAGGERED_DOORS_ACCEPTED_INTERNAL_PLAYABLE`), implementation commit `1e43e9baa82a578fdb14f556e4895d42863513d9`
- Current gate: Task 0013B authenticated-owner Level 6 review recorded for GPT review
- Last completed task: `tasks/0013B_owner_targeted_level_6_review_and_review_constraint_sync.md`
- Environment record: `docs/environment/DEVELOPMENT_ENVIRONMENT_CURRENT.md`
- Simulation contract: `docs/game_design/GAMEPLAY_SIMULATION_CONTRACT_CURRENT.md`
- Level schema: `schemas/level_v1.schema.json`
- Current report: `docs/reports/0013B_OWNER_TARGETED_LEVEL_6_REVIEW_REPORT.md`
- Current architecture plan: `docs/architecture/SYSTEM_SKELETON_PLAN_CURRENT.md`
- Catalog contract: `docs/architecture/LEVEL_CATALOG_V1_CURRENT.md`
- Next recommended gate: GPT adjudication, then a separately bounded Level 7 planning task

## Startup

Follow the canonical read order in `AGENTS.md`. Before any work, verify root, branch, `HEAD`, remotes, and worktree, then require a newly issued GitHub task file. GitHub task files carry the complete execution authorization; the normal local Codex launch prompt only names the task file. Task 0013B is complete and no Level 7 or other implementation is currently authorized.

## Pending

Task 0012 remains GPT accepted at `INTERNAL_PLAYABLE`. Task 0013B records `AUTHENTICATED_OWNER_NOT_FRESH_NOT_INDEPENDENT_LEVEL_6_REVIEW`: Level 5 and Level 6 completed unassisted, Level 6 was harder, P0=0/P1=0/P2=3/P3=1, and the owner recommends preserving Level 6 and making Level 7 more complex. The owner is the only available playtester; do not seek or require third-party reviewers unless the owner explicitly reverses that decision. `FRESH_INDEPENDENT_REVIEW_UNAVAILABLE_BY_OWNER_CONSTRAINT` is unavailable, not passed or failed, and remains a disclosed residual limitation rather than an ordinary internal-development blocker. Candidate status, Level 7, assets/audio/narrative, complete flow, export, Web, and release remain separate, unauthorized gates.
