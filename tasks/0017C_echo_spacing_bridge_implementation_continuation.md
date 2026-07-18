# Task 0017C — Resume `echo_spacing_bridge` implementation after Level Select repair

- Status: `READY`
- Gate: `IMPLEMENTATION CONTINUATION + FORMAL VALIDATION / CURRICULUM BRIDGE`
- Repository: `zcx369658780/delayed-self-godot`
- Expected branch: `main`
- Expected local root: `D:\Delayed_Self`
- Parent implementation task: `tasks/0017_echo_spacing_bridge_implementation.md`
- Accepted Level Select prerequisite: `TASK_0017P_LEVEL_SELECT_SCROLLABILITY_REPAIR_ACCEPTED`
- Acceptance report: `docs/reports/0017P_GPT_FINAL_ACCEPTANCE.md`
- Acceptance commit: `8dcaf9dd0af75000d377b6721e1be456e7e019e2`
- Previously observed candidate evidence root: `D:\Delayed_Self_Evidence\0017_echo_spacing_bridge\`

## 1. Objective

Resume the previously blocked Task 0017 only after accepting the Level Select scalability prerequisite. Reconstruct or boundedly re-author, formally validate, integrate, capture, document, commit, and push:

```text
echo_spacing_bridge / Diverging Echoes / 错位回声
```

The bridge remains the mandatory sequence-7 curriculum room before byte-identical `two_echo_convergence` at sequence 8.

This task ends at `INTERNAL_PLAYABLE / PASS_FOR_GPT_REVIEW`. It does not conduct owner review and does not implement `signal_convergence`.

## 2. Startup and synchronization

Before writing or running Godot, verify:

- root exactly `D:\Delayed_Self`;
- branch `main`;
- expected origin;
- clean tracked and untracked worktree;
- local `HEAD == origin/main` and contains commit `8dcaf9dd0af75000d377b6721e1be456e7e019e2`;
- accepted Godot `4.7.stable.steam.5b4e0cb0f` executable or exact documented equivalent;
- no residual Godot process.

If clean local `main` is behind, use only `git fetch origin` and `git merge --ff-only origin/main`. Stop on divergence, conflict, unexpected files, wrong root/remote, or materially different toolchain.

## 3. Required reads

Read in order:

1. `AGENTS.md`;
2. current startup and active-task documents;
3. this Task 0017C;
4. parent Task 0017;
5. `docs/reports/0017P_GPT_FINAL_ACCEPTANCE.md`;
6. Task 0017P implementation report and focused tests;
7. Task 0017 blocker adjudication;
8. Task 0016R GPT acceptance, revised plan, and revision report;
9. Task 0015/0015R validation and acceptance documents;
10. Level 6 validation/report;
11. simulation, schema, catalog, progression, Gameplay/AppRoot, presentation, testing, capture, Godot-safety, and generated-file-safety contracts;
12. all seven existing formal levels and the seven-entry catalog;
13. the external Task 0017 candidate ledger, logs, captures, hashes, and any preserved candidate formal artifact.

Before editing, print a concise implementation summary with candidate reconstruction status, expected proof matrix, selected paths, test/capture plan, cleanup plan, and stop conditions.

## 4. Candidate reconstruction and authoring boundary

The previous uncommitted candidate reportedly achieved:

```text
L* = 16
N* = 12 EXACT
visited_states = 19059
maximum_frontier = 3734
```

with all 12 shortest solutions satisfying E2→A, E4→B, and open-snapshot Door crossing, and no-ECHO/E2-only/E4-only complete-unsolved controls.

Treat those facts as external authoring evidence, not accepted product evidence.

1. First inspect the external evidence root without modifying the repository.
2. If an exact candidate JSON or complete canonical terrain/entity record is preserved, reconstruct it exactly and require the reported metrics/traces to reproduce.
3. If exact reconstruction is impossible, a maximum of four bounded geometry iterations is authorized under the original Task 0017 contract. Any replacement candidate must satisfy every original hard gate; do not weaken bands or necessity obligations.
4. Record whether the final tracked candidate is an exact reconstruction or a bounded re-author.

Stop with `BLOCKED_CANDIDATE_RECONSTRUCTION_OR_REAUTHOR_FAILED` if no valid candidate can be established.

## 5. Frozen product and App Shell authorities

Treat as immutable:

- `simulation_v1`, `level_v1`, catalog-v1 semantics, solver semantics, history, blocked-action recording, simultaneous independent movement, legal overlap, combinational Doors, open-result/next-input entry, player-only EXIT, restart, and canonical key;
- all seven existing formal JSON files, hashes, metrics, and accepted evidence;
- `two_echo_convergence` formal JSON and SHA-256 `772410d3b8bb807e35472ee2a7d07b703de66e1e0e92ffb4d1ff8433a345d5fd`;
- Task 0015R transition-derived divergence feedback;
- Task 0017P scrollable Level Select implementation and its interaction contract;
- A/B labels/shapes/pips, E2/E4 badges/outlines, `LABEL_SHAPE_PIP_PRIMARY_NO_NEW_LINES`;
- Timeline optional/non-required and Help zero-turn/non-route;
- future `signal_convergence` as an unimplemented sequence-9 concept.

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

No Level Select source change is authorized. If eight-entry presentation still fails with the accepted Task 0017P implementation, stop with `BLOCKED_LEVEL_SELECT_REPAIR_REGRESSION`.

## 6. Formal bridge contract

Create exactly:

```text
data/levels/echo_spacing_bridge.json
```

Required facts:

- schema v1;
- level ID `echo_spacing_bridge` and title `Diverging Echoes`;
- exactly two shared-spawn ECHOs with delays 2 and 4;
- exactly two distinct Plates A/B;
- exactly one initially closed Door depending on A+B;
- exactly one player-only EXIT beyond the Door;
- board no larger than 8×7;
- compact early asymmetric blocker/fork, separated Plate pockets, YOU staging lane, unavoidable Door articulation;
- Plate-to-Door traversable distance greater than one for both Plates;
- no second Door, third Plate, second stage, route metadata, unknown field, or `best_turn_threshold`.

## 7. Hard causal and quantitative gates

Require:

```text
13 <= L* <= 16
2 <= N* <= 32
N* status = EXACT
3000 <= visited_states <= 25000
500 <= maximum_frontier <= 5000
```

Also require:

- every shortest solution contains an early post-activation `BLOCKED/MOVED` ECHO divergence that changes signed or Manhattan spacing;
- every shortest solution later contains E2→A, E4→B, simultaneous A+B, YOU staged for entry, and open-result/next-input Door crossing;
- no-ECHO, E2-only, and E4-only controls exhaust the complete finite state space unsolved without limits;
- YOU cannot substitute on either Plate and still enter during the useful snapshot;
- overlap cannot satisfy A+B;
- Door lies on every YOU-to-EXIT terrain route;
- only YOU completes at EXIT;
- 2–3 meaningful decisions and at least two recoverable alternatives;
- no literal WAIT requirement, repeated blocked-input macro, long-corridor padding, or route-specific presentation;
- measured burden remains materially below current `two_echo_convergence`.

Starting limits remain depth 64, states 500,000, time 30 seconds, count cap 1,000,000. Limit results are unverified and may not be called exact or complete-unsolved.

## 8. Controlled variants and preservation

Run the complete Task 0017 control family:

- no-ECHO, E2-only, E4-only;
- isolate/relocate A and B separately;
- A-only and B-only dependency replacements;
- Door removal;
- equal delays 2/2 and 4/4;
- declared blocker/Plate relocation;
- YOU-substitution, overlap, articulation/bypass, ECHO-on-EXIT, YOU-on-EXIT;
- restart and witness replay.

Record exact outcomes and exhaustion/limit status. Preserve all seven prior formal hashes and accepted metrics byte-for-byte.

## 9. Catalog migration

Update only `data/catalog/level_catalog_v1.json` to exactly eight entries:

- entries 1–6 unchanged;
- `echo_spacing_bridge` sequence 7, prerequisite `staggered_doors`, standard, `STANDARD_COMPACT`, `final_level=false`;
- existing `two_echo_convergence` sequence 8, prerequisite `echo_spacing_bridge`, otherwise unchanged, and sole `final_level=true`;
- no `signal_convergence` entry.

Verify reset, ordered unlock, Level 6→bridge, bridge→shifted Level 7, direct launch, completion return, and sole-final behavior.

## 10. Tests, captures, and regression

Add the minimum focused tests/capture harness under authorized `tests/levels/`, `tests/gameplay/`, and `tests/app/`, and update `tests/run_all.gd`.

Required marker:

```text
TASK_0017_ECHO_SPACING_BRIDGE_TESTS_PASS
```

The final aggregate must:

- exit 0;
- report assertions strictly greater than 481 and vectors exactly 9;
- include all prior eleven markers exactly once;
- include the new Task 0017 marker exactly once;
- preserve all prior hashes/metrics;
- emit only intentional `LEVEL_ID_MISMATCH` on stderr.

Native 960×540 captures must include:

1. eight-entry Level Select with bridge locked;
2. Level 6 completion revealing bridge;
3. bridge initial cues;
4. stable-spacing no-cue control;
5. required `BLOCKED/MOVED` event;
6. recovery/phase state;
7. E2-on-A/E4-on-B A+B result;
8. following open-snapshot crossing;
9. bridge completion revealing shifted Level 7;
10. Level Select bottom/tail focus proving sequence 8 is visible and selectable;
11. reduced-motion and grayscale decision states.

The accepted Task 0017P seven/eight/twelve-entry marker and focus behavior must remain passing. No Level Select source edit is allowed.

## 11. External evidence and generated files

Use:

```text
D:\Delayed_Self_Evidence\0017_echo_spacing_bridge\
```

Preserve prior diagnostic artifacts in place and add a clearly separated continuation/revalidation section or subdirectory. Record candidate provenance, commands, solver results, controls, hashes, regression, captures, and evidence index.

After all Godot runs and before staging, close every Godot process. The narrow literal cleanup authorization from parent Task 0017 remains available only when `project.godot` is the sole unintended tracked change and every untracked path is a regular `.gd.uid` file under the repository. Restore only the worktree copy of literal `project.godot` and delete only the frozen Git-enumerated UID paths one by one. Never use `git clean`, wildcard/recursive deletion, reset, stash, broad restore, rebase, amend, or force-push. Stop if the unexpected set differs.

## 12. Authorized repository surface

May modify only the minimum necessary subset of:

```text
data/levels/echo_spacing_bridge.json
data/catalog/level_catalog_v1.json
tests/levels/<Task 0017 focused tests>.gd
tests/gameplay/<Task 0017 focused tests or capture>.gd
tests/app/<Task 0017 progression or capture>.gd
tests/run_all.gd
docs/level_design/validation/ECHO_SPACING_BRIDGE_VALIDATION.md
docs/reports/0017_ECHO_SPACING_BRIDGE_IMPLEMENTATION_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/level_design/INITIAL_LEVEL_ROADMAP_AND_VALIDATION_MATRIX_CURRENT.md
docs/level_design/FIVE_LEVEL_DIFFICULTY_RECOVERY_AND_LEVELS_6_8_PLAN.md
docs/level_design/LEVEL_8_FINALE_AND_DIFFICULTY_BRIDGE_PLAN_CURRENT.md
docs/ux/PRESENTATION_VIEWPORT_AND_HUD_DIRECTION_CURRENT.md
```

Do not modify prior tasks, reports, reviews, acceptances, formal levels, App Shell source, Gameplay source, Simulation, solver, schema, scenes, project settings, assets, persistence, build, export, or release surfaces.

## 13. Report, Git discipline, and terminal verdict

Create:

```text
docs/reports/0017_ECHO_SPACING_BRIDGE_IMPLEMENTATION_REPORT.md
```

Include candidate provenance, exact formal facts/hash, metrics, witness, all-shortest traces, complete controls, decision/recovery audit, catalog migration, Level Select tail accessibility, focused/aggregate results, captures, prior-hash preservation, cleanup, changed paths, rollback, and non-claims.

Stage explicit authorized paths only. Commit exactly once with:

```text
feat: add Delayed Self echo spacing bridge
```

Fetch and stop on remote drift before push. Push normally to `origin/main`, then require a clean tracked/untracked worktree and `HEAD == origin/main`.

On success return:

```text
ECHO_SPACING_BRIDGE_READY_FOR_GPT_REVIEW
```

Include commit SHA, candidate provenance, metrics, formal SHA-256, controls, aggregate assertions/vectors/markers, capture summary, report path, evidence root, and final Git state.

Do not claim owner acceptance, fresh/independent review, finale acceptance, candidate acceptance, export, release, or submission readiness.
