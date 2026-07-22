# Submission-core 9–12 playtest route audit (CURRENT)

- Task: `0024AD`
- Audit mode: read-only source inspection; no interactive gameplay launch
- Selected classification: `ISOLATED_STAGING_CATALOG_REQUIRED`
- Production Profile/user-data access: none
- Test-profile-root access or enumeration: none

## Decision

The existing `--level-id=<id>` route is not sufficient for sequences 9–12. `DelayedSelfRouteRequest.parse_user_args()` accepts only an ID; `DelayedSelfAppRoot.boot_with_user_args()` passes it to `_route_level_id()`, which always resolves through `_entry_by_id()`. The production catalog has eight entries and no candidate IDs, so the route rejects sequences 9–12 as `APP_UNKNOWN_LEVEL_ID`.

A direct `vertical_slice.gd`/Gameplay launcher would load a level but bypass catalog validation, ordered unlocks, completion recording, finale acknowledgment and Profile behavior. It therefore cannot support the requested full-curriculum owner review.

The minimum later route is a **test-owned 12-entry staging catalog plus a test-owned launcher that configures AppRoot before it enters the tree**. No product injection seam is presently required because `AppRoot.catalog_path` and `AppRoot.configure_test_profile()` already provide the necessary pre-tree seams.

## Inspected product route

| Responsibility | Exact file / scene / function | Observed contract |
|---|---|---|
| Main scene | `project.godot`; `scenes/app/app_root.tscn` | Main scene instantiates `AppRoot` and `RouteHost`. |
| Catalog selection | `scripts/app/app_root.gd`: exported `catalog_path`; `boot_with_user_args()` | Loads exactly the configured catalog through `CatalogLoader.load_file()`. |
| Catalog parsing/validation | `scripts/app/catalog_loader.gd`: `load_file()`, `validate_dict()`, `_validate_level_path()` | Requires ordered entries, valid prerequisites and exactly one `final_level=true`; repository level paths are validated. |
| CLI direct request | `scripts/app/route_request.gd`: `parse_user_args()` | Parses one `--level-id=` only; it does not accept a level path or dictionary. |
| Level-select handoff | `scripts/app/app_root.gd`: `_show_level_select()`, `select_level()`, `_route_level_id()`, `_entry_by_id()` | Selection and development-direct ID both require a catalog entry; normal selection additionally requires `_progress.is_unlocked()`. |
| Gameplay scene | `scenes/vertical_slice/vertical_slice.tscn`; `scripts/gameplay/vertical_slice.gd`: `configure_route_payload()`, `_ready()` | AppRoot passes catalog-derived ID/path/HUD/classification/final flag; Gameplay loads through `LevelLoader.load_file()` and rejects ID mismatch. |
| Runtime/completion | `scripts/gameplay/vertical_slice.gd`: `_unhandled_input()`, `gameplay_completed` signal, `is_final_acknowledgement_visible()` | Simulation drives turns; hosted completion emits ID/turns. The catalog-derived final flag controls the acknowledgment. |
| Completion return | `scripts/app/app_root.gd`: `_on_gameplay_completed()` | Records once; non-final completion returns to Level Select, while a final room remains on the acknowledgment route. |
| Memory unlocks | `scripts/app/memory_progress.gd`: `_init()`, `is_unlocked()`, `record_completion()` | Uses catalog prerequisites and stores completion/best turns in memory only. |
| Profile hydration/progression | `scripts/app/profile_progress_adapter.gd`: `configure()`, `load_profile()`, `prepare_completion()`, `commit_profile()` | Validates the active catalog facts and applies catalog-bound completion/unlock state. |
| Profile path policy | `scripts/app/local_profile.gd`: `validate_test_profile_path()`, `configure_test()`, `configure_production()`, `load_profile()`, `persist_profile()` | Production target is `user://delayed_self_profile.json`; canonical tests must be below `user://delayed_self_test_profiles/<fixture>/delayed_self_profile.json`. |
| App Profile composition | `scripts/app/app_root.gd`: `configure_test_profile()`, `configure_production_profile()`, `_boot_configured_profile()`, `_record_configured_completion()` | Configuration must happen before tree entry/boot. Configured completions can persist; unconfigured mode uses memory only. |

## Existing route answers

1. **Existing direct level-path/dictionary route:** none. Gameplay has a pre-tree route-payload method, but AppRoot exposes only catalog-backed ID navigation.
2. **Can actual gameplay use an isolated Profile without product changes?** Yes, if a later test-owned launcher instantiates AppRoot, sets a test-owned staging `catalog_path`, calls `configure_test_profile()` with the exact canonical path, then adds AppRoot to the tree.
3. **Can the current production catalog launch 9–12 by CLI?** No. `--level-id=` does not bypass `_entry_by_id()`.
4. **Can memory-only mode avoid persistence?** Yes, but it does not exercise the Profile route requested for the full owner-review path. The selected route therefore uses an exact isolated test Profile.

## Profile write-risk map

- Calling `configure_production_profile("WRITE_ON_INTENT")` before boot targets `user://delayed_self_profile.json`; later completion can call `LocalProfile.persist_profile()`. A test launcher must never call this method.
- Calling `configure_test_profile()` with anything other than the exact canonical test path is rejected. The launcher must assert its returned mode/status before tree entry.
- After a configured completion, `AppRoot._record_configured_completion()` calls `ProfileProgressAdapter.prepare_completion()`, then `LocalProfile.persist_profile()`, then `commit_profile()`. The exact configured target therefore determines the write boundary.
- Omitting both configuration calls uses `MemoryProgress`; no disk persistence occurs, but that mode is insufficient to validate isolated Profile progression.
- Reusing production `app_root.tscn` without pre-tree configuration boots memory-only; adding production configuration would enter the protected production surface and is forbidden.

## Minimum safe later implementation

The later launcher should:

1. instantiate `res://scenes/app/app_root.tscn` without adding it to the tree;
2. set `catalog_path` to a test-only 12-entry staging catalog whose entries point to the existing twelve level JSON files, preserve sequences/prerequisites, and mark only sequence 12 final **within the staging catalog**;
3. call `configure_test_profile("user://delayed_self_test_profiles/task_0024ae_owner_curriculum/delayed_self_profile.json")` and require `APP_TEST_PROFILE_CONFIGURED`;
4. add AppRoot to the tree and exercise the normal Main Menu → Level Select → Gameplay → completion → unlock/finale route;
5. expose bounded session snapshots proving mode `TEST_PROFILE`, the exact target identity, ordered unlocks and final acknowledgment;
6. never call `configure_production_profile()`, never read/inspect the production path, and never enumerate the test-profile root;
7. clean only the exact owned fixture file and its exact transaction siblings after explicit identity checks.

No supported launch command exists yet because this task deliberately did not create the launcher or staging catalog. A later task must define and qualify its own command before any owner session.

### Exact proposed next-task allowlist

Only a separately authorized successor may create or modify these paths:

```text
tests/playtest/task_0024ae_submission_core_owner_review_launcher.gd
tests/playtest/fixtures/task_0024ae_submission_core_staging_catalog.json
tests/tools/task_0024ae_owner_review_route_static_qualification.ps1
tests/tools/task_0024ae_owner_review_route_manifest.json
tests/tools/task_0024ae_owner_review_route_runner.ps1
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

Production code, scenes, catalog, levels, schemas, Simulation, solver and Profile implementation are intentionally absent from this allowlist.

## Rollback and zero-production-data verification

- Before launch, assert AppRoot is outside the tree, `catalog_path` is the exact staging resource, and `configure_test_profile()` returns `APP_TEST_PROFILE_CONFIGURED` / `TEST_PROFILE`.
- Record the public Profile session snapshot and require test mode; fail closed before gameplay if it differs.
- Never query existence, size, time, hash or contents of `user://delayed_self_profile.json`; zero-production access is proved by composition, exact target binding and code-path assertions, not by probing protected data.
- Retain exact intended test file/sibling identities before cleanup; do not list or enumerate `user://delayed_self_test_profiles/`.
- Roll back by removing only the exact owned fixture file and its exact known transaction siblings after canonical path checks. If any identity is unproven, stop without broad cleanup.
- Re-run only static Git/hash checks permitted by that future task to prove production catalog/code/levels/Profile implementation are byte-identical; do not infer Profile-data equality from inaccessible protected content.

## Presentation blocker

The current `scripts/gameplay/vertical_slice.gd::_draw()` visibly draws terrain, v1 Plates/Doors, actors and EXIT. It has no visible rendering for schema-v2 crates, keys/locks, typed sensors, grouped barriers or latches. Sequences 9–12 may be mechanically routable under a staging catalog, but an owner cannot fairly judge their clarity or usability in the present presentation. This is the largest unresolved human-review blocker and does not authorize presentation work under Task 0024AD.

## Boundary

`ISOLATED_STAGING_CATALOG_REQUIRED` is a route recommendation, not an implemented launcher, an owner playthrough, catalog admission, finale/Profile migration or product acceptance.
