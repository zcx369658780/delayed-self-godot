# Codex startup snapshot (CURRENT)

- Status: `CURRENT`
- Repository: `zcx369658780/delayed-self-godot` (public)
- Default branch: `main`
- Local root: `D:\Delayed_Self`
- Working title: `迟到的我 / Delayed Self`
- Product: offline single-player; primary target Windows
- Prior accepted gate: Task 0011R (`TASK_0011R_PHYSICAL_WINDOW_FILL_REPAIR_ACCEPTED_PENDING_OWNER_RETEST`), implementation commit `a07c4be075aaa5c57e9d48869392f29dadaaa1d5`
- Current gate: Task 0011RV — authenticated-owner standalone window-fill retest
- Current task: `tasks/0011RVE_bounded_cleanup_standalone_client_retest_and_owner_review_completion.md`
- Environment record: `docs/environment/DEVELOPMENT_ENVIRONMENT_CURRENT.md`
- Simulation contract: `docs/game_design/GAMEPLAY_SIMULATION_CONTRACT_CURRENT.md`
- Level schema: `schemas/level_v1.schema.json`
- Current report: `docs/reports/0011RV_OWNER_WINDOW_FILL_RETEST_REPORT.md`
- Current architecture plan: `docs/architecture/SYSTEM_SKELETON_PLAN_CURRENT.md`
- Catalog contract: `docs/architecture/LEVEL_CATALOG_V1_CURRENT.md`
- Next recommended gate after GPT review: separately authorized difficult Level 6 `staggered_doors`

## Startup

Follow the canonical read order in `AGENTS.md`. Before any write, verify root, branch, `HEAD`, remotes, and clean worktree. Task 0011RV standalone owner evidence is recorded pending GPT final adjudication. Level 6, content, logical layout, imports, assets/audio, Gate, save, export, and release surfaces remain frozen until separately authorized.

## Pending

Task 0011R is GPT accepted pending owner retest. The standalone native-client retest confirms that exact 16:9 enlargement fills, non-16:9 bars are symmetric and natural, all tested routes scale consistently, and resize preserves state/input. The earlier small centered view occurred only in the Godot embedded preview, so the selected branch is `EMBEDDED_PREVIEW_ONLY_NOT_PRODUCT_WINDOW_BLOCKER`. Findings are P0=0/P1=0/P2=0/P3=0. GPT final adjudication remains pending; Level 6, assets, fresh/independent review, candidate status, save, complete flow, export, Web, and release remain separate gates.
