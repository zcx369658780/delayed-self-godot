# Codex active task (CURRENT)

- Status: `TASK_0024AM_READY`
- Active task: `tasks/0024AM_deepseek_v4_pro_external_file_worker_project_pilot_and_sync_gate.md`
- Task publication commit: `6340bb981ca88e096236aa1a716bb295c1ccdd67`
- Required accepted checkpoint in ancestry: `65656cca16b7e3867685287b1fc9c7ebd4e7ee30`
- Previous accepted gate: `TASK_0024AL_PROCESS_ISOLATED_WRITE_AHEAD_SCHEMA_V2_MINIMUM_OWNER_REVIEW_PRESENTATION_ACCEPTED`
- User-level worker baseline: `ACCEPTED_FOR_USER_LEVEL_CLI_FALLBACK_PILOT`
- Candidate project gate: `DEEPSEEK_PROJECT_PILOT_ENABLED` or `DEEPSEEK_PROJECT_PILOT_BLOCKED`
- Recommended main model: `GPT-5.6 Sol`; constrained fallback: `GPT-5.6 Terra`; maximum available reasoning

Task 0024AM is an infrastructure and governance gate. It must audit the project-local Codex configuration against the accepted user-level DeepSeek-V4-Pro file worker, preserve the native GPT-5.6 model/provider, perform one real bounded CLI smoke edit, independently validate the result with GPT-5.6, synchronize repository governance and an upload-ready Project Sources delta, and provide rollback evidence.

DeepSeek may edit only the temporary smoke target during this task. It may not modify tracked repository files, run Shell/Git/tests/builds, access secrets or player data, plan architecture, review its own output, or issue the task verdict. GPT-5.6 Sol/Terra retains planning, configuration design, review, validation, Git and acceptance ownership.

Startup requirements:

1. fetch and fast-forward only;
2. require `HEAD == origin/main`, divergence `0/0`, and ancestry of `65656cca16b7e3867685287b1fc9c7ebd4e7ee30`;
3. require no tracked/staged changes;
4. allow only the pre-existing untracked `.codex/config.toml`;
5. require its startup SHA-256 `d4c670da3c2404921a1ab177f4e5405449bc8321d713cc0b42b8046201fd33cc` without exposing contents;
6. require Godot count zero and do not launch Godot;
7. read `AGENTS.md`, the startup snapshot, the complete Task 0024AM file, the Task 0024AL handoff/acceptance and the model-routing/workflow documents.

All Task 0024AF–0024AL historical retained identities remain immutable. Production catalog, sequence order, finale, Profile, owner worksheet, Simulation, solver, presentation implementation, scenes, assets, audio, builds, releases and submission surfaces remain protected.

The owner subjective 1–12 playthrough is deferred to a later successor task and must not be started or auto-filled under Task 0024AM.
