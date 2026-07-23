# Codex startup snapshot (CURRENT)

- Status: `CURRENT / TASK 0024AN READY / USER-SCOPE CREDENTIAL WRAPPER CORRECTION PENDING`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Active task: `tasks/0024AN_deepseek_user_scope_credential_wrapper_and_project_pilot_continuation.md`
- Active status: `TASK_0024AN_READY`
- Task publication commit: `38edf9d2c9cecd908ad6258b4b45973bf27e6857`
- Active-pointer commit: `f09f098c296fd8a4fc9415a4f3e43b2f3b6060f8`
- Superseded attempted task: `0024AM`
- Superseded blocker: `BLOCKED_BEFORE_WRITE_INVALID_PROCESS_ENVIRONMENT_PREFLIGHT`
- Required predecessor checkpoint in ancestry: `22c38d33275d737bd6bb5327cf7930a53260ac70`
- Previous GPT gameplay acceptance: `TASK_0024AL_PROCESS_ISOLATED_WRITE_AHEAD_SCHEMA_V2_MINIMUM_OWNER_REVIEW_PRESENTATION_ACCEPTED`
- User-level external-worker baseline: `ACCEPTED_FOR_USER_LEVEL_CLI_FALLBACK_PILOT`
- Project-level DeepSeek gate: `NOT_YET_EXECUTED_WITH_CORRECT_CREDENTIAL_BRIDGE`
- Authorized DeepSeek transport: `USER-SCOPE WRAPPER → CLI FALLBACK`
- Required GPT ownership: planning, architecture, wrapper/config design, review, validation, Git and final acceptance remain with `GPT-5.6 Sol/Terra`
- Production baseline: exactly eight cataloged levels; sequence 8 remains the sole formal finale
- Owner route: `MACHINE_QUALIFIED_ISOLATED_STAGING_ROUTE`
- Owner playthrough: `NOT_YET_REVIEWED`
- Presentation: `MACHINE_QUALIFIED_SCHEMA_V2_MINIMUM_OWNER_REVIEW_REQUIRED`
- Catalog admission: `NOT_AUTHORIZED`

Before Task 0024AN work, fetch and fast-forward to current `origin/main`. Require `HEAD == origin/main`, divergence `0/0`, no tracked/staged changes, and only the pre-existing untracked `.codex/config.toml`. Require its SHA-256 `d4c670da3c2404921a1ab177f4e5405449bc8321d713cc0b42b8046201fd33cc` without exposing contents. Require Godot count zero and do not launch Godot.

Do not use `$env:DEEPSEEK_API_KEY` absence as a blocker. Codex shell filtering may intentionally remove variables whose names contain `KEY`, `SECRET`, or `TOKEN` from ordinary child-process environments. The authoritative presence check is Windows User scope, performed without revealing any credential metadata.

Task 0024AN must inspect and create or repair:

```text
C:\Users\zcxve\.codex\helpers\Invoke-DeepSeekFileTask.ps1
```

The wrapper reads the key through `[Environment]::GetEnvironmentVariable(..., User)`, injects it only into Process scope around the one accepted Python worker child, and clears it in `finally`. Every project DeepSeek invocation must use the wrapper. Direct Python invocation is prohibited for the real smoke.

Do not set `ignore_default_excludes = true`; do not weaken `shell_environment_policy`; do not modify user-level Codex config, agents or the accepted worker core; do not place the key in TOML, JSON, Markdown, logs, command arguments or Git.

Read in order: `AGENTS.md`, this file, `docs/CODEX_ACTIVE_TASK_CURRENT.md`, the complete Task 0024AN file, historical Task 0024AM, the Task 0024AL acceptance handoff/report, the model-routing document, project workflow and current documents.

Task 0024AN is infrastructure-only. DeepSeek-V4-Pro may edit only one temporary smoke target. GPT-5.6 must independently review all wrapper, path, content, secret and synchronization evidence.

All Task 0024AF–0024AL artifacts and consumed retained identities remain immutable. Do not rerun them. Do not change gameplay, Simulation, solver, levels, catalog, progression, finale, Profile, presentation implementation, scenes, localization, assets, audio, build/export/release/submission surfaces or the owner worksheet.

The possible Task 0024AN recommendation is `DEEPSEEK_PROJECT_PILOT_ENABLED` or `DEEPSEEK_PROJECT_PILOT_BLOCKED`; Codex may return only `PASS_FOR_GPT_REVIEW`, `BLOCKED` or `FAIL`. Actual acceptance remains with the GPT Project Sources advisor.

The next gameplay/product gate remains owner subjective review of sequences 1–12 and must use a later successor task identity after Task 0024AN is adjudicated.
