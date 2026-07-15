# Task 0009AR — Door timing and AND-door replacement content batch

- Status: `READY`
- Gate: `IMPLEMENTATION / SCHEMA-V1 CONTENT BATCH A REPLACEMENT`
- Repository: `zcx369658780/delayed-self-godot`
- Expected branch: `main`
- Expected local root: `D:\Delayed_Self`
- Issued by: GPT Project Sources advisor
- Date: 2026-07-15
- Prior accepted gate: `TASK_0008_PROGRESSIVE_HUD_AND_OWNER_TUTORIAL_RETEST_ACCEPTED_WITH_OBSERVATIONS`
- Accepted owner-retest evidence: `9f5084219b801ec177a049b64bff52cdf4799843`
- Prior acceptance artifact: `docs/reports/0008_GPT_FINAL_ACCEPTANCE.md`
- Superseded task: `tasks/0009A_door_timing_and_wait_content_batch.md`
- Blocker adjudication: `docs/reports/0009A_WAIT_RELEVANCE_BLOCKER_ADJUDICATION.md`

## 1. Objective

Create, validate, solve, replay, catalog, and smoke-test the next two schema-v1 candidate levels while preserving every accepted runtime and content authority:

1. `door_one_turn_late` — teach and prove start-of-turn Door snapshot timing;
2. `two_keys_one_door` — teach and prove a combinational AND Door requiring simultaneous occupancy of two Plates through player/Echo cooperation.

The previously planned `wait_for_the_echo` level is not part of this implementation task. Its status is `DEFERRED_VALIDATION_RESEARCH` because the prior bounded authoring pass could not satisfy the strict literal-WAIT proof without weakening the validation standard.

This task must not change simulation semantics, solver semantics, blocked-movement behavior, HUD/viewport, accepted levels 1–3, persistent progress, complete flow, exports, releases, or repository settings.

## 2. Success criteria

Task 0009AR succeeds only when:

1. both new formal levels are valid strict `level_v1` JSON;
2. both use only accepted schema-v1 mechanics;
3. the tracked catalog contains exactly five implemented levels in a linear unlock chain;
4. all five levels use the existing reusable Gameplay implementation through validated catalog payloads;
5. `door_one_turn_late` is solver-solved, replayed, and includes an explicit two-transition timing proof;
6. `two_keys_one_door` is solver-solved, replayed, and machine evidence proves both Plates, the AND relation, and player/Echo cooperation are necessary;
7. neither new level has a player bypass around its intended Door/Plate dependency;
8. ECHO reaching EXIT never completes either level;
9. the first three formal level files remain byte-for-byte unchanged with all accepted metrics unchanged;
10. all existing Task 0003/0006/0007/0008 markers remain passing;
11. one new stable Task 0009AR marker passes;
12. no fresh-player, independent, candidate, save, layout, export, release, or submission claim is introduced.

## 3. Mandatory startup gate

Before any write:

```powershell
Get-Location
git branch --show-current
git rev-parse HEAD
git rev-parse origin/main
git remote -v
git status --short --untracked-files=all
git log -20 --oneline --decorate
godot --version
```

Required conditions:

- absolute root is `D:\Delayed_Self`;
- branch is `main`;
- origin is the expected repository;
- local `HEAD` and `origin/main` contain this task, `docs/reports/0008_GPT_FINAL_ACCEPTANCE.md`, and `docs/reports/0009A_WAIT_RELEVANCE_BLOCKER_ADJUDICATION.md`;
- tracked worktree is clean;
- Godot resolves to the accepted standard `4.7.stable` toolchain.

If local is behind and clean, use only:

```powershell
git fetch origin
git merge --ff-only origin/main
```

Stop on divergence, conflict, remote mismatch, unexpected tracked changes, unsafe root, missing governance artifacts, inability to fast-forward, or materially different toolchain.

## 4. Required reads

Read in this order before editing:

1. `AGENTS.md`
2. `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`
3. `docs/CODEX_ACTIVE_TASK_CURRENT.md`
4. this task
5. `docs/reports/0009A_WAIT_RELEVANCE_BLOCKER_ADJUDICATION.md`
6. superseded Task 0009A for historical context only
7. `docs/reports/0008_GPT_FINAL_ACCEPTANCE.md`
8. `docs/reports/0008_OWNER_TARGETED_TUTORIAL_RETEST_REPORT.md`
9. `docs/reports/0008A_GPT_PHASE_A_ACCEPTANCE.md`
10. `docs/reports/0007_GPT_FINAL_ACCEPTANCE.md`
11. `docs/level_design/INITIAL_LEVEL_ROADMAP_AND_VALIDATION_MATRIX_CURRENT.md`
12. `docs/game_design/TUTORIAL_AND_HUD_PROGRESSION_PLAN_CURRENT.md`
13. `docs/architecture/LEVEL_CATALOG_V1_CURRENT.md`
14. `schemas/catalog_v1.schema.json`
15. `data/catalog/level_catalog_v1.json`
16. accepted simulation and level contracts
17. `schemas/level_v1.schema.json`
18. normative transition fixtures
19. all three accepted formal level JSON files
20. existing tutorial validation records
21. `scripts/simulation/level_loader.gd`
22. `scripts/simulation/simulation.gd`
23. `scripts/solver/bfs_solver.gd`
24. `scripts/gameplay/vertical_slice.gd`
25. `scripts/gameplay/timeline_model.gd`
26. AppRoot, catalog, and memory-progress code
27. `tests/run_all.gd` and focused level/gameplay tests
28. current plan/index/handoff/project-memory documents
29. puzzle-validation, Godot-safety, and evidence/independent-review project rules.

Before writing, print a concise summary of:

- blocker adjudication and WAIT non-claims;
- replacement level roles;
- frozen rules, files, and metrics;
- proposed layouts and proof obligations;
- catalog/unlock changes;
- exact allowed/protected paths;
- baseline/final tests and external evidence;
- commit/push authorization;
- stop conditions.

## 5. Frozen inputs and protected authorities

Treat as immutable:

- Godot 4.7 stable, GDScript, Compatibility renderer, 960×540 logical viewport;
- Windows x86_64 current target;
- `simulation_v1`, `level_v1`, and catalog-v1 semantics;
- action order `UP`, `RIGHT`, `DOWN`, `LEFT`, `WAIT`;
- blocked legal movement consumes a turn and records the submitted cardinal action;
- simultaneous actor movement against the same start-of-turn Door snapshot;
- Plate evaluation after movement and combinational AND Door calculation;
- newly calculated Door state affects entry on the following turn;
- current-player-only EXIT completion;
- restart, history, canonical key, replay, and solver statuses;
- AppRoot route IDs and memory-only progress boundary;
- progressive HUD behavior and timeline query behavior;
- the carried P2 observations about limited current Help utility and right-side HUD crowding;
- all three existing formal level files and topology;
- Tutorial 0 metrics: `L*=3`, `N*=3 (EXACT)`, 6 visited, frontier 2;
- Tutorial 1 metrics: `L*=9`, `N*=12 (EXACT)`, 1,975 visited, frontier 509, no-Echo complete unsolved with 10 states;
- vertical slice metrics: `L*=9`, `N*=31 (EXACT)`, 1,318 visited, Echo-isolated complete unsolved with 1,006 states.

Do not modify:

- `data/levels/tutorial_reach_exit.json`;
- `data/levels/tutorial_echo_bridge.json`;
- `data/levels/vertical_slice_delay_3.json`;
- `schemas/level_v1.schema.json`;
- `schemas/catalog_v1.schema.json`;
- `scripts/simulation/level_loader.gd`;
- `scripts/simulation/simulation.gd`;
- `scripts/solver/bfs_solver.gd`;
- normative fixtures/contracts;
- gameplay/HUD scenes or scripts;
- AppRoot, catalog loader, memory progress, menu, select, or error implementation;
- project settings, input map, viewport, persistence, export, build, release, account, or repository settings;
- GDD or project rules.

Do not use this task to revisit or weaken the literal-WAIT proof. Do not create `wait_for_the_echo.json`.

If either replacement level appears to require a new goal, field, action, latch, switch, timer, hazard, push, teleport, route-sensitive actor rule, or simulation/solver change, stop with:

```text
BLOCKED_CONTENT_REQUIRES_UNSUPPORTED_MECHANIC
```

## 6. Level 4 — `door_one_turn_late`

Create:

```text
data/levels/door_one_turn_late.json
```

Required formal properties:

- `schema_version=1`;
- `level_id="door_one_turn_late"`;
- exactly one Echo with delay exactly `2`;
- exactly one Plate;
- exactly one combinational Door referencing that Plate;
- one player-only EXIT beyond or meaningfully gated by the Door;
- terrain only `#` and `.`;
- no unsupported metadata mechanics;
- bounded `recommended_search_depth`;
- no intentional literal-WAIT teaching requirement;
- design target `L*` band 7–12, unverified until solver execution;
- geometry distinct from Tutorial 1 and the vertical slice;
- no direct path that bypasses the Door/Plate teaching event.

Teaching proof requirement:

A solver-produced or equally authoritative shared-transition trace must show two consecutive transitions:

1. **closed-snapshot transition** — at start of turn the Door is closed; ECHO reaches the Plate during movement; the player does not enter the closed Door; the resulting state has the Door open;
2. **open-snapshot entry transition** — the next submitted turn starts with the Door open and the player enters the Door cell using that start snapshot.

The shortest accepted witness must exercise the timing lesson. A cosmetic Door whose shortest solution bypasses this sequence fails.

Required evidence:

- strict loader validity;
- solver `SOLVED`;
- exact `L*` and exact/capped `N*`;
- solver witness replay to completion;
- exact two-transition timing trace;
- controlled no-Echo or equivalent cooperation-necessity complete search;
- no player bypass around Door/Plate;
- ECHO-on-EXIT remains `completed=false`;
- exact restart;
- recorded depth/state/time/count limits, visited states, and maximum frontier.

## 7. Level 5 — `two_keys_one_door`

Create:

```text
data/levels/two_keys_one_door.json
```

Required formal properties:

- `schema_version=1`;
- `level_id="two_keys_one_door"`;
- exactly one Echo with delay exactly `3`;
- exactly two Plates with distinct IDs and positions;
- exactly one combinational Door whose `required_plate_ids` contains both Plate IDs;
- one player-only EXIT beyond or meaningfully gated by the Door;
- terrain only `#` and `.`;
- no unsupported metadata mechanics;
- bounded `recommended_search_depth`;
- geometry distinct from all earlier levels;
- design target `L*` band 11–18, unverified until solver execution;
- no requirement to prove literal WAIT;
- no direct path around the Door.

Teaching structure:

- ECHO must occupy one Plate while YOU occupies the other;
- both Plates must be simultaneously pressed in the resulting post-movement state for the AND Door to become open;
- YOU must subsequently traverse the Door using an open start-of-turn snapshot and reach EXIT;
- the intended solution must not be satisfiable by one actor alone cycling between Plates;
- legal actor overlap must not trivialize the level.

Required machine evidence:

1. strict loader validity;
2. solver `SOLVED`;
3. exact `L*` and exact/capped `N*`;
4. one witness replay to completion;
5. trace showing both Plates simultaneously pressed and the AND Door open;
6. trace showing YOU enters the Door from a start state in which it is open;
7. controlled no-Echo complete search unsolved or otherwise proving Echo cooperation necessity;
8. controlled variant removing or relocating Plate A fails the intended completion dependency;
9. controlled variant removing or relocating Plate B fails the intended completion dependency;
10. controlled variant changing the Door to depend on only one Plate demonstrates why the accepted formal AND dependency matters, without changing the committed level;
11. no player bypass around the Door;
12. ECHO-on-EXIT remains `completed=false`;
13. exact restart;
14. recorded resource limits, visited states, and maximum frontier.

Evidence variants are test-only representations and must not add fields to the committed formal level or change runtime semantics.

If either Plate is unnecessary, if one actor can satisfy the intended gate alone, or if the Door can be bypassed, iterate the level or stop with:

```text
BLOCKED_AND_DEPENDENCY_NOT_MECHANICALLY_RELEVANT
```

## 8. Catalog and progress update

Update the tracked catalog to exactly these five entries:

| sequence | level_id | classification | prerequisite | hud_mode | final_level |
|---:|---|---|---|---|---|
| 1 | `tutorial_reach_exit` | `tutorial` | none | `INTRO_MINIMAL` | false |
| 2 | `tutorial_echo_bridge` | `tutorial` | `tutorial_reach_exit` | `GUIDED_ECHO` | false |
| 3 | `vertical_slice_delay_3` | `standard` | `tutorial_echo_bridge` | `STANDARD_COMPACT` | false |
| 4 | `door_one_turn_late` | `standard` | `vertical_slice_delay_3` | `STANDARD_COMPACT` | false |
| 5 | `two_keys_one_door` | `standard` | `door_one_turn_late` | `STANDARD_COMPACT` | true |

Use stable title keys:

```text
level.door_one_turn_late.title
level.two_keys_one_door.title
```

Do not add `best_turn_threshold`.

Update the human catalog contract narrowly for five-entry tracked facts without changing catalog-v1 shape or authority.

Progress tests must prove:

- only Tutorial 0 is initially unlocked;
- each completion unlocks only its direct successor;
- Level 5 remains locked until Level 4 completion;
- reset restores exact initial unlocks;
- no filesystem write occurs.

## 9. Validation records and roadmap update

Create:

```text
docs/level_design/validation/DOOR_ONE_TURN_LATE_VALIDATION.md
docs/level_design/validation/TWO_KEYS_ONE_DOOR_VALIDATION.md
```

Each record must include:

- formal path and ID;
- status ladder reached;
- loader/schema result;
- solver status;
- `L*`;
- `N*` plus `EXACT`/`CAPPED`;
- visited states, maximum frontier, and configured limits;
- solver witness action array;
- replay completed state;
- exact restart;
- mechanic-necessity variants;
- shortcut/bypass audit;
- known limitations;
- explicit statement that fresh-player and candidate acceptance have not occurred.

Level 4 additionally records the exact two-transition Door timing trace.

Level 5 additionally records the simultaneous two-Plate trace, open-snapshot Door entry, each Plate necessity variant, Echo necessity, and overlap audit.

Update:

```text
docs/level_design/INITIAL_LEVEL_ROADMAP_AND_VALIDATION_MATRIX_CURRENT.md
```

Narrowly:

- mark Level 4 and promoted Level 5 with actual evidenced statuses and metrics;
- move `wait_for_the_echo` to a clearly labelled `DEFERRED_VALIDATION_RESEARCH` section;
- do not report WAIT as impossible or redundant;
- retain remaining uncreated levels as `UNVERIFIED_DESIGN_TARGET`;
- reconcile later sequence numbering without inventing implemented content.

Neither new level may be called `FRESH_PLAYER_REVIEWED` or `CANDIDATE_ACCEPTED`.

## 10. Authorized repository changes

May create or modify only:

### Formal content and catalog

- `data/levels/door_one_turn_late.json`;
- `data/levels/two_keys_one_door.json`;
- `data/catalog/level_catalog_v1.json`;
- `docs/architecture/LEVEL_CATALOG_V1_CURRENT.md` narrowly for five-entry tracked facts;
- `docs/level_design/INITIAL_LEVEL_ROADMAP_AND_VALIDATION_MATRIX_CURRENT.md` narrowly for replacement status and evidence.

### Validation and tests

- `docs/level_design/validation/DOOR_ONE_TURN_LATE_VALIDATION.md`;
- `docs/level_design/validation/TWO_KEYS_ONE_DOOR_VALIDATION.md`;
- `tests/run_all.gd`;
- focused files under `tests/levels/`, `tests/gameplay/`, or `tests/app/`;
- test-only controlled variants generated in memory or bounded fixture paths under `tests/`.

### Reporting/current documents

- `docs/reports/0009AR_DOOR_TIMING_AND_AND_DOOR_CONTENT_REPORT.md`;
- `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`;
- `docs/CODEX_ACTIVE_TASK_CURRENT.md`;
- `docs/DOC_INDEX_CURRENT.md`;
- `docs/DEVELOPMENT_PLAN_CURRENT.md`;
- `docs/HANDOFF_MASTER_CURRENT.md`;
- `docs/project_memory.md`.

Do not modify any other path. Do not modify the blocker adjudication or prior reports.

## 11. Automated validation

Use repository-only GDScript tests. Do not install dependencies, plugins, test frameworks, or schema packages.

### 11.1 Baseline before edits

Require:

```text
TASK_0003_TESTS_PASS assertions=239 vectors=9
TASK_0006_APP_SHELL_TESTS_PASS
TASK_0007_TUTORIAL_LEVELS_TESTS_PASS
TASK_0008_PROGRESSIVE_HUD_TESTS_PASS
```

Also require every accepted Level 1–3 metric unchanged.

If baseline fails, stop with:

```text
BLOCKED_BASELINE_REGRESSION
```

### 11.2 New level tests

For both new levels:

- load through unchanged LevelLoader;
- assert normalized IDs and exact cardinalities;
- construct and exactly restart state;
- solve with bounded BFS;
- replay a solver witness through shared transition;
- assert completion depth equals reported `L*`;
- record `N*` status semantics and resource summaries;
- prove Echo-on-EXIT does not complete;
- prove no direct Door bypass.

Level 4 tests must assert the exact closed-snapshot/open-result followed by open-snapshot/entry sequence.

Level 5 tests must assert:

- both Plate IDs appear in the formal Door dependency;
- both are simultaneously pressed in the witness trace;
- removing/relocating either Plate dependency defeats the intended completion path;
- no-Echo controlled state space is complete unsolved or equivalent strong necessity evidence;
- YOU enters from an open start snapshot;
- overlap does not trivialize the dependency.

### 11.3 Catalog, progress, and runtime tests

Verify:

- tracked five-entry catalog validates and normalizes in sequence;
- exactly one final entry, `two_keys_one_door`;
- all paths and formal IDs match;
- prerequisites and HUD modes match this task;
- linear unlock progression through Level 5;
- reset restores only Tutorial 0 unlocked;
- all five catalog IDs route through the same Gameplay implementation;
- invalid/locked IDs retain Safe Error and no partial Gameplay state;
- development direct-level route accepts both new IDs;
- normal AppRoot launch remains operational;
- no filesystem progress write occurs.

### 11.4 Regression and hash checks

Record and compare hashes for all three accepted formal level files. Require all existing metrics and markers unchanged.

### 11.5 Final markers

Retain:

```text
TASK_0003_TESTS_PASS assertions=<at least 239> vectors=9
TASK_0006_APP_SHELL_TESTS_PASS
TASK_0007_TUTORIAL_LEVELS_TESTS_PASS
TASK_0008_PROGRESSIVE_HUD_TESTS_PASS
```

Add:

```text
TASK_0009AR_LEVELS_4_5_TESTS_PASS
```

Any failure exits non-zero.

## 12. Runtime and external evidence

Authorized external root:

```text
D:\Delayed_Self_Evidence\0009AR_levels_4_5\
```

Use only after safe, non-conflicting path checks.

Required bounded evidence:

- baseline and final headless logs;
- solver/replay summaries for both new levels;
- Level 4 two-transition timing trace;
- Level 4 no-Echo/cooperation evidence;
- Level 5 simultaneous AND-Plate trace;
- Level 5 each-Plate and no-Echo necessity evidence;
- normal AppRoot launch log;
- direct-level launch logs for both new levels;
- game-root-only 960×540 captures for Level 4 and Level 5 initial and representative progressed states;
- Level Select capture showing five-entry progression where safely reproducible;
- evidence index with commands, timestamps, filenames, sizes, and hashes.

Do not stage screenshots, raw logs, `.godot/`, imports, or external evidence. Do not automatically capture the full desktop.

## 13. Required report

Create:

```text
docs/reports/0009AR_DOOR_TIMING_AND_AND_DOOR_CONTENT_REPORT.md
```

Include:

- terminal verdict and exact Git facts;
- superseded Task 0009A/blocker relationship;
- exact changed paths;
- formal level summaries;
- actual solver/replay/resource metrics;
- Level 4 timing proof;
- Level 5 AND/cooperation/Plate-necessity proofs;
- catalog and unlock results;
- first-three-level hash and regression comparisons;
- all test markers;
- external evidence index;
- protected surfaces and non-claims;
- deferred WAIT research status;
- recommended next gate.

## 14. Git discipline

Before staging:

```powershell
git status --short --untracked-files=all
git diff --check
git diff --stat
```

Audit:

- authorized paths only;
- no Level 1–3 changes;
- no simulation, solver, HUD, viewport, app-shell, persistence, or project-setting change;
- no `wait_for_the_echo.json`;
- actual metrics are evidenced, not guessed;
- WAIT is labelled deferred, not impossible;
- no fresh-player/candidate claim;
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

This task authorizes one focused implementation/documentation commit:

```text
feat: add Delayed Self door timing and AND-door levels
```

Immediately before push:

```powershell
git fetch origin
git rev-parse HEAD
git rev-parse origin/main
git status --short --untracked-files=all
```

Stop on remote drift. Do not merge, rebase, amend, force-push, reset published history, or create a second implementation commit.

## 15. Terminal verdicts

Return exactly one:

- `PASS_FOR_GPT_REVIEW`
- `BLOCKED_BASELINE_REGRESSION`
- `BLOCKED_CONTENT_REQUIRES_UNSUPPORTED_MECHANIC`
- `BLOCKED_AND_DEPENDENCY_NOT_MECHANICALLY_RELEVANT`
- `BLOCKED`

No terminal verdict is final GPT acceptance.

## 16. Next gate

After GPT acceptance:

- if both levels pass strongly, decide between a five-level owner sequence review and the next small content batch;
- retain a qualifying fresh/independent review before candidate acceptance;
- keep WAIT feasibility as separate research unless a future explicit task reopens it;
- do not infer save, complete-flow, export, release, or submission authority.