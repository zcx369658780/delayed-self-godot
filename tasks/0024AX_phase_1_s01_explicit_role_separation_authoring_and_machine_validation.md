# Task 0024AX — Author and machine-validate Phase-1 S01 explicit-role-separation candidate

- Status: `READY`
- Gate: `S01 SINGLE CANDIDATE / TYPED ROLE NECESSITY / INDEPENDENT RETAINED VALIDATION`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Required accepted checkpoint in ancestry: `84ad24657f10a2a4d2290aaef0807fe24ebbdfbc`
- Previous accepted gate: `TASK_0024AW_C02_CRATE_PRESSURE_IMPRINT_MACHINE_VALIDATION_ACCEPTED`
- Candidate slot: `S01`
- Production catalog: sequences 1–8 only
- Formal finale: sequence 8 only
- Candidate admission: `NOT_AUTHORIZED`
- Profile/catalog/finale migration: not authorized
- DeepSeek project-code routing: `DISABLED`

## 1. Objective

Create one uncatalogued schema-v2 candidate:

```text
level_id = phase_1_s01_explicit_role_separation
working_title_en = Separate Roles
working_title_zh = 分工初见
candidate_status = UNCATALOGUED_PHASE_1_MACHINE_VALIDATION
production_sequence = UNASSIGNED
```

Required chain:

```text
YOU follows a body-specific route
→ delayed ECHO follows a structurally different route
→ YOU occupies YOU_ONLY sensor
→ ECHO occupies ECHO_ONLY sensor on the same start snapshot
→ grouped barrier opens next turn
→ YOU crosses the barrier and reaches EXIT
```

The two routes and responsibilities must be non-substitutable. This task authorizes S01 only. C03/0024AY and every later candidate remain closed.

## 2. Required reads

```text
AGENTS.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
tasks/0024AX_phase_1_s01_explicit_role_separation_authoring_and_machine_validation.md
docs/reports/0024AW_GPT_C02_CRATE_PRESSURE_IMPRINT_ACCEPTANCE.md
docs/level_design/phase_1/PHASE_1_SIX_CANDIDATE_BRIEFS_CURRENT.md
docs/level_design/phase_1/PHASE_1_SIX_CANDIDATE_VALIDATION_PLAN_CURRENT.md
docs/level_design/phase_1/S01_EXPLICIT_ROLE_SEPARATION_BRIEF.md
docs/game_design/GAMEPLAY_SIMULATION_CONTRACT_V2_CURRENT.md
docs/level_design/LEVEL_SCHEMA_V2_CURRENT.md
schemas/level_v2.schema.json
scripts/simulation/level_loader.gd
scripts/simulation/simulation.gd
scripts/solver/bfs_solver.gd
data/levels/identity_shift_bridge.json
data/levels/phase_1_c02_crate_pressure_imprint.json
tests/levels/task_0024aw_c02_crate_pressure_imprint_validation.gd
docs/level_design/validation/phase_1_c02_crate_pressure_imprint_validation.json
docs/reports/0024AW_C02_CRATE_PRESSURE_IMPRINT_MACHINE_VALIDATION_REPORT.md
docs/reports/0024AL_GPT_PROCESS_ISOLATED_WRITE_AHEAD_SCHEMA_V2_PRESENTATION_ACCEPTANCE.md
tests/tools/run_owned_godot_headless.ps1
tests/run_all.gd
tests/simulation/task_0024v_v2_solver_replay_canonical_malformed.gd
```

Production/test Profile data is forbidden.

## 3. Startup gate

Before writing or launching Godot:

1. require root `D:\Delayed_Self`, branch `main`, expected origin;
2. fetch/fast-forward only and require `HEAD == origin/main`, divergence `0/0`;
3. require Task 0024AX/current pointers from origin and checkpoint `84ad24657f10a2a4d2290aaef0807fe24ebbdfbc` in ancestry;
4. require no tracked/staged changes and only accepted untracked `.codex/config.toml` with accepted hash;
5. require Godot `4.7.1.stable.steam.a13da4feb` and zero pre-existing Godot processes;
6. require no pre-existing 0024AX artifacts;
7. hash/freeze loader, Simulation, BFS, schema-v2, wrapper, Aggregate, complete-v2, catalog, all existing levels, briefs and accepted retained evidence;
8. confirm consumed 0024AW manifest is not invoked;
9. stop on remote/worktree/process/foundation/historical drift or Profile-access need.

## 4. Authorized paths

```text
data/levels/phase_1_s01_explicit_role_separation.json
tests/levels/task_0024ax_s01_explicit_role_separation_validation.gd
tests/levels/task_0024ax_s01_explicit_role_separation_validation.gd.uid
tests/tools/task_0024ax_*.ps1
tests/tools/task_0024ax_*.py
tests/tools/task_0024ax_*.json
docs/level_design/validation/phase_1_s01_explicit_role_separation_validation.json
docs/reports/0024AX_S01_EXPLICIT_ROLE_SEPARATION_MACHINE_VALIDATION_REPORT.md
docs/handoffs/DELAYED_SELF_SESSION_HANDOFF_AFTER_TASK_0024AX_S01_MACHINE_VALIDATION_2026_07_26.md
docs/level_design/phase_1/S01_EXPLICIT_ROLE_SEPARATION_BRIEF.md
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

No other path may change. The UID exception applies only to the new test.

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

The new S01 candidate is the sole new `data/levels/` exception. Never rerun consumed historical manifests.

## 6. Candidate data contract

Create strict schema-v2 JSON:

```text
schema_version = 2
level_id = phase_1_s01_explicit_role_separation
title = Separate Roles
one YOU
one ECHO, delay 2–4
two typed sensors
one grouped barrier
one YOU-only EXIT
zero crates, keys, locks, Plates, Doors and latches
```

Stable IDs:

```text
echo_roles
sensor_you_role
sensor_echo_role
barrier_role_exit
```

Sensors:

```json
{"id":"sensor_you_role","position":[X,Y],"activator":"YOU_ONLY","include_crates":false}
{"id":"sensor_echo_role","position":[X,Y],"activator":"ECHO_ONLY","include_crates":false}
```

Barrier:

```text
initial_open = false
all_sensor_ids = ["sensor_you_role", "sensor_echo_role"]
one or two cells
```

Envelope:

```text
footprint width 8–11
footprint height 6–8
recommended_search_depth <= 48
```

Geometry must make YOU and ECHO routes structurally different through spawn, walls and timing. It must be an introduction, not latch/key/crate synthesis.

## 7. Solver envelope

```text
target L* = 10–16
hard L* cap = 20
accepted exact N* = 1–64
all-shortest enumeration cap = 128
soft/hard states = 50,000 / 150,000
soft/hard elapsed = 15 / 60 seconds
maximum depth = 48
```

Timeout, cutoff, truncation, `L*>20`, states above 150,000 or elapsed above 60 seconds means redesign or `UNVERIFIED`. Do not widen limits.

## 8. Focused validation

Create:

```text
tests/levels/task_0024ax_s01_explicit_role_separation_validation.gd
```

Success marker:

```text
TASK_0024AX_S01_EXPLICIT_ROLE_SEPARATION_PASS
```

Failure prefix:

```text
TASK_0024AX_S01_EXPLICIT_ROLE_SEPARATION_FAIL
```

Use only public loader, shared Simulation and shared BFS.

### 8.1 Identity/schema

Prove exact identity/cardinality, typed sensor eligibility, `include_crates=false`, barrier references, valid footprint, ECHO delay, empty forbidden arrays, YOU-only EXIT, public load success and absence from production catalog.

### 8.2 Baseline solver/replay

Prove:

```text
SOLVED
L* in 10–16
N* exact in 1–64
no limit reached
shortest witness length = L*
witness replay completes with YOU on EXIT
two replays have identical states, canonical keys and events
restart exactly restores all mutable state
```

Record exact actions, metrics, waits, blocked actions, states, frontier, elapsed and limits.

### 8.3 Required event chain

Retain exact ordered events:

1. YOU occupies `sensor_you_role`;
2. delayed ECHO occupies `sensor_echo_role`;
3. both correct typed occupancies coexist on one start snapshot;
4. `barrier_role_exit` opens next turn;
5. YOU crosses the open barrier;
6. YOU reaches EXIT;
7. ECHO never completes the room.

Retain turn/action index, before/after state, actor positions, sensor occupancy, barrier state, history action and completion.

### 8.4 All-shortest proof

Instrument shared `Simulation.transition` with:

```text
YOU_ON_YOU_SENSOR
ECHO_ON_ECHO_SENSOR
SIMULTANEOUS_TYPED_OCCUPANCY
BARRIER_OPEN_FROM_TYPED_PAIR
YOU_CROSSES_BARRIER
YOU_REACHES_EXIT
```

At `L*` require exact completed count equal to solver `N*`, every shortest completion full-mask, omissions zero, both roles present, no wrong-actor activation and complete enumeration.

Do not implement a parallel simulation.

## 9. Required controls

Every control must public-load. No cutoff may be called unsolved.

### A. No ECHO

Remove ECHO with required control metadata. Require complete finite-state `UNSOLVED`.

### B. Remove YOU-role dependency

Barrier depends only on `sensor_echo_role`. Require solved shortcut/material metric change omitting the YOU-role event.

### C. Remove ECHO-role dependency

Barrier depends only on `sensor_you_role`. Require solved shortcut/material metric change omitting the ECHO-role event.

### D. `ANY_ACTOR` broadening

Change each sensor independently, then both, to `ANY_ACTOR`. At least one must admit role substitution, no-correct-role completion, or material metric change.

### E. Swapped eligibility

Swap activators while preserving positions. Require complete `UNSOLVED` or material metric/event change with zero baseline full-mask completions.

### F. Symmetric-path control

Create one documented valid terrain/spawn variant removing intended route asymmetry. It must simplify the route, create substitution/ambiguity, or materially alter metrics/event necessity.

### G. Remove one route

Create body-route-removed and ECHO-route-removed variants. Each must be complete `UNSOLVED` or prove the corresponding role cannot complete.

### H. Barrier initially open

Create schema-consistent initially-open control. It must bypass typed-pair necessity and omit the baseline full mask.

## 10. Rule/shortcut/restart probes

Prove YOU cannot activate ECHO_ONLY sensor; ECHO cannot activate YOU_ONLY sensor; exact typed occupancy drives the barrier; barrier affects entry next turn; no terrain bypass avoids barrier; one role cannot substitute for both; baseline routes are not mirror copies; ECHO cannot complete EXIT; no repeated identical blocked-YOU macro longer than one repeat appears; restart leaves no actor/sensor/barrier/history/completion residue.

## 11. Presentation boundary

Do not modify scenes/rendering. Record:

```text
presentation_status = MACHINE_CONTRACT_READY_OWNER_REVIEW_PENDING
```

Static audit only: existing minimum cues can express YOU/ECHO badges, typed sensor glyph/text, barrier dependency, next-turn opening, wrong-actor failure and color-independent redundancy. Do not claim owner/final visual acceptance.

## 12. Iteration policy

Before PRE_FINAL, iterate only candidate JSON, dedicated test and task helpers. Every run uses the accepted owned wrapper, unique identity, bounded budgets, one cleanup, no owned/unproven PID, Godot zero and protected hashes. Record discarded layouts honestly. Do not weaken tests.

If hard solver, all-shortest role proof, no-ECHO, role-dependency, eligibility, route, replay/restart or lifecycle gates cannot pass, return `BLOCKED` or `UNVERIFIED`.

## 13. PRE_FINAL and retained lifecycle

After stable qualification:

1. freeze candidate/test/helper hashes;
2. pass parser/schema/protected audits;
3. run focused qualification twice in fresh processes;
4. run current Aggregate and complete-v2;
5. record exact markers, assertion count and stderr policy;
6. create PRE_FINAL seal and prohibit further edits;
7. require Godot zero;
8. create one fresh Task 0024AX manifest UUID.

Final architecture follows Task 0024AL: Python stdlib parent; fresh `pwsh -NoProfile -NonInteractive -File` worker per case; accepted wrapper; atomic case record write/reopen; parent independent validation/journal; no shared PowerShell module lifetime.

Consume manifest before case 1. Run exactly once:

```text
Case 1: focused S01
  TASK_0024AX_S01_EXPLICIT_ROLE_SEPARATION_PASS
  stderr empty

Case 2: current Aggregate
  TASK_0003_TESTS_PASS assertions=<PRE_FINAL exact> vectors=9
  stderr exact current accepted policy

Case 3: current complete-v2
  exact current accepted pass marker
  stderr empty
```

Every case requires exit 0, cleanup once, no PID residue, bounded records, exact hashes and no protected drift. After consumption: no repair, rerun, replacement or reconstruction. Any failure closes `BLOCKED`.

## 14. Evidence

Create:

```text
docs/level_design/validation/phase_1_s01_explicit_role_separation_validation.json
docs/reports/0024AX_S01_EXPLICIT_ROLE_SEPARATION_MACHINE_VALIDATION_REPORT.md
docs/handoffs/DELAYED_SELF_SESSION_HANDOFF_AFTER_TASK_0024AX_S01_MACHINE_VALIDATION_2026_07_26.md
```

Include solver facts, event trace, all-shortest proof, controls/completeness, replay/restart/canonical, presentation limitation, iteration history, PRE_FINAL, final cases, stderr/process/cleanup, hashes, changed paths and protected invariants.

## 15. Current documents

Only after terminal result. On success set:

```text
S01 candidate_status = MACHINE_VALIDATED_FOR_GPT_REVIEW
machine_validation_status = PASS_FOR_GPT_REVIEW
presentation_status = MACHINE_CONTRACT_READY_OWNER_REVIEW_PENDING
owner_review_status = NOT_REVIEWED
catalog_status = NOT_AUTHORIZED
```

C03/0024AY remains closed until GPT accepts 0024AX.

## 16. Validation and commit

Before commit run Git status/diff checks and require:

```text
new level files = 1
new focused tests = 1 plus reviewed UID
schema/Simulation/solver/Aggregate changes = 0
existing level changes = 0
catalog/Profile/scenes/gameplay changes = 0
DeepSeek invoked = NO
production catalog = 8
formal finale = sequence 8
candidate admission = NOT_AUTHORIZED
Godot final count = 0
```

Fetch and require divergence `0/0`; explicitly stage authorized files; inspect staged diff; run `git diff --cached --check`.

Commit exactly once:

```text
feat: machine validate Phase-1 S01 role separation
```

Push main; verify synchronized remote, clean tracked/staged state, only `.codex/config.toml` untracked and Godot zero. No amend/rebase/squash/force push. Post-push omission means `BLOCKED`; no second implementation commit.

## 17. Terminal verdicts

`PASS_FOR_GPT_REVIEW` requires every design, solver, control, lifecycle, evidence, commit and push gate.

Use `UNVERIFIED` if proof cannot complete inside hard limits before manifest creation.

Use `BLOCKED` for drift, final-cycle failure, protected risk, evidence failure, cleanup ambiguity or post-push omission.

Codex may not use `FINAL_ACCEPTED`.

## 18. Required final fields

```text
candidate_slot = S01
level_id = phase_1_s01_explicit_role_separation
candidate_status = MACHINE_VALIDATED_FOR_GPT_REVIEW / BLOCKED / UNVERIFIED
solver_status = SOLVED / UNSOLVED / LIMIT_REACHED / NOT_RUN
shortest_solution_length = <exact or NOT_VERIFIED>
shortest_solution_count = <exact or NOT_VERIFIED>
all_shortest_full_event_mask = <exact>/<exact> / NOT_VERIFIED
all_shortest_omissions = <exact or NOT_VERIFIED>
no_echo_control = COMPLETE_UNSOLVED / OTHER / NOT_VERIFIED
you_role_dependency_control = <exact or NOT_VERIFIED>
echo_role_dependency_control = <exact or NOT_VERIFIED>
any_actor_controls = <exact or NOT_VERIFIED>
swapped_eligibility_control = <exact or NOT_VERIFIED>
symmetric_path_control = <exact or NOT_VERIFIED>
body_route_removed = COMPLETE_UNSOLVED / OTHER / NOT_VERIFIED
echo_route_removed = COMPLETE_UNSOLVED / OTHER / NOT_VERIFIED
replay_deterministic = YES / NO / NOT_VERIFIED
restart_exact = YES / NO / NOT_VERIFIED
presentation_status = MACHINE_CONTRACT_READY_OWNER_REVIEW_PENDING
production_catalog_modified = NO / YES
formal_finale_modified = NO / YES
Profile_accessed = NO / YES
next_task_authorized = NO
final_task_verdict = PASS_FOR_GPT_REVIEW / BLOCKED / UNVERIFIED
```

## 19. Next gate

Only explicit GPT acceptance may open 0024AY for C03. S01 remains uncatalogued, unsequenced and owner-unreviewed. Integrated comparison remains 0024BC; owner Phase-1 review remains 0024BD.
