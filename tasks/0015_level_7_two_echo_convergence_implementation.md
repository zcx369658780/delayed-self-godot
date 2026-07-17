# Task 0015 — Implement and formally validate Level 7 `two_echo_convergence`

- Status: `READY`
- Gate: `IMPLEMENTATION + FORMAL VALIDATION / TWO-ECHO CONTENT`
- Repository: `zcx369658780/delayed-self-godot`
- Expected branch: `main`
- Expected local root: `D:\Delayed_Self`
- Issued by: GPT Project Sources advisor
- Date: 2026-07-17
- Publication baseline: `677eb6c3877d75f87f423cca0847a9a678559458`
- Prior accepted gate: `TASK_0014_LEVEL_7_IMPLEMENTATION_PLAN_ACCEPTED`
- Accepted planning commit: `e964518172add3c36523a0989d5d1eab11740b33`
- Planning acceptance: `docs/reports/0014_GPT_FINAL_ACCEPTANCE.md`
- Frozen plan: `docs/level_design/LEVEL_7_TWO_ECHO_CONVERGENCE_PLAN_CURRENT.md`
- Accepted Level 6 implementation: `1e43e9baa82a578fdb14f556e4895d42863513d9`

## 1. Objective

Implement and formally validate the seventh catalog level:

```text
two_echo_convergence / Two Echo Convergence / 双影汇流
```

The level must introduce one clean new temporal obligation: two ECHOs with different delays replay the same input history and converge simultaneously on two distinct Plates, creating one short `A+B` Door-opening window while YOU is positioned to cross on the following open start-turn snapshot.

The task must deliver:

1. one schema-v1 formal Level 7 JSON;
2. one seven-entry catalog update with exact progression and final-flag transfer;
3. exact solver/replay/restart evidence inside the frozen target bands;
4. decisive necessity, equal-delay, dependency, relocation, overlap, articulation, shortcut, and recovery controls;
5. only the minimum reusable primitive A/B, E2/E4, `A+B`, and overlap cues accepted by Task 0014;
6. focused automated and capture evidence plus the full aggregate regression;
7. one validation document and one implementation report;
8. exact project-source synchronization;
9. one single-topic implementation commit pushed normally to `origin/main`.

The task ends at `INTERNAL_PLAYABLE` evidence ready for GPT review. It does not include owner playtesting or candidate acceptance.

## 2. Mandatory startup gate

Before any write or Godot launch:

```powershell
Get-Location
git branch --show-current
git rev-parse HEAD
git rev-parse origin/main
git remote -v
git status --short --untracked-files=all
git log -36 --oneline --decorate
godot --version
Get-Command godot | Format-List Source,Version,CommandType
```

Required:

- absolute root exactly `D:\Delayed_Self`;
- branch `main`;
- expected origin;
- fully clean tracked and untracked worktree;
- `HEAD == origin/main` and both contain this task, `docs/reports/0014_GPT_FINAL_ACCEPTANCE.md`, and the accepted Task 0014 plan;
- Godot `4.7.stable.steam.5b4e0cb0f`, unless the current environment record documents an accepted exact equivalent.

If clean local `main` is behind, use only:

```powershell
git fetch origin
git merge --ff-only origin/main
```

Stop on divergence, conflict, unexpected files, wrong root/remote, inability to fast-forward, missing accepted artifacts, or a materially different toolchain.

## 3. Required reads

Read in order:

1. `AGENTS.md`;
2. `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`;
3. `docs/CODEX_ACTIVE_TASK_CURRENT.md`;
4. this task;
5. `docs/reports/0014_GPT_FINAL_ACCEPTANCE.md`;
6. `docs/level_design/LEVEL_7_TWO_ECHO_CONVERGENCE_PLAN_CURRENT.md`;
7. `docs/reports/0014_LEVEL_7_TWO_ECHO_CONVERGENCE_PLANNING_REPORT.md`;
8. `docs/reports/0013B_GPT_FINAL_ACCEPTANCE.md` and the Task 0013B owner review;
9. `docs/reports/0012_GPT_FINAL_ACCEPTANCE.md` and the exact Level 6 report;
10. `docs/game_design/GAMEPLAY_SIMULATION_CONTRACT_CURRENT.md`;
11. `docs/level_design/LEVEL_SCHEMA_V1_CURRENT.md` and `schemas/level_v1.schema.json`;
12. `docs/architecture/LEVEL_CATALOG_V1_CURRENT.md` and the tracked catalog;
13. all six accepted formal level JSON files and their current validation facts;
14. `scripts/gameplay/vertical_slice.gd` and its presentation/capture tests;
15. current solver, loader, aggregate tests, progression tests, catalog tests, capture harnesses, and focused Level 6 tests;
16. current presentation direction, roadmap, development plan, handoff, project memory, and documentation index;
17. Git, Godot-safety, puzzle-validation, privacy, external-evidence, and owner-only-review rules.

Before editing, print a concise implementation plan containing:

- bounded geometry-authoring strategy and iteration cap;
- exact entity IDs, delays, dependency set, and catalog entry;
- intended two-ECHO convergence/open-snapshot trace;
- hard metric bands and starting limits;
- every required control family;
- meaningful-decision and recovery audit method;
- reusable presentation-cue strategy and exact source path selected;
- test/capture plan and exact marker spelling;
- exact authorized files selected;
- stop, rollback, and no-overclaim conditions.

## 4. Frozen authorities and protected surfaces

Treat as immutable:

- Godot 4.7 stable, GDScript, Compatibility renderer, Windows primary target;
- 960×540 logical presentation, 60 px cells, current window policy;
- `simulation_v1` action order and all delay/history semantics;
- blocked legal moves consuming a turn and entering history;
- same start-turn Door snapshot, simultaneous settlement, legal actor overlap, post-movement Plate evaluation, combinational AND Doors, next-turn effect, and player-only EXIT;
- exact restart, replay, canonical-key, and deterministic BFS semantics;
- strict UTF-8 `level_v1` and catalog-v1 validation;
- all six accepted level files, hashes, metrics, controls, and accepted runtime behavior;
- catalog order 1–6 except the exact authorized append and Level 6 final-flag transfer;
- current Timeline indexing, layout, visibility rules, and text generation;
- current Help modal structure and zero-turn behavior;
- WAIT as `DEFERRED_VALIDATION_RESEARCH`;
- Gate as `DRAFT_NOT_ACCEPTED`;
- owner-only playtest constraint and `FRESH_INDEPENDENT_REVIEW_UNAVAILABLE_BY_OWNER_CONSTRAINT`.

Do not modify:

- `project.godot`;
- `scripts/simulation/`;
- `scripts/solver/`;
- `scripts/app/`;
- any gameplay script other than the exact authorized minimum change to `scripts/gameplay/vertical_slice.gd`;
- `scripts/gameplay/timeline_model.gd`;
- scenes;
- schemas or catalog contracts;
- any of the six existing formal level JSON files;
- normative fixtures or accepted contracts;
- GDD or project-rule files;
- assets, fonts, audio, music, SFX, animation resources, shaders, imports, plugins, or dependencies;
- persistence, settings, user-data behavior, export, build, release, account, repository settings, or submission surfaces.

If the target cannot be implemented without changing runtime, solver, schema, scene structure, project settings, Timeline, Help architecture, or another protected surface, stop with:

```text
BLOCKED_LEVEL_7_REQUIRES_RUNTIME_SCHEMA_OR_BROADER_PRESENTATION_CHANGE
```

## 5. Formal Level 7 contract

Create exactly:

```text
data/levels/two_echo_convergence.json
```

Required facts:

- `schema_version = 1`;
- `level_id = "two_echo_convergence"`;
- title exactly `Two Echo Convergence`;
- exactly one current player;
- exactly two ECHOs;
- exact ECHO IDs `echo_near` and `echo_late`;
- `echo_near.delay = 2`;
- `echo_late.delay = 4`;
- YOU and both ECHOs share the same declared spawn;
- exactly two Plates, IDs `plate_a` and `plate_b`;
- exactly one Door, ID `door_convergence`;
- Door dependency exactly `all_plate_ids=[plate_a, plate_b]` as an unordered AND-set;
- Door initially closed;
- exactly one player-only EXIT beyond the Door;
- exactly 9 columns × 7 rows;
- compact figure-eight/recovery topology plus one convergence lane;
- `door_convergence` is a terrain articulation on every YOU-to-EXIT path;
- at least one necessary simultaneous two-ECHO occupancy window of width 1–2 turns;
- at least four meaningful decisions and three audited recoverable wrong choices;
- no unknown field, best-turn threshold, new mechanic metadata, or hidden rule;
- no long forced corridor, WAIT padding, repeated blocked-input macro, or blind movement loop used to inflate difficulty.

The Task 0014 sketch and seed coordinates are authoring guidance, not accepted coordinates. Bounded coordinate adjustment is authorized only while preserving the frozen envelope, entity cardinalities, topology, articulation, two-action Plate-separation hypothesis, proof obligations, and Level 8 role.

## 6. Catalog and progression

Update only:

```text
data/catalog/level_catalog_v1.json
```

Required final catalog:

- exactly seven entries, sequence 1–7;
- entries 1–6 preserve IDs, paths, order, classifications, HUD modes, and prerequisites;
- Level 6 `staggered_doors.final_level` changes from `true` to `false`;
- append exactly:

```json
{
  "level_id": "two_echo_convergence",
  "level_path": "res://data/levels/two_echo_convergence.json",
  "sequence": 7,
  "display_title_key": "level.two_echo_convergence.title",
  "classification": "standard",
  "unlock_prerequisites": ["staggered_doors"],
  "hud_mode": "STANDARD_COMPACT",
  "final_level": true
}
```

- no `best_turn_threshold`;
- exactly one final entry;
- Level 7 locked initially and before Level 6 completion;
- Level 6 completion unlocks exactly Level 7;
- reset restores only Tutorial 0 unlocked;
- direct-level generic parsing accepts `two_echo_convergence` without parser changes;
- Safe Error behavior remains unchanged.

## 7. Hard quantitative acceptance targets

The final tracked candidate must satisfy every hard band:

```text
17 <= L* <= 25
1 <= N* <= 8
N* status = EXACT
8000 <= visited_states <= 150000
1000 <= maximum_frontier <= 25000
required two-ECHO convergence window = 1–2 turns
meaningful decisions >= 4
audited recoverable wrong choices >= 3
```

Starting limits:

```text
depth_limit = 64
state_limit = 500000
time_limit_ms = 30000
solution_count_cap = 1000000
```

Record:

- exact limits and solver status;
- `L*`, exact `N*`, visited states, maximum frontier, and elapsed time if exposed;
- one shortest action witness;
- all shortest solutions or exact bounded enumeration sufficient to audit all shortest solutions;
- formal file SHA-256;
- terrain/floor/entity summary;
- candidate/re-authoring iteration count.

A timeout, depth limit, state limit, or count cap is never exact or complete evidence. Do not widen limits merely to force acceptance. If no bounded candidate meets every hard band and proof obligation, do not commit an out-of-band formal level; stop with:

```text
BLOCKED_LEVEL_7_TARGET_OR_EXACTNESS_NOT_ESTABLISHED
```

## 8. Required convergence and open-snapshot proof

For every accepted shortest solution, prove:

1. `echo_near` and `echo_late` read the same history at offsets 2 and 4;
2. the two named ECHOs occupy distinct `plate_a` and `plate_b` cells simultaneously in the required result state;
3. both Plate contributions are active in that committed result;
4. `door_convergence` becomes open only from the A+B result;
5. YOU begins the crossing input from a state whose start-turn Door snapshot is open;
6. YOU enters or crosses the Door on that input;
7. the Door may close later without invalidating an occupant, consistent with the accepted contract;
8. ECHO overlap elsewhere never substitutes one actor for both Plate cells;
9. no accepted shortest solution bypasses the required convergence.

Record an actor-role trace mapping exact ECHO IDs, delays, history slots, positions, Plate IDs, Door state, and YOU position across the critical turns. Presentation output is not the source of simulation truth.

## 9. Mandatory control package

Use schema-valid, test-only controlled variants. Never add controls to the product catalog.

### 9.1 Individual ECHO necessity

Run separately:

- remove/isolate `echo_near` while retaining `echo_late`;
- remove/isolate `echo_late` while retaining `echo_near`.

Each must exhaust the complete reachable finite state space as unsolved. Record visited states and limits. A player-plus-one-ECHO solution is a target failure, not an acceptable caveat.

### 9.2 No-ECHO/player-only control

A schema-valid no-ECHO test control must exhaust the complete finite state space as unsolved. Record visited states and limits.

### 9.3 Plate necessity

Isolate or relocate `plate_a` and `plate_b` separately using declared valid control cells. Each must exhaust the complete finite state space as unsolved. Explain why each control preserves a fair test of necessity rather than accidentally walling off the map.

### 9.4 Dependency replacements

Replace the formal AND-set separately with A-only and B-only. For each variant record exact solver status and metrics. Each must materially simplify the exact structure and eliminate the required two-ECHO teaching role. Do not call a merely different equivalent solution a successful control.

### 9.5 Equal-delay controls

Run exact 2/2 and 4/4 delay variants. Each must destroy or materially change the intended two-offset convergence, with exact solver status/metrics and an explicit role-trace comparison. If either preserves an equivalent shortest convergence using indistinguishable actor roles, reject the formal layout.

### 9.6 Door, articulation, and bypass

- remove/neutralize `door_convergence` and record the exact structural change;
- prove the Door cell is an articulation on every YOU-to-EXIT terrain route;
- prove no side route, player-only route, single-ECHO route, overlap exploit, or repeated movement cycle bypasses the convergence;
- prove no actor can occupy two distinct Plate cells simultaneously;
- prove a wider persistent opening does not erase the required 1–2-turn timing obligation.

### 9.7 EXIT, replay, and restart

- ECHO on EXIT is non-terminal;
- YOU on EXIT completes exactly;
- restart reconstructs the exact initial state;
- solver witness replay and Gameplay replay agree under the same actions;
- no dropped, duplicated, reordered, or synthetic input occurs.

A resource-limited control is `UNVERIFIED`, not complete-unsolved.

## 10. Meaningful-decision and recovery audit

Document at least four meaningful decisions along an accepted shortest witness.

Each must:

- have at least one legal alternative producing a distinct canonical successor;
- not be a forced corridor step, input alias, repeated collision, or WAIT padding;
- change route assignment, future ECHO separation, convergence timing, Door commitment, or recovery;
- have a measured consequence from exact/bounded search or replay;
- be explainable from visible positions and accepted rules.

At least three plausible wrong choices must remain recoverable with a target minimum penalty of 2–6 additional actions. Record exact or bounded minimum penalty and the visible reason for failure/recovery. If difficulty comes mainly from hidden soft locks, unreadable overlap, reverse-counting, corridor length, repeated blocked moves, or literal WAIT, reject the candidate.

Literal WAIT is not a teaching goal and does not count toward either audit. If a shortest witness contains WAIT, do not claim necessity. Prefer re-authoring; if accepting it would reopen strict WAIT research, stop with:

```text
BLOCKED_LEVEL_7_REOPENS_WAIT_RESEARCH
```

## 11. Minimum reusable presentation cues

A narrow change to:

```text
scripts/gameplay/vertical_slice.gd
```

is authorized only for the accepted reusable primitive cues below.

The implementation must remain data/contract-derived and must not hardcode a solution or movement route. Prefer generic activation for a multi-ECHO/multi-dependency level rather than a one-off `level_id` branch.

Required Level 7 result:

- `plate_a` is persistently labeled `A` and uses a triangular/pip identity;
- `plate_b` is persistently labeled `B` and uses a circular/pip identity;
- the Door visibly expresses `A + B`;
- each Door contribution is independently filled/unfilled from committed Plate occupancy;
- `echo_near` carries a stable `E2` badge and one persistent outline style;
- `echo_late` carries a stable `E4` badge and a materially different persistent outline style;
- when the ECHOs overlap, both outlines and both badges remain readable rather than collapsing into one actor;
- supplementary colors may differ, but label/shape/outline are sufficient without color;
- cues remain legible at 960×540 with 60 px cells;
- grayscale capture preserves A/B, shapes, E2/E4, outline, and filled/unfilled distinctions;
- YOU, EXIT, Door state, and actor occupancy remain readable;
- connecting lines remain optional reinforcement and do not cross unrelated entities or become the only dependency cue.

Preserve prior-level behavior. Existing levels must remain playable and their accepted presentation tests must pass. Do not redesign or modify:

- Timeline model, indexing, compact/expanded text, or visibility policy;
- Help modal architecture or general Help copy;
- right-rail layout;
- scenes, fonts, assets, shaders, animation system, or window policy.

Task 0014 decisions remain:

```text
TIMELINE_REMOVED_FROM_LEVEL_7_TEACHING_GOAL
HELP_CONTEXTUAL_OPTIONAL
```

Level 7 must be understandable and formally playable without opening either surface. Owner-review success will not require Timeline or Help use.

If the primitive cues cannot be made readable within this one-script boundary without harming prior levels, stop with:

```text
BLOCKED_LEVEL_7_PRESENTATION_CUES_REQUIRE_SEPARATE_REDESIGN
```

## 12. Runtime, progression, and capture smoke

Use only the existing reusable Gameplay/AppRoot paths.

Required runtime checks:

- seven-entry catalog loads;
- initial Level Select shows only Tutorial 0 unlocked;
- accepted completion chain unlocks Levels 2–7 in exact order;
- Level 7 remains locked before Level 6 completion;
- Level 6 completion unlocks exactly Level 7;
- selecting Level 7 loads the matching formal ID and `STANDARD_COMPACT`;
- direct launch loads Level 7 through the existing generic route;
- solver witness replays through reusable Gameplay to completion;
- completion/return behavior remains normal;
- reset restores exact initial unlock state;
- Timeline remains optional/inherited and no reverse-counting is required by the level proof;
- Help remains modal and zero-turn;
- A/B, `A+B`, E2/E4, overlap, Door state, and EXIT are readable at 960×540;
- rapid input order, resize/window behavior, Task 0011 presentation, and Task 0011R window-fill invariants remain accepted.

Capture game-window-only evidence of:

1. Level Select with Level 7 locked;
2. Level Select after Level 6 unlocks Level 7;
3. initial Level 7 showing A/B, `A+B`, E2/E4;
4. an E2/E4 overlap state;
5. the simultaneous convergence result;
6. the following open-snapshot Door crossing;
7. Level 7 completion;
8. a grayscale version of a representative decision frame.

Do not capture the full desktop automatically.

## 13. Automated tests and marker contract

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

Minimum coverage:

1. strict load and exact formal cardinalities/IDs/delays;
2. seven-entry catalog and exact final/progression facts;
3. solver `SOLVED`, all hard bands, exact `N*`, witness replay, restart, and SHA-256;
4. all-shortest convergence/open-snapshot proof;
5. both single-ECHO complete-unsolved controls;
6. no-ECHO complete-unsolved control;
7. both Plate-isolation complete-unsolved controls;
8. A-only/B-only dependency controls;
9. 2/2 and 4/4 equal-delay controls;
10. Plate relocation, Door removal, articulation, overlap, EXIT, and bypass controls;
11. at least four meaningful-decision records and three recovery traces;
12. no unproven WAIT claim;
13. reusable Gameplay, direct route, progression, completion, and reset smoke;
14. A/B, `A+B`, E2/E4, overlap, 960×540, and grayscale presentation snapshots;
15. Timeline/Help behavior unchanged and optional;
16. all six prior formal hashes, accepted metrics, catalog facts, and runtime behavior unchanged;
17. all prior aggregate markers unchanged.

Add exactly this stable marker:

```text
TASK_0015_LEVEL_7_TWO_ECHO_CONVERGENCE_TESTS_PASS
```

The final aggregate output must contain each prior marker exactly once plus the new marker exactly once:

```text
TASK_0003_TESTS_PASS assertions=<strictly greater than 349> vectors=9
TASK_0006_APP_SHELL_TESTS_PASS
TASK_0007_TUTORIAL_LEVELS_TESTS_PASS
TASK_0008_PROGRESSIVE_HUD_TESTS_PASS
TASK_0009AR_LEVELS_4_5_TESTS_PASS
TASK_0011_PRESENTATION_RECOVERY_TESTS_PASS
TASK_0011R_WINDOW_FILL_TESTS_PASS
TASK_0012_LEVEL_6_STAGGERED_DOORS_TESTS_PASS
TASK_0015_LEVEL_7_TWO_ECHO_CONVERGENCE_TESTS_PASS
```

The canonical Level 7 marker spelling is the exact string above. Do not abbreviate it in the report or future current documents.

Any failed assertion, missing/duplicate marker, parser/script/runtime error, crash, nonzero native exit, prior hash/metric drift, incomplete solver status, or unexpected stderr beyond accepted negative paths fails the task.

The intentional `LEVEL_ID_MISMATCH` negative-path stderr may appear in a passing suite; authoritative signals remain native exit, failed assertions/unhandled errors, and exact marker completeness.

## 14. External evidence

Authorized external root:

```text
D:\Delayed_Self_Evidence\0015_two_echo_convergence\
```

It may contain only bounded:

- candidate iteration ledger;
- exact commands, executable identity, native exit, stdout/stderr;
- solver limits, metrics, witness, hashes, and replay traces;
- all control outcomes and complete/incomplete boundaries;
- all-shortest convergence trace;
- meaningful-decision and recovery audits;
- catalog/progression trace;
- approved game-window-only captures and grayscale derivative;
- evidence index with timestamp, size, command/source, and SHA-256.

Do not stage or commit external evidence, screenshots, logs, `.godot/`, generated `.gd.uid`, imports, temporary candidates, or user data. Never delete or overwrite unrelated evidence.

If Godot creates unexpected repository files, stop before cleanup unless an existing durable rule explicitly authorizes exact safe handling. Do not infer cleanup authority from prior one-off incidents.

## 15. Validation and implementation report

Create exactly:

```text
docs/level_design/validation/TWO_ECHO_CONVERGENCE_VALIDATION.md
docs/reports/0015_LEVEL_7_TWO_ECHO_CONVERGENCE_IMPLEMENTATION_REPORT.md
```

The validation document must include:

- formal facts and SHA-256;
- target bands versus exact results;
- limits and exactness;
- shortest witness and all-shortest convergence statement;
- critical actor-role/open-snapshot trace;
- both ECHO, no-ECHO, Plate, dependency, equal-delay, relocation, Door, articulation, overlap, EXIT, and bypass controls;
- meaningful-decision and recovery audits;
- presentation-cue snapshot facts;
- prior-level preservation;
- explicit non-claims.

The implementation report must include:

- task and start/final Git facts;
- bounded authoring summary and candidate iteration count;
- final geometry/entity/dependency facts;
- exact metrics, limits, witness, frontier, elapsed time if available, and SHA-256;
- complete proof/control matrix with complete/limited status;
- progression, runtime, presentation, capture, and aggregate results;
- assertion/vector count and all nine exact markers;
- changed paths, protected surfaces, and external evidence index;
- rollback instructions;
- non-claims and next-gate recommendation.

Do not claim fresh-player review, independent review, population difficulty/fun, candidate acceptance, final art/audio, complete flow, export, release, or submission readiness.

## 16. Project-source synchronization

After exact validation, update only the necessary subset of:

```text
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/level_design/LEVEL_7_TWO_ECHO_CONVERGENCE_PLAN_CURRENT.md
docs/level_design/INITIAL_LEVEL_ROADMAP_AND_VALIDATION_MATRIX_CURRENT.md
docs/level_design/FIVE_LEVEL_DIFFICULTY_RECOVERY_AND_LEVELS_6_8_PLAN.md
docs/ux/PRESENTATION_VIEWPORT_AND_HUD_DIRECTION_CURRENT.md
```

Synchronize exact facts only after validation. Mark Level 7 no higher than `INTERNAL_PLAYABLE / PENDING GPT REVIEW`. Preserve:

- Level 8 as concept/proposal only;
- Timeline and Help decisions;
- owner-only review constraint;
- fresh/independent evidence as unavailable and not claimed;
- all production, complete-flow, export, release, and submission gates as unauthorized.

Do not modify Task 0014, prior reports/reviews/acceptances, GDD, project rules, accepted contracts, or historical artifacts.

## 17. Authorized repository surface

May modify only the minimum necessary subset of:

- `data/levels/two_echo_convergence.json` — new formal level;
- `data/catalog/level_catalog_v1.json` — exact append and Level 6 final-flag transfer;
- `scripts/gameplay/vertical_slice.gd` — only accepted reusable primitive cues;
- `tests/run_all.gd`;
- focused tests/capture harnesses under `tests/levels/`, `tests/gameplay/`, or `tests/app/`;
- `docs/level_design/validation/TWO_ECHO_CONVERGENCE_VALIDATION.md`;
- `docs/reports/0015_LEVEL_7_TWO_ECHO_CONVERGENCE_IMPLEMENTATION_REPORT.md`;
- the exact necessary subset of current documents listed in Section 16.

Before editing, print the exact selected paths. Do not broaden scope silently.

## 18. Pre-staging validation and Git discipline

Before staging:

```powershell
git status --short --untracked-files=all
git diff --check
git diff --stat
```

Audit:

- only explicitly selected authorized paths changed;
- all six existing formal level files are byte-identical;
- no simulation, solver, app, scene, schema, project-setting, Timeline-model, Help-architecture, asset, import, dependency, or user-data change;
- catalog change is limited to Level 6 final flag and Level 7 append;
- presentation change is narrow, reusable, contract-derived, and contains no route/solution hardcoding;
- no generated UID, `.godot`, screenshot, log, evidence, temporary candidate, asset, or import is staged;
- every hard band and proof obligation passes;
- all nine exact markers pass;
- documentation does not overclaim human or candidate acceptance.

Stage explicit files only. Never use `git add .`, `git add -A`, broad globs, or broad pathspecs.

Then run:

```powershell
git diff --cached --check
git diff --cached --stat
git diff --cached --name-only
```

Commit exactly once:

```text
feat: add Delayed Self two echo convergence level
```

Immediately before push:

```powershell
git fetch origin
git rev-parse HEAD
git rev-parse origin/main
git status --short --untracked-files=all
```

Require no remote drift from this task publication point. Push normally to `origin/main`.

Forbidden:

- merge commit;
- rebase;
- amend;
- squash;
- force-push;
- reset;
- broad restore/checkout;
- broad staging;
- modifying prior acceptance artifacts;
- committing external evidence;
- a second implementation commit for the same task.

After push require a clean worktree and `HEAD == origin/main`.

## 19. Terminal verdicts

After one successful implementation/documentation commit and normal push:

```text
PASS_FOR_GPT_REVIEW
```

Report immediately above it:

- implementation commit SHA;
- final `L*`, exact `N*`, visited, frontier, and limits;
- shortest witness;
- convergence/open-snapshot proof summary;
- complete control matrix summary;
- meaningful-decision and recovery counts;
- assertion/vector count and all nine exact markers;
- Level 7 formal SHA-256;
- validation/report paths;
- confirmation that `HEAD == origin/main` and worktree is clean.

If target bands or exactness cannot be established:

```text
BLOCKED_LEVEL_7_TARGET_OR_EXACTNESS_NOT_ESTABLISHED
```

If runtime/schema/broader presentation changes are required:

```text
BLOCKED_LEVEL_7_REQUIRES_RUNTIME_SCHEMA_OR_BROADER_PRESENTATION_CHANGE
```

If primitive cues require a separate redesign:

```text
BLOCKED_LEVEL_7_PRESENTATION_CUES_REQUIRE_SEPARATE_REDESIGN
```

If strict WAIT research would be reopened:

```text
BLOCKED_LEVEL_7_REOPENS_WAIT_RESEARCH
```

If unexpected worktree or evidence safety issues occur:

```text
BLOCKED_UNEXPECTED_WORKTREE_CHANGE
```

Do not weaken targets, substitute a rejected candidate, silently consume Level 8's role, or proceed to Level 8.

## 20. Next gate

After `PASS_FOR_GPT_REVIEW`, GPT reviews the exact diff, formal proof, controls, presentation snapshots, regression, and report. Only GPT may accept Level 7 at `INTERNAL_PLAYABLE` and then issue a separately bounded authenticated-owner Level 7 review or another repair task.

Level 8, general Timeline/Help redesign, narrative, assets/fonts/audio/animation, Gate, persistence, complete flow, export, release, and submission remain unauthorized.
