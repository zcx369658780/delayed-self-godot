# Task 0024V test correction qualification report

- Verdict: `CORE_MECHANICS_TEST_CORRECTION_QUALIFIED_FOR_GPT_REVIEW`
- Gate: repeatable test-contract correction and qualification; no seal and no final driver
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Startup and qualification baseline HEAD: `5cd82fbc742bfe2664ea0b0b0df6d48bc8dd717a`
- Startup `origin/main`: `5cd82fbc742bfe2664ea0b0b0df6d48bc8dd717a`
- Startup divergence: `0/0`; worktree and staged set were clean
- Required commit `58248f545c128a80e0fd8f3c983f5c4e813be806`: ancestor confirmed
- Accepted wrapper blob: `5f14eb0feff903b40311c1c7283b20e2eabbffc2`
- Godot: `4.7.1.stable.steam.a13da4feb`
- Final Godot process count: `0`

## Exact corrections

The aggregate correction is exactly:

```diff
-	value = base.duplicate(true); value.schema_version = 2
+	value = base.duplicate(true); value.schema_version = 3
	_expect_code(loader.validate_dict(value), "UNSUPPORTED_SCHEMA_VERSION", "unsupported version")
```

The pre-correction SHA-256 was `fb77fec7a6cb4556a770e00a98ef032d212d08dcd4b08f5a7674f1e8f24d9ed0`; the corrected SHA-256 is `a9fb670d9c20faab005b151febebd34205ad55ea6f39b3db49a3c95456cf7303`. The semantic-equivalence helper reconstructed the current file from `HEAD:tests/run_all.gd` with that one replacement only. Expectation-call structure stayed `253 → 253`; the runtime marker contract remains `621` assertions and nine vectors.

The new complete-v2 script was derived from immutable `tests/simulation/task_0024t_v2_solver_replay_canonical_malformed.gd`. Its historical SHA-256 remains `f61e7eba9c246d0ea21c88ebff1c476c320db2e3a927e0c1eacac5244df9f4f5`; the new SHA-256 is `b3b670f160bdaa0b57773c7769fc6712543f205e4d3ef953e352f8f9da247321`. Exact transformation audit:

- 15 dynamically inferred declaration sites received explicit types: 14 `Dictionary` sites and one `bool` site.
- `TASK_0024T_V2_COMPLETE_PASS/FAIL` became `TASK_0024V_V2_COMPLETE_PASS/FAIL`.
- `TASK_0024T_CASE_FAIL` became `TASK_0024V_CASE_FAIL`.
- Fixtures, solver limits, conditions, expected literals, malformed mutations, canonical distinctions, replay logic and control flow are otherwise text-identical after line-ending and terminal-blank normalization.
- No reference to the historical incomplete 0023ZX matrix or marker exists.

## Coverage audit

All 44 required IDs occur exactly once. Missing count: `0`; duplicate count: `0`.

1. `V2_FIXTURES_PUBLIC_LOADER_ALL_FIVE`
2. `V2_RESTART_EXACT_ALL_FIVE`
3. `V2_BFS_SOLVES_ALL_FIVE_BOUNDED`
4. `V2_BFS_WITNESS_REPLAY_COMPLETES_ALL_FIVE`
5. `V2_REPLAY_COUNT_EQUALS_SHORTEST_ALL_FIVE`
6. `V2_WITNESS_REPLAY_DETERMINISTIC_ALL_FIVE`
7. `V2_CANONICAL_ID_ARRAY_ORDER_NORMALIZED`
8. `V2_CANONICAL_DISTINGUISH_CRATES`
9. `V2_CANONICAL_DISTINGUISH_REMAINING_KEYS`
10. `V2_CANONICAL_DISTINGUISH_HELD_KEYS`
11. `V2_CANONICAL_DISTINGUISH_REMOVED_LOCKS`
12. `V2_CANONICAL_DISTINGUISH_BARRIERS`
13. `V2_CANONICAL_DISTINGUISH_LATCHES`
14. `V2_CANONICAL_DISTINGUISH_PLAYER`
15. `V2_CANONICAL_DISTINGUISH_ECHOES`
16. `V2_CANONICAL_DISTINGUISH_DOORS`
17. `V2_CANONICAL_DISTINGUISH_HISTORY`
18. `V2_CANONICAL_DISTINGUISH_COMPLETION`
19. `V2_CANONICAL_EXCLUDES_TURN_INDEX`
20. `V2_YOU_ONLY_CRATE_PUSH`
21. `V2_ECHO_BLOCKED_BY_CRATE`
22. `V2_YOU_ONLY_KEY_COLLECTION`
23. `V2_SAME_TURN_MATCHING_LOCK_CONSUMPTION`
24. `V2_SENSOR_ANY_ACTOR_TYPED_ELIGIBILITY`
25. `V2_SENSOR_YOU_ONLY_TYPED_ELIGIBILITY`
26. `V2_SENSOR_ECHO_ONLY_TYPED_ELIGIBILITY`
27. `V2_SENSOR_EXPLICIT_CRATE_ELIGIBILITY`
28. `V2_GROUPED_BARRIER_NEXT_TURN_SEMANTICS`
29. `V2_OCCUPIED_CELL_DEFERS_BARRIER_CLOSURE`
30. `V2_GROUPED_BARRIER_CLOSE_AFTER_VACATE`
31. `V2_ONE_SHOT_LATCH_PERSISTS`
32. `V2_RESTART_RESETS_LATCH_IMMUTABLY`
33. `V2_MALFORMED_UNKNOWN_TOP_FIELD_ATOMIC`
34. `V2_MALFORMED_UNKNOWN_ENTITY_FIELD_ATOMIC`
35. `V2_MALFORMED_MISSING_REQUIRED_ARRAY_ATOMIC`
36. `V2_MALFORMED_DUPLICATE_IDS_ATOMIC`
37. `V2_MALFORMED_UNKNOWN_SENSOR_REFERENCE_ATOMIC`
38. `V2_MALFORMED_UNKNOWN_LATCH_REFERENCE_ATOMIC`
39. `V2_MALFORMED_INVALID_ACTIVATOR_ATOMIC`
40. `V2_MALFORMED_INVALID_KEY_TYPE_ATOMIC`
41. `V2_MALFORMED_STATIC_CELL_OVERLAP_ATOMIC`
42. `V2_MALFORMED_OUT_OF_BOUNDS_OVERLAY_ATOMIC`
43. `V2_MALFORMED_INCONSISTENT_INITIAL_BARRIER_ATOMIC`
44. `V1_STRICT_REJECTS_V2_ONLY_FIELDS`

## Static qualification

The static validator passed before every retained Godot qualification cycle and again after the passing cycle. Deterministic results:

- frozen files: `26`;
- historical 0024T repository files: `5`;
- historical 0024U repository files: `6`;
- historical external evidence files: `8`;
- coverage IDs: `44`, missing `0`, duplicates `0`;
- authorized declaration sites: `15`;
- wrapper/Godot launches by static validation: `0`;
- Godot before/after static validation: `0/0`.

## Frozen and historical repository hashes

Every listed pre-task hash equaled its post-qualification hash.

| Path | Pre SHA-256 | Post SHA-256 |
|---|---|---|
| `tests/tools/run_owned_godot_headless.ps1` | `17c03970f1a4c59d9d87a826471429fef55da75afb7b86c676bb3bdf5205afbc` | `17c03970f1a4c59d9d87a826471429fef55da75afb7b86c676bb3bdf5205afbc` |
| `docs/game_design/GAMEPLAY_SIMULATION_CONTRACT_V2_CURRENT.md` | `61e1af820ca9d7bec025aeeb28ea02b964c61e85b70d8bd44fe169762ee02e86` | `61e1af820ca9d7bec025aeeb28ea02b964c61e85b70d8bd44fe169762ee02e86` |
| `docs/level_design/LEVEL_SCHEMA_V2_CURRENT.md` | `7474e7314b13d8310e2353e750a2adf31ec0806f8a96ad8b18f5392168952299` | `7474e7314b13d8310e2353e750a2adf31ec0806f8a96ad8b18f5392168952299` |
| `docs/level_design/reference/turn_transition_vectors_v2.json` | `7aa003bf51b65e7ed9134c01ee96dae887c11e79c8ba1538099daebd386f4062` | `7aa003bf51b65e7ed9134c01ee96dae887c11e79c8ba1538099daebd386f4062` |
| `schemas/level_v2.schema.json` | `54146b644f9db246d5d43ffb4958ee1512ba5aefb0dd19d6296524ffb28a28c9` | `54146b644f9db246d5d43ffb4958ee1512ba5aefb0dd19d6296524ffb28a28c9` |
| `scripts/simulation/level_loader.gd` | `58948ec5207210a4afc6513429935291c1ac8677f0cd413ff5dd306a6274674e` | `58948ec5207210a4afc6513429935291c1ac8677f0cd413ff5dd306a6274674e` |
| `scripts/simulation/simulation.gd` | `9860feafdc16926cdc5db86768f31990d25d5c816ad2ca3d065043aaa4f03579` | `9860feafdc16926cdc5db86768f31990d25d5c816ad2ca3d065043aaa4f03579` |
| `scripts/solver/bfs_solver.gd` | `48e22a8cc0a36b7e8d14b71cb5df84487079ab6d9a083301a85c87ad4383f3bc` | `48e22a8cc0a36b7e8d14b71cb5df84487079ab6d9a083301a85c87ad4383f3bc` |
| `tests/simulation/task_0023zx_core_mechanics_foundation.gd` | `7c7a02c7fad97dd20138daf180a776f2d96ac76e55087f6e5e5e091268d4249d` | `7c7a02c7fad97dd20138daf180a776f2d96ac76e55087f6e5e5e091268d4249d` |
| `tests/levels/task_0012_staggered_doors_validation.gd` | `3ec532f06bb5c520d765040079ca0a5f54913e7223ea58461bbc95e2c54840ea` | `3ec532f06bb5c520d765040079ca0a5f54913e7223ea58461bbc95e2c54840ea` |
| `tests/simulation/fixtures/task_0023zx_crate_echo.json` | `7e888ca5a39ca76f5ff7e3ee53f0f78b5f5befc811b68817301ea3211cc4a0ef` | `7e888ca5a39ca76f5ff7e3ee53f0f78b5f5befc811b68817301ea3211cc4a0ef` |
| `tests/simulation/fixtures/task_0023zx_integration.json` | `eb16553764cb9b27809efd888e67ddd7876899cea1ca46f7197a90e94579de62` | `eb16553764cb9b27809efd888e67ddd7876899cea1ca46f7197a90e94579de62` |
| `tests/simulation/fixtures/task_0023zx_key_lock.json` | `117606037a712ea7f63eeb3a4507e7f003c790630909996fddfa9404e58c874c` | `117606037a712ea7f63eeb3a4507e7f003c790630909996fddfa9404e58c874c` |
| `tests/simulation/fixtures/task_0023zx_latch_defer.json` | `94a791cf64cf3525d299b4a4e37d657276c2f1f1cf392c40070b27bcfa96f916` | `94a791cf64cf3525d299b4a4e37d657276c2f1f1cf392c40070b27bcfa96f916` |
| `tests/simulation/fixtures/task_0023zx_sensor_barrier.json` | `3e25c4588575de6ec9e63f6d974fadf6c4e84b95eae655cf822eaa4dd6de9f12` | `3e25c4588575de6ec9e63f6d974fadf6c4e84b95eae655cf822eaa4dd6de9f12` |
| `docs/level_design/reference/turn_transition_vectors_v1.json` | `2587d33e9e13c13fd62df7e8211f41fbb73bc60c7c13c33b1d2637dc8b2ca576` | `2587d33e9e13c13fd62df7e8211f41fbb73bc60c7c13c33b1d2637dc8b2ca576` |
| `schemas/level_v1.schema.json` | `6cc9cb017facfb34d1217c7f85aee6a1e4fa86342f6d79a5552c2f893a727267` | `6cc9cb017facfb34d1217c7f85aee6a1e4fa86342f6d79a5552c2f893a727267` |
| `data/catalog/level_catalog_v1.json` | `a2bfa892f77370ac4d7e93ba5b6ce5970f0d7ba75160e1b2d00c4384f3da4e51` | `a2bfa892f77370ac4d7e93ba5b6ce5970f0d7ba75160e1b2d00c4384f3da4e51` |
| `data/levels/door_one_turn_late.json` | `1775cf89ae4a94f65a76dac2b791a31395443de88205d0ed1b6233331dbda577` | `1775cf89ae4a94f65a76dac2b791a31395443de88205d0ed1b6233331dbda577` |
| `data/levels/echo_spacing_bridge.json` | `805cdc05ea9b3805189ba7be4938cb7ede4e7056b9ae9a7e911df96a801d58ee` | `805cdc05ea9b3805189ba7be4938cb7ede4e7056b9ae9a7e911df96a801d58ee` |
| `data/levels/staggered_doors.json` | `3f14c19b50775e36dd5b52664798381cf1292b0a30b377641c03435f45696bc8` | `3f14c19b50775e36dd5b52664798381cf1292b0a30b377641c03435f45696bc8` |
| `data/levels/tutorial_echo_bridge.json` | `681d99057c4e6034a490644d75960ff23d8f43bd1b91850f48179b79fc04a3cf` | `681d99057c4e6034a490644d75960ff23d8f43bd1b91850f48179b79fc04a3cf` |
| `data/levels/tutorial_reach_exit.json` | `38e466bb5922f1987a99d79c7527a4a8eab8e6cfdbe76fd8159f80b0a40cf2c4` | `38e466bb5922f1987a99d79c7527a4a8eab8e6cfdbe76fd8159f80b0a40cf2c4` |
| `data/levels/two_echo_convergence.json` | `772410d3b8bb807e35472ee2a7d07b703de66e1e0e92ffb4d1ff8433a345d5fd` | `772410d3b8bb807e35472ee2a7d07b703de66e1e0e92ffb4d1ff8433a345d5fd` |
| `data/levels/two_keys_one_door.json` | `f4c6791dfc84d17fb450721e654091a2baeb522e55d660a5d73878cd977651cd` | `f4c6791dfc84d17fb450721e654091a2baeb522e55d660a5d73878cd977651cd` |
| `data/levels/vertical_slice_delay_3.json` | `8751da5051fbebaaa5ae7c895d9be9f086e8d8f2e87876a80c379dc06262f1d8` | `8751da5051fbebaaa5ae7c895d9be9f086e8d8f2e87876a80c379dc06262f1d8` |
| `tests/tools/task_0024t_core_mechanics_final_validation_manifest.json` | `f9e547fb8b7ca0e3fe837774599dff24f29a8de251415e97dd86a45358f92a4a` | `f9e547fb8b7ca0e3fe837774599dff24f29a8de251415e97dd86a45358f92a4a` |
| `tests/tools/task_0024t_core_mechanics_final_validation_static_validator.ps1` | `f650a011ea71d5c9ab889d621a5c1b3b622fc44d9e4cab75871aa3fb0f8fc7f1` | `f650a011ea71d5c9ab889d621a5c1b3b622fc44d9e4cab75871aa3fb0f8fc7f1` |
| `tests/tools/task_0024t_core_mechanics_final_validation.ps1` | `1f28006256a262819c7a5623295d04424f2d1c9e20a49baf201b4fcadbc61762` | `1f28006256a262819c7a5623295d04424f2d1c9e20a49baf201b4fcadbc61762` |
| `tests/simulation/task_0024t_v2_solver_replay_canonical_malformed.gd` | `f61e7eba9c246d0ea21c88ebff1c476c320db2e3a927e0c1eacac5244df9f4f5` | `f61e7eba9c246d0ea21c88ebff1c476c320db2e3a927e0c1eacac5244df9f4f5` |
| `docs/reports/0024T_COMPLETE_CORE_MECHANICS_FINAL_VALIDATION_REPORT.md` | `01feb5519beff3ae43c95a4a28331206e9e3cb4d85971f08e80d6a7558034aac` | `01feb5519beff3ae43c95a4a28331206e9e3cb4d85971f08e80d6a7558034aac` |
| `tests/tools/task_0024u_core_mechanics_final_validation_driver.ps1` | `1a78218bb038a26bec884ef6c4ee8e2339c55f48d6329174590aa837539318d1` | `1a78218bb038a26bec884ef6c4ee8e2339c55f48d6329174590aa837539318d1` |
| `tests/tools/task_0024u_core_mechanics_final_validation_manifest.json` | `bab6e48eeb2c6122f9d47692001829cfeec7fbee434192cab641d4b7551d724f` | `bab6e48eeb2c6122f9d47692001829cfeec7fbee434192cab641d4b7551d724f` |
| `tests/tools/task_0024u_core_mechanics_final_validation_static_validator.ps1` | `94386719d25d4a3c1f69aa3d1c4d66d573818a42c1020dcb40a8e81732607119` | `94386719d25d4a3c1f69aa3d1c4d66d573818a42c1020dcb40a8e81732607119` |
| `tests/tools/task_0024u_driver_precondition_qualification_summary.json` | `3455451bd763d3b7049a84dc2a8622d3d6bf9b6b6ec7b357c18b2b793c97f469` | `3455451bd763d3b7049a84dc2a8622d3d6bf9b6b6ec7b357c18b2b793c97f469` |
| `tests/tools/task_0024u_driver_precondition_qualification.ps1` | `ac5bdb87db07aea61de03ec4b2c98e176f567a34479b50ddfc18ceb72c36278d` | `ac5bdb87db07aea61de03ec4b2c98e176f567a34479b50ddfc18ceb72c36278d` |
| `docs/reports/0024U_CORRECTED_COMPLETE_CORE_MECHANICS_FINAL_VALIDATION_REPORT.md` | `653ef117d30cfaf8b50360107d5cf512edb3d05aa19be94fe949b58b2752602c` | `653ef117d30cfaf8b50360107d5cf512edb3d05aa19be94fe949b58b2752602c` |

## Historical external evidence hashes

No Task 0024T/0024U external evidence was edited, overwritten, resealed, rerun or reinterpreted.

| Evidence-relative path | Pre SHA-256 | Post SHA-256 |
|---|---|---|
| `0024T_complete_core_mechanics_final_validation/pre_execution_seal.json` | `c9f7f2eb1f781280bc9d4a778367da2cde2dfc805ce20578c42098e9bb3caf29` | `c9f7f2eb1f781280bc9d4a778367da2cde2dfc805ce20578c42098e9bb3caf29` |
| `0024U_corrected_complete_core_mechanics_final_validation/attempt_record.json` | `4d6d7fdccd18c390ee9aa0b6bd0ae97ef5f44c742ace4063731642c12121424e` | `4d6d7fdccd18c390ee9aa0b6bd0ae97ef5f44c742ace4063731642c12121424e` |
| `0024U_corrected_complete_core_mechanics_final_validation/case_aggregate_v1_formal_regression.json` | `81d44a8b0de41a073091b62db2dd877b9ae4abb04081e7ed5bda0d85c5e481ba` | `81d44a8b0de41a073091b62db2dd877b9ae4abb04081e7ed5bda0d85c5e481ba` |
| `0024U_corrected_complete_core_mechanics_final_validation/case_task_0012_standalone_regression.json` | `760d5b0f408e2629d958b6bdf8a8e70a5a9af8f3f7d17b1ee3049615403b8ca5` | `760d5b0f408e2629d958b6bdf8a8e70a5a9af8f3f7d17b1ee3049615403b8ca5` |
| `0024U_corrected_complete_core_mechanics_final_validation/case_v2_complete_solver_replay_canonical_malformed.json` | `6584d7954e55b9c12b90586c57d25dd72935b7ebce3c0a4701f7bbc0164c3913` | `6584d7954e55b9c12b90586c57d25dd72935b7ebce3c0a4701f7bbc0164c3913` |
| `0024U_corrected_complete_core_mechanics_final_validation/case_v2_focused_foundation.json` | `8111136a62fc907d5122405e8c069bd8fc28edde7b18e4c1d3752c526f6fe5cb` | `8111136a62fc907d5122405e8c069bd8fc28edde7b18e4c1d3752c526f6fe5cb` |
| `0024U_corrected_complete_core_mechanics_final_validation/final_summary.json` | `69f11128b97b1f4fa9bfb0fbcd30d91fd541be12dd986e40cccb185145a391e2` | `69f11128b97b1f4fa9bfb0fbcd30d91fd541be12dd986e40cccb185145a391e2` |
| `0024U_corrected_complete_core_mechanics_final_validation/pre_execution_seal.json` | `2e2ca41e22f54f73b4566125991e2b1ec47dd4a8d052a7a96b6c51028e4e49ed` | `2e2ca41e22f54f73b4566125991e2b1ec47dd4a8d052a7a96b6c51028e4e49ed` |

## Qualification cycles

Two runner invocations are recorded under `D:\Delayed_Self_Evidence\0024V_test_correction_qualification`.

### Cycle 001 — harness record lifecycle failure

The first invocation created `cycle_001` but returned without retaining a case record or final summary. It is recorded honestly as `HARNESS_TERMINATED_WITHOUT_RETAINED_SUMMARY`; whether a case began is `UNPROVEN` and no result is claimed. Godot was observed at zero after the invocation. The repair stayed within the authorized qualification runner and added immediate `STARTED`, static-pass and per-case progress checkpoints. Repetition is explicitly allowed by Task 0024V.

Recovered record SHA-256: `d97f20d32531f92bcf284968cf84f78a4a980cdc7ccecf252e13c59009b226e2`.

### Cycle 002 — qualified pass

| Case | Wrapper/native exit | Marker | Stderr | Cleanup | Godot before/after | Residual owned/unproven | Result |
|---|---|---|---|---:|---:|---:|---|
| Aggregate | `0/0` | exact `TASK_0003_TESTS_PASS assertions=621 vectors=9`, once | exact allowlist: `LEVEL_ID_MISMATCH` | 1 | `0/0` | `0/0` | PASS |
| complete-v2 | `0/0` | exact `TASK_0024V_V2_COMPLETE_PASS`, once | empty / `ForbidNonempty` | 1 | `0/0` | `0/0` | PASS |

No unrelated process was touched. Each wrapper case classified one direct owned Godot PID, invoked cleanup exactly once, and ended with no owned or unproven PID. Post-cycle static validation passed and final Godot count was zero.

Evidence hashes:

- `cycle_002/case_aggregate.json`: `463ccc4d373f97c5239e3576ca51232987f7c639bd9171bf81d3da9138185171`
- `cycle_002/case_complete_v2.json`: `b5b84ec62a0dee80847f3261e093185b2dc6f84bf40c9680bee6e616970c0dd1`
- `cycle_002/qualification_summary.json`: `7635d3b6872c9105526c182f804556a9344125e5715df6ff7af1294abdcdd21b`

## Changed-path audit

The final repository change set is limited to these Task 0024V-authorized paths:

- `tests/run_all.gd`
- `tests/simulation/task_0024v_v2_solver_replay_canonical_malformed.gd`
- `tests/tools/task_0024v_test_correction_baseline.json`
- `tests/tools/task_0024v_test_correction_equivalence.py`
- `tests/tools/task_0024v_test_correction_qualification.ps1`
- `tests/tools/task_0024v_test_correction_static_validator.ps1`
- `docs/reports/0024V_TEST_CORRECTION_QUALIFICATION_REPORT.md`
- `docs/CODEX_ACTIVE_TASK_CURRENT.md`
- `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`
- `docs/DEVELOPMENT_PLAN_CURRENT.md`
- `docs/DOC_INDEX_CURRENT.md`
- `docs/HANDOFF_MASTER_CURRENT.md`
- `docs/project_memory.md`
- `docs/project_memory/HEADLESS_GODOT_TEST_PROCESS_LIFECYCLE_FAILURE_AND_POLICY_CURRENT.md`
- `docs/production/EXPANDED_CONTENT_SUBMISSION_ROADMAP_CURRENT.md`

No loader, Simulation, BFS solver, schema, vector, fixture, catalog, formal level, UID, Profile/user data, Gameplay/UI, project setting, asset, audio, localization, build/export, release or submission path changed. Production Profile content/metadata/siblings, ordinary user data and the test-profile root were not accessed.

## Scope and remaining uncertainty

This result qualifies only the corrected validation artifacts for GPT review. No seal was created, no final driver was created or invoked, and no foundation acceptance occurred. Historical Task 0024T/0024U one-shot budgets remain consumed and their evidence remains immutable.

A separate Task 0024W may design a new manifest/seal/final-validation gate only after GPT acceptance. Sequence 9–12, catalog/finale/Profile migration, Gameplay/UI, presentation, localization, assets/fonts/audio, build/export, release, upload and submission remain closed.
