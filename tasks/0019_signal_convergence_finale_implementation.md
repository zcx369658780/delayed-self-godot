# Task 0019 — Implement and validate `signal_convergence` finale

- Status: `READY`
- Gate: `BOUNDED CANDIDATE-A AUTHORING + FORMAL IMPLEMENTATION + MACHINE/PRESENTATION VALIDATION`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Accepted plan: `docs/level_design/SIGNAL_CONVERGENCE_FINALE_PLAN_CURRENT.md`
- GPT plan acceptance: `docs/reports/0018_GPT_SIGNAL_CONVERGENCE_FINALE_PLAN_ACCEPTANCE.md`
- Acceptance commit: `dbed40d35e06574045cc1654210b493577e8850e`
- Authorized structure: `A — SINGLE_DOOR_FIRST_AND_DOOR_FINAL`
- Fallback B: not authorized in this task

## 1. Objective

Author, select, formally implement, integrate, and validate one sequence-9 finale:

```text
signal_convergence / Signal Convergence / 信号汇流
```

The room must synthesize two dependency stages under frozen schema-v1 rules:

1. an ECHO-driven single-Plate result opens `D1` and creates necessary route access or phase;
2. only after that enabling chain, E2/E4 form the final A+B result while YOU remains free to enter `D2` from the following open snapshot and reach the player-only EXIT.

The task ends at `INTERNAL_PLAYABLE / PASS_FOR_GPT_REVIEW`. It does not conduct owner review, implement localization, add production art/audio, or perform build/export/release/submission work.

## 2. Startup gate

Before any write or Godot run, verify:

- root exactly `D:\Delayed_Self`;
- branch `main`;
- SSH/expected origin;
- clean tracked and untracked worktree;
- `HEAD == origin/main` and contains `dbed40d35e06574045cc1654210b493577e8850e`;
- Godot `4.7.stable.steam.5b4e0cb0f` or exact documented equivalent;
- no residual Godot process.

If clean local `main` is behind, use only `git fetch origin` and `git merge --ff-only origin/main`. Stop on divergence, conflict, wrong root/remote, unexpected files, or materially different toolchain.

Read in order:

1. `AGENTS.md`;
2. current startup and active-task documents;
3. this task;
4. Task 0018 plan, planning report, and GPT acceptance;
5. Task 0017RC/0017RCV implementation, acceptance, owner evidence, and adjudication;
6. Task 0017 and sequence-7/8 validation documents;
7. Level 6 validation;
8. simulation, schema, solver, catalog, progression, Gameplay/AppRoot, Help, Timeline, presentation, testing, capture, and generated-file safety contracts;
9. all eight current formal levels, catalog, focused tests, and aggregate registration.

Before editing, print a concise candidate-search, proof, path, capture, cleanup, rollback, and stop-condition plan.

## 3. Frozen authorities and forbidden scope

Treat as immutable:

- `simulation_v1`, `level_v1`, catalog-v1 semantics, solver behavior, action order, history, simultaneous independent movement, legal overlap, combinational Doors, open-result/next-input entry, player-only EXIT, restart, and canonical key;
- all eight existing formal level files, hashes, and accepted metrics;
- `echo_spacing_bridge` contextual Help behavior;
- byte-identical `two_echo_convergence`, SHA-256 `772410d3b8bb807e35472ee2a7d07b703de66e1e0e92ffb4d1ff8433a345d5fd`;
- accepted divergence feedback and Level Select scrolling;
- Timeline as optional and non-required;
- Help as manual, zero-turn, contextual, reusable, and non-route;
- `LABEL_SHAPE_PIP_PRIMARY_NO_NEW_LINES`;
- owner-only review constraint.

Do not modify:

```text
project.godot
schemas/
scripts/simulation/
scripts/solver/
scripts/app/
scripts/gameplay/
scenes/
data/levels/<any existing level>
```

Do not add a new mechanic, action, collision rule, Gate, latch, persistent/one-shot Door, timer, switch, key, box, push, hazard, enemy, combat, teleport, actor-owned Plate, route trigger, new goal, exact walkthrough, route indicator, target spacing, next-action hint, solver-backed recovery, or always-on relationship line.

No custom ending copy or localization is authorized. Use the existing ordinary completion presentation only; narrative polish is a later gate.

## 4. Candidate-A authoring and search budget

Candidate B is not an automatic fallback. Search candidate A only.

Use external authoring under:

```text
D:\Delayed_Self_Evidence\0019_signal_convergence_finale\
```

Hard search budget:

```text
Stage A structural candidates generated <= 128
Stage B normal-solver candidates <= 32
Stage C strict-control candidates <= 8
Stage D complete augmented proofs <= 3
```

Record every generated canonical definition and disposition. Candidate probes stay external until one candidate passes every gate.

Freeze solver limits before search:

```text
depth_limit = 64
state_limit = 500000
time_limit_ms = 60000
solution_count_cap = 1000000
```

A resource-limit result is unverified. Do not widen limits after seeing results. Complete-negative claims require reachable-state exhaustion. If complete augmented proof cannot finish within a separately recorded ceiling of 2,000,000 augmented states and 180 seconds, stop with `BLOCKED_FINALE_PROOF_LIMIT`; do not call the result complete.

## 5. Exact formal grammar

Create exactly:

```text
data/levels/signal_convergence.json
```

Required facts:

- `schema_version = 1`;
- `level_id = "signal_convergence"`;
- title `Signal Convergence`;
- exactly one YOU;
- exactly two shared-spawn ECHOS with stable IDs and delays 2 and 4;
- exactly three distinct Plates with stable IDs: one stage-1 Plate `S`, and final Plates `A` and `B`;
- exactly two initially closed Doors;
- `D1` depends on exactly `S`;
- `D2` depends on exactly `A+B`;
- exactly one player-only EXIT beyond `D2`;
- board no larger than 10×8, preferably no larger than 9×8;
- exactly two dependency stages;
- pairwise-distinct Plate, Door, and EXIT cells;
- no route/witness metadata and no `best_turn_threshold`;
- metadata must describe two-stage convergence but must not declare `echo_spacing_change`, so bridge-specific Help remains false.

## 6. Narrowed quantitative acceptance bands

The selected tracked candidate must satisfy:

```text
22 <= L* <= 28
1 <= N* <= 8
N* status = EXACT
30000 <= visited_states <= 250000
3000 <= maximum_frontier <= 40000
meaningful decisions = 4–6
recoverable alternatives >= 4
dependency stages = exactly 2
```

CAPPED, limited, or out-of-band results are not acceptance. Do not rewrite targets after seeing results.

No literal WAIT requirement, repeated blocked-input macro, empty-distance padding, forced replay cycle, or ceremonial Door is allowed.

## 7. Mandatory causal chain

Every shortest solution must contain, in order:

1. an ECHO presses `S` and produces a visible `D1` open result;
2. a selected and documented causally required actor enters/passes `D1` from the following open start-turn snapshot;
3. the `D1` traversal creates route access or phase that is necessary for the final stage;
4. E2 and E4 simultaneously occupy distinct `A` and `B` in one measured stable role mapping while YOU is free in the final approach;
5. the result opens `D2`;
6. on the following input, YOU enters `D2` from its open start-turn snapshot;
7. YOU alone reaches EXIT.

Before formal commit, freeze the selected stage-1 crossing actor and final E2/E4 role mapping in the validation document. Do not expose either mapping in Help.

`D1` must causally enable stage 2 rather than merely precede it in a corridor. `D1` and `D2` must each articulate their intended stage.

## 8. Complete augmented curriculum proof

For each Stage-D candidate, augment the canonical state with monotonic event flags for:

- `S` pressed by an ECHO;
- `D1` open result;
- following-input `D1` entry/crossing;
- post-`D1` enabling state;
- useful A+B before stage 1;
- selected E2/A–E4/B or measured role state;
- reverse-role state;
- YOU substitution at the final A+B result;
- `D2` open result;
- following-input `D2` entry;
- completion.

Expand all accepted actions until the augmented finite state space is exhausted.

The selected candidate must prove:

```text
no completion without stage-1 D1 chain
no useful A+B before the stage-1 enabling state
no completion with YOU substitution at final A+B
no completion with reverse final role mapping
no completion bypassing either Door articulation
```

All shortest completions must contain the full ordered chain. If any completed class violates one of these direct gates, reject the candidate.

## 9. Strict controls

Run and record complete finite-state controls for:

- no ECHO;
- E2 only;
- E4 only;
- equal delays 2/2;
- equal delays 4/4.

All five must exhaust complete-unsolved for the full room. Record visited states, frontier, and exhaustion status.

Also run:

- YOU substitution on `S`, `A`, and `B`;
- individual removal/isolation/relocation of `S`, `A`, and `B`;
- removal of `D1` and `D2` separately;
- `D1` dependency replacement;
- A+B reduced to A-only and B-only;
- dependencies swapped between Doors;
- blocker and declared terrain-cell relocation/removal;
- overlap controls;
- both Door articulation and all terrain bypass audits;
- one controlled variant breaking only stage 1;
- one controlled variant breaking only stage 2;
- ECHO-on-EXIT and YOU-on-EXIT;
- exact restart and witness replay.

Controls must show that removing/bypassing `D1` materially collapses the causal chain, not merely shortens a corridor.

## 10. Meaningful decisions and recovery

Audit 4–6 meaningful decisions along a shortest witness. Each must have a legal alternative with a distinct canonical successor and create a measurable penalty, missed stage, changed role phase, recoverable branch, or complete failure.

Establish at least four non-optimal alternatives that remain recoverable by exact bounded search or a short visible return route. Restart must not be the only intelligible recovery.

Separate machine planning burden from owner difficulty claims.

## 11. Catalog and progression migration

Update only:

```text
data/catalog/level_catalog_v1.json
```

Required result:

- exactly nine entries, sequences 1–9 contiguous;
- entries 1–7 semantically and byte-field equivalent;
- sequence 8 remains `two_echo_convergence`, prerequisite `echo_spacing_bridge`, but changes only `final_level` from true to false;
- add sequence 9:

```json
{
  "level_id": "signal_convergence",
  "level_path": "res://data/levels/signal_convergence.json",
  "sequence": 9,
  "display_title_key": "level.signal_convergence.title",
  "classification": "standard",
  "unlock_prerequisites": ["two_echo_convergence"],
  "hud_mode": "STANDARD_COMPACT",
  "final_level": true
}
```

- exactly one final level: sequence 9;
- reset unlocks only Tutorial 0;
- sequence 8 completion unlocks exactly sequence 9;
- generic direct launch accepts sequence 9;
- normal completion return/progression works;
- prior progress that already completed sequence 8 unlocks sequence 9 without persistence-contract changes;
- Level Select sequence 9 is reachable by scroll and focus.

## 12. Help, Timeline, and presentation

Do not add finale-specific Help. The bridge-specific contextual predicate must be false for `signal_convergence` because the finale metadata does not declare `echo_spacing_change`.

Generic Help remains manual, zero-turn, state-preserving, and non-route. Timeline remains optional and unchanged; solving, proof, capture, and owner review must not require Timeline or reverse-counting.

At 960×540 and in grayscale/reduced-motion, verify:

- three Plate identities and both Door dependencies are readable through labels/shapes/pips;
- E2/E4 remain distinct, including overlap states;
- both stage results and both following-snapshot entries are visible;
- no critical overlap, clipping, horizontal overflow, or always-on line web;
- standard completion presentation is readable.

## 13. Tests and stable marker

Add focused tests under the minimum necessary subset of:

```text
tests/levels/
tests/gameplay/
tests/app/
```

Update `tests/run_all.gd` and add exactly one marker:

```text
TASK_0019_SIGNAL_CONVERGENCE_FINALE_TESTS_PASS
```

Cover at minimum:

1. exact formal grammar and new SHA-256;
2. narrowed exact metrics;
3. witness replay and restart;
4. all-shortest ordered two-stage chain;
5. complete augmented no-bypass/no-substitution/no-reverse proof;
6. all strict actor/equal-delay controls;
7. Plate, Door, dependency, terrain, articulation, EXIT, and stage-isolation controls;
8. 4–6 decisions and at least four recoveries;
9. nine-entry catalog, sole-final transfer, progression, direct route, reset, prior-progress compatibility, and Level Select tail access;
10. bridge Help predicate false for the finale;
11. generic Help zero-turn and Timeline optionality;
12. reusable Gameplay, AppRoot return, restart, resize, Safe Error, grayscale, and reduced motion;
13. exact preservation of all eight prior hashes and metrics.

Final aggregate must:

- exit 0;
- report assertions strictly greater than 578 and vectors exactly 9;
- include all prior thirteen markers exactly once;
- include the Task 0019 marker exactly once;
- preserve all eight prior hashes/metrics;
- emit only intentional `LEVEL_ID_MISMATCH` on stderr.

## 14. Native captures

Capture game-window-only 960×540 Compatibility evidence for:

1. nine-entry Level Select with finale locked;
2. sequence 8 completion unlocking sequence 9;
3. finale initial state;
4. stage-1 `S`/`D1` open result;
5. following-snapshot `D1` entry;
6. post-`D1` enabling state;
7. at least two recoverable non-optimal states;
8. final E2/E4 A+B result with YOU free;
9. following-snapshot `D2` entry;
10. YOU completion with ordinary completion overlay;
11. overlap identity state;
12. generic Help open without bridge-specific section;
13. Timeline ignored/optional state;
14. reduced-motion state;
15. grayscale state;
16. Level Select bottom with sequence 9 focused/selectable.

Record dimensions, commands, timestamps, and SHA-256 values in an evidence index.

## 15. Generated-file safety

After all Godot runs and before staging, close every Godot process.

The narrow cleanup authorization applies only when `project.godot` is the sole unintended unstaged tracked change and every untracked path is a regular repository-local `.gd.uid` absent at task start. Restore only the literal worktree `project.godot` and delete only frozen Git-enumerated UID paths one by one.

Never use `git clean`, wildcard or recursive deletion, reset, stash, broad restore, rebase, amend, force-push, or broad staging. Stop if the unexpected set differs.

## 16. Authorized paths

May modify only the minimum necessary subset of:

```text
data/levels/signal_convergence.json
data/catalog/level_catalog_v1.json
tests/levels/<Task 0019 tests>.gd
tests/gameplay/<Task 0019 tests or capture>.gd
tests/app/<Task 0019 progression tests>.gd
tests/run_all.gd
docs/level_design/validation/SIGNAL_CONVERGENCE_VALIDATION.md
docs/reports/0019_SIGNAL_CONVERGENCE_FINALE_IMPLEMENTATION_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/game_design/DELAYED_SELF_GAME_DESIGN_DOCUMENT_CURRENT.md
docs/level_design/SIGNAL_CONVERGENCE_FINALE_PLAN_CURRENT.md
docs/level_design/INITIAL_LEVEL_ROADMAP_AND_VALIDATION_MATRIX_CURRENT.md
docs/level_design/FIVE_LEVEL_DIFFICULTY_RECOVERY_AND_LEVELS_6_8_PLAN.md
docs/ux/PRESENTATION_VIEWPORT_AND_HUD_DIRECTION_CURRENT.md
```

Do not modify prior tasks, reports, reviews, acceptances, existing formal levels, Gameplay/App source, Simulation, solver, schema, scenes, project settings, assets, persistence, build, export, release, or submission surfaces.

## 17. Report and Git discipline

Create:

```text
docs/level_design/validation/SIGNAL_CONVERGENCE_VALIDATION.md
docs/reports/0019_SIGNAL_CONVERGENCE_FINALE_IMPLEMENTATION_REPORT.md
```

Include candidate provenance, search ledger, exact formal facts/hash, metrics, witness, all-shortest and complete augmented proofs, strict/control matrix, decisions/recoveries, catalog migration, progression, Help/Timeline isolation, captures, prior-hash preservation, cleanup, changed paths, rollback, and non-claims.

Stage explicit authorized paths only. Require `git diff --check` and cached checks. Commit exactly once:

```text
feat: add Delayed Self signal convergence finale
```

Fetch before push and stop on remote drift. Push normally to `origin/main`, then require a clean tracked/untracked worktree and `HEAD == origin/main`.

## 18. Stop conditions and terminal verdict

Stop without product commit if no candidate A satisfies every gate, if D1 is ceremonial, if a completed class bypasses either stage, if YOU substitution or reverse roles survive, if exact/complete proof hits a limit, if presentation fails, if any prior hash/metric changes, or if an unauthorized path changes.

Return exactly one:

```text
SIGNAL_CONVERGENCE_FINALE_READY_FOR_GPT_REVIEW
BLOCKED_NO_BOUNDED_CANDIDATE_A
BLOCKED_FINALE_CAUSAL_STAGE_BYPASS
BLOCKED_FINALE_PROOF_LIMIT
BLOCKED_FINALE_PRESENTATION
BLOCKED_BASELINE_REGRESSION
BLOCKED_UNEXPECTED_WORKTREE_CHANGE
```

On success include commit SHA, candidate provenance, exact metrics/hash, two-stage and augmented proof summary, strict controls, aggregate assertions/vectors/markers, captures, report/validation/evidence paths, cleanup disposition, and final Git state.

Do not claim owner acceptance, fresh/independent review, human difficulty/fun acceptance, narrative completion, production readiness, export, release, or submission readiness.
