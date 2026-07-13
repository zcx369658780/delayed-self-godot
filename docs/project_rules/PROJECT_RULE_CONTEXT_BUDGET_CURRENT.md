# Context budget rules (CURRENT)

- Start from Git facts, `AGENTS.md`, current docs, and the active task; do not reconstruct full historical chats.
- Inspect directory/file lists, sizes, headings, and diff stats before loading large sources.
- Prefer codebase-memory graph tools for structural code discovery. Use scoped direct search/reads for Markdown, config, string literals, or graph gaps.
- Keep shell outputs bounded (normally about 120 lines or 12,000 characters); read large documents in intentional sections.
- Avoid session JSONL, encrypted content, full history, raw long logs, and broad machine searches unless the task explicitly needs them.
- When context pressure rises, update the active task/handoff with verified state. Never save tokens by skipping diff review, required reads, safety checks, or validation evidence.
