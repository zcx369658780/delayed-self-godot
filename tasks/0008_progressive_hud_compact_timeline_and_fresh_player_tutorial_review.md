# Task 0008 — Progressive HUD, compact timeline, and fresh-player tutorial review

- Status: `READY`
- Gate: `IMPLEMENTATION + HUMAN EVIDENCE / TUTORIAL UX`
- Repository: `zcx369658780/delayed-self-godot`
- Expected branch: `main`
- Expected local root: `D:\Delayed_Self`
- Issued by: GPT Project Sources advisor
- Date: 2026-07-14
- Prior accepted gate: `TASK_0007_REUSABLE_GAMEPLAY_AND_TUTORIAL_LEVELS_ACCEPTED`
- Accepted implementation commit: `833016b9260841227d3ed97ddf6c56ee6ae91dc9`
- Prior acceptance artifact: `docs/reports/0007_GPT_FINAL_ACCEPTANCE.md`

## 1. Objective

Implement the planned progressive-disclosure HUD for the accepted three-level sequence and obtain a genuine fresh-player review of Tutorial 0 and Tutorial 1.

The task must:

1. preserve all accepted puzzle, catalog, routing, progress, tutorial-level, and solver semantics;
2. replace permanently duplicated tutorial prose with contextual disclosure;
3. introduce a compact, contract-derived timeline that makes the next Echo action visually legible;
4. keep Tutorial 0 free of Echo/timeline/door clutter;
5. retain explicit player-only victory and actor identity at the points where prior evidence showed P1 risk;
6. let a reviewer restore collapsed help without advancing a world turn;
7. collect direct evidence from a genuinely fresh reviewer who has not seen solver routes or prior design discussion;
8. stop content multiplication if the review finds a P0/P1 issue.

This task does not authorize new formal levels, level-topology changes, new puzzle mechanics, persistent saves, Results/Pause/Final Completion, final localization architecture, assets, audio, export, Web, release, or submission.

## 2. Two-phase execution and authorization

This task has two explicit phases.

### Phase A — implementation

Implement and validate the progressive HUD. After all automated and visual gates pass, Phase A authorizes one implementation/documentation commit and one normal push:

```text
feat: add Delayed Self progressive tutorial HUD
```

### Phase B — fresh-player evidence

After Phase A is pushed and the exact implementation commit is known, a fresh reviewer may perform the review protocol. Phase B authorizes one documentation-only commit and one normal push:

```text
docs: record Delayed Self tutorial fresh-player review
```

Phase B must not modify source, scenes, levels, catalog, schema, tests, project settings, copy, or visuals.

If no qualifying reviewer is available, complete and push Phase A, then return:

```text
IMPLEMENTATION_READY_FOR_FRESH_PLAYER_REVIEW
```

Do not fabricate Phase B. A later execution of the same task may continue from the accepted Phase A commit after a clean startup gate.

If both phases complete, return:

```text
FRESH_PLAYER_REVIEW_RECORDED_FOR_GPT_REVIEW
```

Neither terminal result is final GPT acceptance.

## 3. Mandatory startup gate

Before any write:

```powershell
Get-Location
git branch --show-current
git rev-parse HEAD
git rev-parse origin/main
git remote -v
git status --short --untracked-files=all
git log -16 --oneline --decorate
godot --version
```

Required conditions:

- absolute root is `D:\Delayed_Self`;
- branch is `main`;
- origin is the expected repository;
- local `HEAD` and `origin/main` contain this task and `docs/reports/0007_GPT_FINAL_ACCEPTANCE.md`;
- tracked worktree is clean;
- Godot resolves to accepted standard `4.7.stable`.

If local is behind and clean, use only:

```powershell
git fetch origin
git merge --ff-only origin/main
```

Stop on divergence, conflict, remote mismatch, unexpected tracked changes, unsafe root, missing task/acceptance, inability to fast-forward, or materially different toolchain.

## 4. Required reads

Read in this order:

1. `AGENTS.md`
2. `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`
3. `docs/CODEX_ACTIVE_TASK_CURRENT.md`
4. this task
5. `docs/reports/0007_GPT_FINAL_ACCEPTANCE.md`
6. `docs/reports/0007_REUSABLE_GAMEPLAY_AND_TUTORIAL_LEVELS_REPORT.md`
7. both tutorial validation records
8. `docs/reports/0004V_GPT_FINAL_ACCEPTANCE.md`
9. `docs/game_design/TUTORIAL_AND_HUD_PROGRESSION_PLAN_CURRENT.md`
10. `docs/architecture/SYSTEM_SKELETON_PLAN_CURRENT.md`
11. `docs/level_design/INITIAL_LEVEL_ROADMAP_AND_VALIDATION_MATRIX_CURRENT.md`
12. `docs/architecture/LEVEL_CATALOG_V1_CURRENT.md`
13. accepted simulation/level contracts and reference vectors
14. tracked catalog and all three formal levels
15. `scripts/gameplay/vertical_slice.gd`
16. `scenes/vertical_slice/vertical_slice.tscn`
17. `scripts/simulation/simulation.gd`
18. AppRoot/catalog/progress code
19. `tests/run_all.gd` and Task 0007 focused tests
20. current plan/index/handoff/project-memory documents
21. Godot safety, puzzle validation, and evidence/independent-review project rules.

Before editing, print a concise summary of:

- accepted three-level facts and metrics;
- carried P1 risks and P2 information-density evidence;
- Phase A and Phase B boundaries;
- HUD/timeline architecture;
- protected semantics and paths;
- test, visual-evidence, and reviewer plans;
- two authorized commit messages;
- stop conditions.

## 5. Frozen inputs and protected authorities

Treat as immutable:

- Godot 4.7 stable, GDScript, Compatibility renderer, 960×540;
- Windows x86_64 current target;
- `simulation_v1`, `level_v1`, catalog-v1, action order, history/delay semantics, simultaneous movement, plate/door timing, player-only EXIT, restart, canonical keys, and solver statuses;
- AppRoot routes and memory-only progress boundary;
- all three formal level JSON files and their topology;
- Tutorial 0: `L*=3`, `N*=3 (EXACT)`, 6 visited, frontier 2;
- Tutorial 1: `L*=9`, `N*=12 (EXACT)`, 1,975 visited, frontier 509, no-Echo complete unsolved with 10 states;
- vertical slice: unchanged `L*=9`, `N*=31 (EXACT)`, 1,318 visited, Echo-isolated complete unsolved with 1,006 states;
- tracked catalog sequence, prerequisites, classifications, and final flag.

Do not modify:

- `data/levels/`;
- `data/catalog/level_catalog_v1.json`;
- catalog or level JSON Schemas/contracts;
- LevelLoader or BFS solver;
- normative fixtures;
- GDD or project rules;
- AppRoot route IDs or progress persistence boundary;
- save/player-data paths;
- export/build/release/account/repository settings.

A pure simulation query may be added only when required to avoid duplicating accepted history indexing. It must be used by both existing action lookup and HUD presentation, change no transition/state/key output, and receive focused regression coverage.

If the HUD appears to require a new level field, new action, new goal, changed timing rule, or modified level topology, stop with:

```text
BLOCKED_HUD_REQUIRES_SEMANTIC_CHANGE
```

## 6. Required HUD behavior

HUD mode remains owned by validated catalog payload data.

### 6.1 `INTRO_MINIMAL`

For `tutorial_reach_exit`:

- show a short objective equivalent to “让本体到达出口”; current English development wording is acceptable only if no Chinese-first change is safely implemented;
- identify YOU and EXIT through board labels/shape plus minimal text;
- show movement and restart initially;
- hide Echo, delay, Echo next, history/timeline, Plate, Door, and WAIT-as-puzzle guidance;
- after the first legal move, collapse the full control explanation to a compact reminder;
- completion remains prominent and explicitly names YOU and EXIT;
- restart restores the level state but need not restore already-collapsed explanatory text during the same gameplay session.

### 6.2 `GUIDED_ECHO`

For `tutorial_echo_bridge`:

Initial presentation must make visible without revealing a route:

- YOU versus ECHO identity;
- player-only EXIT completion;
- delay 3;
- ECHO holds PLATE while YOU crosses DOOR;
- a compact timeline with three ordered action slots;
- a clear indication of the action ECHO will execute on the next submitted turn.

Progressive disclosure triggers:

- after the first visible non-WAIT Echo replay, collapse the full entity legend to a compact key;
- after ECHO first occupies PLATE and changes the Door state, collapse the multi-line role/door explanation to a one-line objective;
- retain the compact timeline and a discoverable help control;
- do not collapse solely on elapsed wall-clock time;
- blocked movement must remain understandable as a consumed turn, but do not add route hints.

### 6.3 `STANDARD_COMPACT`

For `vertical_slice_delay_3`:

- preserve the accepted YOU/ECHO/EXIT visual identities and completion overlay;
- replace the permanently duplicated full text History plus separate `Echo next` prose with the compact timeline as the primary planning surface;
- keep a one-line explicit player-only objective on entry;
- after the first legal input or explicit acknowledgement, collapse the objective to a compact reminder/help affordance;
- an expanded help/timeline explanation must remain available without advancing a world turn;
- do not claim the earlier information-density P2 is closed until human evidence supports it.

### 6.4 Help and disclosure state

Provide a discoverable help toggle using built-in UI and/or a bounded key handler. Requirements:

- opening/closing help never calls `Simulation.transition` and never advances `turn_index`;
- help restores objective, entity key, controls, and timeline explanation appropriate to the current mode;
- help cannot reveal an action sequence or solver route;
- route changes create a fresh per-attempt disclosure state;
- restart reconstructs simulation state exactly while retaining already-earned disclosure flags for that gameplay session;
- no persistence beyond the current process is introduced.

## 7. Compact timeline contract

Create a small presentation model/helper under an authorized gameplay/UI path. It consumes validated immutable level data and a read-only accepted state.

Required timeline behavior:

- zero Echoes: no timeline is shown;
- slots are ordered oldest to newest and equal `max_delay`;
- every slot displays an arrow/action glyph or `WAIT`, plus an accessible action label where needed;
- the slot used by each Echo is identified from the accepted contract, not independently re-derived in multiple UI locations;
- for delay equal to `max_delay`, the oldest slot is the next Echo action;
- synthetic multiple-delay tests must be able to show distinct Echo pointers without adding a formal level;
- color is supplementary; slot position, outline/pointer, and label carry meaning;
- the compact view replaces duplicate prose, while expanded help explains oldest-to-newest order and Echo pointers;
- the HUD remains presentation-only and never predicts movement outcome, door outcome, or completion beyond accepted state/query data.

Preferred anti-duplication approach:

- add one pure query such as `echo_history_index_for_state(level,state,echo_id)` to `Simulation`;
- make `echo_action_for_state` call that query;
- make the timeline use the same query;
- verify no normative vector, transition output, state key, or solver metric changes.

A different approach is allowed only if it demonstrably avoids duplicated contract indexing.

## 8. Copy and language boundary

- Use concise copy with one concept per line/card.
- Chinese-first tutorial copy is preferred for the candidate, but no localization framework, external font, or broad string-table migration is authorized.
- Built-in/system fallback font only; verify all shown glyphs at 960×540.
- English development copy may remain where changing it would broaden scope or create glyph risk; document the decision.
- Never include solver statistics, shortest paths, directional sequences, or next-move hints in player-facing copy.

## 9. Authorized Phase A repository changes

May modify/create only:

- `scripts/gameplay/vertical_slice.gd`;
- `scenes/vertical_slice/vertical_slice.tscn`;
- focused files under `scripts/gameplay/`, `scripts/ui/`, `scenes/gameplay/`, or `scenes/ui/` for HUD/timeline presentation;
- `scripts/simulation/simulation.gd` only for the pure anti-duplication query described above;
- `tests/run_all.gd`;
- focused tests under `tests/gameplay/` or `tests/ui/`;
- `docs/game_design/TUTORIAL_AND_HUD_PROGRESSION_PLAN_CURRENT.md` only to record implemented facts versus remaining recommendations;
- `docs/reports/0008_PROGRESSIVE_HUD_AND_COMPACT_TIMELINE_IMPLEMENTATION_REPORT.md`;
- current startup/task/index/plan/handoff/project-memory documents as needed.

Do not modify AppRoot, catalog loader, memory progress, Main Menu, Level Select, Safe Error, formal levels/catalog data, schemas, or other paths unless an existing contract regression proves a necessary compatibility change. Stop and request a new task rather than broadening silently.

## 10. Phase A automated validation

Use repository-only GDScript tests. No plugins, external frameworks, packages, or dependencies.

### 10.1 Baseline

Require before edits:

```text
TASK_0003_TESTS_PASS assertions=220 vectors=9
TASK_0006_APP_SHELL_TESTS_PASS
TASK_0007_TUTORIAL_LEVELS_TESTS_PASS
```

Also require all accepted level metrics unchanged.

### 10.2 Timeline tests

At minimum verify:

- zero-Echo state returns no timeline;
- Tutorial 1 produces three oldest-to-newest slots and the correct next Echo action;
- history changes update slot contents and next-action highlight consistently;
- blocked cardinal input remains represented as its original action;
- synthetic two-Echo delays point to distinct accepted history indices/actions;
- expanded explanation and compact model agree;
- timeline queries do not mutate level or state;
- canonical keys, transitions, vectors, replay, and solver results remain unchanged.

### 10.3 Mode/disclosure tests

Verify public HUD snapshots/state rather than pixels:

- `INTRO_MINIMAL` contains YOU/EXIT objective and controls but no Echo/delay/timeline/Plate/Door/WAIT-puzzle text;
- first legal action collapses initial controls without changing the transition result;
- `GUIDED_ECHO` initially includes roles, delay, causality, and compact timeline;
- first visible replay collapses the full legend;
- first ECHO-held Plate event collapses the long causality explanation;
- `STANDARD_COMPACT` uses compact timeline as primary planning information and does not permanently duplicate full History plus separate next-action prose;
- help opens/closes without changing canonical key or turn index;
- restart preserves exact logical restart and documented session disclosure behavior;
- completion remains prominent in all modes;
- all three catalog routes and direct-level routes remain operational;
- text fits 960×540 in initial, progressed, help-expanded, and completed states.

### 10.4 Final markers

Retain:

```text
TASK_0003_TESTS_PASS assertions=<at least 220> vectors=9
TASK_0006_APP_SHELL_TESTS_PASS
TASK_0007_TUTORIAL_LEVELS_TESTS_PASS
```

Add:

```text
TASK_0008_PROGRESSIVE_HUD_TESTS_PASS
```

Any failure exits non-zero.

## 11. Phase A runtime and external evidence

Authorized external root:

```text
D:\Delayed_Self_Evidence\0008_progressive_hud\
```

Use only after safe non-conflicting path checks. Required bounded evidence:

- baseline and final headless logs;
- normal AppRoot launch log;
- direct Tutorial 0, Tutorial 1, and vertical-slice launch logs;
- 960×540 game-root captures for each mode at initial and progressed states;
- Tutorial 1 timeline before and after the first replay;
- ECHO-on-PLATE disclosure state;
- help-expanded state;
- completed state in Tutorials 0–1;
- evidence index with commands, timestamps, files, and hashes.

Do not stage screenshots, raw logs, `.godot/`, imports, or external evidence. Do not capture the full desktop automatically.

## 12. Phase A report

Create:

```text
docs/reports/0008_PROGRESSIVE_HUD_AND_COMPACT_TIMELINE_IMPLEMENTATION_REPORT.md
```

Include:

- task and Git facts;
- exact changed paths;
- architecture and anti-duplication query decision;
- implemented behavior for all three HUD modes;
- disclosure triggers and help behavior;
- timeline model examples;
- baseline/final markers and all level metrics;
- visual evidence index;
- protected surfaces and non-claims;
- whether a fresh reviewer is available;
- Phase B readiness.

## 13. Phase A Git gate

Before staging:

```powershell
git status --short --untracked-files=all
git diff --check
git diff --stat
```

Audit:

- authorized paths only;
- no formal-level/catalog/schema change;
- no route or progress regression;
- no duplicated puzzle rule or solver route in copy;
- no external evidence staged;
- no secret/private data;
- links resolve;
- no fresh-player claim before Phase B.

Stage explicit paths only. Never use broad staging.

Then:

```powershell
git diff --cached --check
git diff --cached --stat
git diff --cached --name-only
```

Commit with the required Phase A message, fetch, verify no remote drift, and push normally. Stop on remote movement; do not merge/rebase/amend/force-push.

## 14. Phase B reviewer qualification

A qualifying reviewer must:

- be a real person other than Codex and other than the authenticated project owner who participated in Tasks 0004/0004V;
- not have seen solver routes, action sequences, prior design discussion, or the user's earlier screenshots/explanations;
- not have played these tutorial levels before;
- disclose any unavoidable prior exposure;
- consent to a bounded game-window-only observation/screenshot protocol.

A friend, colleague, student, or family member may qualify. Record only a non-identifying reviewer role label such as `colleague_1`; do not record unnecessary personal data.

Codex may facilitate and record but cannot answer for the reviewer or call its own inspection independent human evidence.

## 15. Phase B preflight and launch protocol

Before the review:

1. verify the exact pushed Phase A implementation commit and clean worktree;
2. rerun the final automated suite and require all four markers;
3. reset in-memory progress by restarting the process;
4. launch normal AppRoot flow;
5. do not expose solver statistics, routes, validation records, debug direct-level arguments, or design explanations.

Tell the reviewer only:

```text
Please start a new game and play the first two tutorial levels using only the information shown in the game. Say when you complete a level, give up, encounter a bug, or want a hint. Please explain what you think the symbols and timeline mean after each level.
```

Any movement hint makes the relevant attempt `ASSISTED`.

## 16. Phase B fresh-player protocol

### Tutorial 0 record

Record directly observed or reported facts:

- completion status;
- approximate elapsed time when supplied;
- final turn count;
- restart count when known;
- whether controls, YOU, EXIT, objective, completion, and restart were understood;
- whether collapsed help could be restored;
- any clipping, clutter, or unresponsive-looking state.

After the attempt ask:

1. Which object were you controlling?
2. What was the goal?
3. Were movement and restart discoverable?
4. Did any hidden/collapsed information disappear too early?
5. Was the completion state clear?

### Tutorial 1 record

Record:

- completion status and assistance status;
- final turn count and restarts when supplied;
- first interpretation of ECHO and delay;
- whether the reviewer could predict one next Echo action from the compact timeline;
- whether the reviewer understood ECHO holds PLATE so YOU crosses DOOR;
- whether next-turn Door entry timing caused confusion;
- whether help/timeline expansion was used;
- information-density and text-size observations;
- completion clarity.

After the attempt ask:

1. What are YOU and ECHO?
2. What does the three-slot timeline show, and which slot controls ECHO's next action?
3. Who must stand on PLATE and who must reach EXIT?
4. Did the Door seem to react immediately or on the next usable turn, and was that understandable?
5. Which information helped most, and which felt unnecessary?
6. Would you continue to the third level?

Ask for 1–5 ratings after both tutorials:

- entity distinction;
- objective clarity;
- control clarity;
- timeline/next-action clarity;
- Plate/Door causality;
- information density;
- willingness to continue.

Missing measurements/answers are `NOT_PROVIDED`, never inferred.

## 17. Phase B gate logic

Classify findings:

- `P0`: crash, launch/input failure, corrupted state, impossible completion due to defect, regression;
- `P1`: reviewer cannot identify victory, actors, timeline meaning, or required Plate/Door progress without a route/hint;
- `P2`: material friction, clutter, weak timing feedback, help/disclosure problem that does not block core comprehension;
- `P3`: polish or preference.

Gate outcomes:

- any P0/P1: recommend a separate `Task 0008R` and do not authorize remaining level production;
- no P0/P1 and both tutorials completed unassisted: recommend GPT acceptance and Task 0009 content production;
- no P0/P1 but assisted/incomplete: recommend a narrower repeated review or focused copy/timeline repair;
- this two-level fresh review does not replace later four-level and complete-flow independent reviews.

## 18. Authorized Phase B repository writes

Create only:

```text
docs/reviews/0008_FRESH_PLAYER_TUTORIAL_0_1_REVIEW.md
docs/reports/0008_FRESH_PLAYER_TUTORIAL_REVIEW_REPORT.md
```

Update only as needed:

- current startup/task/index/plan/handoff/project-memory documents.

Do not modify any implementation or prior artifact.

The review must include reviewer exposure qualification, exact Phase A commit, environment/launch, both attempt records, answers, ratings, P0–P3 findings, screenshot/evidence index, non-claims, and recommendation.

The report must include terminal verdict, Git facts, preflight markers, evidence paths, finding counts, no-source-change confirmation, and next-gate recommendation.

## 19. Phase B evidence and privacy

Authorized external root:

```text
D:\Delayed_Self_Evidence\0008_fresh_player_review\
```

Allowed:

- bounded automated/launch logs;
- plain-text observation and answer record;
- deliberately approved game-window-only screenshots;
- evidence index with timestamps and hashes.

Forbidden:

- full-desktop automatic capture;
- browser, email, notifications, credentials, unrelated windows/files;
- raw keyboard monitoring outside the game;
- unnecessary reviewer identity or personal details;
- staging external evidence.

## 20. Phase B Git gate

After the reviewer completes or ends both attempts:

- validate documentation accuracy and privacy;
- confirm implementation paths are unchanged from the Phase A commit;
- stage only authorized Markdown files explicitly;
- use `git diff --cached --check`, stat, and name-only audits;
- fetch and stop on remote drift;
- create the required Phase B documentation commit and push normally.

No amend, rebase, merge, force-push, or second implementation commit is authorized.

## 21. Terminal verdicts

Use exactly one:

- `FRESH_PLAYER_REVIEW_RECORDED_FOR_GPT_REVIEW`
- `IMPLEMENTATION_READY_FOR_FRESH_PLAYER_REVIEW`
- `BLOCKED_BASELINE_REGRESSION`
- `BLOCKED_HUD_REQUIRES_SEMANTIC_CHANGE`
- `BLOCKED_FRESH_REVIEW_P0_P1`
- `BLOCKED`

## 22. Next gate

- successful fresh review with no P0/P1: recommend `Task 0009 — remaining schema-v1 candidate levels and validation matrix`;
- P0/P1: recommend `Task 0008R` focused repair;
- implementation-only completion: wait for Phase B; do not begin Task 0009.