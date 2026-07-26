# Task 0024AV — Freeze six Phase-1 candidate briefs and validation budgets before level authoring

- Status: `READY`
- Gate: `SIX-BRIEF FREEZE / READ-ONLY CONTRACT AUDIT / SOLVER-BUDGET PLAN`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Required accepted checkpoint in ancestry: `402431849f4379fad279dff9f6c965c0fbe04db9`
- Previous accepted gate: `TASK_0024AU_OWNER_REBASELINE_DOCUMENTATION_COMPLETION_ACCEPTED`
- Owner playthrough: `COMPLETED_WITH_DIRECTIONAL_FEEDBACK`
- Production catalog: exactly sequences 1–8
- Formal finale: sequence 8 only
- Candidate admission: `NOT_AUTHORIZED`
- DeepSeek project-code routing: `DISABLED`
- Task type: documentation/read-only planning only
- Godot, solver, level/code/schema/catalog/Profile changes: not authorized

## 1. Objective

Freeze the first Phase-1 proof batch before any level file is authored.

Default candidates:

```text
C02 — crate pressure plate
C03 — crate-held delayed door
C07 — crate + echo cooperation
S01 — explicit role separation
S03 — echo-only sensor route
S04 — asymmetric parallel paths
```

Codex must:

1. synchronize safely;
2. audit current schema/Simulation/solver support read-only;
3. classify each candidate as `SUPPORTED_AS_IS`, `REQUIRES_BOUNDED_SCHEMA_EXTENSION`, or `BLOCKED_BY_CURRENT_CONTRACT`;
4. freeze six complete briefs with no level data;
5. freeze symbolic solution hypotheses, solver budgets, controls, presentation requirements, cut conditions, and future task identities;
6. update the selected portfolio rows and current planning documents;
7. create exactly one documentation commit and push;
8. return `PASS_FOR_GPT_REVIEW` or `BLOCKED`.

No candidate becomes authored, machine-validated, cataloged, or owner-accepted here.

## 2. Rationale

Phase 1 tests breadth, not volume.

- C02 tests a meaningful crate-specific destination.
- C03 tests crate-created delayed timing rather than static obstruction.
- C07 tests a necessary crate/echo dependency chain.
- S01 explicitly teaches non-substitutable body/echo roles.
- S03 tests an echo-only sensor with a distinct body responsibility.
- S04 tests asymmetric parallel routes rather than mirrored paths.

## 3. Required reads

Read in order:

```text
AGENTS.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
tasks/0024AV_phase_1_six_candidate_brief_and_validation_plan.md
docs/reports/0024AU_GPT_OWNER_REBASELINE_DOCUMENTATION_COMPLETION_ACCEPTANCE.md
docs/reports/0024AU_OWNER_REBASELINE_DOCUMENTATION_COMPLETION_AND_SYNC_REPORT.md
docs/level_design/OWNER_FEEDBACK_MECHANIC_EXPANSION_REBASELINE_CURRENT.md
docs/level_design/OWNER_FEEDBACK_LEVEL_PORTFOLIO_MATRIX_CURRENT.md
docs/playtest/SUBMISSION_CORE_1_12_OWNER_CURRICULUM_REVIEW_CURRENT.md
docs/game_design/GAMEPLAY_BREADTH_AND_MECHANICS_REBASELINE_CURRENT.md
docs/production/EXPANDED_CONTENT_SUBMISSION_ROADMAP_CURRENT.md
docs/level_design/SUBMISSION_CORE_LEVELS_9_12_SCOPE_CURRENT.md
docs/reports/0024W_GPT_COMPLETE_CORE_MECHANICS_FOUNDATION_ACCEPTANCE.md
schemas/**
scripts/simulation/**
scripts/tools/**
data/levels/**
tests/simulation/**
tests/levels/**
docs/DOC_INDEX_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
```

Code/schema/level/test reads are read-only and only for dependency classification. Do not inspect Profile data.

## 4. Hard boundaries

Do not:

- create or modify level data;
- change gameplay, Simulation, solver, schema, tests, catalog, sequence order, Profile, or finale;
- launch Godot or run solver/gameplay tests;
- create manifests/evidence identities;
- invoke DeepSeek;
- assign production sequence numbers;
- call symbolic solutions machine verified;
- promise that all six candidates will ship.

## 5. Support audit

For each candidate record:

```text
candidate_slot
current_mechanics_used
current_schema_fields_used
current_simulation_paths_used
current_solver_paths_used
support_classification
missing_contract
bounded_future_change_surface
protected_surface_risk
recommended_action
```

Use:

- `SUPPORTED_AS_IS` only when current accepted contracts express the brief without semantic changes.
- `REQUIRES_BOUNDED_SCHEMA_EXTENSION` only for a deterministic, room-local, narrowly specified extension; identify exact schema/Simulation/solver/test surfaces and defaults. No extension is authorized here.
- `BLOCKED_BY_CURRENT_CONTRACT` for freeform physics, ambiguous priority, nondeterminism, unsafe persistence, unbounded search, or changes that cannot be bounded.

## 6. Bounded substitutions

Retain the default selection unless a candidate is `BLOCKED_BY_CURRENT_CONTRACT`.

At most one substitution per family:

```text
crate fallbacks: C04, then C05
body/shadow fallbacks: S05, then S06
```

A substitution must preserve reasoning breadth, remain bounded, update all documents consistently, and keep exactly six candidates.

## 7. Required files

Create:

```text
docs/level_design/phase_1/PHASE_1_SIX_CANDIDATE_BRIEFS_CURRENT.md
docs/level_design/phase_1/PHASE_1_SIX_CANDIDATE_VALIDATION_PLAN_CURRENT.md
docs/level_design/phase_1/C02_CRATE_PRESSURE_PLATE_BRIEF.md
docs/level_design/phase_1/C03_CRATE_DELAYED_DOOR_BRIEF.md
docs/level_design/phase_1/C07_CRATE_ECHO_COOPERATION_BRIEF.md
docs/level_design/phase_1/S01_EXPLICIT_ROLE_SEPARATION_BRIEF.md
docs/level_design/phase_1/S03_ECHO_ONLY_SENSOR_BRIEF.md
docs/level_design/phase_1/S04_ASYMMETRIC_PARALLEL_PATHS_BRIEF.md
```

When a permitted substitution occurs, replace only the corresponding default brief path with the substituted slot path.

## 8. Mandatory brief fields

Every brief must include:

### Identity

```text
candidate_slot
working_title_zh
working_title_en
family
phase = PHASE_1_PROOF_BATCH
status = BRIEF_FROZEN_NOT_AUTHORED
production_sequence = UNASSIGNED
catalog_status = NOT_AUTHORIZED
owner_review_status = NOT_REVIEWED
machine_validation_status = NOT_RUN
```

### Design intent

```text
teaching_goal
player_visible_objective
prerequisites
new_reasoning_structure
relationship_to_seed_room
anti_duplication_claim
non_goals
```

### Roles

Crate briefs:

```text
you_responsibility
echo_responsibility
crate_specific_purpose
why_crate_is_not_optional
```

Body/shadow briefs:

```text
body_responsibility
echo_responsibility
why_roles_are_not_substitutable
```

### Dependencies

```text
support_classification
level_data_dependencies
schema_dependencies
simulation_dependencies
solver_dependencies
presentation_dependencies
required_future_tests
forbidden_implementation_shortcuts
```

### Topology hypothesis

Include a small symbolic/ASCII sketch using named regions, not production coordinates or JSON.

```text
topology_status = DESIGN_HYPOTHESIS_NOT_LEVEL_DATA
```

### Symbolic solution

Provide phase-based human-design steps, identify the intended-mechanic witness and critical timing/commitment decision, and state:

```text
candidate_solution_status = HUMAN_DESIGN_HYPOTHESIS_NOT_MACHINE_VERIFIED
```

### Solver budget

Each brief specifies:

```text
target_shortest_solution_band
hard_solution_length_cap
soft_state_expansion_budget
hard_state_expansion_budget
soft_elapsed_budget_seconds
hard_elapsed_budget_seconds
shortest_solution_enumeration_cap
required_machine_witnesses
required_negative_controls
timeout_policy
```

Default classes:

```text
Intro: target L*=10–16; hard L*=20; states 50k/150k; elapsed 15/60s; enum 128
Intermediate: target L*=12–20; hard L*=24; states 100k/250k; elapsed 30/90s; enum 128
Synthesis proof: target L*=14–22; hard L*=26; states 150k/400k; elapsed 45/120s; enum 128
```

Timeout means `UNVERIFIED`.

### Controls

Define at least:

- intended-mechanic witness;
- no/displaced-crate control for crate rooms;
- no-echo control when echo is required;
- role-substitution control for body/shadow rooms;
- eligibility/barrier control where relevant;
- topology shortcut audit;
- restart/reset proof;
- trivial-solution rejection.

Do not claim any control passes.

### Presentation

```text
identity_cues
crate_or_actor_cues
door_sensor_barrier_cues
timeline_or_delay_cue
failure_readability
restart_readability
color_independent_redundancy
minimum_schema_v2_evidence
owner_review_question
```

### Cut conditions

List at least five triggers, including duplicate reasoning, optional intended mechanic, hard-budget overrun, unclear purpose/role, unbounded contract change, opaque failure, execution-heavy solution, or schedule cost exceeding proof value.

## 9. Candidate-specific minimums

### C02

Crate occupies a crate-eligible destination; body cannot substitute; crate creates a route/timing consequence; delayed echo participation is required or the brief is rejected as generic Sokoban.

Controls: plate excludes crate, crate not moved, echo disabled.

### C03

Crate creates/preserves a delayed door window distinct from C02; next-turn barrier semantics and echo arrival timing are explicit.

Controls: immediate-update control, crate removed before echo, timing bypass.

### C07

YOU positions crate; ECHO later performs a non-substitutable action; neither crate-only nor echo-only solves; the handoff is readable.

Controls: no crate, no echo, crate pre-positioned, body substitutes for echo.

### S01

Teach different body/echo responsibilities before failure, without advanced synthesis.

Controls: body-only, echo-only, eligibility swapped, symmetric-path control.

### S03

An `ECHO_ONLY` sensor or accepted equivalent is necessary; body cannot activate it and has a separate responsibility.

Controls: sensor `ANY_ACTOR`, sensor `YOU_ONLY`, echo disabled, body route removed.

### S04

Body and echo traverse different topologies with cross-route dependency; routes are not mirror copies.

Controls: symmetric paths, route removed, roles swapped, dependency removed.

## 10. Overview and order

The overview must compare final slots, support classifications, budget classes, substitutions, future identities, and protected boundaries.

Default interleaved authoring order:

```text
1 C02
2 S01
3 C03
4 S03
5 C07
6 S04
```

Change only for a documented dependency reason. Do not author all crate rooms before all body/shadow rooms.

## 11. Reserved future identities

Reserve only in planning documents:

```text
0024AW — author/machine-validate C02
0024AX — author/machine-validate S01
0024AY — author/machine-validate C03
0024AZ — author/machine-validate S03
0024BA — author/machine-validate C07
0024BB — author/machine-validate S04
0024BC — integrated six-candidate machine/curriculum comparison
0024BD — owner Phase-1 playthrough and portfolio scope checkpoint
```

If a slot is substituted, its position retains the reserved identity. Do not create these task files or evidence identities now.

## 12. Validation plan

For each candidate, `PHASE_1_SIX_CANDIDATE_VALIDATION_PLAN_CURRENT.md` must define:

```text
future_task_identity
candidate_slot
expected_authored_paths
expected_validation_summary_path
expected_report_path
independent_manifest_policy
qualification_requirements
final_machine_case_categories
required_controls
retained_evidence_budget
no_rerun_boundary
terminal_verdicts
```

Each candidate has an independent future task and evidence lifecycle. No shared one-shot manifest. A blocked candidate may be cut without automatically blocking the other family. Task 0024BC requires all candidate tasks individually adjudicated.

## 13. Phase-1 comparison rubric

Freeze dimensions for Tasks 0024BC/BD:

```text
solver tractability
shortest-solution quality
intended-mechanic necessity
shortcut resistance
reasoning distinctiveness
failure readability
presentation clarity
owner enjoyment
implementation cost
test/evidence cost
duplicate-mechanic risk
festival schedule fit
```

Possible later family verdicts: `CONTINUE`, `CONTINUE_WITH_CUTS`, `REDESIGN`, `STOP_TRACK`. Assign none now.

## 14. Synchronization

Update the six selected rows in:

```text
docs/level_design/OWNER_FEEDBACK_LEVEL_PORTFOLIO_MATRIX_CURRENT.md
```

Set:

```text
candidate_status = BRIEF_FROZEN_NOT_AUTHORED
machine_validation_status = NOT_RUN
presentation_status = NOT_IMPLEMENTED
owner_review_status = NOT_REVIEWED
catalog_status = NOT_AUTHORIZED
```

Update the current gameplay rebaseline and expanded roadmap to reference the six-brief freeze without implying authoring or shipping.

Create:

```text
docs/reports/0024AV_PHASE_1_SIX_CANDIDATE_BRIEF_AND_VALIDATION_PLAN_REPORT.md
docs/handoffs/DELAYED_SELF_SESSION_HANDOFF_AFTER_TASK_0024AV_PHASE_1_BRIEF_FREEZE_2026_07_26.md
```

Update current pointers/index/plan/handoff/memory consistently.

## 15. Authorized paths

Only:

```text
docs/level_design/phase_1/**
docs/level_design/OWNER_FEEDBACK_LEVEL_PORTFOLIO_MATRIX_CURRENT.md
docs/production/EXPANDED_CONTENT_SUBMISSION_ROADMAP_CURRENT.md
docs/game_design/GAMEPLAY_BREADTH_AND_MECHANICS_REBASELINE_CURRENT.md
docs/reports/0024AV_PHASE_1_SIX_CANDIDATE_BRIEF_AND_VALIDATION_PLAN_REPORT.md
docs/handoffs/DELAYED_SELF_SESSION_HANDOFF_AFTER_TASK_0024AV_PHASE_1_BRIEF_FREEZE_2026_07_26.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
```

## 16. Protected surfaces

Do not modify:

```text
data/catalog/**
data/levels/**
scripts/**
scenes/**
project.godot
schemas/**
tests/**
docs/playtest/**
docs/reports/0024AL_*
docs/reports/0024AU_*
localization/**
assets/**
audio/**
build/**
export/**
release/**
submission/**
C:\Users\zcxve\.codex\**
```

## 17. Startup gate

Before writing:

1. require root `D:\Delayed_Self`, branch `main`, expected origin;
2. fetch/fast-forward only;
3. require `HEAD == origin/main`, divergence `0/0`;
4. require Task 0024AV/current pointers from origin;
5. require accepted checkpoint `402431849f4379fad279dff9f6c965c0fbe04db9` in ancestry;
6. require no tracked/staged changes;
7. allow only accepted untracked `.codex/config.toml` and verify its accepted hash;
8. require Godot count zero;
9. stop on remote, worktree, protected-file drift, or unauthorized Phase-1 artifacts.

## 18. Validation

Run:

```powershell
git status --short --untracked-files=all
git diff --check
git diff --name-only
git diff --stat
```

Mandatory checks:

```text
selected candidates = 6
crate/body-shadow = 3/3
brief files = 6
overview = 1
validation plan = 1
all brief statuses = BRIEF_FROZEN_NOT_AUTHORED
machine validation claims = 0
production sequence assignments = 0
reserved future identities = 8
selected matrix rows updated = 6
level files created = 0
code/schema/tests modified = 0
production catalog = 8
formal finale = sequence 8
shipping count = DEFERRED
candidate admission = NOT_AUTHORIZED
DeepSeek code routing = DISABLED
```

Every brief must contain all mandatory fields and at least five cut conditions. Check Markdown links.

```text
full_gameplay_regression = NOT_RUN_NOT_REQUIRED_PLANNING_ONLY
solver_execution = NOT_RUN_NOT_AUTHORIZED
```

## 19. One-commit policy

Exactly one implementation commit.

Before commit, complete the full checklist, validate all fields/links, fetch with divergence `0/0`, explicitly stage authorized paths, compare staged paths to the checklist, run `git diff --cached --check`, and review the full staged diff.

Commit:

```text
docs: freeze Phase-1 six-candidate briefs
```

Push main. Verify `HEAD == origin/main`, no tracked/staged changes, only `.codex/config.toml` untracked, and Godot zero. If an omission is found after push, return `BLOCKED`; do not create a second implementation commit.

## 20. Terminal verdict

Return `PASS_FOR_GPT_REVIEW` only if six complete not-authored briefs, evidence-based support classifications, explicit budgets/controls/presentation, interleaved order, future identities, no machine claims, no protected changes, and exactly one pushed commit are all satisfied. Otherwise return `BLOCKED`.

## 21. Required final fields

```text
task_0024au_status = TASK_0024AU_OWNER_REBASELINE_DOCUMENTATION_COMPLETION_ACCEPTED
phase_1_selected_slots = <six slots>
crate_briefs = 3_OF_3 / INCOMPLETE
body_shadow_briefs = 3_OF_3 / INCOMPLETE
support_classifications_complete = 6_OF_6 / INCOMPLETE
symbolic_solution_outlines = 6_OF_6 / INCOMPLETE
solver_budgets = 6_OF_6 / INCOMPLETE
shortcut_control_plans = 6_OF_6 / INCOMPLETE
presentation_plans = 6_OF_6 / INCOMPLETE
future_task_identities_reserved = 8 / OTHER
new_level_files_created = NO / YES
gameplay_code_modified = NO / YES
schema_modified = NO / YES
tests_modified = NO / YES
production_catalog_modified = NO / YES
formal_finale_modified = NO / YES
candidate_admission = NOT_AUTHORIZED
next_task = 0024AW_FIRST_SELECTED_CANDIDATE_AUTHORING_AND_MACHINE_VALIDATION
final_task_verdict = PASS_FOR_GPT_REVIEW / BLOCKED
```

## 22. Next gate

After GPT acceptance, execute only the first reserved authoring task. It must independently freeze exact allowed files, author one uncatalogued candidate, run candidate-specific schema/Simulation/solver tests, produce machine evidence, and stop before the next candidate. No batch authoring is implied.
