# Task 0024AE — Implement and qualify the isolated staging catalog owner-review route

- Status: `READY`
- Gate: `TEST-OWNED STAGING CATALOG / ISOLATED PROFILE / NORMAL APP ROUTE QUALIFICATION`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Required accepted checkpoint: `30b40ea75ac53a4e8447e27238f54dbe5ef77b1f`
- Accepted Task 0024AD result commit: `b3e8da670925da3a5a106b13f0e85d13c8c474cf`
- Accepted route classification: `ISOLATED_STAGING_CATALOG_REQUIRED`
- Latest GPT verdict: `TASK_0024AD_SUBMISSION_CORE_1_12_BATCH_REGRESSION_AND_OWNER_ROUTE_AUDIT_ACCEPTED`
- Formal product baseline: exactly eight production-catalog levels; sequence 8 remains the sole formal finale
- Accepted uncatalogued candidates: `crate_shadow_timing`, `key_route_commitment`, `identity_shift_bridge`, `lasting_echo_latch`
- Recommended Codex model: `GPT-5.6 Sol Max`; fallback `GPT-5.6 Sol High`

## 1. Objective

Implement the minimum test-owned route selected by Task 0024AD:

1. one isolated twelve-entry staging catalog;
2. one test-owned launcher that configures AppRoot before tree entry;
3. one exact isolated test Profile fixture path;
4. machine qualification of normal catalog → selection → Gameplay → completion → ordered unlock → staging-finale behavior;
5. exact rollback and zero-production-data evidence.

This task establishes only route readiness. It must not perform or claim owner subjective playthrough acceptance. The known schema-v2 presentation blocker remains open.

## 2. Binding route architecture

Use the existing product seams without modifying product code:

- instantiate `res://scenes/app/app_root.tscn` while it is outside the tree;
- set exported `catalog_path` to the test-owned staging catalog;
- call `configure_test_profile()` with exactly:

```text
user://delayed_self_test_profiles/task_0024ae_owner_curriculum/delayed_self_profile.json
```

- require `ok=true`, `status=APP_TEST_PROFILE_CONFIGURED`, `mode=TEST_PROFILE` before tree entry;
- add AppRoot to the tree only after both catalog and Profile configuration are fixed;
- use normal AppRoot catalog-backed routing, Gameplay scene creation, completion handling, unlock progression and final acknowledgement.

Never call `configure_production_profile()`. Never read, query, enumerate, stat, hash or inspect `user://delayed_self_profile.json` or its siblings. Never enumerate `user://delayed_self_test_profiles/`.

## 3. Startup gate

Before editing or launching Godot:

1. require root `D:\Delayed_Self`, branch `main`, expected origin and no Git operation in progress;
2. fetch and fast-forward only;
3. require `HEAD == origin/main`, divergence `0/0`, ancestry of `30b40ea75ac53a4e8447e27238f54dbe5ef77b1f` and a clean worktree;
4. require zero pre-existing Godot processes; never close unknown or pre-existing processes;
5. require Godot `4.7.1.stable.steam.a13da4feb` and accepted wrapper blob `5f14eb0feff903b40311c1c7283b20e2eabbffc2`;
6. read `AGENTS.md`, current startup/active docs, this task, Task 0024AD report/matrix/route audit/GPT acceptance, Task 0024AC acceptance, the headless lifecycle policy, catalog loader, AppRoot, LocalProfile, ProfileProgressAdapter, MemoryProgress, RouteRequest and Gameplay route code;
7. record exact hashes for production catalog, all twelve level files, AppRoot/catalog/Profile/gameplay route files, accepted 9–12 evidence and Task 0024AD artifacts;
8. stop on remote drift, dirty state, process ambiguity, accepted-artifact drift, route-code drift or any need to inspect production user data.

## 4. Authorized repository paths

Create or modify only:

```text
tests/playtest/task_0024ae_submission_core_owner_review_launcher.gd
tests/playtest/task_0024ae_submission_core_owner_review_launcher.gd.uid
tests/playtest/fixtures/task_0024ae_submission_core_staging_catalog.json
tests/tools/task_0024ae_owner_review_route_static_qualification.ps1
tests/tools/task_0024ae_owner_review_route_manifest.json
tests/tools/task_0024ae_owner_review_route_runner.ps1
tests/tools/task_0024ae_*.json
tests/tools/task_0024ae_*.py
docs/playtest/SUBMISSION_CORE_1_12_OWNER_CURRICULUM_REVIEW_CURRENT.md
docs/reports/0024AE_SUBMISSION_CORE_OWNER_REVIEW_ROUTE_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/production/EXPANDED_CONTENT_SUBMISSION_ROADMAP_CURRENT.md
```

No other path may change. A generated UID is allowed only for the new launcher script.

## 5. Frozen and protected surfaces

Do not modify:

```text
data/catalog/**
data/levels/**
scripts/app/**
scripts/gameplay/**
scripts/simulation/**
scripts/solver/**
scenes/**
project.godot
schemas/**
tests/run_all.gd
tests/simulation/**
tests/levels/**
tests/curriculum/task_0024ad_submission_core_1_12_batch_validation.gd
tests/tools/run_owned_godot_headless.ps1
accepted Task 0024T–0024AD evidence
localization/**
assets/**
audio/**
build/export/release/submission surfaces
```

Production Profile content/metadata/siblings, ordinary user data and the test-profile root are protected runtime surfaces. The task may create and remove only the exact owned fixture file and exact known transaction siblings inside the fixed Task 0024AE fixture directory.

## 6. Staging catalog contract

Create:

```text
tests/playtest/fixtures/task_0024ae_submission_core_staging_catalog.json
```

Requirements:

- `catalog_version = 1`;
- exactly twelve ordered entries;
- sequences and IDs exactly match the accepted 1–12 manifest;
- sequences 1–7 preserve the production entry fields exactly;
- sequence 8 preserves all production fields except staging-only `final_level=false`;
- append:

```text
9  crate_shadow_timing
10 key_route_commitment
11 identity_shift_bridge
12 lasting_echo_latch
```

- candidate level paths point to the accepted existing JSON files;
- prerequisite chain is exactly 8→9→10→11→12;
- sequences 9–12 use nonempty stable `display_title_key`, `classification` and `hud_mode` fields accepted by CatalogLoader;
- sequence 12 alone has `final_level=true` in the staging catalog;
- exactly one staging final level;
- no production catalog file changes;
- no staging catalog field claims production admission or Profile migration.

The static qualification must compare the production first eight entries semantically and report the sole allowed staging difference on sequence 8.

## 7. Launcher contract

Create:

```text
tests/playtest/task_0024ae_submission_core_owner_review_launcher.gd
```

The launcher must:

1. instantiate AppRoot outside the tree;
2. assert it is not inside the tree and boot has not started;
3. assign the exact staging `catalog_path`;
4. configure the exact canonical Task 0024AE test Profile path;
5. fail closed unless configuration returns the exact accepted status/mode;
6. add AppRoot to the tree only after configuration succeeds;
7. retain a bounded public session snapshot showing `TEST_PROFILE`, exact catalog identity and no production-write authorization;
8. support a machine-qualification mode and a later interactive owner-review mode under the same test-owned route;
9. never call production Profile configuration;
10. never inspect protected production data or enumerate test directories.

### 7.1 Machine-qualification mode

Use one explicit launcher-only flag, for example:

```text
--task-0024ae-route-qualification
```

In this mode, the launcher must deterministically prove the route without subjective playtesting:

- boot the staging catalog with the exact isolated Profile;
- require twelve validated catalog entries and sequence 12 as the staging-only final;
- require a clean/missing test Profile boot state or a task-owned known state;
- prove initial unlock state contains sequence 1 and does not prematurely unlock later rooms;
- for sequences 1–12 in order, use normal catalog-backed `select_level()` routing;
- require the active route is Gameplay and route payload ID/path/final flag match the staging entry;
- simulate only the completion signal plumbing from the active Gameplay instance after the room's machine-accepted turn count; do not claim this is a human solution replay;
- require AppRoot's normal completion handler persists to the exact test Profile and unlocks the next sequence;
- require non-final rooms return to Level Select;
- require sequence 12 retains the final acknowledgement route and does not unlock a sequence 13;
- require completed IDs and best-turn keys match all twelve entries after the ordered route;
- create a second independently configured AppRoot session against the same exact fixture and prove persisted progress reloads correctly;
- never use development-direct routing to bypass unlock checks in the ordered progression proof.

The route proof supplements, but does not replace, the accepted 1–12 solver/replay evidence.

### 7.2 Later interactive mode

When the qualification flag is absent, the launcher may leave the configured AppRoot running for later owner use and pass normal `--level-id=` arguments through the staging catalog. It must display or log a clear test/staging identity and the exact isolated fixture path without exposing production data.

Task 0024AE must not conduct the owner session. The current v2 visual presentation limitation must be stated prominently in the report and worksheet.

## 8. Profile boundary and cleanup contract

Before any runtime write:

- bind the exact fixture path as a constant;
- precompute only exact known owned sibling paths used by LocalProfile transaction semantics;
- reject any path that is not under the exact Task 0024AE fixture directory;
- do not list directories or discover siblings dynamically;
- do not inspect production Profile existence or metadata.

After qualification:

- retain the final task-owned Profile/session evidence needed for the report;
- remove only the exact fixture and exact known transaction siblings after identity checks;
- require all exact owned fixture paths absent after cleanup;
- if any identity is ambiguous, stop without broad cleanup;
- record that zero production-data probes occurred.

## 9. Static qualification

Before launching Godot, create and run a deterministic static qualification that proves:

1. staging catalog has exactly twelve entries and one final;
2. exact IDs, paths, sequences and prerequisite chain;
3. production catalog hash is unchanged;
4. accepted twelve level hashes are unchanged;
5. launcher configures test Profile before tree entry;
6. launcher contains the exact canonical test path;
7. launcher contains no call to `configure_production_profile`;
8. launcher contains no production Profile path literal or broad directory enumeration API;
9. launcher uses the exact staging catalog path;
10. cleanup targets are fixed and bounded;
11. no product file appears in the changed-path set.

The static qualification result must be machine-readable and committed.

## 10. Repeatable route qualification

Before the retained final cycle, route qualification is repeatable and repairable.

Every qualification execution must:

- use the accepted owned-process wrapper;
- invoke cleanup exactly once after native exit;
- retain no owned or unproven PID;
- end with total Godot count zero;
- clean only exact Task 0024AE fixture paths;
- record route, catalog, test-profile, unlock, completion, reload, finale and cleanup facts;
- preserve failed attempts honestly.

The launcher output must use independently parseable JSON records below 1800 UTF-8 bytes. Include separate records for configuration, catalog, per-sequence route/completion, persisted reload, staging finale, boundary and cleanup. The parser must reject missing, duplicate, truncated, invalid-JSON and over-bound records.

Required pass marker:

```text
TASK_0024AE_ISOLATED_STAGING_OWNER_ROUTE_PASS
```

Failure prefix:

```text
TASK_0024AE_ISOLATED_STAGING_OWNER_ROUTE_FAIL
```

## 11. Fresh retained cycle

After static and repeatable route qualification pass, execute one retained Task 0024AE cycle containing exactly these cases, once each:

1. Task 0024AE isolated staging route qualification;
   - marker `TASK_0024AE_ISOLATED_STAGING_OWNER_ROUTE_PASS`;
   - stderr empty;
2. accepted Task 0024AD 1–12 batch validator;
   - marker `TASK_0024AD_SUBMISSION_CORE_1_12_BATCH_PASS`;
   - stderr empty;
3. Aggregate;
   - exact marker `TASK_0003_TESTS_PASS assertions=621 vectors=9`;
   - stderr exactly `LEVEL_ID_MISMATCH`;
4. corrected complete-v2;
   - marker `TASK_0024V_V2_COMPLETE_PASS`;
   - stderr empty.

For every case retain wrapper/native exits, exact marker count, stderr, cleanup count/order, process ownership, remaining owned/unproven PIDs, Godot before/after and bounded output.

Final Godot count must be zero. The Task 0024AD retained cycle must not be rerun; this task runs only its accepted focused batch validator under a new Task 0024AE manifest. Once the new cycle is consumed, do not rerun it.

## 12. Required report and worksheet update

Create:

```text
docs/reports/0024AE_SUBMISSION_CORE_OWNER_REVIEW_ROUTE_REPORT.md
```

The report must include:

- exact changed paths and hashes;
- staging catalog identity and semantic comparison with production catalog;
- launcher architecture and static qualification;
- exact test Profile binding and zero-production-data composition proof;
- ordered 1–12 route, unlock, completion, persistence reload and staging-finale facts;
- exact cleanup evidence;
- retained cycle evidence;
- frozen-hash audit;
- explicit unresolved presentation blocker.

Update the owner worksheet only to record route state. Do not populate subjective room answers. Required status language:

```text
owner_route_status = MACHINE_QUALIFIED_ISOLATED_STAGING_ROUTE
owner_playthrough_status = NOT_YET_REVIEWED
presentation_readiness = BLOCKED_SCHEMA_V2_VISUALS
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
test: qualify isolated staging owner review route
```

## 14. Terminal verdict

Return exactly one:

```text
ISOLATED_STAGING_OWNER_REVIEW_ROUTE_READY_FOR_GPT_REVIEW
BLOCKED_ISOLATED_STAGING_OWNER_REVIEW_ROUTE
PROTECTED_DATA_BOUNDARY_BREACH
```

A pass authorizes only GPT review of the test-owned staging route. It does not authorize owner subjective acceptance, production catalog/progression/finale/Profile changes, schema-v2 presentation work, localization, assets/audio, build/export, release, upload or submission.