# Task 0015D — Level 7 false-unsolvable diagnosis and repair planning

- Status: `READY`
- Gate: `DESIGN DIAGNOSTIC / BLOCKING P2 REPAIR PLANNING`
- Repository: `zcx369658780/delayed-self-godot`
- Expected branch: `main`
- Expected local root: `D:\Delayed_Self`
- Issued by: GPT Project Sources advisor
- Date: 2026-07-17
- Parent review: `tasks/0015V_owner_targeted_level_7_review.md`
- Parent review commit: `37a83991749fab8f8e9ab3bf2daf6b196093bc4b`
- GPT adjudication: `docs/reports/0015V_GPT_OWNER_LEVEL_7_REVIEW_ADJUDICATION.md`
- Adjudication commit: `6c4ccc94cb5f844604f7ec25a022bdfed1d72dbb`
- Accepted Level 7 implementation: `27a678da47d1ba34ed012f8840b8c80c775e8be1`
- Formal Level 7 SHA-256: `772410d3b8bb807e35472ee2a7d07b703de66e1e0e92ffb4d1ff8433a345d5fd`

## 1. Objective

Diagnose why the authenticated owner persistently judged the machine-valid Level 7 `two_echo_convergence` to be impossible, then freeze one bounded repair plan for a later implementation task.

The accepted problem classification is:

```text
BLOCKING_P2_FALSE_UNSOLVABLE_MENTAL_MODEL_AND_RECOVERY_FAILURE
```

This task must identify the smallest credible intervention that makes the following causal principle discoverable and recoverable:

> E2 and E4 replay the same history at different offsets, but walls, blocked movement, route choices, and prior positions can change their relative spacing; their spacing is not a fixed invariant.

The diagnostic must not assume the owner’s proposed delay-5, changed Plate spacing, persistent Door, direct walkthrough Help, animation, supplementary color, longer route, or push-box mechanic is correct. Treat each as a proposal requiring comparison against the accepted machine and product constraints.

This is a planning and evidence task. It does not authorize a product repair, formal Level 7 edit, runtime change, Timeline/Help redesign, new mechanic, Level 8, asset, animation, audio, narrative, persistence, export, release, or submission work.

## 2. Current accepted facts

Treat as frozen:

- `simulation_v1` and `level_v1`;
- the accepted Godot 4.7 stable Compatibility-renderer environment;
- Level 7 formal structure: one YOU, shared-spawn E2 delay 2, shared-spawn E4 delay 4, Plate A, Plate B, one A+B combinational Door, player-only EXIT;
- exact machine result: `L*=19`, `N*=6 EXACT`, visited `61,975`, frontier `21,449`;
- all six shortest solutions use E2 on A, E4 on B, then an open-snapshot crossing;
- single-ECHO, no-ECHO, relocation, and equal-delay controls are complete unsolved;
- the seven-level catalog, prior six formal hashes/metrics, and Task 0015 aggregate are accepted;
- Task 0015V owner facts: Level 7 `GAVE_UP`, Help ineffective, Timeline unused, actor/dependency vocabulary understood, false invariant-spacing model persisted;
- owner-only review constraint: do not seek or require third parties;
- WAIT remains `DEFERRED_VALIDATION_RESEARCH`;
- latched/one-shot Gate remains `DRAFT_NOT_ACCEPTED`.

Task 0015 remains accepted at `INTERNAL_PLAYABLE`; this task does not reopen machine correctness unless new contradictory evidence is found.

## 3. Mandatory startup gate

Before any execution or write:

```powershell
Get-Location
git branch --show-current
git rev-parse HEAD
git rev-parse origin/main
git remote -v
git status --short --untracked-files=all
git log -36 --oneline --decorate
godot --version
Get-Command godot | Format-List Source,Version,CommandType
```

Required:

- root exactly `D:\Delayed_Self`;
- branch `main`;
- expected origin;
- fully clean tracked and untracked worktree;
- local and remote contain this task, the GPT adjudication, Task 0015V evidence, and Task 0015 acceptance;
- accepted Godot executable/version, or an exact equivalent already recorded in the current environment source.

If clean local `main` is behind, use only:

```powershell
git fetch origin
git merge --ff-only origin/main
```

Stop on divergence, conflict, unexpected files, wrong root/remote, unsafe evidence path, inability to fast-forward, or materially different toolchain.

## 4. Required reads

Read in order:

1. `AGENTS.md`;
2. current startup and active-task documents;
3. this task;
4. `docs/reports/0015V_GPT_OWNER_LEVEL_7_REVIEW_ADJUDICATION.md`;
5. `docs/reviews/0015V_OWNER_TARGETED_LEVEL_7_REVIEW.md`;
6. `docs/reports/0015V_OWNER_TARGETED_LEVEL_7_REVIEW_REPORT.md`;
7. `docs/reports/0015_GPT_FINAL_ACCEPTANCE.md`;
8. `docs/level_design/validation/TWO_ECHO_CONVERGENCE_VALIDATION.md`;
9. `docs/reports/0015_LEVEL_7_TWO_ECHO_CONVERGENCE_IMPLEMENTATION_REPORT.md`;
10. `docs/level_design/LEVEL_7_TWO_ECHO_CONVERGENCE_PLAN_CURRENT.md`;
11. `data/levels/two_echo_convergence.json`;
12. current reusable Gameplay presentation and focused Task 0015 tests/capture harness;
13. current Level 6 validation and Task 0013B owner review for comparison;
14. current presentation/HUD direction, roadmap, handoff, development plan, and project memory;
15. puzzle-validation, evidence/privacy, Git, and Godot-safety rules.

Do not show solver witnesses, task text, source, validation traces, or screenshots containing external notes to the owner during this planning task.

Before execution, print a concise diagnostic plan covering:

- accepted machine facts and owner contradiction;
- hypotheses to test;
- exact evidence sources;
- any native replay/capture commands;
- temporary external-script strategy;
- candidate comparison method;
- no-product-write boundary;
- output files and terminal verdicts.

## 5. Repository and implementation freeze

Do not modify:

- `data/levels/two_echo_convergence.json`;
- any other formal level;
- `data/catalog/level_catalog_v1.json`;
- `scripts/`;
- `scenes/`;
- `tests/`;
- `schemas/`;
- `project.godot`;
- fixtures or accepted contracts;
- Timeline model/index/layout;
- Help architecture/copy;
- assets, fonts, audio, shaders, imports, plugins, dependencies;
- save/player data;
- build, export, release, accounts, repository settings, or submission surfaces;
- prior task, review, report, validation, or acceptance artifacts.

Do not create or commit a repaired Level 7 candidate.

Temporary diagnostic variants and scripts are allowed only outside the repository under the authorized external evidence root. They must never be staged or copied into product paths.

## 6. External evidence boundary

Authorized root:

```text
D:\Delayed_Self_Evidence\0015D_level_7_false_unsolvable_diagnostic\
```

Allowed:

- bounded stdout/stderr and native exit summaries;
- exact executable and command records;
- copies or references to already approved game-window-only Task 0015/0015V screenshots;
- new game-window-only captures created specifically for diagnostic comparison;
- temporary external GDScript or text scripts used to inspect in-memory variants;
- canonical state/replay tables;
- candidate comparison tables;
- image crops containing only the game window;
- evidence index with timestamps, sizes, and SHA-256.

Forbidden:

- automatic full-desktop capture;
- browser, email, notifications, accounts, credentials, face, voice, or unrelated windows;
- raw keyboard logging;
- deletion or overwrite of prior evidence;
- staging external evidence or temporary scripts;
- modifying user save data merely to prepare a capture.

Use existing accepted direct-level launch or isolated capture harnesses. Do not clear user data.

## 7. Baseline verification

Verify live repository facts and Task 0015 evidence before diagnosis.

A fresh aggregate rerun is optional when the current commit history after Task 0015 contains documentation/task files only and the Task 0015V fresh aggregate evidence index is complete and readable. If any fact cannot be safely verified, rerun once using the accepted command and require:

```text
TASK_0003_TESTS_PASS assertions=367 vectors=9
TASK_0006_APP_SHELL_TESTS_PASS
TASK_0007_TUTORIAL_LEVELS_TESTS_PASS
TASK_0008_PROGRESSIVE_HUD_TESTS_PASS
TASK_0009AR_LEVELS_4_5_TESTS_PASS
TASK_0011_PRESENTATION_RECOVERY_TESTS_PASS
TASK_0011R_WINDOW_FILL_TESTS_PASS
TASK_0012_LEVEL_6_STAGGERED_DOORS_TESTS_PASS
TASK_0015_LEVEL_7_TWO_ECHO_CONVERGENCE_TESTS_PASS
```

Also require unchanged Level 7 metrics/hash and prior seven formal hashes.

If baseline differs, stop without diagnosis:

```text
BLOCKED_LEVEL_7_DIAGNOSTIC_BASELINE_REGRESSION
```

## 8. Required causal diagnosis

Build a turn-by-turn diagnostic of the selected shortest witness and at least two plausible failed owner-style prefixes.

### 8.1 Relative-spacing table

For every relevant turn, record:

- submitted action;
- YOU, E2, and E4 positions before and after settlement;
- E2–E4 Manhattan and signed coordinate differences;
- whether each actor was blocked by terrain or Door state;
- history slots replayed by E2 and E4;
- Plate occupancy and committed Door state;
- whether the turn creates, preserves, or destroys the useful convergence phase.

Identify the earliest turn at which the physical E2–E4 spacing changes from the owner’s assumed invariant. Identify the exact terrain/blocked-history cause.

### 8.2 Counterfactual mental-model check

Construct the simplest explicit model corresponding to the owner’s belief:

```text
E2/E4 relative spacing is fixed by delay difference alone.
```

Show exactly where this model predicts the wrong state. Do not ridicule or dismiss the belief; explain why the current presentation and route may reinforce it.

### 8.3 Failed-prefix analysis

Use owner screenshots/notes and bounded plausible prefixes to identify at least two failure patterns that can reinforce the false-unsolvable belief, such as:

- both ECHOs following the same unobstructed lane and preserving apparent spacing;
- a restart before the first visible divergence;
- reaching a state where A/B are visible but no progressive cue indicates a recoverable history phase;
- observing overlap/crowding without understanding blocked-action divergence.

For each, record whether the state is still solvable, minimum known recovery cost when practical, and what information the current game does or does not expose.

## 9. Repair candidates to compare

Compare at least four bounded repair directions. More may be added, but the final plan must select exactly one primary repair bundle and may identify one fallback.

### Candidate A — geometry-only re-authoring

Preserve E2/E4, A+B, one Door, EXIT, `simulation_v1`, and `level_v1`, but adjust terrain/Plate placement so route-induced divergence becomes visible earlier and more naturally.

Evaluate:

- whether a visible early wall/block creates an obvious change in spacing;
- whether the useful convergence is less indirect;
- whether the puzzle still requires two offsets rather than a trivial fixed spacing;
- prospective effects on `L*`, `N*`, visited/frontier, decision count, and recovery;
- whether Level 7 remains materially harder than Level 6 without becoming a corridor.

Any proposed geometry remains an external or in-memory candidate only.

### Candidate B — board-state divergence feedback

Preserve formal geometry and rules. Add a minimal reusable visual explanation that highlights when E2 and E4 replay the same action but settle differently because one is blocked or routed differently.

Possible bounded examples:

- a one-turn `SAME INPUT · DIFFERENT RESULT` badge;
- distinct blocked/moved trail endpoints for E2/E4;
- a short relative-spacing change pulse;
- a static or transient `E2↔E4 spacing changed` cue derived only from state transitions.

Evaluate whether this teaches a causal principle without revealing route, exact timing, or solution.

### Candidate C — recovery/progress feedback

Preserve formal geometry. Make plausible failed states communicate progress or recoverability rather than permanent impossibility.

Possible bounded examples:

- show that the current phase can still reach A+B within a bounded number of replay slots without giving moves;
- highlight first-time route divergence as a discovered concept;
- distinguish `not aligned yet` from `structurally impossible`;
- contextual feedback after repeated restarts or a repeated false-invariant state.

Reject any proposal that requires runtime solver hints, hidden solution lookup, or route-specific hardcoding.

### Candidate D — contextual Help principle

Preserve the board and avoid a movement walkthrough. Add one concise Level 7-specific causal principle:

> The two ECHOs replay the same history at different times. Walls and blocked moves can change their spacing.

Compare text-only, small diagram, and one-step non-route animation/storyboard options. Do not provide the exact sequence, actor schedule, Plate timing, or solver witness.

Explain why the Task 0015V high-level explanation failed and what a better contextual explanation would need to show.

### Candidate E — owner-proposed structural simplifications

Analyze, but do not privilege:

- change E4 delay to 5;
- change Plate spacing;
- make the Door persistent/one-shot;
- make Help an exact operation walkthrough;
- extend the level length;
- add push boxes.

For each, state whether it preserves the intended Level 7 lesson, changes schema/runtime, consumes Level 8 or future-mechanic scope, weakens exact necessity, or merely hides the discoverability problem.

Push boxes and persistent Doors are scope expansions and cannot be selected as the primary immediate repair under this task.

## 10. Candidate evaluation matrix

Score each repair direction from 1–5 using a weighted matrix:

| Criterion | Weight | Required question |
|---|---:|---|
| Corrects false invariant model | 25% | Does it directly make changing ECHO spacing understandable? |
| Preserves temporal reasoning | 20% | Does it keep two-offset planning rather than trivialize it? |
| Minimal implementation risk | 15% | Can it be implemented without schema/simulation/solver expansion? |
| Recovery clarity | 15% | Do failed attempts expose progress and a path to recovery? |
| Non-spoiler quality | 10% | Does it teach principle without revealing route or exact moves? |
| Reusability | 10% | Can the intervention support Level 8 or other multi-ECHO content? |
| Production compatibility | 5% | Does it fit 960×540 primitive presentation and current schedule? |

The scores are design judgments, not human evidence. Include rationale and uncertainty.

The selected primary repair bundle must:

- address the false-unsolvable mental model directly;
- avoid new mechanics and avoid Level 8 implementation;
- keep Timeline out of the teaching goal unless the evidence decisively shows a small Timeline change is the minimal solution;
- not use an exact walkthrough as the default Help;
- preserve at least two non-color identity cues;
- have explicit machine and owner-retest acceptance criteria;
- include rollback and stop conditions.

## 11. Optional external variant analysis

You may use temporary external scripts to test in-memory geometry or metadata variants.

Requirements:

- scripts remain under the external evidence root;
- product files are read-only;
- each variant is labeled `DIAGNOSTIC_ONLY_NOT_FORMAL`;
- record exact changed facts, solver limits, result status, metrics, and whether the intended two-ECHO role remains necessary;
- never call a limit result unsolvable;
- do not widen limits beyond Task 0015 without written justification in the diagnostic report;
- do not create more than twelve geometry variants;
- stop candidate generation when one or two clearly superior repair directions are identified.

This task does not require finding a final qualifying repaired geometry. It requires enough evidence to choose the next implementation scope safely.

## 12. Required output plan

Create:

```text
docs/level_design/LEVEL_7_FALSE_UNSOLVABLE_REPAIR_PLAN_CURRENT.md
docs/reports/0015D_LEVEL_7_FALSE_UNSOLVABLE_DIAGNOSTIC_REPORT.md
```

Update only the necessary subset of:

```text
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/level_design/INITIAL_LEVEL_ROADMAP_AND_VALIDATION_MATRIX_CURRENT.md
docs/level_design/FIVE_LEVEL_DIFFICULTY_RECOVERY_AND_LEVELS_6_8_PLAN.md
docs/ux/PRESENTATION_VIEWPORT_AND_HUD_DIRECTION_CURRENT.md
```

The repair plan must contain:

- accepted baseline and owner contradiction;
- causal turn/spacing analysis;
- failed-prefix and recovery analysis;
- at least four compared repair directions;
- owner-proposal disposition table;
- weighted matrix;
- exactly one selected primary repair bundle;
- optional fallback bundle;
- exact authorized implementation surfaces for the later task;
- formal-level preservation or revalidation requirements;
- presentation acceptance criteria at 960×540 and grayscale;
- machine regression and control requirements;
- owner-only retest protocol and promotion criteria;
- non-claims, rollback, stop conditions, and next gate.

The diagnostic report must contain:

- live Git facts and commands;
- baseline verification/reuse decision;
- evidence sources and external root;
- scripts/variants run and their status;
- causal diagnosis summary;
- candidate scores and selection;
- exact files created/updated;
- confirmation no product implementation changed;
- terminal verdict and next recommendation.

## 13. Later implementation acceptance requirements to freeze

The selected plan must define, at minimum:

1. baseline and all seven formal hashes/metrics before repair;
2. exact allowed source/formal/presentation files;
3. whether formal Level 7 JSON changes;
4. if formal data changes, complete strict load, solve, exact `N*`, replay, restart, all controls, articulation, overlap, decisions, recovery, progression, capture, and aggregate rerun;
5. if only presentation changes, unchanged Level 7 hash and exact machine metrics plus focused transition/capture tests;
6. no route hardcoding or solver-driven runtime hint;
7. no exact movement walkthrough in default Help;
8. the owner can explain that spacing changes because actors settle differently under terrain/history;
9. owner completes unassisted or, if still incomplete, no longer judges the level mathematically impossible and can identify a credible recovery strategy;
10. P0=0/P1=0 and the blocking P2 is closed or materially reduced before Level 8.

The later retest classification remains:

```text
AUTHENTICATED_OWNER_NOT_FRESH_NOT_INDEPENDENT_LEVEL_7_RETEST
```

No third party may be sought or required.

## 14. Validation and Git discipline

Before staging:

```powershell
git status --short --untracked-files=all
git diff --check
git diff --stat
```

Audit:

- only authorized Markdown repository files changed;
- no product, formal level, catalog, source, scene, test, schema, fixture, project setting, asset, import, Timeline model, Help code, user data, or external evidence is staged;
- all statements distinguish accepted facts, diagnostic observations, proposals, and unresolved uncertainty;
- no temporary external script or candidate enters the repository;
- Level 8 remains unauthorized;
- no fresh/independent claim is made;
- internal links resolve.

Stage explicit files only. Never use broad staging.

Then:

```powershell
git diff --cached --check
git diff --cached --stat
git diff --cached --name-only
```

Commit exactly once:

```text
docs: diagnose Delayed Self Level 7 false-unsolvable gap
```

Before push:

```powershell
git fetch origin
git rev-parse HEAD
git rev-parse origin/main
git status --short --untracked-files=all
```

Stop on remote drift. Do not merge, rebase, amend, force-push, reset, broadly restore, clean, or create a second commit.

After push, require clean worktree and `HEAD == origin/main`.

## 15. Terminal verdicts

After successful diagnosis, plan, commit, and push:

```text
LEVEL_7_FALSE_UNSOLVABLE_REPAIR_PLAN_READY_FOR_GPT_REVIEW
```

If baseline differs:

```text
BLOCKED_LEVEL_7_DIAGNOSTIC_BASELINE_REGRESSION
```

If the evidence cannot distinguish a safe repair direction:

```text
BLOCKED_LEVEL_7_REPAIR_DIRECTION_UNRESOLVED
```

If every credible repair requires schema/runtime/new-mechanic expansion:

```text
BLOCKED_LEVEL_7_REPAIR_REQUIRES_SCOPE_EXPANSION
```

No terminal verdict is final GPT acceptance or implementation authorization.

## 16. Next gate

After GPT review:

- accepted plan → one bounded Level 7 repair implementation task;
- unresolved diagnosis → one narrower evidence task;
- scope expansion required → GPT/user product decision before any implementation;
- Level 8 remains blocked until a repaired Level 7 passes machine regression and owner-only retest.
