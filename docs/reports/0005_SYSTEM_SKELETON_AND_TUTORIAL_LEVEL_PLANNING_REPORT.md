# Task 0005 system skeleton and tutorial-level planning report

- Verdict: `PASS_FOR_GPT_REVIEW`
- Task: `tasks/0005_system_skeleton_and_tutorial_level_planning.md`
- Branch: `main`
- Start HEAD / start `origin/main`: `07a93015b48db526396829db031a5989de00e414`
- Final HEAD / final `origin/main`: `SELF` — resolve from `main` after the authorized push
- Change type: documentation-only planning

## Files created

- `docs/architecture/SYSTEM_SKELETON_PLAN_CURRENT.md`
- `docs/game_design/TUTORIAL_AND_HUD_PROGRESSION_PLAN_CURRENT.md`
- `docs/level_design/INITIAL_LEVEL_ROADMAP_AND_VALIDATION_MATRIX_CURRENT.md`
- `docs/version_plans/M2_SYSTEM_SKELETON_IMPLEMENTATION_PLAN.md`
- `docs/reports/0005_SYSTEM_SKELETON_AND_TUTORIAL_LEVEL_PLANNING_REPORT.md`

## Files updated

- `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`
- `docs/CODEX_ACTIVE_TASK_CURRENT.md`
- `docs/DOC_INDEX_CURRENT.md`
- `docs/DEVELOPMENT_PLAN_CURRENT.md`
- `docs/HANDOFF_MASTER_CURRENT.md`
- `docs/project_memory.md`

## Sources inspected

The planning package was grounded in:

- Task 0005 and the Task 0004V/0004R acceptance, review, and report chain;
- canonical GDD, accepted simulation contract, schema contract, JSON Schema, transition-vector description, formal vertical-slice level, and project rules;
- `project.godot`, current vertical-slice scene, gameplay controller/presentation, strict loader, shared simulation, BFS solver, and conformance tests;
- current startup, task, index, development plan, handoff, and project memory.

## Major recommendations

All items are `PLANNING_RECOMMENDATION_FOR_GPT`, not implemented facts:

1. introduce a thin AppRoot/router with Boot, Menu, Level Select, Gameplay, Pause, Results, Final Completion, and Safe Error states;
2. incrementally separate reusable GameplayController, BoardView, and GameplayHud while preserving one shared transition authority;
3. use a versioned separate JSON catalog rather than extending `level_v1`, Godot Resources, or a hard-coded registry;
4. use in-memory progression for early skeleton tests and defer persistent storage format/path/migration to a save-specific gate;
5. implement `INTRO_MINIMAL`, `GUIDED_ECHO`, and `STANDARD_COMPACT` HUD modes with a compact contract-derived timeline;
6. build an eight-level schema-v1 spine: two tutorials, the accepted slice, and five geometry/timing-focused core levels;
7. advance each level through schema, solver, replay, internal, fresh-player, and candidate acceptance gates;
8. sequence future Tasks 0006–0009, using early M1 completion buffer to protect the Jul 24 skeleton and Jul 31 content targets.

## Decisions awaiting GPT acceptance

- catalog representation, versioning, fields, and player-facing title ownership;
- recommended scene/module names and dependencies;
- progress interface and later save-adapter boundary;
- tutorial concepts, roadmap sequence, target `L*` bands, necessity variants, and scope-cut order;
- progressive HUD mode behavior and Chinese-first localization ownership;
- Task 0006–0009 scope, schedule, and commit-policy suggestions.

No target band, concept, or authoring route is reported as solver evidence.

## Task 0004V observations

- P2 information density: addressed through contextual objectives/legends, three HUD modes, compact timeline slots, expanded help, and mandatory fresh-player evidence before removal of explicit facts.
- P3 branching routes: recorded as `DEFERRED_POST_MVP` with player value, schema/solver/save implications, schedule risks, and reconsideration criteria. It is absent from the schema-v1 roadmap and pre-candidate tasks.

## Validation performed

- all required source, contract, evidence, runtime, plan, and rule surfaces were read;
- the codebase knowledge graph was consulted first for code discovery; it indexed the repository but did not return sufficient GDScript main-script results, so exact required files were read directly under the documented fallback;
- Markdown links, status vocabulary, required artifact sections, eight-level count, three HUD modes, fresh-player gates, schema-v1-only mechanics, schedule/scope cuts, and authorized-path boundaries were checked;
- Markdown-link, required-content, schema-v1 roadmap, authorized-path, whitespace, sensitive-pattern, `git diff --check`, and `git diff --cached --check` audits passed before commit;
- no Godot runtime test was needed or used as evidence for uncreated levels; existing accepted results are cited only as accepted facts.

## Subagents

No subagents were used. Task 0005 made them optional, and the main thread completed the bounded read/draft/consistency review. This is not represented as independent review.

## Protected-surface confirmation

No file under `scripts/`, `scenes/`, `data/`, `schemas/`, `tests/`, `assets/`, `audio/`, or `shaders/` changed. No GDD, project rule, contract, prior report, project setting, level, save, export, build, release, license, plugin, dependency, or external evidence changed.

## Recommended next gate

`Task 0006 — reusable app shell, level catalog, scene routing, and in-memory progression implementation`.

This recommendation does not authorize Task 0006 automatically.
