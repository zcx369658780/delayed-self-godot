# DeepSeek file-worker pilot workflow

DeepSeek is an opt-in external implementation worker, never a planner, reviewer, tester, Git actor, or acceptance authority. GPT-5.6 defines the task JSON, reviews every changed byte, runs validation, and owns Git and verdicts.

Use only `Invoke-DeepSeekFileTask.ps1`. The frozen worker requires an absolute existing isolated `workspace`; `allowed_paths` and `context_files` must be canonical relative paths below it. Use the smallest isolated workspace, one explicit writable file, and only non-sensitive context. Never use direct Python, MCP, Shell delegation, credentials, Profile/player data, provider changes, or automatic routing.

Before invocation: verify wrapper/worker hashes, User-scope credential presence without reading it, reparse-free paths, JSON canonicality, and an independent GPT review. Afterwards: parse sanitized JSON, verify target/context hashes and changed paths, scan for secrets, prove Process-scope cleanup, remove only the temporary workspace, and stop on any drift. Rollback means stop delegation; wrapper/worker remain untouched and governance reverts only under a new Git task.
