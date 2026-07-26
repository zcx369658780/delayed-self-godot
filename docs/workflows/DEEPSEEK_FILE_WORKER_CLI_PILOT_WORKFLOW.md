# DeepSeek file-worker pilot workflow

The accepted User-scope wrapper remains a bounded credential and file-transport mechanism. Use only:

```powershell
& "C:\Users\zcxve\.codex\helpers\Invoke-DeepSeekFileTask.ps1" `
  -TaskFile "<absolute task JSON path>"
```

The wrapper requires an absolute isolated `workspace`; `allowed_paths` and `context_files` must be canonical relative paths below it. Use the smallest isolated workspace, one explicit writable pre-existing regular file, and only non-sensitive context. Never use direct Python, credentials in files, Profile/player data, provider changes, automatic routing, shell-policy weakening, Git, builds, releases, or final-acceptance authority.

## Current authorization after Task 0024AR

DeepSeek is **not authorized to implement tracked project code** through either MCP or wrapper/CLI.

Task 0024AR proved MCP single-file transport but the generated implementation ignored the frozen public API, implemented an unrelated codec, scored `23/100`, and was adjudicated `NOT_ACCEPTABLE`. A repair turn produced no code change.

Therefore:

- do not delegate GDScript, tests, refactors, bug fixes, Simulation, solver, level logic, Profile, build, or release code to DeepSeek;
- do not use wrapper/CLI as a coding fallback;
- do not automatically route work to DeepSeek;
- retain the wrapper and MCP registration unchanged for disposable transport probes only;
- permit a new code-quality evaluation only after a material model, routing, or transport change and a new explicit task;
- GPT-5.6 Sol/Terra owns all project code implementation, review, testing, Git, and acceptance.

Before any authorized non-code probe, verify wrapper/worker hashes, User-scope credential presence without exposing it, reparse-free paths, JSON canonicality, and independent GPT review. Afterwards parse sanitized output, verify changed paths and hashes, scan for secrets, prove cleanup, remove only the temporary workspace, and stop on drift.
