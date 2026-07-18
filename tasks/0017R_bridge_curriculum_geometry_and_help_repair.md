# Task 0017R — Repair bridge curriculum geometry and contextual Help

- Status: `READY`
- Gate: `FORMAL REAUTHORING + CONTEXTUAL HELP + MACHINE/CAPTURE VALIDATION`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Accepted plan: `docs/level_design/BRIDGE_CURRICULUM_REPAIR_PLAN_CURRENT.md`
- Plan acceptance: `docs/reports/0017D_GPT_BRIDGE_CURRICULUM_REPAIR_PLAN_ACCEPTANCE.md`
- Plan acceptance commit: `82dbcff5060263290acb84cd9d870f452f464f0a`
- Current accepted bridge SHA-256: `805cdc05ea9b3805189ba7be4938cb7ede4e7056b9ae9a7e911df96a801d58ee`
- Primary bundle: `MINIMAL_BRIDGE_GEOMETRY_PLUS_CONTEXTUAL_CAUSAL_HELP`
- Sole fallback: `SIMPLIFIED_GEOMETRY_WITHOUT_HELP_CHANGE`

## 1. Objective

Replace the current `echo_spacing_bridge` with one materially simpler schema-v1 geometry and add one bridge-curriculum contextual Help section that explains the reusable causal experiment without disclosing a route.

The repaired bridge must remain mandatory sequence 7 before byte-identical `two_echo_convergence` at sequence 8. This task ends at machine/capture validation and GPT review. It does not conduct owner retest and does not begin `signal_convergence`.

## 2. Startup and required reads

Before any write or Godot run, verify exact root, branch, SSH/expected origin, clean tracked and untracked worktree, synchronized `HEAD == origin/main`, accepted Godot `4.7.stable.steam.5b4e0cb0f`, and no residual Godot process.

Read in order:

1. `AGENTS.md`;
2. current startup and active-task documents;
3. this task;
4. Task 0017D plan, diagnostic report, and GPT acceptance;
5. Task 0017V owner review/report and GPT adjudication;
6. Task 0017C implementation report and validation;
7. Task 0017, 0017P, and 0017C task boundaries;
8. simulation, schema, catalog, progression, Gameplay/AppRoot, Help, Timeline, presentation, test, capture, and generated-file safety contracts;
9. current bridge, byte-identical `two_echo_convergence`, catalog, relevant focused tests, and aggregate registration.

Before editing, print a concise plan with candidate-authoring limit, selected paths, causal gates, Help predicate/copy semantics, tests, captures, cleanup, rollback, and stop conditions.

## 3. Frozen authorities and forbidden scope

Treat as immutable:

- `simulation_v1`, `level_v1`, catalog-v1 semantics, solver behavior, history, simultaneous independent movement, legal overlap, combinational Doors, open-result/next-input entry, player-only EXIT, restart, and canonical key;
- catalog entry count, ordering, prerequisites, and sole-final semantics;
- all seven formal levels other than `echo_spacing_bridge`, especially byte-identical `two_echo_convergence` and SHA-256 `772410d3b8bb807e35472ee2a7d07b703de66e1e0e92ffb4d1ff8433a345d5fd`;
- accepted Task 0015R divergence feedback;
- accepted Task 0017P scrollable Level Select;
- Timeline model, indexing, copy, visibility, and optional status;
- A/B labels/shapes/pips and E2/E4 badges/outlines;
- `LABEL_SHAPE_PIP_PRIMARY_NO_NEW_LINES`;
- future `signal_convergence` as unimplemented and unauthorized.

Do not modify:

```text
project.godot
schemas/
scripts/simulation/
scripts/solver/
scripts/app/
scenes/
data/catalog/level_catalog_v1.json
data/levels/<anything except echo_spacing_bridge.json>
```

Do not add a new mechanic, action, actor collision, Gate, latch, persistent Door, box, key, timer, hazard, second Door, third Plate, new level, catalog entry, exact walkthrough, route indicator, target spacing, next-action hint, solver-backed recovery, or always-on line.

## 4. Bounded geometry authoring

Re-author only:

```text
data/levels/echo_spacing_bridge.json
```

A maximum of six bounded geometry candidates is authorized. Candidate probes remain external and never enter product data unless selected. Stop if no candidate satisfies every hard gate.

Required formal structure:

- schema v1;
- same `level_id` and title;
- shared-spawn E2/E4 delays exactly 2 and 4;
- exactly two distinct Plates A/B;
- exactly one initially closed A+B Door;
- exactly one player-only EXIT beyond the Door;
- board no larger than 8×7;
- no route/witness metadata or `best_turn_threshold`;
- at least one misleading overshoot/upward-pocket burden from the accepted room must be removed or structurally neutralized;
- required `BLOCKED/MOVED` divergence must occur before the two-Plate staging loop and be visually inspectable.

Hard metric gates:

```text
11 <= L* <= 14
4 <= N* <= 64
N* status = EXACT
1000 <= visited_states <= 12000
100 <= maximum_frontier <= 2500
meaningful decisions = 2–3
recoverable alternatives >= 3
```

Starting limits remain depth 64, states 500,000, time 30 seconds, count cap 1,000,000. A limit result is unverified.

## 5. Causal and necessity gates

Every shortest solution must include:

1. a post-activation transition where one ECHO is `BLOCKED`, the other `MOVED`, and signed or Manhattan spacing changes;
2. later E2 on A and E4 on B with YOU staged for entry;
3. simultaneous A+B open result;
4. following-input entry/crossing from the open start snapshot;
5. YOU-only completion.

Require zero reversed-role shortest solutions unless GPT separately adjudicates otherwise.

Complete finite-state controls must establish unsolved without limits for:

- no ECHO;
- E2 only;
- E4 only;
- equal delays 2/2;
- equal delays 4/4.

Also audit A-only, B-only, Door removal, Plate A relocation, Plate B relocation, blocker relocation, YOU substitution, overlap, Door articulation/bypass, ECHO-on-EXIT, YOU-on-EXIT, exact restart, and witness replay.

At least three non-optimal states must remain recoverable through exact bounded search or short visible return routes. Restart must not be the only intelligible recovery. No literal WAIT requirement, repeated blocked-input macro, or corridor padding is allowed.

## 6. Contextual Help contract

Modify reusable Gameplay only as narrowly necessary to append one bridge-curriculum Help section when H is opened.

The trigger must be data-derived and require all of:

- `metadata.intended_mechanics` contains `echo_spacing_change`;
- at least two ECHOs;
- exactly two Plates;
- a Door depending on both Plates.

Do not branch on `level_id`, coordinates, turn number, history contents, witness state, or solution progress. Tests must prove `two_echo_convergence` does not receive this section because its metadata does not declare `echo_spacing_change`.

The exact copy is implementation-selected but must communicate only:

- a Door or wall can block one ECHO while another moves, changing spacing;
- compare `MOVED/BLOCKED` and try a different route or loop;
- keep the two ECHOs on separate A/B Plates so YOU stays free to cross after A+B opens;
- only YOU completes.

Forbidden copy includes exact inputs, coordinates, turns, target spacing, next action, exact E2/A–E4/B assignment, branch recommendation, screenshot route, solver output, remaining distance, or state-solvability claims.

Help remains manual, modal, zero-turn, and non-persistent. Opening/closing Help must not change canonical state, turn, progress, completion, or disclosure outside presentation. Timeline source/copy/behavior remains unchanged. Do not bundle dotted-line changes.

Primary bundle is mandatory unless focused 960×540/no-route review proves the Help cannot remain readable and non-route. Only then may the sole fallback freeze Help and implement geometry-only; document the exact failed primary criterion before switching.

## 7. Tests and stable marker

Update the minimum necessary Task 0017 formal tests and add focused Help/repair tests. Register one new marker:

```text
TASK_0017R_BRIDGE_CURRICULUM_REPAIR_TESTS_PASS
```

Cover at minimum:

1. exact formal cardinalities and new SHA-256;
2. hard metric bands and `N* EXACT`;
3. witness replay and exact restart;
4. all-shortest required divergence, fixed roles, A+B, and following-input crossing;
5. complete no-ECHO/E2-only/E4-only/equal-delay controls;
6. dependency, Door, Plate, blocker, substitution, overlap, articulation, and EXIT controls;
7. 2–3 decisions and at least three recoveries;
8. no WAIT/padding claim violations;
9. catalog remains byte-identical with eight entries and bridge sequence 7;
10. all seven other formal hashes and metrics remain exact;
11. Help predicate true for repaired bridge and false for `two_echo_convergence`, zero/single-ECHO levels, and non-spacing-change rooms;
12. Help copy contains causal/role concepts and none of the forbidden route disclosures;
13. Help open/close is zero-turn and canonical-state preserving;
14. Timeline remains unchanged and optional;
15. Level Select eight/twelve-entry reachability and Task 0017P marker remain passing;
16. reusable Gameplay, direct route, AppRoot progression, completion return, restart, reset, resize, and Safe Error remain normal.

Final aggregate must:

- exit 0;
- report assertions strictly greater than 550 and vectors exactly 9;
- include all prior twelve markers exactly once;
- include the new Task 0017R marker exactly once;
- preserve seven other formal hashes/metrics;
- emit only intentional `LEVEL_ID_MISMATCH` on stderr.

## 8. Native captures

Capture game-window-only 960×540 Compatibility evidence for:

1. repaired bridge initial state;
2. stable-spacing no-cue control;
3. required early `BLOCKED/MOVED` event;
4. at least two recoverable non-optimal states;
5. A+B role state;
6. following open-snapshot crossing;
7. bridge completion and shifted Level 8 unlock;
8. H Help closed/open comparison;
9. bridge contextual Help readable without route disclosure;
10. `two_echo_convergence` Help without the bridge-specific section;
11. reduced-motion decision state;
12. grayscale decision/Help state;
13. Level Select bottom with sequence 8 reachable.

Verify no critical overlap, no horizontal clipping, no route disclosure, and preservation of A/B, E2/E4, Door, EXIT, goal, controls, and completion readability.

## 9. Evidence, cleanup, and authorized paths

Use external root:

```text
D:\Delayed_Self_Evidence\0017R_bridge_curriculum_repair\
```

Record all candidate attempts, selected provenance, commands, solver/control results, hashes, test outputs, captures, Help review, and SHA-256 index. Do not stage external artifacts.

After all Godot runs, close every Godot process. Narrow generated-file cleanup is authorized only when `project.godot` is the sole unintended unstaged tracked change and every untracked path is a regular repository-local `.gd.uid`. Restore only literal worktree `project.godot` and delete only the frozen Git-enumerated UID paths one by one. Stop on any differing set. Never use broad clean/restore, reset, stash, rebase, amend, or force-push.

May modify only the minimum necessary subset of:

```text
data/levels/echo_spacing_bridge.json
scripts/gameplay/vertical_slice.gd
tests/levels/task_0017_echo_spacing_bridge_validation.gd
tests/gameplay/<Task 0017R focused Help/presentation test>.gd
tests/gameplay/<Task 0017R capture harness>.gd
tests/app/<narrow progression/capture update if necessary>.gd
tests/run_all.gd
docs/level_design/validation/ECHO_SPACING_BRIDGE_VALIDATION.md
docs/reports/0017R_BRIDGE_CURRICULUM_REPAIR_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/level_design/INITIAL_LEVEL_ROADMAP_AND_VALIDATION_MATRIX_CURRENT.md
docs/level_design/FIVE_LEVEL_DIFFICULTY_RECOVERY_AND_LEVELS_6_8_PLAN.md
docs/level_design/LEVEL_8_FINALE_AND_DIFFICULTY_BRIDGE_PLAN_CURRENT.md
docs/level_design/BRIDGE_CURRICULUM_REPAIR_PLAN_CURRENT.md
docs/ux/PRESENTATION_VIEWPORT_AND_HUD_DIRECTION_CURRENT.md
```

Do not modify prior tasks/reports/reviews/acceptances, catalog data, other formal levels, App Shell source, Simulation, solver, schema, scenes, project settings, assets, persistence, build, export, or release surfaces.

## 10. Report, Git discipline, and terminal verdict

Create `docs/reports/0017R_BRIDGE_CURRICULUM_REPAIR_REPORT.md` with candidate provenance, old/new hashes and metrics, all-shortest traces, complete controls, decision/recovery audit, Help trigger/copy/no-route audit, captures, aggregate, preservation, cleanup, changed paths, rollback, and non-claims.

Stage explicit authorized paths only. Commit exactly once:

```text
fix: simplify Delayed Self bridge curriculum
```

Fetch and stop on remote drift before push. Push normally and require a clean tracked/untracked worktree with `HEAD == origin/main`.

On success return:

```text
BRIDGE_CURRICULUM_REPAIR_READY_FOR_GPT_REVIEW
```

Include commit SHA, selected bundle/fallback disposition, new metrics/hash, controls, Help predicate/copy boundary, aggregate assertions/vectors/markers, captures, report/evidence paths, and final Git state.

Do not claim owner acceptance, fresh/independent evidence, curriculum closure, finale acceptance, candidate readiness, export, release, or submission readiness.
