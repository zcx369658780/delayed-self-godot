# DeepSeek file-worker pilot workflow

## Current wrapper-only route after Task 0024BAC

`DeepSeek_MCP = REMOVED`; native provider, automatic native subagent and MCP fallback are forbidden. The command below is the sole formal route, only for `GPT_FROZEN_LOW_RISK_BOUNDED_EASY_TO_VERIFY` external file work. DeepSeek is not a planner, tester, reviewer, Git/release authority or mandatory GPT subagent.

Task 0024BAC captured the wrapper and worker package twice without invocation or modification. Candidate identity is `IDENTITY_BASELINE_READY_FOR_GPT_REVIEW`: wrapper SHA-256 `f604001d001cd206e742e5252a69995c29f96c983e6520ec6fd0374ae4908750`; `DS_WORKER_TREE_SHA256_V1` aggregate `7949540c811e530ea777d655b5c1882b71b45ab31640702eae8f2180d335cbe8`; CLI-entry SHA-256 `d0596c70dd102b98a3ed77a02c99195ccff23f6d126fb400ff3c47c25a232a36`. These candidate hashes do not authorize invocation until GPT accepts them.

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

Before any authorized delegation after GPT baseline acceptance, freshly verify both accepted identities without exposing contents, use a secret-free external task JSON, enforce regular-file/reparse-safe paths, and retain independent GPT review. If either accepted identity is missing or differs, do not invoke or smoke-test; record the route blocker and continue only when DeepSeek was optional. GPT-5.6 retains planning, allowed paths, review, tests, Git, release and acceptance authority.
