# Task 0024BA — Author and machine-validate Phase-1 C07 crate-to-ECHO handoff candidate

- Status: `READY`
- Gate: `C07 SINGLE CANDIDATE / ORDERED CRATE-TO-ECHO HANDOFF / TWO-STAGE ROLE NECESSITY / INDEPENDENT RETAINED VALIDATION`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Required accepted checkpoint in ancestry: `c14d445b98c06295c9af4a5054efb15318195af7`
- Previous accepted gate: `TASK_0024AZ_S03_ECHO_ONLY_SENSOR_MACHINE_VALIDATION_ACCEPTED`
- Candidate slot: `C07`
- Candidate classification: Phase-1 synthesis-proof candidate; uncatalogued
- Production catalog at start/end: exactly sequences 1–8
- Formal finale at start/end: sequence 8 only
- Candidate admission: `NOT_AUTHORIZED`
- Profile/catalog/finale migration: not authorized
- DeepSeek project-code routing: `DISABLED`

## 1. Objective

Create one uncatalogued schema-v2 C07 candidate that proves this ordered handoff:

```text
YOU positions crate on a crate-eligible handoff sensor
→ first grouped barrier opens after transition resolution
→ delayed ECHO crosses the crate-opened route
→ ECHO activates a distinct ECHO_ONLY sensor
→ second grouped barrier opens after transition resolution
→ YOU crosses the ECHO-opened route
→ YOU reaches EXIT
```

The candidate must prove authored crate commitment, sustained crate occupancy, ECHO access, ECHO-only second-stage activation, later YOU traversal, all-shortest ordered necessity, replay/restart/canonical identity and an independent retained lifecycle.

This task authorizes C07 only. S04/0024BB remains closed.

## 2. Frozen identity

```text
candidate_slot = C07
level_id = phase_1_c07_crate_echo_handoff
working_title_en = Hand Off
working_title_zh = 递给回声
candidate_status = UNCATALOGUED_PHASE_1_MACHINE_VALIDATION
production_sequence = UNASSIGNED
catalog_status = NOT_AUTHORIZED
owner_review_status = NOT_REVIEWED
presentation_status = OWNER_REVIEW_PENDING
```

Candidate path:

```text
data/levels/phase_1_c07_crate_echo_handoff.json
```

No catalog entry, sequence, unlock edge, finale flag or Profile behavior may be added.

## 3. Binding distinction

Use `docs/level_design/phase_1/C07_CRATE_ECHO_COOPERATION_BRIEF.md`.

```text
C02 = crate-specific destination opens an ECHO route
S03 = ECHO_ONLY trigger opens a YOU route
C07 = ordered composition of both responsibilities into one necessary handoff chain
```

Fail if crate or ECHO is optional, YOU substitutes at either stage, either barrier is bypassable, stage order is unnecessary, ECHO completes EXIT, or any shortest solution omits a handoff stage.

## 4. Required reads

Read:

```text
AGENTS.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
tasks/0024BA_phase_1_c07_crate_echo_handoff_authoring_and_machine_validation.md
docs/reports/0024AZ_GPT_S03_ECHO_ONLY_SENSOR_ACCEPTANCE.md
docs/reports/0024AYR_GPT_C03_NEXT_TURN_DOOR_RETRY_ACCEPTANCE.md
docs/reports/0024AW_GPT_C02_CRATE_PRESSURE_IMPRINT_ACCEPTANCE.md
docs/level_design/phase_1/C07_CRATE_ECHO_COOPERATION_BRIEF.md
docs/level_design/phase_1/PHASE_1_SIX_CANDIDATE_BRIEFS_CURRENT.md
docs/level_design/phase_1/PHASE_1_SIX_CANDIDATE_VALIDATION_PLAN_CURRENT.md
docs/level_design/OWNER_FEEDBACK_LEVEL_PORTFOLIO_MATRIX_CURRENT.md
docs/game_design/GAMEPLAY_SIMULATION_CONTRACT_V2_CURRENT.md
docs/level_design/LEVEL_SCHEMA_V2_CURRENT.md
schemas/level_v2.schema.json
scripts/simulation/level_loader.gd
scripts/simulation/simulation.gd
scripts/solver/bfs_solver.gd
data/levels/phase_1_c02_crate_pressure_imprint.json
data/levels/phase_1_s03_echo_only_sensor.json
data/levels/phase_1_c03_crate_delayed_door.json
tests/levels/task_0024aw_c02_crate_pressure_imprint_validation.gd
tests/levels/task_0024az_s03_echo_only_sensor_validation.gd
tests/levels/task_0024ayr_c03_crate_delayed_door_validation.gd
docs/reports/0024AW_C02_CRATE_PRESSURE_IMPRINT_MACHINE_VALIDATION_REPORT.md
docs/reports/0024AZ_S03_ECHO_ONLY_SENSOR_MACHINE_VALIDATION_REPORT.md
tests/tools/run_owned_godot_headless.ps1
tests/run_all.gd
tests/simulation/task_0024v_v2_solver_replay_canonical_malformed.gd
```

Read all existing level filenames/hashes before writing. Profile data is forbidden.

## 5. Startup gate

Require synchronized `main`, divergence `0/0`, checkpoint ancestry, clean tracked/staged state, only accepted `.codex/config.toml`, Godot `4.7.1.stable.steam.a13da4feb`, zero pre-existing Godot processes, no 0024BA artifacts, and frozen hashes for loader/Simulation/BFS/schema/wrapper/Aggregate/complete-v2/catalog/levels/briefs/evidence. Consumed 0024AW/AX/AYR/AZ manifests remain immutable and must never run.

## 6. Authorized paths

```text
data/levels/phase_1_c07_crate_echo_handoff.json
tests/levels/task_0024ba_c07_crate_echo_handoff_validation.gd
tests/levels/task_0024ba_c07_crate_echo_handoff_validation.gd.uid
tests/tools/task_0024ba_*.ps1
tests/tools/task_0024ba_*.py
tests/tools/task_0024ba_*.json
docs/level_design/validation/phase_1_c07_crate_echo_handoff_validation.json
docs/reports/0024BA_C07_CRATE_ECHO_HANDOFF_MACHINE_VALIDATION_REPORT.md
docs/handoffs/DELAYED_SELF_SESSION_HANDOFF_AFTER_TASK_0024BA_C07_MACHINE_VALIDATION_2026_07_27.md
docs/level_design/phase_1/C07_CRATE_ECHO_COOPERATION_BRIEF.md
docs/level_design/phase_1/PHASE_1_SIX_CANDIDATE_BRIEFS_CURRENT.md
docs/level_design/phase_1/PHASE_1_SIX_CANDIDATE_VALIDATION_PLAN_CURRENT.md
docs/level_design/OWNER_FEEDBACK_LEVEL_PORTFOLIO_MATRIX_CURRENT.md
docs/production/EXPANDED_CONTENT_SUBMISSION_ROADMAP_CURRENT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
```

No other path may change. UID exception applies only to the new test.

## 7. Protected surfaces

Do not modify catalog, pre-existing levels/tests, scripts, scenes, project.godot, schemas, Aggregate, simulation tests, owned wrapper, Profile, presentation, localization, assets/audio, build/export/release/submission, or user-scope Codex files.

## 8. Candidate contract

Strict schema-v2:

```text
level_id = phase_1_c07_crate_echo_handoff
title = Hand Off
one YOU
one ECHO
one crate
two typed sensors
two grouped barriers
one YOU-only EXIT
zero keys, locks, Plates, Doors, latches
```

Stable IDs:

```text
echo_handoff
crate_handoff
sensor_crate_handoff
sensor_echo_handoff
barrier_echo_access
barrier_you_exit
```

First sensor:

```json
{"id":"sensor_crate_handoff","position":[X,Y],"activator":"YOU_ONLY","include_crates":true}
```

First barrier depends only on that sensor and starts closed.

Second sensor:

```json
{"id":"sensor_echo_handoff","position":[X,Y],"activator":"ECHO_ONLY","include_crates":false}
```

Second barrier depends only on that sensor and starts closed.

Envelope:

```text
ECHO delay 2–4
footprint 9–12 by 7–9
1–3 consequential pushes in every shortest solution
recommended depth <= 64
```

First barrier must materially control ECHO access; second barrier must materially control YOU access. The two barriers cannot be cosmetic copies.

## 9. Solver envelope

```text
target L* = 14–22
hard L* cap = 26
exact N* = 1–64
all-shortest cap = 128
soft/hard states = 150,000 / 400,000
soft/hard elapsed = 45 / 120 seconds
maximum depth = 64
```

Timeout, cutoff, truncation or hard-limit breach means redesign or `UNVERIFIED`. Do not widen limits.

## 10. Focused validation

Create `tests/levels/task_0024ba_c07_crate_echo_handoff_validation.gd`.

Markers:

```text
TASK_0024BA_C07_CRATE_ECHO_HANDOFF_PASS
TASK_0024BA_C07_CRATE_ECHO_HANDOFF_FAIL
```

Use only public loader, shared Simulation and BFS.

Prove exact identity/schema, catalog absence, exact solver facts, deterministic replay, exact restart, crate-sensitive canonical key, YOU-only completion and this ordered chain:

1. YOU legally pushes crate;
2. crate reaches and remains on first sensor;
3. first barrier opens after transition;
4. ECHO later crosses from an open start snapshot;
5. ECHO enters second sensor;
6. second barrier opens after transition;
7. YOU later crosses from an open start snapshot;
8. YOU reaches EXIT.

Strict ordering:

```text
crate_sensor_turn < echo_access_cross_turn
echo_sensor_turn < you_exit_barrier_cross_turn
```

## 11. All-shortest proof

Mandatory mask:

```text
LEGAL_CRATE_PUSH
CRATE_ON_HANDOFF_SENSOR
ECHO_ACCESS_BARRIER_OPEN_FROM_CRATE
ECHO_CROSSES_ACCESS_BARRIER
ECHO_ON_ECHO_ONLY_SENSOR
YOU_EXIT_BARRIER_OPEN_FROM_ECHO
YOU_CROSSES_EXIT_BARRIER
YOU_REACHES_EXIT
```

At `L*` require exact `N*/N*`, omissions zero, complete enumeration, 1–3 pushes, sustained crate occupancy through ECHO crossing, ECHO-only second-stage activation and strict ordering of both stages. Use shared transition only.

## 12. Controls

Every control must public-load. No cutoff may be called unsolved.

Required:

- no-push: complete-unsolved;
- first sensor `include_crates=false`: complete-unsolved;
- no-crate: complete-unsolved preferred, otherwise zero full-mask with material change;
- displaced crate;
- pre-positioned crate: shorter/materially different and authored push omitted;
- no-ECHO: complete-unsolved;
- second sensor `ANY_ACTOR`: YOU-substitution shortcut/material change;
- second sensor `YOU_ONLY`: complete-unsolved or body-only bypass;
- first barrier initially open: first-stage bypass;
- second barrier initially open: second-stage bypass;
- first dependency removed;
- second dependency removed;
- static-wall substitution;
- direct YOU bypass.

All must record exact metrics/event masks and completeness.

## 13. Rule/restart/presentation probes

Prove baseline typed eligibility, crate counting only via `include_crates=true`, ECHO crate restrictions, illegal push stability, start-snapshot barrier entry, post-movement barrier updates, sustained crate occupancy, no terrain bypass, YOU-only EXIT, no repeated blocked macros and exact restart.

Do not modify scenes. Set `MACHINE_CONTRACT_READY_OWNER_REVIEW_PENDING` only after static cue audit for distinct crate sensor, ECHO sensor, two barriers, ordered handoff, wrong-role/stalled-handoff feedback and color-independent redundancy.

## 14. Iteration, PRE_FINAL and retained lifecycle

Before PRE_FINAL, iterate only new candidate/test/helpers. Every run uses accepted wrapper, unique identity, bounded budgets, cleanup once, no PID residue, Godot zero and protected hashes unchanged.

After stable qualification:

1. freeze hashes;
2. static/parser/schema/protected audits;
3. focused twice;
4. current Aggregate and complete-v2;
5. exact markers/assertions/stderr;
6. PRE_FINAL seal;
7. prohibit edits;
8. Godot zero;
9. create one fresh 0024BA manifest.

Use accepted 0024AL architecture: Python stdlib parent, fresh PowerShell worker per case, accepted wrapper, atomic record/reopen, parent validation/journal.

Consume once and run:

```text
focused C07
current Aggregate
current complete-v2
```

Any consumed-cycle failure closes `BLOCKED`; no repair/rerun/replacement/reconstruction.

## 15. Evidence/current docs

Create C07 validation JSON, report and handoff. On success set C07 `MACHINE_VALIDATED_FOR_GPT_REVIEW`, owner `NOT_REVIEWED`, catalog `NOT_AUTHORIZED`, presentation `MACHINE_CONTRACT_READY_OWNER_REVIEW_PENDING`. S04/0024BB remains closed.

## 16. Validation and commit

Require one new level, one focused test plus UID, zero schema/Simulation/solver/Aggregate/existing-level/catalog/Profile/scenes/gameplay changes, DeepSeek not invoked, catalog 8, finale 8, Godot zero.

Commit exactly once:

```text
feat: machine validate Phase-1 C07 crate echo handoff
```

Push main; verify `HEAD == origin/main`, divergence `0/0`, clean tracked/staged state, only `.codex/config.toml` untracked, Godot zero. No second implementation commit.

## 17. Final fields

```text
candidate_slot = C07
level_id = phase_1_c07_crate_echo_handoff
candidate_status = MACHINE_VALIDATED_FOR_GPT_REVIEW / BLOCKED / UNVERIFIED
solver_status = SOLVED / UNSOLVED / LIMIT_REACHED / NOT_RUN
shortest_solution_length = <exact or NOT_VERIFIED>
shortest_solution_count = <exact or NOT_VERIFIED>
all_shortest_full_event_mask = <exact>/<exact> / NOT_VERIFIED
all_shortest_omissions = <exact or NOT_VERIFIED>
strict_first_stage_order = YES / NO / NOT_VERIFIED
strict_second_stage_order = YES / NO / NOT_VERIFIED
consequential_push_range = <exact or NOT_VERIFIED>
no_push_control = COMPLETE_UNSOLVED / OTHER / NOT_VERIFIED
first_sensor_excludes_crate = COMPLETE_UNSOLVED / OTHER / NOT_VERIFIED
no_crate_control = COMPLETE_UNSOLVED / OTHER / NOT_VERIFIED
displaced_crate_control = <exact or NOT_VERIFIED>
prepositioned_crate_control = <exact or NOT_VERIFIED>
no_echo_control = COMPLETE_UNSOLVED / OTHER / NOT_VERIFIED
second_sensor_any_actor = <exact or NOT_VERIFIED>
second_sensor_you_only = <exact or NOT_VERIFIED>
first_barrier_initially_open = <exact or NOT_VERIFIED>
second_barrier_initially_open = <exact or NOT_VERIFIED>
first_dependency_removed = <exact or NOT_VERIFIED>
second_dependency_removed = <exact or NOT_VERIFIED>
static_wall_control = <exact or NOT_VERIFIED>
direct_you_bypass = <exact or NOT_VERIFIED>
replay_deterministic = YES / NO / NOT_VERIFIED
restart_exact = YES / NO / NOT_VERIFIED
canonical_crate_identity = PASS / FAIL / NOT_VERIFIED
presentation_status = MACHINE_CONTRACT_READY_OWNER_REVIEW_PENDING
production_catalog_modified = NO / YES
formal_finale_modified = NO / YES
Profile_accessed = NO / YES
next_task_authorized = NO
final_task_verdict = PASS_FOR_GPT_REVIEW / BLOCKED / UNVERIFIED
```

## 18. Next gate

Only explicit GPT acceptance may open S04/0024BB. C07 remains uncatalogued, unsequenced and owner-unreviewed. Integrated comparison remains 0024BC; owner review remains 0024BD.
