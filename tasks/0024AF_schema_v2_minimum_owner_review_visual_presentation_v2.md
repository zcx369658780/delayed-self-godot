# Task 0024AF v2 — Implement and machine-qualify minimum schema-v2 visuals for owner review

- Status: `READY`
- Authority: this file supersedes `tasks/0024AF_schema_v2_minimum_owner_review_visual_presentation.md` for execution
- Gate: `SCHEMA-V2 MINIMUM GAMEPLAY PRESENTATION / OWNER-REVIEW READINESS / MULTI-SUBAGENT REQUIRED / NO CATALOG OR PROFILE CHANGE`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Required accepted checkpoint: `6ce55238c111b0523c72b9168505f107cc5825ea`
- Accepted Task 0024AE result commit: `678f59025ce5fc53a423e7d1aa73bf2a6c09dfd1`
- Accepted Task 0024AE verdict: `TASK_0024AE_ISOLATED_STAGING_OWNER_REVIEW_ROUTE_ACCEPTED`
- Formal product baseline: exactly eight production-catalog levels; sequence 8 remains the sole formal finale
- Accepted uncatalogued candidates: `crate_shadow_timing`, `key_route_commitment`, `identity_shift_bridge`, `lasting_echo_latch`
- Recommended main-agent model: `GPT-5.6 Sol Max`; fallback `GPT-5.6 Sol High`

## 1. Objective

Remove the current `BLOCKED_SCHEMA_V2_VISUALS` owner-review blocker by implementing a minimum, deterministic, no-new-assets presentation for the schema-v2 mechanics used in sequences 9–12:

1. crates;
2. keys and locks, including held-key inventory;
3. typed sensors;
4. grouped barriers, including closed, open and occupied-closure-deferral states;
5. one-shot latches, including inactive, activated, persistent and target-group states.

The presentation must be visible in the normal Gameplay scene and machine-auditable through a pure presentation-descriptor snapshot consumed by both `_draw()` and validation.

This is minimum owner-review presentation only. It is not final art direction, final localization, final accessibility acceptance, owner subjective acceptance or production catalog admission.

## 2. Mandatory multi-subagent execution doctrine

This project now defaults to multi-subagent execution to reduce main-thread token use. Task 0024AF v2 must use the project-local configuration when present:

```text
D:\Delayed_Self\.codex\config.toml
```

### 2.1 Startup handling of `.codex/config.toml`

- `.codex/config.toml` is the sole permitted pre-existing untracked path.
- It is local configuration, not a repository artifact.
- Read it before planning subagent assignments.
- Record its exact path and SHA-256 in the report, but never include its contents.
- Do not modify, stage, commit, delete or copy it.
- Require it to remain byte-identical through task closeout.
- Any other unexpected untracked path remains a blocker.

### 2.2 Required roles

Use at least three distinct subagent roles, routed according to `.codex/config.toml` and existing project/global role definitions:

1. **read-only source mapper** — inspect Gameplay, Simulation-state shapes, accepted sequence-9–12 evidence and protected boundaries;
2. **implementation worker** — implement the pure descriptor helper and bounded Gameplay drawing integration;
3. **independent reviewer/test auditor** — inspect semantic preservation, descriptor completeness, tests and changed-path boundaries.

A documentation/evidence writer may be a fourth role when configured. Prefer the lowest-cost configured model that is adequate for each reading, mapping and documentation role. The main agent remains responsible for scope control, final integration, test execution, Git actions and the terminal verdict.

### 2.3 Concurrency and ownership rules

- Parallel work is permitted only for read-only analysis of disjoint concerns.
- Only one writer may modify a given file at a time.
- Do not allow parallel writers on `vertical_slice.gd`, the presentation helper or the focused test.
- Subagents must not run Git commit/push operations.
- Subagents must not launch Godot concurrently.
- Only the main agent may run the accepted Godot wrapper, final qualification, retained cycle, staging, commit and push.
- No subagent may access Profile/user data or leave the authorized path set.
- The main agent must review and integrate every subagent result; subagent output is advisory until integrated.

### 2.4 Required multi-agent evidence

The final report must retain a compact routing ledger containing:

- role name;
- assigned scope;
- configured routing/model class used, without exposing private configuration contents;
- files inspected or proposed;
- whether the output was accepted, revised or rejected by the main agent;
- confirmation that no subagent ran Git writes, Godot or protected-data access.

If multi-subagent capability or `.codex/config.toml` parsing fails, return an honest blocker. Do not silently fall back to a single-agent implementation.

## 3. Binding presentation policy

Presentation must communicate mechanics through shape, glyph and structure redundancy and must never depend on color alone.

Use existing project geometry, palette, vector drawing and built-in text only. Do not add image assets, fonts, shaders, audio, external packages or network dependencies.

Required semantic draw order:

1. terrain/background;
2. sensor underlays and open-barrier edges;
3. closed barriers and interactable objects;
4. actors;
5. tokens, state overlays and held-key inventory.

All descriptors and drawn bounds must remain within the existing gameplay content area. Board geometry, collision, input and mechanics must not change.

## 4. Required visual language

### 4.1 Crate

- square/box silhouette distinct from wall, YOU and ECHO;
- inset cross, slats or equivalent monochrome structural mark;
- descriptor follows mutable crate position after YOU pushes;
- restart restores the initial descriptor;
- no ECHO push affordance.

### 4.2 Key, lock and inventory

- floor key uses a key silhouette and stable type token;
- matching lock uses a lock/crossbar silhouette and the same token;
- stable tokens are assigned by sorted key type, such as `K1`, `K2`;
- collected floor key disappears;
- held key appears in a bounded board-adjacent inventory strip;
- consumed matching lock and held key disappear together after the accepted same-turn transition;
- restart restores key/lock and clears inventory.

### 4.3 Typed sensor

- inactive sensors remain visible;
- `YOU_ONLY`, `ECHO_ONLY` and `ANY_ACTOR` have distinct non-color-only glyph/shape signatures such as `Y`, `E`, `A`;
- active and inactive states differ structurally, not only by color;
- occupied sensor underlay/ring remains visible around the actor;
- sensor exposes deterministic dependent barrier-group token(s);
- `include_crates=false` must not imply crate eligibility.

### 4.4 Grouped barrier

- stable group tokens such as `G1`, `G2` are deterministic within the level;
- all cells of one group share token and pattern;
- closed uses blocking hatch/crossbar structure;
- open remains visibly outlined rather than disappearing;
- occupied closure deferral has a third distinct structural signature;
- group edges/tokens remain visible under actor occupancy;
- latch-target and typed-sensor groups remain distinguishable by token.

### 4.5 One-shot latch

- inactive latch uses an uncommitted switch/diamond/lever signature;
- activated latch uses a persistent committed/check/filled signature;
- later turns retain the activated state;
- latch displays the token of its target barrier group;
- repeated contact does not suggest a second activation.

## 5. Presentation-descriptor architecture

Create:

```text
scripts/gameplay/schema_v2_presentation.gd
```

The helper must be pure and deterministic. It must:

- accept immutable level definition, current shared-Simulation state and existing board geometry inputs;
- never mutate level or state;
- contain no alternate transition, collision, completion, catalog or Profile logic;
- produce one deterministic descriptor per visible semantic entity/cell/state;
- expose stable fields including family, stable ID, cell/position, layer, state variant, shape token, glyph token, type/group token, bounds and monochrome signature;
- derive visibility and state from accepted mutable Simulation state;
- provide the exact descriptor collection used by `_draw()` and tests.

Modify `scripts/gameplay/vertical_slice.gd` only to:

1. preload/call the helper;
2. draw descriptors using existing vector primitives and built-in text;
3. expose a bounded read-only snapshot such as `get_schema_v2_presentation_snapshot()`;
4. request redraw after already-accepted load, turn and restart state changes.

Do not create a second presentation-state store. Simulation remains authoritative.

## 6. Startup gate

Before editing or launching Godot:

1. require root `D:\Delayed_Self`, branch `main`, expected origin and no Git operation in progress;
2. fetch and fast-forward only;
3. require `HEAD == origin/main`, divergence `0/0`, ancestry of `6ce55238c111b0523c72b9168505f107cc5825ea`;
4. permit only the exact pre-existing untracked `.codex/config.toml`; require no other dirty, staged or untracked path;
5. record `.codex/config.toml` hash and require it unchanged at closeout;
6. require zero pre-existing Godot processes;
7. require Godot `4.7.1.stable.steam.a13da4feb` and wrapper blob `5f14eb0feff903b40311c1c7283b20e2eabbffc2`;
8. read `AGENTS.md`, current task/startup docs, this full task, Task 0024AE report/GPT acceptance, Task 0024AD matrix/route audit, accepted sequence-9–12 reports/summaries, schema-v2 and Simulation-v2 contracts, current Gameplay script/scene and headless lifecycle policy;
9. record exact hashes for `vertical_slice.gd`, its scene, product route/Profile/catalog files, all twelve levels, accepted candidate evidence, staging launcher/catalog and foundation files;
10. stop on remote drift, unexpected dirty state, process ambiguity, accepted-artifact drift, evidence drift, configuration drift or any need to access production/test Profile data.

Production Profile content/metadata/siblings, ordinary user data and test-profile roots are forbidden runtime surfaces.

## 7. Authorized repository paths

Create or modify only:

```text
scripts/gameplay/schema_v2_presentation.gd
scripts/gameplay/schema_v2_presentation.gd.uid
scripts/gameplay/vertical_slice.gd
tests/presentation/task_0024af_schema_v2_minimum_visual_validation.gd
tests/presentation/task_0024af_schema_v2_minimum_visual_validation.gd.uid
tests/tools/task_0024af_*.ps1
tests/tools/task_0024af_*.py
tests/tools/task_0024af_*.json
docs/presentation/SCHEMA_V2_MINIMUM_OWNER_REVIEW_VISUAL_CONTRACT_CURRENT.md
docs/playtest/SUBMISSION_CORE_1_12_OWNER_CURRICULUM_REVIEW_CURRENT.md
docs/reports/0024AF_SCHEMA_V2_MINIMUM_OWNER_REVIEW_VISUAL_PRESENTATION_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/production/EXPANDED_CONTENT_SUBMISSION_ROADMAP_CURRENT.md
```

No other repository path may change. Generated UID files are allowed only for the new helper and focused test. `.codex/config.toml` remains local, untracked and unchanged.

## 8. Frozen and protected surfaces

Do not modify:

```text
scenes/**
project.godot
data/catalog/**
data/levels/**
scripts/app/**
scripts/simulation/**
scripts/solver/**
scripts/gameplay files other than vertical_slice.gd and the new helper
schemas/**
tests/run_all.gd
tests/simulation/**
tests/levels/**
tests/curriculum/**
tests/playtest/task_0024ae_submission_core_owner_review_launcher.gd
tests/playtest/fixtures/task_0024ae_submission_core_staging_catalog.json
tests/tools/run_owned_godot_headless.ps1
accepted Task 0024T–0024AE evidence
localization/**
assets/**
audio/**
build/export/release/submission surfaces
```

Do not change mechanics, collision, turn order, history, solver behavior, route behavior, completion, catalog, finale or Profile handling.

## 9. Static semantic-preservation qualification

Before dynamic qualification, create a deterministic static tool comparing the accepted pre-task `vertical_slice.gd` with the edited file. Prove:

1. route-payload validation is semantically unchanged;
2. level loading is semantically unchanged;
3. input-to-action mapping is semantically unchanged;
4. Simulation transition/restart calls are semantically unchanged;
5. completion signal and final acknowledgement are semantically unchanged;
6. request-back behavior is semantically unchanged;
7. changes are limited to presentation functions, read-only snapshot plumbing and bounded `queue_redraw()` calls;
8. the helper contains no file/Profile/catalog access and no transition implementation;
9. protected files are byte-identical;
10. changed paths are inside the allowlist;
11. `.codex/config.toml` is unchanged and unstaged;
12. the required multi-subagent routing ledger exists and shows no forbidden agent action.

Commit a machine-readable static qualification result.

## 10. Focused machine validation

Create:

```text
res://tests/presentation/task_0024af_schema_v2_minimum_visual_validation.gd
```

Pass marker:

```text
TASK_0024AF_SCHEMA_V2_MINIMUM_VISUAL_PASS
```

Failure prefix:

```text
TASK_0024AF_SCHEMA_V2_MINIMUM_VISUAL_FAIL
```

Use public loader, shared Simulation, accepted BFS/witness evidence and the real presentation helper/snapshot. Do not duplicate transitions.

### 10.1 Descriptor completeness and purity

For sequences 9–12 prove:

- every visible v2 entity has the correct descriptor unless removed by accepted state;
- mutable descriptor cells/states match Simulation;
- stable family/ID/layer/shape/glyph/token/bounds/monochrome fields exist;
- ordering is deterministic;
- duplicate snapshots are identical;
- generation changes no canonical state, history, completion or mutable field.

### 10.2 Sequence 9 crate

Prove initial position, accepted push position, distinct monochrome signature and exact restart restoration.

### 10.3 Sequence 10 key/lock/inventory

Prove initial matching tokens, YOU collection removes floor key and adds inventory, ECHO contact never adds inventory, matching lock consumption removes lock and held key, and restart restores initial state.

### 10.4 Sequence 11 sensors/barrier

Prove distinct YOU/ECHO sensor signatures, inactive visibility, correct/wrong identity distinction, shared group token, distinct closed/open/deferred/closed-after-vacancy signatures, occupied underlay/edge visibility and restart restoration.

### 10.5 Sequence 12 latch synthesis

Prove inactive and activated latch signatures, persistent activation, distinct `barrier_phase` and `barrier_typed` tokens, correct latch target token, persistent-open versus temporary-open/deferred distinction and restart restoration.

### 10.6 Monochrome uniqueness

Ignoring color fields, require unique signatures for at least:

```text
crate
floor_key
held_key
lock
sensor_you_inactive
sensor_you_active
sensor_echo_inactive
sensor_echo_active
barrier_closed
barrier_open
barrier_open_deferred
latch_inactive
latch_activated
```

No required pair may collapse to the same structure.

### 10.7 Fit, layering and v1 regression

- all bounds fit the existing gameplay content area for sequences 1–12;
- layer ordering matches policy;
- actor occupancy does not erase sensor/barrier identity;
- sequences 1–8 produce no spurious v2 descriptors;
- all accepted 1–12 `(L*, N*)` values remain unchanged;
- route, completion and restart behavior remain unchanged.

## 11. Evidence format

Emit independently parseable prefixed JSON records, each strictly below 1800 UTF-8 bytes, covering:

- multi-subagent routing ledger;
- static semantic-preservation qualification;
- per-level descriptor inventory;
- crate states;
- key/lock/inventory states;
- sensor/barrier states;
- latch states;
- monochrome uniqueness;
- fit/layering/v1 regression;
- summary.

The parser must reject missing, duplicate, truncated, invalid-JSON and over-bound records and retain exact byte counts.

## 12. Repeatable qualification

Before final retention, qualification is repeatable and repairable. Every Godot run must:

- be launched only by the main agent through the accepted wrapper;
- invoke cleanup exactly once after native exit;
- retain no owned or unproven PID;
- end with Godot count zero;
- access no Profile/user-data surface;
- preserve failed attempts honestly.

Machine descriptor success does not establish human clarity. It establishes readiness for owner judgment only.

## 13. Fresh retained cycle

After static, focused and parser qualification pass, execute one retained Task 0024AF v2 cycle containing exactly these cases, once each:

1. Task 0024AF visual focused validation — marker `TASK_0024AF_SCHEMA_V2_MINIMUM_VISUAL_PASS`, stderr empty;
2. accepted Task 0024AE staging-route qualification — marker `TASK_0024AE_ISOLATED_STAGING_OWNER_ROUTE_PASS`, stderr empty;
3. accepted Task 0024AD 1–12 batch validator — marker `TASK_0024AD_SUBMISSION_CORE_1_12_BATCH_PASS`, stderr empty;
4. Aggregate — exact `TASK_0003_TESTS_PASS assertions=621 vectors=9`, stderr exactly `LEVEL_ID_MISMATCH`;
5. corrected complete-v2 — marker `TASK_0024V_V2_COMPLETE_PASS`, stderr empty.

For every case retain wrapper/native exits, marker count, stderr, cleanup count/order, process ownership, remaining PIDs and Godot before/after. Final Godot count must be zero.

Do not rerun previously consumed final cycles. This manifest invokes only accepted focused validators. Once the new retained cycle is consumed, do not rerun it.

## 14. Required contract, report and worksheet update

Create:

```text
docs/presentation/SCHEMA_V2_MINIMUM_OWNER_REVIEW_VISUAL_CONTRACT_CURRENT.md
docs/reports/0024AF_SCHEMA_V2_MINIMUM_OWNER_REVIEW_VISUAL_PRESENTATION_REPORT.md
```

The contract must document tokens, state variants, layering and non-color policy without claiming final-art acceptance.

The report must include:

- changed paths and hashes;
- multi-subagent routing ledger;
- helper architecture and semantic-preservation proof;
- per-family visual contract;
- sequence 9–12 state evidence;
- monochrome uniqueness and fit/layering results;
- v1 and 1–12 regression evidence;
- retained cycle and frozen-hash evidence;
- `.codex/config.toml` unchanged/untracked proof without disclosing contents;
- explicit unresolved human judgment and final-art boundaries.

Update the owner worksheet only with readiness state. Do not populate subjective answers. Required pass language:

```text
owner_route_status = MACHINE_QUALIFIED_ISOLATED_STAGING_ROUTE
owner_playthrough_status = NOT_YET_REVIEWED
presentation_readiness = MACHINE_QUALIFIED_SCHEMA_V2_MINIMUM_OWNER_REVIEW_REQUIRED
visual_art_direction_status = NOT_FINAL
catalog_admission_status = NOT_AUTHORIZED
```

## 15. Commit and push policy

On pass or honest blocker:

1. stage only authorized repository paths;
2. explicitly confirm `.codex/config.toml` is unstaged and unchanged;
3. inspect staged names and run `git diff --cached --check`;
4. create one single-topic result commit; do not amend, rebase or squash;
5. fetch before push and stop on remote drift;
6. push only a clean fast-forward to `origin/main`;
7. require post-push `HEAD == origin/main`, divergence `0/0`, no tracked/staged changes, only the permitted untracked `.codex/config.toml`, and Godot zero;
8. report any correction commit transparently.

Suggested pass commit:

```text
feat: add minimum schema v2 visuals for owner review
```

## 16. Terminal verdict

Return exactly one:

```text
SCHEMA_V2_MINIMUM_OWNER_REVIEW_PRESENTATION_READY_FOR_GPT_REVIEW
BLOCKED_SCHEMA_V2_MINIMUM_OWNER_REVIEW_PRESENTATION
PROTECTED_DATA_BOUNDARY_BREACH
```

A pass authorizes only GPT review of minimum schema-v2 presentation. It does not authorize owner subjective acceptance, final art acceptance, production catalog/progression/finale/Profile changes, localization, assets/audio, build/export, release, upload or submission.
