# Task 0023ZX — Implement the core-mechanics schema, Simulation and solver foundation

- Status: `READY`
- Gate: `IMPLEMENTATION / BACKWARD-COMPATIBLE CORE MECHANICS FOUNDATION + ZERO CATALOG/PROFILE CHANGE`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- GPT prerequisite acceptance: `docs/reports/0023ZW_GPT_GAMEPLAY_PRESENTATION_ROADMAP_REBASELINE_ACCEPTANCE.md`
- Required checkpoint: `3515b6b5a8e09e6a7725c8024861063e3bbb8c45`
- Existing implemented baseline: eight formal levels, unchanged
- Target product direction: twelve core levels plus two conditional stretch rooms
- Production Profile authority: none
- Catalog/final-flag authority: none
- Asset/font/audio authority: none

## 1. Objective

Extend the deterministic pure rules layer so future non-catalog fixtures can represent and solve the five accepted core mechanic families:

1. YOU-only push crates;
2. YOU-only consumable keys and locks;
3. grouped multi-cell barriers / bridges;
4. typed sensors (`ANY_ACTOR`, `YOU_ONLY`, `ECHO_ONLY`) with explicit crate eligibility;
5. one-shot room-local latches.

This task must update the schema/loader, shared Simulation transition, canonical state key, restart/replay behavior and bounded BFS solver, then prove the extension with focused non-catalog fixtures and tests.

Do not add, reorder or modify formal levels. Do not change the catalog, finale flags, Profile codec/store/defaults, UI, gameplay presentation, localization, assets, fonts or audio.

## 2. Binding product decisions

The accepted future sequence policy is append-only:

- existing IDs and sequence 1–8 remain unchanged;
- `two_echo_convergence` remains sequence 8 and the implemented finale during this task;
- future rooms 9–12 and any new finale remain unauthorized;
- existing Profile content is not read or written.

Schema v1 and every existing level must remain valid and behavior-identical. Implement the new mechanics as a backward-compatible schema v2 path or an equivalently explicit versioned extension; do not silently reinterpret schema-v1 fields.

## 3. Deterministic transition contract

Before code edits, materialize/update the authoritative v2 contract and reference vectors. The implementation must follow this order for a legal non-terminal turn:

1. capture the complete turn-start snapshot;
2. derive YOU and ECHO actions from input/history;
3. evaluate bounds, walls, closed v1 doors, closed v2 barrier cells and locks;
4. evaluate at most one YOU crate push and reserve the crate destination;
5. resolve actor destinations, blocking an ECHO from any crate cell and blocking an ECHO destination reserved by a pushed crate;
6. commit actor and crate positions simultaneously;
7. collect YOU-only keys;
8. resolve typed sensor occupancy and first-use latches;
9. derive next-turn v1 door and v2 grouped-barrier states;
10. defer a requested grouped-barrier closure while any actor or crate occupies one of its cells;
11. evaluate the current YOU position against the exit;
12. shift history and increment the operational turn index.

Rendering and animation remain non-authoritative.

### 3.1 Crates

- A crate occupies one cell and has a stable lower-snake-case ID.
- Only YOU may push exactly one adjacent crate by a cardinal action.
- The cell beyond the crate must be in bounds, traversable, free of wall, closed barrier/door/lock, another crate and every actor position in the turn-start snapshot.
- A valid push reserves the destination for the crate; an ECHO proposing that reserved cell is blocked.
- YOU ends in the crate's former cell; the crate ends in the reserved cell.
- An ECHO attempting to enter a crate cell remains in place.
- Crates may press only sensors whose schema explicitly enables crate occupancy.
- Deadlocks are normal restartable states; no automatic repair is allowed.

### 3.2 Keys and locks

- Submission-core schema supports one visible key/lock family while retaining stable IDs.
- Only YOU may collect a key.
- Collected keys become bounded room-local inventory and the key entity becomes absent for that attempt.
- When YOU attempts to enter a matching lock cell with a matching key already held at turn start, exactly one key is consumed, the lock is removed and YOU enters the cell in the same turn.
- ECHOs never collect keys, consume keys or remove locks.
- Restart restores all keys and locks and clears inventory.

### 3.3 Grouped barriers and sensors

- One barrier group may contain one or more unique cells and changes as one unit.
- Sensor types are exact enums `ANY_ACTOR`, `YOU_ONLY`, `ECHO_ONLY`.
- `ANY_ACTOR` means YOU or any ECHO; crates do not count unless `include_crates=true` is declared.
- Sensor eligibility is never inferred from presentation.
- Sensor/latch results affect entry beginning next turn.
- If a group should close while any actor or crate occupies a group cell, actual closure is deferred; the group remains open and is reevaluated after the next movement.

### 3.4 One-shot latches

- A latch declares one activator class (`ANY_ACTOR`, `YOU_ONLY`, `ECHO_ONLY`) and one target barrier group/state.
- The first valid occupancy activates it once for the room attempt.
- Its activated state is stored in Simulation state and persists until restart.
- It never toggles and never writes Profile data.

## 4. State and canonical key

The v2 operational state must include every future-relevant mutable value, in deterministic ID order:

- YOU and ECHO positions;
- v1 door states;
- v2 barrier-group actual states;
- crate IDs/positions;
- remaining key IDs and bounded held-key inventory;
- removed/opened lock IDs;
- latch activation states;
- action history;
- completion.

`turn_index` remains excluded from deduplication. Static definitions and presentation state remain excluded. Canonical serialization must be compact, deterministic JSON with exact fixtures. Two states differing in crate position, remaining key, held inventory, removed lock, latch activation or actual grouped-barrier state must never deduplicate.

## 5. Schema and loader

Create an explicit schema-v2 contract and machine-readable schema while preserving schema v1 unchanged.

Validation must reject at minimum:

- duplicate IDs or cells;
- out-of-bounds/non-traversable placement;
- crate/key/lock/barrier/static overlap not explicitly allowed;
- unknown sensor/latch/barrier references;
- invalid enums or undeclared crate eligibility;
- multiple entities occupying a forbidden initial cell;
- inconsistent initial grouped-barrier state;
- a latch targeting a missing group;
- unknown fields.

The loader must normalize v1 and v2 into explicit immutable dictionaries without adding v2 semantics to v1 rooms.

## 6. Solver and budgets

The BFS solver must use only the shared Simulation transition and extended canonical key. No duplicated mechanic logic is allowed in the solver or tests.

Add bounded non-catalog fixtures that independently demonstrate:

- crate + delayed-ECHO role separation;
- key/lock + delayed-ECHO benefit;
- typed sensor + multi-cell barrier;
- one-shot latch and deferred closure;
- one small integration fixture using no more than three new families.

Each fixture must have a deterministic replayable shortest solution, exact or explicitly capped shortest-solution count, and documented depth/state/frontier facts. Use conservative fixture budgets; any fixture exceeding depth 32 or 50,000 visited states is blocked pending redesign.

## 7. Required regressions

Prove all of the following in fresh headless processes:

1. every schema-v1 reference vector still matches exactly;
2. all eight existing formal levels retain validity, canonical restart behavior, solver status, shortest length/count status and replay result;
3. existing level/catalog hashes remain unchanged;
4. YOU valid/invalid crate pushes;
5. ECHO crate blocking and reserved-destination blocking;
6. crate-enabled versus crate-disabled sensor behavior;
7. YOU-only key collection and same-turn matching-lock entry/consumption;
8. ECHO key/lock rejection;
9. all three typed sensor classes;
10. grouped next-turn barrier behavior;
11. actor- and crate-occupied deferred closure;
12. one-shot latch persistence and restart reset;
13. canonical-key distinctions for every new mutable family;
14. replay and BFS share the same transition;
15. malformed v2 states/levels fail atomically with stable codes.

Do not run project main-scene playthroughs, production Profile operations, historical configured fixtures, export or build.

## 8. Authorized repository paths

Product/contract paths:

```text
docs/game_design/GAMEPLAY_SIMULATION_CONTRACT_V2_CURRENT.md
docs/level_design/LEVEL_SCHEMA_V2_CURRENT.md
docs/level_design/reference/turn_transition_vectors_v2.json
schemas/level_v2.schema.json
scripts/simulation/level_loader.gd
scripts/simulation/simulation.gd
scripts/solver/bfs_solver.gd
```

Focused new fixture/test paths only:

```text
tests/simulation/task_0023zx_core_mechanics_*.gd
tests/simulation/fixtures/task_0023zx_*.json
```

Report/current documentation:

```text
docs/reports/0023ZX_CORE_MECHANICS_SCHEMA_SIMULATION_SOLVER_FOUNDATION_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/production/EXPANDED_CONTENT_SUBMISSION_ROADMAP_CURRENT.md
```

No other path may change. In particular freeze:

```text
data/catalog/**
data/levels/**
scenes/**
scripts/gameplay/**
scripts/app/**
project.godot
schemas/level_v1.schema.json
docs/level_design/reference/turn_transition_vectors_v1.json
tests/run_all.gd
assets/**
```

## 9. Stop conditions

Stop without broad repair on any:

- schema-v1 or existing-level semantic drift;
- existing level/catalog hash change;
- solver/Simulation disagreement;
- nondeterministic key or replay;
- fixture budget excess;
- Profile, test-root or ordinary user-data access;
- catalog/formal-level/finale change;
- presentation/localization/asset/audio change;
- unauthorized path;
- residual Godot process;
- remote divergence.

## 10. Repository output

On complete pass, commit authorized paths only with:

```text
feat: add Delayed Self core mechanics simulation foundation
```

Push normally after exact changed-path, frozen-hash, diff-check, process and remote-drift audits.

## 11. Terminal verdict

Return exactly one:

```text
CORE_MECHANICS_SIMULATION_FOUNDATION_READY_FOR_GPT_REVIEW
BLOCKED_CORE_MECHANICS_SIMULATION_FOUNDATION
```

A pass establishes only schema/Simulation/solver support and non-catalog fixtures. It does not authorize formal rooms 9–12, catalog/finale/Profile migration, gameplay rendering, art/font/audio import, localization, menu flow, build/export, release, upload or submission.
