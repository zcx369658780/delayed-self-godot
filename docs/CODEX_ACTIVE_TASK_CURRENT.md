# Codex active task (CURRENT)

- Status: `TASK_0024AS_READY`
- Active task: `tasks/0024AS_launch_isolated_owner_review_game_session.md`
- Task publication commit: `21adcf4257c29a781de91b565b7b586e655b1211`
- Required accepted checkpoint in ancestry: `9caa73d548dc15047913a09505ea16f3eaf18195`
- Previous adjudicated gate: `TASK_0024AR_MCP_TRANSPORT_ACCEPTED_DEEPSEEK_CODE_QUALITY_NOT_ACCEPTABLE`
- DeepSeek project-code routing: `DISABLED`
- Owner route: `MACHINE_QUALIFIED_ISOLATED_STAGING_ROUTE`
- Presentation gate: `TASK_0024AL_PROCESS_ISOLATED_WRITE_AHEAD_SCHEMA_V2_MINIMUM_OWNER_REVIEW_PRESENTATION_ACCEPTED`
- Target result: `OWNER_REVIEW_SESSION_LAUNCHED_AWAITING_OWNER_INPUT`

Task 0024AS is an operational no-repository-write task. Codex must launch the existing Task 0024AE interactive staging launcher through Godot 4.7.1, use the exact isolated test Profile, verify `INTERACTIVE_STAGING`, and leave the visible game window running for the owner. It must not use qualification mode, send gameplay input, populate subjective worksheet fields, modify catalog/Profile/product files, invoke DeepSeek, commit, or push.

The staging session exposes sequences 1–12 while preserving the production catalog at eight levels and sequence 8 as the sole formal production finale. Sequences 9–12 remain uncatalogued candidates. Owner playthrough remains `NOT_YET_REVIEWED` until the owner actually plays and supplies judgments.