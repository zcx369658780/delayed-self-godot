# Task 0011 — Primitive board/HUD and Door-feedback recovery

- Status: `READY`
- Gate: `IMPLEMENTATION / M3.1 PRESENTATION RECOVERY`
- Repository: `zcx369658780/delayed-self-godot`
- Expected branch: `main`
- Expected local root: `D:\Delayed_Self`
- Issued by: GPT Project Sources advisor
- Date: 2026-07-16
- Prior accepted gate: `TASK_0010_PRESENTATION_DIFFICULTY_AND_PRODUCTION_PLANNING_ACCEPTED`
- Accepted planning commit: `37ab72513ed456d216bfe642282b6cac9e5484bd`
- Prior acceptance artifact: `docs/reports/0010_GPT_FINAL_ACCEPTANCE.md`
- Accepted five-level implementation: `9516c44688d5416c154167e8be002a60de7ce327`

## 1. Objective

Implement the accepted primitive presentation-recovery baseline for the existing five-level build without changing any puzzle, level, catalog, solver, or progress semantics.

The task must:

1. retain the `960×540` logical viewport and current project settings;
2. enlarge and center the board around a `60 px` cell pitch;
3. remove permanent HUD/control overlap from active board cells;
4. replace the current always-present standard Timeline and footer with the accepted contextual presentation;
5. turn `H` Help into a zero-turn modal/reference surface;
6. make combinational Plate/Door state changes visibly understandable using existing primitives;
7. make Level 4's accepted closed-start/open-result/open-next-input sequence observable;
8. reinforce Level 5's two-Plate AND dependency without adding prose-heavy clutter;
9. preserve every accepted marker, level hash, metric, transition, canonical key, route, and unlock result;
10. stop before any asset, font, audio, narrative, Gate, new-level, save, export, or release work.

This task implements presentation only. It does not authorize a new mechanic, a level edit, a viewport migration, or human acceptance.

## 2. Success criteria

Task 0011 succeeds only when:

1. all five accepted levels still use one reusable Gameplay path;
2. all current grids fit the accepted board zone at `60 px` pitch without board/HUD overlap;
3. no permanent controls/footer text crosses any formal board footprint after disclosure;
4. minimum presentation text sizes meet the accepted baseline;
5. `INTRO_MINIMAL`, `GUIDED_ECHO`, and `STANDARD_COMPACT` retain their intended conceptual boundaries;
6. Timeline visibility is deterministic and presentation-only;
7. Help opens and closes without advancing a turn, calling a transition, changing the canonical key, or leaking a route;
8. closed and open Doors are distinguishable by shape/icon/text without color or audio;
9. Level 4 exposes the accepted next-input timing boundary without changing it or revealing a movement sequence;
10. Level 5 displays stable per-Plate dependency pips/paths and an understandable AND-open state;
11. presentation effects consume accepted before/result/actor-action data and never calculate puzzle outcomes;
12. input is not dropped, duplicated, or reordered because of presentation timing;
13. all five prior markers remain passing and a new Task 0011 marker passes;
14. external visual evidence covers the required states at 960×540;
15. no claim of owner approval, fresh review, final art, final accessibility, or candidate readiness is introduced.

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
- local `HEAD` and `origin/main` contain this task and `docs/reports/0010_GPT_FINAL_ACCEPTANCE.md`;
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
5. `docs/reports/0010_GPT_FINAL_ACCEPTANCE.md`;
6. `docs/reports/0010_PRESENTATION_DIFFICULTY_AND_PRODUCTION_DIRECTION_PLANNING_REPORT.md`;
7. `docs/ux/PRESENTATION_VIEWPORT_AND_HUD_DIRECTION_CURRENT.md`;
8. `docs/ux/DOOR_PLATE_AND_ECHO_FEEDBACK_STORYBOARD.md`;
9. `docs/version_plans/M3_PRESENTATION_DIFFICULTY_AND_PRODUCTION_RECOVERY_PLAN.md`;
10. `docs/reports/0009AV_GPT_FINAL_ACCEPTANCE.md`;
11. `docs/reviews/0009AV_OWNER_FIVE_LEVEL_SEQUENCE_REVIEW.md`;
12. `docs/reports/0009AR_GPT_FINAL_ACCEPTANCE.md`;
13. all five formal level files and validation records;
14. current five-entry catalog and catalog contract;
15. `scenes/vertical_slice/vertical_slice.tscn`;
16. `scripts/gameplay/vertical_slice.gd`;
17. `scripts/gameplay/timeline_model.gd`;
18. `scripts/simulation/simulation.gd` for read-only contract use;
19. `tests/run_all.gd` and current focused gameplay/level tests;
20. current startup/index/plan/handoff/project-memory documents;
21. Godot-safety, puzzle-validation, evidence, and independent-review rules.

Before editing, print a concise summary of:

- frozen semantics, files, metrics, and hashes;
- accepted 960×540 layout dimensions;
- proposed scene/script structure;
- Timeline visibility rule;
- modal Help behavior;
- Plate/Door/ECHO feedback state model;
- Level 4 and Level 5 proof-driven visual states;
- input-timing choice and invariants;
- tests, captures, commit policy, and stop conditions.

## 5. Frozen authorities and protected paths

Treat as immutable:

- Godot 4.7 stable, GDScript, Compatibility renderer;
- logical viewport `960×540`, current stretch policy, and Windows target;
- `simulation_v1`, `level_v1`, catalog-v1, action order, blocked-action recording, delayed-ECHO history semantics, simultaneous movement, start-of-turn Door snapshots, post-movement Plate evaluation, combinational Door calculation, current-player-only EXIT, restart, replay, canonical keys, and solver statuses;
- all five formal level files and their topology;
- tracked five-entry catalog, unlock order, final flag, and memory-only progression;
- WAIT status `DEFERRED_VALIDATION_RESEARCH`;
- latched/one-shot Gate status `DRAFT_NOT_ACCEPTED`;
- current narrative, asset, font, and audio work as planning only.

Do not modify:

- `project.godot`;
- `scripts/simulation/`;
- `scripts/solver/`;
- `schemas/`;
- `data/levels/`;
- `data/catalog/`;
- AppRoot, catalog loader, progress, Main Menu, Level Select, or Safe Error implementation;
- normative fixtures/contracts;
- GDD or project rules;
- assets, fonts, audio, music, SFX, imports, plugins, or dependencies;
- persistence, export, build, release, account, or repository settings.

If the requested presentation appears to require a new level field, catalog field, action, transition rule, state field, canonical-key field, or project-setting change, stop with:

```text
BLOCKED_PRESENTATION_REQUIRES_PROTECTED_CHANGE
```

## 6. Authorized repository changes

May modify:

- `scenes/vertical_slice/vertical_slice.tscn`;
- `scripts/gameplay/vertical_slice.gd`;
- `scripts/gameplay/timeline_model.gd` only when needed for presentation text/snapshot output without changing accepted pointer logic;
- focused new presentation helpers under `scripts/gameplay/` or `scripts/ui/`;
- `tests/run_all.gd`;
- focused tests under `tests/gameplay/` or `tests/ui/`;
- focused capture harnesses under `tests/gameplay/`;
- `docs/reports/0011_PRIMITIVE_PRESENTATION_AND_DOOR_FEEDBACK_RECOVERY_REPORT.md`;
- narrowly necessary current startup/task/index/plan/handoff/project-memory documents.

Do not broaden beyond these paths without stopping for a revised task.

## 7. Board-first layout requirements

### 7.1 Logical geometry

Retain `960×540` and implement the accepted baseline:

- cell pitch: `60 px`;
- cell drawing may preserve a small fixed inter-cell gap, but every level must use the same pitch;
- board zone: approximately `x=24..564`, `y=84..504`;
- maximum current formal grid `9×7` must fit as `540×420` without clipping;
- horizontally and vertically center smaller formal grids inside the board zone using deterministic formal-grid bounds;
- retain at least 24 px outer margin and approximately 36 px separation from the right rail;
- right rail: approximately `x=600..936`;
- goal/title strip: approximately `y=18..64`;
- Help modal bounds: approximately `x=96..864`, `y=54..486`.

The board transform is presentation-only. It must not enter level state, transition output, replay, canonical keys, or solver behavior.

### 7.2 Text and permanent surfaces

Use the accepted minimums unless an existing larger value is retained:

- secondary/compact text: at least 16 px;
- instructions/objective/help body: at least 18 px;
- title/important state: at least 22 px;
- completion may remain larger.

After initial control discovery:

- no permanent controls/history/footer label may cross the board zone;
- retain only a compact `H Help` affordance outside active cells;
- one-line goal may collapse after accepted disclosure events;
- long entity/timeline explanations belong in Help, not permanent board-adjacent prose.

All label bounds must be measurable through a public test snapshot or equivalent deterministic geometry API.

## 8. HUD-mode behavior

### 8.1 `INTRO_MINIMAL`

- identify YOU and EXIT;
- show objective and initial movement/restart/Help controls;
- no ECHO, delay, Timeline, Plate, Door, or WAIT-as-puzzle information;
- after first accepted action, remove the full controls surface from the board composition;
- completion explicitly names YOU and EXIT;
- `H` opens the modal reference without changing the logical state.

### 8.2 `GUIDED_ECHO`

- retain player-only completion, YOU/ECHO identity, delay, Plate/Door causality, and the compact Timeline;
- Timeline remains visible while the level is incomplete;
- the full legend/causality explanation may collapse through accepted disclosure events;
- detailed oldest-to-newest explanation and controls move into Help;
- the main HUD may show compact arrows/pointers plus accessible short labels.

### 8.3 `STANDARD_COMPACT`

Timeline is visible only when presentation complexity is true:

```text
echo_count > 1
OR distinct_delay_count > 1
OR max_delay >= 4
```

The rule must be deterministic, presentation-only, and derived from validated immutable level facts. It must not add a catalog field or change catalog-v1.

For the current accepted standard Levels 3–5, the Timeline is therefore normally hidden because each contains one ECHO and `max_delay < 4`.

When hidden:

- retain title/turn;
- show compact Door/Plate state information only when relevant;
- keep one-line objective until its accepted collapse;
- keep `H Help` discoverable;
- do not leave an empty Timeline panel consuming permanent space.

Synthetic focused tests must cover multiple ECHOS, distinct delays, and `max_delay>=4` without adding a formal level.

## 9. Modal Help requirements

`H` opens a modal/reference card containing the mode-appropriate:

- objective;
- controls;
- entity key;
- Door/Plate explanation;
- full Timeline explanation and accessible action labels when a Timeline exists.

Requirements:

- Help open/close never calls `Simulation.transition`;
- Help open/close never changes `turn_index`, history, actor positions, Door states, completion, or canonical key;
- while Help is open, gameplay movement/WAIT/restart inputs must not accidentally advance the level;
- `H` closes Help;
- `Esc` closes Help before it performs Back/Quit behavior;
- focus/input returns predictably to Gameplay after close;
- Help never displays solver metrics, witnesses, routes, next-move advice, or hidden formal data;
- disclosure flags may remain session-local as previously accepted.

If a true Control-based modal is used, it must remain fully keyboard operable. A bounded key-driven modal is acceptable if its focus and input behavior are deterministic and tested.

## 10. Primitive feedback model

Presentation may consume:

- the accepted pre-transition state;
- submitted action;
- accepted transition result state;
- accepted actor-action metadata;
- accepted pressed-Plate query/output;
- immutable level definitions.

Presentation must not:

- recalculate whether movement was legal;
- decide whether a Door is open;
- predict a transition result;
- modify transition output;
- add presentation fields to canonical state.

Expose a deterministic presentation snapshot for focused tests. It may include visual-only fields such as:

- board rectangle and cell pitch;
- visible HUD surfaces and rectangles;
- Help state;
- Timeline visibility/model;
- player/ECHO visual tracks;
- Plate visual state;
- Door visual state (`BARS_CLOSED`, `HOLLOW_OPEN` or equivalent);
- dependency pip states;
- teaching badge state;
- blocked-Door feedback state;
- presentation phase/timing;
- reduced-motion test mode.

These fields are not gameplay authority.

## 11. Plate and dependency feedback

Using existing primitives only:

- unpressed Plate: raised/dim ring or equivalent hollow state;
- pressed Plate: filled/depressed center plus an outward ring/pip;
- release: visible shape change back to the unpressed state;
- draw one dependency path or stable visual connection for each `all_plate_ids` reference;
- order dependency pips by stable Plate ID;
- active pips fill; inactive pips remain hollow;
- dependency paths/pips visualize exact accepted references and never imply a different rule;
- color is supplementary to shape/fill/icon.

Level 5 must visibly show two dependency pips and both active when the accepted AND state is open.

## 12. Door feedback

### 12.1 Stable states

- closed Door: solid bars/center obstruction plus `CLOSED` icon/text where the rail displays state;
- open Door: hollow aperture/split frame plus `OPEN` icon/text;
- render a closed Door behind an occupying actor so actor identity remains visible;
- audio is not used in this task.

Closed and open states must remain distinguishable in grayscale captures.

### 12.2 Level 4 teaching feedback

At the accepted critical transition:

1. the start snapshot is closed;
2. submitted player movement is blocked while ECHO replays onto the Plate;
3. the result state commits the Plate pressed and Door open;
4. show a blocked-Door X/stop notch for the player;
5. show an ECHO replay trail/glyph;
6. show Plate press feedback and a dependency pulse/path state;
7. show the open Door aperture;
8. display a teaching badge adjacent to the Door or in a tightly associated state surface:

```text
OPEN · NEXT INPUT
```

The badge:

- appears only on the first relevant Level 4 open commit in the current gameplay instance;
- remains visible long enough to be captured and understood, targeted around 1.0–1.5 seconds;
- may clear on the next submitted gameplay action or Help toggle after it has become visible;
- must not reveal which direction to move;
- must not say “opening next turn,” because the result state is already open;
- must not appear as a new puzzle rule in unrelated levels.

On the next accepted input, YOU may enter from the open start snapshot. If ECHO leaves the Plate and the result closes the Door, show closure behind/around YOU without obscuring the actor.

### 12.3 Blocked action feedback

When accepted transition metadata proves the current player submitted a cardinal action but remained blocked by a closed Door:

- show a short X/stop notch at the attempted Door boundary;
- preserve the submitted action in Timeline/history exactly as accepted;
- detailed `BLOCKED · ACTION RECORDED` explanation belongs in Help or teaching feedback, not permanent standard prose.

Do not independently infer collision when accepted actor-action metadata already provides the result.

## 13. ECHO feedback

Using existing primitives only:

- retain outlined/dashed ECHO identity and `E` label;
- on a visible non-WAIT replay, show a short dotted or segmented trail from accepted before-position to accepted result-position;
- provide a replay glyph/marker distinct from player movement;
- when ECHO and YOU overlap, both identities remain readable;
- multiple synthetic ECHOS must retain stable ID/delay association in presentation snapshots;
- no particle asset, shader dependency, or audio is authorized.

## 14. Timing and input handling

Logical transition commitment remains immediate and authoritative.

Choose and document one safe presentation approach:

### Approach A — non-blocking presentation

- gameplay inputs remain accepted immediately;
- a new accepted transition replaces/advances visual-only feedback deterministically;
- no input is dropped or duplicated;
- the important committed Door state and badge remain available through stable post-result surfaces.

### Approach B — bounded single-input buffer

- presentation handoff completes within a target 260–320 ms in normal mode;
- accept at most one queued gameplay action during the bounded presentation phase;
- dispatch it exactly once after the declared safe handoff;
- do not queue while Help is open, level is complete, route is leaving, or restart occurs;
- no animation callback calculates puzzle state; it may only dispatch the already queued user action through the normal accepted input path.

Either approach must receive focused tests for rapid input, no loss, no duplicate transition, action ordering, restart, Help, completion, and route exit. Stop rather than introduce an unbounded input queue.

Provide a presentation-only reduced-motion test mode or deterministic substitute in which travel/pulse motion becomes a short static/crossfade state while all icons, text, bars/aperture, pips, and badge remain legible. Do not add a persistent settings system.

## 15. Automated validation

Use repository-only GDScript tests. No plugin, package, or external framework.

### 15.1 Baseline before edits

Require:

```text
TASK_0003_TESTS_PASS assertions=280 vectors=9
TASK_0006_APP_SHELL_TESTS_PASS
TASK_0007_TUTORIAL_LEVELS_TESTS_PASS
TASK_0008_PROGRESSIVE_HUD_TESTS_PASS
TASK_0009AR_LEVELS_4_5_TESTS_PASS
```

Require all accepted level hashes, exact metrics, replay results, and controlled-unsolved results unchanged.

### 15.2 Geometry and HUD tests

At minimum verify:

- pitch is 60 px;
- all five formal grids fit inside the accepted board zone;
- smaller grids are centered deterministically;
- board bounds do not intersect objective, status, Timeline, legend, controls, or Help when those surfaces are simultaneously visible;
- no permanent post-disclosure footer crosses active/formal board cells;
- minimum font sizes meet the accepted baseline;
- every label stays within measured bounds at 960×540;
- completion remains readable and explicit.

### 15.3 Timeline and Help tests

At minimum verify:

- Tutorial 0 has no Timeline;
- `GUIDED_ECHO` keeps Timeline visible;
- each current standard Level 3–5 hides Timeline under the accepted threshold;
- synthetic multi-ECHO, distinct-delay, and delay-4 representations show Timeline;
- every pointer still uses the shared accepted history-index query;
- compact and Help-expanded representations agree;
- Help blocks gameplay inputs and preserves turn/canonical key/state;
- `Esc` closes Help before Back/Quit;
- focus/input returns after Help close.

### 15.4 Feedback tests

At minimum verify:

- closed/open Door shape state is not color-only;
- per-Plate pips match stable required IDs;
- Level 5 has two pips and both active in the accepted AND state;
- Level 4 accepted critical trace produces blocked-player, ECHO trail, Plate press, dependency, open Door, and teaching-badge presentation states;
- the next accepted action uses the already-open logical state and clears/advances the badge as documented;
- closure around an occupant keeps actor identity visible;
- ECHO on EXIT still does not complete;
- presentation snapshot queries do not mutate level or state;
- no presentation helper calls or duplicates transition logic;
- chosen rapid-input approach preserves exact action order and count;
- reduced-motion substitute preserves state meaning.

### 15.5 Regression tests

Retain every prior marker and add:

```text
TASK_0011_PRESENTATION_RECOVERY_TESTS_PASS
```

The aggregate marker may increase the assertion count but must keep `vectors=9`. Any failure exits non-zero.

## 16. Runtime and visual evidence

Authorized external root:

```text
D:\Delayed_Self_Evidence\0011_presentation_recovery\
```

Verify safe, non-conflicting directory use before writing. Do not delete or overwrite unrelated evidence.

Required bounded evidence:

- baseline and final headless test logs;
- normal AppRoot launch log;
- direct Level 4 and Level 5 launch logs;
- 960×540 captures for all five initial gameplay states;
- Level 4 closed critical start;
- Level 4 blocked/ECHO-to-Plate feedback;
- Level 4 open result with `OPEN · NEXT INPUT`;
- Level 4 next-input entry and closed-around/behind-occupant result;
- Level 5 simultaneous two-Plate AND-open state with two active pips;
- modal Help in at least guided and standard modes;
- contextual Timeline hidden and synthetic/authorized visible-state evidence;
- grayscale closed/open comparison;
- reduced-motion substitute state;
- evidence index with commands, timestamps, sizes, and SHA-256 hashes.

Game-window-only captures are permitted. Do not automatically capture the full desktop. Do not stage screenshots, logs, `.godot/`, imports, or external evidence.

## 17. Implementation report

Create:

```text
docs/reports/0011_PRIMITIVE_PRESENTATION_AND_DOOR_FEEDBACK_RECOVERY_REPORT.md
```

Include:

- task and exact Git facts;
- chosen input-timing approach and rationale;
- exact changed paths;
- final board/HUD rectangles, pitch, and font sizes;
- Timeline threshold implementation;
- modal Help behavior;
- feedback state architecture and non-authority boundary;
- Level 4 critical presentation trace;
- Level 5 dependency-pip evidence;
- baseline/final markers, assertions, vectors, hashes, and metrics;
- capture/evidence index;
- protected surfaces and non-claims;
- remaining need for owner review;
- recommended next gate.

Do not claim that the owner has accepted the new layout or that Level 4 pedagogy is closed.

## 18. Git discipline

Before staging:

```powershell
git status --short --untracked-files=all
git diff --check
git diff --stat
```

Audit:

- authorized paths only;
- no project setting, simulation, solver, schema, level, catalog, route, progress, asset, audio, or import change;
- no duplicated puzzle rule;
- no solver route or next-move hint in player-facing text;
- no external evidence staged;
- no secret/private data;
- links resolve.

Stage explicit paths only. Never use broad staging.

Then:

```powershell
git diff --cached --check
git diff --cached --stat
git diff --cached --name-only
```

Authorize exactly one implementation/documentation commit:

```text
feat: recover Delayed Self board HUD and door feedback
```

Immediately before push:

```powershell
git fetch origin
git rev-parse HEAD
git rev-parse origin/main
git status --short --untracked-files=all
```

Stop on remote drift. Do not amend, rebase, merge, reset, force-push, or create a second implementation commit.

## 19. Terminal verdicts

Use exactly one:

- `PASS_FOR_GPT_REVIEW`;
- `BLOCKED_BASELINE_REGRESSION`;
- `BLOCKED_PRESENTATION_REQUIRES_PROTECTED_CHANGE`;
- `BLOCKED_LAYOUT_CANNOT_MEET_ACCEPTANCE`;
- `BLOCKED_INPUT_PRESENTATION_INVARIANT`;
- `BLOCKED`.

No terminal verdict is final GPT acceptance.

## 20. Next gate

After a successful implementation and GPT acceptance, issue a separate owner-targeted review gate for Level 4 plus the five-level sequence. That review must evaluate perceived board size, overlap/clutter, Door timing clarity, Timeline/Help value, and any P0–P3 findings without being represented as fresh or independent evidence.

No asset acquisition, audio, narrative, Level 6, Gate, save, export, or release task is authorized by Task 0011.