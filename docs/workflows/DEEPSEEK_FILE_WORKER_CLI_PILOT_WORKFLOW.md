# DeepSeek file-worker pilot workflow

## Current wrapper-only route after Task 0024BAB v2

`DeepSeek_MCP = REMOVED`; native provider and automatic native subagent are forbidden. The command below is the sole formal route, only for GPT-frozen low-risk bounded/easy-to-verify external file work. DeepSeek is not a planner, tester, reviewer, Git/release authority or mandatory GPT subagent.

The accepted User-scope wrapper remains a bounded credential and file-transport mechanism. Use only:

```powershell
& "C:\Users\zcxve\.codex\helpers\Invoke-DeepSeekFileTask.ps1" `
  -TaskFile "<absolute task JSON path>"
```

The wrapper requires an absolute isolated `workspace`; `allowed_paths` and `context_files` must be canonical relative paths below it. Use the smallest isolated workspace, one explicit writable pre-existing regular file, and only non-sensitive context. Never use direct Python, credentials in files, Profile/player data, provider changes, automatic routing, shell-policy weakening, Git, builds, releases, or final-acceptance authority.

## Current authorization

DeepSeek is **not authorized to implement tracked project code** through the wrapper/CLI.

Task 0024AR proved MCP single-file transport but the generated implementation ignored the frozen public API, implemented an unrelated codec, scored `23/100`, and was adjudicated `NOT_ACCEPTABLE`. A repair turn produced no code change.

Therefore:

- do not delegate GDScript, tests, refactors, bug fixes, Simulation, solver, level logic, Profile, build, or release code to DeepSeek;
- do not use wrapper/CLI as a coding fallback;
- do not automatically route work to DeepSeek;
- never restore or fall back to MCP/native routing;
- permit a new code-quality evaluation only after a material model, routing, or transport change and a new explicit task;
- GPT-5.6 Sol/Terra owns all project code implementation, review, testing, Git, and acceptance.

Before any authorized delegation, verify accepted wrapper and worker identities without exposing contents, use a secret-free external task JSON, enforce regular-file/reparse-safe paths, and retain independent GPT review. If either accepted identity is missing or differs, do not invoke or smoke-test; record the route blocker and continue only when DeepSeek was optional. Task 0024BAB found no accepted worker SHA baseline, did not invoke the wrapper and set the pair to `NOT_VERIFIED`.
