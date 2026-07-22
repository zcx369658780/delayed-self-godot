# Task 0024AF — Implement and machine-qualify minimum schema-v2 visuals for owner review

- Status: `READY`
- Gate: `SCHEMA-V2 MINIMUM GAMEPLAY PRESENTATION / OWNER-REVIEW READINESS / NO CATALOG OR PROFILE CHANGE`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Required accepted checkpoint: `6ce55238c111b0523c72b9168505f107cc5825ea`
- Accepted Task 0024AE result commit: `678f59025ce5fc53a423e7d1aa73bf2a6c09dfd1`
- Accepted Task 0024AE verdict: `TASK_0024AE_ISOLATED_STAGING_OWNER_REVIEW_ROUTE_ACCEPTED`
- Accepted isolated staging route: test-owned 12-entry catalog plus exact isolated test Profile
- Formal product baseline: exactly eight production-catalog levels; sequence 8 remains the sole formal finale
- Accepted uncatalogued candidates: `crate_shadow_timing`, `key_route_commitment`, `identity_shift_bridge`, `lasting_echo_latch`
- Recommended Codex model: `GPT-5.6 Sol Max`; fallback `GPT-5.6 Sol High`

## 1. Objective

Remove the current `BLOCKED_SCHEMA_V2_VISUALS` owner-review blocker by implementing a minimum, deterministic, no-new-assets presentation for the schema-v2 mechanics used in sequences 9–12:

1. crates;
2. keys and locks, including held-key inventory;
3. typed sensors;
4. grouped barriers, including open/closed and occupied-closure-deferral states;
5. one-shot latches, including inactive/activated persistence and target-group identity.

The result must be visible in the normal Gameplay scene and must be machine-auditable through a pure presentation-descriptor snapshot shared with `_draw()`.

This is **minimum owner-review presentation**, not final hand-drawn art direction, final localization, final accessibility acceptance or owner subjective acceptance.

## 2. Binding presentation policy

Presentation must communicate mechanics through shape/glyph/structure redundancy and must never depend on color alone.

Use existing project geometry, palette and vector drawing only. Do not add image assets, fonts, shaders, audio or external dependencies.

Required visual language:

### 2.1 Crate

- persistent square/box silhouette distinct from walls and actors;
- inset cross, slats or equivalent structural mark that remains recognizable in monochrome;
- descriptor position must follow the current mutable crate state after a push;
- ECHO must never receive a crate-push presentation affordance.

### 2.2 Key and lock

- floor key uses a key-shaped silhouette plus deterministic key-type token;
- matching lock uses a padlock/crossbar silhouette plus the same key-type token;
- key disappears from the board after collection;
- lock disappears after accepted matching consumption;
- held-key inventory is visibly represented in a bounded board-adjacent strip using icon plus deterministic type/count token;
- no English tutorial sentence or localized product copy is required in this task.

For multiple key types, assign stable tokens by sorted key type, for example `K1`, `K2`. The same type must always receive the same token within one level.

### 2.3 Typed sensor

- every sensor remains visible when inactive and when occupied;
- `YOU_ONLY`, `ECHO_ONLY` and `ANY_ACTOR` must have distinct glyph/shape signatures (`Y`, `E`, `A` or equivalent stable tokens);
- active/inactive state must differ by more than color;
- when an actor occupies the sensor, an outer ring/underlay or equivalent mark must remain visible around the actor;
- each sensor must expose the deterministic group token(s) of barrier groups that depend on it;
- `include_crates=false` must not be visually misrepresented as crate eligibility.

### 2.4 Grouped barrier

- every group receives a deterministic stable token, for example `G1`, `G2`, assigned by stable level definition order or sorted stable ID;
- all cells in the same group share that token/structural pattern;
- closed state uses a blocking hatch/crossbar structure;
- open state remains visible through perimeter/corner/dashed structure rather than disappearing entirely;
- occupied-cell closure deferral uses a third non-color-only signature distinct from ordinary open state;
- actor occupancy must not completely hide group state at the cell edge;
- latch-target groups and typed-sensor groups must remain distinguishable by group token even when both use the grouped-barrier family.

### 2.5 One-shot latch

- inactive latch uses a one-shot switch/diamond/lever signature with empty or uncommitted center;
- activated latch uses a persistent committed/check/filled structural signature;
- activation state must remain visible on later turns;
- the latch shows the deterministic token of its target barrier group;
- repeated contact must not imply a second activation affordance.

### 2.6 Layering and fit

Required semantic draw order:

1. terrain/background;
2. cell underlays: sensors and open barrier edges;
3. blocking/interactable objects: closed barriers, crates, keys, locks, latches;
4. actors;
5. state overlays, group/type tokens and held-key inventory.

All descriptors and drawn bounds must remain inside the existing logical gameplay content area for all accepted sequences 1–12. No board geometry, collision or input behavior may change.

## 3. Presentation-descriptor architecture

Create a pure helper:

```text
scripts/gameplay/schema_v2_presentation.gd
```

The helper may be a `RefCounted` or static utility. It must:

- accept immutable level definition plus current shared-Simulation state and existing board geometry inputs;
- produce deterministic presentation descriptors without mutating level or state;
- use no alternate mechanics or transition logic;
- expose one descriptor per visible semantic entity/cell/state;
- contain stable fields such as family, stable ID, cells/position, layer, state variant, shape token, glyph token, type/group token and monochrome signature;
- derive barrier open/closed/deferral presentation from accepted current state plus sensor dependency/occupancy facts;
- derive key/lock/inventory/latch visibility from accepted mutable state;
- provide the same descriptor collection consumed by normal Gameplay `_draw()` and by tests.

Modify `scripts/gameplay/vertical_slice.gd` only as needed to:

1. call the helper from `_draw()`;
2. render the returned descriptors using vector primitives/default built-in text drawing;
3. expose a bounded public read-only method such as `get_schema_v2_presentation_snapshot()` for validation;
4. ensure redraw occurs after accepted turn/restart/load state changes.

Do not create a second presentation state store. The shared Simulation state remains authoritative.

## 4. Startup gate

Before editing or launching Godot:

1. require root `D:\Delayed_Self`, branch `main`, expected origin and no Git operation in progress;
2. fetch and fast-forward only;
3. require `HEAD == origin/main`, divergence `0/0`, ancestry of `6ce55238c111b0523c72b9168505f107cc5825ea` and clean worktree;
4. require zero pre-existing Godot processes;
5. require Godot `4.7.1.stable.steam.a13da4feb` and accepted wrapper blob `5f14eb0feff903b40311c1c7283b20e2eabbffc2`;
6. read `AGENTS.md`, current startup/active docs, this task, Task 0024AE report/GPT acceptance, Task 0024AD matrix/route audit, accepted sequence-9/10/11/12 reports and summaries, schema-v2 and Simulation-v2 contracts, current Gameplay script/scene and headless lifecycle policy;
7. record exact pre-task hashes for `vertical_slice.gd`, its scene, all product route/Profile/catalog files, all twelve levels, accepted candidate validators/evidence, staging launcher/catalog and foundation files;
8. stop on remote drift, dirty state, process ambiguity, accepted-artifact drift, historical evidence drift or any need to access production/test Profile data.

Production Profile content/metadata/siblings, ordinary user data and test-profile roots are forbidden runtime surfaces in this task.

## 5. Authorized repository paths

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

No other path may change. Generated UID files are allowed only for the new helper and new focused test.

## 6. Frozen and protected surfaces

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

Do not change mechanics, collision, turn order, history, solver behavior, accepted level data, route behavior, completion, catalog, finale or Profile handling.

## 7. Static protected-function qualification

Before dynamic qualification, create a deterministic static tool that compares pre-task `vertical_slice.gd` with the edited file.

It must prove:

1. route-payload validation is semantically unchanged;
2. level loading is semantically unchanged;
3. input-to-action mapping is semantically unchanged;
4. Simulation transition/restart calls are semantically unchanged;
5. completion signal and final-acknowledgement behavior are semantically unchanged;
6. request-back behavior is semantically unchanged;
7. only presentation functions, presentation snapshot plumbing and bounded `queue_redraw()` additions changed;
8. the new helper contains no file/Profile/catalog access and no transition implementation;
9. production scene and all protected files are byte-identical;
10. changed paths are inside the exact allowlist.

The static qualification must be machine-readable and committed.

## 8. Focused machine validation

Create:

```text
res://tests/presentation/task_0024af_schema_v2_minimum_visual_validation.gd
```

Required pass marker:

```text
TASK_0024AF_SCHEMA_V2_MINIMUM_VISUAL_PASS
```

Failure prefix:

```text
TASK_0024AF_SCHEMA_V2_MINIMUM_VISUAL_FAIL
```

Use the public loader, shared Simulation, accepted BFS/witness evidence and the real Gameplay presentation helper/snapshot. Do not duplicate transitions.

### 8.1 Descriptor completeness

For each accepted sequence 9–12 level:

- every level-defined v2 entity has an initial descriptor unless its accepted mutable state removes it;
- every mutable visible entity descriptor cell/state matches shared Simulation state;
- all descriptors have stable family/ID/layer/shape/glyph/token/monochrome fields;
- descriptor ordering is deterministic;
- calling the snapshot twice on the same state returns identical content;
- descriptor generation does not change canonical state, completion, history or any mutable field.

### 8.2 Sequence 9 crate states

Using the accepted shortest witness/evidence:

- initial crate descriptor is present at the exact initial cell;
- after the accepted YOU push, the descriptor moves to the exact mutable crate cell;
- the crate monochrome signature differs from wall, YOU and ECHO signatures;
- restart restores the initial crate descriptor exactly.

### 8.3 Sequence 10 key/lock/inventory states

Retain snapshots proving:

- initial key and matching lock are visible with the same stable key-type token;
- after YOU collection, floor key descriptor is absent and held-key inventory descriptor is present;
- ECHO contact never produces held-key inventory;
- after same-turn lock consumption/entry, lock descriptor and held key are absent;
- restart restores key and lock and clears held inventory.

### 8.4 Sequence 11 typed sensor/grouped barrier states

Retain snapshots proving:

- `YOU_ONLY` and `ECHO_ONLY` sensors have distinct non-color-only signatures;
- inactive sensors remain visible;
- correct actor occupancy produces active signature while wrong-actor identity remains visually distinct;
- the two-cell group shares one stable group token;
- closed, open-next-snapshot, occupied-closure-deferred and closed-after-vacancy variants are all distinct in monochrome signature;
- sensor underlay/group edge remains visible when occupied by an actor;
- restart restores inactive sensors and closed group.

### 8.5 Sequence 12 latch synthesis states

Retain snapshots proving:

- inactive latch shows one-shot uncommitted signature and target group token;
- first activation changes to persistent committed signature;
- the latch remains visually active on later turns;
- `barrier_phase` and `barrier_typed` receive distinct stable group tokens;
- latch target token points only to `barrier_phase`;
- phase barrier persistent-open signature is distinguishable from typed barrier temporary-open/deferral signatures;
- restart restores inactive latch and initial groups.

### 8.6 Monochrome and semantic uniqueness

Ignore all color fields and require distinct signatures for at least:

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

No required pair may collapse to the same shape/glyph/structure signature.

### 8.7 Fit, layering and v1 regression

- all descriptor bounds fit inside the existing gameplay content area for sequences 1–12;
- layer ordering matches the binding policy;
- actor occupancy does not erase sensor or barrier-edge identity;
- sequences 1–8 still load, accept their existing routes and produce no spurious v2 descriptors for absent families;
- all twelve accepted `(L*, N*)` values remain unchanged under a fresh focused batch check or the accepted Task 0024AD validator.

## 9. Evidence format

Emit independently parseable prefixed JSON records, each strictly below 1800 UTF-8 bytes. Include separate records for:

- static protected-function qualification;
- per-level descriptor inventory;
- crate states;
- key/lock/inventory states;
- typed sensor/grouped barrier states;
- latch states;
- monochrome uniqueness;
- fit/layering/v1 regression;
- summary.

The parser must reject missing, duplicate, truncated, invalid-JSON and over-bound records and retain exact byte counts.

## 10. Repeatable qualification

Before final retention, qualification is repeatable and repairable.

Every Godot run must:

- use the accepted owned-process wrapper;
- invoke cleanup exactly once after native exit;
- retain no owned or unproven PID;
- end with total Godot count zero;
- access no Profile/user-data surface;
- preserve failed attempts honestly.

Do not claim visual clarity from machine descriptors alone. Machine pass only means the mechanics are visibly represented and ready for owner judgment.

## 11. Fresh retained cycle

After static, focused and parser qualification pass, execute one retained Task 0024AF cycle containing exactly these cases, once each:

1. Task 0024AF schema-v2 visual focused validation;
   - marker `TASK_0024AF_SCHEMA_V2_MINIMUM_VISUAL_PASS`;
   - stderr empty;
2. accepted Task 0024AE isolated staging route qualification;
   - marker `TASK_0024AE_ISOLATED_STAGING_OWNER_ROUTE_PASS`;
   - stderr empty;
3. accepted Task 0024AD 1–12 batch validator;
   - marker `TASK_0024AD_SUBMISSION_CORE_1_12_BATCH_PASS`;
   - stderr empty;
4. Aggregate;
   - exact marker `TASK_0003_TESTS_PASS assertions=621 vectors=9`;
   - stderr exactly `LEVEL_ID_MISMATCH`;
5. corrected complete-v2;
   - marker `TASK_0024V_V2_COMPLETE_PASS`;
   - stderr empty.

For every case retain wrapper/native exits, exact marker count, stderr, cleanup count/order, process ownership, remaining owned/unproven PIDs, Godot before/after and bounded output.

Final Godot count must be zero. Previously consumed final cycles must not be rerun; this new manifest may invoke only their accepted focused validators. Once the Task 0024AF cycle is consumed, do not rerun it.

## 12. Required contract, report and worksheet update

Create:

```text
docs/presentation/SCHEMA_V2_MINIMUM_OWNER_REVIEW_VISUAL_CONTRACT_CURRENT.md
docs/reports/0024AF_SCHEMA_V2_MINIMUM_OWNER_REVIEW_VISUAL_PRESENTATION_REPORT.md
```

The contract must document the visual tokens, state variants, layering and non-color-only policy without claiming final art acceptance.

The report must include:

- exact changed paths and hashes;
- helper architecture and protected-function comparison;
- per-family visual contract;
- sequence 9–12 state evidence;
- monochrome uniqueness and fit/layering results;
- v1 and 1–12 regression evidence;
- retained cycle and frozen-hash evidence;
- explicit unresolved human judgment and final-art boundaries.

Update the owner worksheet only with readiness state. Do not populate subjective answers. Required language on pass:

```text
owner_route_status = MACHINE_QUALIFIED_ISOLATED_STAGING_ROUTE
owner_playthrough_status = NOT_YET_REVIEWED
presentation_readiness = MACHINE_QUALIFIED_SCHEMA_V2_MINIMUM_OWNER_REVIEW_REQUIRED
visual_art_direction_status = NOT_FINAL
catalog_admission_status = NOT_AUTHORIZED
```

## 13. Commit and push policy

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
feat: add minimum schema v2 visuals for owner review
```

## 14. Terminal verdict

Return exactly one:

```text
SCHEMA_V2_MINIMUM_OWNER_REVIEW_PRESENTATION_READY_FOR_GPT_REVIEW
BLOCKED_SCHEMA_V2_MINIMUM_OWNER_REVIEW_PRESENTATION
PROTECTED_DATA_BOUNDARY_BREACH
```

A pass authorizes only GPT review of the minimum schema-v2 presentation. It does not authorize owner subjective acceptance, final visual art acceptance, production catalog/progression/finale/Profile changes, localization, assets/audio, build/export, release, upload or submission.