# Task 0024Y — Author and machine-validate the sequence-9 crate timing candidate

- Status: `READY`
- Gate: `SEQUENCE 9 CANDIDATE AUTHORING / MACHINE VALIDATION / NO CATALOG OR PROFILE`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Required accepted checkpoint: `3257aa8a1d677aa0596bb5edd9e8015a4c476fd1`
- Accepted scope verdict: `TASK_0024X_SUBMISSION_CORE_LEVELS_9_12_SCOPE_ACCEPTED`
- Accepted mechanics foundation: `TASK_0024W_COMPLETE_CORE_MECHANICS_FOUNDATION_ACCEPTED`
- Accepted foundation result commit: `7072566ef814f6969693bbc9335fcced5e424585`
- Accepted wrapper implementation/blob: `7c0712d6a602dc23200ccb147d0096acc6333305` / `5f14eb0feff903b40311c1c7283b20e2eabbffc2`
- Implemented/cataloged product baseline at start: exactly eight formal levels
- Recommended Codex model: `GPT-5.6 Sol Max`; fallback `GPT-5.6 Sol High`

## 1. Objective

Create one uncatalogued schema-v2 candidate level for future sequence 9, prove its intended crate/ECHO temporal structure through the accepted loader, shared Simulation and BFS solver, and retain bounded machine-readable evidence for GPT review.

The candidate identity is:

```text
level_id: crate_shadow_timing
English working title: Crate-Shadow Timing
Simplified-Chinese planned title: 箱影定拍
future sequence: 9
classification: core candidate; not catalog-admitted
```

This task may iterate the candidate level and its dedicated validation artifacts until the machine contract passes. It must not add the candidate to the catalog, unlock progression, move the finale, read/write Profile data, modify Gameplay/UI or claim owner/formal admission.

## 2. Binding Task 0024X design brief

The candidate must teach a reasoning structure not present in sequences 1–8:

- only YOU pushes a crate;
- the selected crate resting position persists;
- the crate deliberately blocks one replayed ECHO movement and changes that ECHO's phase;
- after the phase change, the ECHO creates the required Plate/Door window while YOU crosses;
- static terrain or a crate-free route must not reproduce the accepted shortest-solution structure.

Frozen target envelope:

- exactly one crate;
- exactly one ECHO with delay from 2 through 4;
- exactly one v1 Plate and one v1 Door;
- zero keys, locks, typed sensors, grouped barriers and latches;
- footprint 7–9 cells wide and 5–7 cells high;
- at most two consequential YOU pushes in any accepted shortest witness;
- no multi-crate ordering, packing, corner maze or generic Sokoban structure;
- target `L* = 13–16`;
- exact target `N* = 4–20`;
- solver maximum: depth 48, 250,000 states, 20,000 ms, count cap 1,000,000.

The target bands are hard admission bands for this candidate task. Do not silently widen them. Use the frozen hard-cut fallback—one crate, one phase-changing push, one ECHO/Plate window—before returning a blocker.

## 3. Startup gate

Before editing or launching Godot:

1. require root `D:\Delayed_Self`, branch `main`, expected origin and no Git operation in progress;
2. fetch and fast-forward only;
3. require `HEAD == origin/main`, divergence `0/0`, and ancestry of `3257aa8a1d677aa0596bb5edd9e8015a4c476fd1`;
4. require clean tracked worktree, zero staged paths and no unexpected untracked files;
5. require zero pre-existing Godot processes; never close unknown/pre-existing processes;
6. require Godot `4.7.1.stable.steam.a13da4feb` and accepted wrapper blob `5f14eb0feff903b40311c1c7283b20e2eabbffc2`;
7. read `AGENTS.md`, current startup/active docs, this full task, the Task 0024X scope and GPT acceptance, the schema-v2 and Simulation-v2 contracts, the Task 0024W acceptance, the existing eight level JSON files and accepted level-validation examples;
8. record pre-task hashes for loader, Simulation, BFS, schemas, vectors, five v2 fixtures, catalog, all eight existing formal levels, accepted wrapper and Task 0024W sealed repository artifacts;
9. stop on remote drift, unexpected dirty state, process ambiguity, foundation drift, historical evidence drift or any need to access Profile/user-data surfaces.

Production Profile content/metadata/siblings, ordinary user data and the test-profile root are forbidden.

## 4. Authorized repository paths

Product/test candidate paths:

```text
data/levels/crate_shadow_timing.json
tests/levels/task_0024y_crate_shadow_timing_validation.gd
tests/levels/task_0024y_crate_shadow_timing_validation.gd.uid
tests/tools/task_0024y_*.ps1
tests/tools/task_0024y_*.py
tests/tools/task_0024y_*.json
docs/level_design/validation/sequence_09_crate_shadow_timing_validation.json
docs/reports/0024Y_SEQUENCE_9_CRATE_SHADOW_TIMING_MACHINE_VALIDATION_REPORT.md
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

No other path may change. A generated UID is allowed only for the new dedicated test script and must be reviewed and tracked explicitly. Existing UID sidecars remain frozen.

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

Do not modify the catalog or route parser to make the candidate playable. This task validates the uncatalogued candidate directly through the public loader and shared Simulation.

## 6. Candidate level data contract

Create `data/levels/crate_shadow_timing.json` with:

- `schema_version = 2`;
- exact `level_id = "crate_shadow_timing"`;
- exact working `title = "Crate-Shadow Timing"`;
- one ECHO with stable ID `echo_phase` and delay 2–4;
- one crate with stable ID `crate_phase`;
- one Plate with stable ID `plate_window`;
- one Door with stable ID `door_window`, initially closed and dependent only on `plate_window`;
- empty arrays for keys, locks, barrier groups, sensors and latches;
- one YOU-only EXIT;
- metadata that names crate phase timing, YOU-only push, ECHO crate blocking and next-turn Door use without embedding the solution;
- `validation.recommended_search_depth = 48`.

The level must remain within the frozen footprint/cardinality limits. Terrain, spawn, delay and entity positions may be iterated before the final result.

The file is a machine-validated candidate, not a cataloged/formally admitted level. Do not set catalog sequence, unlock or finale state anywhere.

## 7. Dedicated focused validation

Create `tests/levels/task_0024y_crate_shadow_timing_validation.gd` using only the accepted public loader, shared Simulation and BFS solver.

Required terminal marker:

```text
TASK_0024Y_CRATE_SHADOW_TIMING_PASS
```

Failure prefix:

```text
TASK_0024Y_CRATE_SHADOW_TIMING_FAIL
```

The focused validation must prove all items below.

### 7.1 Identity and schema

- exact level ID/title and schema version;
- exact stable entity IDs and cardinalities;
- footprint and empty forbidden-family arrays;
- one ECHO delay in the allowed band;
- one Plate/Door dependency and YOU-only exit;
- loader validity through `load_file`, not private parser shortcuts.

### 7.2 Solver and replay

Using limits no larger than the frozen maximum:

- status `SOLVED`;
- `L*` between 13 and 16 inclusive;
- `N*` exact, between 4 and 20 inclusive;
- state/time/depth limits not exceeded;
- one deterministic shortest witness;
- witness length equals `L*`;
- witness replays to completion through shared Simulation;
- replaying the witness twice produces identical states and canonical-key traces;
- exact restart reconstructs every mutable field;
- a changed crate position changes the canonical key.

Record exact solution, `L*`, `N*`, visited states, maximum frontier, configured limits, waits, blocked YOU actions and consequential push count.

### 7.3 Required temporal event

The validation must identify and retain an exact trace proving:

1. YOU legally pushes `crate_phase` into the intended phase cell;
2. a later directional ECHO replay attempts to enter the crate-occupied cell and remains in place because ECHOs cannot push or enter crates;
3. that one-turn block changes the useful ECHO phase;
4. on a later start snapshot, `echo_phase` alone occupies `plate_window`, `door_window` is open, and YOU enters/crosses the Door;
5. YOU, not ECHO, reaches EXIT.

The trace must preserve before-state, action, transition result, crate/ECHO positions, history action, Plate/Door state and action index for every required event.

### 7.4 All-shortest-solutions proof

Do not prove the mechanic only from one convenient witness.

Run an instrumented shortest-depth search through shared `Simulation.transition` using an event mask for:

- legal YOU crate push;
- ECHO blocked by that crate;
- ECHO-only Plate/Door crossing event.

At depth `L*`:

- the total completed-path count must equal the solver's exact `N*`;
- every completed shortest path must contain the full required event mask;
- zero completed shortest paths may omit any required event;
- every accepted shortest path must use no more than two consequential pushes.

Use canonical state plus event mask/depth/count bookkeeping; do not implement a parallel transition system.

### 7.5 Necessity controls

Retain exact results for all controls:

1. **No-push control:** search the unchanged level through shared Simulation while rejecting every transition that changes crate position. The complete reachable finite state must exhaust unsolved within the authorized budget; reaching only a depth cutoff or state limit is not acceptance.
2. **Displaced-crate control:** move the initial crate to one explicitly documented valid floor cell outside the intended phase lane, validate the variant through the public loader, and prove it is complete-unsolved or materially changes `L*`/`N*` while eliminating the required full event chain.
3. **Static-blocker substitution:** remove the crate and replace its intended resting cell with static wall terrain in a schema-valid variant. It must not reproduce the baseline `L*`, `N*` and temporal event structure.
4. **No-ECHO control:** remove the ECHO, set only the schema-required zero-ECHO tutorial metadata for the control, and prove complete-unsolved or otherwise prove EXIT cannot be reached through the intended dependency.

At least the no-push control must be complete finite-state unsolved. No control may be reported as unsolved if it stopped only on time/depth/state limits.

### 7.6 Shortcut and rule probes

Prove or retain evidence for:

- no terrain walk-around bypasses `door_window`;
- ECHO contact cannot move the crate;
- an illegal YOU push into a blocked destination does not move YOU or crate;
- blocked input history follows the accepted Simulation contract and is not used as a long repeated-input macro;
- the selected witness contains no repeated identical blocked-YOU macro longer than one consecutive repeat;
- ECHO on EXIT cannot complete the room;
- YOU cannot complete without the ECHO-held Door dependency;
- restart leaves no crate, Plate, Door, history or completion residue.

## 8. Authoring iteration doctrine

Before the final retained qualification, Codex may repeatedly edit only the authorized candidate JSON/test/helper paths and rerun bounded candidate checks.

Every iteration must:

- use the accepted wrapper for Godot execution;
- end with cleanup invocation count exactly one;
- leave no owned or unproven PID;
- end with total Godot count zero;
- remain inside the solver/time/state limits;
- be summarized honestly in the final report, including discarded candidates and why they failed.

Do not weaken tests to fit a candidate. Prefer the frozen hard-cut fallback. If the candidate cannot satisfy the hard bands and necessity controls, return a blocker without changing scope.

## 9. Final retained qualification

After the candidate and focused test are stable, run one retained Task 0024Y qualification cycle containing exactly these cases, each once in that cycle through the accepted wrapper:

1. `res://tests/levels/task_0024y_crate_shadow_timing_validation.gd`
   - marker: `TASK_0024Y_CRATE_SHADOW_TIMING_PASS`
   - stderr: empty;
2. `res://tests/run_all.gd`
   - marker: exact `TASK_0003_TESTS_PASS assertions=621 vectors=9`;
   - stderr: exactly `LEVEL_ID_MISMATCH`;
3. `res://tests/simulation/task_0024v_v2_solver_replay_canonical_malformed.gd`
   - marker: `TASK_0024V_V2_COMPLETE_PASS`;
   - stderr: empty.

The final retained cycle must record for each case:

- wrapper and native exit;
- exact marker count;
- exact stderr classification;
- cleanup invocation count/order;
- direct/descendant PID ownership;
- remaining owned/unproven PIDs;
- Godot count before/after;
- bounded stdout/stderr.

Final Godot count must be zero. Repetition before this final retained cycle is authoring qualification, not hidden final evidence. Do not create a seal or one-shot driver in Task 0024Y.

## 10. Machine-readable validation summary

Create:

```text
docs/level_design/validation/sequence_09_crate_shadow_timing_validation.json
```

It must include at least:

- schema/task/commit/Godot/wrapper identities;
- candidate file SHA-256;
- exact entity/footprint facts;
- limits, solver status, `L*`, exact `N*`, visited/frontier/time facts;
- exact witness action array;
- consequential push count, wait count and blocked-YOU count;
- required event indices and trace facts;
- all-shortest event-mask counts;
- no-push/displaced/static/no-ECHO control results;
- shortcut-probe results;
- restart/canonical/replay results;
- final wrapper qualification facts;
- `owner_playthrough_status = "PENDING_LATER_CURRICULUM_GATE"`;
- `catalog_admission_status = "NOT_AUTHORIZED"`.

Do not hand-edit claims that disagree with retained runtime output.

## 11. Required report and current docs

Create:

```text
docs/reports/0024Y_SEQUENCE_9_CRATE_SHADOW_TIMING_MACHINE_VALIDATION_REPORT.md
```

The report must state:

- exact changed paths and hashes;
- candidate design and discarded iterations;
- exact solver metrics and witness;
- required-event and all-shortest proof;
- necessity-control and shortcut results;
- final retained wrapper/process evidence;
- frozen/historical hash audit;
- unresolved owner playthrough/catalog admission;
- no Profile/catalog/finale/UI/release authority.

Update authorized current docs consistently after the terminal result.

## 12. Commit and push policy

On pass or honest blocker:

1. explicitly stage only authorized paths;
2. inspect staged names and run `git diff --cached --check`;
3. create one single-topic result commit; do not amend/rebase/squash;
4. fetch before push and stop on remote drift;
5. push only a clean fast-forward to `origin/main`;
6. require post-push `HEAD == origin/main`, divergence `0/0`, clean worktree and zero Godot processes;
7. report any separate correction commit transparently if genuinely required.

Suggested pass commit:

```text
feat: machine validate sequence 9 crate timing candidate
```

## 13. Terminal verdict

Return exactly one:

```text
SEQUENCE_9_CRATE_SHADOW_TIMING_MACHINE_VALIDATED_FOR_GPT_REVIEW
BLOCKED_SEQUENCE_9_CRATE_SHADOW_TIMING_VALIDATION
PROTECTED_DATA_BOUNDARY_BREACH
```

A pass establishes only an uncatalogued machine-validated sequence-9 candidate ready for GPT review. It does not authorize catalog/progression/finale/Profile changes, sequence 10 authoring, owner acceptance, Gameplay/UI, localization, assets/audio, build/export, release, upload or submission.
