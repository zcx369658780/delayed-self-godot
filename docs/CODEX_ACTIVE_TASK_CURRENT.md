# Codex active task (CURRENT)

- Status: `CORE_MECHANICS_TEST_CORRECTION_QUALIFIED_FOR_GPT_REVIEW`
- Active task: `tasks/0024V_stale_schema_regression_and_complete_v2_test_correction_qualification.md`
- Closed predecessors: all Tasks through `0024U`; none may be resumed directly
- Latest completed Codex verdict: `CORE_MECHANICS_TEST_CORRECTION_QUALIFIED_FOR_GPT_REVIEW`
- Required start commit: `58248f545c128a80e0fd8f3c983f5c4e813be806`
- Task publication commit: `538c79f01aef6163c7a4ecbeddc7b829d8ff7e45`
- Accepted wrapper implementation/blob: `7c0712d6a602dc23200ccb147d0096acc6333305` / `5f14eb0feff903b40311c1c7283b20e2eabbffc2`
- Provisional foundation implementation: `fdaf2b81fc71c60e4b3548422be94953146f25f4`
- Historical 0024T seal SHA-256: `c9f7f2eb1f781280bc9d4a778367da2cde2dfc805ce20578c42098e9bb3caf29`
- Historical 0024U seal SHA-256: `2e2ca41e22f54f73b4566125991e2b1ec47dd4a8d052a7a96b6c51028e4e49ed`
- Implemented product baseline: exactly eight formal levels

Task 0024V corrected the stale aggregate probe from supported schema version 2 to unsupported version 3 and created a semantically equivalent complete-v2 test with explicit types at all 15 historical parse sites. Static validation proves the aggregate's one-line logical diff, unchanged 253 expectation-call structure and 621 runtime assertion contract, all 44 complete-v2 coverage IDs exactly once, and exact frozen/historical hashes.

Qualification cycle 001 is honestly retained as an unproven harness-record lifecycle failure. After an authorized progress-checkpoint repair, cycle 002 passed Aggregate at 621 assertions with exact `LEVEL_ID_MISMATCH` stderr and passed complete-v2 with empty stderr. Each wrapper case invoked cleanup once, left no owned/unproven PID and ended at zero Godot. Read `docs/reports/0024V_TEST_CORRECTION_QUALIFICATION_REPORT.md`.

Task 0024V created no seal or final driver and does not accept the foundation. Await GPT review. Only a new explicit Task 0024W may authorize design/execution of another manifest/seal/final-validation gate.

Sequence 9–12, catalog/finale/Profile changes, Gameplay/UI, presentation, localization, assets/fonts/audio, build/export, release, upload and submission remain closed.
