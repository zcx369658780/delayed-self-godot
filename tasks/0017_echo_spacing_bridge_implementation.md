# Task 0017 — Implement and validate `echo_spacing_bridge`

- Status: `READY`
- Gate: `IMPLEMENTATION + FORMAL VALIDATION / CURRICULUM BRIDGE`
- Repository: `zcx369658780/delayed-self-godot`
- Expected branch: `main`
- Expected local root: `D:\Delayed_Self`
- Issued by: GPT Project Sources advisor
- Date: 2026-07-18
- Accepted plan: `docs/level_design/LEVEL_8_FINALE_AND_DIFFICULTY_BRIDGE_PLAN_CURRENT.md`
- Accepted revision commit: `09ad4f6347af6d9cb17cb78f6f1cd11a07794d8d`
- GPT acceptance: `docs/reports/0016R_GPT_BRIDGE_MECHANICAL_NECESSITY_PLAN_ACCEPTANCE.md`
- GPT acceptance commit: `594e0a7e87ff2aa2e5233340fa48c3c01bbb157d`
- Exact target grammar: `SIMPLIFIED_TWO_PLATE_AND_TUTORIAL`

## 1. Objective

Implement, formally validate, and integrate one mandatory curriculum bridge:

```text
echo_spacing_bridge / Diverging Echoes / 错位回声
```

The bridge must teach one bounded causal idea before the accepted `two_echo_convergence` synthesis:

> terrain or a closed Door can make one delayed ECHO `BLOCKED` while the other `MOVED`, changing their relative spacing; the changed phase then lets E2 and E4 occupy two separate Plates together while YOU crosses an A+B Door from the following open snapshot.

The task ends at `INTERNAL_PLAYABLE / PASS_FOR_GPT_REVIEW` with exact machine evidence, catalog progression, native presentation captures, documentation, one commit, and push. It does not conduct owner review and does not implement `signal_convergence`.

## 2. Mandatory startup gate

Before any write or Godot run:

```powershell
Get-Location
git branch --show-current
git rev-parse HEAD
git rev-parse origin/main
git remote -v
git status --short --untracked-files=all
git log -48 --oneline --decorate
& 'D:\Program Files (x86)\Steam\steamapps\common\Godot Engine\godot.windows.opt.tools.64.exe' --version
Get-Command 'D:\Program Files (x86)\Steam\steamapps\common\Godot Engine\godot.windows.opt.tools.64.exe' | Format-List Source,Version,CommandType
```

Required:

- root exactly `D:\Delayed_Self`;
- branch `main`;
- expected origin;
- local `HEAD == origin/main` and contains this task plus the Task 0016R GPT acceptance;
- fully clean tracked and untracked worktree;
- accepted Godot `4.7.stable.steam.5b4e0cb0f` executable or exact equivalent recorded in the current environment document.

If clean local `main` is behind, use only:

```powershell
git fetch origin
git merge --ff-only origin/main
```

Stop on divergence, conflict, wrong root/remote, inability to fast-forward, unexpected files, or materially different toolchain.

## 3. Required reads

Read in order:

1. `AGENTS.md`;
2. current startup and active-task documents;
3. this task;
4. `docs/reports/0016R_GPT_BRIDGE_MECHANICAL_NECESSITY_PLAN_ACCEPTANCE.md`;
5. `docs/level_design/LEVEL_8_FINALE_AND_DIFFICULTY_BRIDGE_PLAN_CURRENT.md`;
6. `docs/reports/0016R_BRIDGE_MECHANICAL_NECESSITY_PLAN_REVISION_REPORT.md`;
7. `docs/reports/0016_GPT_FINALE_SEQUENCE_PLAN_ADJUDICATION.md`;
8. `docs/reports/0015R_GPT_FINAL_ACCEPTANCE.md` and Task 0015R implementation report;
9. `docs/level_design/validation/TWO_ECHO_CONVERGENCE_VALIDATION.md` and Task 0015 implementation report;
10. Task 0012 Level 6 validation/report;
11. `docs/game_design/GAMEPLAY_SIMULATION_CONTRACT_CURRENT.md`;
12. `docs/level_design/LEVEL_SCHEMA_V1_CURRENT.md` and `schemas/level_v1.schema.json`;
13. current eight-relevant contracts: catalog, progression, Gameplay/AppRoot routing, presentation direction, testing/capture conventions, Godot safety, generated-file safety, and puzzle-validation rules;
14. all seven existing formal levels and `data/catalog/level_catalog_v1.json`;
15. current solver/loader, Level 6/7 tests, Task 0015R feedback tests, capture harnesses, and aggregate registration;
16. current development plan, handoff, index, roadmap, difficulty plan, and project memory.

Before editing, print a concise implementation summary containing:

- candidate-authoring strategy and bounded iteration limit;
- intended early `BLOCKED/MOVED` divergence;
- intended E2→A / E4→B committed result;
- Plate-to-Door anti-substitution geometry;
- exact metric bands and solver limits;
- complete control matrix;
- catalog/progression migration;
- presentation/capture plan;
- exact selected repository paths;
- generated-file cleanup plan;
- stop and rollback conditions.

## 4. Frozen authorities and forbidden scope

Treat as immutable:

- `simulation_v1`, `level_v1`, catalog v1, solver semantics, action order, history indexing, blocked-action recording, simultaneous actor movement, legal overlap, combinational Doors, open-result/next-input entry, player-only EXIT, restart, canonical key, and exact BFS semantics;
- all seven existing formal JSON files, hashes, accepted metrics, and validation facts;
- accepted `two_echo_convergence` file content and SHA-256 `772410d3b8bb807e35472ee2a7d07b703de66e1e0e92ffb4d1ff8433a345d5fd`;
- Task 0015R transition-derived ECHO divergence feedback behavior;
- A/B labels/shapes/pips and E2/E4 badges/outlines;
- `LABEL_SHAPE_PIP_PRIMARY_NO_NEW_LINES`;
- Timeline as optional and non-required;
- Help architecture/copy and non-route role;
- WAIT as deferred research;
- owner-only review constraint;
- future `signal_convergence` as unimplemented sequence-9 concept.

Do not modify:

```text
project.godot
schemas/
scripts/simulation/
scripts/solver/
scripts/app/
scripts/gameplay/
scenes/
```

Also do not modify any existing formal level JSON, normative fixture, project rule, GDD, asset, font, audio, shader, import, plugin, dependency, persistence, settings, build, export, release, account, repository setting, Timeline model/index/layout, or Help architecture/copy.

Do not add:

- Gate, latch, persistent/one-shot Door, switch, timer, key, box, push mechanic, hazard, enemy, combat, teleport, interaction, new action, actor-specific Plate ownership, collision between actors, or new goal semantics;
- literal WAIT as a teaching requirement;
- exact walkthrough, next move, target spacing, target turn, solver-backed recovery, or route-specific presentation;
- new always-on dotted relationship lines;
- `signal_convergence` data or catalog entry.

If the bridge cannot satisfy the target without a forbidden change, stop with:

```text
BLOCKED_BRIDGE_REQUIRES_FORBIDDEN_SURFACE
```

## 5. Formal bridge contract

Create exactly:

```text
data/levels/echo_spacing_bridge.json
```

Required formal facts:

- `schema_version = 1`;
- `level_id = "echo_spacing_bridge"`;
- title `Diverging Echoes`;
- exactly one YOU;
- exactly two ECHOs with stable IDs, shared spawn, and delays exactly 2 and 4;
- exactly two distinct Plates with stable IDs representing A and B;
- exactly one initially closed Door;
- Door dependency set exactly both Plate IDs as an unordered A+B AND set;
- exactly one player-only EXIT beyond the Door;
- board no larger than 8×7;
- compact asymmetric early-divergence topology with one visible blocker/fork, two separated Plate pockets, a YOU staging lane, and one unavoidable Door articulation;
- each Plate has traversable graph distance greater than one move to the Door cell, with no one-turn Plate-to-Door shortcut;
- no second Door, third Plate, second dependency stage, or unknown field;
- no `best_turn_threshold`;
- no route/witness metadata;
- all critical entities and cues remain readable at 960×540.

Coordinates are implementation-selected. Re-author geometry rather than weakening the entity contract or proof gates.

## 6. Exact causal and necessity obligations

The accepted candidate must satisfy all of the following.

### 6.1 Required early divergence

Every shortest solution must contain an early post-activation transition before the final A+B setup where:

- one ECHO performs a cardinal action and is `BLOCKED`;
- the other ECHO performs a returned action and is `MOVED`;
- signed relative vector or Manhattan spacing changes;
- the event is visible through board geometry and accepted transition feedback;
- it is necessary to the later phase/role assignment, not optional spectacle;
- it is not a repeated-collision macro or literal WAIT lesson.

Record before/after positions, actual replay actions, outcomes, relative vectors, Manhattan spacing, and why the event is necessary.

### 6.2 Required A+B role result

Every shortest solution must contain a committed result where:

- E2 occupies Plate A;
- E4 occupies Plate B;
- YOU is staged for Door entry;
- the Door becomes open from A+B;
- the following input begins from the open snapshot and enters/crosses the Door;
- only YOU later completes at EXIT.

If shortest solutions reverse E2/E4 roles or admit another equivalent role mapping, stop and re-author unless a new GPT adjudication explicitly accepts that change. Do not silently weaken the role contract.

### 6.3 Dual-ECHO necessity

Run complete finite-state controls with the same formal geometry and accepted transition rules:

- no ECHO;
- E2 only;
- E4 only.

All three must be:

```text
UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE
```

without depth, state, time, or count limitation. Record visited states, frontier, and exhaustion status.

### 6.4 YOU-substitution exclusion

Prove both mechanically and by search/audit that YOU cannot replace E2 on A or E4 on B and still enter the Door:

- graph distance from each Plate to Door is greater than one;
- leaving a substituted Plate yields at most the following open start snapshot;
- YOU cannot reach the Door cell within that one input;
- no alternate shortcut, previously open state, side route, or overlap invalidates the argument;
- exhaustive single-ECHO searches remain unsolved.

### 6.5 Overlap and articulation

- one actor on an overlapped cell presses at most one Plate cell;
- actor overlap cannot satisfy A+B;
- Door cell lies on every YOU-to-EXIT terrain route;
- no side route, player-only route, or single-ECHO route bypasses the Door;
- ECHO on EXIT never completes; YOU on EXIT completes exactly.

## 7. Catalog and progression migration

Update only:

```text
data/catalog/level_catalog_v1.json
```

Required catalog result:

- exactly eight entries, sequences 1–8 with no gaps or duplicates;
- entries 1–6 retain byte-equivalent semantic fields, IDs, paths, order, classifications, HUD modes, and prerequisites;
- append bridge at sequence 7:

```json
{
  "level_id": "echo_spacing_bridge",
  "level_path": "res://data/levels/echo_spacing_bridge.json",
  "sequence": 7,
  "display_title_key": "level.echo_spacing_bridge.title",
  "classification": "standard",
  "unlock_prerequisites": ["staggered_doors"],
  "hud_mode": "STANDARD_COMPACT",
  "final_level": false
}
```

- existing `two_echo_convergence` moves to sequence 8;
- its prerequisite changes only from `staggered_doors` to `echo_spacing_bridge`;
- it remains the sole `final_level=true` entry;
- its level path, ID, display key, classification, HUD mode, and formal JSON remain unchanged;
- no `signal_convergence` entry;
- no `best_turn_threshold`;
- reset still unlocks only Tutorial 0;
- completion unlocks Levels 2–8 in order;
- bridge remains locked before Level 6 completion;
- Level 6 completion unlocks exactly bridge;
- bridge completion unlocks exactly `two_echo_convergence`;
- direct-level routing accepts bridge through the existing generic path without parser changes.

## 8. Prospective quantitative acceptance bands

The tracked bridge must satisfy every hard band:

```text
13 <= L* <= 16
2 <= N* <= 32
N* status = EXACT
3000 <= visited_states <= 25000
500 <= maximum_frontier <= 5000
```

Also require:

- exactly one dependency stage;
- useful A+B window width 1–2 result turns;
- 2–3 audited meaningful decisions;
- at least two recoverable non-optimal alternatives;
- measured burden materially lower than current Level 7 (`L*=19`, visited 61,975, frontier 21,449, six audited decisions);
- no literal WAIT requirement;
- selected shortest witness preferably contains no WAIT;
- no repeated blocked-input macro or corridor padding.

Starting solver limits:

```text
depth_limit = 64
state_limit = 500000
time_limit_ms = 30000
solution_count_cap = 1000000
```

A limit result is unverified. `UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE` is valid only after complete reachable-state exhaustion. Do not widen limits merely to force acceptance.

If no bounded candidate satisfies all bands and proof obligations, stop with:

```text
BLOCKED_NO_SCHEMA_V1_SEQUENCE_SOLUTION
```

Do not commit an out-of-band or mechanically weaker bridge.

## 9. Additional controlled variants

Run and record, using test-only variants that never enter the catalog:

1. isolate or relocate Plate A;
2. isolate or relocate Plate B;
3. replace A+B dependency with A-only;
4. replace A+B dependency with B-only;
5. remove the Door;
6. equalize delays to 2/2;
7. equalize delays to 4/4;
8. relocate the key blocker or one Plate to a declared control cell;
9. no-ECHO, E2-only, E4-only;
10. ECHO-on-EXIT and YOU-on-EXIT;
11. exact restart and witness replay.

Required interpretation:

- A-only/B-only and Door removal materially simplify or destroy the dual-ECHO teaching role;
- at least one blocker/Plate relocation destroys the required early divergence or role chain;
- equal-delay variants destroy or materially change the two-offset spacing lesson;
- no control ending at a resource limit is called unsolved;
- controlled variants are never staged as product content.

## 10. Meaningful-decision and recovery audit

Audit 2–3 meaningful decisions along a shortest witness. Each must:

- have a legal alternative with a distinct canonical successor;
- not be an input alias, forced corridor continuation, literal WAIT, or repeated collision;
- create a measurable penalty, missed divergence, changed role phase, recoverable branch, or complete failure;
- be explainable through visible actor positions, returned outcomes, Plate/Door state, or history phase.

At least two must involve genuine route/timing choices. Record minimum known penalties when established.

Audit at least two non-optimal alternatives that remain recoverable through bounded exact search or a short visible return route. Restart must not be the only comprehensible recovery.

## 11. Presentation and runtime validation

Use the existing reusable Gameplay and AppRoot paths without source modification.

Required checks:

- existing A/B labels, shapes, and Door pips identify both dependencies without new lines;
- E2/E4 badges/outlines remain distinct;
- Task 0015R divergence feedback truthfully reports required `BLOCKED/MOVED` event;
- stable spacing does not falsely trigger;
- bridge remains understandable if Timeline is ignored and Help is never opened;
- Help remains zero-turn and non-route;
- no new always-on dotted relationship line is added;
- existing prediction/dependency lines do not create a materially unreadable web;
- bridge, shifted current Level 7, and all earlier levels load through the same reusable Gameplay;
- progression, direct launch, completion, back/return, restart, reset, resize, and accepted window behavior remain normal;
- canonical state and simulation results are unchanged by presentation.

## 12. Tests and stable marker

Add focused tests under the minimum necessary subset of:

```text
tests/levels/
tests/gameplay/
tests/app/
```

Update:

```text
tests/run_all.gd
```

Cover at minimum:

1. strict formal cardinalities and schema load;
2. eight-entry catalog and exact sequence/prerequisite/final facts;
3. exact solver metrics and target bands;
4. witness replay and exact restart;
5. all-shortest required early `BLOCKED/MOVED` divergence;
6. all-shortest E2→A/E4→B A+B role result and open-snapshot crossing;
7. no-ECHO, E2-only, E4-only complete-unsolved controls;
8. YOU-substitution exclusion and Plate-to-Door distance;
9. overlap, Door articulation, and route-bypass audit;
10. Plate/dependency/Door/equal-delay/blocker controls;
11. ECHO/EXIT and YOU/EXIT behavior;
12. 2–3 meaningful decisions and two recoveries;
13. no unproven WAIT claim;
14. progression, direct route, bridge unlock, shifted Level 7 unlock, reset, and sole-final behavior;
15. reusable Gameplay and Task 0015R divergence feedback;
16. exact preservation of all seven prior hashes/metrics and byte-identical `two_echo_convergence`;
17. accepted Task 0011/0011R window/presentation invariants.

Add the stable marker:

```text
TASK_0017_ECHO_SPACING_BRIDGE_TESTS_PASS
```

Final aggregate must:

- exit 0;
- report assertions not lower than 391 and vectors exactly 9;
- include all prior ten markers exactly once;
- include the new Task 0017 marker exactly once;
- preserve all seven prior hashes and metrics;
- show only the accepted intentional `LEVEL_ID_MISMATCH` on stderr;
- contain no failed assertion, parser/script/runtime error, or crash.

## 13. Native capture validation

Create one focused native 960×540 capture harness under an authorized test path.

Capture at minimum:

1. Level Select with bridge locked;
2. Level Select after Level 6 unlocks bridge;
3. initial bridge with E2/E4 and A/B/A+B cues;
4. stable-spacing control with no false divergence cue;
5. required ECHO `BLOCKED/MOVED` spacing-change event;
6. post-divergence recovery/phase state;
7. simultaneous E2-on-A/E4-on-B A+B result;
8. following open-snapshot Door crossing;
9. bridge completion and shifted Level 7 unlock;
10. reduced-motion decision state;
11. grayscale decision state.

Use a standalone native Compatibility-renderer game window or accepted bounded capture method. Do not capture the full desktop or use embedded editor preview. Verify no material obstruction of YOU, ECHOs, Plates, Door, EXIT, goal, controls, completion, labels, pips, or outcome feedback.

## 14. External evidence

Authorized external root:

```text
D:\Delayed_Self_Evidence\0017_echo_spacing_bridge\
```

Record:

- executable identity and exact commands;
- bounded candidate ledger and rejection reasons;
- final formal file SHA-256;
- solver limits, witness, `L*`, exact `N*`, visited, frontier, and elapsed time if exposed;
- all-shortest divergence and role traces;
- complete control matrix and exhaustion status;
- YOU-substitution, overlap, articulation, and bypass evidence;
- meaningful-decision and recovery audit;
- catalog/progression trace;
- focused and aggregate stdout/stderr/native exits;
- native captures and presentation snapshots;
- all eight formal hashes after implementation;
- evidence index with timestamps, sizes, commands, and SHA-256.

Do not stage external evidence, screenshots, logs, `.godot`, generated UID files, imports, caches, or temporary candidates.

## 15. Narrow generated-file cleanup authorization

Run all required Godot tests/captures before staging. Close every Godot process before cleanup.

If and only if the post-run unexpected worktree state satisfies all of the following:

- `project.godot` is the only unintended modified tracked path;
- `project.godot` is not staged and is not conflicted;
- every untracked path reported by `git ls-files --others --exclude-standard` ends exactly in `.gd.uid`;
- there is at least one and no other untracked path;
- every UID path resolves under `D:\Delayed_Self`, is a regular file, and is not a tracked or staged path;
- all intended task changes are within the authorized surface below;
- no Godot process remains;

then this task explicitly authorizes:

```powershell
git restore --worktree --source=HEAD -- project.godot
```

and literal one-by-one deletion of the frozen Git-enumerated UID list:

```powershell
$UidPaths = @(git ls-files --others --exclude-standard | Sort-Object -Unique)
$UidPaths | ForEach-Object { Write-Host ('REMOVE_LITERAL ' + $_) }
foreach ($RelativePath in $UidPaths) {
    Remove-Item -LiteralPath (Join-Path 'D:\Delayed_Self' $RelativePath) -Force
}
```

Before deletion, print and externally record the exact list, require every entry to end in `.gd.uid`, reject `..`, directories, links/reparse points, and paths outside the repository. After cleanup, require `project.godot` blob hash to equal `HEAD:project.godot`, no UID/untracked path to remain, and no intended change to be lost.

This is not broad cleanup authority. Forbidden:

- `git clean`;
- wildcard deletion;
- recursive deletion;
- broad restore/checkout;
- reset, stash, rebase, amend, or force-push;
- deleting parent directories;
- cleanup of any path outside the exact conditions above.

If the unexpected set differs, stop with:

```text
BLOCKED_UNEXPECTED_WORKTREE_CHANGE
```

## 16. Authorized repository surface

May modify only the minimum necessary subset of:

- `data/levels/echo_spacing_bridge.json`;
- `data/catalog/level_catalog_v1.json`;
- one focused bridge validation test under `tests/levels/`;
- narrowly necessary focused Gameplay/AppRoot tests under `tests/gameplay/` or `tests/app/`;
- one focused native capture harness under `tests/gameplay/` or `tests/app/`;
- `tests/run_all.gd`;
- `docs/level_design/validation/ECHO_SPACING_BRIDGE_VALIDATION.md`;
- `docs/reports/0017_ECHO_SPACING_BRIDGE_IMPLEMENTATION_REPORT.md`;
- `docs/level_design/LEVEL_8_FINALE_AND_DIFFICULTY_BRIDGE_PLAN_CURRENT.md`, only to replace bridge proposal facts with exact implementation evidence after validation;
- `docs/level_design/INITIAL_LEVEL_ROADMAP_AND_VALIDATION_MATRIX_CURRENT.md`;
- `docs/level_design/FIVE_LEVEL_DIFFICULTY_RECOVERY_AND_LEVELS_6_8_PLAN.md`;
- narrowly necessary current startup/task/index/development/handoff/project-memory/presentation Markdown files.

Do not modify any prior task, report, review, acceptance, existing validation, existing formal level, source script, schema, scene, project setting, or product/release surface.

Before editing, print the exact selected path list. Before staging, prove only selected authorized paths changed.

## 17. Implementation report

Create:

```text
docs/reports/0017_ECHO_SPACING_BRIDGE_IMPLEMENTATION_REPORT.md
```

Include:

- task/start/final Git facts;
- candidate-authoring ledger and rejected-candidate count;
- exact formal level facts and topology rationale;
- catalog migration and rollback;
- solver limits, exact metrics, witness, and SHA-256;
- required early divergence trace;
- all-shortest E2→A/E4→B and open-snapshot traces;
- no-ECHO/E2-only/E4-only complete controls;
- YOU-substitution, overlap, articulation, bypass, Plate, dependency, Door, equal-delay, and relocation controls;
- meaningful decisions and recoveries;
- WAIT boundary;
- presentation, reduced-motion, grayscale, captures, and no-new-lines policy;
- all prior seven hashes/metrics plus bridge hash;
- complete aggregate output and stderr disposition;
- external evidence index;
- generated-file cleanup disposition;
- exact changed paths and protected surfaces;
- rollback procedure;
- non-claims and recommendation for GPT review followed by owner-only bridge sequence review.

Do not claim owner acceptance, fresh/independent evidence, final difficulty, fun, candidate status, finale implementation, production completeness, export, release, or submission readiness.

## 18. Git discipline

Before staging:

```powershell
git status --short --untracked-files=all
git diff --check
git diff --stat
git diff --name-only
```

Audit:

- only explicit authorized paths changed;
- all seven prior formal level files are byte-identical;
- `two_echo_convergence` is byte-identical and retains accepted hash/metrics;
- catalog migration is limited to bridge append and current Level 7 sequence/prerequisite adjustment;
- no source/schema/scene/project/Timeline/Help change;
- no generated UID, `.godot`, import, screenshot, log, evidence, cache, or temporary candidate is staged;
- all eleven markers pass;
- report avoids owner/finale/release overclaims.

Stage explicit files only. Do not use `git add .`, `git add -A`, broad globs, or broad pathspecs.

Then:

```powershell
git diff --cached --check
git diff --cached --stat
git diff --cached --name-only
```

Commit exactly once:

```text
feat: add Delayed Self echo spacing bridge
```

Immediately before push:

```powershell
git fetch origin
git rev-parse HEAD
git rev-parse origin/main
git status --short --untracked-files=all
```

Require no remote drift from the task publication point except the local implementation commit. Do not merge, rebase, amend, force-push, reset, or broadly restore.

Push normally to `origin/main`. Final worktree must be clean and `HEAD == origin/main`.

## 19. Terminal verdicts

After successful implementation, validation, one commit, push, and clean final audit, return:

```text
ECHO_SPACING_BRIDGE_READY_FOR_GPT_REVIEW
```

Include:

- commit SHA;
- bridge SHA-256;
- `L*`, exact `N*`, visited, frontier, and limits;
- shortest witness;
- early divergence summary;
- E2→A/E4→B and Door crossing summary;
- complete control matrix summary;
- meaningful-decision/recovery counts;
- aggregate assertions/vectors and all eleven markers;
- catalog/progression result;
- capture states;
- validation/report paths;
- external evidence root;
- generated-file cleanup disposition;
- final Git state.

Use the most specific blocker when applicable:

```text
BLOCKED_NO_SCHEMA_V1_SEQUENCE_SOLUTION
BLOCKED_BRIDGE_REQUIRES_FORBIDDEN_SURFACE
BLOCKED_BRIDGE_METRIC_OR_ROLE_TARGET_NOT_ESTABLISHED
BLOCKED_BASELINE_OR_FORMAL_REGRESSION
BLOCKED_PRESENTATION_READABILITY
BLOCKED_UNEXPECTED_WORKTREE_CHANGE
```

Do not substitute a weaker bridge, weaken necessity/metric bands, alter accepted Level 7, or proceed to the finale.
