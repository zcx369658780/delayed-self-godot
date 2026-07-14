# Task 0003 — Minimal Godot vertical slice and contract conformance

- Status: `READY`
- Gate: `IMPLEMENTATION / MINIMAL VERTICAL SLICE`
- Repository: `zcx369658780/delayed-self-godot`
- Expected branch: `main`
- Expected local root: `D:\Delayed_Self`
- Issued by: GPT Project Sources advisor
- Date: 2026-07-14
- Prior accepted gate: `TASK_0002_SIMULATION_AND_SCHEMA_CONTRACT_ACCEPTED_WITH_OBSERVATION`
- Prior accepted implementation commit: `f390f5a4ced31252f8804fba99da1226c9f64be4`
- Prior acceptance artifact: `docs/reports/0002_GPT_FINAL_ACCEPTANCE.md`

## 1. Objective

Create the first runnable Godot vertical slice for **Delayed Self** and demonstrate that its GDScript level loader, simulation transition, canonical-state serializer, replay path, and bounded BFS solver conform to the accepted `simulation_v1` / `level_v1` contract.

The delivered slice must be a small, data-driven, keyboard-playable puzzle in which a delay-3 echo is required to operate a pressure plate so the current player can pass a door and reach the exit. The presentation may use only original geometric/code-drawn placeholders and Godot's built-in font.

This gate is successful only when:

1. all nine accepted reference transition vectors execute in Godot and match exactly;
2. the GDScript loader enforces the schema-v1 shape and cross-field boundary used by the slice;
3. the same transition implementation is used by gameplay, replay, tests, and solver;
4. the BFS solver finds and replays a shortest solution for the vertical-slice level;
5. the project launches locally without runtime errors and accepts keyboard input;
6. restart reconstructs the exact initial state;
7. no post-v1 mechanic or protected release surface is introduced.

## 2. Mandatory startup gate

Before any write:

```powershell
Get-Location
git branch --show-current
git rev-parse HEAD
git rev-parse origin/main
git remote -v
git status --short --untracked-files=all
git log -8 --oneline --decorate
```

Required conditions:

- absolute root is `D:\Delayed_Self`;
- branch is `main`;
- origin is the expected GitHub repository;
- local `HEAD` and `origin/main` contain this task and `docs/reports/0002_GPT_FINAL_ACCEPTANCE.md`;
- tracked worktree is clean before implementation;
- installed Godot resolves to the accepted standard 4.7 stable candidate.

If local is behind and clean, use only:

```powershell
git fetch origin
git merge --ff-only origin/main
```

Stop on divergence, conflict, remote mismatch, unexpected tracked changes, unsafe local root, inability to obtain this task by fast-forward, or a materially different Godot version/toolchain.

## 3. Required reads

Read in this order:

1. `AGENTS.md`
2. `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`
3. `docs/CODEX_ACTIVE_TASK_CURRENT.md`
4. this task file
5. `docs/reports/0002_GPT_FINAL_ACCEPTANCE.md`
6. `docs/game_design/GAMEPLAY_SIMULATION_CONTRACT_CURRENT.md`
7. `docs/level_design/LEVEL_SCHEMA_V1_CURRENT.md`
8. `schemas/level_v1.schema.json`
9. `docs/level_design/REFERENCE_TRANSITION_VECTORS_V1.md`
10. `docs/level_design/reference/turn_transition_vectors_v1.json`
11. `docs/level_design/examples/level_v1_minimal_valid.json`
12. `docs/game_design/DELAYED_SELF_GAME_DESIGN_DOCUMENT_CURRENT.md`
13. `docs/environment/DEVELOPMENT_ENVIRONMENT_CURRENT.md`
14. `docs/project_rules/PROJECT_RULE_PUZZLE_VALIDATION_CURRENT.md`
15. `docs/project_rules/PROJECT_RULE_GODOT_SAFETY_AND_RELEASE_GATES_CURRENT.md`
16. `docs/project_rules/PROJECT_RULE_EVIDENCE_AND_INDEPENDENT_REVIEW_CURRENT.md`
17. `docs/DEVELOPMENT_PLAN_CURRENT.md`
18. `docs/HANDOFF_MASTER_CURRENT.md`
19. `docs/project_memory.md`

Before writing, print a concise pre-implementation summary containing:

- objective and success criteria;
- accepted contract authority;
- exact implementation scope;
- non-goals and protected surfaces;
- planned paths/modules;
- test and evidence plan;
- external evidence-directory policy;
- commit/push authorization;
- stop conditions.

## 4. Frozen inputs and task-scoped decisions

Treat these as fixed:

- engine: standard Godot `4.7.stable`; observed build `4.7.stable.steam.5b4e0cb0f`;
- language: GDScript only; no .NET/C# or GDExtension;
- renderer: Compatibility;
- committed vertical-slice platform: local Windows desktop x86_64;
- Web work: deferred;
- gameplay authority: accepted `simulation_v1`, `level_v1`, JSON Schema, and normative transition vectors;
- action set/order: `UP`, `RIGHT`, `DOWN`, `LEFT`, `WAIT`;
- input mapping: arrows and WASD for cardinal movement, `Space` for `WAIT`, `R` for restart, `Esc` for quit in the slice;
- task-scoped logical viewport: `960 × 540`, 16:9, `canvas_items` stretch with aspect kept;
- visual direction for this gate: original geometric/code-drawn placeholder presentation only; this does not freeze final art style;
- no third-party art, font, music, sound, plugin, library, or package;
- accepted external evidence root: `D:\Delayed_Self_Evidence`.

Task 0003 authorizes creation of exactly:

```text
D:\Delayed_Self_Evidence\0003_vertical_slice\
```

only after checking that any existing path is a directory and can be used without deleting, moving, or overwriting unrelated files. Use task-specific filenames. If the path exists with conflicting task evidence, stop rather than cleaning it. Evidence files are not staged.

Do not alter the accepted contract to fit an implementation. If a contradiction prevents implementation, stop with `BLOCKED_CONTRACT_CONTRADICTION` and document the exact conflict.

## 5. Required implementation architecture

Names may vary narrowly when Godot conventions require it, but the responsibility boundaries are mandatory.

### 5.1 Project initialization

Create `project.godot` with:

- project name `Delayed Self`;
- Compatibility renderer;
- main scene pointing to the vertical-slice scene;
- viewport `960 × 540`;
- stretch mode `canvas_items`, aspect `keep`;
- the frozen keyboard input actions;
- no autoload unless a narrow implementation need is documented;
- no external plugin or asset dependency.

Opening/running the project may create ignored `.godot/` state. Do not stage it.

### 5.2 Pure logical layer

Create pure/ref-counted GDScript modules for:

- level parsing and schema-v1 validation;
- cross-field validation and stable validation codes;
- immutable normalized level definition;
- initial/restart state construction;
- `simulation_v1` transition;
- canonical state-key serialization;
- replay of an action array;
- bounded BFS solver and shortest-solution counting/status;
- optional trace events needed for tests and rendering, without changing state semantics.

The logical layer must not depend on scene nodes, animation, audio, frame time, input devices, or rendered coordinates.

### 5.3 Single transition authority

Gameplay, tests, replay, and BFS must call one transition implementation. Do not copy movement, history, plate, door, completion, or canonical-key logic into the scene/controller or solver.

### 5.4 Loader boundary

The GDScript loader must reject unknown fields and enforce all documented shape and cross-field checks required by `LEVEL_SCHEMA_V1_CURRENT.md`, including:

- required top-level/entity fields and supported types;
- schema version;
- bounded rectangular terrain/alphabet;
- coordinate bounds and floor placement;
- ID format and uniqueness;
- static-position overlap rules;
- actor spawn exclusions;
- door plate-reference existence/uniqueness;
- initial combinational door consistency;
- zero-echo tutorial flag policy;
- bounded delays and entity counts.

A full external JSON Schema engine is not required and must not be installed. The manual validator must return `INVALID_LEVEL` plus stable codes consistent with the accepted contract.

### 5.5 Vertical-slice level

Create one formal level-v1 JSON under `data/levels/` with:

- one current player;
- one echo with delay `3`, preferably sharing the player spawn unless a documented reason requires otherwise;
- at least one pressure plate;
- one combinational door separating the player from the exit;
- one exit;
- a layout that cannot be completed without delayed-echo cooperation;
- no unsupported metadata mechanics;
- a bounded recommended search depth.

Recommended topology:

```text
#########
#...D..E#
#P.A#...#
#########
```

The actual JSON terrain must use only `#` and `.`, with player/echo/plate/door/exit stored as overlays. Codex may make a narrowly different level only if automated evidence proves the same teaching goal.

The solver evidence must establish:

- status `SOLVED`;
- exact shortest length `L*`;
- exact or explicitly capped shortest-solution count `N*`;
- one replayable shortest action sequence;
- replay reaches `completed=true`;
- at least one transition in the accepted solution enters/passes the door using a start-of-turn open state caused by echo plate occupancy while the player is not occupying that plate;
- no solution exists in a controlled validation variant with the echo removed or disabled, unless that variant is invalid by policy—in that case use an equivalent bounded mechanic-necessity check and explain it.

The mechanic-necessity check is validation evidence only; do not add a non-schema field to the formal level.

### 5.6 Play scene

Create one small scene that visibly presents:

- walls/floor grid;
- current player;
- delayed echo with clearly different appearance;
- pressure plate state;
- open/closed door state;
- exit;
- current turn index;
- delay value;
- history queue oldest-to-newest;
- concise controls/instruction text;
- completion state and restart prompt.

Use code-drawn geometry, Godot primitives, theme overrides, and built-in font only. No external assets.

Logical state commits before presentation updates. Any tween/animation is optional and purely visual; input may be briefly locked during presentation, but animation cannot decide movement or transition order.

### 5.7 Restart and error display

`R` must reconstruct the exact initial state through the accepted restart constructor. Invalid level loading must fail safely with a concise visible/logged diagnostic rather than producing a partial game state.

## 6. Required automated conformance tests

Create a Godot headless test runner using repository GDScript only. Do not install GUT, gdUnit, gdtoolkit, or any package.

The runner must return a non-zero exit code on failure and print a stable final marker such as:

```text
TASK_0003_TESTS_PASS
```

### 6.1 Normative vector suite

Load and execute all nine entries from:

```text
docs/level_design/reference/turn_transition_vectors_v1.json
```

For each vector, compare all specified outputs exactly, including where applicable:

- resolved actor actions;
- player and echo positions;
- pressed plate IDs;
- door states;
- history;
- turn index;
- completion;
- exact compact canonical key;
- restart behavior.

Do not rewrite expected fixtures to match implementation.

### 6.2 Loader validation suite

At minimum test:

- the accepted minimal valid example;
- the new vertical-slice level;
- unknown field rejection;
- unsupported schema version;
- ragged terrain;
- out-of-bounds coordinate;
- non-floor placement;
- duplicate ID;
- static overlap;
- spawn on door/exit;
- unknown plate reference;
- duplicate plate reference;
- initial door mismatch;
- zero echo without explicit tutorial flag.

Tests may build invalid dictionaries in memory; do not clutter the repository with many invalid JSON files unless clearly justified.

### 6.3 Determinism and restart

- Run the same valid action sequence from the same restart state at least twice and compare each canonical key.
- Verify blocked cardinal input remains in history.
- Verify restart discards all prior positions/history/door/completion state.
- Verify completed states return `TERMINAL_STATE` without mutation.
- Verify invalid actions return `INVALID_ACTION` without mutation.

### 6.4 Solver and replay

- Solve the vertical-slice level using bounded BFS and the shared transition.
- Record configured depth/state/time/solution-count limits.
- Replay the returned shortest solution through the shared transition.
- Assert the replay reaches completion in exactly `L*` turns.
- Assert result status/count status semantics match the accepted contract.
- Assert the delayed echo is mechanically necessary as specified above.

### 6.5 Scene smoke

The test harness must load/instantiate the main vertical-slice scene and process at least one frame without parse/runtime errors. It should verify that required logical/HUD responsibilities are connected, without relying on screenshot pixels.

## 7. Runtime checks and evidence

Use the accepted Godot executable/alias and bounded commands. Expected forms may include:

```powershell
godot --version
godot --headless --path . --script res://tests/run_all.gd
godot --headless --path . --quit-after 3
```

Exact syntax may be adjusted for Godot 4.7, but record it.

Also perform one bounded local windowed game launch if safe. A successful timed launch is runtime-start evidence, not visual acceptance. Do not leave the editor or game process running.

Write concise evidence under the authorized task evidence directory, such as:

- test stdout/stderr log;
- runtime-launch log;
- solver result JSON or text;
- optional screenshot only if generated safely without adding production-only screenshot behavior.

Record file hashes in the repository report. Do not commit raw logs, screenshots, `.godot/`, or builds.

If windowed launch cannot be observed reliably, record that limitation; do not fabricate visual evidence. Headless conformance remains mandatory.

## 8. Authorized repository paths

Create or modify only:

```text
project.godot
scripts/simulation/**
scripts/solver/**
scripts/gameplay/**
scenes/vertical_slice/**
data/levels/**
tests/**
docs/reports/0003_MINIMAL_GODOT_VERTICAL_SLICE_AND_CONTRACT_CONFORMANCE_REPORT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
```

A narrow `scripts/common/**` path is allowed only if required to avoid circular duplication and is explained in the report.

Do not modify:

- `AGENTS.md`;
- `.gitignore`;
- `README.md`;
- accepted Task 0002 contract/schema/vector files;
- canonical GDD;
- environment record;
- rule files;
- prior task/acceptance/report files;
- license/attribution documents;
- any GitHub workflow;
- any export preset.

If a required change falls outside authorized paths, stop and request a new task rather than expanding scope.

## 9. Non-goals and protected surfaces

Do not:

- implement synchronization targets, `INTERACT`, push mechanics, hazards, failure/death, anchors, latches, toggles, timers, enemies, combat, collectibles, story fragments, multiple levels, menus, settings, save data, undo, controller support, audio, particles, shaders, or final art;
- install/download Godot, export templates, plugins, packages, validators, fonts, audio, art, or testing tools;
- use C#, .NET, native extensions, or external services;
- create `export_presets.cfg`;
- export a Windows or Web build;
- change renderer, engine line, viewport, schema, or contract;
- access or alter accounts, repository settings, releases, tags, Pages, submission sites, credentials, or secrets;
- publish or upload anything;
- write outside the repository except the exact authorized evidence directory;
- delete, move, or clean user files or existing evidence;
- claim visual polish, performance, export readiness, release readiness, or game-festival submission readiness.

## 10. Subagent policy

Configured subagents may be used within their roles:

- `code_mapper`: inspect planned module boundaries and references;
- `impl_worker`: implement a narrow delegated module without commit/push;
- `code_reviewer`: review the final diff for contract drift, duplicated logic, missing tests, Godot errors, and protected-surface violations;
- `docs_writer`: draft only the execution report/current-doc updates.

The main thread owns contract interpretation, integration, test execution, explicit staging, commit, push, and verdict. Subagents may not commit, push, install, publish, access secrets, change the task, or modify protected files. If unavailable, continue in the main thread and record the fallback. Do not fabricate review results.

## 11. Validation before commit

Run at minimum:

```powershell
git status --short --untracked-files=all
git diff --check
git diff --stat
```

Then verify:

- Godot project parses under the accepted 4.7 stable executable;
- Compatibility renderer is configured;
- all automated tests pass with the stable marker;
- all nine normative vectors executed in Godot;
- loader validation suite passes;
- solver result and shortest replay pass;
- mechanic-necessity assertion passes;
- main scene instantiates without runtime errors;
- restart is exact;
- no unsupported mechanic or external asset exists;
- no `.godot/` or evidence file is staged;
- accepted contract/schema/vector/GDD files are unchanged;
- current docs distinguish implemented/tested facts from unverified visual/export claims;
- Markdown links resolve;
- no secret-like values or unrelated personal data are present.

Explicitly stage only authorized paths. Never use broad staging.

Then run:

```powershell
git diff --cached --check
git diff --cached --stat
git diff --cached --name-only
```

Review the staged diff, preferably with `code_reviewer` or an equivalent bounded main-thread review.

## 12. Commit and push authorization

This task authorizes one implementation commit on `main` and one normal push to `origin/main` only if all mandatory conformance tests pass.

Required commit message:

```text
feat: add Delayed Self minimal vertical slice
```

Immediately before push:

```powershell
git fetch origin
git rev-parse HEAD
git rev-parse origin/main
git status --short --untracked-files=all
```

If `origin/main` moved after implementation began, stop. Do not merge, rebase, amend, force-push, overwrite, or create a second commit without a new instruction.

## 13. Required report

Create:

```text
docs/reports/0003_MINIMAL_GODOT_VERTICAL_SLICE_AND_CONTRACT_CONFORMANCE_REPORT.md
```

Include:

- verdict;
- task path;
- branch, start/final HEAD and origin;
- Godot executable/version and renderer;
- created/modified files by responsibility;
- architecture summary;
- loader validation coverage;
- normative-vector results, all nine named;
- solver limits, status, `L*`, `N*`, count status, visited states, maximum frontier, solution sequence;
- mechanic-necessity evidence;
- replay and determinism evidence;
- scene/headless/windowed launch checks;
- evidence directory and hashes;
- tests/commands and results;
- subagent usage and review result;
- protected surfaces not touched;
- limitations and unverified claims;
- final Git status;
- recommended next gate.

## 14. Stop conditions

Stop with `BLOCKED` and do not commit if:

- startup/root/Git gate fails;
- remote or Godot version/toolchain differs materially;
- accepted contract/schema/vectors conflict in a way that requires reinterpretation;
- the implementation cannot execute all nine vectors exactly;
- loader checks require an external dependency;
- solver/runtime would need separate transition logic;
- the level is solvable without delayed-echo cooperation;
- mandatory tests fail or are skipped;
- Godot creates unexpected tracked/generated files outside authorized paths;
- runtime errors remain;
- evidence creation would overwrite existing data;
- remote drifts before push;
- required work expands into exports, saves, assets, plugins, menus, or post-v1 mechanics.

Do not weaken expected fixtures, tests, or the level to manufacture a pass.

## 15. Terminal verdicts

Use exactly one:

- `PASS_FOR_GPT_REVIEW`
- `PASS_WITH_OBSERVATIONS_FOR_GPT_REVIEW`
- `BLOCKED`

Codex must not use `FINAL_ACCEPTED`.

## 16. Next gate recommendation

After completion, recommend one of:

- Task 0003R — narrow conformance/runtime repair;
- Task 0004 — first-player UX, visual readability, and manual vertical-slice review;
- Task 0004E — separately authorized Windows debug-export smoke gate, only if runtime conformance is accepted;
- Task 0004P — data-driven level pipeline and additional validated tutorial level, only if the vertical slice is accepted.

Do not begin any next gate from this task alone.