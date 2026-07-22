# Task 0024AC — Author and machine-validate the sequence-12 lasting-echo latch candidate

- Status: `READY`
- Gate: `SEQUENCE 12 FINALE-CANDIDATE AUTHORING / MACHINE VALIDATION / NO CATALOG OR PROFILE`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Required accepted checkpoint: `349f0436691e7f0a7ee73af36870e0b026bba49d`
- Accepted sequence-11 result commit: `e6cd9fe76c19a144315b173b480ad5f9ccf2f115`
- Accepted sequence-11 verdict: `TASK_0024AB_SEQUENCE_11_IDENTITY_SHIFT_BRIDGE_CORRECTED_MACHINE_VALIDATION_ACCEPTED`
- Accepted sequence-10 result commit: `b8378bc2e1e96642ff99eded436df65e2435cc9f`
- Accepted sequence-9 result commit: `445122ab035a4c9210f3280af58d054a35bef2bd`
- Accepted scope verdict: `TASK_0024X_SUBMISSION_CORE_LEVELS_9_12_SCOPE_ACCEPTED`
- Accepted mechanics foundation: `TASK_0024W_COMPLETE_CORE_MECHANICS_FOUNDATION_ACCEPTED`
- Accepted wrapper implementation/blob: `7c0712d6a602dc23200ccb147d0096acc6333305` / `5f14eb0feff903b40311c1c7283b20e2eabbffc2`
- Implemented/cataloged product baseline at start: exactly eight formal levels
- Accepted uncatalogued candidates at start: `crate_shadow_timing`, `key_route_commitment`, `identity_shift_bridge`
- Recommended Codex model: `GPT-5.6 Sol Max`; fallback `GPT-5.6 Sol High`

## 1. Objective

Create one uncatalogued schema-v2 candidate for future sequence 12 and prove its two-phase one-shot-latch synthesis through the public loader, shared Simulation and accepted BFS solver.

Candidate identity:

```text
level_id: lasting_echo_latch
English working title: The Lasting Echo
Simplified-Chinese planned title: 余响落锁
future sequence: 12
classification: core candidate; FINALE_CANDIDATE_ONLY; not catalog-admitted
```

This task does not make sequence 12 the formal finale. It must not modify the existing sequence-8 final flag, catalog, progression, Profile, Gameplay/UI or release surfaces.

## 2. Binding curriculum

The candidate must synthesize already taught rules without debuting a new mechanic:

1. phase one coordinates YOU and delayed ECHO to activate exactly one one-shot latch;
2. the latch permanently changes one grouped barrier state for the remainder of the attempt;
3. phase two returns through the changed topology and solves a typed-sensor/grouped-barrier crossing using sequence-11 language;
4. restart reconstructs latch, barrier, sensors, actors, history and completion from immutable definitions;
5. the two phases and permanent topology change must be necessary in every shortest solution;
6. YOU, not ECHO, completes at EXIT.

Frozen envelope:

- exactly one latch, stable ID `latch_phase`;
- exactly one target barrier group `barrier_phase`, one to three cells;
- one or two typed sensors using only already taught `YOU_ONLY` and/or `ECHO_ONLY` modes;
- all sensor `include_crates` fields explicit and false;
- one or two ECHOs with existing delays 2 through 4;
- zero crates, keys and locks;
- zero v1 Plates and v1 Doors;
- at most three mechanic families in the critical chain: latch, typed sensors, grouped barrier;
- footprint 10–12 cells wide and 7–9 cells high;
- target `L*=21–28`;
- exact target `N*=1–6`;
- maximum solver limits: depth 80, states 1,000,000, time 45,000 ms, solution-count cap 1,000,000.

Prefer the frozen fallback before returning a blocker: one ECHO, one latch opening one grouped route, and one previously taught typed-sensor crossing. Do not add a second ECHO or second sensor unless the simpler design cannot meet the two-phase necessity contract.

## 3. Startup gate

Before editing or launching Godot:

1. require root `D:\Delayed_Self`, branch `main`, expected origin and no Git operation in progress;
2. fetch and fast-forward only;
3. require `HEAD == origin/main`, divergence `0/0`, and ancestry of `349f0436691e7f0a7ee73af36870e0b026bba49d`;
4. require clean worktree, zero staged paths and no unexpected untracked files;
5. require zero pre-existing Godot processes;
6. require Godot `4.7.1.stable.steam.a13da4feb` and accepted wrapper blob `5f14eb0feff903b40311c1c7283b20e2eabbffc2`;
7. read `AGENTS.md`, current task/startup docs, this task, Task 0024X scope, sequence-9/10/11 summaries/reports/GPT acceptances, schema-v2/Simulation-v2 contracts, Task 0024W acceptance and headless lifecycle policy;
8. record pre-task hashes for foundation files, wrapper, catalog, eight formal levels, accepted candidate JSON/tests/summaries/reports/acceptances and Task 0024AA/AB historical evidence;
9. stop on remote drift, process ambiguity, accepted-artifact drift, evidence drift or any need to access Profile/user data.

Production Profile content/metadata/siblings, ordinary user data and test-profile root are forbidden.

## 4. Authorized paths

```text
data/levels/lasting_echo_latch.json
tests/levels/task_0024ac_lasting_echo_latch_validation.gd
tests/levels/task_0024ac_lasting_echo_latch_validation.gd.uid
tests/tools/task_0024ac_*.ps1
tests/tools/task_0024ac_*.py
tests/tools/task_0024ac_*.json
docs/level_design/validation/sequence_12_lasting_echo_latch_validation.json
docs/reports/0024AC_SEQUENCE_12_LASTING_ECHO_LATCH_MACHINE_VALIDATION_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/production/EXPANDED_CONTENT_SUBMISSION_ROADMAP_CURRENT.md
```

No other path may change. A generated UID is allowed only for the new dedicated test.

## 5. Frozen surfaces

Do not modify loader, Simulation, BFS, schema/contracts/vectors, wrapper, aggregate/complete-v2 tests, existing formal levels, accepted sequence-9/10/11 candidate or evidence artifacts, catalog, route parsing, scenes, app/gameplay code, project settings, assets, audio, localization, build/export/release/submission surfaces, or historical Task 0024T–0024AB evidence.

## 6. Candidate contract

Create `data/levels/lasting_echo_latch.json` with:

- schema version 2;
- exact ID/title above;
- latch ID `latch_phase`;
- barrier group ID `barrier_phase`;
- latch targets `barrier_phase` and has one terminal `target_open` state;
- one or two sensors with stable IDs beginning `sensor_phase_`, typed only `YOU_ONLY`/`ECHO_ONLY`, `include_crates=false`;
- one or two ECHOs with stable IDs beginning `echo_phase_`, delay 2–4;
- empty crates/keys/locks and empty v1 plates/doors;
- one YOU-only EXIT;
- metadata naming two-phase latch permanence, restart reset and reused identity/barrier timing without embedding the route;
- `validation.recommended_search_depth=80`.

The candidate remains uncatalogued and may not contain sequence, unlock or finale state.

## 7. Focused validation

Create `tests/levels/task_0024ac_lasting_echo_latch_validation.gd` using only public loader, shared Simulation and accepted BFS solver.

Pass marker:

```text
TASK_0024AC_LASTING_ECHO_LATCH_PASS
```

Failure prefix:

```text
TASK_0024AC_LASTING_ECHO_LATCH_FAIL
```

### 7.1 Identity and schema

Prove exact identity, footprint, cardinalities, stable IDs/references, allowed sensor modes, explicit no-crate eligibility, forbidden-family emptiness, YOU-only EXIT and public `load_file` validity.

### 7.2 Solver/replay

Prove:

- `SOLVED`;
- `L*=21–28`;
- exact `N*=1–6`;
- no configured limit exceeded;
- deterministic shortest witness and duplicate replay;
- witness length equals `L*` and completes;
- exact restart;
- canonical key distinguishes pre/post latch, relevant barrier states, actors, history and completion;
- fresh exact integer `elapsed_ms` retained.

Record witness, limits, visited/frontier/time, waits and blocked-YOU actions.

### 7.3 Ordered two-phase event

Retain exact before/action/after evidence proving in order:

1. the intended actor/sensor occupancy activates `latch_phase` for the first and only time;
2. latch state becomes activated and permanently applies the target `barrier_phase` state;
3. YOU leaves phase one and traverses/returns through topology that would be unavailable before latch activation;
4. phase two uses only previously taught typed-sensor/grouped-barrier timing;
5. a critical crossing occurs only after the permanent phase transition;
6. the latch remains activated on later turns and cannot activate a second time;
7. YOU reaches EXIT; ECHO does not complete.

The event trace must distinguish latch-caused persistent barrier state from temporary sensor-caused state.

### 7.4 All-shortest proof

Use shared `Simulation.transition` with canonical state and ordered event state. At depth `L*` prove:

- completed-path count equals exact solver `N*`;
- every shortest path contains latch first activation, persistent post-latch phase, required phase-two typed crossing and YOU completion;
- omissions zero;
- every shortest path has at least one state before and one state after latch activation;
- no shortest path reaches EXIT before latch activation;
- no parallel transition implementation.

### 7.5 Necessity controls

Retain exact results for:

1. **Latch disabled:** remove latch or make a schema-valid nonactivating control; complete finite-state unsolved or eliminate the required two-phase chain with material metric change.
2. **Latch resets after activation:** restricted search rejects any transition/state path that preserves activation into the next phase; complete finite-state unsolved.
3. **Target reversed:** reverse the latch terminal target state in a schema-valid control; complete-unsolved or material metric/event change.
4. **Direct post-latch-route:** modify the topology to expose the post-latch route initially; materially lower metrics and remove the phase transition event.
5. **No-ECHO:** schema-valid zero-ECHO control; complete finite-state unsolved when ECHO is required by the chosen design.
6. **Sensor simplification:** replace the phase-two typed sensor with `ANY_ACTOR` or remove its identity distinction; materially change metrics/structure and eliminate the accepted typed-identity claim.

At least latch-disabled and latch-reset must be complete finite-state unsolved. No limit result may be called unsolved.

### 7.6 Shortcut/rule probes

Prove:

- EXIT cannot be reached before latch activation;
- latch activates once and persists;
- repeated contact does not create another activation transition;
- restart clears latch and restores exact initial barrier/sensor state;
- no barrier state leaks between attempts;
- phase-two route cannot bypass the typed dependency;
- ECHO on EXIT is nonterminal;
- no direct terrain walk-around;
- no repeated identical blocked-YOU macro longer than one consecutive repeat;
- critical solution chain uses no more than the allowed three families.

## 8. Bounded evidence format

Apply the Task 0024AB lesson from the start. Emit independently parseable prefixed JSON records, each strictly below 1800 UTF-8 bytes. Include separate metrics, witness, event, all-shortest, controls, shortcuts and replay/restart records. The parser must reject missing, duplicate, truncated, non-JSON and over-bound records, and must retain raw byte counts.

The metrics record must contain fresh exact `elapsed_ms`. Do not rely on monolithic compact output.

## 9. Iteration doctrine

Before the final retained cycle, bounded authoring iterations are allowed only on authorized candidate/test/helper paths. Every Godot execution must use the accepted wrapper, cleanup once, leave no owned/unproven PID and end at Godot zero. Preserve discarded candidates and reasons. Do not weaken tests or widen bands.

## 10. Final retained cycle

After stable qualification, execute exactly once each in one retained Task 0024AC cycle:

1. focused Task 0024AC — empty stderr;
2. accepted focused Task 0024AB — empty stderr;
3. accepted focused Task 0024Z — empty stderr;
4. accepted focused Task 0024Y — empty stderr;
5. Aggregate — exact `TASK_0003_TESTS_PASS assertions=621 vectors=9`, stderr exactly `LEVEL_ID_MISMATCH`;
6. corrected complete-v2 — empty stderr.

Retain wrapper/native exits, marker counts, stderr, cleanup count/order, ownership/PIDs, Godot before/after and bounded output. Final Godot count must be zero. Once declared retained and consumed, do not rerun.

## 11. Machine summary and report

Create:

```text
docs/level_design/validation/sequence_12_lasting_echo_latch_validation.json
docs/reports/0024AC_SEQUENCE_12_LASTING_ECHO_LATCH_MACHINE_VALIDATION_REPORT.md
```

Include exact identities/hashes, candidate facts, metrics/witness, ordered/all-shortest evidence, controls/shortcuts, bounded-record audit, six-case lifecycle evidence, frozen-hash audit and authoring history.

Set:

```text
classification = UNCATALOGUED_SEQUENCE_12_CORE_CANDIDATE
finale_status = FINALE_CANDIDATE_ONLY
owner_playthrough_status = PENDING_LATER_CURRICULUM_GATE
catalog_admission_status = NOT_AUTHORIZED
```

## 12. Commit/push

Stage only authorized paths, inspect staged files, run `git diff --cached --check`, make one single-topic commit without amend/rebase/squash, fetch before push, fast-forward push only, and require post-push clean worktree, divergence `0/0` and Godot zero.

Suggested pass commit:

```text
feat: machine validate sequence 12 latch finale candidate
```

## 13. Terminal verdict

Return exactly one:

```text
SEQUENCE_12_LASTING_ECHO_LATCH_MACHINE_VALIDATED_FOR_GPT_REVIEW
BLOCKED_SEQUENCE_12_LASTING_ECHO_LATCH_VALIDATION
PROTECTED_DATA_BOUNDARY_BREACH
```

A pass does not authorize catalog/progression/finale/Profile changes, owner acceptance, presentation/UI, localization, assets/audio, build/export, release, upload or submission.