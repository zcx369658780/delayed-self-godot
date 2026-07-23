# Codex active task (CURRENT)

- Status: `TASK_0024AN_READY`
- Active task: `tasks/0024AN_deepseek_user_scope_credential_wrapper_and_project_pilot_continuation.md`
- Task publication commit: `38edf9d2c9cecd908ad6258b4b45973bf27e6857`
- Required start checkpoint in ancestry: `22c38d33275d737bd6bb5327cf7930a53260ac70`
- Previous attempted task: `0024AM`
- Previous attempt result: `BLOCKED_BEFORE_WRITE_INVALID_PROCESS_ENVIRONMENT_PREFLIGHT`
- Previous accepted gameplay gate: `TASK_0024AL_PROCESS_ISOLATED_WRITE_AHEAD_SCHEMA_V2_MINIMUM_OWNER_REVIEW_PRESENTATION_ACCEPTED`
- User-level worker baseline: `ACCEPTED_FOR_USER_LEVEL_CLI_FALLBACK_PILOT`
- Candidate project gate: `DEEPSEEK_PROJECT_PILOT_ENABLED` or `DEEPSEEK_PROJECT_PILOT_BLOCKED`
- Recommended main model: `GPT-5.6 Sol`; constrained fallback: `GPT-5.6 Terra`; maximum available reasoning

Task 0024AN supersedes only Task 0024AM's invalid current-process credential preflight and direct Python worker command. An empty `$env:DEEPSEEK_API_KEY` is not a blocker because Codex shell filtering may exclude names containing `KEY`, `SECRET`, or `TOKEN` from ordinary child-process environments.

The task must inspect and create or repair the user-level wrapper:

```text
C:\Users\zcxve\.codex\helpers\Invoke-DeepSeekFileTask.ps1
```

The wrapper must read `DEEPSEEK_API_KEY` from Windows User scope, inject it only into Process scope immediately around the approved Python worker invocation, and clear it in `finally`. It must never print, log, serialize, persist or commit the credential.

Every project DeepSeek invocation must use:

```powershell
& "C:\Users\zcxve\.codex\helpers\Invoke-DeepSeekFileTask.ps1" `
  -TaskFile "<absolute task JSON path>"
```

Do not set `ignore_default_excludes = true`, do not weaken `shell_environment_policy`, and do not modify user-level Codex config, agents or the accepted worker core.

DeepSeek may edit only the temporary 0024AN smoke target. GPT-5.6 Sol/Terra retains wrapper design, planning, configuration audit, task JSON, invocation, path/diff/secret review, validation, Git and task verdict ownership.

Startup requirements:

1. fetch and fast-forward only;
2. require `HEAD == origin/main`, divergence `0/0`;
3. require no tracked/staged changes;
4. allow only the pre-existing untracked `.codex/config.toml` with SHA-256 `d4c670da3c2404921a1ab177f4e5405449bc8321d713cc0b42b8046201fd33cc`;
5. require Godot count zero and do not launch Godot;
6. do not test current-process key visibility as a presence gate;
7. read Task 0024AN completely before writing.

All Task 0024AF–0024AL historical retained identities remain immutable. Production catalog, sequence order, finale, Profile, owner worksheet, Simulation, solver, presentation implementation, scenes, assets, audio, builds, releases and submission surfaces remain protected.

The owner subjective 1–12 playthrough remains deferred to a later successor task and must not be started or auto-filled under Task 0024AN.
