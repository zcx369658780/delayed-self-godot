# Task 0017RC — Add bridge-specific contextual causal Help without geometry change

- Status: `READY`
- Gate: `CONTEXTUAL HELP REPAIR + MACHINE/CAPTURE VALIDATION`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Parent blocker: `tasks/0017RB_bridge_topology_search_and_candidate_selection.md`
- GPT adjudication: `docs/reports/0017RB_GPT_TOPOLOGY_SEARCH_BLOCKER_ADJUDICATION.md`
- Selected direction: `BYTE_IDENTICAL_BRIDGE_PLUS_CONTEXTUAL_CAUSAL_HELP`
- Accepted bridge SHA-256: `805cdc05ea9b3805189ba7be4938cb7ede4e7056b9ae9a7e911df96a801d58ee`

## 1. Objective

Keep the accepted `echo_spacing_bridge` formal file byte-identical and add one manual, zero-turn, bridge-curriculum Help section that explains a reusable causal experiment and the two-ECHO/YOU role constraint without revealing a route.

This task ends at machine/capture validation and GPT review. It does not conduct owner retest, change geometry, weaken any hard gate, or begin `signal_convergence`.

## 2. Startup and synchronization

Before writing or running Godot, verify:

- root exactly `D:\Delayed_Self`;
- branch `main`;
- expected SSH origin;
- clean tracked and untracked worktree;
- `HEAD == origin/main` and contains the Task 0017RB blocker adjudication;
- accepted Godot `4.7.stable.steam.5b4e0cb0f` or exact documented equivalent;
- no residual Godot process.

If clean local `main` is behind, use only `git fetch origin` and `git merge --ff-only origin/main`. Stop on divergence, conflict, unexpected paths, wrong root/remote, or materially different toolchain.

## 3. Required reads

Read in order:

1. `AGENTS.md`;
2. current startup and active-task documents;
3. this task;
4. Task 0017RB report/candidate disposition and GPT adjudication;
5. Task 0017RA equal-delay adjudication and report;
6. Task 0017R blocker report and Task 0017D accepted repair plan;
7. Task 0017V owner review/report/adjudication;
8. Task 0017C bridge implementation report/validation;
9. Task 0015R divergence-feedback implementation/acceptance;
10. current bridge, `two_echo_convergence`, catalog, Gameplay Help code, Help tests, presentation/capture conventions, and aggregate registration;
11. simulation, schema, progression, AppRoot, Level Select, Godot-safety, and generated-file-safety contracts.

Before editing, print a concise implementation plan covering trigger predicate, proposed semantics, no-route audit, exact selected paths, focused tests, captures, aggregate regression, cleanup, rollback, and stop conditions.

## 4. Frozen authorities and forbidden scope

Treat as immutable:

- `simulation_v1`, `level_v1`, catalog-v1 semantics, solver behavior, history, movement, Doors, completion, restart, and canonical key;
- all eight formal level JSON files, including `echo_spacing_bridge` and `two_echo_convergence`;
- all formal hashes and accepted solver metrics;
- catalog count/order/prerequisites/final semantics;
- Task 0015R divergence feedback;
- Task 0017P Level Select behavior;
- Timeline model, indexing, copy, visibility, and optional status;
- A/B labels/shapes/pips and E2/E4 badges/outlines;
- dotted-line behavior;
- future `signal_convergence` as unimplemented and unauthorized.

Do not modify:

```text
project.godot
schemas/
data/
scripts/simulation/
scripts/solver/
scripts/app/
scenes/
assets/
```

Do not add geometry, formal metadata, a new level, catalog entry, mechanic, action, Gate, latch, persistent Door, box, timer, hazard, route indicator, solver-backed recovery, automatic hint, or always-on cue.

## 5. Contextual Help trigger

Modify reusable Gameplay only as narrowly necessary.

The bridge-curriculum Help section may appear only when all of the following data-derived conditions are true:

1. `level.metadata.intended_mechanics` contains `echo_spacing_change`;
2. the level declares at least two ECHOs;
3. the level declares exactly two distinct Plates;
4. at least one Door depends on both Plate IDs.

Do not branch on:

- `level_id`;
- title;
- coordinates;
- turn number;
- current actor positions;
- history contents;
- witness progress;
- solver state;
- completion proximity.

Tests must prove the section is absent from:

- byte-identical `two_echo_convergence`;
- zero-ECHO and single-ECHO levels;
- multi-ECHO rooms without `echo_spacing_change` metadata;
- rooms without exactly two Plates and an A+B Door.

## 6. Help semantics and no-route boundary

Help remains manual through `H`, modal, zero-turn, and non-persistent.

The contextual section must communicate only these concepts:

- a closed Door or wall can block one ECHO while another moves, changing spacing;
- compare the visible `MOVED/BLOCKED` outcomes and try a different route or loop;
- two ECHOs must remain on separate A/B Plates while YOU stays free to cross after A+B opens;
- only YOU completes.

The exact wording is implementation-selected, but it must be concise and readable at 960×540.

Forbidden content includes:

- action sequences or key presses;
- coordinates;
- turn counts;
- target spacing or required distance;
- next action;
- exact E2-on-A / E4-on-B assignment;
- branch or corridor recommendation;
- screenshot route;
- solver output or witness;
- remaining moves or recovery distance;
- labels that a current state is solvable, dead, correct, or incorrect.

The section must not automatically open, pulse, persist after closing, or change based on current progress.

Opening and closing Help must not change:

- turn index;
- canonical state key;
- player/ECHO positions;
- Door state;
- history;
- completion;
- progress/unlock state;
- disclosure state outside the existing Help presentation contract.

Timeline source, copy, visibility logic, and semantics remain unchanged.

## 7. Focused tests and stable marker

Add or update the minimum focused Gameplay tests and register exactly one new marker:

```text
TASK_0017RC_BRIDGE_CONTEXTUAL_HELP_REPAIR_TESTS_PASS
```

Cover at minimum:

1. bridge trigger predicate is true from formal data;
2. `two_echo_convergence` trigger is false;
3. zero/single-ECHO and non-spacing metadata controls are false;
4. wrong Plate count and non-A+B Door controls are false;
5. Help section appears only after manual H/open call;
6. Help closes through existing behavior;
7. open/close consumes zero turns and preserves canonical key and all operational state;
8. Help text contains the allowed causal and role concepts;
9. Help text contains none of the forbidden route disclosures;
10. exact E2/A–E4/B mapping is absent;
11. Timeline output before and after this task is unchanged;
12. bridge formal hash remains `805cdc05ea9b3805189ba7be4938cb7ede4e7056b9ae9a7e911df96a801d58ee`;
13. the other seven formal hashes and accepted metrics remain exact;
14. catalog remains byte-identical with eight entries;
15. Task 0015R divergence feedback remains truthful;
16. Level Select eight/twelve-entry reachability and Task 0017P marker remain passing;
17. AppRoot direct route, progression, completion return, restart, reset, resize, and Safe Error remain normal.

Final aggregate must:

- exit 0;
- report assertions strictly greater than 550 and vectors exactly 9;
- include all prior twelve markers exactly once;
- include the new Task 0017RC marker exactly once;
- preserve all eight formal hashes and accepted metrics;
- emit only the intentional `LEVEL_ID_MISMATCH` on stderr;
- contain no failed assertion, parser/runtime error, or crash.

## 8. Native capture requirements

Capture game-window-only native Compatibility evidence at 960×540 for:

1. bridge Help closed;
2. bridge Help open with the contextual section fully readable;
3. bridge Help after a real `BLOCKED/MOVED` event, proving copy remains static and non-progress-aware;
4. `two_echo_convergence` Help open without the bridge-specific section;
5. zero/single-ECHO Help controls without the section;
6. Help open/close state snapshots proving zero-turn preservation;
7. grayscale bridge Help;
8. reduced-motion bridge Help/decision frame;
9. Level Select bottom with sequence 8 reachable.

Verify:

- no clipping or text overflow;
- contextual section does not obscure critical Help content;
- no route or exact assignment is disclosed;
- A/B, E2/E4, Door, EXIT, goal, controls, and completion remain readable when Help is closed;
- `two_echo_convergence` remains visually unchanged outside existing Help.

## 9. External evidence and generated files

Use:

```text
D:\Delayed_Self_Evidence\0017RC_bridge_contextual_help_repair\
```

Record commands, focused/aggregate outputs, trigger matrix, before/after snapshots, copy/no-route audit, hashes, captures, cleanup, and a SHA-256 evidence index. Do not stage external artifacts.

After all Godot runs, close every Godot process. Narrow generated-file cleanup is authorized only when `project.godot` is the sole unintended unstaged tracked change and every untracked path is a regular repository-local `.gd.uid`. Restore only literal worktree `project.godot` and remove only frozen Git-enumerated UID paths one by one. Stop on any differing set. Never use `git clean`, wildcard/recursive deletion, reset, stash, rebase, amend, or force-push.

## 10. Authorized repository paths

May modify only the minimum necessary subset of:

```text
scripts/gameplay/vertical_slice.gd
tests/gameplay/<Task 0017RC focused Help test>.gd
tests/gameplay/<Task 0017RC capture harness>.gd
tests/run_all.gd
docs/reports/0017RC_BRIDGE_CONTEXTUAL_HELP_REPAIR_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/level_design/BRIDGE_CURRICULUM_REPAIR_PLAN_CURRENT.md
docs/ux/PRESENTATION_VIEWPORT_AND_HUD_DIRECTION_CURRENT.md
```

Do not modify prior tasks, reports, reviews, acceptances, candidate dispositions, formal data, catalog, App Shell, Simulation, solver, schema, Timeline model, scenes, project settings, assets, persistence, build, export, or release surfaces.

## 11. Report, Git discipline, and terminal verdict

Create:

```text
docs/reports/0017RC_BRIDGE_CONTEXTUAL_HELP_REPAIR_REPORT.md
```

The report must include trigger contract, final copy, no-route audit, zero-turn/state proof, non-target controls, focused/aggregate results, captures, formal/catalog preservation, changed paths, cleanup, evidence index, rollback, and non-claims.

Rollback is one presentation topic: remove the contextual section/predicate and its focused tests/capture registration. Formal data requires no rollback because it must not change.

Stage explicit authorized paths only. Require `git diff --check` and cached checks. Commit exactly once with:

```text
fix: add Delayed Self bridge causal Help
```

Fetch before push and stop on remote drift. Push normally and require a fully clean tracked/untracked worktree with `HEAD == origin/main`.

Stop with a specific blocker if Help cannot remain readable and non-route, leaks to a non-target level, changes operational state, requires a forbidden surface, breaks baseline regression, changes any formal hash/metric, or creates an unexpected worktree set.

On success return:

```text
BRIDGE_CONTEXTUAL_HELP_REPAIR_READY_FOR_GPT_REVIEW
```

Include commit SHA, final copy, trigger/non-trigger matrix, focused/aggregate assertions/vectors/markers, capture summary, report/evidence paths, cleanup disposition, and final Git state.

Do not claim curriculum closure, owner acceptance, fresh/independent evidence, difficulty/fun acceptance, finale authority, candidate readiness, export, release, or submission readiness.
