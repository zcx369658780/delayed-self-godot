# Task 0007 — Reusable gameplay loading and Tutorial 0–1 formal levels

- Status: `READY`
- Gate: `IMPLEMENTATION / REUSABLE GAMEPLAY AND TUTORIAL CONTENT`
- Repository: `zcx369658780/delayed-self-godot`
- Expected branch: `main`
- Expected local root: `D:\Delayed_Self`
- Issued by: GPT Project Sources advisor
- Date: 2026-07-14
- Prior accepted gate: `TASK_0006_APP_SHELL_CATALOG_AND_MEMORY_PROGRESS_ACCEPTED`
- Prior accepted implementation commit: `4fc742723b1ea5dbefb19cf4ea27acacc2ad9f36`
- Prior acceptance artifact: `docs/reports/0006_GPT_FINAL_ACCEPTANCE.md`
- Accepted repaired gameplay base: `caeff311fda77b0261a7d78672afb9244ff23549`

## 1. Objective

Generalize the accepted hosted gameplay surface enough to load multiple validated catalog-selected schema-v1 levels, then create, validate, solve, replay, catalog, and smoke-test the first two tutorial levels.

The delivered three-level sequence must be:

1. `tutorial_reach_exit` — Tutorial 0: YOU, movement, EXIT, restart, completion; no echo, plate, or door.
2. `tutorial_echo_bridge` — Tutorial 1: one delay-3 ECHO must operate one PLATE/DOOR chain so YOU reaches EXIT.
3. `vertical_slice_delay_3` — the unchanged accepted first less-guided puzzle.

This task must preserve one simulation authority and one data-driven gameplay path. It must not create per-level gameplay scenes or scripts that encode puzzle rules.

## 2. Success criteria

Task 0007 succeeds only when:

1. the application catalog contains exactly the three implemented levels in the sequence above;
2. catalog prerequisites produce the deterministic unlock chain Tutorial 0 → Tutorial 1 → accepted vertical slice;
3. one reusable hosted gameplay implementation loads all three through validated catalog payloads;
4. valid zero-echo/no-door/no-plate levels do not crash, show irrelevant echo/door data, or require fake entities;
5. valid single-echo levels use the same accepted transition, history, door, completion, replay, and solver authorities;
6. Tutorial 0 is schema-valid, solver-solved, replay-validated, and locally playable;
7. Tutorial 1 is schema-valid, solver-solved, replay-validated, locally playable, and machine-evidenced as requiring delayed-Echo cooperation;
8. the accepted vertical slice remains byte-for-byte unchanged and retains all accepted metrics and behavior;
9. AppRoot, catalog validation, Safe Error, development direct-level routing, and in-memory progress remain passing;
10. no unsupported mechanic, persistent save, final progressive-HUD claim, asset, export, Web, release, or submission surface is introduced.

## 3. Mandatory startup gate

Before any write:

```powershell
Get-Location
git branch --show-current
git rev-parse HEAD
git rev-parse origin/main
git remote -v
git status --short --untracked-files=all
git log -14 --oneline --decorate
godot --version
```

Required conditions:

- absolute root is `D:\Delayed_Self`;
- branch is `main`;
- origin is the expected repository;
- local `HEAD` and `origin/main` contain this task and `docs/reports/0006_GPT_FINAL_ACCEPTANCE.md`;
- tracked worktree is clean;
- Godot resolves to the accepted standard `4.7.stable` toolchain.

If local is behind and clean, use only:

```powershell
git fetch origin
git merge --ff-only origin/main
```

Stop on divergence, conflict, remote mismatch, unexpected tracked changes, unsafe root, missing task/acceptance, inability to fast-forward, or materially different Godot/toolchain.

## 4. Required reads

Read in this order before editing:

1. `AGENTS.md`
2. `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`
3. `docs/CODEX_ACTIVE_TASK_CURRENT.md`
4. this task file
5. `docs/reports/0006_GPT_FINAL_ACCEPTANCE.md`
6. `docs/reports/0006_REUSABLE_APP_SHELL_CATALOG_AND_MEMORY_PROGRESS_REPORT.md`
7. `docs/architecture/LEVEL_CATALOG_V1_CURRENT.md`
8. `schemas/catalog_v1.schema.json`
9. `data/catalog/level_catalog_v1.json`
10. `docs/architecture/SYSTEM_SKELETON_PLAN_CURRENT.md`
11. `docs/game_design/TUTORIAL_AND_HUD_PROGRESSION_PLAN_CURRENT.md`
12. `docs/level_design/INITIAL_LEVEL_ROADMAP_AND_VALIDATION_MATRIX_CURRENT.md`
13. `docs/version_plans/M2_SYSTEM_SKELETON_IMPLEMENTATION_PLAN.md`
14. `docs/game_design/GAMEPLAY_SIMULATION_CONTRACT_CURRENT.md`
15. `docs/level_design/LEVEL_SCHEMA_V1_CURRENT.md`
16. `schemas/level_v1.schema.json`
17. `docs/level_design/REFERENCE_TRANSITION_VECTORS_V1.md`
18. `docs/level_design/reference/turn_transition_vectors_v1.json`
19. `data/levels/vertical_slice_delay_3.json`
20. `project.godot`
21. `scenes/app/app_root.tscn`
22. `scripts/app/app_root.gd`
23. `scripts/app/catalog_loader.gd`
24. `scripts/app/memory_progress.gd`
25. `scenes/vertical_slice/vertical_slice.tscn`
26. `scripts/gameplay/vertical_slice.gd`
27. `scripts/simulation/level_loader.gd`
28. `scripts/simulation/simulation.gd`
29. `scripts/solver/bfs_solver.gd`
30. `tests/run_all.gd`
31. current plan/index/handoff/project-memory documents
32. puzzle-validation, Godot-safety, and evidence/independent-review project rules.

Before writing, print a concise summary of:

- objective and three-level sequence;
- accepted authorities and protected metrics;
- proposed reusable-gameplay seam;
- Tutorial 0 and Tutorial 1 content constraints;
- catalog/unlock changes;
- interim HUD boundary versus Task 0008;
- exact allowed/protected paths;
- solver, regression, runtime, and evidence plan;
- commit/push authorization;
- stop conditions.

## 5. Frozen inputs and protected authorities

Treat as immutable:

- standard Godot `4.7.stable`, GDScript, Compatibility renderer, 960×540;
- Windows x86_64 current target;
- accepted `simulation_v1` and `level_v1` semantics;
- legal action set/order `UP`, `RIGHT`, `DOWN`, `LEFT`, `WAIT`;
- simultaneous non-blocking actor movement;
- accepted history/delay indexing;
- combinational PLATE/DOOR and next-turn entry timing;
- current-player-only EXIT completion;
- restart semantics;
- normative transition fixtures and canonical keys;
- strict accepted LevelLoader boundary;
- existing BFS semantics and statuses;
- catalog-v1 shape and authority boundary;
- accepted `vertical_slice_delay_3` formal file and topology;
- accepted vertical-slice solver result `L*=9`, `N*=31 (EXACT)`, 1,318 visited states;
- accepted controlled Echo-isolated result: complete finite state exhausted unsolved, 1,006 states;
- AppRoot route IDs, Safe Error principle, validated payload routing, and memory-only progress boundary.

Do not modify:

- `scripts/simulation/level_loader.gd`;
- `scripts/simulation/simulation.gd` unless a pure, non-semantic presentation query is strictly necessary and separately justified in the report; prefer no modification;
- `scripts/solver/bfs_solver.gd`;
- `schemas/level_v1.schema.json`;
- accepted transition fixtures/contracts;
- `data/levels/vertical_slice_delay_3.json`;
- the canonical GDD or project rules;
- persistent save/player-data paths;
- export presets, builds, releases, repository settings, or account surfaces.

If Tutorial 0 or Tutorial 1 appears to require a new goal, interaction, timer, latch, hazard, push, route-sensitive actor rule, or schema field, stop with `BLOCKED_TUTORIAL_REQUIRES_UNSUPPORTED_MECHANIC` rather than extending v1.

## 6. Reusable gameplay architecture

Task 0006 intentionally retained a narrow compatibility seam. Task 0007 must make the gameplay route genuinely reusable for the three formal levels without performing the final Task 0008 HUD redesign.

### 6.1 Allowed implementation choices

Choose and document one bounded approach:

**Approach A — new reusable gameplay scene**

- create a reusable scene/script under `scenes/gameplay/` and `scripts/gameplay/`;
- AppRoot hosts the new scene through the existing validated payload;
- preserve `scenes/vertical_slice/vertical_slice.tscn` as a direct-development compatibility wrapper or direct accepted-scene path.

**Approach B — generalize the existing scene in place**

- retain the current scene path but remove vertical-slice-only assumptions;
- document the historical name as a temporary compatibility artifact;
- ensure all three catalog levels use the same implementation.

Do not duplicate board, HUD, input, completion, or transition logic between the approaches. Do not create one scene/script per tutorial.

### 6.2 Required responsibilities

The reusable gameplay surface must:

- accept a validated catalog route payload before tree entry;
- load the configured formal level through the unchanged accepted LevelLoader;
- verify catalog/formal level ID parity;
- construct initial state through the accepted Simulation;
- submit legal actions through the single accepted transition authority;
- render arbitrary valid schema-v1 cardinalities used in this task: zero or one Echo, zero or one Plate, zero or one Door;
- avoid unsafe `[0]` indexing when a collection may be empty;
- emit completion with configured catalog `level_id` and logical turn count;
- emit request-back when hosted by AppRoot;
- preserve direct-development launch of the accepted vertical slice with its default path;
- fail safely on invalid configuration without partial gameplay state.

A narrow controller/view/HUD split is allowed if it lowers risk. A broad service framework, autoload proliferation, or final architecture rewrite is not required.

### 6.3 Interim HUD boundary

Task 0007 must make all three levels understandable and non-crashing, but Task 0008 still owns the final progressive HUD/timeline redesign and fresh-player evidence.

Implement only the minimum functional mapping:

- `INTRO_MINIMAL`: show YOU, EXIT, movement, restart, completion, and a concise tutorial objective; hide Echo, delay, Echo-next, history, Plate, Door, and WAIT-as-puzzle guidance when absent.
- `GUIDED_ECHO`: show explicit YOU/ECHO/PLATE/DOOR/EXIT roles, delay, current text history/Echo-next information, controls, and a concise role-causality objective without revealing a route.
- `STANDARD_COMPACT`: preserve the accepted vertical-slice readability behavior; no requirement to implement the final compact visual timeline in this task.

Requirements:

- HUD mode comes from the validated catalog payload, never formal `level_v1` data;
- absent entities produce absent/contextual UI rather than placeholder/fake values;
- completion remains prominent and names YOU/EXIT;
- no copy contains a movement sequence;
- current English development copy may remain; Chinese-first localization implementation is deferred;
- Task 0007 must not claim the information-density P2 is fully resolved.

## 7. Tutorial 0 formal level

Create:

```text
data/levels/tutorial_reach_exit.json
```

Required formal properties:

- `schema_version=1`;
- `level_id="tutorial_reach_exit"`;
- zero Echoes;
- `metadata.allow_zero_echo_tutorial=true`;
- zero Plates;
- zero Doors;
- one player spawn and one distinct EXIT;
- terrain only `#` and `.`;
- no unsupported metadata mechanics;
- bounded `recommended_search_depth`;
- player does not start on EXIT;
- simple geometry with at least one meaningful movement choice but no intentional trap;
- design target `L*` band 2–5, explicitly unverified until the solver runs.

Teaching goal:

- identify YOU and EXIT;
- move using the accepted input map;
- observe unmistakable completion;
- restart works exactly;
- no Echo/WAIT/timeline/Plate/Door concept is introduced.

Required evidence before acceptance:

- strict loader validity;
- solver status `SOLVED`;
- exact `L*` and exact/capped `N*` recorded from the implemented level;
- one solver-produced action sequence replayed to completion;
- restart exactness;
- local gameplay route and direct configured launch smoke;
- no claim of fresh-player clarity.

## 8. Tutorial 1 formal level

Create:

```text
data/levels/tutorial_echo_bridge.json
```

Required formal properties:

- `schema_version=1`;
- `level_id="tutorial_echo_bridge"`;
- one Echo with delay exactly `3`;
- preferably player and Echo share the spawn unless a documented layout reason requires otherwise;
- exactly one Plate;
- exactly one combinational Door referencing that Plate;
- one distinct player-only EXIT beyond or meaningfully gated by the Door;
- terrain only `#` and `.`;
- no unsupported metadata mechanics;
- bounded `recommended_search_depth`;
- design target `L*` band 6–10, explicitly unverified until solver execution;
- geometry must be simpler and more direct than `vertical_slice_delay_3`, not a cosmetic copy.

Teaching goal:

- identify ECHO and delay 3;
- understand current actions become future Echo actions;
- make ECHO hold PLATE while YOU crosses DOOR and reaches EXIT;
- expose accepted next-turn Door timing without requiring explanatory route text;
- do not require multiple Echoes, multiple Doors, AND Plates, or a forced WAIT teaching proof.

Required machine evidence:

- strict loader validity;
- solver status `SOLVED`;
- exact `L*` and exact/capped `N*`;
- solver witness replay reaches completion;
- transition trace demonstrates a Door entry using the accepted start-of-turn open snapshot caused by Echo/Plate occupancy;
- controlled mechanic-necessity evidence shows the intended delayed Echo is required for the taught Door-crossing path;
- audit that YOU cannot bypass the Door/Plate and ECHO alone cannot complete;
- restart exactness and resource limits recorded.

The necessity variant is evidence only and must not add a field to the formal level. It may isolate/relocate/disable the Echo in a controlled test representation or use an equivalent bounded trace/search, but it must not alter `simulation_v1`.

## 9. Catalog and progress update

Update the tracked catalog to exactly these entries:

| sequence | level_id | classification | prerequisite | hud_mode | final_level |
|---:|---|---|---|---|---|
| 1 | `tutorial_reach_exit` | `tutorial` | none | `INTRO_MINIMAL` | false |
| 2 | `tutorial_echo_bridge` | `tutorial` | `tutorial_reach_exit` | `GUIDED_ECHO` | false |
| 3 | `vertical_slice_delay_3` | `standard` | `tutorial_echo_bridge` | `STANDARD_COMPACT` | true |

Use stable title keys:

```text
level.tutorial_reach_exit.title
level.tutorial_echo_bridge.title
level.vertical_slice_delay_3.title
```

Do not add `best_turn_threshold` to any entry in this task. Solver metrics are validation evidence, not automatically product thresholds.

Update the human catalog contract only as needed to replace the one-entry development facts with the accepted three-entry runtime facts. Do not change catalog-v1 shape or add fields.

In-memory progress behavior must demonstrate:

- Tutorial 0 unlocked initially;
- Tutorial 1 locked until Tutorial 0 completion;
- vertical slice locked until Tutorial 1 completion;
- completing a level unlocks only the correct next entry;
- reset returns the exact initial unlock state;
- no filesystem write.

## 10. Validation records

Create:

```text
docs/level_design/validation/TUTORIAL_REACH_EXIT_VALIDATION.md
docs/level_design/validation/TUTORIAL_ECHO_BRIDGE_VALIDATION.md
```

Each record must include:

- formal level path and ID;
- status ladder reached;
- loader/schema result;
- solver status;
- `L*`;
- `N*` plus `EXACT`/`CAPPED`;
- visited states, maximum frontier, and configured limits;
- one solver witness action array;
- replay result and completed state;
- restart result;
- required mechanic/necessity evidence;
- shortcut/bypass audit;
- known limitations;
- explicit statement that human/fresh-player acceptance has not yet occurred.

Do not call either level `FRESH_PLAYER_REVIEWED` or `CANDIDATE_ACCEPTED` in this task.

## 11. Authorized repository changes

May create or modify only:

### Formal content/catalog

- `data/levels/tutorial_reach_exit.json`;
- `data/levels/tutorial_echo_bridge.json`;
- `data/catalog/level_catalog_v1.json`;
- `docs/architecture/LEVEL_CATALOG_V1_CURRENT.md` narrowly for three-entry tracked facts.

### Gameplay/app surfaces

- current gameplay scene/script paths;
- new files under `scenes/gameplay/` and `scripts/gameplay/` if Approach A or a bounded split is chosen;
- `scripts/app/app_root.gd` only to point at/configure the reusable gameplay scene and preserve route behavior;
- `scenes/app/app_root.tscn` only if required for the reusable seam;
- do not modify Main Menu, Level Select, Safe Error, catalog loader, or memory progress unless a focused compatibility/test need is documented and within existing contracts.

### Tests/docs

- `tests/run_all.gd`;
- focused files under `tests/gameplay/`, `tests/levels/`, or `tests/app/`;
- the two required validation records;
- `docs/reports/0007_REUSABLE_GAMEPLAY_AND_TUTORIAL_LEVELS_REPORT.md`;
- current startup/task/index/plan/handoff/project-memory documents as needed.

Do not modify `project.godot` unless a proven reusable-scene path requires a main-scene correction; AppRoot must remain the main scene. Any such change must be narrow and documented.

Do not modify any other path without stopping and requesting a new task.

## 12. Automated validation

Use repository-only GDScript tests. Do not install plugins, test frameworks, JSON-schema packages, or dependencies.

### 12.1 Baseline before edits

Require:

```text
TASK_0003_TESTS_PASS assertions=183 vectors=9
TASK_0006_APP_SHELL_TESTS_PASS
```

Also require unchanged:

- vertical slice `SOLVED`;
- `L*=9`;
- `N*=31 (EXACT)`;
- 1,318 visited states;
- Echo-isolated complete finite state unsolved with 1,006 states.

If baseline fails, stop with `BLOCKED_BASELINE_REGRESSION`.

### 12.2 Formal-level tests

For both tutorials:

- load through unchanged LevelLoader;
- assert normalized IDs and cardinalities;
- construct/restart state;
- solve with bounded BFS;
- replay solver witness through shared transition;
- assert exact completion depth equals reported `L*`;
- assert `N*` status semantics;
- record limits and resource summaries.

Tutorial 0 additionally verifies:

- history is `[]`;
- no Echo actions/controls/timeline are required;
- no Plate/Door state exists;
- player-only EXIT completion and restart.

Tutorial 1 additionally verifies:

- delay-3 history semantics;
- Echo/Plate/Door teaching trace;
- accepted next-turn Door entry timing;
- Echo necessity controlled variant;
- no player bypass and no Echo completion.

### 12.3 Catalog/progress/app tests

Verify:

- tracked three-entry catalog validates and normalizes in sequence;
- exactly one final entry, the vertical slice;
- all paths and formal IDs match;
- title-key/classification/HUD-mode/prerequisite facts match this task;
- initial unlock state contains only Tutorial 0;
- Tutorial 0 completion unlocks Tutorial 1 but not vertical slice;
- Tutorial 1 completion unlocks vertical slice;
- reset restores initial unlocks;
- each catalog ID routes to one reusable gameplay implementation with expected payload;
- invalid/locked IDs still reach Safe Error and construct no gameplay state;
- AppRoot still owns one active routed screen;
- development `--level-id` route accepts all three tracked IDs;
- direct accepted vertical-slice scene remains launchable with its default level.

### 12.4 Gameplay/HUD compatibility tests

Avoid pixel-perfect tests. Verify public state/snapshot behavior:

- Tutorial 0 runtime becomes ready with zero Echoes and zero Doors;
- Tutorial 0 HUD does not contain an Echo-next/history/door requirement or unsafe placeholder;
- Tutorial 0 completion emits correct level ID and logical turns;
- Tutorial 1 runtime exposes one Echo, Plate, Door, delay, and role-causality information;
- vertical slice retains accepted objective/entity/next-action/completion behavior;
- no collection access error occurs for empty or present entity arrays;
- all three scenes process bounded frames without parse/runtime errors.

### 12.5 Final markers

The final suite must retain:

```text
TASK_0003_TESTS_PASS assertions=<at least 183> vectors=9
TASK_0006_APP_SHELL_TESTS_PASS
```

and add:

```text
TASK_0007_TUTORIAL_LEVELS_TESTS_PASS
```

Any failure must exit non-zero.

## 13. Runtime and external evidence

This task authorizes creation/use of exactly:

```text
D:\Delayed_Self_Evidence\0007_tutorial_levels\
```

Check for safe non-conflicting use first. Do not delete, move, or overwrite unrelated evidence.

Required bounded evidence:

- baseline and final headless logs;
- solver/replay summaries for both tutorials;
- controlled Tutorial 1 Echo-necessity log;
- normal AppRoot launch log;
- development direct-level launch logs for Tutorial 0 and Tutorial 1;
- game-root-only 960×540 captures for Tutorial 0, Tutorial 1, and the unchanged vertical slice;
- Level Select captures before and after in-memory unlock progression where safely reproducible;
- evidence index with commands, timestamps, filenames, and hashes.

Do not stage screenshots, raw logs, `.godot/`, imports, or external evidence. Do not capture the whole desktop automatically.

## 14. Required report

Create:

```text
docs/reports/0007_REUSABLE_GAMEPLAY_AND_TUTORIAL_LEVELS_REPORT.md
```

The report must include:

- verdict;
- task path and Git start/final facts;
- chosen reusable-gameplay approach and responsibility boundaries;
- exact changed files;
- Tutorial 0 and Tutorial 1 formal summaries;
- exact solver/replay metrics and limits for both tutorials;
- Tutorial 1 necessity and bypass evidence;
- catalog/unlock chain;
- baseline and final markers/assertion counts;
- unchanged accepted vertical-slice metrics;
- external evidence index/path;
- protected surfaces not changed;
- explicit non-claims for fresh-player/tutorial acceptance, final progressive HUD, save, export, release, and submission;
- recommended next gate.

Recommended next gate after GPT acceptance:

```text
Task 0008 — progressive HUD modes and fresh-player Tutorial 0–1 review
```

Do not start Task 0008 from this report alone.

## 15. Validation and Git discipline

Before staging:

```powershell
git status --short --untracked-files=all
git diff --check
git diff --stat
```

Review for:

- only authorized paths;
- accepted vertical-slice formal JSON byte-for-byte unchanged;
- no simulation/schema/solver semantic change;
- no unsupported mechanics or fake entities;
- no per-level rule branches;
- no invented human acceptance or target metrics;
- catalog has exactly three implemented entries and one final flag;
- no filesystem persistence;
- no asset/plugin/export/build/release surface;
- no secrets or unrelated personal data;
- Markdown links resolve;
- current docs do not claim Task 0008/fresh-player acceptance.

Stage paths explicitly. Never use broad staging.

Then run:

```powershell
git diff --cached --check
git diff --cached --stat
git diff --cached --name-only
```

## 16. Commit and push authorization

This task authorizes one focused implementation/content/test/documentation commit on `main` and one normal push after all gates pass.

Required commit message:

```text
feat: add Delayed Self tutorial levels and reusable gameplay
```

Immediately before push:

```powershell
git fetch origin
git rev-parse HEAD
git rev-parse origin/main
git status --short --untracked-files=all
```

If remote moved after task start, stop. Do not merge, rebase, amend, force-push, overwrite, or create a second commit without new authorization.

## 17. Stop conditions

Stop with the most specific available verdict if:

- startup/root/Git/toolchain gate fails;
- baseline regression fails;
- Tutorial 0 or 1 requires unsupported mechanics/schema changes;
- a tutorial cannot be solved/replayed within bounded resources;
- Tutorial 1 Echo necessity cannot be evidenced;
- reusable gameplay requires duplicating transition rules or per-level scenes;
- zero-entity handling requires fake formal entities;
- accepted vertical-slice metrics or file content changes unexpectedly;
- catalog becomes partially publishable after an invalid entry;
- persistent storage becomes necessary;
- evidence path conflicts;
- remote drifts before push.

Do not weaken tests, fixtures, or contract rules to obtain a pass.

## 18. Terminal verdicts

Use exactly one:

- `PASS_FOR_GPT_REVIEW`
- `PASS_WITH_OBSERVATIONS_FOR_GPT_REVIEW`
- `BLOCKED_BASELINE_REGRESSION`
- `BLOCKED_TUTORIAL_REQUIRES_UNSUPPORTED_MECHANIC`
- `BLOCKED`

A passing implementation proves schema/solver/replay/internal-playability only. It does not prove fresh-player tutorial clarity or authorize Task 0008 automatically.
