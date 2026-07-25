# Codex active task (CURRENT)

- Status: `TASK_0024AP_READY`
- Active task: `tasks/0024AP_deepseek_mcp_bounded_gdscript_code_quality_pilot.md`
- Task publication commit: `b06417cca24e879329d648ba1bb18449564553cb`
- Required accepted checkpoint in ancestry: `a5a9e9ac0efe0b85458e0017e5ac5322a366371b`
- Previous accepted gate: `TASK_0024AO_DEEPSEEK_PROJECT_PILOT_ACCEPTED`
- Existing accepted route: User-scope wrapper to frozen CLI worker
- Experimental route: configured DeepSeek MCP
- Benchmark: isolated pure GDScript action-sequence codec; no production integration
- Candidate transport verdict: `PASS_DIRECT_FILE_EDIT`, `PASS_PATCH_RETURN`, or `BLOCKED`
- Candidate code-quality verdict: `ACCEPTABLE_FOR_BOUNDED_IMPLEMENTATION`, `CONDITIONAL_MECHANICAL_ONLY`, `NOT_ACCEPTABLE`, or `NOT_EVALUATED`
- Recommended main model: `GPT-5.6 Sol`; constrained fallback: `GPT-5.6 Terra`

Task 0024AP must separate MCP transport from model code quality. GPT-5.6 freezes the contract, owns hidden tests, review, scoring, Git and verdict. DeepSeek may author only `tests/deepseek_quality/action_sequence_codec.gd` in an isolated worktree. It may not inspect hidden tests, run Shell/Git/Godot, access secrets/Profile data, or touch production code.

If MCP is unavailable, record it as blocked; the accepted wrapper may be used only as an explicitly labeled model-quality control. No fallback may be represented as MCP success.

Production catalog, sequence order, finale, Profile, owner worksheet, Simulation, solver, scenes, assets, audio, build/release/submission surfaces and all historical retained evidence remain protected. Owner subjective 1–12 playthrough remains pending and must not start under Task 0024AP.
