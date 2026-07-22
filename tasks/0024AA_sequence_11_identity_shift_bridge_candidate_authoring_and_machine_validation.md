# Task 0024AA — Author and machine-validate the sequence-11 identity-shift bridge candidate

- Status: `READY`
- Gate: `SEQUENCE 11 FALLBACK-ENVELOPE CANDIDATE AUTHORING / MACHINE VALIDATION / NO CATALOG OR PROFILE`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Required accepted checkpoint: `3b9b576d4a729b1f2e2d673c76c8efdce4a5d494`
- Accepted sequence-10 result commit: `b8378bc2e1e96642ff99eded436df65e2435cc9f`
- Accepted sequence-10 verdict: `TASK_0024Z_SEQUENCE_10_KEY_ROUTE_COMMITMENT_MACHINE_VALIDATION_ACCEPTED`
- Accepted sequence-9 result commit: `445122ab035a4c9210f3280af58d054a35bef2bd`
- Accepted scope verdict: `TASK_0024X_SUBMISSION_CORE_LEVELS_9_12_SCOPE_ACCEPTED`
- Accepted mechanics foundation: `TASK_0024W_COMPLETE_CORE_MECHANICS_FOUNDATION_ACCEPTED`
- Accepted foundation result commit: `7072566ef814f6969693bbc9335fcced5e424585`
- Accepted wrapper implementation/blob: `7c0712d6a602dc23200ccb147d0096acc6333305` / `5f14eb0feff903b40311c1c7283b20e2eabbffc2`
- Implemented/cataloged product baseline at start: exactly eight formal levels
- Accepted uncatalogued candidates at start: `crate_shadow_timing`, `key_route_commitment`
- Recommended Codex model: `GPT-5.6 Sol Max`; fallback `GPT-5.6 Sol High`

## 1. Objective

Create one uncatalogued schema-v2 candidate level for future sequence 11, using the pre-agreed **fallback envelope** from Task 0024X: exactly one YOU-only sensor, one ECHO-only sensor and one two-cell grouped bridge, with no crate or optional `ANY_ACTOR` branch.

Prove through the accepted public loader, shared Simulation and BFS solver that actor identity, next-turn barrier state and occupied-cell closure deferral are all necessary to the room's shortest-solution structure.

Candidate identity:

```text
level_id: identity_shift_bridge
English working title: Identity-Shift Bridge
Simplified-Chinese planned title: 身份错拍桥
future sequence: 11
classification: core candidate; not catalog-admitted
risk envelope: frozen sequence-11 fallback
```

This task may iterate the candidate and its dedicated validation artifacts until the machine contract passes. It must not add sequences 9–11 to the catalog, alter progression/finale/Profile, modify Gameplay/UI, introduce the optional crate/`ANY_ACTOR` branch, or claim owner/formal admission.

## 2. Binding design brief and fallback decision

Sequence 11 is the highest-risk submission-core room. Task 0024X froze the fallback as the implementation starting point, not merely an emergency option.

The candidate must teach a reasoning structure not present in sequences 1–10:

- actor identity, rather than occupancy count alone, controls the bridge;
- YOU must activate a `YOU_ONLY` sensor;
- ECHO must activate an `ECHO_ONLY` sensor;
- both exact typed conditions must coincide to request the grouped bridge open;
- the requested state affects movement only from the next turn-start snapshot;
- after bridge entry, releasing a sensor requests closure while YOU occupies a grouped cell;
- closure is deferred while the group is occupied;
- after YOU vacates the group, the bridge closes behind;
- YOU, not ECHO, completes at EXIT.

Frozen fallback envelope:

- exactly one ECHO with delay 2 through 4;
- exactly two critical sensors: one `YOU_ONLY`, one `ECHO_ONLY`;
- both sensors have explicit `include_crates = false`;
- exactly one grouped barrier/bridge with exactly two unique cells;
- the group depends on both sensor IDs and is initially closed;
- zero crates, keys, locks and latches;
- zero v1 Plates and v1 Doors;
- footprint 9–11 cells wide and 7–9 cells high;
- target `L* = 18–23`;
- exact target `N* = 1–8`;
- solver maximum: depth 64, 750,000 states, 35,000 ms, count cap 1,000,000.

Do not silently widen the bands, add a third sensor, add `ANY_ACTOR`, add a crate, use color-only identity assumptions, reduce the accepted candidate to a one-cell gate, or introduce any stretch mechanic. If the full target cannot be met, simplify geometry while preserving the exact two sensors, two-cell group, next-turn entry and occupied closure-deferral chain before returning a blocker.

## 3. Startup gate

Before editing or launching Godot:

1. require root `D:\Delayed_Self`, branch `main`, expected origin and no Git operation in progress;
2. fetch and fast-forward only;
3. require `HEAD == origin/main`, divergence `0/0`, and ancestry of `3b9b576d4a729b1f2e2d673c76c8efdce4a5d494`;
4. require clean tracked worktree, zero staged paths and no unexpected untracked files;
5. require zero pre-existing Godot processes; never close unknown/pre-existing processes;
6. require Godot `4.7.1.stable.steam.a13da4feb` and accepted wrapper blob `5f14eb0feff903b40311c1c7283b20e2eabbffc2`;
7. read `AGENTS.md`, current startup/active docs, this full task, Task 0024X scope/acceptance, Task 0024Y and 0024Z reports/summaries/GPT acceptances, schema-v2 and Simulation-v2 contracts, Task 0024W acceptance, all eight formal levels and accepted sequence-9/10 candidates/tests;
8. record pre-task hashes for loader, Simulation, BFS, schemas, vectors, five v2 fixtures, catalog, all eight formal levels, accepted sequence-9/10 candidate/test/summary/report/acceptance artifacts, wrapper and Task 0024W sealed repository artifacts;
9. stop on remote drift, unexpected dirty state, process ambiguity, foundation drift, accepted-candidate drift, historical evidence drift or any need to access Profile/user-data surfaces.

Production Profile content/metadata/siblings, ordinary user data and the test-profile root are forbidden.

## 4. Authorized repository paths

Candidate and validation paths:

```text
data/levels/identity_shift_bridge.json
tests/levels/task_0024aa_identity_shift_bridge_validation.gd
tests/levels/task_0024aa_identity_shift_bridge_validation.gd.uid
tests/tools/task_0024aa_*.ps1
tests/tools/task_0024aa_*.py
tests/tools/task_0024aa_*.json
docs/level_design/validation/sequence_11_identity_shift_bridge_validation.json
docs/reports/0024AA_SEQUENCE_11_IDENTITY_SHIFT_BRIDGE_MACHINE_VALIDATION_REPORT.md
```

Current-document updates allowed only after a terminal result:

```text
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/production/EXPANDED_CONTENT_SUBMISSION_ROADMAP_CURRENT.md
```

No other path may change. A generated UID is allowed only for the new dedicated test script and must be explicitly reviewed and staged. Existing UID sidecars remain frozen.

## 5. Frozen and protected surfaces

Do not modify:

```text
scripts/simulation/level_loader.gd
scripts/simulation/simulation.gd
scripts/solver/bfs_solver.gd
docs/game_design/GAMEPLAY_SIMULATION_CONTRACT_V2_CURRENT.md
docs/level_design/LEVEL_SCHEMA_V2_CURRENT.md
schemas/**
docs/level_design/reference/**
tests/run_all.gd
tests/simulation/**
tests/levels/task_0012_staggered_doors_validation.gd
tests/levels/task_0024y_crate_shadow_timing_validation.gd
tests/levels/task_0024z_key_route_commitment_validation.gd
tests/tools/run_owned_godot_headless.ps1
data/catalog/**
data/levels/tutorial_reach_exit.json
data/levels/tutorial_echo_bridge.json
data/levels/vertical_slice_delay_3.json
data/levels/door_one_turn_late.json
data/levels/two_keys_one_door.json
data/levels/staggered_doors.json
data/levels/echo_spacing_bridge.json
data/levels/two_echo_convergence.json
data/levels/crate_shadow_timing.json
data/levels/key_route_commitment.json
docs/level_design/validation/sequence_09_crate_shadow_timing_validation.json
docs/level_design/validation/sequence_10_key_route_commitment_validation.json
docs/reports/0024Y_SEQUENCE_9_CRATE_SHADOW_TIMING_MACHINE_VALIDATION_REPORT.md
docs/reports/0024Z_SEQUENCE_10_KEY_ROUTE_COMMITMENT_MACHINE_VALIDATION_REPORT.md
docs/reports/0024Y_GPT_SEQUENCE_9_CRATE_SHADOW_TIMING_MACHINE_VALIDATION_ACCEPTANCE.md
docs/reports/0024Z_GPT_SEQUENCE_10_KEY_ROUTE_COMMITMENT_MACHINE_VALIDATION_ACCEPTANCE.md
scenes/**
scripts/gameplay/**
scripts/app/**
project.godot
assets/**
audio/**
localization/**
build/export/release/submission surfaces
all Task 0024T/0024U/0024V/0024W sealed or historical evidence
```

Do not modify catalog or route parsing to make the candidate playable. Validate it directly through the public loader and shared Simulation.

## 6. Candidate level data contract

Create `data/levels/identity_shift_bridge.json` with:

- `schema_version = 2`;
- exact `level_id = "identity_shift_bridge"`;
- exact working `title = "Identity-Shift Bridge"`;
- one ECHO with stable ID `echo_identity` and delay 2–4;
- zero v1 Plates and zero v1 Doors;
- zero crates, keys, locks and latches;
- exactly two sensors:
  - `sensor_you`, `activator = "YOU_ONLY"`, `include_crates = false`;
  - `sensor_echo`, `activator = "ECHO_ONLY"`, `include_crates = false`;
- exactly one barrier group `bridge_identity`;
- exactly two unique barrier cells;
- `initial_open = false`;
- exact dependency set containing only `sensor_you` and `sensor_echo`;
- one YOU-only EXIT;
- metadata naming typed actor identity, next-turn grouped-bridge state and occupied-cell closure deferral without embedding the route;
- `validation.recommended_search_depth = 64`.

Terrain, spawn, delay, sensor positions, barrier cells and EXIT may be iterated before the terminal result. The candidate remains uncatalogued and must contain no sequence/unlock/finale state.

## 7. Dedicated focused validation

Create `tests/levels/task_0024aa_identity_shift_bridge_validation.gd` using only the accepted public loader, shared Simulation and BFS solver.

Required terminal marker:

```text
TASK_0024AA_IDENTITY_SHIFT_BRIDGE_PASS
```

Failure prefix:

```text
TASK_0024AA_IDENTITY_SHIFT_BRIDGE_FAIL
```

The validation must prove all sections below.

### 7.1 Identity and schema

- exact level ID/title/schema version;
- exact stable IDs and cardinalities;
- footprint inside 9–11 by 7–9;
- one ECHO delay in the allowed band;
- exact `YOU_ONLY` and `ECHO_ONLY` sensor identities;
- both `include_crates = false`;
- exactly one initially closed, two-cell group with the exact two-sensor dependency;
- zero v1 Plate/Door and all forbidden-family arrays empty;
- YOU-only EXIT;
- loader validity through `load_file`.

### 7.2 Solver and replay

Using limits no larger than the frozen maximum:

- status `SOLVED`;
- `L*` between 18 and 23 inclusive;
- `N*` exact, between 1 and 8 inclusive;
- no depth/state/time limit exceeded;
- one deterministic shortest witness;
- witness length equals `L*`;
- witness replays to completion through shared Simulation;
- replaying twice produces identical states and canonical-key traces;
- restart reconstructs all mutable fields;
- canonical key distinguishes open/closed barrier state, actor positions and history.

Record exact witness, `L*`, `N*`, visited states, maximum frontier, elapsed time, configured limits, waits and blocked-YOU actions.

### 7.3 Required ordered identity/timing event

Retain an exact trace proving, in order:

1. YOU occupies `sensor_you` while ECHO occupies `sensor_echo` in the same result; neither sensor is satisfied by the wrong actor;
2. that result requests and commits `bridge_identity` open for the next turn, while no actor entered a bridge cell from the previously closed start snapshot;
3. on the following open start snapshot, YOU enters the first bridge cell;
4. after one required sensor releases, closure is requested while YOU occupies a bridge cell, and the group remains open because closure is deferred;
5. YOU advances/vacates the two-cell group and the bridge closes after occupancy clears;
6. YOU, not ECHO, reaches EXIT.

The trace must retain before/action/after player, ECHO, history, pressed sensor IDs, sensor eligibility, barrier state, barrier occupancy, requested close/deferral classification and action index.

### 7.4 All-shortest-solutions proof

Run an instrumented shortest-depth search through shared `Simulation.transition` using ordered event state for:

- exact typed pair activation (`YOU_ONLY` by YOU and `ECHO_ONLY` by ECHO);
- bridge opening result with no same-turn entry;
- next-turn YOU bridge entry;
- occupied-cell closure deferral after sensor release;
- closure after group vacancy.

At depth `L*`:

- total completed-path count equals solver exact `N*`;
- every completed shortest path contains the full ordered event chain;
- zero completed shortest paths omit either actor identity, next-turn entry or closure deferral;
- every shortest path crosses the two-cell grouped bridge;
- no path substitutes occupancy cardinality for typed identity.

Use canonical state plus ordered event state/depth/count bookkeeping; do not implement parallel transitions.

### 7.5 Necessity controls

Retain exact results for:

1. **No-ECHO control:** remove ECHO, set only the schema-required zero-ECHO metadata, and prove complete finite-state unsolved.
2. **Swapped-identity control:** swap the two sensor activators. It must be schema-valid and complete-unsolved or materially change `L*`/`N*` while eliminating the ordered identity chain.
3. **YOU-sensor ANY control:** change only `sensor_you` to `ANY_ACTOR`. It must materially change metrics or solution structure and eliminate proof that YOU identity is necessary.
4. **ECHO-sensor ANY control:** change only `sensor_echo` to `ANY_ACTOR`. It must materially change metrics or solution structure and eliminate proof that ECHO identity is necessary.
5. **One-cell-group control:** reduce the bridge group to one valid cell. It must materially change metrics and eliminate the required two-cell entry/deferral/vacancy chain.
6. **No-deferral restricted search:** search the unchanged level through shared Simulation while rejecting every transition classified as occupied-cell closure deferral. The complete reachable finite state must exhaust unsolved. A depth/time/state cutoff is not acceptance.

At least no-ECHO and no-deferral must be complete finite-state unsolved. No control may be labeled unsolved after only a limit result.

### 7.6 Shortcut and rule probes

Prove or retain evidence for:

- YOU does not satisfy `sensor_echo`;
- ECHO does not satisfy `sensor_you`;
- `include_crates=false` is explicit and no crate exists;
- the closed group blocks entry on the same result turn that sensors request opening;
- the next open start snapshot permits entry;
- a requested close is deferred while YOU occupies either group cell;
- the group closes after all actors vacate;
- the two-cell group is a terrain/route articulation with no walk-around;
- no direct EXIT path bypasses the typed bridge chain;
- ECHO on EXIT cannot complete;
- witness has no repeated identical blocked-YOU macro longer than one consecutive repeat;
- restart restores sensors/barrier/history/completion with zero residue.

## 8. Authoring iteration doctrine

Before final retained qualification, Codex may repeatedly edit only Task 0024AA-authorized candidate/test/helper paths and rerun bounded checks.

Every iteration must:

- use the accepted wrapper for Godot execution;
- invoke cleanup exactly once;
- leave no owned or unproven PID;
- end with total Godot count zero;
- remain within limits;
- be summarized honestly in the final report, including discarded candidates and failure reasons.

Do not weaken tests, widen bands or reintroduce the optional crate/`ANY_ACTOR` branch. Simplify geometry inside the frozen fallback before returning a blocker.

## 9. Final retained qualification

After the candidate and focused test are stable, run one retained Task 0024AA qualification cycle containing exactly these cases, each once in that cycle through the accepted wrapper:

1. `res://tests/levels/task_0024aa_identity_shift_bridge_validation.gd`
   - marker: `TASK_0024AA_IDENTITY_SHIFT_BRIDGE_PASS`;
   - stderr: empty;
2. `res://tests/levels/task_0024z_key_route_commitment_validation.gd`
   - marker: `TASK_0024Z_KEY_ROUTE_COMMITMENT_PASS`;
   - stderr: empty;
3. `res://tests/levels/task_0024y_crate_shadow_timing_validation.gd`
   - marker: `TASK_0024Y_CRATE_SHADOW_TIMING_PASS`;
   - stderr: empty;
4. `res://tests/run_all.gd`
   - marker: exact `TASK_0003_TESTS_PASS assertions=621 vectors=9`;
   - stderr: exactly `LEVEL_ID_MISMATCH`;
5. `res://tests/simulation/task_0024v_v2_solver_replay_canonical_malformed.gd`
   - marker: `TASK_0024V_V2_COMPLETE_PASS`;
   - stderr: empty.

Per case retain wrapper/native exit, marker count, stderr classification, cleanup count/order, direct/descendant ownership, remaining owned/unproven PIDs, Godot before/after and bounded stdout/stderr. Final Godot count must be zero.

Repetitions before the retained cycle are authoring checks, not hidden final evidence. Do not create a seal or one-shot driver in Task 0024AA. Once the retained cycle is declared final and consumed, do not rerun it.

## 10. Machine-readable validation summary

Create:

```text
docs/level_design/validation/sequence_11_identity_shift_bridge_validation.json
```

Include at least:

- task/commit/Godot/wrapper identities;
- candidate SHA-256 and exact entity/footprint facts;
- explicit `risk_envelope = "FROZEN_FALLBACK"`;
- limits, solver status, `L*`, exact `N*`, visited/frontier/time;
- exact witness actions;
- wait and blocked-YOU counts;
- ordered event indices and trace facts;
- all-shortest event counts;
- no-ECHO/swapped/ANY/one-cell/no-deferral controls;
- shortcut probes;
- restart/canonical/replay facts;
- final five-case wrapper qualification;
- `owner_playthrough_status = "PENDING_LATER_CURRICULUM_GATE"`;
- `catalog_admission_status = "NOT_AUTHORIZED"`.

Do not hand-edit claims that disagree with retained runtime output.

## 11. Required report and current docs

Create:

```text
docs/reports/0024AA_SEQUENCE_11_IDENTITY_SHIFT_BRIDGE_MACHINE_VALIDATION_REPORT.md
```

The report must state exact changed paths/hashes, discarded iterations, solver metrics/witness, ordered/all-shortest proof, controls/shortcuts, final wrapper/process evidence, frozen/sequence-9/10/historical hash audit, unresolved owner/catalog status and protected boundaries.

Update authorized current docs consistently after terminal result.

## 12. Commit and push policy

On pass or honest blocker:

1. stage only authorized paths;
2. inspect staged names and run `git diff --cached --check`;
3. create one single-topic result commit; do not amend/rebase/squash;
4. fetch before push and stop on remote drift;
5. push only a clean fast-forward to `origin/main`;
6. require post-push `HEAD == origin/main`, divergence `0/0`, clean worktree and zero Godot processes;
7. report any separate correction commit transparently.

Suggested pass commit:

```text
feat: machine validate sequence 11 identity bridge candidate
```

## 13. Terminal verdict

Return exactly one:

```text
SEQUENCE_11_IDENTITY_SHIFT_BRIDGE_MACHINE_VALIDATED_FOR_GPT_REVIEW
BLOCKED_SEQUENCE_11_IDENTITY_SHIFT_BRIDGE_VALIDATION
PROTECTED_DATA_BOUNDARY_BREACH
```

A pass establishes only an uncatalogued machine-validated sequence-11 fallback-envelope candidate ready for GPT review. It does not authorize catalog/progression/finale/Profile changes, sequence-12 authoring, owner acceptance, Gameplay/UI, localization, assets/audio, build/export, release, upload or submission.
