# Task 0024AO GPT acceptance — DeepSeek project file-worker pilot

- Date: `2026-07-23`
- Reviewed result commit: `3e8a05e9d75752a9fa7febad6e4cc3e307d1c701`
- GPT verdict: `TASK_0024AO_DEEPSEEK_PROJECT_PILOT_ACCEPTED`
- Project gate: `DEEPSEEK_PROJECT_PILOT_ENABLED`
- Acceptance class: `BOUNDED EXTERNAL FILE-WORKER PILOT / WRAPPER-ONLY / PATH-B DOCUMENTATION ALIGNMENT`

## 1. Accepted facts

GPT review accepts the following evidence:

1. the Windows User-scope credential bridge is reached only through `C:\Users\zcxve\.codex\helpers\Invoke-DeepSeekFileTask.ps1`;
2. the wrapper SHA-256 is `56289229ffa0e975f9f9751a5998c777e5827b5c2639f7f74ae6c7cbbb07c1d1`;
3. the wrapper and frozen worker remained unchanged during Task 0024AO;
4. the frozen worker contract uses an absolute isolated workspace and workspace-relative `allowed_paths` and `context_files`;
5. one real wrapper-only smoke completed with exit code `0`, parseable `completed` JSON, empty stderr and the exact authorized target transformation;
6. the context remained unchanged and no path outside the single authorized target changed;
7. the temporary smoke workspace was removed;
8. Process-scope credential cleanup, User-scope credential persistence, secret scanning and zero-Godot conditions passed;
9. project `.codex/config.toml` remained byte-identical at `d4c670da3c2404921a1ab177f4e5405449bc8321d713cc0b42b8046201fd33cc`;
10. native GPT provider/model, global shell filtering, user config, user agents and frozen worker core remained unchanged;
11. `PATH_B_DOCUMENTATION_ONLY_WRAPPER_ALIGNMENT` is accepted; no native DeepSeek provider, automatic routing or unsupported project TOML key was added;
12. result commit `3e8a05e9d75752a9fa7febad6e4cc3e307d1c701` changed only governance, reports, current pointers and an upload-ready Project Sources delta.

## 2. Operating authorization

DeepSeek-V4-Pro is authorized only as an opt-in external file-editing implementation worker under a future explicit task. Every delegation must use:

- an isolated absolute workspace;
- canonical workspace-relative readable and writable paths;
- the smallest possible `allowed_paths` set;
- non-sensitive context only;
- wrapper-only invocation;
- independent GPT-5.6 review of every changed byte;
- GPT-5.6-owned tests, Git operations and task verdict.

DeepSeek is not authorized for planning, architecture, Simulation or solver semantics, level solvability or difficulty adjudication, security, credentials, Profile/player data, Shell, Git, tests, builds, dependency installation, release, submission or final acceptance.

## 3. Historical adjudication

- Task 0024AM remains an immutable historical attempt whose current-process credential preflight was superseded.
- Task 0024AN remains an immutable historical attempt whose absolute allowed/context path schema was superseded.
- Neither predecessor failure is evidence against the accepted wrapper or worker route.

## 4. Observations

The 0024AO handoff and reports are intentionally compact and the handoff refers readers to Git history for the final result commit. This is a documentation observation, not a blocker, because the reviewed commit identity, complete changed-file boundary, current pointers and remote main were independently verified during GPT review.

The wrapper and worker are user-level local artifacts and are not committed to this public repository. Acceptance is therefore limited to the recorded hash identity and the successful bounded smoke; future tasks must recheck those hashes before delegation.

## 5. Project Sources

The repository delta at:

```text
docs/project_sources/DELAYED_SELF_PROJECT_SOURCE_DEEPSEEK_FILE_WORKER_PILOT_CURRENT_2026_07_23.md
```

is accepted as the current upload-ready source delta.

```text
project_source_import_status = READY_FOR_GPT_PROJECT_SOURCE_IMPORT
```

This acceptance does not claim that the ChatGPT Project Sources UI has already imported the file.

## 6. Protected boundaries

This acceptance does not change:

- the eight-level production catalog;
- sequence 8 as the sole formal finale;
- owner playthrough status `NOT_YET_REVIEWED`;
- candidate admission status `NOT_AUTHORIZED`;
- Simulation, solver, Gameplay, presentation implementation or Profile;
- build, release or festival submission authorization.

## 7. Next gate

The next legitimate product gate remains owner subjective playthrough of sequences 1–12 through the accepted isolated staging route. It requires a new explicit task identity.
