# Task 0002 — Deterministic gameplay simulation and level-schema contract

- Status: `READY`
- Gate: `DESIGN CONTRACT / DOCS-AND-SCHEMA ONLY`
- Repository: `zcx369658780/delayed-self-godot`
- Expected branch: `main`
- Expected local root: `D:\Delayed_Self`
- Issued by: GPT Project Sources advisor
- Date: 2026-07-14
- Prior accepted gate: `TASK_0001_ENVIRONMENT_INVENTORY_ACCEPTED`
- Prior accepted implementation commit: `227ea8b86de1699d540113f0a3052214cc294beb`
- Prior acceptance artifact: `docs/reports/0001_GPT_FINAL_ACCEPTANCE.md`

## 1. Objective

Freeze an implementation-ready, deterministic contract for the first playable delayed-echo puzzle loop and its level-data format before any Godot project or gameplay code exists.

The contract must be precise enough that:

1. a future GDScript runtime and a future solver can independently implement the same state transition;
2. AI-generated levels can be expressed in a bounded machine-readable format;
3. reference transition vectors can detect semantic drift;
4. shortest-path search can deduplicate states correctly;
5. Task 0003 can implement one vertical slice without inventing core rules.

This is a specification gate. It does not authorize `project.godot`, GDScript, scenes, runtime assets, editor launch, imports, plugins, dependencies, external evidence-directory creation, builds, exports, or gameplay execution.

## 2. Mandatory startup gate

Before any write:

```powershell
Get-Location
git branch --show-current
git rev-parse HEAD
git rev-parse origin/main
git remote -v
git status --short --untracked-files=all
git log -7 --oneline --decorate
```

Required conditions:

- absolute root is `D:\Delayed_Self`;
- branch is `main`;
- origin is the expected repository;
- local `HEAD` and `origin/main` contain this task and `docs/reports/0001_GPT_FINAL_ACCEPTANCE.md`;
- tracked worktree is clean.

If local is behind and clean, use only:

```powershell
git fetch origin
git merge --ff-only origin/main
```

Stop on divergence, conflict, remote mismatch, unexpected tracked changes, unsafe root, or inability to obtain this task by fast-forward.

## 3. Required reads

Read in this order:

1. `AGENTS.md`
2. `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`
3. `docs/CODEX_ACTIVE_TASK_CURRENT.md`
4. this task
5. `docs/reports/0001_GPT_FINAL_ACCEPTANCE.md`
6. `docs/environment/DEVELOPMENT_ENVIRONMENT_CURRENT.md`
7. `docs/game_design/DELAYED_SELF_GAME_DESIGN_DOCUMENT_CURRENT.md`
8. `docs/project_rules/PROJECT_RULE_PUZZLE_VALIDATION_CURRENT.md`
9. `docs/project_rules/PROJECT_RULE_GODOT_SAFETY_AND_RELEASE_GATES_CURRENT.md`
10. `docs/DOC_INDEX_CURRENT.md`
11. `docs/DEVELOPMENT_PLAN_CURRENT.md`
12. `docs/HANDOFF_MASTER_CURRENT.md`
13. `docs/project_memory.md`

Before drafting, print a concise summary of objective, frozen inputs, unresolved choices, allowed paths, non-goals, validation plan, commit/push authorization, and stop conditions.

## 4. Frozen project inputs

Treat the following as accepted decisions, not recommendations:

- engine line: standard Godot `4.7.stable`; observed build `4.7.stable.steam.5b4e0cb0f`;
- language: GDScript, not .NET;
- renderer: Compatibility;
- vertical-slice committed platform: Windows desktop x86_64;
- Web: deferred to a later compatibility gate;
- approved external evidence root: `D:\Delayed_Self_Evidence`, not yet authorized for creation.

Do not change these decisions in this task.

## 5. Contract decisions to materialize

The canonical contract must implement the following semantics unless a direct contradiction is found in a higher-priority source. If a contradiction exists, stop and report rather than silently changing these rules.

### 5.1 Coordinate and action model

- Grid origin is top-left `(0, 0)`.
- `x` increases right; `y` increases down.
- Base actions are exactly: `UP`, `RIGHT`, `DOWN`, `LEFT`, `WAIT`.
- Deterministic solver expansion order is exactly the action order above.
- `INTERACT`, push, combat, enemies, hazards, anchors, teleporters, latches, one-way tiles, and real-time actions are outside schema version 1.

### 5.2 Turn indexing and history

- Initial state is `S_1`, immediately before the player's first input.
- On turn `t`, the player supplies `u_t`.
- An echo with delay `d` executes `u_(t-d)`.
- If `t-d <= 0`, the echo executes `WAIT`.
- Therefore an action issued on turn 1 is first replayed by a delay-3 echo on turn 4.
- Runtime state keeps only the last `max_delay` player actions, left-padded with `WAIT`; older actions are irrelevant to future transitions.
- A cardinal action blocked by a wall, closed door, or boundary still consumes the turn and is recorded in history. It is not converted to `WAIT`.

### 5.3 Movement and overlap

- At the start of each turn, capture one traversability snapshot using the current door states.
- Determine the player action and every echo action from the same start state.
- Compute each actor's proposed destination independently against that snapshot.
- Apply all actor positions simultaneously.
- Actors do not block one another and may share a tile.
- A blocked actor remains in place, but its action is still considered executed.
- Visual animation may be sequential for readability, but it must present the already-resolved logical result and cannot alter it.

### 5.4 Plates and doors

- After simultaneous movement, evaluate pressure-plate occupancy from all actors.
- A plate is pressed when the player or any echo occupies its tile.
- Schema v1 doors use only `open_when_all_pressed`: every referenced plate must be pressed.
- Compute and commit door states after plate evaluation.
- The committed door states are visible in `S_(t+1)` and affect movement beginning on the next turn; a newly opened door cannot be traversed during the same turn that activated its plate.
- A door may close while an actor occupies the door tile. The actor is not harmed and may leave; a closed door only blocks entry into its tile.
- Door/plate logic is combinational in schema v1; no toggle, memory, latch, or timer.

### 5.5 Completion and reset

- The current player alone triggers the exit; echoes cannot complete the level.
- Success is evaluated after movement and environment-state commit.
- Reaching the exit succeeds if the player occupies the exit tile and the level has no other schema-v1 goal predicate.
- Restart restores the exact declared initial state: positions, initial door states, `WAIT`-padded history, turn index, and completion flag.
- Undo is not part of schema v1 and remains a later product decision.

### 5.6 State-transition phase order

Document one normative phase list equivalent to:

```text
0. validate input action
1. read start-of-turn state and current door snapshot
2. resolve player and echo actions from history
3. compute independent proposed destinations
4. apply all actor positions simultaneously
5. evaluate pressure plates
6. compute and commit next door states
7. evaluate player exit success
8. shift history and append current player action
9. increment turn and emit S_(t+1)
```

Define error behavior for malformed input or invalid level data separately from normal blocked movement.

## 6. State and canonical key contract

Define the minimum logical state needed by runtime and solver. It must include at least:

- player position;
- echo positions ordered by stable echo ID;
- current door states ordered by stable door ID;
- fixed-length history queue of length `max_delay`;
- completion flag when relevant.

The solver canonical key must exclude presentation state, animation progress, audio state, wall-clock time, and absolute turn count unless a future bounded-turn goal explicitly requires turn count. This prevents identical logical loops from becoming infinitely distinct.

Clarify:

- which level data is immutable and excluded from each state key;
- why two states with equal positions but different history queues are not equivalent;
- deterministic ID ordering;
- canonical serialization suitable for hashing or dictionary keys;
- restart-state construction.

## 7. Level schema version 1

Create an implementation-neutral JSON Schema draft and human-readable contract.

### 7.1 Required conceptual fields

At minimum:

```text
schema_version
level_id
title
terrain_rows
player_spawn
echoes[]: id, delay, spawn
plates[]: id, position
doors[]: id, position, initial_open, all_plate_ids
exit: position
metadata: teaching_goal, intended_mechanics, notes
validation: recommended_search_depth, expected_min_turns (optional/non-authoritative)
```

### 7.2 Required schema constraints

- UTF-8 JSON; no comments or trailing commas.
- `schema_version` is integer `1`.
- Stable IDs use lower snake_case and are unique within their entity family.
- Terrain rows use only `#` for wall and `.` for floor.
- All rows have equal non-zero length.
- Coordinates are integer `[x, y]` pairs within bounds.
- Static entities must be on floor cells.
- Door positions, plate positions, and exit position are mutually non-overlapping.
- Actor spawns may overlap one another and may occupy a plate, but may not be on walls, doors, or the exit.
- Echo delays are positive integers; recommend a bounded initial range such as 1–16 and justify the chosen bound.
- Every door references at least one existing plate ID; duplicate references are invalid.
- At least one echo is required for an official delayed-echo puzzle, though a schema example may explain whether tutorial-zero levels are permitted by an explicit metadata flag.
- Unknown fields policy must be explicit: either reject or safely ignore. Prefer rejection for version 1 unless justified.

### 7.3 Machine-readable artifacts

Create:

- `schemas/level_v1.schema.json`
- `docs/level_design/examples/level_v1_minimal_valid.json`
- `docs/level_design/reference/turn_transition_vectors_v1.json`

These are contract artifacts, not runtime implementation.

## 8. Reference transition vectors

The JSON transition-vector file and companion explanation must cover at least:

1. delay-3 indexing: turn-1 input replays on turn 4;
2. blocked player movement consumes a turn and remains in history;
3. blocked echo movement under a changed door state remains in place;
4. a plate opens its linked door only for next-turn movement;
5. actors may overlap without collision resolution;
6. identical positions with different history queues produce different canonical keys;
7. restart reproduces the declared initial state;
8. exit is triggered only by the current player.

Each vector must identify:

- immutable level fragment or fixture ID;
- input state;
- player input;
- expected actor actions;
- expected positions;
- expected plate/door state;
- expected history queue;
- expected success flag;
- short rationale.

Do not claim the vectors were executed by a runtime; they are normative specification fixtures until Task 0003 or a later test task implements them.

## 9. Solver and validation contract

Define a bounded breadth-first-search baseline for schema v1:

- deterministic action order: `UP`, `RIGHT`, `DOWN`, `LEFT`, `WAIT`;
- initial state construction from level data;
- visited-set key from the canonical logical state;
- goal check using the same transition contract;
- shortest turn count `L*`;
- one machine-replayable shortest solution;
- shortest-solution count `N*`, with an explicit cap/status if counting becomes excessive;
- visited-state count;
- maximum frontier size;
- search-depth limit;
- state-count/time limit status values such as `SOLVED`, `UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE`, `DEPTH_LIMIT`, `STATE_LIMIT`, `TIME_LIMIT`, `INVALID_LEVEL`;
- no claim of `UNSOLVABLE` when only a resource limit was reached.

Explain that absolute turn count is a metric, not normally part of state deduplication, because the history queue captures all future-relevant input memory for schema v1.

Define required future regression behavior: any change to transition semantics reruns every accepted level and compares validity, `L*`, solution count status, and replay.

## 10. Required repository artifacts

Create:

- `docs/game_design/GAMEPLAY_SIMULATION_CONTRACT_CURRENT.md`
- `docs/level_design/LEVEL_SCHEMA_V1_CURRENT.md`
- `docs/level_design/REFERENCE_TRANSITION_VECTORS_V1.md`
- `schemas/level_v1.schema.json`
- `docs/level_design/examples/level_v1_minimal_valid.json`
- `docs/level_design/reference/turn_transition_vectors_v1.json`
- `docs/reports/0002_DETERMINISTIC_SIMULATION_AND_LEVEL_SCHEMA_CONTRACT_REPORT.md`

Update only as needed:

- `docs/game_design/DELAYED_SELF_GAME_DESIGN_DOCUMENT_CURRENT.md`
- `docs/environment/DEVELOPMENT_ENVIRONMENT_CURRENT.md`
- `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`
- `docs/CODEX_ACTIVE_TASK_CURRENT.md`
- `docs/DOC_INDEX_CURRENT.md`
- `docs/DEVELOPMENT_PLAN_CURRENT.md`
- `docs/HANDOFF_MASTER_CURRENT.md`
- `docs/project_memory.md`

GDD edits must be narrow: add links/authority notes and reconcile the logical movement/turn semantics with this contract. Preserve product vision, scope, milestones, narrative, and unrelated design content.

Environment-record edits must only link the Task 0001 acceptance and distinguish the newly frozen decisions from remaining unverified runtime/export facts.

## 11. Allowed tools and subagents

Allowed:

- Git read commands;
- Markdown/JSON authoring in authorized paths;
- Python standard-library `json` parsing and bounded consistency checks;
- bounded text searches;
- configured `docs_reader`, `docs_writer`, `planner_high`, or read-only `code_reviewer` when useful.

Subagents must not commit, push, edit outside delegated paths, invent implementation evidence, or weaken the frozen contract. Main thread owns final reconciliation, staging, commit, push, and verdict. Record any fallback honestly.

## 12. Non-goals and protected surfaces

Do not:

- create or edit `project.godot`;
- launch Godot editor or headless project mode;
- create GDScript, scenes, runtime resources, tests, tools, plugins, assets, shaders, imports, export presets, builds, or executables;
- install or download dependencies;
- create `D:\Delayed_Self_Evidence`;
- change Godot version, renderer, language, or target-platform decisions;
- decide logic resolution, art style, final license, independent reviewer, or undo support;
- implement or claim a working solver;
- claim any level was runtime-tested, playable, exported, or performance-validated;
- modify repository settings, releases, tags, accounts, or public submission surfaces.

## 13. Consistency review

Before staging, confirm:

- the human contract, JSON Schema, example level, and transition vectors use the same field names and semantics;
- all JSON parses with Python standard library;
- the valid example satisfies every manually checkable schema constraint;
- every referenced plate ID exists;
- all coordinates are in bounds and on floor;
- reference history indexing matches the delay definition;
- door timing matches the next-turn rule;
- the GDD no longer implies a conflicting sequential logical resolution;
- observed, frozen, pending, and unverified statuses remain distinct;
- no runtime or editor state exists;
- no secret-like or unrelated personal data is present;
- all Markdown links resolve.

A JSON Schema validator package is not installed or required. If validation beyond JSON parsing would require installation, do not install; perform a bounded manual/standard-library consistency checker and state that limitation.

## 14. Validation and Git discipline

Before staging:

```powershell
git status --short --untracked-files=all
git diff --check
git diff --stat
```

Explicitly stage only authorized paths. Never use broad staging.

Then run:

```powershell
git diff --cached --check
git diff --cached --stat
git diff --cached --name-only
```

The execution report must list:

- verdict;
- task and accepted predecessor;
- start/final HEAD and origin;
- files created/updated;
- contract decisions materialized;
- JSON and consistency checks;
- known limitations;
- GDD reconciliation summary;
- protected surfaces not touched;
- subagent use/fallback;
- recommended next gate.

## 15. Commit and push authorization

This task authorizes one specification-only commit on `main` and one normal push to `origin/main` if all gates pass.

Required commit message:

```text
docs: freeze Delayed Self simulation and level schema
```

Immediately before push:

```powershell
git fetch origin
git rev-parse HEAD
git rev-parse origin/main
git status --short --untracked-files=all
```

If remote moved after Task 0002 began, stop. Do not merge, rebase, amend, force-push, overwrite, or create a second commit without a new instruction.

## 16. Stop conditions

Stop with `BLOCKED` if:

- startup Git/root gate fails;
- worktree is unexpectedly dirty;
- local/remote diverged;
- this task or Task 0001 acceptance is missing;
- the frozen semantics directly contradict a higher-priority source and cannot be reconciled narrowly;
- a coherent schema or vector set would require guessing a material rule not resolved here;
- required work would need Godot launch, implementation, installation, download, or protected-surface access;
- JSON artifacts cannot be made internally consistent;
- remote drifts before push.

## 17. Terminal verdicts

Use exactly one:

- `PASS_FOR_GPT_REVIEW`
- `PASS_WITH_OBSERVATIONS_FOR_GPT_REVIEW`
- `BLOCKED`

## 18. Recommended next gate

Do not start implementation automatically. Recommend one of:

- Task 0002R — narrow contract correction if material ambiguity remains;
- Task 0003 — minimal Godot vertical slice implementing the accepted contract and reference vectors;
- a separate tooling task only if a prerequisite is genuinely required and cannot be avoided with built-in Godot/GDScript facilities.