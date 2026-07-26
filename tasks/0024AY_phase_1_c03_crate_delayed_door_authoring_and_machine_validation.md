# Task 0024AY — Phase-1 C03 crate-delayed-door authoring and machine validation

- Status: `READY`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Required accepted checkpoint: `d17dcb756b982808c119428ae02f1c42dd41f78a`
- Previous accepted gate: `TASK_0024AX_S01_EXPLICIT_ROLE_SEPARATION_MACHINE_VALIDATION_ACCEPTED`
- Candidate: `C03`
- Production catalog: sequences 1–8 only
- Formal finale: sequence 8 only
- Candidate admission: `NOT_AUTHORIZED`
- DeepSeek code routing: `DISABLED`

## 1. Objective

Create one uncatalogued schema-v2 candidate:

```text
level_id = phase_1_c03_crate_delayed_door
working_title_en = Held Window
working_title_zh = 迟门留印
production_sequence = UNASSIGNED
owner_review_status = NOT_REVIEWED
```

Required chain:

```text
YOU pushes crate into ECHO lane
→ replayed ECHO is blocked by crate and changes phase
→ ECHO later enters Plate
→ on that same turn YOU attempts the still-closed Door and is blocked
→ Door opens after movement
→ on the next turn YOU crosses the already-open Door
→ YOU reaches EXIT
```

C03 is distinct from C02:

```text
C02 = crate as sustained destination occupancy
C03 = crate as temporal phase commitment creating a next-turn Door window
```

This task authorizes C03 only. S03/0024AZ remains closed.

## 2. Required reads

```text
AGENTS.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
tasks/0024AY_phase_1_c03_crate_delayed_door_authoring_and_machine_validation.md
docs/reports/0024AX_GPT_S01_EXPLICIT_ROLE_SEPARATION_ACCEPTANCE.md
docs/reports/0024AW_GPT_C02_CRATE_PRESSURE_IMPRINT_ACCEPTANCE.md
docs/level_design/phase_1/C03_CRATE_DELAYED_DOOR_BRIEF.md
docs/level_design/phase_1/PHASE_1_SIX_CANDIDATE_BRIEFS_CURRENT.md
docs/level_design/phase_1/PHASE_1_SIX_CANDIDATE_VALIDATION_PLAN_CURRENT.md
docs/game_design/GAMEPLAY_SIMULATION_CONTRACT_V2_CURRENT.md
docs/level_design/LEVEL_SCHEMA_V2_CURRENT.md
schemas/level_v2.schema.json
scripts/simulation/level_loader.gd
scripts/simulation/simulation.gd
scripts/solver/bfs_solver.gd
data/levels/crate_shadow_timing.json
data/levels/phase_1_c02_crate_pressure_imprint.json
data/levels/phase_1_s01_explicit_role_separation.json
tests/levels/task_0024y_crate_shadow_timing_validation.gd
tests/levels/task_0024aw_c02_crate_pressure_imprint_validation.gd
tests/levels/task_0024ax_s01_explicit_role_separation_validation.gd
docs/reports/0024Y_SEQUENCE_9_CRATE_SHADOW_TIMING_MACHINE_VALIDATION_REPORT.md
docs/reports/0024AW_C02_CRATE_PRESSURE_IMPRINT_MACHINE_VALIDATION_REPORT.md
docs/reports/0024AX_S01_EXPLICIT_ROLE_SEPARATION_MACHINE_VALIDATION_REPORT.md
tests/tools/run_owned_godot_headless.ps1
tests/run_all.gd
tests/simulation/task_0024v_v2_solver_replay_canonical_malformed.gd
```

Profile data is forbidden.

## 3. Startup gate

Before writing or launching Godot:

1. require root `D:\Delayed_Self`, branch `main`, expected origin;
2. fetch/fast-forward only;
3. require `HEAD == origin/main`, divergence `0/0`;
4. require Task 0024AY/current pointers from origin;
5. require checkpoint `d17dcb756b982808c119428ae02f1c42dd41f78a` in ancestry;
6. require no tracked/staged changes;
7. allow only accepted untracked `.codex/config.toml` with accepted hash;
8. require Godot `4.7.1.stable.steam.a13da4feb`;
9. require zero pre-existing Godot processes;
10. require no 0024AY artifacts;
11. hash/freeze loader, Simulation, BFS, schema, wrapper, Aggregate, complete-v2, catalog, every existing level, briefs and accepted retained evidence;
12. confirm consumed 0024AW/0024AX manifests remain immutable and are not invoked;
13. stop on remote/worktree/process/foundation drift or Profile need.

## 4. Authorized paths

```text
data/levels/phase_1_c03_crate_delayed_door.json
tests/levels/task_0024ay_c03_crate_delayed_door_validation.gd
tests/levels/task_0024ay_c03_crate_delayed_door_validation.gd.uid
tests/tools/task_0024ay_*.ps1
tests/tools/task_0024ay_*.py
tests/tools/task_0024ay_*.json
docs/level_design/validation/phase_1_c03_crate_delayed_door_validation.json
docs/reports/0024AY_C03_CRATE_DELAYED_DOOR_MACHINE_VALIDATION_REPORT.md
docs/handoffs/DELAYED_SELF_SESSION_HANDOFF_AFTER_TASK_0024AY_C03_MACHINE_VALIDATION_2026_07_26.md
docs/level_design/phase_1/C03_CRATE_DELAYED_DOOR_BRIEF.md
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

No other path may change. The UID exception applies only to the new focused test.

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

The new C03 level is the sole exception under `data/levels/`.

## 6. Candidate contract

Create strict schema-v2 JSON:

```text
schema_version = 2
level_id = phase_1_c03_crate_delayed_door
title = Held Window
one YOU
one ECHO
one crate
one Plate
one Door
one YOU-only EXIT
zero sensors, barriers, keys, locks and latches
```

Stable IDs:

```text
echo_window
crate_window
plate_window
door_window
```

Door:

```text
initial_open = false
all_plate_ids = ["plate_window"]
```

Envelope:

```text
ECHO delay = 2–4
footprint = 8–11 wide, 6–8 high
every accepted shortest path uses 1–3 consequential YOU pushes
every accepted shortest path uses 1–2 ECHO-blocked-by-crate events
recommended_search_depth <= 56
```

The crate resting cell must be in ECHO's route, not a generic exit obstruction.

Metadata must name crate phase commitment, ECHO blocked by crate, ECHO-held Plate, same-turn blocked Door attempt, next-turn crossing, and uncatalogued C03 status without embedding the solution.

## 7. Solver envelope

```text
target L* = 12–20
hard L* cap = 24
exact N* = 1–64
all-shortest cap = 128
soft/hard states = 100,000 / 250,000
soft/hard elapsed = 30 / 90 seconds
maximum depth = 56
```

Timeout, cutoff, truncation, `L*>24`, states above 250,000 or elapsed above 90 seconds means redesign or `UNVERIFIED`. Do not widen limits.

## 8. Focused validation

Create:

```text
tests/levels/task_0024ay_c03_crate_delayed_door_validation.gd
```

Success:

```text
TASK_0024AY_C03_CRATE_DELAYED_DOOR_PASS
```

Failure prefix:

```text
TASK_0024AY_C03_CRATE_DELAYED_DOOR_FAIL
```

Use only public loader, shared Simulation and BFS.

### Identity/schema

Prove exact identity, cardinalities, Plate/Door dependency, valid footprint, ECHO delay, empty forbidden arrays, YOU-only EXIT, public load and absence from catalog.

### Baseline solver/replay

Prove:

```text
SOLVED
L* in 12–20
N* exact in 1–64
no limit reached
shortest witness length = L*
two replays have identical states, keys and events
restart exactly restores all mutable state
moving only crate changes canonical key
YOU reaches EXIT; ECHO never completes
```

Record actions, waits, blocked YOU actions, pushes, ECHO crate blocks, states, frontier, elapsed and limits.

### Required event chain

Retain in order:

1. legal YOU crate push;
2. later ECHO attempts crate cell and is blocked;
3. block changes useful ECHO phase;
4. ECHO enters Plate;
5. on that same transition YOU attempts the closed Door and is blocked;
6. Door end state becomes open;
7. next turn YOU crosses already-open Door;
8. YOU reaches EXIT.

Retain turn/action index, before/after state, actor/crate positions, history action, Plate occupancy, Door start/end state, blocked result and completion.

The same-turn blocked Door attempt is mandatory.

### All-shortest proof

Event mask:

```text
LEGAL_CRATE_PUSH
ECHO_BLOCKED_BY_CRATE
ECHO_PHASE_CHANGED
ECHO_ENTERS_PLATE
YOU_SAME_TURN_DOOR_ATTEMPT_BLOCKED
DOOR_OPENS_AFTER_PLATE
YOU_NEXT_TURN_CROSSES_DOOR
YOU_REACHES_EXIT
```

At `L*` require:

- exact path count equals solver N*;
- every shortest path has full mask;
- omissions = 0;
- every shortest path uses 1–3 pushes;
- every shortest path uses 1–2 ECHO crate blocks;
- no shortest path crosses Door on Plate-entry turn;
- enumeration complete, not sampled/capped.

Use shared transition only.

## 9. Controls

Every control must public-load. No limit result may be called unsolved.

- **No-push:** reject crate-moving transitions; require complete-unsolved.
- **No crate:** remove crate; require complete-unsolved or zero full-mask with material metric change.
- **Displaced crate:** move initial crate outside intended lane; require complete-unsolved or material change with zero mask.
- **Pre-positioned crate:** begin on resting cell; must omit YOU commitment and materially alter structure.
- **Static wall:** replace resting cell with wall; must not reproduce metrics and temporal chain.
- **No ECHO:** require complete-unsolved.
- **Plate/Door dependency removed:** must create shorter/bypass structure with baseline mask absent.
- **Timing bypass:** smallest valid geometry mutation that removes same-turn-blocked/next-turn lesson; require material change.
- **Immediate-update sensitivity:** do not implement alternate Simulation; prove from baseline trace that Door start state is closed on Plate-entry transition, YOU is blocked, Door end state is open, and next transition starts open and crosses.

## 10. Rule/shortcut/restart probes

Prove:

- no terrain Door bypass;
- ECHO cannot push/enter crate;
- illegal YOU push moves neither;
- Door entry uses start-snapshot state;
- Plate changes Door only after movement;
- crate remains in intended ECHO lane during block;
- no useful ECHO phase without crate commitment;
- YOU cannot finish without ECHO-held Door;
- ECHO cannot finish EXIT;
- no repeated identical blocked-YOU macro longer than one repeat;
- restart leaves no crate, Plate, Door, history or completion residue.

## 11. Presentation boundary

Do not modify scenes/rendering.

Set:

```text
presentation_status = MACHINE_CONTRACT_READY_OWNER_REVIEW_PENDING
```

Audit that current minimum cues can represent crate commitment, ECHO blocked attempt, Plate/Door link, closed-this-turn/open-next-turn state, intentional blocked Door attempt, timeline, and color-independent redundancy.

## 12. Iteration policy

Before PRE_FINAL, iterate only new candidate, focused test and task helpers.

Every run uses the accepted wrapper, unique identity, bounded budgets, cleanup once, no owned/unproven PID, final Godot zero and protected-hash preservation.

Record discarded layouts honestly. Do not weaken tests.

Return `BLOCKED` or `UNVERIFIED` if hard budgets, full-mask proof, controls, mandatory Door timing, replay/restart/canonical or protected boundaries cannot pass.

## 13. PRE_FINAL and retained cycle

After stable qualification:

1. freeze candidate/test/helper hashes;
2. pass static/parser/schema/protected audits;
3. run focused twice in fresh processes;
4. run current Aggregate and complete-v2;
5. record exact markers/assertions/stderr;
6. create PRE_FINAL seal;
7. prohibit further candidate/test/helper edits;
8. require Godot zero;
9. create one fresh 0024AY manifest UUID.

Use accepted 0024AL architecture:

- Python stdlib parent;
- fresh `pwsh -NoProfile -NonInteractive -File` worker per case;
- accepted Godot wrapper;
- atomic record write/reopen;
- parent validation/journal;
- no shared PowerShell lifetime.

Consume manifest before case 1. Run once:

```text
Case 1 focused C03:
  TASK_0024AY_C03_CRATE_DELAYED_DOOR_PASS
  stderr empty

Case 2 current Aggregate:
  TASK_0003_TESTS_PASS assertions=<PRE_FINAL exact> vectors=9
  stderr exact accepted policy

Case 3 current complete-v2:
  exact accepted marker
  stderr empty
```

Each case: exit 0, cleanup once, no PID residue, bounded records, exact hashes, no drift.

After consumption: no repair, rerun, replacement or reconstruction. Any failure closes `BLOCKED`.

## 14. Evidence and current docs

Create:

```text
docs/level_design/validation/phase_1_c03_crate_delayed_door_validation.json
docs/reports/0024AY_C03_CRATE_DELAYED_DOOR_MACHINE_VALIDATION_REPORT.md
docs/handoffs/DELAYED_SELF_SESSION_HANDOFF_AFTER_TASK_0024AY_C03_MACHINE_VALIDATION_2026_07_26.md
```

On success set C03:

```text
candidate_status = MACHINE_VALIDATED_FOR_GPT_REVIEW
machine_validation_status = PASS_FOR_GPT_REVIEW
presentation_status = MACHINE_CONTRACT_READY_OWNER_REVIEW_PENDING
owner_review_status = NOT_REVIEWED
catalog_status = NOT_AUTHORIZED
```

S03/0024AZ remains closed until GPT acceptance.

## 15. Validation and commit

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

Fetch, require divergence `0/0`, explicitly stage authorized paths, inspect full diff, run `git diff --cached --check`.

Commit exactly once:

```text
feat: machine validate Phase-1 C03 delayed door
```

Push main; verify synchronized remote, clean tracked/staged state, only `.codex/config.toml` untracked, Godot zero.

No amend/rebase/squash/force push. A post-push omission means `BLOCKED`; no second commit.

## 16. Verdicts and final fields

Use `PASS_FOR_GPT_REVIEW`, `BLOCKED`, or `UNVERIFIED`. Never `FINAL_ACCEPTED`.

```text
candidate_slot = C03
level_id = phase_1_c03_crate_delayed_door
candidate_status = MACHINE_VALIDATED_FOR_GPT_REVIEW / BLOCKED / UNVERIFIED
solver_status = SOLVED / UNSOLVED / LIMIT_REACHED / NOT_RUN
shortest_solution_length = <exact or NOT_VERIFIED>
shortest_solution_count = <exact or NOT_VERIFIED>
all_shortest_full_event_mask = <exact>/<exact> / NOT_VERIFIED
all_shortest_omissions = <exact or NOT_VERIFIED>
consequential_push_range = <exact or NOT_VERIFIED>
echo_crate_block_range = <exact or NOT_VERIFIED>
same_turn_door_attempt_blocked = YES / NO / NOT_VERIFIED
next_turn_door_crossing = YES / NO / NOT_VERIFIED
no_push_control = COMPLETE_UNSOLVED / OTHER / NOT_VERIFIED
no_crate_control = COMPLETE_UNSOLVED / OTHER / NOT_VERIFIED
displaced_crate_control = <exact or NOT_VERIFIED>
prepositioned_crate_control = <exact or NOT_VERIFIED>
static_wall_control = <exact or NOT_VERIFIED>
no_echo_control = COMPLETE_UNSOLVED / OTHER / NOT_VERIFIED
timing_bypass_control = <exact or NOT_VERIFIED>
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

## 17. Next gate

Only explicit GPT acceptance may open 0024AZ for S03. C03 remains uncatalogued, unsequenced and owner-unreviewed. Integrated comparison remains 0024BC; owner review remains 0024BD.
