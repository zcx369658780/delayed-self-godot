# Task 0014 — Level 7 two-ECHO convergence planning

- Status: `READY`
- Gate: `DESIGN PLANNING / LEVEL 7 FORMAL TARGET FREEZE`
- Repository: `zcx369658780/delayed-self-godot`
- Expected branch: `main`
- Expected local root: `D:\Delayed_Self`
- Issued by: GPT Project Sources advisor
- Date: 2026-07-17
- Prior accepted gate: `TASK_0013B_OWNER_LEVEL_6_REVIEW_ACCEPTED_INTERNAL_EVIDENCE`
- Owner-review commit: `e5285d1e49aac8bd0b1a4778cd602bbe89e8bc43`
- GPT acceptance artifact: `docs/reports/0013B_GPT_FINAL_ACCEPTANCE.md`
- GPT acceptance commit: `b7dc1ebcd14e19c1cd2832471e281cfa48020247`
- Accepted implementation baseline: `1e43e9baa82a578fdb14f556e4895d42863513d9`
- Frozen runtime authority: `simulation_v1`
- Frozen data authority: `level_v1`

## 1. Objective

Produce a documentation-only, implementation-ready Level 7 design plan that creates a materially more complex puzzle than Level 6 while remaining entirely inside the accepted simulation and schema.

The task must:

1. evaluate bounded Level 7 structures using two ECHOs with distinct delays;
2. select exactly one preferred formal implementation target;
3. preserve Level 8 as a later synthesis/finale candidate rather than consuming its full complexity now;
4. define exact structural requirements, target metric bands, proof obligations, stop conditions, and owner-review criteria;
5. resolve the product direction for Timeline and Help before implementation;
6. define how multiple actors, Plates, and Doors will remain visually and conceptually distinguishable;
7. carry forward the owner-only playtest constraint without seeking or requiring a third party;
8. leave the repository ready for a separately authorized Level 7 implementation task.

This task must not create or modify a formal level, catalog entry, test, source file, scene, project setting, asset, audio file, or runtime behavior.

## 2. Product context and accepted evidence

Level 6 `staggered_doors` is accepted at `INTERNAL_PLAYABLE` with:

```text
one ECHO, delay 3
two Plates
two unavoidable single-dependency Doors
L* = 15
N* = 4 EXACT
visited_states = 6772
maximum_frontier = 1179
```

Task 0013B owner evidence records:

```text
Level 5: Turn 13, approximately 3 seconds, 1 restart
Level 6: Turn 16, approximately 1 minute, 2 restarts
P0 = 0
P1 = 0
P2 = 3
P3 = 1
```

The owner:

- understood delay-3 replay;
- distinguished the two Door events;
- completed Level 6 without assistance;
- judged it harder than Level 5;
- recommended preserving it;
- requested a more complex Level 7.

Mandatory Level 7 planning inputs:

1. same-colored switches/Doors made dependency order harder to remember;
2. current Timeline was judged unintuitive and unhelpful;
3. text Help was judged difficult to understand and unnecessary at current difficulty;
4. difficulty must come from temporal reasoning, not hidden relationships, unreadable state, reverse-counting burden, or corridor length.

## 3. Claim boundary

A successful Task 0014 may establish only:

```text
LEVEL_7_IMPLEMENTATION_PLAN_READY_FOR_GPT_REVIEW
```

After GPT acceptance, it may support a separately authorized Level 7 implementation task.

It does not establish:

- a created or solvable Level 7;
- `SCHEMA_VALID`, `SOLVER_VALIDATED`, `REPLAY_VALIDATED`, `INTERNAL_PLAYABLE`, `FRESH_PLAYER_REVIEWED`, or `CANDIDATE_ACCEPTED` status for Level 7;
- final difficulty, fun, balance, or player comprehension;
- final Timeline, Help, HUD, art, audio, narrative, animation, accessibility, localization, persistence, export, release, or submission acceptance.

## 4. Mandatory startup gate

Before any write:

```powershell
Get-Location
git branch --show-current
git rev-parse HEAD
git rev-parse origin/main
git remote -v
git status --short --untracked-files=all
git log -32 --oneline --decorate
```

Required:

- root exactly `D:\Delayed_Self`;
- branch `main`;
- expected origin;
- fully clean tracked and untracked worktree;
- local `HEAD == origin/main` and both contain this task and `docs/reports/0013B_GPT_FINAL_ACCEPTANCE.md`.

If clean local `main` is behind, use only:

```powershell
git fetch origin
git merge --ff-only origin/main
```

Stop on divergence, conflict, wrong root/remote, unexpected files, missing acceptance artifacts, or inability to fast-forward.

## 5. Required reads

Read in order:

1. `AGENTS.md`;
2. `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`;
3. `docs/CODEX_ACTIVE_TASK_CURRENT.md`;
4. this task;
5. `docs/reports/0013B_GPT_FINAL_ACCEPTANCE.md`;
6. `docs/reviews/0013B_OWNER_TARGETED_LEVEL_6_REVIEW.md`;
7. `docs/reports/0013B_OWNER_TARGETED_LEVEL_6_REVIEW_REPORT.md`;
8. `docs/reports/0012_GPT_FINAL_ACCEPTANCE.md`;
9. `docs/reports/0012_LEVEL_6_STAGGERED_DOORS_REPORT.md`;
10. `docs/level_design/FIVE_LEVEL_DIFFICULTY_RECOVERY_AND_LEVELS_6_8_PLAN.md`;
11. `docs/level_design/INITIAL_LEVEL_ROADMAP_AND_VALIDATION_MATRIX_CURRENT.md`;
12. `docs/game_design/GAMEPLAY_SIMULATION_CONTRACT_CURRENT.md`;
13. `docs/level_design/LEVEL_SCHEMA_V1_CURRENT.md`;
14. `schemas/level_v1.schema.json`;
15. `docs/architecture/LEVEL_CATALOG_V1_CURRENT.md`;
16. `docs/ux/PRESENTATION_VIEWPORT_AND_HUD_DIRECTION_CURRENT.md`;
17. `docs/game_design/TUTORIAL_AND_HUD_PROGRESSION_PLAN_CURRENT.md`;
18. current development plan, index, handoff, and project memory;
19. puzzle-validation, evidence, Git, and Godot-safety project rules.

Before editing, print a concise planning summary covering:

- accepted Level 6 facts and owner observations;
- Level 7 scope and non-goals;
- frozen runtime/schema boundary;
- candidate-comparison method;
- Timeline/Help decision requirement;
- dependency-legibility requirement;
- target proof package;
- documentation-only Git policy.

## 6. Frozen design boundary

Level 7 must use only accepted schema-v1 concepts:

- rectangular grid and walls;
- one current player;
- ECHOs replaying the same input history at fixed delays;
- Plates;
- combinational Doors using existing `all_plate_ids` semantics;
- player-only EXIT;
- accepted next-turn/open-snapshot Door behavior;
- accepted overlap, collision, restart, and completion rules.

The selected target should normally use:

```text
two ECHOs
two distinct delays
two or three Plates
one or two Doors
one player-only EXIT
```

The plan must not introduce:

- Gate, latch, toggle, switch, one-shot state, anchor, hazard, laser, bridge, key inventory, box pushing, enemy, combat, teleport, new goal, new actor type, new action, or schema change;
- a second input history;
- independently controlled ECHOs;
- a new runtime or solver rule;
- a dependency whose meaning exists only in prose or color without formal data.

Preserve the later Level 8 role. Do not select a Level 7 structure that already consumes the full intended Level 8 synthesis of multiple stages, three Plates, and mixed single/AND Door chains unless the plan proves why the Level 8 roadmap should be revised.

## 7. Candidate comparison

Develop and compare at least three bounded schema-v1 candidates. Each candidate must include:

- working ID and title;
- one-sentence mental model;
- exact ECHO delays;
- Plate and Door counts;
- each Door dependency set;
- approximate board dimensions;
- ASCII or coordinate-level structural sketch;
- route topology;
- intended synchronization obligation;
- why both ECHOs are necessary;
- how it differs from Level 6;
- expected meaningful decisions;
- expected recovery pattern after plausible mistakes;
- anticipated shortcut risks;
- anticipated observability risks;
- provisional metric band;
- effect on the later Level 8 concept;
- reasons to select or reject it.

At least these families must be considered:

### Candidate family A — AND convergence

Two ECHOs with distinct delays align on two separate Plates to open one AND Door for the player.

### Candidate family B — dual-ECHO staggered windows

Two ECHOs with distinct delays create two temporally separate Door opportunities without copying Level 6's one-ECHO route structure.

### Candidate family C — bounded hybrid

A compact combination of one preparatory obligation and one simultaneous convergence, constrained so that Level 8 still retains a larger two-stage synthesis role.

Do not select based only on predicted `L*`, low solution count, or map size. Select based on temporal reasoning, actor necessity, observability, recoverability, proof feasibility, production risk, and sequence role.

## 8. Required selected-target freeze

Select exactly one preferred Level 7 target and freeze the following in the plan:

- canonical proposed `level_id` and display title;
- exact ECHO count and delays;
- exact Plate count;
- exact Door count and dependency sets;
- board-size range and topology;
- player/ECHO spawn relationship;
- EXIT role;
- intended temporal reasoning chain;
- required synchronization-window count and width;
- minimum number of meaningful decisions;
- plausible wrong actions and expected recovery penalties;
- explicit anti-padding rule;
- explicit shortcut and bypass hypotheses;
- implementation-order recommendation;
- proof-package checklist;
- owner-review questions;
- stop conditions.

The selected target must materially exceed Level 6 in reasoning structure. At minimum it must require:

1. two distinct ECHO delays;
2. both ECHOs to be individually necessary;
3. at least one synchronization obligation that cannot be replaced by one actor following a longer route;
4. explicit tracking of two future replay positions or actions;
5. at least four meaningful decisions or an equivalent justified reasoning burden;
6. a topology that is not merely a longer corridor or a larger copy of Level 6;
7. directly observable actor roles and dependency relationships.

## 9. Quantitative target bands

Start from the current proposal:

```text
L* = 17–25
N* = 1–8, exact preferred
visited_states = 8000–150000
maximum_frontier = 1000–25000
required synchronization window = 1–2 turns
```

The plan may refine a band only with written reasoning. Do not rewrite a target after later implementation results are known.

Also define:

- solver depth, state, time, and count-cap starting limits;
- exact/capped count policy;
- complete-unsolved interpretation rules;
- target number of meaningful branches;
- controlled-variant expectations;
- owner-facing difficulty target as a review target, not a promise.

Given the Task 0013B result, the owner-facing Level 7 target should normally seek a clear increase over approximately 1 minute and two restarts without using obscurity as difficulty. Any proposed timing/restart band must be labeled `OWNER_REVIEW_TARGET_NOT_FRESH_NOT_INDEPENDENT`.

## 10. Mandatory machine-proof plan

The selected target's later implementation task must be able to prove:

1. strict schema/catalog load;
2. solver completion and replay;
3. exact restart equality;
4. canonical metric and formal hash record;
5. each ECHO individually necessary through remove/isolate controls;
6. each Plate and Door dependency necessary;
7. equalizing ECHO delays materially changes or destroys the intended synchronization structure;
8. relocating at least one Plate materially changes or destroys the intended structure;
9. no player-only or single-ECHO route bypass;
10. ECHO on EXIT remains non-terminal;
11. every required Door crossing occurs from the accepted open snapshot;
12. shortest-solution or bounded-solution traces demonstrate the intended actor roles;
13. meaningful-decision alternatives incur measurable penalties or different future states;
14. all six prior formal level hashes and metrics remain unchanged;
15. aggregate regression remains green.

Define the exact controlled variants expected, but do not implement them in Task 0014.

## 11. Dependency legibility decision

The plan must ensure that difficulty does not come from same-colored or otherwise indistinguishable relationships.

Define a presentation requirement for later implementation using a redundant combination of at least two cues, such as:

- distinct color families;
- numeric or alphabetic labels;
- matching Plate/Door icons;
- connecting line or pulse language;
- spatial grouping;
- actor-specific markings;
- shape differences that remain readable without color.

Do not select exact final art assets or licensed resources. Primitive shapes, labels, and existing presentation systems should remain sufficient for the Level 7 implementation gate.

The plan must state how the cue survives:

- common color-vision differences;
- overlap of two ECHOs;
- 960×540 physical-window readability;
- compact HUD constraints;
- screenshots and motion.

## 12. Timeline and Help disposition

Choose exactly one primary Timeline disposition:

```text
TIMELINE_RED_DESIGN_REQUIRED_BEFORE_LEVEL_7
TIMELINE_DEEMPHASIZED_SUPPORT_ONLY
TIMELINE_REMOVED_FROM_LEVEL_7_TEACHING_GOAL
```

The spelling `TIMELINE_RED_DESIGN_REQUIRED_BEFORE_LEVEL_7` is intentionally not preferred; if a redesign is selected, normalize it in the plan to the correctly named project verdict:

```text
TIMELINE_REDESIGN_REQUIRED_BEFORE_LEVEL_7
```

Do not preserve both names.

The plan must explain:

- whether Level 7 must be solvable from board-state reasoning without reverse-counting;
- what Timeline may show, if retained;
- whether the compact or expanded form changes;
- what evidence would justify redesign work;
- whether Timeline changes are required before formal Level 7 implementation or may be separately deferred.

Choose exactly one Help disposition:

```text
HELP_CONTEXTUAL_OPTIONAL
HELP_VISUAL_REDESIGN_REQUIRED
HELP_DEEMPHASIZED_FOR_LEVEL_7
```

Help must not reveal movement sequences, routes, or exact synchronization timing. It cannot compensate for unreadable board state.

## 13. Owner-only review protocol

The plan must preserve:

```text
FRESH_INDEPENDENT_REVIEW_UNAVAILABLE_BY_OWNER_CONSTRAINT
```

Do not seek, require, contact, recruit, or suggest any third-party reviewer.

Define a later owner review classified as:

```text
AUTHENTICATED_OWNER_NOT_FRESH_NOT_INDEPENDENT_LEVEL_7_REVIEW
```

The owner review plan should record:

- unassisted/assisted completion;
- visible turn count;
- supplied elapsed time and restart count;
- whether both ECHO roles were understood;
- whether the synchronization obligation was predicted or found accidentally;
- whether dependency cues were readable;
- whether Timeline or Help was used and how;
- whether difficulty exceeded Level 6 for reasoning rather than obscurity;
- P0–P3 findings;
- recommendation to preserve, simplify, repair, or replace the level.

No owner result may be labeled fresh, blind, first-player, independent, or population-level evidence.

## 14. Authorized repository writes

Create:

```text
docs/level_design/LEVEL_7_TWO_ECHO_CONVERGENCE_PLAN_CURRENT.md
docs/reports/0014_LEVEL_7_TWO_ECHO_CONVERGENCE_PLANNING_REPORT.md
```

Update only the necessary subset of:

```text
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/level_design/FIVE_LEVEL_DIFFICULTY_RECOVERY_AND_LEVELS_6_8_PLAN.md
docs/level_design/INITIAL_LEVEL_ROADMAP_AND_VALIDATION_MATRIX_CURRENT.md
docs/ux/PRESENTATION_VIEWPORT_AND_HUD_DIRECTION_CURRENT.md
```

Do not modify:

- `AGENTS.md`;
- prior tasks, reports, reviews, acceptances, or validation records;
- GDD, simulation contract, schema, catalog contract, or project rules;
- `project.godot`;
- `scripts/`, `scenes/`, `data/`, `schemas/`, `tests/`, fixtures;
- assets, fonts, audio, shaders, imports, plugins, dependencies;
- user data, evidence, build, export, release, account, repository-setting, or submission surfaces.

## 15. Planning report requirements

`docs/reports/0014_LEVEL_7_TWO_ECHO_CONVERGENCE_PLANNING_REPORT.md` must include:

- start and final Git facts;
- files created and updated;
- candidate comparison summary;
- selected target and rejected alternatives;
- frozen structure and target bands;
- Timeline verdict;
- Help verdict;
- dependency-legibility requirement;
- proof-package summary;
- owner-review classification and no-third-party constraint;
- unresolved risks;
- explicit confirmation that no formal level, runtime, content, test, asset, or project setting changed;
- recommended next task;
- terminal verdict.

## 16. Validation

No Godot execution, solver run, import, editor launch, or gameplay launch is required or authorized. This is a documentation-only planning gate.

Before staging:

```powershell
git status --short --untracked-files=all
git diff --check
git diff --stat
```

Audit:

- only authorized Markdown files changed;
- exactly one selected Level 7 target exists;
- at least three candidates were compared;
- selected target remains inside `simulation_v1` and `level_v1`;
- no new mechanic or schema field is implied;
- Level 8 retains a distinct later role;
- metric targets are prospective and not presented as results;
- Timeline and Help each have one explicit disposition;
- dependency legibility uses redundant cues;
- owner-only review constraint is preserved;
- no implementation or review is falsely authorized;
- all links resolve.

Stage explicit files only. Never use broad staging.

Then run:

```powershell
git diff --cached --check
git diff --cached --stat
git diff --cached --name-only
```

## 17. Git discipline

This task authorizes one documentation-only commit:

```text
docs: plan Delayed Self Level 7 convergence
```

Immediately before push:

```powershell
git fetch origin
git rev-parse HEAD
git rev-parse origin/main
git status --short --untracked-files=all
```

Stop on remote drift. Push normally to `origin/main`.

Forbidden:

- broad staging;
- merge commit;
- rebase;
- amend;
- force-push;
- reset;
- broad restore;
- `git clean`;
- implementation or content commit;
- more than one commit for this planning gate.

After push require a clean worktree and `HEAD == origin/main`.

## 18. Terminal verdicts

Use exactly one:

```text
LEVEL_7_IMPLEMENTATION_PLAN_READY_FOR_GPT_REVIEW
```

```text
BLOCKED_LEVEL_7_PLAN_REQUIRES_SCHEMA_OR_RUNTIME_EXPANSION
```

```text
BLOCKED_LEVEL_7_PLAN_CANNOT_PRESERVE_OBSERVABILITY
```

```text
BLOCKED
```

No terminal verdict is final GPT acceptance or implementation authority.

## 19. Next gate

If the plan is accepted by GPT, the next task may implement exactly the selected Level 7 formal target, catalog progression, focused validation/capture tests, and required primitive dependency cues. Any Timeline redesign, Help redesign, asset/audio/narrative work, Gate, persistence, export, release, or submission work remains separately gated unless the accepted plan proves it is an inseparable prerequisite and GPT explicitly authorizes it.
