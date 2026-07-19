# Task 0020 — Plan eight-level finale closure and production readiness

- Status: `READY`
- Gate: `EIGHT-LEVEL SCOPE FREEZE / FINALE PRESENTATION + PRODUCTION READINESS PLANNING`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Scope adjudication: `docs/reports/0019B_GPT_FINALE_SCOPE_REASSESSMENT_ADJUDICATION.md`
- Expected adjudication commit: `f9b3974f32254265f5150b1f74f7eac78dbf44ab`
- Formal finale: sequence 8 `two_echo_convergence`

## 1. Objective

Freeze the product at eight formal levels and produce one implementation-ready plan for:

1. giving sequence 8 a bounded finale/ending presentation using existing capabilities;
2. closing remaining gameplay/presentation/product gaps without adding another puzzle room;
3. ordering later implementation, machine validation, owner-only review, build/export, release, and festival-submission gates.

This task is documentation and inspection only. It must not implement the ending, edit product/test files, run candidate search, revive sequence 9, build/export, or prepare a submission package.

Intermediate progress updates are not terminal results. Continue until one terminal verdict in section 12 is reached unless an explicit blocker occurs.

## 2. Startup gate

Before inspection:

- verify root exactly `D:\Delayed_Self`;
- verify branch `main` and expected SSH origin;
- require a clean tracked and untracked worktree;
- fetch and fast-forward only;
- require `HEAD == origin/main` and that HEAD contains `f9b3974f32254265f5150b1f74f7eac78dbf44ab`;
- verify no residual Godot process.

Stop on divergence, conflict, wrong root/remote, unexpected files, or dirty state.

## 3. Required reads

Read:

1. `AGENTS.md`, current startup and active-task documents;
2. the GPT scope-reassessment adjudication;
3. Tasks 0018, 0019, 0019A, and 0019B plus their reports/adjudications;
4. the GDD ending/narrative sections and current level roadmap;
5. sequence-8 validation and catalog/progression facts;
6. Task 0017RC/0017RCV Help, owner, and evidence boundaries;
7. current Gameplay/AppRoot completion flow, menus, Level Select, persistence, presentation, settings, tests, export/tooling reports, and generated-file safety contracts.

Inspect product files read-only as needed. Do not run Godot unless a narrowly bounded read-only startup/capture inspection is essential; document any such run and make no repository write.

## 4. Frozen scope

Treat as final for this planning gate:

- exactly eight formal levels;
- byte-identical existing level JSON files and accepted hashes/metrics;
- byte-identical eight-entry catalog;
- sequence 8 `two_echo_convergence` remains sole final;
- no `signal_convergence.json`;
- no candidate A/B/C continuation;
- no new mechanic, schema, Simulation, solver, action, actor, Plate, Door, or puzzle room;
- bridge contextual Help remains accepted;
- Help remains manual, zero-turn, contextual, reusable, and non-route;
- Timeline remains optional;
- owner-only review and no-third-party constraint remain active.

Sequence-9 concepts and B007 are historical diagnostic evidence only.

## 5. Finale presentation options

Compare exactly these bounded ending directions:

### A — Final-level completion copy only

Use the existing completion overlay/copy path to give sequence 8 a short finale-specific acknowledgment after ordinary YOU-on-EXIT completion. No new screen or flow.

### B — Final-level completion overlay plus bounded return state

Use existing completion presentation plus a minimal final-state affordance, such as an explicit ending acknowledgment and a clear return-to-menu/Level Select action, without adding a cutscene, credits system, save contract, or new scene architecture.

### C — No product ending change

Keep the current generic completion presentation and treat external festival copy/screenshots as the narrative wrapper.

Select one primary and at most one fallback. Prefer the smallest option that makes sequence 8 feel intentionally final rather than merely the last catalog entry.

Do not authorize exact implementation copy in this task unless needed as a provisional example. Any final copy must remain consistent with the game theme: the response is late, cannot change the past, but is still heard or acknowledged.

## 6. Production-readiness inventory

Create a source-backed inventory with status, evidence, severity, dependency, and proposed gate for at least:

- title/menu and new-game/continue/reset behavior;
- eight-level progression and final-level completion return;
- Level Select scroll/focus/accessibility;
- Help and Timeline behavior;
- 960×540, resize, window fill, grayscale, reduced motion, and overlap readability;
- keyboard controls and controller support status if any;
- persistence/save compatibility and reset safety;
- safe error handling;
- ending/finale presentation;
- credits, attribution, licenses, and third-party asset status;
- audio/music status;
- icon, splash, screenshots, store/festival copy, and submission media status;
- Windows and Web export/toolchain readiness;
- build/version naming and reproducibility;
- regression suite and evidence inventory;
- known owner-only review limitations;
- localization status and English-only residual limitations.

Do not infer unsupported readiness. Use `READY`, `PARTIAL`, `MISSING`, `DEFERRED`, or `NOT_APPLICABLE`, with evidence references.

## 7. Milestone and gate design

Propose a compact ordered milestone spine after Task 0020. It should normally separate:

1. finale presentation implementation;
2. machine/capture acceptance;
3. owner-only finale/product walkthrough;
4. production/readiness fixes;
5. export/build validation;
6. release-candidate acceptance;
7. festival submission packaging.

Merge gates only when the change and evidence are genuinely inseparable. Do not create an excessive task chain.

For each gate, specify:

- authorized paths and forbidden scope;
- objective and acceptance criteria;
- required tests/captures/evidence;
- owner review classification and exposure limitations where applicable;
- rollback and stop conditions;
- exact non-claims.

## 8. Ending implementation contract

For the selected ending direction, define a later implementation contract that:

- triggers only for the catalog-marked final level through stable data, not hard-coded route progress or witness state;
- preserves ordinary YOU-on-EXIT completion semantics;
- does not change Simulation, solver, level JSON, catalog count/order, persistence contract, or prior progress;
- uses existing scene/presentation architecture whenever feasible;
- remains readable at 960×540, grayscale, and reduced motion;
- does not require sound, animation, Timeline, localization, or route knowledge;
- provides a deterministic testable state and clear exit/return behavior;
- does not introduce a cutscene system, branching narrative, accounts, networking, or a new asset pipeline.

Explicitly identify whether the existing route payload `final_level` fact is sufficient or whether a stable catalog-derived fact must be passed differently. Do not implement it here.

## 9. Owner review and evidence boundary

Future human evidence remains:

```text
OWNER_ONLY_REVIEW
FRESH_INDEPENDENT_REVIEW_UNAVAILABLE_BY_OWNER_CONSTRAINT
```

No third-party reviewer may be sought, required, contacted, recruited, or suggested.

Plan an owner walkthrough that evaluates:

- whether sequence 8 now feels intentionally final;
- whether the ending message is understandable and emotionally appropriate;
- whether completion/return behavior is clear;
- whether the full eight-level arc feels coherent;
- Help/Timeline/presentation issues that remain visible;
- P0–P3 findings.

Prior mechanical and route exposure must be disclosed. Completion time and difficulty cannot be treated as fresh discovery evidence.

## 10. Outputs

Create:

```text
docs/production/EIGHT_LEVEL_FINALE_CLOSURE_AND_PRODUCTION_PLAN_CURRENT.md
docs/reports/0020_EIGHT_LEVEL_FINALE_CLOSURE_PLANNING_REPORT.md
```

Update only the minimum CURRENT navigation, development-plan, handoff, GDD/roadmap, presentation-direction, and project-memory Markdown files necessary to freeze eight-level scope and point to the next gate.

The plan must include:

- explicit retirement/deferment of sequence 9 from current product scope;
- ending-option comparison and one selected primary;
- source-backed readiness matrix;
- ordered milestone/gate spine;
- selected ending implementation contract;
- owner-only review plan;
- stop conditions, rollback, and non-claims.

## 11. Authorized repository paths and Git discipline

May create/update only Markdown under:

```text
docs/production/EIGHT_LEVEL_FINALE_CLOSURE_AND_PRODUCTION_PLAN_CURRENT.md
docs/reports/0020_EIGHT_LEVEL_FINALE_CLOSURE_PLANNING_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/game_design/DELAYED_SELF_GAME_DESIGN_DOCUMENT_CURRENT.md
docs/level_design/FIVE_LEVEL_DIFFICULTY_RECOVERY_AND_LEVELS_6_8_PLAN.md
docs/level_design/INITIAL_LEVEL_ROADMAP_AND_VALIDATION_MATRIX_CURRENT.md
docs/level_design/LEVEL_8_FINALE_AND_DIFFICULTY_BRIDGE_PLAN_CURRENT.md
docs/level_design/SIGNAL_CONVERGENCE_FINALE_PLAN_CURRENT.md
docs/ux/PRESENTATION_VIEWPORT_AND_HUD_DIRECTION_CURRENT.md
```

Do not modify tasks, prior reports/adjudications, formal levels, catalog, source, tests, schemas, scenes, settings, assets, persistence, build, export, release, or submission files.

Use one documentation-only commit:

```text
docs: plan Delayed Self eight-level finale closure
```

Push normally and require a clean worktree, `HEAD == origin/main`, divergence `0/0`, and no residual Godot process.

## 12. Terminal verdict

Return exactly one:

```text
EIGHT_LEVEL_FINALE_CLOSURE_PLAN_READY_FOR_GPT_REVIEW
BLOCKED_EIGHT_LEVEL_FINALE_CLOSURE_PLANNING
```

Include commit SHA, selected ending direction and fallback, major readiness gaps, proposed next gate, output paths, any inspection runs, and final Git state.

This task authorizes no product implementation, owner acceptance, build/export, release, or submission work.