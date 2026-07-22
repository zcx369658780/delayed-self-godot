# Codex active task (CURRENT)

- Status: `CORE_MECHANICS_TEST_CORRECTION_QUALIFICATION_READY_FOR_CODEX`
- Active task: `tasks/0024V_stale_schema_regression_and_complete_v2_test_correction_qualification.md`
- Closed predecessors: all Tasks through `0024U`; none may be resumed directly
- Latest GPT adjudication: `TASK_0024U_HONEST_BLOCKER_ACCEPTED_TEST_ARTIFACT_CORRECTION_REQUIRED`
- Required start commit: `58248f545c128a80e0fd8f3c983f5c4e813be806`
- Task publication commit: `538c79f01aef6163c7a4ecbeddc7b829d8ff7e45`
- Accepted wrapper implementation/blob: `7c0712d6a602dc23200ccb147d0096acc6333305` / `5f14eb0feff903b40311c1c7283b20e2eabbffc2`
- Provisional foundation implementation: `fdaf2b81fc71c60e4b3548422be94953146f25f4`
- Historical 0024T seal SHA-256: `c9f7f2eb1f781280bc9d4a778367da2cde2dfc805ce20578c42098e9bb3caf29`
- Historical 0024U seal SHA-256: `2e2ca41e22f54f73b4566125991e2b1ec47dd4a8d052a7a96b6c51028e4e49ed`
- Implemented product baseline: exactly eight formal levels

Task 0024U is accepted as an honest terminal blocker, not as foundation acceptance. Its lifecycle, cleanup, process isolation, frozen-hash and protected-boundary evidence passed. The remaining blockers are validation-artifact defects: one stale aggregate assertion still treats supported schema v2 as unsupported, and the immutable historical complete-v2 test has 15 Godot 4.7.1 type-inference parse errors.

Task 0024V is a repeatable correction/qualification gate. It may correct only the stale unsupported-version probe in `tests/run_all.gd`, create a new semantically equivalent complete-v2 test with explicit typing, and build bounded static/runtime qualification evidence. It must not modify product implementation, historical 0024T/0024U evidence, create a seal, create or invoke a final driver, or claim foundation acceptance.

Sequence 9–12, catalog/finale/Profile changes, Gameplay/UI, presentation, localization, assets/fonts/audio, build/export, release, upload and submission remain closed.
