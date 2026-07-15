# Task 0009A — Door timing and WAIT content batch

- Status: `READY`
- Gate: `IMPLEMENTATION / SCHEMA-V1 CONTENT BATCH A`
- Repository: `zcx369658780/delayed-self-godot`
- Expected branch: `main`
- Expected local root: `D:\Delayed_Self`
- Issued by: GPT Project Sources advisor
- Date: 2026-07-15
- Prior accepted gate: `TASK_0008_PROGRESSIVE_HUD_AND_OWNER_TUTORIAL_RETEST_ACCEPTED_WITH_OBSERVATIONS`
- Accepted owner-retest evidence commit: `9f5084219b801ec177a049b64bff52cdf4799843`
- Prior acceptance artifact: `docs/reports/0008_GPT_FINAL_ACCEPTANCE.md`
- Accepted progressive-HUD implementation: `3f35078b5d7e71db871140ca440c38069ea5d057`

## 1. Objective

Create, validate, solve, replay, catalog, and smoke-test the next two schema-v1 candidate levels without changing puzzle semantics or the accepted first three levels:

1. `door_one_turn_late` — teach that a Door state calculated after movement affects entry on the following turn, not retroactively during the same turn;
2. `wait_for_the_echo` — teach literal `WAIT` as an intentional scheduling action that is strictly useful relative to movement-only/blocked-move substitutes.

This is a bounded content batch. It must not create levels 6–8, add new mechanics, redesign the HUD/viewport, or implement any complete-flow/save/export surface.

## 2. Success criteria

Task 0009A succeeds only when:

1. both new formal levels are valid `level_v1` JSON and use only accepted schema-v1 mechanics;
2. the tracked catalog contains exactly five implemented levels in the accepted sequence;
3. the unlock chain is deterministic and linear through level 5;
4. one existing reusable Gameplay implementation hosts all five levels through catalog payloads;
5. `door_one_turn_late` is solver-solved and replayed, and its witness trace proves start-of-turn Door snapshot timing;
6. `wait_for_the_echo` is solver-solved and replayed, and machine evidence proves every optimal solution requires at least one literal `WAIT` relative to a no-WAIT action search that still permits blocked cardinal moves;
7. both levels have bounded mechanic-necessity and shortcut/bypass evidence;
8. the first three formal level files remain byte-for-byte unchanged and all accepted metrics remain unchanged;
9. all Task 0003/0006/0007/0008 markers remain passing;
10. no fresh-player, candidate, persistence, layout, export, release, or submission claim is introduced.

## 3. Mandatory startup gate

Before any write:

```powershell
Get-Location
git branch --show-current
git rev-parse HEAD
git rev-parse origin/main
git remote -v
git status --short --untracked-files=all
git log -18 --oneline --decorate
godot --version
```

Required conditions:

- absolute root is `D:\Delayed_Self`;
- branch is `main`;
- origin is the expected repository;
- local `HEAD` and `origin/main` contain this task and `docs/reports/0008_GPT_FINAL_ACCEPTANCE.md`;
- tracked worktree is clean;
- Godot resolves to the accepted standard `4.7.stable` toolchain.

If local is behind and clean, use only:

```powershell
git fetch origin
git merge --ff-only origin/main
```

Stop on divergence, conflict, remote mismatch, unexpected tracked changes, unsafe root, missing task/acceptance, inability to fast-forward, or materially different toolchain.

## 4. Required reads

Read in this order before editing:

1. `AGENTS.md`
2. `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`
3. `docs/CODEX_ACTIVE_TASK_CURRENT.md`
4. this task
5. `docs/reports/0008_GPT_FINAL_ACCEPTANCE.md`
6. `docs/reports/0008_OWNER_TARGETED_TUTORIAL_RETEST_REPORT.md`
7. `docs/reviews/0008_OWNER_TARGETED_TUTORIAL_0_1_RETEST.md`
8. `docs/reports/0008A_GPT_PHASE_A_ACCEPTANCE.md`
9. `docs/reports/0008_PROGRESSIVE_HUD_AND_COMPACT_TIMELINE_IMPLEMENTATION_REPORT.md`
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
20. both existing tutorial validation records
21. `scripts/simulation/simulation.gd`
22. `scripts/solver/bfs_solver.gd`
23. `scripts/gameplay/vertical_slice.gd`
24. `scripts/gameplay/timeline_model.gd`
25. AppRoot, catalog, and memory-progress code
26. `tests/run_all.gd` and focused level/gameplay tests
27. current plan/index/handoff/project-memory documents
28. puzzle-validation, Godot-safety, and evidence/independent-review project rules.

Before writing, print a concise summary of:

- accepted five-level roadmap role for levels 4–5;
- frozen rules, files, and metrics;
- proposed layouts and teaching proofs;
- Door-timing trace requirement;
- literal-WAIT optimality proof;
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
- blocked legal movement consumes a turn and records the original cardinal action;
- simultaneous actor movement against the same start-of-turn Door snapshot;
- Plate evaluation after movement and combinational AND Door calculation;
- newly calculated Door state affects entry on the following turn;
- only the current player reaching EXIT completes;
- restart, history, canonical-key, replay, and solver-status semantics;
- AppRoot route IDs and memory-only progress boundary;
- all three existing formal level files and topology;
- Tutorial 0 accepted metrics: `L*=3`, `N*=3 (EXACT)`, 6 visited, frontier 2;
- Tutorial 1 accepted metrics: `L*=9`, `N*=12 (EXACT)`, 1,975 visited, frontier 509, no-Echo complete unsolved with 10 states;
- vertical slice accepted metrics: `L*=9`, `N*=31 (EXACT)`, 1,318 visited, Echo-isolated complete unsolved with 1,006 states;
- progressive HUD behavior and the carried P2 observations concerning limited current Help utility and right-side crowding.

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

If either level appears to require a new goal, field, action, latch, switch, timer, hazard, push, teleport, route-sensitive actor rule, or simulation/solver change, stop with:

```text
BLOCKED_CONTENT_REQUIRES_UNSUPPORTED_MECHANIC
```

Do not use this task to address the carried 960×540 HUD crowding observation.

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
- no intentional requirement for literal `WAIT`;
- design target `L*` band 7–12, explicitly unverified until solver execution;
- geometry distinct from Tutorial 1 and the vertical slice;
- no direct path that bypasses the Door/Plate teaching event.

Teaching requirement:

- the player must encounter a state in which ECHO reaches Plate and the Door becomes open only in the resulting state;
- the player cannot enter the previously closed Door during that same transition;
- on the next submitted turn, the player can enter using the now-open start-of-turn Door snapshot.

Required machine evidence:

- strict loader validity;
- solver `SOLVED`;
- exact `L*` and exact/capped `N*`;
- one solver witness replayed to completion;
- an explicit two-transition trace proving the closed-snapshot turn followed by open-snapshot entry;
- controlled no-Echo or equivalent cooperation-necessity search;
- no player bypass around Door/Plate;
- ECHO on EXIT does not complete;
- exact restart;
- recorded depth/state/time/count limits, visited states, and maximum frontier.

If the shortest witness does not exercise the timing lesson, iterate the level. Do not accept a cosmetic Door level whose solution bypasses the intended rule.

## 7. Level 5 — `wait_for_the_echo`

Create:

```text
data/levels/wait_for_the_echo.json
```

Required formal properties:

- `schema_version=1`;
- `level_id="wait_for_the_echo"`;
- exactly one Echo with delay exactly `3`;
- exactly one Plate;
- exactly one combinational Door referencing that Plate;
- one player-only EXIT beyond or meaningfully gated by the Door;
- terrain only `#` and `.`;
- no unsupported metadata mechanics;
- bounded `recommended_search_depth`;
- design target `L*` band 9–15, explicitly unverified until solver execution;
- geometry distinct from all earlier levels;
- literal `WAIT` must be a meaningful optimal scheduling action, not decorative copy.

Required WAIT proof:

1. the full-action solver returns `SOLVED` with a witness containing at least one literal `WAIT`;
2. run a deterministic bounded search using the same canonical state and `Simulation.transition`, but with action expansion restricted to `UP`, `RIGHT`, `DOWN`, `LEFT`—blocked cardinal moves remain allowed and still consume turns;
3. the no-WAIT search must either:
   - exhaust the complete finite state unsolved; or
   - return a strictly larger shortest depth than the full-action `L*`;
4. therefore no optimal full-action solution can omit literal `WAIT`;
5. record the no-WAIT status, depth if solved, limits, visited states, and frontier.

A test-only validation helper may implement the restricted action expansion if the existing solver has no safe filter. It must use the shared transition and canonical key and must not become runtime gameplay authority. Do not alter accepted BFS semantics merely to obtain the result.

Additional required evidence:

- strict loader validity;
- exact/capped `N*` under the full action set;
- solver witness replay to completion;
- Echo cooperation necessity through a controlled no-Echo or equivalent complete search;
- no player bypass around Door/Plate;
- ECHO on EXIT does not complete;
- exact restart;
- shortcut audit that blocked movement does not provide an equal-depth substitute for literal `WAIT`.

If no-WAIT search produces an equal-depth solution, the level fails its teaching requirement and must be iterated or reported `BLOCKED_WAIT_NOT_MECHANICALLY_RELEVANT`.

## 8. Catalog and progress update

Update the tracked catalog to exactly these five entries:

| sequence | level_id | classification | prerequisite | hud_mode | final_level |
|---:|---|---|---|---|---|
| 1 | `tutorial_reach_exit` | `tutorial` | none | `INTRO_MINIMAL` | false |
| 2 | `tutorial_echo_bridge` | `tutorial` | `tutorial_reach_exit` | `GUIDED_ECHO` | false |
| 3 | `vertical_slice_delay_3` | `standard` | `tutorial_echo_bridge` | `STANDARD_COMPACT` | false |
| 4 | `door_one_turn_late` | `standard` | `vertical_slice_delay_3` | `STANDARD_COMPACT` | false |
| 5 | `wait_for_the_echo` | `standard` | `door_one_turn_late` | `STANDARD_COMPACT` | true |

Use stable title keys:

```text
level.door_one_turn_late.title
level.wait_for_the_echo.title
```

Do not add `best_turn_threshold` to any entry. Solver metrics are evidence, not product thresholds.

The catalog contract may be updated narrowly to describe the five-entry tracked state without changing catalog-v1 shape or authority.

In-memory progress tests must prove:

- only Tutorial 0 is initially unlocked;
- each completion unlocks only its direct successor;
- level 5 remains locked until level 4 completion;
- reset restores exact initial unlocks;
- no filesystem write occurs.

## 9. Validation records and roadmap status

Create:

```text
docs/level_design/validation/DOOR_ONE_TURN_LATE_VALIDATION.md
docs/level_design/validation/WAIT_FOR_THE_ECHO_VALIDATION.md
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
- mechanic-necessity evidence;
- shortcut/bypass audit;
- known limitations;
- explicit statement that fresh-player and candidate acceptance have not occurred.

Level 4 additionally records the exact two-transition Door timing trace.

Level 5 additionally records full-action versus no-WAIT search comparison and the blocked-move-substitute audit.

Update `docs/level_design/INITIAL_LEVEL_ROADMAP_AND_VALIDATION_MATRIX_CURRENT.md` narrowly to mark levels 4–5 with their evidenced status and metrics while retaining levels 6–8 as unverified concepts.

Neither new level may be called `FRESH_PLAYER_REVIEWED` or `CANDIDATE_ACCEPTED`.

## 10. Authorized repository changes

May create or modify only:

### Formal content/catalog

- `data/levels/door_one_turn_late.json`;
- `data/levels/wait_for_the_echo.json`;
- `data/catalog/level_catalog_v1.json`;
- `docs/architecture/LEVEL_CATALOG_V1_CURRENT.md` narrowly for five-entry tracked facts;
- `docs/level_design/INITIAL_LEVEL_ROADMAP_AND_VALIDATION_MATRIX_CURRENT.md` narrowly for evidenced status/metrics.

### Tests/validation tooling

- `tests/run_all.gd`;
- focused files under `tests/levels/` or `tests/solver/`;
- a test-only no-WAIT search helper under `tests/` if required;
- do not modify runtime solver/simulation/gameplay code.

### Records/docs

- the two required validation records;
- `docs/reports/0009A_DOOR_TIMING_AND_WAIT_CONTENT_BATCH_REPORT.md`;
- current startup/task/index/plan/handoff/project-memory documents as needed.

Do not modify any other path without stopping and requesting new authorization.

## 11. Automated validation

Use repository-only GDScript tests. Do not install plugins, frameworks, JSON-schema packages, or dependencies.

### 11.1 Baseline

Require before edits:

```text
TASK_0003_TESTS_PASS assertions=239 vectors=9
TASK_0006_APP_SHELL_TESTS_PASS
TASK_0007_TUTORIAL_LEVELS_TESTS_PASS
TASK_0008_PROGRESSIVE_HUD_TESTS_PASS
```

Also record all accepted first-three-level metrics and SHA-256 hashes before editing.

If baseline fails, stop with:

```text
BLOCKED_BASELINE_REGRESSION
```

### 11.2 New-level tests

For each new level:

- load through unchanged LevelLoader;
- assert normalized ID/cardinalities/references;
- construct and restart state;
- solve through accepted BFS;
- replay witness through shared transition;
- assert completed depth equals reported `L*`;
- assert `N*` status semantics;
- record limits/resources;
- run required necessity/bypass/EXIT-role checks.

Level 4 must assert the two-transition start-snapshot timing trace.

Level 5 must assert the full-action versus no-WAIT result and that no-WAIT does not match full `L*` even though blocked cardinal turns remain legal.

### 11.3 Catalog/progress/routing tests

Verify:

- tracked five-entry catalog validates and normalizes in sequence;
- exactly one final entry, level 5;
- all paths/formal IDs/title keys/classifications/HUD modes/prerequisites match this task;
- exact linear unlock progression through all five levels;
- reset/no-write behavior;
- all five IDs route through the same gameplay implementation;
- locked/unknown IDs still reach Safe Error and construct no partial gameplay state;
- development `--level-id` accepts all five tracked IDs;
- AppRoot owns one active routed screen.

### 11.4 Regression integrity

Verify:

- the first three formal JSON hashes are unchanged;
- all first-three-level solver/replay/necessity metrics are unchanged;
- progressive HUD/time-line/help tests remain passing;
- no runtime code changed.

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
TASK_0009A_LEVELS_4_5_TESTS_PASS
```

Any failure must exit non-zero.

## 12. Runtime and external evidence

This task authorizes creation/use of exactly:

```text
D:\Delayed_Self_Evidence\0009A_levels_4_5\
```

Check for safe non-conflicting use first. Do not delete, move, rename, or overwrite unrelated evidence.

Required bounded evidence:

- baseline and final headless logs;
- standalone solver/replay summaries for both levels;
- Level 4 Door-timing trace log;
- Level 5 full-action and no-WAIT comparison logs;
- cooperation-necessity/bypass logs;
- normal AppRoot launch log;
- development direct-level launch logs for both new IDs;
- game-root-only 960×540 captures for each new level at initial, teaching-event, and completed states;
- Level Select capture showing five entries and bounded unlock progression where reproducible;
- evidence index with commands, timestamps, filenames, sizes, and hashes.

Do not stage screenshots, raw logs, `.godot/`, imports, or external evidence. Do not capture the whole desktop automatically.

## 13. Required report

Create:

```text
docs/reports/0009A_DOOR_TIMING_AND_WAIT_CONTENT_BATCH_REPORT.md
```

The report must include:

- verdict;
- task/start/final Git facts;
- exact changed paths;
- both level designs and why they differ from earlier content;
- actual solver/replay metrics;
- Level 4 timing trace;
- Level 5 WAIT/no-WAIT proof;
- necessity and bypass evidence;
- five-entry catalog/unlock facts;
- baseline/final markers and first-three hashes/metrics;
- external evidence index;
- protected surfaces and non-claims;
- unresolved owner/fresh-player/layout observations;
- recommended next gate.

## 14. Git discipline and authorization

Before staging:

```powershell
git status --short --untracked-files=all
git diff --check
git diff --stat
```

Audit:

- authorized paths only;
- no accepted formal file changed;
- no runtime/schema/contract change;
- no unsupported mechanic;
- no invented solver/human claim;
- no `best_turn_threshold`;
- no external evidence staged;
- no secret/private data;
- links resolve;
- Tasks 0009B/later are recommendations only.

Stage explicit paths only. Never use broad staging.

Then:

```powershell
git diff --cached --check
git diff --cached --stat
git diff --cached --name-only
```

This task authorizes one focused implementation/content/documentation commit:

```text
feat: add Delayed Self door timing and wait levels
```

Immediately before push:

```powershell
git fetch origin
git rev-parse HEAD
git rev-parse origin/main
git status --short --untracked-files=all
```

Stop on remote drift. Do not merge, rebase, amend, force-push, or create a second commit without new authorization.

## 15. Stop conditions

Stop with the most specific verdict if:

- baseline/root/branch/remote/toolchain gate fails;
- content needs unsupported mechanics or semantic changes;
- accepted files/metrics regress;
- either level remains unsolved or only reaches a solver limit;
- Level 4 shortest evidence bypasses next-turn timing;
- Level 5 no-WAIT search matches the full optimal depth;
- catalog/unlock progression fails;
- source becomes unexpectedly dirty;
- evidence path conflicts;
- remote drifts before push.

Do not call a limited search unsolvable. Do not weaken fixtures or acceptance criteria to obtain a pass.

## 16. Terminal verdicts

Use exactly one:

- `PASS_FOR_GPT_REVIEW`
- `PASS_WITH_OBSERVATIONS_FOR_GPT_REVIEW`
- `BLOCKED_BASELINE_REGRESSION`
- `BLOCKED_CONTENT_REQUIRES_UNSUPPORTED_MECHANIC`
- `BLOCKED_DOOR_TIMING_NOT_EXERCISED`
- `BLOCKED_WAIT_NOT_MECHANICALLY_RELEVANT`
- `BLOCKED_SOLVER_LIMIT`
- `BLOCKED`

## 17. Next gate

After GPT acceptance, recommend one of:

- `Task 0009V — owner/four-to-five-level sequence review` if a sequence usability check is needed before more content;
- `Task 0009B — AND Door, staggered Doors, and multi-delay finale content batch` if automated evidence is strong and schedule permits;
- a focused repair task if P0/P1 or content-validation defects appear.

A qualifying fresh-player or independent review remains mandatory before candidate acceptance even if Task 0009B later proceeds.
