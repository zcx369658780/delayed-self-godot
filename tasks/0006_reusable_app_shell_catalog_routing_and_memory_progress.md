# Task 0006 — Reusable app shell, level catalog, routing, and in-memory progress

- Status: `READY`
- Gate: `IMPLEMENTATION / APPLICATION SHELL`
- Repository: `zcx369658780/delayed-self-godot`
- Expected branch: `main`
- Expected local root: `D:\Delayed_Self`
- Issued by: GPT Project Sources advisor
- Date: 2026-07-14
- Prior accepted gate: `TASK_0005_SYSTEM_SKELETON_AND_TUTORIAL_PLANNING_ACCEPTED`
- Prior accepted planning commit: `0de8fa7435dc1024f35161d90cd03419a53730dd`
- Prior acceptance artifact: `docs/reports/0005_GPT_FINAL_ACCEPTANCE.md`
- Accepted repaired runtime: `caeff311fda77b0261a7d78672afb9244ff23549`

## 1. Objective

Implement the smallest reusable application shell around the accepted vertical slice without changing puzzle semantics.

The task must deliver:

1. a deterministic Boot/AppRoot entry point;
2. a minimal Main Menu;
3. a catalog-driven Level Select screen;
4. routing of the accepted `vertical_slice_delay_3` level by catalog ID into the existing gameplay scene;
5. a Safe Error screen for invalid route/catalog/level requests;
6. a strict, versioned, separate JSON catalog-v1 boundary;
7. an in-memory progress adapter with deterministic unlock/completion/best-turn behavior;
8. a development direct-level route by catalog ID;
9. automated catalog, route, progress, and app-scene tests while preserving all accepted simulation and solver evidence.

This is not the complete product flow. Do not implement Tutorial 0–1, Pause, Results, Final Completion, persistent saves, settings, credits polish, localization rollout, audio, export, Web, releases, or submission operations.

## 2. Success criteria

Task 0006 succeeds only when:

1. `project.godot` boots into the new app shell rather than directly into the vertical-slice scene;
2. Boot validates the complete catalog before constructing Main Menu or Level Select;
3. a valid catalog displays the accepted level as a selectable entry;
4. selecting the catalog ID launches the accepted vertical slice through one validated route payload;
5. the existing direct-development launch of the vertical-slice scene remains available through a documented test/development path;
6. an unknown route, unknown level ID, invalid catalog, missing level file, or formal `level_id` mismatch reaches Safe Error and constructs no gameplay state;
7. in-memory progress unlocks entries deterministically, records completion and best turns, and resets without filesystem writes;
8. all accepted 135 assertions, 9/9 normative vectors, `L*=9`, `N*=31 (EXACT)`, and echo-necessity evidence remain unchanged;
9. no persistent player data, export, build, asset, plugin, dependency, or new gameplay mechanic is introduced.

## 3. Mandatory startup gate

Before any write:

```powershell
Get-Location
git branch --show-current
git rev-parse HEAD
git rev-parse origin/main
git remote -v
git status --short --untracked-files=all
git log -12 --oneline --decorate
godot --version
```

Required conditions:

- absolute root is `D:\Delayed_Self`;
- branch is `main`;
- origin is the expected GitHub repository;
- local `HEAD` and `origin/main` contain this task and `docs/reports/0005_GPT_FINAL_ACCEPTANCE.md`;
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
5. `docs/reports/0005_GPT_FINAL_ACCEPTANCE.md`
6. `docs/architecture/SYSTEM_SKELETON_PLAN_CURRENT.md`
7. `docs/game_design/TUTORIAL_AND_HUD_PROGRESSION_PLAN_CURRENT.md`
8. `docs/level_design/INITIAL_LEVEL_ROADMAP_AND_VALIDATION_MATRIX_CURRENT.md`
9. `docs/version_plans/M2_SYSTEM_SKELETON_IMPLEMENTATION_PLAN.md`
10. `docs/reports/0004V_GPT_FINAL_ACCEPTANCE.md`
11. `docs/reports/0004R_GPT_FINAL_ACCEPTANCE.md`
12. `docs/game_design/GAMEPLAY_SIMULATION_CONTRACT_CURRENT.md`
13. `docs/level_design/LEVEL_SCHEMA_V1_CURRENT.md`
14. `schemas/level_v1.schema.json`
15. `data/levels/vertical_slice_delay_3.json`
16. `project.godot`
17. `scenes/vertical_slice/vertical_slice.tscn`
18. `scripts/gameplay/vertical_slice.gd`
19. `scripts/simulation/level_loader.gd`
20. `scripts/simulation/simulation.gd`
21. `scripts/solver/bfs_solver.gd`
22. `tests/run_all.gd`
23. `docs/project_rules/PROJECT_RULE_GODOT_SAFETY_AND_RELEASE_GATES_CURRENT.md`
24. `docs/project_rules/PROJECT_RULE_PUZZLE_VALIDATION_CURRENT.md`
25. current plan/index/handoff/memory documents.

Before writing, print a concise summary of:

- objective and success criteria;
- accepted planning decisions;
- catalog-v1 contract proposed below;
- implementation seams and temporary compatibility choices;
- exact allowed/protected surfaces;
- test and external-evidence plan;
- commit/push authorization;
- stop conditions.

## 5. Frozen inputs and protected authorities

Treat the following as immutable:

- Godot standard `4.7.stable`;
- GDScript;
- Compatibility renderer;
- 960×540 logical viewport;
- Windows x86_64 current target;
- accepted `simulation_v1` and `level_v1` semantics;
- action order `UP`, `RIGHT`, `DOWN`, `LEFT`, `WAIT`;
- current-player-only EXIT completion;
- accepted formal level `data/levels/vertical_slice_delay_3.json`;
- accepted reference vectors and canonical keys;
- accepted solver result `L*=9`, `N*=31 (EXACT)`;
- accepted echo-isolated unsolvability result;
- current input mapping and repaired gameplay readability behavior.

Do not modify:

- `scripts/simulation/level_loader.gd`;
- `scripts/simulation/simulation.gd`;
- `scripts/solver/bfs_solver.gd`;
- `data/levels/`;
- `schemas/level_v1.schema.json`;
- accepted transition fixtures/contracts;
- the canonical GDD or project rules;
- save/player-data paths;
- export presets, builds, releases, repository settings, or account surfaces.

If application-shell implementation appears to require changing puzzle semantics, level-v1 metadata, the accepted level, or the solver, stop with `BLOCKED_ARCHITECTURE_BOUNDARY` rather than weakening the boundary.

## 6. Catalog-v1 implementation contract

Create a separate formal product catalog, independent from `level_v1`.

### 6.1 Required files

```text
schemas/catalog_v1.schema.json
data/catalog/level_catalog_v1.json
docs/architecture/LEVEL_CATALOG_V1_CURRENT.md
```

The human contract and implementation must agree. Unknown fields are rejected.

### 6.2 Top-level shape

Use:

```json
{
  "catalog_version": 1,
  "entries": []
}
```

Top-level fields are exactly:

- `catalog_version`: integer constant `1`;
- `entries`: array with 1–64 entries.

### 6.3 Entry shape

Each entry must contain exactly:

- `level_id`: stable lower-snake-case ID matching the formal level ID;
- `level_path`: `res://` path to a formal level-v1 JSON under `data/levels/`;
- `sequence`: unique integer from 1–999;
- `display_title_key`: stable localization/product-title key;
- `classification`: `tutorial` or `standard`;
- `unlock_prerequisites`: unique array of catalog level IDs;
- `hud_mode`: `INTRO_MINIMAL`, `GUIDED_ECHO`, or `STANDARD_COMPACT`;
- `final_level`: boolean;
- optional `best_turn_threshold`: positive integer only when already supported by solver/human evidence.

The initial tracked catalog must contain exactly the accepted `vertical_slice_delay_3` entry. Do not add placeholder entries for uncreated tutorials or core levels. Omit `best_turn_threshold` unless the accepted evidence and task scope clearly justify it; target bands are not thresholds.

For the current one-entry development catalog, it is acceptable to mark the sole entry as `final_level=true`. This means only “last entry in the currently implemented catalog,” not final narrative or candidate completion evidence. Document this temporary interpretation.

### 6.4 Manual validator and cross-reference checks

A repository GDScript catalog loader/validator must reject and report stable error codes for at least:

- JSON parse failure;
- unknown top-level or entry field;
- unsupported catalog version;
- missing or wrong field type;
- invalid ID/key/path format;
- duplicate `level_id`;
- duplicate or non-contiguous `sequence`;
- unknown classification or HUD mode;
- duplicate prerequisite;
- self prerequisite;
- unknown prerequisite;
- prerequisite cycle;
- entry unreachable from a root entry;
- missing formal level file;
- formal level rejected by the accepted `LevelLoader`;
- catalog `level_id` not matching formal level `level_id`;
- zero or multiple `final_level=true` entries for the tracked runtime catalog.

Catalog validation must finish before Level Select construction. A failure creates no partial selectable menu and routes to Safe Error with a stable diagnostic code plus bounded human-readable context.

The validator may use the accepted `LevelLoader` as a dependency but must not duplicate or alter level-v1 validation.

### 6.5 Player-facing title during this gate

Localization implementation is not authorized. The catalog owns `display_title_key`; during Task 0006 the UI may use the validated formal level `title` as an explicitly documented development fallback. Do not create a hidden hard-coded title registry. A later localization task will resolve keys to Chinese-first strings.

## 7. Application-shell architecture

Names may vary narrowly for Godot conventions, but responsibility boundaries are mandatory.

### 7.1 App root and routes

Create a root scene and script under recommended paths such as:

```text
scenes/app/app_root.tscn
scripts/app/app_root.gd
```

The app root owns:

- catalog validation and normalized catalog state;
- one in-memory progress adapter;
- the current routed screen;
- route-payload validation;
- safe replacement of routed screens;
- development direct-level argument handling.

Required route identifiers for this gate:

- `BOOT`;
- `MAIN_MENU`;
- `LEVEL_SELECT`;
- `GAMEPLAY`;
- `SAFE_ERROR`.

Do not implement Pause, Results, Credits, Settings, Final Completion, or persistent Continue behavior in this task.

### 7.2 Main Menu

Create a minimal geometric/built-in-font menu with:

- `Play` or equivalent -> Level Select;
- `Quit` -> desktop, with no claim that final quit-confirmation UX exists;
- visible development-project title.

No Continue button is required because persistent progress is not implemented. Do not imply saved progress exists.

### 7.3 Level Select

The screen must:

- display entries sorted by catalog `sequence`;
- distinguish unlocked and locked entries;
- show prerequisite information for locked entries;
- emit a validated catalog `level_id` selection intent;
- use the formal title as temporary development fallback while retaining `display_title_key` in the normalized catalog;
- contain no per-level puzzle rule logic.

With the one-entry catalog, the accepted vertical slice is initially unlocked and selectable.

### 7.4 Gameplay route and temporary compatibility seam

Route `GAMEPLAY` with a validated payload containing at least:

- catalog `level_id`;
- validated formal `level_path`;
- catalog HUD mode;
- classification;
- development/final flags required by the shell.

Narrowly modify the existing vertical-slice gameplay surface only as needed to accept a configured `level_id`/`level_path` before `_ready`, while preserving the current formal level as the direct-launch default.

Acceptable temporary seam:

- instantiate the accepted vertical-slice scene;
- configure the validated catalog payload before adding it to the tree;
- let the existing gameplay controller load that formal path through the accepted `LevelLoader`;
- expose bounded signals such as completion and request-back only when necessary for app ownership.

Do not perform the full GameplayController/BoardView/HUD refactor planned for Task 0007. Do not create per-level scene branches or copy transition logic.

The accepted vertical-slice scene must still be directly launchable for development/test use with its existing default formal level.

### 7.5 Safe Error

Create a minimal Safe Error surface that displays:

- stable error code;
- bounded diagnostic context without secrets or raw dumps;
- action to return to Main Menu;
- optional retry only when the source action is safely repeatable.

No invalid catalog or route may silently fall back to the accepted level.

## 8. In-memory progress

Create a pure/ref-counted or otherwise isolated in-memory adapter under `scripts/app/`.

Required interface behavior:

```text
snapshot()
is_unlocked(level_id)
record_completion(level_id, turns)
reset_test_profile()
```

It must track at least:

- completed level IDs;
- best turns per completed level;
- deterministic unlock facts derived from catalog prerequisites;
- no filesystem path or persistence.

Rules:

- root entries with no prerequisites are unlocked initially;
- an entry unlocks when every prerequisite is completed;
- completion is idempotent;
- best turns retain the lower positive turn count;
- unknown IDs and invalid turn values fail safely;
- `reset_test_profile()` returns deterministic initial state;
- progress does not decide puzzle completion and never calls `Simulation.transition`.

The shell may record completion when the hosted accepted gameplay scene emits a completion event. No Results screen is required in this gate; returning to Level Select may expose the updated in-memory state.

Do not create `user://` files, registry entries, settings files, test profiles on disk, migration code, backup files, or deletion behavior.

## 9. Development direct-level route

Implement and document one bounded development-only route using a user argument such as:

```text
--level-id=vertical_slice_delay_3
```

Requirements:

- parse only user arguments, not unrelated engine arguments;
- validate the ID through the catalog;
- valid ID may boot directly into Gameplay;
- unknown ID routes to Safe Error;
- no direct filesystem path supplied by the user bypasses catalog validation;
- no production/candidate UX claim is made for this developer path.

The exact parser can be a pure helper so tests do not need to mutate process arguments.

## 10. Authorized repository changes

May create or modify only the following categories:

### Root/project

- `project.godot` only to change the main scene to the app shell and register no more input actions than already accepted;

### New catalog/app surfaces

- `schemas/catalog_v1.schema.json`;
- `data/catalog/level_catalog_v1.json`;
- `docs/architecture/LEVEL_CATALOG_V1_CURRENT.md`;
- files under `scripts/app/`;
- files under `scenes/app/`;
- files under `scenes/ui/`;

### Narrow existing gameplay compatibility

- `scripts/gameplay/vertical_slice.gd`;
- `scenes/vertical_slice/vertical_slice.tscn` only if required for route payload/signals and with no visual or semantic regression;

### Tests/docs

- `tests/run_all.gd` and narrowly scoped new repository-only test files under `tests/app/` if useful;
- `docs/reports/0006_REUSABLE_APP_SHELL_CATALOG_AND_MEMORY_PROGRESS_REPORT.md`;
- current startup/task/index/plan/handoff/project-memory documents as needed.

Do not modify any other path without stopping and requesting a new task.

## 11. Automated validation

Use repository-only GDScript tests. Do not install GUT, gdUnit, gdtoolkit, JSON-schema packages, plugins, or other dependencies.

### 11.1 Baseline before edits

Run the accepted suite and require:

```text
TASK_0003_TESTS_PASS assertions=135 vectors=9
```

Record unchanged solver and mechanic summaries:

- `SOLVED`;
- `L*=9`;
- `N*=31 (EXACT)`;
- 1,318 visited states;
- echo-isolated variant `UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE`, 1,006 visited states.

If baseline fails, stop before implementation with `BLOCKED_BASELINE_REGRESSION`.

### 11.2 Catalog tests

At minimum cover:

- tracked catalog valid and normalized;
- unknown top-level field;
- unknown entry field;
- unsupported version;
- missing/wrong field types;
- invalid IDs, title keys, and paths;
- duplicate IDs;
- duplicate/non-contiguous sequence;
- unknown classification/HUD mode;
- duplicate/self/unknown prerequisite;
- prerequisite cycle and unreachable entry;
- missing formal level path;
- invalid formal level;
- catalog/formal `level_id` mismatch;
- zero and multiple final entries;
- no partial entry list returned after validation failure.

Synthetic invalid dictionaries/files should be generated in memory or a repository-safe test fixture strategy; do not clutter `data/catalog/` with invalid production files.

### 11.3 Progress tests

Use a synthetic valid normalized catalog with multiple prerequisite relationships and verify:

- roots unlocked initially;
- dependent entries locked initially;
- completion unlocks expected entries only;
- multi-prerequisite entries require all facts;
- repeated completion is idempotent;
- best turns retain the minimum;
- invalid IDs/turns fail safely;
- reset is deterministic;
- no filesystem write occurs.

### 11.4 Routing and app tests

At minimum verify:

- app root scene instantiates and processes frames;
- valid catalog boots to Main Menu;
- Main Menu intent routes to Level Select;
- valid selected catalog ID routes to Gameplay with the expected normalized payload;
- gameplay scene loads the accepted formal level through the payload;
- the existing direct vertical-slice scene still instantiates with its default path;
- unknown route and unknown level ID route to Safe Error;
- invalid catalog boots only Safe Error and no menu/gameplay state;
- development `--level-id` parser accepts the tracked ID and rejects unknown IDs;
- completion event can update in-memory progress without persistence;
- route replacements leave only one active routed screen.

Avoid pixel-perfect assertions. Test explicit state, labels, route IDs, payloads, and runtime readiness.

### 11.5 Final markers

The final test run must retain the accepted marker and add a stable shell marker, for example:

```text
TASK_0003_TESTS_PASS assertions=<at least 135> vectors=9
TASK_0006_APP_SHELL_TESTS_PASS
```

A non-zero exit is required on any failure.

## 12. Runtime and external evidence

This task authorizes creation/use of exactly:

```text
D:\Delayed_Self_Evidence\0006_app_shell_catalog\
```

Check for safe, non-conflicting use before writing. Do not delete, move, or overwrite unrelated evidence.

Required bounded evidence:

- baseline and final headless test logs;
- valid app-shell window launch log;
- game-window-only screenshots or root-viewport captures for Main Menu, Level Select, accepted Gameplay route, and Safe Error;
- an evidence index with commit, commands, timestamps, filenames, and hashes where useful.

Do not stage screenshots, raw logs, `.godot/`, imports, or external evidence.

If safe capture is unavailable, record the limitation and use bounded launch/state evidence; do not capture the full desktop automatically.

## 13. Required report

Create:

```text
docs/reports/0006_REUSABLE_APP_SHELL_CATALOG_AND_MEMORY_PROGRESS_REPORT.md
```

The report must include:

- verdict;
- task path;
- start/final HEAD and origin;
- changed files and responsibilities;
- catalog-v1 shape and stable error codes;
- application routes implemented;
- temporary vertical-slice compatibility seam;
- in-memory progress behavior;
- baseline/final assertion, vector, solver, and necessity summaries;
- app/catalog/progress test counts and pass markers;
- runtime/evidence index;
- protected surfaces not changed;
- known limitations and explicit non-claims;
- recommended next gate: Task 0007 only after GPT acceptance.

Do not claim Tutorial 0–1, reusable final gameplay architecture, persistent progress, complete flow, export, or candidate readiness.

## 14. Validation and Git discipline

Before staging:

```powershell
git status --short --untracked-files=all
git diff --check
git diff --stat
```

Review all changes for:

- catalog and formal level authorities remain separated;
- no puzzle-rule duplication in app/menu/catalog/progress code;
- no partial menu/gameplay on invalid data;
- no persistent writes;
- no hard-coded hidden level registry beyond explicit scene factories/routing needed by this bounded gate;
- no invented tutorial entries or uncreated level paths;
- no third-party content or generated evidence staged;
- existing accepted direct scene and test behavior preserved;
- no release/readiness overclaim;
- current links resolve;
- no secrets or unrelated personal data.

Stage authorized paths explicitly. Never use `git add .` or `git add -A`.

Then run:

```powershell
git diff --cached --check
git diff --cached --stat
git diff --cached --name-only
```

## 15. Commit and push authorization

This task authorizes one focused implementation/documentation commit on `main` and one normal push to `origin/main` after all gates pass.

Required commit message:

```text
feat: add Delayed Self app shell and level catalog
```

Immediately before push:

```powershell
git fetch origin
git rev-parse HEAD
git rev-parse origin/main
git status --short --untracked-files=all
```

If `origin/main` moved after task start, stop. Do not merge, rebase, amend, force-push, overwrite, or create a second commit without new authorization.

## 16. Stop conditions

Stop with `BLOCKED` if:

- startup/root/Git/toolchain gate fails;
- accepted baseline regression fails;
- catalog needs `level_v1` pollution or schema change;
- routing requires copied simulation rules;
- invalid catalog cannot prevent partial menu/gameplay state;
- in-memory progress appears to require persistence;
- current formal level or solver result would change;
- evidence path conflicts;
- unauthorized paths become necessary;
- remote drifts before push.

Do not weaken tests, fixtures, catalog validation, or protected boundaries to obtain a pass.

## 17. Terminal verdicts

Use exactly one:

- `PASS_FOR_GPT_REVIEW`
- `PASS_WITH_OBSERVATIONS_FOR_GPT_REVIEW`
- `BLOCKED_BASELINE_REGRESSION`
- `BLOCKED_ARCHITECTURE_BOUNDARY`
- `BLOCKED`

A passing Task 0006 does not authorize Task 0007 automatically. The recommended next gate after GPT acceptance is:

```text
Task 0007 — reusable gameplay loading and Tutorial 0–1 formal levels
```
