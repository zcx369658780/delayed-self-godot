# Codex active task (CURRENT)

- Status: `TASK_0024AO_READY`
- Active task: `tasks/0024AO_deepseek_relative_path_contract_alignment_and_project_pilot_completion.md`
- Task publication commit: `625314efc1fab7b06014683907db478f91428f89`
- Required predecessor checkpoint in ancestry: `8369cd1beb1e1c4a662081cb7657f01c4a99fb6a`
- Historical attempted tasks: `0024AM`, `0024AN`
- 0024AM adjudication: `INVALID_PROCESS_ENVIRONMENT_PREFLIGHT_SUPERSEDED`
- 0024AN adjudication: `ABSOLUTE_ALLOWED_CONTEXT_PATHS_SUPERSEDED_BY_FROZEN_WORKER_RELATIVE_CONTRACT`
- Previous accepted gameplay gate: `TASK_0024AL_PROCESS_ISOLATED_WRITE_AHEAD_SCHEMA_V2_MINIMUM_OWNER_REVIEW_PRESENTATION_ACCEPTED`
- User-level worker baseline: `ACCEPTED_FOR_USER_LEVEL_CLI_FALLBACK_PILOT`
- Candidate project gate: `DEEPSEEK_PROJECT_PILOT_ENABLED` or `DEEPSEEK_PROJECT_PILOT_BLOCKED`
- Recommended main model: `GPT-5.6 Sol`; constrained fallback: `GPT-5.6 Terra`; maximum available reasoning

Task 0024AO preserves the repaired user-level credential wrapper and frozen DeepSeek worker, extracts the worker's actual path schema from source, and retries the real bounded smoke using an absolute `workspace` with workspace-relative `allowed_paths` and `context_files`.

The wrapper remains the only authorized invocation:

```powershell
& "C:\Users\zcxve\.codex\helpers\Invoke-DeepSeekFileTask.ps1" `
  -TaskFile "<absolute task JSON path>"
```

Do not use direct Python, MCP delegate, current-process key visibility, absolute allowed/context entries, `ignore_default_excludes = true`, or a weakened `shell_environment_policy`.

DeepSeek may edit only one temporary untracked smoke target. GPT-5.6 Sol/Terra retains worker-contract extraction, planning, task JSON, path/content/secret review, configuration decisions, validation, Git and task-verdict ownership.

Startup requirements:

1. fetch and fast-forward only;
2. require `HEAD == origin/main`, divergence `0/0`;
3. require no tracked/staged changes;
4. allow only the pre-existing untracked `.codex/config.toml` with SHA-256 `d4c670da3c2404921a1ab177f4e5405449bc8321d713cc0b42b8046201fd33cc`;
5. require wrapper and worker byte identity;
6. require Windows User-scope credential `PRESENT` without revealing credential metadata;
7. require Godot count zero and do not launch Godot;
8. read Task 0024AO completely before writing.

All Task 0024AF–0024AL historical retained identities remain immutable. Production catalog, sequence order, finale, Profile, owner worksheet, Simulation, solver, presentation implementation, scenes, assets, audio, builds, releases and submission surfaces remain protected.

The owner subjective 1–12 playthrough remains deferred to a later successor task and must not be started or auto-filled under Task 0024AO.