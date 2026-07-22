# Task 0024AD — Run the submission-core 1–12 batch regression and audit the safe owner-review route

- Status: `READY`
- Gate: `SUBMISSION CORE 1–12 BATCH REGRESSION / CURRICULUM READINESS / OWNER PLAYTEST ROUTE AUDIT`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Required accepted checkpoint: `4b89f15010719b96f872849b1ef69732b340e171`
- Accepted sequence-12 result commit: `5843b851d7b63d8b0645c6a8550e2199694b17b1`
- Accepted sequence-12 verdict: `TASK_0024AC_SEQUENCE_12_LASTING_ECHO_LATCH_MACHINE_VALIDATION_ACCEPTED`
- Accepted sequence-11 result commit: `e6cd9fe76c19a144315b173b480ad5f9ccf2f115`
- Accepted sequence-10 result commit: `b8378bc2e1e96642ff99eded436df65e2435cc9f`
- Accepted sequence-9 result commit: `445122ab035a4c9210f3280af58d054a35bef2bd`
- Accepted mechanics foundation result: `7072566ef814f6969693bbc9335fcced5e424585`
- Accepted wrapper implementation/blob: `7c0712d6a602dc23200ccb147d0096acc6333305` / `5f14eb0feff903b40311c1c7283b20e2eabbffc2`
- Formal product baseline at start: exactly eight cataloged levels; sequence 8 remains the sole formal finale
- Accepted uncatalogued candidates: `crate_shadow_timing`, `key_route_commitment`, `identity_shift_bridge`, `lasting_echo_latch`
- Recommended Codex model: `GPT-5.6 Sol Max`; fallback `GPT-5.6 Sol High`

## 1. Objective

Establish a single machine-readable curriculum view across the planned sequences 1–12, run a fresh batch regression without modifying any accepted level or product surface, assess teaching/difficulty continuity, and audit the least-invasive route for a later human owner playthrough of sequences 9–12.

This task is a readiness and route-audit gate. It does **not** perform owner acceptance and does not admit the four candidates to the production catalog.

Required outputs:

1. a fixed 1–12 level manifest and machine curriculum matrix;
2. a fresh shared-loader/Simulation/solver batch regression;
3. a curriculum continuity and redundancy assessment;
4. an owner-review worksheet covering all twelve rooms;
5. a read-only audit of the actual catalog → gameplay → completion → Profile/finale route;
6. one exact, implementation-ready recommendation for a later isolated playtest launcher or staging route;
7. a retained regression cycle and protected-boundary report.

## 2. Fixed planned sequence manifest

Use this exact planned order:

| Sequence | Level ID | Status at task start |
|---:|---|---|
| 1 | `tutorial_reach_exit` | formal/cataloged |
| 2 | `tutorial_echo_bridge` | formal/cataloged |
| 3 | `vertical_slice_delay_3` | formal/cataloged |
| 4 | `door_one_turn_late` | formal/cataloged |
| 5 | `two_keys_one_door` | formal/cataloged |
| 6 | `staggered_doors` | formal/cataloged |
| 7 | `echo_spacing_bridge` | formal/cataloged |
| 8 | `two_echo_convergence` | formal/cataloged; current sole formal finale |
| 9 | `crate_shadow_timing` | accepted uncatalogued candidate |
| 10 | `key_route_commitment` | accepted uncatalogued candidate |
| 11 | `identity_shift_bridge` | accepted uncatalogued fallback candidate |
| 12 | `lasting_echo_latch` | accepted uncatalogued `FINALE_CANDIDATE_ONLY` |

Do not reorder, rename, copy or rewrite any level.

## 3. Startup gate

Before editing or launching Godot:

1. require root `D:\Delayed_Self`, branch `main`, expected origin and no Git operation in progress;
2. fetch and fast-forward only;
3. require `HEAD == origin/main`, divergence `0/0`, ancestry of `4b89f15010719b96f872849b1ef69732b340e171` and a clean worktree;
4. require zero pre-existing Godot processes; never close unknown or pre-existing processes;
5. require Godot `4.7.1.stable.steam.a13da4feb` and accepted wrapper blob `5f14eb0feff903b40311c1c7283b20e2eabbffc2`;
6. read `AGENTS.md`, current startup/active docs, this task, Task 0024X scope, Task 0024Y/Z/AB/AC reports/summaries/GPT acceptances, the schema-v2 and Simulation-v2 contracts, Task 0024W acceptance, current roadmap and the headless lifecycle policy;
7. record exact hashes for all twelve level JSON files, accepted focused validators and accepted 9–12 summaries/reports/acceptances;
8. record hashes for loader, Simulation, BFS, schemas/vectors, wrapper, catalog files, progression/finale routing, Profile store, gameplay scene/scripts and the existing eight-level regression artifacts;
9. stop on remote drift, unexpected dirty state, process ambiguity, accepted-artifact drift, historical evidence drift or any need to read/write production Profile/user data.

Production Profile content, metadata, siblings, ordinary user data and the test-profile root are forbidden.

## 4. Authorized repository paths

Create only:

```text
tests/curriculum/task_0024ad_submission_core_1_12_batch_validation.gd
tests/curriculum/task_0024ad_submission_core_1_12_batch_validation.gd.uid
tests/tools/task_0024ad_*.ps1
tests/tools/task_0024ad_*.py
tests/tools/task_0024ad_*.json
docs/level_design/validation/submission_core_1_12_curriculum_matrix.json
docs/playtest/SUBMISSION_CORE_1_12_OWNER_CURRICULUM_REVIEW_CURRENT.md
docs/playtest/SUBMISSION_CORE_9_12_PLAYTEST_ROUTE_AUDIT_CURRENT.md
docs/reports/0024AD_SUBMISSION_CORE_1_12_BATCH_REGRESSION_AND_OWNER_REVIEW_ROUTE_AUDIT_REPORT.md
```

After a terminal result, update only as needed:

```text
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/production/EXPANDED_CONTENT_SUBMISSION_ROADMAP_CURRENT.md
```

No other path may change. A generated UID is allowed only for the new curriculum validator.

## 5. Frozen and protected surfaces

Do not modify:

```text
data/levels/**
data/catalog/**
scripts/simulation/**
scripts/solver/**
scripts/gameplay/**
scripts/app/**
scenes/**
project.godot
schemas/**
tests/run_all.gd
tests/simulation/**
tests/levels/task_0012_staggered_doors_validation.gd
tests/levels/task_0024y_crate_shadow_timing_validation.gd
tests/levels/task_0024z_key_route_commitment_validation.gd
tests/levels/task_0024aa_identity_shift_bridge_validation.gd
tests/levels/task_0024ab_identity_shift_bridge_validation.gd
tests/levels/task_0024ac_lasting_echo_latch_validation.gd
tests/tools/run_owned_godot_headless.ps1
accepted Task 0024T–0024AC evidence
Profile stores, production user data and test-profile roots
assets/**
audio/**
localization/**
build/export/release/submission surfaces
```

This task may read product source and catalog/Profile route code but may not execute a path that reads or writes production user data.

## 6. Fresh 1–12 batch validator

Create `tests/curriculum/task_0024ad_submission_core_1_12_batch_validation.gd` using only public `LevelLoader.load_file`, shared `Simulation` and accepted BFS solver.

Pass marker:

```text
TASK_0024AD_SUBMISSION_CORE_1_12_BATCH_PASS
```

Failure prefix:

```text
TASK_0024AD_SUBMISSION_CORE_1_12_BATCH_FAIL
```

### 6.1 Identity and immutability

For all twelve entries prove:

- file exists and loads through the public loader;
- exact sequence → level-ID mapping above;
- IDs are unique;
- level title is nonempty;
- dimensions and entity definitions are schema-valid;
- exact file SHA-256 matches the pre-task recorded identity;
- sequences 1–8 remain in the production catalog in their existing order;
- sequences 9–12 remain absent from the production catalog;
- sequence 8 remains the sole formal finale;
- no candidate JSON contains sequence, unlock, formal-finale or Profile state.

### 6.2 Solver/replay/restart matrix

For every level:

- run the accepted BFS solver with limits no larger than the level's accepted/recommended limits;
- require `SOLVED` and exact shortest-solution count status;
- retain `L*`, exact `N*`, visited states, maximum frontier, exact fresh elapsed time and configured limits;
- replay one deterministic shortest witness through shared Simulation to completion;
- repeat replay and require identical final state and canonical trace;
- require exact restart;
- require only YOU can complete EXIT;
- record waits, blocked-YOU actions and repeated blocked-input maximum.

For sequences 9–12 require exact accepted results:

```text
9  crate_shadow_timing   L*=14  N*=6
10 key_route_commitment  L*=19  N*=8
11 identity_shift_bridge L*=18  N*=1
12 lasting_echo_latch    L*=21  N*=6
```

A timing difference is allowed; an `L*`, `N*`, completion, replay, restart or accepted-candidate hash difference is a blocker.

### 6.3 Curriculum matrix

Create one row per sequence containing at least:

- sequence, ID, title, schema version and formal/candidate classification;
- dimensions and entity-family counts;
- newly introduced mechanic families;
- mechanics reused from prior rooms;
- `L*`, exact `N*`, visited/frontier/elapsed;
- conceptual objective;
- prerequisite sequences;
- shortest-witness waits/blocked actions;
- candidate acceptance commit/hash where applicable;
- current owner-review state;
- current catalog/finale/Profile state.

The matrix must be produced from retained machine output plus accepted scope documents, not unsupported prose.

## 7. Curriculum continuity assessment

Assess the twelve-room sequence without forcing numerical monotonicity.

The report and owner worksheet must explicitly evaluate:

1. whether each room has one primary teaching responsibility;
2. whether sequences 9–12 add distinct reasoning structures rather than only longer routes;
3. whether sequence 8 → 9 is a readable transition from multi-ECHO convergence to persistent crate timing;
4. whether sequence 9 → 10 moves from state persistence to irreversible route commitment;
5. whether sequence 10 → 11 moves from item identity to actor identity without excessive simultaneous novelty;
6. whether sequence 11 → 12 reads as synthesis rather than a fourth tutorial;
7. whether `L*=19` at sequence 10 followed by `L*=18` at sequence 11 is acceptable given conceptual load, and flag it for owner review rather than treating it automatically as failure;
8. whether sequence 12 is credible as a finale candidate while sequence 8 remains the formal finale;
9. any redundant mechanic explanation, sudden difficulty cliff, opaque dependency, excessive shortest-solution multiplicity or likely presentation burden;
10. a recommended decision per room: `KEEP`, `OWNER_REVIEW_REQUIRED`, `REVISE_BEFORE_ADMISSION` or `CUT_CANDIDATE`.

Do not modify a room to resolve a curriculum observation in this task.

## 8. Owner curriculum review worksheet

Create `docs/playtest/SUBMISSION_CORE_1_12_OWNER_CURRICULUM_REVIEW_CURRENT.md` as a ready-to-use human review form.

For each sequence include:

- ID and current title;
- primary lesson and prerequisite;
- machine `L*`/`N*` and accepted status;
- spoiler-free review objective;
- fields for completion result, perceived difficulty `1–5`, clarity `1–5`, enjoyment `1–5`, first confusion point, accidental shortcut, presentation blocker and free notes;
- owner disposition: `ACCEPT`, `REVISE`, `CUT`, `RETEST`;
- explicit statement that blank fields are `NOT_YET_REVIEWED`, not implicit acceptance.

Include cross-room questions for pacing, memory load, tutorial redundancy, sequence 12 finale credibility and whether sequence 8 should become a chapter capstone later.

Do not populate subjective owner answers.

## 9. Read-only playtest-route audit

Inspect the actual product route from catalog selection to gameplay loading, completion reporting, unlock progression, formal finale behavior and Profile persistence.

Create `docs/playtest/SUBMISSION_CORE_9_12_PLAYTEST_ROUTE_AUDIT_CURRENT.md` containing:

1. exact files/functions/scenes involved in catalog parsing, selected-level handoff, gameplay loading, completion, unlock/finale decisions and Profile reads/writes;
2. whether an existing direct level-path or level-dictionary launch route already exists;
3. whether actual gameplay can be launched with a test-only or isolated Profile root without changing production code;
4. every point at which a candidate playtest could accidentally write production Profile data;
5. the minimum safe later implementation route, selecting exactly one:
   - `EXISTING_DIRECT_ROUTE_SAFE`;
   - `TEST_ONLY_LAUNCHER_FEASIBLE_WITHOUT_PRODUCT_CHANGES`;
   - `ISOLATED_STAGING_CATALOG_REQUIRED`;
   - `PRODUCT_INJECTION_SEAM_REQUIRED`;
   - `BLOCKED_BY_UNRESOLVED_PROFILE_BOUNDARY`;
6. an exact next-task file allowlist and implementation plan for the selected route;
7. launch commands or editor steps only when supported by inspected code;
8. rollback and zero-production-data verification steps.

Do not create the launcher, staging catalog or injection seam in Task 0024AD. Do not invoke an interactive gameplay route that could access production Profile data.

## 10. Bounded evidence format

Use independently parseable prefixed JSON records, each strictly below 1800 UTF-8 bytes. Include separate records for manifest/identity, per-level metrics, replay/restart, catalog-state assertions and batch summary.

The parser must reject missing, duplicate, truncated, non-JSON and over-bound records and retain raw byte counts. Exact elapsed times must come from the fresh batch execution.

## 11. Fresh retained regression cycle

After the batch validator and capture parser are stable, run one retained Task 0024AD cycle containing exactly these cases, once each under this task identity:

1. `res://tests/curriculum/task_0024ad_submission_core_1_12_batch_validation.gd`
   - marker `TASK_0024AD_SUBMISSION_CORE_1_12_BATCH_PASS`;
   - stderr empty;
2. accepted focused Task 0024AC;
3. accepted focused Task 0024AB;
4. accepted focused Task 0024Z;
5. accepted focused Task 0024Y;
6. Aggregate with exact `TASK_0003_TESTS_PASS assertions=621 vectors=9` and stderr exactly `LEVEL_ID_MISMATCH`;
7. corrected complete-v2 with empty stderr.

For every case retain wrapper/native exits, exact marker count, stderr, cleanup count/order, process ownership, remaining owned/unproven PIDs, Godot before/after and bounded stdout/stderr.

Final Godot count must be zero. Once declared retained and consumed, do not rerun it.

## 12. Frozen audit and boundary evidence

Run PRE_TASK, PRE_FINAL and POST_FINAL audits over:

- Task 0024W seal and historical external evidence;
- all twelve level JSON files;
- catalog and eight formal-level identities;
- accepted sequence-9/10/11/12 validators, summaries, reports and GPT acceptances;
- historical Task 0024AA/AB evidence;
- wrapper, loader, Simulation, BFS, schemas/vectors;
- product catalog/gameplay/Profile/finale route files read during the audit.

All mismatch counts must be zero. Record that production Profile/user data was neither read nor written.

## 13. Required report

Create:

```text
docs/reports/0024AD_SUBMISSION_CORE_1_12_BATCH_REGRESSION_AND_OWNER_REVIEW_ROUTE_AUDIT_REPORT.md
```

The report must state:

- exact changed-path inventory and hashes;
- fresh twelve-level matrix and retained cycle facts;
- any curriculum warnings without modifying content;
- the selected owner-playtest route classification and exact rationale;
- unresolved human-review fields;
- frozen-hash evidence and protected boundaries;
- explicit separation between machine readiness, owner playthrough and formal admission.

## 14. Commit and push policy

On pass or honest blocker:

1. stage only authorized paths;
2. inspect staged names and run `git diff --cached --check`;
3. create one single-topic result commit; do not amend, rebase or squash;
4. fetch before push and stop on remote drift;
5. push only a clean fast-forward to `origin/main`;
6. require post-push `HEAD == origin/main`, divergence `0/0`, clean worktree and Godot zero;
7. report any separate correction commit transparently.

Suggested pass commit:

```text
test: validate 1-12 curriculum and audit owner playtest route
```

## 15. Terminal verdict

Return exactly one:

```text
SUBMISSION_CORE_1_12_BATCH_REGRESSION_AND_OWNER_REVIEW_ROUTE_READY_FOR_GPT_REVIEW
BLOCKED_SUBMISSION_CORE_1_12_BATCH_REGRESSION_OR_PLAYTEST_ROUTE
PROTECTED_DATA_BOUNDARY_BREACH
```

A pass authorizes only GPT review of the curriculum matrix and safe playtest-route recommendation. It does not authorize a launcher implementation, owner acceptance, catalog/progression/finale/Profile changes, presentation/UI, localization, assets/audio, build/export, release, upload or submission.