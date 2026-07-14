# Task 0005 — System skeleton and tutorial-level planning

- Status: `READY`
- Gate: `PLANNING / SYSTEM SKELETON AND CONTENT SPINE`
- Repository: `zcx369658780/delayed-self-godot`
- Expected branch: `main`
- Expected local root: `D:\Delayed_Self`
- Issued by: GPT Project Sources advisor
- Date: 2026-07-14
- Prior accepted gate: `TASK_0004V_TARGETED_UX_RETEST_ACCEPTED_WITH_OBSERVATIONS`
- Accepted evidence commit: `67b9a9cbfcefd2458b481c33673aeb23520a51f4`
- Prior acceptance artifact: `docs/reports/0004V_GPT_FINAL_ACCEPTANCE.md`
- Accepted repaired runtime: `caeff311fda77b0261a7d78672afb9244ff23549`

## 1. Objective

Produce an implementation-ready planning package for the next development phase without modifying the Godot runtime.

The package must define:

1. the application/game-flow skeleton from launch through level completion;
2. scene/module/data ownership boundaries;
3. a separate level-catalog strategy that does not pollute `level_v1` simulation data;
4. a progressive-disclosure HUD strategy that addresses the accepted P2 information-density observation;
5. a tutorial sequence that teaches controls, player-only victory, delayed echo behavior, history/next-action planning, pressure plates, and next-turn door timing;
6. an initial 8-level content roadmap using only accepted schema-v1 mechanics;
7. solver and human-validation gates for every level;
8. staged implementation tasks with dependencies, acceptance criteria, and scope cuts through the 2026-08-10 candidate milestone;
9. a post-MVP mechanic backlog that records—but does not adopt—the user suggestion about player/echo route divergence.

This task is planning and documentation only. It must not create or modify scenes, scripts, level JSON, schema, tests, project settings, assets, saves, export presets, builds, plugins, or dependencies.

## 2. Mandatory startup gate

Before any repository write:

```powershell
Get-Location
git branch --show-current
git rev-parse HEAD
git rev-parse origin/main
git remote -v
git status --short --untracked-files=all
git log -12 --oneline --decorate
```

Required conditions:

- absolute root is `D:\Delayed_Self`;
- branch is `main`;
- origin is the expected repository;
- local `HEAD` and `origin/main` contain this task and `docs/reports/0004V_GPT_FINAL_ACCEPTANCE.md`;
- tracked worktree is clean.

If local is behind and clean, use only:

```powershell
git fetch origin
git merge --ff-only origin/main
```

Stop on divergence, conflict, remote mismatch, unexpected tracked changes, unsafe root, missing task/acceptance, or inability to obtain the task by fast-forward.

## 3. Required reads

Read in this order:

1. `AGENTS.md`
2. `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`
3. `docs/CODEX_ACTIVE_TASK_CURRENT.md`
4. this task file
5. `docs/reports/0004V_GPT_FINAL_ACCEPTANCE.md`
6. `docs/reviews/0004V_TARGETED_VICTORY_AND_ENTITY_READABILITY_USER_RETEST.md`
7. `docs/reports/0004V_TARGETED_USER_RETEST_REPORT.md`
8. `docs/reports/0004R_GPT_FINAL_ACCEPTANCE.md`
9. `docs/reviews/0004_GPT_FIRST_PLAYER_EVIDENCE_ADJUDICATION.md`
10. `docs/game_design/DELAYED_SELF_GAME_DESIGN_DOCUMENT_CURRENT.md`
11. `docs/game_design/GAMEPLAY_SIMULATION_CONTRACT_CURRENT.md`
12. `docs/level_design/LEVEL_SCHEMA_V1_CURRENT.md`
13. `schemas/level_v1.schema.json`
14. `docs/level_design/REFERENCE_TRANSITION_VECTORS_V1.md`
15. `data/levels/vertical_slice_delay_3.json`
16. `project.godot`
17. `scenes/vertical_slice/vertical_slice.tscn`
18. `scripts/gameplay/vertical_slice.gd`
19. `scripts/simulation/level_loader.gd`
20. `scripts/simulation/simulation.gd`
21. `scripts/solver/bfs_solver.gd`
22. `tests/run_all.gd`
23. `docs/DEVELOPMENT_PLAN_CURRENT.md`
24. `docs/HANDOFF_MASTER_CURRENT.md`
25. `docs/project_memory.md`
26. `docs/project_rules/PROJECT_RULE_PUZZLE_VALIDATION_CURRENT.md`
27. `docs/project_rules/PROJECT_RULE_GODOT_SAFETY_AND_RELEASE_GATES_CURRENT.md`
28. `docs/project_rules/PROJECT_RULE_EVIDENCE_AND_INDEPENDENT_REVIEW_CURRENT.md`

Before drafting, print a concise summary of:

- accepted runtime/design facts;
- Task 0004V accepted claims and carried observations;
- planning deliverables;
- unresolved architectural decisions;
- protected surfaces;
- allowed files;
- review/validation approach;
- commit/push authorization;
- stop conditions.

## 4. Frozen inputs

Treat these as accepted and immutable in this task:

- engine: standard Godot `4.7.stable`;
- language: GDScript;
- renderer: Compatibility;
- logical viewport: 960×540 for the current milestone;
- vertical-slice committed platform: Windows x86_64;
- Web: deferred to a separate later gate;
- simulation authority: accepted `simulation_v1`;
- formal level authority: accepted `level_v1`;
- legal action set/order: `UP`, `RIGHT`, `DOWN`, `LEFT`, `WAIT`;
- one shared transition authority for gameplay, replay, tests, and solver;
- current player alone satisfies EXIT completion;
- schema-v1 mechanics: player, one or more delayed echoes, walls/floor, pressure plates, combinational AND doors, one exit, restart;
- no push, combat, enemy, hazard, anchor, latch, teleporter, interact action, alternate goal, or route-trigger mechanic in schema v1;
- current repaired vertical slice remains accepted at `L*=9`, `N*=31 (EXACT)` and must not be rewritten in this task;
- no unresolved P0/P1 blocks planning;
- the same-user retest does not replace a later fresh-player/independent review.

## 5. Carried UX observations

### 5.1 P2 information density

The current repaired HUD succeeded in clarifying the objective, entities, EXIT, and completion. However, the screen now contains many explanatory elements, while `Echo next` and the full text history queue were reported as only modestly useful.

The plan must not simply delete planning information. It must define progressive disclosure and testable HUD modes, including:

- what is shown in the no-echo tutorial;
- what appears when the echo is introduced;
- what remains in standard play after the concept is learned;
- whether the full history queue is always visible, compacted into timeline slots, or available as an expanded view;
- how `Echo next` relates visually to the oldest history slot;
- how the legend and multi-line objective become contextual/temporary rather than permanent;
- how fresh-player evidence will determine whether information is removed.

### 5.2 P3 branching-route suggestion

The user suggested future gameplay in which player/echo door traversal could create different routes. Record this as a post-MVP concept with:

- potential player value;
- likely simulation/schema implications;
- risks to solver complexity and schedule;
- criteria for reconsideration after the candidate build.

Do not include it in the schema-v1 level roadmap or implementation tasks before 2026-08-10.

## 6. Required planning artifacts

Create all of the following.

### 6.1 System skeleton plan

```text
docs/architecture/SYSTEM_SKELETON_PLAN_CURRENT.md
```

It must define, at minimum:

#### Application states and transitions

Plan the smallest complete product flow:

```text
Boot
→ Main Menu
→ Level Select / Continue
→ Gameplay
→ Level Complete / Results
→ Next Level or Level Select
→ Final Completion / Credits
```

Also define:

- pause behavior;
- restart behavior;
- quit behavior;
- invalid-level/error route;
- how a direct development launch may still enter a chosen test level;
- what belongs in the 8/10 candidate versus later polish.

#### Scene/module ownership

Provide recommended responsibilities and dependencies for concepts such as:

- `AppRoot` or equivalent scene router;
- main menu;
- level select;
- reusable gameplay scene/controller;
- board renderer/presentation;
- HUD;
- result screen;
- level catalog/registry;
- progress interface;
- settings interface;
- existing pure loader/simulation/solver modules.

Names are recommendations, not implementation facts. Explicitly show which modules may call the shared transition and which must remain presentation-only.

#### Level catalog boundary

Compare at least these options:

1. extend `level_v1` metadata;
2. separate JSON catalog/manifest;
3. Godot Resource-based catalog;
4. hard-coded registry.

Recommend one for the current project and explain:

- why simulation data stays independent from menu/progression/presentation data;
- ordering and display-title ownership;
- tutorial/standard classification;
- unlock prerequisites;
- optional best-turn thresholds;
- UI/HUD mode selection;
- final-level flag;
- how missing/broken catalog entries fail safely;
- versioning/migration considerations.

Do not create the catalog file in this task.

#### Progress/save boundary

Define interfaces and data that will eventually be needed, but keep save implementation behind a separate task. Distinguish:

- in-memory progress acceptable for early system-skeleton testing;
- persistent progress required for candidate completion;
- fields likely needed: unlocked levels, completed levels, best turns, settings, tutorial flags;
- save versioning and isolated test profile requirements;
- protected operations requiring a later save-specific gate.

Do not freeze a storage path/format unless the document clearly marks it as `RECOMMENDATION_FOR_GPT_DECISION`.

#### Failure and error handling

Plan behavior for:

- malformed catalog;
- invalid formal level;
- missing level file;
- solver validation unavailable;
- completion route failure;
- future save corruption.

No failure may silently enter a partial game state.

### 6.2 Tutorial and HUD progression plan

```text
docs/game_design/TUTORIAL_AND_HUD_PROGRESSION_PLAN_CURRENT.md
```

It must include:

#### Learning objectives

Order the concepts so each step introduces one primary idea:

1. YOU, EXIT, movement, restart, completion;
2. ECHO identity and delay;
3. current actions become future echo actions;
4. pressure plate and door relationship;
5. door changes affect entry on the following turn;
6. WAIT as an intentional planning action;
7. full independent puzzle solving.

#### Tutorial sequence

Design at least two tutorial levels and identify where the accepted vertical slice belongs. Recommended minimum structure:

- `Tutorial 0`: no-echo controls/EXIT level using the explicit zero-echo tutorial exception;
- `Tutorial 1`: smallest mechanically echo-required plate/door level;
- `Tutorial 2` or `Core 1`: accepted vertical slice as the first less-guided puzzle.

For each tutorial, specify:

- teaching goal;
- schema-v1 mechanics used;
- what the player must demonstrate;
- what HUD/copy is visible initially;
- when copy fades, collapses, or changes;
- what is intentionally not introduced;
- failure/confusion risks;
- solver-validation requirement;
- human-review requirement;
- whether the level must be echo-necessary;
- approximate target `L*` range as an unverified design target.

Do not claim a concrete shortest path until a future solver executes a formal level.

#### Progressive HUD modes

Define no fewer than three planned modes:

- `INTRO_MINIMAL`;
- `GUIDED_ECHO`;
- `STANDARD_COMPACT`.

For each, define visibility of:

- objective;
- entity legend;
- Echo next;
- full history/timeline;
- turn count;
- delay;
- door status;
- controls;
- completion overlay.

The plan should prefer a compact visual timeline over permanently duplicated prose where appropriate, but must preserve enough information for multi-delay future levels. Specify what requires fresh-player testing before removal.

#### Copy and language policy

Plan concise Chinese-first copy for the final game while allowing current English development copy to remain temporarily. Define:

- which strings must become data/localization-owned;
- how tutorial copy avoids revealing exact routes;
- how the objective remains explicit without permanently occupying excessive space;
- whether English is deferred from the 8/10 candidate.

No localization implementation is authorized.

### 6.3 Initial level roadmap and validation matrix

```text
docs/level_design/INITIAL_LEVEL_ROADMAP_AND_VALIDATION_MATRIX_CURRENT.md
```

Plan an 8-level candidate spine, counting tutorials, using only schema-v1 mechanics. The roadmap should include:

- 2–3 tutorial/onboarding levels;
- the accepted vertical slice, either preserved as-is or assigned a roadmap role without changing it;
- 4–5 additional core levels;
- no more than 8 levels required for the 8/10 candidate unless later progress is ahead of schedule.

For every planned level, include a table with:

- working ID/title;
- sequence position;
- teaching/design goal;
- echoes and delay configuration;
- plates/doors used;
- intended reasoning structure;
- whether WAIT should be required;
- whether echo cooperation must be mechanically necessary;
- target difficulty tier;
- unverified target `L*` band;
- desired shortest-solution multiplicity tendency (`many`, `moderate`, `few`) without inventing `N*`;
- mandatory solver checks;
- mechanic-necessity variant;
- human-review checkpoint;
- HUD mode;
- scope-cut priority.

The roadmap must demonstrate variety through geometry and timing rather than unsupported mechanics. Candidate structures may include:

- one delay-3 echo;
- multiple pressure plates feeding one AND door;
- multiple doors with different plate sets;
- two echoes with different delays;
- blocked historical actions caused by current door state;
- intentional WAIT;
- overlapping actors;
- route planning that uses next-turn door timing.

Do not add goals other than current player on EXIT.

#### Difficulty/quality metrics

Define which metrics are mandatory at authoring, solver, and human-review stages:

- validity status;
- `L*`;
- `N*` and exact/capped status;
- visited-state/frontier/resource limits;
- replay result;
- echo/mechanic necessity;
- `W_req` or equivalent wait evidence;
- shortcut/teaching-goal bypass review;
- first-attempt completion and confusion notes;
- best-turn threshold only after evidence.

#### Acceptance ladder

Define level states such as:

```text
CONCEPT
→ SCHEMA_VALID
→ SOLVER_VALIDATED
→ REPLAY_VALIDATED
→ INTERNAL_PLAYABLE
→ FRESH_PLAYER_REVIEWED
→ CANDIDATE_ACCEPTED
```

State who/what may advance each gate and which claims are prohibited at each earlier stage.

### 6.4 M2 implementation plan

```text
docs/version_plans/M2_SYSTEM_SKELETON_IMPLEMENTATION_PLAN.md
```

Create a staged task plan after Task 0005. Do not create the future task files yet, but recommend a sequence comparable to:

- `Task 0006`: reusable app shell, scene routing, catalog loader, and in-memory progression;
- `Task 0007`: Tutorial 0–1 formal levels, reusable gameplay loading, solver validation, and regression;
- `Task 0008`: progressive HUD implementation and tutorial UX evidence;
- `Task 0009`: remaining schema-v1 candidate levels and validation matrix;
- later separate gates: persistent save, audio, visual direction, Windows export, Web compatibility, fresh-player review.

For each recommended task, include:

- objective;
- dependencies;
- allowed surfaces;
- protected surfaces;
- implementation scope;
- tests/evidence;
- commit policy suggestion;
- stop conditions;
- estimated schedule window;
- scope cuts.

The plan must not assume all tasks are automatically authorized. Each remains subject to a future GPT task file.

#### Schedule

Reconcile the plan with:

- M2 system skeleton target: 2026-07-20–07-24;
- M3 content production target: 2026-07-25–07-31;
- complete flow target: 2026-08-01–08-05;
- candidate stabilization: 2026-08-06–08-10.

If the current calendar makes any original milestone unrealistic, state it explicitly and propose the safest scope adjustment. Do not move the final submission deadline.

### 6.5 Planning report

```text
docs/reports/0005_SYSTEM_SKELETON_AND_TUTORIAL_LEVEL_PLANNING_REPORT.md
```

It must contain:

- verdict;
- task/start/final Git facts;
- files created/updated;
- sources inspected;
- major recommendations;
- decisions still awaiting GPT acceptance;
- handling of Task 0004V P2/P3 observations;
- confirmation that no runtime or protected surface changed;
- validation performed;
- subagents used/fallbacks;
- recommended next gate.

## 7. Planning quality requirements

### 7.1 Separate status types

Every material statement must be clearly one of:

- `ACCEPTED_EXISTING_FACT`;
- `PLANNING_RECOMMENDATION_FOR_GPT`;
- `UNVERIFIED_DESIGN_TARGET`;
- `DEFERRED_POST_MVP`;
- `OUT_OF_SCOPE`.

Do not write a proposal as though it is already implemented or frozen.

### 7.2 Preserve source-of-truth boundaries

- `level_v1` remains simulation data.
- Menu/progression/tutorial presentation must not silently become simulation semantics.
- The shared transition remains untouched.
- Solver outputs are evidence only when run against formal level data.
- Tutorial copy must not define hidden gameplay rules that differ from the contract.

### 7.3 Scope discipline

The plan must prefer:

- reuse over framework expansion;
- data-driven levels over scene-per-level logic;
- one reusable gameplay scene;
- schema-v1 content variety before schema-v2 mechanics;
- 8 strong levels over 12 weak levels;
- Windows completion before Web;
- fresh-player evidence before large content multiplication.

### 7.4 Fresh-player review requirement

Specify at least these future human gates:

- after Tutorial 0–1 and progressive HUD implementation;
- after four-level sequence exists;
- before 8/10 candidate acceptance.

At least one reviewer must not have seen the solver route or prior design discussion.

## 8. Optional subagent use

This planning task may use configured subagents if available:

- `docs_reader`: extract accepted decisions and evidence;
- `code_mapper`: read-only map of current project responsibilities;
- `planner_high`: architecture, task decomposition, and risk review;
- `code_reviewer`: read-only consistency check of the final planning package.

Constraints:

- no subagent may edit, commit, push, or change scope;
- provide exact read-only paths and output contracts;
- main thread must verify and integrate results;
- unavailable agents must be recorded honestly;
- do not fabricate independent review.

## 9. Authorized repository writes

Create:

- `docs/architecture/SYSTEM_SKELETON_PLAN_CURRENT.md`;
- `docs/game_design/TUTORIAL_AND_HUD_PROGRESSION_PLAN_CURRENT.md`;
- `docs/level_design/INITIAL_LEVEL_ROADMAP_AND_VALIDATION_MATRIX_CURRENT.md`;
- `docs/version_plans/M2_SYSTEM_SKELETON_IMPLEMENTATION_PLAN.md`;
- `docs/reports/0005_SYSTEM_SKELETON_AND_TUTORIAL_LEVEL_PLANNING_REPORT.md`.

Update only as needed:

- `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`;
- `docs/CODEX_ACTIVE_TASK_CURRENT.md`;
- `docs/DOC_INDEX_CURRENT.md`;
- `docs/DEVELOPMENT_PLAN_CURRENT.md`;
- `docs/HANDOFF_MASTER_CURRENT.md`;
- `docs/project_memory.md`.

Do not modify:

- `AGENTS.md`;
- project rules;
- GDD unless a direct contradiction makes planning impossible—in that case stop and report instead of editing;
- accepted contracts, schemas, fixtures, or prior reports;
- `project.godot`;
- any file under `scripts/`, `scenes/`, `data/`, `schemas/`, `tests/`, `assets/`, `audio/`, or `shaders/`;
- license files;
- export/build/save/release surfaces.

## 10. Validation

Before staging:

```powershell
git status --short --untracked-files=all
git diff --check
git diff --stat
```

Review all planning files for:

- complete links and consistent terminology;
- no claim that planned systems/levels exist;
- no invented solver results;
- no unsupported mechanics in the candidate roadmap;
- explicit treatment of information-density P2;
- branching-route idea classified post-MVP;
- no save/export/release authorization;
- no source/runtime change;
- no secret-like or unrelated personal information;
- schedule and scope-cut consistency;
- current docs pointing to Task 0005 and its report.

Stage only the authorized Markdown paths explicitly. Never use broad staging.

Then run:

```powershell
git diff --cached --check
git diff --cached --stat
git diff --cached --name-only
```

## 11. Commit and push authorization

This task authorizes one documentation-only planning commit on `main` and one normal push to `origin/main` if all gates pass.

Required commit message:

```text
docs: plan Delayed Self system skeleton and tutorials
```

Immediately before push:

```powershell
git fetch origin
git rev-parse HEAD
git rev-parse origin/main
git status --short --untracked-files=all
```

If remote moved after Task 0005 began, stop. Do not merge, rebase, amend, force-push, overwrite, or create a second commit without a new instruction.

## 12. Stop conditions

Stop with `BLOCKED` if:

- startup/root/Git gate fails;
- the accepted contract and desired tutorial progression cannot be reconciled without a schema/semantic change;
- planning would require inventing solver evidence;
- the GDD materially contradicts accepted runtime authority;
- current source is unexpectedly dirty;
- the task would require modifying runtime/source/protected files;
- remote drifts before push.

If schema-v1 cannot support an intended roadmap level, classify that concept as deferred rather than silently extending the schema.

## 13. Terminal verdicts

Use exactly one:

- `PASS_FOR_GPT_REVIEW`;
- `PASS_WITH_OBSERVATIONS_FOR_GPT_REVIEW`;
- `BLOCKED`.

A pass means the planning package is ready for GPT review. It does not authorize Task 0006 or any implementation automatically.

## 14. Recommended next gate

Recommend one after completing the plan:

- `Task 0005R` — planning correction if material conflicts remain;
- `Task 0006` — reusable app shell, level catalog, scene routing, and in-memory progression implementation;
- a narrower architecture spike if one decision cannot be safely resolved in planning.
