# Task 0016 — Level 8 finale and difficulty-bridge sequencing plan

- Status: `READY`
- Gate: `CONTENT SEQUENCING + FINALE DESIGN / PLANNING ONLY`
- Repository: `zcx369658780/delayed-self-godot`
- Expected branch: `main`
- Expected local root: `D:\Delayed_Self`
- Issued by: GPT Project Sources advisor
- Date: 2026-07-17
- Prior accepted gate: `TASK_0015RV_BLOCKING_P2_CLOSED_FOR_OWNER_EVIDENCE_ACCEPTED`
- Prior acceptance: `docs/reports/0015RV_GPT_FINAL_ACCEPTANCE.md`
- Prior acceptance commit: `df4e8361969cff1b4ca6248a4defbec21b152212`
- Accepted Level 7 implementation: `27a678da47d1ba34ed012f8840b8c80c775e8be1`
- Accepted Level 7 repair: `538ced4c24beca1d7b143e9934fd9f10554b64b4`
- Formal Level 7 SHA-256: `772410d3b8bb807e35472ee2a7d07b703de66e1e0e92ffb4d1ff8433a345d5fd`

## 1. Objective

Create one implementation-ready planning decision for the next formal content step after the seven accepted levels.

The planning task must not assume that the next catalog item must be the final `signal_convergence` room. It must explicitly decide whether the project should:

1. implement the current Level 8 finale concept directly;
2. insert a schema-v1 bridge level between Level 6 and the current Level 7, shifting the current Level 7 and future finale to later sequence numbers;
3. use another bounded schema-v1 sequencing structure that credibly addresses the observed Level 6-to-7 difficulty discontinuity without relying on Help, Timeline, exact walkthroughs, or a new mechanic.

The task must compare at least three concrete candidates, select exactly one recommended sequencing plan, freeze exactly one next formal implementation target, and preserve a separate future-finale role when the selected next target is a bridge.

This is planning and documentation only. Do not create or edit formal JSON, catalog entries, source, tests, scenes, project settings, assets, or runtime behavior.

## 2. Accepted evidence and decision boundary

Carry forward without reinterpretation:

### 2.1 Level 6

- `staggered_doors` is GPT accepted at `INTERNAL_PLAYABLE`;
- one delay-3 ECHO, two Plates, two separate Door windows;
- exact `L*=15`, `N*=4 EXACT`, visited `6772`, frontier `1179`;
- owner completed unassisted at visible Turn 16 in approximately 1 minute with two restarts;
- owner understood the two events and recommended preserving the room.

### 2.2 Level 7

- `two_echo_convergence` is GPT accepted at `INTERNAL_PLAYABLE`;
- E2/E4, A/B, one A+B Door, 9×7;
- exact `L*=19`, `N*=6 EXACT`, visited `61975`, frontier `21449`;
- all six shortest solutions require E2 on A and E4 on B and an open-snapshot crossing;
- transition-derived spacing feedback is machine/presentation accepted;
- formal hash and metrics remain frozen.

### 2.3 Owner evidence

Task 0015RV is assisted owner evidence because the exact witness was previously exposed. It closes only:

```text
BLOCKING_P2_FALSE_UNSOLVABLE_MENTAL_MODEL_AND_RECOVERY_FAILURE
```

Accepted closure:

```text
BLOCKING_P2_CLOSED_FOR_OWNER_EVIDENCE
```

Residual P2 inputs remain:

1. Level 6-to-7 difficulty-ramp discontinuity and missing intermediate teaching;
2. Help ineffective for the spacing-manipulation causal lesson;
3. Timeline abstract and unused;
4. ECHO prediction and dependency dotted paths can overlap and create clutter.

The owner recommends preserving Level 7 and considering intermediate teaching content before it. This is product evidence, not automatic authority to insert a level.

### 2.4 Review constraint

The owner is the only available playtester. Do not seek, require, contact, recruit, or suggest any third party. Fresh/independent evidence remains unavailable and not claimed.

## 3. Mandatory startup gate

Before any write:

```powershell
Get-Location
git branch --show-current
git rev-parse HEAD
git rev-parse origin/main
git remote -v
git status --short --untracked-files=all
git log -40 --oneline --decorate
```

Required:

- root exactly `D:\Delayed_Self`;
- branch `main`;
- expected origin;
- clean tracked and untracked worktree;
- local `HEAD == origin/main` and contains this task plus `docs/reports/0015RV_GPT_FINAL_ACCEPTANCE.md`;
- no unresolved merge, rebase, cherry-pick, conflict, stash dependency, or unexpected file.

If clean local `main` is behind, use only:

```powershell
git fetch origin
git merge --ff-only origin/main
```

Stop on divergence, conflict, unexpected files, wrong root/remote, or inability to fast-forward.

## 4. Required reads

Read in order:

1. `AGENTS.md`;
2. current startup and active-task documents;
3. this task;
4. `docs/reports/0015RV_GPT_FINAL_ACCEPTANCE.md`;
5. `docs/reviews/0015RV_OWNER_LEVEL_7_DIVERGENCE_FEEDBACK_RETEST.md`;
6. `docs/reports/0015RV_OWNER_LEVEL_7_DIVERGENCE_FEEDBACK_RETEST_REPORT.md`;
7. `docs/reports/0015R_GPT_FINAL_ACCEPTANCE.md`;
8. `docs/reports/0015R_LEVEL_7_ECHO_DIVERGENCE_FEEDBACK_REPAIR_REPORT.md`;
9. `docs/reports/0015_GPT_FINAL_ACCEPTANCE.md`;
10. `docs/level_design/validation/TWO_ECHO_CONVERGENCE_VALIDATION.md`;
11. `docs/level_design/FIVE_LEVEL_DIFFICULTY_RECOVERY_AND_LEVELS_6_8_PLAN.md`;
12. `docs/level_design/INITIAL_LEVEL_ROADMAP_AND_VALIDATION_MATRIX_CURRENT.md`;
13. `docs/level_design/LEVEL_7_TWO_ECHO_CONVERGENCE_PLAN_CURRENT.md`;
14. `docs/level_design/LEVEL_7_FALSE_UNSOLVABLE_REPAIR_PLAN_CURRENT.md`;
15. `docs/game_design/GAMEPLAY_SIMULATION_CONTRACT_CURRENT.md`;
16. `docs/level_design/LEVEL_SCHEMA_V1_CURRENT.md`;
17. `docs/architecture/LEVEL_CATALOG_V1_CURRENT.md`;
18. tracked seven-entry catalog and all seven formal level files, read-only;
19. current presentation direction, development plan, handoff, index, and project memory;
20. current GDD only for milestone/finale role and non-goals.

Before drafting, print a concise summary of:

- accepted Level 6 and Level 7 progression evidence;
- exact residual P2 inputs;
- frozen simulation/schema/catalog boundaries;
- three candidate families to compare;
- scoring criteria and weights;
- expected decision outputs;
- authorized Markdown paths;
- explicit non-goals.

## 5. Planning-only freeze

Do not run:

- Godot;
- editor;
- game process;
- solver;
- Simulation scripts;
- capture harnesses;
- tests;
- import scan;
- export/build tools.

Do not modify:

```text
project.godot
data/
schemas/
scripts/
scenes/
tests/
assets/
audio/
shaders/
addons/
```

Do not create temporary candidate JSON inside the repository.

No formal metrics, solution count, playability, necessity, difficulty, or human-comprehension claim may be presented as measured evidence. All candidate values are prospective targets or planning judgments.

## 6. Frozen mechanics and prohibited shortcuts

The selected next formal target must stay within accepted `simulation_v1`, `level_v1`, catalog-v1, and reusable Gameplay.

Allowed mechanics:

- rectangular floor/walls;
- current YOU input history;
- accepted fixed-delay ECHOs reading the same history;
- Plates;
- combinational `all_plate_ids` Doors;
- player-only EXIT;
- legal overlap;
- accepted blocked-action history;
- accepted next-turn/open-snapshot Door behavior;
- restart and existing HUD/presentation facts.

Do not select or require:

- push boxes;
- Gate, latch, toggle, one-shot, persistent Door, switch, timer, key, inventory;
- hazard, enemy, combat, teleport, anchor, route divergence state, new goal;
- second controllable actor or independent ECHO history;
- schema/runtime/solver/catalog-contract expansion;
- exact operation Help or route walkthrough;
- Timeline as a required teaching dependency;
- literal WAIT as the teaching goal or padding;
- a larger maze or corridor length as the primary difficulty source.

Push-box and other new-mechanic ideas may be recorded only as deferred future concepts outside the selected next implementation target.

## 7. Required candidate comparison

Compare at least three concrete sequence candidates. The comparison must include these candidate families, though names and exact bounded structures may be refined:

### Candidate A — Direct finale

Proceed directly with a final-catalog candidate based on the current concept:

```text
signal_convergence
```

Minimum conceptual structure:

- two accepted ECHOs, provisionally delays 2 and 4;
- three Plates;
- two visible Door stages, one single dependency and one A+B dependency;
- player-only EXIT;
- compact readable topology;
- no new mechanic.

The analysis must explain how this candidate avoids worsening the Level 6-to-7 discontinuity and why residual Help/Timeline/clutter evidence does not make direct escalation irresponsible.

### Candidate B — Linear bridge inserted before current Level 7

Design one new schema-v1 bridge whose sole curriculum role is to make route/terrain/blocking-induced ECHO spacing change discoverable before two-ECHO A+B convergence.

The candidate must include a concrete catalog migration proposal, for example:

```text
new bridge becomes sequence 7
current two_echo_convergence shifts to sequence 8
future finale shifts to sequence 9
```

The current formal Level 7 file, ID, hash, metrics, and content must remain unchanged; only a later task could change catalog sequence/prerequisites.

The bridge must not reveal the current Level 7 route or reuse the same full A+B solution grammar. It should teach one bounded causal step and remain materially simpler than current Level 7.

### Candidate C — Another bounded sequencing solution

Evaluate one credible alternative, such as:

- an optional/branching practice level after Level 6 with current Level 7 retained as a challenge path;
- splitting the finale curriculum into a post-Level-7 mastery room followed by a later final synthesis;
- another schema-v1 sequence that addresses the ramp without editing accepted formal content.

The candidate must state exact progression implications and catalog/UX risk. A vague “improve Help” or “make Timeline clearer” is not a valid standalone candidate because those surfaces failed as primary teaching tools in owner evidence.

## 8. Scoring and decision method

Use a weighted five-point planning score with at least these criteria:

| Criterion | Minimum weight | Decision question |
|---|---:|---|
| Curriculum continuity | 20% | Does the sequence teach the spacing/blocking idea before requiring synthesis? |
| Mechanical differentiation | 15% | Is the next room distinct from Levels 6–7 rather than repetition or padding? |
| Finale preservation | 15% | Does the future finale retain a materially larger synthesis role? |
| Observability | 15% | Can the puzzle be reasoned from board and transition feedback without required Timeline/Help? |
| Proof feasibility | 15% | Can necessity, bypass, exact search, decisions, and recovery be audited decisively? |
| Production/presentation risk | 10% | Can 960×540 and current primitive cues remain readable? |
| Catalog/progression risk | 10% | Is the sequence migration bounded and testable? |

State uncertainty explicitly. Scores are planning judgments, not evidence.

Select exactly one recommended sequencing plan. Do not return multiple equal recommendations.

## 9. Required selected-plan outputs

The plan must freeze all of the following:

### 9.1 Sequence decision

Use one exact decision label, chosen or narrowly refined from:

```text
DIRECT_LEVEL_8_FINALE
INSERT_BRIDGE_BEFORE_CURRENT_LEVEL_7
BOUNDED_ALTERNATIVE_SEQUENCE
```

State:

- current catalog order;
- proposed future catalog order;
- which existing sequence numbers would shift;
- whether any existing formal file changes are proposed;
- prerequisite/final-level migration;
- rollback strategy.

### 9.2 Exact next formal implementation target

Freeze:

- proposed `level_id`;
- display title;
- sequence role;
- entity cardinalities;
- ECHO delays and spawn relationship;
- Plate count and dependency structure;
- Door count and exact dependency-set pattern;
- player-only EXIT;
- board envelope and topology class;
- intended mental model;
- at least three meaningful decision hypotheses;
- recovery expectations;
- anti-padding rule;
- shortcut and observability risks.

This is a formal target, not coordinates, route, JSON, witness, or accepted content.

### 9.3 Future finale role

If the next target is a bridge, preserve a separate future finale and freeze its role at concept level. State which mechanics and dependency depth remain reserved for it.

If the next target is the direct finale, freeze the exact finale scope and explain why no bridge is needed.

### 9.4 Prospective quantitative bands

Define prospective targets for:

- `L*`;
- `N*` and exactness requirement;
- visited states;
- maximum frontier;
- decision count;
- recoverable alternatives;
- dependency stages;
- synchronization/window requirements where applicable;
- owner-only review target, explicitly not fresh/independent.

Bands must reflect the selected role. A bridge must be clearly below current Level 7 reasoning burden; a finale must be above Level 7 without relying on path length or UI obscurity.

### 9.5 Mandatory machine-proof package

Define a complete future proof family appropriate to the selected target, including:

- strict load/catalog/progression;
- solve, replay, restart, exact metrics/hash;
- actor and dependency necessity controls;
- no-ECHO/single-ECHO or equivalent controlled variants;
- Door removal/dependency simplification;
- delay equalization/relocation where relevant;
- articulation and route-bypass audit;
- overlap and player-only EXIT;
- all-shortest or bounded event traces;
- meaningful-decision and recovery audit;
- prior seven hashes/metrics preserved;
- reusable Gameplay, AppRoot, capture, and aggregate regression.

A resource-limited result is not exact or complete-unsolved.

### 9.6 Presentation policy

Freeze these product rules:

- board-state and transition feedback are primary;
- Timeline is not a required teaching dependency;
- Help is contextual optional and cannot reveal a route;
- exact walkthrough Help is rejected for the selected formal target;
- supplementary color is allowed but never the sole relationship cue;
- A/B or equivalent labels/shapes/pips remain primary;
- ECHO identity remains badge/outline based;
- dotted dependency/prediction paths must not scale into a cluttered web.

Select one dependency-path policy, such as:

```text
MINIMIZE_ALWAYS_ON_DOTTED_PATHS
CONTEXTUAL_ONLY_RELATIONSHIP_LINES
LABEL_SHAPE_PIP_PRIMARY_NO_NEW_LINES
```

Any future line change remains separately implemented and tested.

### 9.7 Owner-only review plan

Future review classification must remain authenticated-owner, not fresh or independent.

Define questions that distinguish:

- learned bridge concept versus memorized route;
- reasoning increase versus visual/Help/Timeline friction;
- recovery understanding;
- satisfying finale synthesis versus repetitive replay;
- whether the selected sequence resolves the Level 6-to-7 discontinuity.

No third party may be sought or required.

## 10. Required outputs

Create:

```text
docs/level_design/LEVEL_8_FINALE_AND_DIFFICULTY_BRIDGE_PLAN_CURRENT.md
docs/reports/0016_LEVEL_8_FINALE_AND_DIFFICULTY_BRIDGE_PLANNING_REPORT.md
```

The plan must contain:

- accepted baseline and evidence boundaries;
- candidate comparison and weighted decision;
- exact selected sequence label;
- exact next formal target freeze;
- future finale role;
- catalog migration proposal;
- quantitative bands;
- machine-proof package;
- presentation/Help/Timeline/path policy;
- owner-only review plan;
- risks, stop conditions, rollback, non-claims, and next gate.

The report must contain:

- task and Git facts;
- files read;
- candidate summary and scores;
- exact decision and rationale;
- created/updated paths;
- confirmation that no Godot/solver/test/product file changed;
- unresolved risks;
- recommended next implementation gate.

## 11. Authorized repository surface

Create only:

```text
docs/level_design/LEVEL_8_FINALE_AND_DIFFICULTY_BRIDGE_PLAN_CURRENT.md
docs/reports/0016_LEVEL_8_FINALE_AND_DIFFICULTY_BRIDGE_PLANNING_REPORT.md
```

Update only the necessary subset of:

```text
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/level_design/INITIAL_LEVEL_ROADMAP_AND_VALIDATION_MATRIX_CURRENT.md
docs/level_design/FIVE_LEVEL_DIFFICULTY_RECOVERY_AND_LEVELS_6_8_PLAN.md
docs/ux/PRESENTATION_VIEWPORT_AND_HUD_DIRECTION_CURRENT.md
```

Do not modify prior tasks, reviews, reports, acceptances, validations, contracts, GDD, project rules, source, tests, formal data, catalog, assets, or project settings.

## 12. Git discipline

Before staging:

```powershell
git status --short --untracked-files=all
git diff --check
git diff --stat
```

Audit:

- only authorized Markdown paths changed;
- no Godot, solver, test, capture, import, or build process ran;
- no formal level/catalog/source/test/project-setting file changed;
- no measured-metric or playability overclaim appears;
- exactly one sequence decision and one next formal target are selected;
- residual owner-evidence limitations remain explicit;
- Level 8 implementation is not silently authorized.

Stage explicit paths only. Never use broad staging.

Then run:

```powershell
git diff --cached --check
git diff --cached --stat
git diff --cached --name-only
```

Commit exactly once:

```text
docs: plan Delayed Self finale sequence and difficulty bridge
```

Immediately before push:

```powershell
git fetch origin
git rev-parse HEAD
git rev-parse origin/main
git status --short --untracked-files=all
```

Require no remote drift. Push normally to `origin/main`. After push require a clean worktree and `HEAD == origin/main`.

Forbidden:

- broad staging;
- merge commit;
- rebase;
- amend;
- force-push;
- reset;
- stash;
- broad restore/checkout;
- any product or formal-content edit.

## 13. Stop conditions

Stop with the most specific verdict if:

```text
BLOCKED_NO_SCHEMA_V1_SEQUENCE_SOLUTION
BLOCKED_SEQUENCE_REQUIRES_NEW_MECHANIC
BLOCKED_SEQUENCE_REQUIRES_RUNTIME_OR_SCHEMA_CHANGE
BLOCKED_SEQUENCE_DECISION_NOT_UNIQUE
BLOCKED_UNEXPECTED_WORKTREE_CHANGE
BLOCKED_REMOTE_DRIFT
```

Do not weaken the task by selecting a vague documentation-only recommendation with no exact next formal target.

## 14. Terminal verdict and next gate

After one documentation-only commit, normal push, and clean final audit, return:

```text
LEVEL_8_FINALE_SEQUENCE_PLAN_READY_FOR_GPT_REVIEW
```

Include:

- commit SHA;
- exact sequence decision label;
- exact next formal target ID/title/role;
- proposed future catalog order;
- future finale disposition;
- Timeline/Help/dependency-path policy;
- created plan/report paths;
- confirmation that no Godot/solver/product file changed;
- final Git state.

No terminal verdict is final GPT acceptance.

After GPT accepts the plan, the next gate is one bounded implementation task for the selected **next formal target**, which may be a bridge rather than the finale. Level 8/finale implementation is not authorized merely because this task is numbered 0016.
