# Task 0024AZ — Author and machine-validate Phase-1 S03 ECHO-only-sensor candidate

- Status: `READY`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Required accepted checkpoint: `de9fe41c168ff8db0684456b84c746ed7880308e`
- Previous acceptance: `TASK_0024AYR_C03_NEXT_TURN_DOOR_RETRY_ACCEPTED`
- Candidate: `S03`
- Production catalog: sequences 1–8 only
- Formal finale: sequence 8 only
- Candidate admission: `NOT_AUTHORIZED`
- DeepSeek routing: `DISABLED`

## Objective

Create one uncatalogued schema-v2 candidate:

```text
level_id = phase_1_s03_echo_only_sensor
working_title_en = Echo Signal
working_title_zh = 回声感应
production_sequence = UNASSIGNED
owner_review_status = NOT_REVIEWED
```

Required chain:

```text
YOU commits to the body route
→ delayed ECHO follows a separate route
→ ECHO enters ECHO_ONLY sensor
→ grouped barrier opens after transition resolution
→ on a later transition YOU crosses the already-open barrier
→ YOU reaches EXIT
```

This differs from S01: S01 uses a simultaneous YOU_ONLY + ECHO_ONLY pair; S03 uses one ECHO_ONLY trigger plus an independent YOU traversal responsibility.

This task authorizes S03 only. C07/0024BA and every later candidate remain closed.

## Required reads

Read `AGENTS.md`, current startup/active docs, this task, the 0024AYR and 0024AX GPT acceptances, the S03 brief and Phase-1 overview/validation plan, schema-v2 and Simulation-v2 contracts, loader/Simulation/BFS, accepted S01/C03 candidates and validations, current Aggregate, complete-v2 and owned Godot wrapper.

Do not inspect Profile data.

## Startup gate

Before writing or launching Godot:

1. require root `D:\Delayed_Self`, branch `main`, expected origin;
2. fetch/fast-forward only and require `HEAD == origin/main`, divergence `0/0`;
3. require this task/current pointers from origin and checkpoint `de9fe41...` in ancestry;
4. require no tracked/staged changes and only accepted untracked `.codex/config.toml` with exact hash;
5. require Godot `4.7.1.stable.steam.a13da4feb` and zero pre-existing Godot processes;
6. require no 0024AZ artifacts;
7. freeze hashes for loader, Simulation, BFS, schema, wrapper, Aggregate, complete-v2, catalog, all existing levels/briefs/evidence;
8. never invoke consumed 0024AW/AX/AYR manifests;
9. stop on drift, process ambiguity or Profile need.

## Authorized paths

```text
data/levels/phase_1_s03_echo_only_sensor.json
tests/levels/task_0024az_s03_echo_only_sensor_validation.gd
tests/levels/task_0024az_s03_echo_only_sensor_validation.gd.uid
tests/tools/task_0024az_*.ps1
tests/tools/task_0024az_*.py
tests/tools/task_0024az_*.json
docs/level_design/validation/phase_1_s03_echo_only_sensor_validation.json
docs/reports/0024AZ_S03_ECHO_ONLY_SENSOR_MACHINE_VALIDATION_REPORT.md
docs/handoffs/DELAYED_SELF_SESSION_HANDOFF_AFTER_TASK_0024AZ_S03_MACHINE_VALIDATION_2026_07_26.md
docs/level_design/phase_1/S03_ECHO_ONLY_SENSOR_BRIEF.md
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

## Protected surfaces

Do not modify catalog, any pre-existing level/test, scripts, scenes, project.godot, schemas, Aggregate, simulation tests, owned wrapper, Profile, presentation, localization, assets/audio, build/export/release/submission or user-scope Codex files.

## Candidate contract

Strict schema-v2:

```text
one YOU
one ECHO, delay 2–4
one ECHO_ONLY sensor with include_crates=false
one initially closed grouped barrier dependent only on that sensor
one YOU-only EXIT
zero crates, keys, locks, Plates, Doors and latches
footprint 8–11 by 6–8
recommended depth <= 56
```

Stable IDs:

```text
echo_signal
sensor_echo_signal
barrier_body_route
```

Geometry must provide a distinct ECHO approach, a materially required body route, no barrier walk-around and a readable coordination moment.

## Solver envelope

```text
target L* = 12–20
hard L* cap = 24
exact N* = 1–64
all-shortest cap = 128
soft/hard states = 100,000 / 250,000
soft/hard elapsed = 30 / 90 seconds
maximum depth = 56
```

Timeout, cutoff, truncation or hard-limit breach means redesign or `UNVERIFIED`. Do not widen limits.

## Focused validation

Create `tests/levels/task_0024az_s03_echo_only_sensor_validation.gd`.

Markers:

```text
TASK_0024AZ_S03_ECHO_ONLY_SENSOR_PASS
TASK_0024AZ_S03_ECHO_ONLY_SENSOR_FAIL
```

Use only public loader, shared Simulation and BFS.

Prove exact identity/schema, public load, catalog absence, exact solver facts, deterministic replay, exact restart, YOU-only completion and no limit reached.

Required event chain:

1. YOU commits to the body route;
2. delayed ECHO enters `sensor_echo_signal`;
3. activation is attributed only to ECHO;
4. barrier opens after transition resolution;
5. later YOU crosses the already-open barrier;
6. YOU reaches EXIT.

All-shortest mask:

```text
BODY_ROUTE_COMMITMENT
ECHO_ON_ECHO_ONLY_SENSOR
BARRIER_OPEN_FROM_ECHO
YOU_LATER_CROSSES_BARRIER
YOU_REACHES_EXIT
```

At `L*`, require exact `N*/N*`, omissions zero, ECHO-only activation in every shortest completion, later barrier crossing from an open start snapshot, material body-route use and complete enumeration. Use shared transition only.

## Required controls

Every control must public-load; no cutoff may be called unsolved.

- no ECHO: complete finite-state unsolved;
- sensor `ANY_ACTOR`: role-substitution shortcut or material metric/event change;
- sensor `YOU_ONLY`: complete-unsolved or materially different body-only shortcut with baseline mask absent;
- sensor/dependency removed: shorter/bypass with mask absent;
- barrier initially open: bypass with mask absent;
- body route removed: complete-unsolved or YOU cannot reach EXIT;
- ECHO route removed: complete-unsolved;
- direct body bypass: shorter/materially different with mask absent;
- symmetric-path variant: role ambiguity, substitution or material metric/event change.

Prove YOU cannot activate the baseline sensor, ECHO can, barrier entry uses start-snapshot state, sensor affects barrier after movement, no baseline bypass, body route is required, ECHO cannot complete, accepted witnesses avoid repeated blocked macros and restart leaves no residue.

## Presentation boundary

Do not modify scenes/rendering. Set `MACHINE_CONTRACT_READY_OWNER_REVIEW_PENDING` only after static cue audit for ECHO identity, ECHO-only glyph/text, barrier dependency, delayed opening, body route, wrong-actor failure and color-independent redundancy.

## Iteration, PRE_FINAL and retained cycle

Before PRE_FINAL, iterate only the new candidate/test/helpers. Every run uses the accepted wrapper, unique identity, bounded budgets, cleanup once, no PID residue, Godot zero and protected hashes unchanged.

After stable qualification:

1. freeze hashes;
2. pass static/parser/schema/protected audits;
3. run focused twice;
4. run current Aggregate and complete-v2;
5. record exact markers/assertions/stderr;
6. create PRE_FINAL seal and prohibit edits;
7. create one fresh 0024AZ manifest.

Use the accepted 0024AL process-isolated write-ahead architecture. Consume the manifest once and run focused S03, current Aggregate and current complete-v2 exactly once. Any consumed-cycle failure closes `BLOCKED`; no repair/rerun/replacement/reconstruction.

## Evidence/current docs

Create the S03 validation JSON, report and handoff. On success set S03 to `MACHINE_VALIDATED_FOR_GPT_REVIEW`, owner `NOT_REVIEWED`, catalog `NOT_AUTHORIZED`, presentation `MACHINE_CONTRACT_READY_OWNER_REVIEW_PENDING`. C07/0024BA remains closed.

## Validation and commit

Require exactly one new level and one new focused test plus UID, zero schema/Simulation/solver/Aggregate/existing-level/catalog/Profile/scenes/gameplay changes, DeepSeek not invoked, catalog 8, finale sequence 8 and Godot zero.

Commit exactly once:

```text
feat: machine validate Phase-1 S03 echo-only sensor
```

Push main; verify synchronized remote, clean tracked/staged state, only `.codex/config.toml` untracked and Godot zero. No second implementation commit.

## Final fields

```text
candidate_slot = S03
level_id = phase_1_s03_echo_only_sensor
candidate_status = MACHINE_VALIDATED_FOR_GPT_REVIEW / BLOCKED / UNVERIFIED
solver_status = SOLVED / UNSOLVED / LIMIT_REACHED / NOT_RUN
shortest_solution_length = <exact or NOT_VERIFIED>
shortest_solution_count = <exact or NOT_VERIFIED>
all_shortest_full_event_mask = <exact>/<exact> / NOT_VERIFIED
all_shortest_omissions = <exact or NOT_VERIFIED>
no_echo_control = COMPLETE_UNSOLVED / OTHER / NOT_VERIFIED
any_actor_control = <exact or NOT_VERIFIED>
you_only_control = <exact or NOT_VERIFIED>
dependency_removed_control = <exact or NOT_VERIFIED>
initially_open_control = <exact or NOT_VERIFIED>
body_route_removed = COMPLETE_UNSOLVED / OTHER / NOT_VERIFIED
echo_route_removed = COMPLETE_UNSOLVED / OTHER / NOT_VERIFIED
direct_body_bypass = <exact or NOT_VERIFIED>
symmetric_path_control = <exact or NOT_VERIFIED>
replay_deterministic = YES / NO / NOT_VERIFIED
restart_exact = YES / NO / NOT_VERIFIED
presentation_status = MACHINE_CONTRACT_READY_OWNER_REVIEW_PENDING
production_catalog_modified = NO / YES
formal_finale_modified = NO / YES
Profile_accessed = NO / YES
next_task_authorized = NO
final_task_verdict = PASS_FOR_GPT_REVIEW / BLOCKED / UNVERIFIED
```

Only explicit GPT acceptance may open C07/0024BA. S03 remains uncatalogued, unsequenced and owner-unreviewed.