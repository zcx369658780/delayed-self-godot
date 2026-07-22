# Task 0024Z — Author and machine-validate the sequence-10 key-route commitment candidate

- Status: `READY`
- Gate: `SEQUENCE 10 CANDIDATE AUTHORING / MACHINE VALIDATION / NO CATALOG OR PROFILE`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Required accepted checkpoint: `19a068334b583a1e72180d5c609fed4bf2c94e50`
- Accepted sequence-9 result commit: `445122ab035a4c9210f3280af58d054a35bef2bd`
- Accepted sequence-9 verdict: `TASK_0024Y_SEQUENCE_9_CRATE_SHADOW_TIMING_MACHINE_VALIDATION_ACCEPTED`
- Accepted scope verdict: `TASK_0024X_SUBMISSION_CORE_LEVELS_9_12_SCOPE_ACCEPTED`
- Accepted mechanics foundation: `TASK_0024W_COMPLETE_CORE_MECHANICS_FOUNDATION_ACCEPTED`
- Accepted foundation result commit: `7072566ef814f6969693bbc9335fcced5e424585`
- Accepted wrapper implementation/blob: `7c0712d6a602dc23200ccb147d0096acc6333305` / `5f14eb0feff903b40311c1c7283b20e2eabbffc2`
- Implemented/cataloged product baseline at start: exactly eight formal levels
- Uncatalogued accepted candidate at start: `crate_shadow_timing`
- Recommended Codex model: `GPT-5.6 Sol Max`; fallback `GPT-5.6 Sol High`

## 1. Objective

Create one uncatalogued schema-v2 candidate level for future sequence 10, prove its intended YOU-only key/lock route commitment through the accepted public loader, shared Simulation and BFS solver, and retain bounded machine-readable evidence for GPT review.

Candidate identity:

```text
level_id: key_route_commitment
English working title: The Key Is Yours
Simplified-Chinese planned title: 独行钥匙
future sequence: 10
classification: core candidate; not catalog-admitted
```

This task may iterate the candidate and its dedicated validation artifacts until the machine contract passes. It must not add either sequence-9 or sequence-10 candidates to the catalog, alter unlock progression/finale/Profile, modify Gameplay/UI, or claim owner/formal admission.

## 2. Binding design brief

The candidate must teach a reasoning structure not present in sequences 1–9:

- only YOU collects the single `main` key;
- only YOU can spend that key to remove the matching lock;
- matching lock consumption and entry happen on the same accepted turn;
- the key detour writes delayed history needed by the ECHO downstream;
- lock removal is an irreversible room-local route commitment until restart;
- after the commitment, the ECHO creates the required Plate/Door window while YOU crosses;
- the key/lock must not merely add walking distance.

Frozen target envelope:

- exactly one key with `key_type = "main"`;
- exactly one matching lock with `key_type = "main"`;
- exactly one ECHO with delay 2 through 4;
- exactly one v1 Plate and one v1 Door;
- zero crates, typed sensors, grouped barriers and latches;
- footprint 8–10 cells wide and 6–8 cells high;
- one irreversible inventory/route commitment;
- target `L* = 15–19`;
- exact target `N* = 1–8`;
- solver maximum: depth 56, 400,000 states, 25,000 ms, count cap 1,000,000.

Do not silently widen the bands or introduce a second key type, multiple locks, hidden inventory, or a consumable soft-lock without readable restart evidence. Use the frozen hard-cut fallback—one key, one lock, one ECHO-timed downstream Door—before returning a blocker.

## 3. Startup gate

Before editing or launching Godot:

1. require root `D:\Delayed_Self`, branch `main`, expected origin and no Git operation in progress;
2. fetch and fast-forward only;
3. require `HEAD == origin/main`, divergence `0/0`, and ancestry of `19a068334b583a1e72180d5c609fed4bf2c94e50`;
4. require clean tracked worktree, zero staged paths and no unexpected untracked files;
5. require zero pre-existing Godot processes; never close unknown/pre-existing processes;
6. require Godot `4.7.1.stable.steam.a13da4feb` and accepted wrapper blob `5f14eb0feff903b40311c1c7283b20e2eabbffc2`;
7. read `AGENTS.md`, current startup/active docs, this full task, Task 0024X scope and GPT acceptance, Task 0024Y report/summary/GPT acceptance, schema-v2 and Simulation-v2 contracts, Task 0024W acceptance, all eight formal levels and the accepted sequence-9 candidate/test;
8. record pre-task hashes for loader, Simulation, BFS, schemas, vectors, five v2 fixtures, catalog, eight formal levels, accepted sequence-9 candidate/test/summary/report/GPT acceptance, accepted wrapper and Task 0024W sealed repository artifacts;
9. stop on remote drift, unexpected dirty state, process ambiguity, foundation drift, sequence-9 drift, historical evidence drift or any need to access Profile/user-data surfaces.

Production Profile content/metadata/siblings, ordinary user data and the test-profile root are forbidden.

## 4. Authorized repository paths

Candidate and validation paths:

```text
data/levels/key_route_commitment.json
tests/levels/task_0024z_key_route_commitment_validation.gd
tests/levels/task_0024z_key_route_commitment_validation.gd.uid
tests/tools/task_0024z_*.ps1
tests/tools/task_0024z_*.py
tests/tools/task_0024z_*.json
docs/level_design/validation/sequence_10_key_route_commitment_validation.json
docs/reports/0024Z_SEQUENCE_10_KEY_ROUTE_COMMITMENT_MACHINE_VALIDATION_REPORT.md
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
docs/level_design/validation/sequence_09_crate_shadow_timing_validation.json
docs/reports/0024Y_SEQUENCE_9_CRATE_SHADOW_TIMING_MACHINE_VALIDATION_REPORT.md
docs/reports/0024Y_GPT_SEQUENCE_9_CRATE_SHADOW_TIMING_MACHINE_VALIDATION_ACCEPTANCE.md
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

Do not modify catalog or route parsing to make the candidate playable. Validate it directly through public loader and shared Simulation.

## 6. Candidate level data contract

Create `data/levels/key_route_commitment.json` with:

- `schema_version = 2`;
- exact `level_id = "key_route_commitment"`;
- exact working `title = "The Key Is Yours"`;
- one ECHO with stable ID `echo_route` and delay 2–4;
- one key with stable ID `key_main`, `key_type = "main"`;
- one lock with stable ID `lock_main`, `key_type = "main"`;
- one Plate with stable ID `plate_route`;
- one Door with stable ID `door_route`, initially closed and dependent only on `plate_route`;
- empty arrays for crates, barrier groups, sensors and latches;
- one YOU-only EXIT;
- metadata naming YOU-only key collection, same-turn lock consumption, irreversible route commitment and downstream delayed Door use without embedding the solution;
- `validation.recommended_search_depth = 56`.

Terrain, spawn, delay and entity positions may be iterated before the terminal result. The file remains an uncatalogued candidate and must contain no sequence/unlock/finale state.

## 7. Dedicated focused validation

Create `tests/levels/task_0024z_key_route_commitment_validation.gd` using only the accepted public loader, shared Simulation and BFS solver.

Required terminal marker:

```text
TASK_0024Z_KEY_ROUTE_COMMITMENT_PASS
```

Failure prefix:

```text
TASK_0024Z_KEY_ROUTE_COMMITMENT_FAIL
```

The validation must prove all sections below.

### 7.1 Identity and schema

- exact level ID/title/schema version;
- exact stable IDs and cardinalities;
- footprint and empty forbidden-family arrays;
- one ECHO delay in the allowed band;
- exact one-key/one-lock `main` contract;
- one Plate/Door dependency and YOU-only EXIT;
- loader validity through `load_file`.

### 7.2 Solver and replay

Using limits no larger than the frozen maximum:

- status `SOLVED`;
- `L*` between 15 and 19 inclusive;
- `N*` exact, between 1 and 8 inclusive;
- no depth/state/time limit exceeded;
- one deterministic shortest witness;
- witness length equals `L*`;
- witness replays to completion through shared Simulation;
- replaying twice produces identical states and canonical-key traces;
- restart reconstructs all mutable fields;
- canonical key distinguishes remaining key, held key and removed lock states.

Record exact witness, `L*`, `N*`, visited states, maximum frontier, elapsed time, configured limits, waits and blocked-YOU actions.

### 7.3 Required ordered temporal event

Retain an exact trace proving, in order:

1. YOU enters `key_main`, removes it from remaining keys and gains one held `main` key;
2. ECHO contact with the key location cannot collect it or create inventory;
3. later, YOU enters `lock_main` with the held key; on that same accepted turn the lock is recorded removed, the key is consumed and YOU occupies the former lock cell;
4. ECHO contact with an intact lock cannot remove or cross it;
5. after the irreversible commitment, the delayed ECHO alone occupies `plate_route`, `door_route` is open in the start snapshot and YOU enters/crosses the Door;
6. YOU, not ECHO, reaches EXIT.

The trace must retain before/action/after player, ECHO, key inventory, remaining key IDs, removed lock IDs, history, Plate/Door state and action index.

### 7.4 All-shortest-solutions proof

Run an instrumented shortest-depth search through shared `Simulation.transition` using ordered event state for:

- YOU-only key collection;
- same-turn matching-lock consumption and entry after collection;
- downstream ECHO-only Plate/Door crossing after lock removal.

At depth `L*`:

- total completed-path count equals solver exact `N*`;
- every completed shortest path contains the full ordered event chain;
- zero completed shortest paths omit key collection, lock consumption or delayed Door crossing;
- no accepted shortest path uses a second key/lock or bypasses the lock.

Use canonical state plus event state/depth/count bookkeeping; do not implement parallel transitions.

### 7.5 Necessity controls

Retain exact results for:

1. **No-key control:** remove the key while retaining the lock and route. It must be schema-valid and complete finite-state unsolved. A limit result is not acceptance.
2. **No-lock control:** remove the lock in a schema-valid variant. It must materially change `L*` or `N*` and eliminate the intended same-turn lock-consumption event; it must not be presented as equivalent curriculum.
3. **Key displaced control:** move the key to one documented valid floor cell outside the intended preparation detour. It must be complete-unsolved or materially change metrics while eliminating the required ordered chain.
4. **ECHO-item route control:** create a schema-valid variant or deterministic shared-Simulation probe in which ECHO contacts key and intact lock cells before YOU. Prove that ECHO changes neither remaining key IDs, held keys nor removed lock IDs and cannot substitute for YOU.
5. **No-ECHO control:** remove the ECHO, set only schema-required zero-ECHO metadata for the control, and prove complete finite-state unsolved or otherwise prove the intended downstream dependency cannot complete.

At least no-key must be complete finite-state unsolved. No control may be labeled unsolved after only a depth/time/state cutoff.

### 7.6 Shortcut and rule probes

Prove or retain evidence for:

- the intact lock is a terrain/route articulation; no walk-around reaches the downstream Door/EXIT;
- YOU cannot enter/remove the lock without held `main` key;
- matching lock removal consumes exactly one key and enters on the same turn;
- ECHO cannot collect key, hold inventory, remove lock or cross intact lock;
- key cannot be collected after its lock has already been removed in the accepted chain;
- no direct EXIT route bypasses the ECHO-held Door dependency;
- ECHO on EXIT cannot complete;
- witness has no repeated identical blocked-YOU macro longer than one consecutive repeat;
- restart restores key, lock, inventory, Plate, Door, history and completion with zero residue.

## 8. Authoring iteration doctrine

Before final retained qualification, Codex may repeatedly edit only Task 0024Z-authorized candidate/test/helper paths and rerun bounded checks.

Every iteration must:

- use the accepted wrapper for Godot execution;
- invoke cleanup exactly once;
- leave no owned or unproven PID;
- end with total Godot count zero;
- remain within limits;
- be summarized honestly in the final report, including discarded candidates and failure reasons.

Do not weaken tests or widen bands. Prefer the hard-cut fallback before returning a blocker.

## 9. Final retained qualification

After the candidate and focused test are stable, run one retained Task 0024Z qualification cycle containing exactly these cases, each once in that cycle through the accepted wrapper:

1. `res://tests/levels/task_0024z_key_route_commitment_validation.gd`
   - marker: `TASK_0024Z_KEY_ROUTE_COMMITMENT_PASS`;
   - stderr: empty;
2. `res://tests/levels/task_0024y_crate_shadow_timing_validation.gd`
   - marker: `TASK_0024Y_CRATE_SHADOW_TIMING_PASS`;
   - stderr: empty;
3. `res://tests/run_all.gd`
   - marker: exact `TASK_0003_TESTS_PASS assertions=621 vectors=9`;
   - stderr: exactly `LEVEL_ID_MISMATCH`;
4. `res://tests/simulation/task_0024v_v2_solver_replay_canonical_malformed.gd`
   - marker: `TASK_0024V_V2_COMPLETE_PASS`;
   - stderr: empty.

Per case retain wrapper/native exit, marker count, stderr classification, cleanup count/order, direct/descendant ownership, remaining owned/unproven PIDs, Godot before/after and bounded stdout/stderr. Final Godot count must be zero.

Repetitions before the retained cycle are authoring checks, not hidden final evidence. Do not create a seal or one-shot driver in Task 0024Z.

## 10. Machine-readable validation summary

Create:

```text
docs/level_design/validation/sequence_10_key_route_commitment_validation.json
```

Include at least:

- task/commit/Godot/wrapper identities;
- candidate SHA-256 and entity/footprint facts;
- limits, solver status, `L*`, exact `N*`, visited/frontier/time;
- exact witness actions;
- wait and blocked-YOU counts;
- ordered event indices and trace facts;
- all-shortest event counts;
- no-key/no-lock/displaced/ECHO-item/no-ECHO controls;
- shortcut probes;
- restart/canonical/replay facts;
- final four-case wrapper qualification;
- `owner_playthrough_status = "PENDING_LATER_CURRICULUM_GATE"`;
- `catalog_admission_status = "NOT_AUTHORIZED"`.

Do not hand-edit claims that disagree with retained runtime output.

## 11. Required report and current docs

Create:

```text
docs/reports/0024Z_SEQUENCE_10_KEY_ROUTE_COMMITMENT_MACHINE_VALIDATION_REPORT.md
```

The report must state exact changed paths/hashes, discarded iterations, solver metrics/witness, ordered/all-shortest proof, controls/shortcuts, final wrapper/process evidence, frozen/sequence-9/historical hash audit, unresolved owner/catalog status and protected boundaries.

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
feat: machine validate sequence 10 key route candidate
```

## 13. Terminal verdict

Return exactly one:

```text
SEQUENCE_10_KEY_ROUTE_COMMITMENT_MACHINE_VALIDATED_FOR_GPT_REVIEW
BLOCKED_SEQUENCE_10_KEY_ROUTE_COMMITMENT_VALIDATION
PROTECTED_DATA_BOUNDARY_BREACH
```

A pass establishes only an uncatalogued machine-validated sequence-10 candidate ready for GPT review. It does not authorize catalog/progression/finale/Profile changes, sequence-11 authoring, owner acceptance, Gameplay/UI, localization, assets/audio, build/export, release, upload or submission.
