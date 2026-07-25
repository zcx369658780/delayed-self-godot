# Codex active task (CURRENT)

- Status: `TASK_0024AQ_READY`
- Active task: `tasks/0024AQ_deepseek_wrapper_drift_reconciliation_and_mcp_quality_continuation.md`
- Task publication commit: `4254f6cd6b062e06fe25368b2e6b6068645a0c41`
- Required predecessor checkpoint in ancestry: `26354b4fdaa0ad8bd5ebba046b526a7aa2b1d0cb`
- Previous accepted gate: `TASK_0024AO_DEEPSEEK_PROJECT_PILOT_ACCEPTED`
- Stopped predecessor: Task 0024AP stopped at startup on exact wrapper-hash drift before any code delegation or write
- Former accepted wrapper hash: `56289229ffa0e975f9f9751a5998c777e5827b5c2639f7f74ae6c7cbbb07c1d1`
- Observed wrapper hash: `f604001d001cd206e742e5252a69995c29f96c983e6520ec6fd0374ae4908750`
- Wrapper decision gate: accept safe current bytes, rebuild canonical wrapper, or block
- Experimental route: configured DeepSeek MCP
- Benchmark: isolated test-only GDScript action-sequence codec
- GPT ownership: wrapper audit, contract, hidden tests, review, scoring, validation, Git and acceptance
- DeepSeek scope: one implementation file only

Task 0024AQ must first create a byte-identical wrapper backup, audit semantic drift, and fully requalify whichever wrapper becomes authoritative. An exact-hash mismatch is no longer an automatic blocker under this task. Shell filtering, user-level config/agents and the frozen worker core remain protected.

After wrapper reconciliation, repeat MCP ping/tool discovery and continue the bounded code-quality benchmark. MCP transport and model quality must be adjudicated separately; wrapper fallback may be used only as a labeled model-quality control.

Production catalog, sequence order, finale, Profile, owner worksheet, Simulation, solver, scenes, assets, audio, build/release/submission surfaces and all historical retained evidence remain protected. Owner subjective 1–12 playthrough remains pending.
