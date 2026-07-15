# Task 0010 — Presentation, difficulty, asset/audio, narrative, and Gate-direction planning

- Status: `READY`
- Gate: `PLANNING / PRESENTATION AND PRODUCTION DIRECTION`
- Repository: `zcx369658780/delayed-self-godot`
- Expected branch: `main`
- Expected local root: `D:\Delayed_Self`
- Issued by: GPT Project Sources advisor
- Date: 2026-07-15
- Prior accepted gate: `TASK_0009AV_OWNER_FIVE_LEVEL_SEQUENCE_REVIEW_ACCEPTED_WITH_FINDINGS`
- Accepted five-level implementation: `9516c44688d5416c154167e8be002a60de7ce327`
- Accepted owner-sequence evidence: `a4dca805835a48d6d06f241d52e4f275ac61251b`
- Prior acceptance artifact: `docs/reports/0009AV_GPT_FINAL_ACCEPTANCE.md`

## 1. Objective

Create an implementation-ready recovery plan for the current five-level build before any additional level production.

The plan must resolve or explicitly stage the following owner findings:

1. the five-level difficulty curve is too flat and easy;
2. Level 4's next-turn Door timing is mechanically valid but visually difficult to observe;
3. the compact timeline and `H` Help provide little practical value in the current simple content;
4. the effective board/gameplay area feels too small relative to the window and HUD;
5. primitive circles and flat shapes should eventually be replaced by a coherent licensed visual style;
6. music, sound effects, and lightweight narrative should enter through a controlled production pipeline;
7. a separate latched/one-shot Gate should be evaluated without changing the accepted combinational Plate Door.

This task is planning-only. It must not modify runtime code, scenes, levels, catalog, schemas, tests, project settings, viewport settings, imports, assets, audio files, or release surfaces.

## 2. Success criteria

Task 0010 succeeds only when it produces a coherent, evidence-grounded plan that:

1. measures the current board, HUD, viewport, and window allocation from repository facts and bounded runtime observation;
2. compares at least three presentation/layout options and selects one recommended implementation baseline;
3. defines a measurable difficulty framework for Levels 6–8 and any future rebalance of Levels 3–5;
4. defines a non-semantic visual/audio feedback sequence for combinational Door changes, especially Level 4;
5. decides whether the existing timeline and Help should remain, collapse further, move, or become contextual in harder levels;
6. establishes an asset, font, music, and sound-effect provenance/license policy before any download or import;
7. provides a small shortlist of candidate free/licensed sources when network research is available, with exact license and attribution requirements;
8. drafts a lightweight narrative direction that supports the delayed-Echo mechanic without requiring new gameplay semantics;
9. evaluates a latched/one-shot Gate through an architecture decision record, including state/schema/solver implications;
10. produces a sequenced implementation roadmap with explicit next gates and stop conditions;
11. preserves all accepted gameplay, level, catalog, solver, and test authorities;
12. makes no claim that any planned improvement is already implemented or human-validated.

## 3. Mandatory startup gate

Before any write:

```powershell
Get-Location
git branch --show-current
git rev-parse HEAD
git rev-parse origin/main
git remote -v
git status --short --untracked-files=all
git log -24 --oneline --decorate
godot --version
```

Required conditions:

- absolute root is `D:\Delayed_Self`;
- branch is `main`;
- origin is the expected repository;
- local `HEAD` and `origin/main` contain this task and `docs/reports/0009AV_GPT_FINAL_ACCEPTANCE.md`;
- tracked worktree is clean;
- Godot resolves to the accepted `4.7.stable` toolchain.

If local is behind and clean, use only:

```powershell
git fetch origin
git merge --ff-only origin/main
```

Stop on divergence, conflict, remote mismatch, unexpected tracked changes, unsafe root, missing governance artifacts, inability to fast-forward, or materially different toolchain.

## 4. Required reads

Read in this order:

1. `AGENTS.md`;
2. `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`;
3. `docs/CODEX_ACTIVE_TASK_CURRENT.md`;
4. this task;
5. `docs/reports/0009AV_GPT_FINAL_ACCEPTANCE.md`;
6. `docs/reviews/0009AV_OWNER_FIVE_LEVEL_SEQUENCE_REVIEW.md`;
7. `docs/reports/0009AV_OWNER_FIVE_LEVEL_SEQUENCE_REVIEW_REPORT.md`;
8. `docs/reports/0009AR_GPT_FINAL_ACCEPTANCE.md`;
9. `docs/reports/0009AR_DOOR_TIMING_AND_AND_DOOR_CONTENT_REPORT.md`;
10. both Level 4–5 validation records;
11. `docs/reports/0008_GPT_FINAL_ACCEPTANCE.md`;
12. `docs/game_design/TUTORIAL_AND_HUD_PROGRESSION_PLAN_CURRENT.md`;
13. `docs/level_design/INITIAL_LEVEL_ROADMAP_AND_VALIDATION_MATRIX_CURRENT.md`;
14. `docs/architecture/SYSTEM_SKELETON_PLAN_CURRENT.md`;
15. current GDD and gameplay simulation contract;
16. current five-entry catalog contract and tracked catalog;
17. current Gameplay scene/script and timeline model for measurement only;
18. `project.godot` and accepted environment record for viewport/window facts only;
19. current startup/index/plan/handoff/project-memory documents;
20. Godot-safety, puzzle-validation, independent-review, and evidence rules.

Before writing, print a concise summary of:

- accepted five-level facts and frozen semantics;
- the four accepted P2 findings and two P3 proposals;
- exact planning-only boundary;
- proposed measurement method;
- presentation options to compare;
- difficulty framework dimensions;
- Door-feedback planning scope;
- asset/audio licensing research scope;
- narrative planning scope;
- latched-Gate ADR scope;
- authorized documents, commit policy, and stop conditions.

## 5. Frozen authorities and non-negotiable boundaries

Treat as immutable for this task:

- Godot 4.7 stable, GDScript, Compatibility renderer;
- current Windows target;
- `simulation_v1`, `level_v1`, and catalog-v1 semantics;
- action order, blocked-move consumption, Echo history/delay behavior, simultaneous movement, Plate evaluation, combinational Door semantics, player-only EXIT, restart, replay, canonical keys, and solver statuses;
- all five formal level files and accepted metrics;
- tracked five-entry catalog and memory-only progression;
- current tests and five accepted marker outputs;
- WAIT status `DEFERRED_VALIDATION_RESEARCH`;
- current combinational Door remains a live accepted mechanic;
- no new mechanic is accepted by planning alone.

Do not modify or create runtime implementation under:

- `scripts/`;
- `scenes/`;
- `data/levels/`;
- `data/catalog/`;
- `schemas/`;
- `tests/`;
- `project.godot`;
- `assets/` or any imported-resource path;
- `audio/`, `music/`, `sfx/`, `fonts/`, or equivalent binary/source asset path;
- export/build/release/account/repository-setting paths.

Do not download or import assets, fonts, music, or sound effects. Do not add Godot plugins or dependencies.

Network research is permitted only for planning and provenance. If network access is unavailable, mark source shortlisting `NETWORK_UNAVAILABLE` and still complete the policy, evaluation rubric, and implementation roadmap without inventing candidate URLs or licenses.

## 6. Presentation and viewport analysis

Create:

```text
docs/ux/PRESENTATION_VIEWPORT_AND_HUD_DIRECTION_CURRENT.md
```

### 6.1 Current-state measurement

Record repository-grounded facts and bounded observations:

- configured logical viewport and window defaults;
- current board origin, cell size, maximum occupied board dimensions among the five levels, and resulting board pixel footprint;
- approximate left/right/top/bottom HUD allocations;
- percentage of the logical viewport used by active board cells versus HUD/background;
- current minimum text sizes and wrapping regions;
- whether larger OS window size currently enlarges content, adds empty space, or scales the logical viewport;
- which labels remain permanently visible in each HUD mode;
- the exact presentation sequence for Level 4's Door state.

Do not claim pixel-perfect measurement if only source-derived bounds are available. Distinguish `SOURCE_MEASURED`, `RUNTIME_OBSERVED`, and `ESTIMATED` values.

### 6.2 Compare at least three options

Compare at minimum:

#### Option A — retain 960×540 logical viewport

- enlarge/recenter board;
- reduce permanent right-side text;
- move controls/help to contextual overlay or bottom strip;
- preserve low-resolution asset requirements.

#### Option B — adopt 1280×720 logical viewport

- larger board and readable HUD regions;
- Windows scaling behavior;
- impact on captures, tests, scene anchors, and future assets;
- migration cost and minimum-window behavior.

#### Option C — responsive board-first layout

- board occupies a target percentage of available space;
- HUD collapses or relocates based on width;
- one logical baseline plus bounded stretch rules;
- increased implementation/test complexity.

A fourth hybrid option may be added when justified.

For every option include:

- board-area target;
- HUD placement;
- expected readability;
- impact on current five levels;
- Godot implementation approach;
- regression/evidence burden;
- accessibility implications;
- asset-resolution requirements;
- risks and rollback plan.

### 6.3 Required decision

Choose one recommended implementation baseline and one fallback. Specify:

- target logical viewport/window behavior;
- target board share of usable area;
- target HUD zones;
- compact/help behavior;
- minimum supported window size;
- scale/stretch policy;
- exact implementation files likely affected in a later task;
- automated and visual acceptance criteria.

Planning must not change the viewport or scene.

## 7. Difficulty recovery plan

Create:

```text
docs/level_design/FIVE_LEVEL_DIFFICULTY_RECOVERY_AND_LEVELS_6_8_PLAN.md
```

Separate machine complexity from human difficulty.

### 7.1 Difficulty dimensions

Define a matrix including at least:

- shortest length `L*`;
- optimal solution count `N*` and whether exact/capped;
- visited-state/frontier burden under fixed solver limits;
- number of delayed actors and distinct delays;
- number of Plates/Doors and dependency graph depth;
- required synchronization windows;
- number of meaningful branch points;
- punishment/recovery cost for a wrong action;
- degree to which trial-and-error can succeed without understanding;
- information that must be tracked mentally;
- visual-state observability;
- human completion time/restarts/hints from later reviews.

Explain why no single metric is sufficient.

### 7.2 Current five-level diagnosis

For each existing level, record:

- accepted machine metrics;
- intended lesson;
- owner-observed difficulty and clarity;
- whether the level should remain tutorial, be strengthened later, or stay as a short onboarding step;
- any future rebalance concept, clearly marked `PROPOSAL_ONLY`.

Do not modify accepted formal files.

### 7.3 Levels 6–8 planning

Produce bounded schema-v1 concepts for Levels 6–8 unless the Gate ADR recommends an explicitly later schema-v2 branch.

Each concept must include:

- teaching and challenge role;
- proposed actor delays;
- proposed Plate/Door structure;
- intended mental model;
- target bands for `L*`, `N*`, state exploration, and human completion;
- mandatory mechanic-necessity and bypass proofs;
- how the level makes timeline/help genuinely useful or proves they should be reduced;
- how it differs geometrically and cognitively from Levels 1–5;
- stop conditions if the concept remains too easy or becomes pathological.

At minimum plan:

1. a staggered multi-door schema-v1 level;
2. a multi-delay level that gives the timeline a real planning role;
3. a finale candidate combining accepted mechanics without relying on an unaccepted Gate.

Do not create formal JSON files.

### 7.4 Content-production gate

Define quantitative and human gates for authoring and accepting future levels. Include a rule that a level cannot be accepted solely because its solver witness exists.

## 8. Door-state feedback storyboard

Create:

```text
docs/ux/DOOR_PLATE_AND_ECHO_FEEDBACK_STORYBOARD.md
```

Plan feedback without changing mechanics.

For the current combinational Door, cover:

- Plate press/release feedback;
- dependency connection or pulse from Plate to Door;
- Door opening anticipation versus committed open state;
- clear indication that the newly open state applies to the next submitted turn;
- Door close feedback after actors leave Plates;
- player blocked-at-door feedback;
- Echo replay cue distinct from player movement;
- motion, sound, icon, text, and color channels;
- accessibility when color or audio is unavailable;
- timing in milliseconds/frames as an implementation recommendation only;
- how to avoid slowing rapid puzzle input excessively.

Provide a step-by-step storyboard for the exact Level 4 critical sequence:

1. closed start snapshot;
2. submitted action;
3. Echo moves onto Plate;
4. Plate activates;
5. Door visibly commits open for the next turn;
6. next-turn player entry;
7. Door may close around/behind the occupant according to accepted rules.

Recommend a minimal feedback implementation and an enhanced version. No animation, sound, or code is authorized in this task.

## 9. Timeline and Help product decision

Within the presentation document or a dedicated section, evaluate:

- keeping the three-slot timeline always visible;
- showing it only when Echoes exist and complexity exceeds a threshold determined by HUD mode/catalog data;
- moving detailed labels into Help while leaving compact arrows/pointers on the main HUD;
- contextually emphasizing the slot that will replay next;
- reducing `H` Help to a modal/overlay reference card;
- preserving keyboard discoverability;
- implications for future multi-delay levels;
- testability and accessibility.

Choose a recommended direction. Do not delete or modify current timeline/Help behavior.

## 10. Asset, font, and audio provenance plan

Create:

```text
docs/art/ASSET_AUDIO_LICENSE_AND_PIPELINE_PLAN_CURRENT.md
```

The plan must define:

### 10.1 Allowed license policy

Recommend an explicit acceptance policy. At minimum distinguish:

- preferred: CC0/public-domain-equivalent;
- conditionally acceptable with attribution ledger: CC-BY 4.0, MIT, BSD, SIL OFL for fonts;
- prohibited without separate legal decision: unclear/custom-no-redistribution, non-commercial, share-alike when incompatible with distribution goals, ripped/derivative commercial-game assets, AI outputs with unclear rights, or assets lacking source/license evidence.

State that a license name alone is insufficient; the project must preserve source URL, author, version/download date, license text or stable reference, modifications, attribution string, and files used.

### 10.2 Asset ledger and import gate

Define a future tracked ledger format, proposed path, and fields. Include:

- asset ID;
- source and author;
- original and local filenames;
- license and attribution;
- modification notes;
- intended use;
- import settings;
- hash;
- approval status.

No ledger containing imaginary downloaded assets should be created in this task; provide the schema/template only.

### 10.3 Visual direction

Define a coherent low-cost style for:

- YOU;
- ECHO;
- floor/walls;
- Plates;
- combinational Doors;
- EXIT;
- UI panels/icons;
- Echo trails and state feedback.

Compare at least two feasible directions, such as minimalist neon/temporal sci-fi versus readable pixel-art laboratory. Select one recommended direction based on clarity, available free assets, animation cost, and narrative fit.

### 10.4 Candidate source shortlist

When network access is available, shortlist at least three credible sources or packs for visual assets and at least three for audio/music. For each record:

- exact title/source;
- author/publisher;
- stable URL;
- exact license;
- attribution requirement;
- relevant files/content;
- style fit;
- risks or missing information.

Prefer original publisher pages, official asset libraries, or authoritative repositories. Do not download or import anything.

When network access is unavailable, mark this subsection `NETWORK_UNAVAILABLE` rather than inventing sources.

### 10.5 Audio plan

Define a minimal audio set:

- player move;
- blocked move;
- Echo replay/move;
- Plate press/release;
- Door open/close;
- level completion;
- menu navigation;
- one or more low-distraction music loops.

Explain priority, mixing, looping, mute/volume controls, and accessibility considerations. No audio implementation is authorized.

## 11. Narrative direction

Create:

```text
docs/narrative/DELAYED_SELF_NARRATIVE_DIRECTION_CURRENT.md
```

Develop a lightweight narrative compatible with an offline puzzle game and the existing mechanic.

Include:

- one-sentence premise;
- player identity and meaning of ECHO;
- central emotional/theme statement;
- beginning, middle, and ending beats across a proposed eight-level arc;
- one short pre-level or post-level text beat per current and planned level;
- environmental storytelling opportunities;
- how narrative is delivered without interrupting puzzle flow;
- copy-length and localization constraints;
- what remains intentionally ambiguous;
- content-safety and scope constraints;
- a recommendation for whether story enters before or after the first visual/audio pass.

Do not add dialogue, localization files, cutscenes, or runtime story state.

## 12. Latched/one-shot Gate ADR draft

Create:

```text
docs/architecture/LATCHED_ONE_SHOT_GATE_ADR_DRAFT.md
```

Status must remain `DRAFT_NOT_ACCEPTED`.

Compare at minimum:

1. no new Gate; retain combinational Doors only;
2. latched Gate: once activated, remains open;
3. one-shot disappearing Gate: activation removes future collision/visual obstruction;
4. environmental switch controlling a persistent Gate, if materially distinct.

For each option analyze:

- player-facing rule and visual language;
- schema representation;
- initial and runtime state;
- canonical-key impact;
- transition ordering;
- restart/replay behavior;
- solver state-space impact;
- backward compatibility;
- required validation vectors;
- migration of existing levels, which should default to none;
- content value versus complexity;
- risk of confusing it with the existing Plate Door.

Make a recommendation: adopt later, reject, or defer pending prototype. No recommendation may silently modify `simulation_v1` or `level_v1`.

If recommending implementation, define a separate future task sequence: contract/ADR acceptance → schema/simulation vectors → isolated prototype level → human review → candidate-content use.

## 13. Integrated recovery roadmap

Create:

```text
docs/version_plans/M3_PRESENTATION_DIFFICULTY_AND_PRODUCTION_RECOVERY_PLAN.md
```

Sequence the proposed work into small gates. At minimum address:

1. viewport/board/HUD implementation and visual evidence;
2. Door/Plate/Echo feedback implementation;
3. asset provenance setup and first licensed visual pass;
4. audio foundation and settings boundary;
5. narrative copy prototype;
6. difficulty recovery and Levels 6–8 production;
7. optional latched-Gate contract/prototype path;
8. owner review;
9. qualifying fresh/independent review before candidate acceptance;
10. save/complete-flow/export gates that remain separate.

For each gate include objective, allowed paths, dependencies, evidence, human review, rollback, and stop conditions.

Choose and justify the immediate next implementation task after this planning gate. Do not self-authorize it.

## 14. Planning report

Create:

```text
docs/reports/0010_PRESENTATION_DIFFICULTY_AND_PRODUCTION_DIRECTION_PLANNING_REPORT.md
```

Include:

- task and Git facts;
- exact documents created/updated;
- current-state measurements and confidence labels;
- selected viewport/layout direction and fallback;
- difficulty framework and Levels 6–8 planning summary;
- Door feedback recommendation;
- timeline/Help recommendation;
- visual direction and licensing policy;
- source-shortlist status;
- audio plan;
- narrative direction;
- Gate ADR recommendation and non-acceptance status;
- integrated roadmap and recommended immediate next task;
- protected surfaces and non-claims;
- unresolved decisions requiring GPT or owner choice.

## 15. Authorized repository changes

May create only:

- `docs/ux/PRESENTATION_VIEWPORT_AND_HUD_DIRECTION_CURRENT.md`;
- `docs/level_design/FIVE_LEVEL_DIFFICULTY_RECOVERY_AND_LEVELS_6_8_PLAN.md`;
- `docs/ux/DOOR_PLATE_AND_ECHO_FEEDBACK_STORYBOARD.md`;
- `docs/art/ASSET_AUDIO_LICENSE_AND_PIPELINE_PLAN_CURRENT.md`;
- `docs/narrative/DELAYED_SELF_NARRATIVE_DIRECTION_CURRENT.md`;
- `docs/architecture/LATCHED_ONE_SHOT_GATE_ADR_DRAFT.md`;
- `docs/version_plans/M3_PRESENTATION_DIFFICULTY_AND_PRODUCTION_RECOVERY_PLAN.md`;
- `docs/reports/0010_PRESENTATION_DIFFICULTY_AND_PRODUCTION_DIRECTION_PLANNING_REPORT.md`.

May update narrowly:

- `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`;
- `docs/CODEX_ACTIVE_TASK_CURRENT.md`;
- `docs/DOC_INDEX_CURRENT.md`;
- `docs/DEVELOPMENT_PLAN_CURRENT.md`;
- `docs/HANDOFF_MASTER_CURRENT.md`;
- `docs/project_memory.md`.

Do not modify prior reports, reviews, accepted plans, GDD, contracts, rules, runtime files, tests, content, or settings.

## 16. Validation and quality gate

No runtime implementation test is required beyond confirming the accepted baseline remains unchanged before and after planning.

Run the repository suite before and after documentation work and require:

```text
TASK_0003_TESTS_PASS assertions=280 vectors=9
TASK_0006_APP_SHELL_TESTS_PASS
TASK_0007_TUTORIAL_LEVELS_TESTS_PASS
TASK_0008_PROGRESSIVE_HUD_TESTS_PASS
TASK_0009AR_LEVELS_4_5_TESTS_PASS
```

Also require unchanged accepted level metrics and hashes.

Document validation must verify:

- every required deliverable exists;
- all internal links resolve;
- planning facts are distinguished from proposals;
- candidate source licenses are exact and cited when researched;
- no asset is downloaded/imported;
- Gate ADR remains `DRAFT_NOT_ACCEPTED`;
- no future task is self-authorized;
- no implementation or external evidence is staged;
- no secrets or personal data are present.

## 17. Git discipline

Before staging:

```powershell
git status --short --untracked-files=all
git diff --check
git diff --stat
```

Audit authorized Markdown paths only. Stage explicit paths only; never use broad staging.

Then:

```powershell
git diff --cached --check
git diff --cached --stat
git diff --cached --name-only
```

This task authorizes one documentation-only commit:

```text
docs: plan Delayed Self presentation and difficulty recovery
```

Immediately before push:

```powershell
git fetch origin
git rev-parse HEAD
git rev-parse origin/main
git status --short --untracked-files=all
```

Stop on remote drift. Do not merge, rebase, amend, reset, force-push, or create a second commit.

## 18. Terminal verdicts

Return exactly one:

- `PASS_FOR_GPT_REVIEW`;
- `BLOCKED_BASELINE_REGRESSION`;
- `BLOCKED_NETWORK_RESEARCH_ONLY` only when all non-network planning is complete but the task cannot satisfy a mandatory source-shortlist requirement;
- `BLOCKED_UNRESOLVED_PRODUCT_CHOICE` when two materially different directions require owner selection and no responsible recommendation can be made;
- `BLOCKED`.

No terminal verdict is final GPT acceptance.

## 19. Next gate

After GPT acceptance, the expected next gate is one bounded implementation task selected by the accepted roadmap—most likely viewport/board/HUD recovery plus Door feedback using existing primitives before any external asset import or Levels 6–8 production.

No implementation, asset acquisition, new Gate semantics, or additional level production is authorized by this planning task itself.