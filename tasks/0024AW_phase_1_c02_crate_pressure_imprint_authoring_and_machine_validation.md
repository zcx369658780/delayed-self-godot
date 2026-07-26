# Task 0024AW — Author and machine-validate Phase-1 C02 crate-pressure-imprint candidate

- Status: `READY`
- Gate: `C02 SINGLE CANDIDATE / INTENDED-MECHANIC PROOF / INDEPENDENT RETAINED VALIDATION`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Required accepted checkpoint: `666d7921ef1865e603c916255fd337213accbcda`
- Previous accepted gate: `TASK_0024AV_PHASE_1_SIX_CANDIDATE_BRIEF_AND_VALIDATION_PLAN_ACCEPTED`
- Candidate: `C02`
- Production catalog: sequences 1–8 only
- Formal finale: sequence 8 only
- Candidate admission: `NOT_AUTHORIZED`
- DeepSeek project-code routing: `DISABLED`

## 1. Objective

Create and machine-validate one uncatalogued schema-v2 candidate:

```text
level_id = phase_1_c02_crate_pressure_imprint
working_title_en = Pressure Imprint
working_title_zh = 压印回路
candidate_status = UNCATALOGUED_PHASE_1_MACHINE_VALIDATION
production_sequence = UNASSIGNED
```

Required gameplay chain:

```text
YOU pushes crate onto crate-eligible sensor
→ grouped ECHO route opens next turn
→ delayed ECHO crosses that route
→ ECHO alone occupies a traditional Plate
→ Door opens next turn
→ YOU crosses Door and reaches EXIT
```

The crate must have a meaningful destination. Clearing an obstruction alone is insufficient.

This task authorizes C02 only. It does not authorize S01/0024AX, catalog integration, Profile access, finale movement, presentation code, build, release, or submission.

## 2. Required reads

```text
AGENTS.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
tasks/0024AW_phase_1_c02_crate_pressure_imprint_authoring_and_machine_validation.md
docs/reports/0024AV_GPT_PHASE_1_SIX_CANDIDATE_BRIEF_ACCEPTANCE.md
docs/level_design/phase_1/PHASE_1_SIX_CANDIDATE_BRIEFS_CURRENT.md
docs/level_design/phase_1/PHASE_1_SIX_CANDIDATE_VALIDATION_PLAN_CURRENT.md
docs/level_design/phase_1/C02_CRATE_PRESSURE_PLATE_BRIEF.md
docs/game_design/GAMEPLAY_SIMULATION_CONTRACT_V2_CURRENT.md
docs/level_design/LEVEL_SCHEMA_V2_CURRENT.md
schemas/level_v2.schema.json
scripts/simulation/level_loader.gd
scripts/simulation/simulation.gd
scripts/solver/bfs_solver.gd
data/levels/crate_shadow_timing.json
data/levels/identity_shift_bridge.json
tests/levels/task_0024y_crate_shadow_timing_validation.gd
docs/reports/0024Y_SEQUENCE_9_CRATE_SHADOW_TIMING_MACHINE_VALIDATION_REPORT.md
docs/reports/0024AL_GPT_PROCESS_ISOLATED_WRITE_AHEAD_SCHEMA_V2_PRESENTATION_ACCEPTANCE.md
tests/tools/run_owned_godot_headless.ps1
tests/run_all.gd
tests/simulation/task_0024v_v2_solver_replay_canonical_malformed.gd
```

All production/test Profile data is forbidden.

## 3. Startup gate

Before writing or launching Godot:

1. root `D:\Delayed_Self`, branch `main`, expected origin;
2. fetch/fast-forward only;
3. `HEAD == origin/main`, divergence `0/0`;
4. Task 0024AW/current pointers present;
5. accepted 0024AV checkpoint in ancestry;
6. no tracked/staged changes;
7. only accepted untracked `.codex/config.toml`, with accepted hash;
8. Godot version `4.7.1.stable.steam.a13da4feb`;
9. zero pre-existing Godot processes;
10. no Task 0024AW artifacts already exist;
11. hash/freeze loader, Simulation, BFS, schema, wrapper, Aggregate, complete-v2, catalog, all existing levels, Phase-1 briefs, and accepted retained evidence;
12. stop on remote drift, process ambiguity, protected drift, or any Profile requirement.

## 4. Authorized paths

```text
data/levels/phase_1_c02_crate_pressure_imprint.json
tests/levels/task_0024aw_c02_crate_pressure_imprint_validation.gd
tests/levels/task_0024aw_c02_crate_pressure_imprint_validation.gd.uid
tests/tools/task_0024aw_*.ps1
tests/tools/task_0024aw_*.py
tests/tools/task_0024aw_*.json
docs/level_design/validation/phase_1_c02_crate_pressure_imprint_validation.json
docs/reports/0024AW_C02_CRATE_PRESSURE_IMPRINT_MACHINE_VALIDATION_REPORT.md
docs/handoffs/DELAYED_SELF_SESSION_HANDOFF_AFTER_TASK_0024AW_C02_MACHINE_VALIDATION_2026_07_26.md
docs/level_design/phase_1/C02_CRATE_PRESSURE_PLATE_BRIEF.md
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

No other path may change. The UID exception applies only to the new dedicated test.

## 5. Protected surfaces

Do not modify:

```text
data/catalog/**
all pre-existing data/levels/**
scripts/**
scenes/**
project.godot
schemas/**
tests/run_all.gd
tests/simulation/**
all pre-existing tests/levels/**
tests/tools/run_owned_godot_headless.ps1
docs/game_design/GAMEPLAY_SIMULATION_CONTRACT_V2_CURRENT.md
docs/level_design/LEVEL_SCHEMA_V2_CURRENT.md
docs/playtest/**
localization/**
assets/**
audio/**
build/**
export/**
release/**
submission/**
C:\Users\zcxve\.codex\**
```

Do not modify or rerun consumed historical evidence.

## 6. Candidate data contract

Create a strict schema-v2 level with:

```text
schema_version = 2
level_id = phase_1_c02_crate_pressure_imprint
title = Pressure Imprint
one YOU
one ECHO, delay 2–4
one crate
one typed sensor
one grouped barrier
one traditional Plate
one traditional Door
one YOU-only EXIT
zero keys, locks, latches
```

Stable IDs:

```text
echo_imprint
crate_imprint
sensor_crate_imprint
barrier_echo_lane
plate_echo_exit
door_you_exit
```

Required sensor:

```json
{
  "id": "sensor_crate_imprint",
  "position": [X, Y],
  "activator": "YOU_ONLY",
  "include_crates": true
}
```

Required barrier:

```text
initial_open = false
all_sensor_ids = ["sensor_crate_imprint"]
one or two cells
```

Required Door:

```text
initial_open = false
all_plate_ids = ["plate_echo_exit"]
```

Envelope:

```text
footprint width 8–11
footprint height 6–8
1–3 consequential YOU pushes in every accepted shortest solution
recommended_search_depth <= 48
```

Metadata must name crate-specific sensor occupancy, next-turn barrier, delayed ECHO route, ECHO-held Plate/Door, and uncatalogued C02 status without embedding the solution.

## 7. Solver envelope

```text
target L* = 10–16
hard L* cap = 20
accepted exact N* = 1–64
all-shortest enumeration cap = 128
soft/hard visited states = 50,000 / 150,000
soft/hard elapsed = 15 / 60 seconds
maximum depth = 48
```

Timeout, cutoff, truncation, `L*>20`, states above 150,000, or elapsed above 60 seconds means redesign or `UNVERIFIED`. Do not widen limits.

## 8. Dedicated focused validation

Create:

```text
tests/levels/task_0024aw_c02_crate_pressure_imprint_validation.gd
```

Success marker:

```text
TASK_0024AW_C02_CRATE_PRESSURE_IMPRINT_PASS
```

Failure prefix:

```text
TASK_0024AW_C02_CRATE_PRESSURE_IMPRINT_FAIL
```

Use only the public loader, shared Simulation, and shared BFS.

### 8.1 Identity/schema

Prove exact IDs/cardinalities, sensor activator and `include_crates=true`, barrier/Plate/Door references, footprint, empty forbidden arrays, valid public load, YOU-only EXIT, and absence from production catalog.

### 8.2 Baseline solver/replay

Prove:

```text
SOLVED
L* in 10–16
N* exact in 1–64
no limit reached
shortest witness length = L*
witness replay completes with YOU on EXIT
two replays have identical states, canonical keys, and events
restart exactly restores every mutable field
changed crate position changes canonical key
```

Record exact actions, metrics, waits, blocked actions, pushes, visited states, frontier, elapsed, and configured limits.

### 8.3 Required event chain

Retain exact ordered events:

1. legal YOU push;
2. crate reaches sensor;
3. start snapshot counts crate occupancy;
4. barrier opens next turn;
5. delayed ECHO crosses barrier route;
6. ECHO alone occupies Plate;
7. Door opens next turn;
8. YOU crosses Door;
9. YOU reaches EXIT.

For each event retain turn/action index, before/after state, actor/crate positions, sensor/barrier/Plate/Door state, history action, and completion.

### 8.4 All-shortest proof

Instrument shortest-depth search using shared `Simulation.transition`.

Event mask:

```text
LEGAL_CRATE_PUSH
CRATE_ON_SENSOR
BARRIER_OPEN_FROM_CRATE
ECHO_CROSSES_BARRIER
ECHO_ALONE_ON_PLATE
DOOR_OPEN_FROM_ECHO
YOU_CROSSES_DOOR
YOU_REACHES_EXIT
```

At `L*`:

- completed path count equals exact solver `N*`;
- every shortest completion has the full mask;
- omissions = 0;
- no shortest solution substitutes YOU/ECHO for crate occupancy;
- every shortest solution uses 1–3 consequential pushes;
- enumeration is complete, not sampled/capped.

Do not implement a parallel transition system.

## 9. Required controls

Every variant must public-load before solver use. No limit-reached result may be called unsolved.

### A. No-push

Reject transitions changing crate position. YOU remains free to stand on the sensor. Require complete finite-state `UNSOLVED`; this proves YOU cannot substitute.

### B. Sensor excludes crate

Change only `include_crates=false`. Require complete `UNSOLVED`.

### C. No crate

Remove crate in a valid fixture. Require complete `UNSOLVED` if feasible; otherwise prove no full event-mask completion and material metric change.

### D. Displaced crate

Move initial crate outside intended lane. Require complete `UNSOLVED` or material metric change with zero full-mask completions.

### E. No ECHO

Remove ECHO with only the schema-required control metadata. Require complete `UNSOLVED` or prove the Door/EXIT dependency cannot complete.

### F. Barrier initially open

Create a schema-consistent initially-open control. It must materially shorten/bypass baseline and omit the crate event chain.

### G. Sensor broadened to `ANY_ACTOR`

It must create a shortcut or materially change shortest metrics/necessity. Record exact result.

## 10. Rule/shortcut/restart probes

Prove:

- no terrain bypass around barrier or Door;
- ECHO cannot push or enter crate;
- illegal YOU push moves neither YOU nor crate;
- barrier and Door entry changes occur next turn;
- crate stays on sensor during required ECHO crossing;
- YOU cannot complete by briefly standing on sensor;
- ECHO cannot activate the `YOU_ONLY` sensor;
- crate counts only because `include_crates=true`;
- ECHO cannot complete EXIT;
- no accepted witness uses a repeated identical blocked-YOU macro longer than one repeat;
- restart leaves no crate, sensor, barrier, Plate, Door, history, or completion residue.

## 11. Presentation boundary

Do not modify scenes/rendering.

Record only:

```text
presentation_status = MACHINE_CONTRACT_READY_OWNER_REVIEW_PENDING
```

Audit that crate, sensor eligibility, barrier, Plate, Door, ECHO, next-turn states, and failure states can map to existing schema-v2 minimum cues. Do not claim final visual acceptance.

## 12. Iteration policy

Before final retention, Codex may iterate only candidate JSON, dedicated test, and task helpers.

Each run:

- uses current accepted owned Godot wrapper;
- has unique qualification identity;
- stays within budgets;
- records candidate hash/result;
- runs cleanup exactly once;
- leaves no owned/unproven PID;
- ends with Godot count zero;
- preserves protected hashes.

Summarize discarded candidates honestly. Do not weaken tests.

## 13. PRE_FINAL and retained final cycle

After a stable candidate:

1. freeze candidate/test/helper hashes;
2. pass static/parser/schema/protected audits;
3. run focused qualification twice in fresh processes;
4. run current Aggregate and complete-v2 qualification;
5. record exact current Aggregate marker/assertion count and accepted stderr policy;
6. create a PRE_FINAL seal;
7. forbid further candidate/test/helper edits;
8. require Godot zero;
9. create one fresh Task 0024AW manifest UUID.

Final lifecycle follows accepted Task 0024AL architecture:

- Python standard-library parent;
- fresh `pwsh -NoProfile -NonInteractive -File` worker per case;
- accepted owned Godot wrapper;
- worker atomically writes/reopens complete case record before success;
- parent independently validates and journals;
- no shared PowerShell module lifetime.

Consume manifest atomically before case 1. Run exactly once:

```text
Case 1: focused C02
  marker TASK_0024AW_C02_CRATE_PRESSURE_IMPRINT_PASS
  stderr empty

Case 2: current tests/run_all.gd
  marker TASK_0003_TESTS_PASS assertions=<PRE_FINAL exact> vectors=9
  stderr exact current accepted Aggregate policy

Case 3: current complete-v2 test
  exact current accepted pass marker
  stderr empty
```

Every case requires exit 0, cleanup count 1, no owned/unproven PID, bounded records, exact hashes, and no protected drift.

After manifest consumption: no repair, rerun, replacement manifest, or reconstructed evidence. Any failure closes the task `BLOCKED`.

## 14. Required evidence

Create:

```text
docs/level_design/validation/phase_1_c02_crate_pressure_imprint_validation.json
docs/reports/0024AW_C02_CRATE_PRESSURE_IMPRINT_MACHINE_VALIDATION_REPORT.md
docs/handoffs/DELAYED_SELF_SESSION_HANDOFF_AFTER_TASK_0024AW_C02_MACHINE_VALIDATION_2026_07_26.md
```

The JSON/report must include exact solver facts, witness/event trace, all-shortest counts, all controls and completeness, replay/canonical/restart, presentation limitation, iteration history, PRE_FINAL, manifest/final cases, stderr/process/cleanup, hashes, changed files, and catalog/Profile/finale invariants.

## 15. Current-doc updates

Only after terminal result.

On success set:

```text
C02 candidate_status = MACHINE_VALIDATED_FOR_GPT_REVIEW
machine_validation_status = PASS_FOR_GPT_REVIEW
presentation_status = MACHINE_CONTRACT_READY_OWNER_REVIEW_PENDING
owner_review_status = NOT_REVIEWED
catalog_status = NOT_AUTHORIZED
```

Update only the authorized Phase-1/current docs. State that S01/0024AX remains closed until GPT accepts 0024AW.

## 16. Validation and commit

Before commit:

```powershell
git status --short --untracked-files=all
git diff --check
git diff --name-only
git diff --stat
```

Require:

```text
new level files = 1
new dedicated tests = 1 plus reviewed UID
schema/Simulation/solver/Aggregate changes = 0
existing level changes = 0
catalog/Profile/scenes/gameplay changes = 0
DeepSeek invoked = NO
production catalog = 8
formal finale = sequence 8
candidate admission = NOT_AUTHORIZED
Godot final count = 0
```

Fetch and require divergence `0/0`; explicitly stage authorized paths; inspect full staged diff; run `git diff --cached --check`.

Commit exactly once:

```text
feat: machine validate Phase-1 C02 pressure imprint
```

Push main; verify `HEAD == origin/main`; no tracked/staged changes; only `.codex/config.toml` untracked; Godot zero.

No amend/rebase/squash/force push. A post-push omission means `BLOCKED`; no second implementation commit.

## 17. Terminal verdicts

`PASS_FOR_GPT_REVIEW` requires every hard design, solver, control, lifecycle, evidence, commit, and push gate.

Use `UNVERIFIED` when proof cannot complete inside hard limits before final manifest creation.

Use `BLOCKED` for contract/protected drift, final-cycle failure, evidence failure, cleanup ambiguity, or post-push omission.

Codex may not use `FINAL_ACCEPTED`.

## 18. Required final fields

```text
candidate_slot = C02
level_id = phase_1_c02_crate_pressure_imprint
candidate_status = MACHINE_VALIDATED_FOR_GPT_REVIEW / BLOCKED / UNVERIFIED
solver_status = SOLVED / UNSOLVED / LIMIT_REACHED / NOT_RUN
shortest_solution_length = <exact or NOT_VERIFIED>
shortest_solution_count = <exact or NOT_VERIFIED>
all_shortest_full_event_mask = <exact>/<exact> / NOT_VERIFIED
all_shortest_omissions = <exact or NOT_VERIFIED>
no_push_control = COMPLETE_UNSOLVED / OTHER / NOT_VERIFIED
sensor_excludes_crate_control = COMPLETE_UNSOLVED / OTHER / NOT_VERIFIED
no_crate_control = COMPLETE_UNSOLVED / OTHER / NOT_VERIFIED
displaced_crate_control = <exact or NOT_VERIFIED>
no_echo_control = COMPLETE_UNSOLVED / OTHER / NOT_VERIFIED
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

## 19. Next gate

Only GPT acceptance may open 0024AX for S01. C02 remains uncatalogued, unsequenced, and owner-unreviewed. Integrated comparison remains 0024BC and owner Phase-1 review remains 0024BD.
