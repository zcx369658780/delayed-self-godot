# Task 0023U — Implement the test-fixture-only Profile filesystem store

- Status: `READY`
- Gate: `PROTECTED PLAYER DATA / TEST-ONLY FILESYSTEM STORE`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Accepted path gate: `tasks/0023R_profile_test_isolation_gate_repair.md`
- Accepted codec gate: `tasks/0023T_pure_profile_codec_compile_gate.md`
- GPT codec acceptance: `docs/reports/0023T_GPT_PURE_PROFILE_CODEC_GATE_ACCEPTANCE.md`
- Required checkpoint: `a78bce1714e22adda2fddd4ee08b13a60a503e6d`

## 1. Objective

Extend `DelayedSelfLocalProfile` into a bounded filesystem store and prove Profile v1 loading, sanitation, recovery preservation, transactional replacement, failure rollback and a test-only reset primitive **only inside one task-owned canonical test fixture**.

This task does not provide or exercise a production store factory. It must not open the real production Profile, integrate AppRoot or MemoryProgress, modify existing product-flow tests, register aggregate tests, or implement any menu/settings/localization/export surface.

## 2. Startup and protected metadata

Before any edit or Godot process:

- require root `D:\Delayed_Self`, branch `main`, expected SSH origin and clean tracked/untracked worktree;
- fetch and fast-forward only;
- require `HEAD == origin/main` and ancestry of `a78bce1714e22adda2fddd4ee08b13a60a503e6d`;
- verify Godot `4.7.stable.steam.5b4e0cb0f` or the exact documented equivalent;
- require no residual Godot process.

Outside Godot, record only production Profile:

```text
Test-Path
Length
LastWriteTimeUtc
```

for the fixed `user://delayed_self_profile.json`. Do not open, parse, hash, copy, rename, back up, delete or repair its content.

Record only whether `user://delayed_self_test_profiles/` exists. Do not enumerate or alter pre-existing contents.

## 3. Mandatory zero-I/O prerequisites

Before editing, rerun exactly:

```text
godot.windows.opt.tools.64.exe --headless --path D:\Delayed_Self --script res://tests/app/task_0023r_profile_test_isolation_gate.gd
godot.windows.opt.tools.64.exe --headless --path D:\Delayed_Self --script res://tests/app/task_0023t_profile_codec_compile_smoke.gd
godot.windows.opt.tools.64.exe --headless --path D:\Delayed_Self --script res://tests/app/task_0023t_pure_profile_codec.gd
```

Require the accepted 123-assertion path result, first-attempt-equivalent compile marker, 34-assertion codec result, exit 0 and empty stderr. Recheck protected metadata afterward.

Any regression stops with `BLOCKED_PROFILE_FILESYSTEM_STORE` before edits.

## 4. Frozen accepted authorities

Preserve byte/semantic behavior of:

- the Task 0023R static path-policy constants and methods in `local_profile.gd`;
- `profile_codec.gd` and its accepted typed zero-I/O behavior;
- eight formal levels, catalog, Simulation, solver, schema, Gameplay, final acknowledgment, Help, Timeline and presentation;
- the real production Profile and unrelated test-root contents.

Do not modify `profile_codec.gd` in this task. Stop if an essential codec change is discovered.

## 5. Store architecture

Append instance/store behavior below the accepted static policy block in `scripts/app/local_profile.gd`.

Provide only one creation interface in this task:

```text
DelayedSelfLocalProfile.create_test(catalog_facts: Dictionary, canonical_test_profile_path: String) -> Dictionary
```

It must:

1. call `validate_test_profile_path` first;
2. return a structured rejection and perform zero I/O when validation fails;
3. use exactly the accepted returned path;
4. retain immutable catalog facts needed by the accepted codec;
5. construct a store instance only for that test path.

Do **not** add `create_production`, arbitrary-path constructors/setters, environment/command-line paths, base-directory injection, autoloads, service locators or background threads.

`ProjectSettings.globalize_path` may be used only inside the trusted filesystem implementation after `create_test` has accepted the canonical virtual path. It must never participate in path validation or accept a caller-supplied OS path.

## 6. Profile filesystem contract

Use the accepted codec for all Profile v1 data decisions.

Maximum accepted source size: `65536` bytes.

At minimum expose structured operations equivalent to:

```text
load_profile() -> Dictionary
persist_profile(candidate_profile: Dictionary) -> Dictionary
reset_test_profile() -> Dictionary
get_committed_profile() -> Dictionary
```

Exact names may vary but the report must record them.

Required statuses include:

```text
MISSING_CLEAN
LOADED
SANITIZED
RECOVERED_CLEAN
RECOVERY_FAILED
PERSISTED
NO_CHANGE
WRITE_FAILED
RESET
```

### Missing and valid

- Missing target: clean in-memory v1; no eager file creation.
- Valid target: load normalized Profile without rewriting.
- Repeated equivalent persist: `NO_CHANGE`, no rewrite.

### Salvageable v1

- Return `SANITIZED` with the accepted codec-normalized in-memory Profile.
- Do not immediately overwrite the source.
- Before the first later persist that would replace it, preserve one collision-safe sibling recovery copy.

### Malformed/oversized/wrong structure/unknown version

- Preserve the exact source as one collision-safe sibling recovery copy before activating a clean in-memory Profile.
- If preservation succeeds: `RECOVERED_CLEAN`, writable clean state.
- If preservation fails through the narrow deterministic failure seam: original untouched, writes disabled, `RECOVERY_FAILED`.

No source contents or full OS path may enter user-facing/status text. Test evidence may hash synthetic fixture files only.

## 7. Transactional replacement

For each changed candidate:

1. canonicalize and serialize with the accepted codec without mutating the committed Profile;
2. write a unique same-directory temp sibling;
3. verify write result, flush and close;
4. read back the owned temp and prove it parses/normalizes to the intended canonical Profile;
5. replace the target using the same pinned Godot 4.7 API proven by the retained blocked-Task-0023 synthetic Windows probe;
6. update committed in-memory state only after replacement succeeds;
7. on failure, leave the old target and committed state unchanged and remove only the owned temp.

Record the retained Windows probe evidence identity. If a different replacement API is used, run a new synthetic fixture-only probe and stop if overwrite preservation cannot be proven.

Provide narrow deterministic seams for:

- recovery-copy failure;
- temp/write or replacement failure.

They may select a fixed internal failure stage only. They must not expose arbitrary paths, operations or production mode.

Use bounded collision-safe candidate generation without enumerating the test root. It may test existence of bounded exact sibling names inside the owned fixture directory.

## 8. Test-owned fixture discipline

The standalone behavior test must:

1. create a unique valid fixture ID;
2. obtain its path only from `build_test_profile_path`;
3. call `create_test` and require success before any I/O;
4. create/access only that exact fixture directory and tracked sibling files;
5. never enumerate the test root or inspect unrelated fixture directories;
6. retain exact paths for every target/temp/recovery file it creates;
7. remove only those tracked owned files and its own fixture directory;
8. prove no owned residue remains.

The test must not instantiate AppRoot or MemoryProgress and must not run `tests/run_all.gd`.

## 9. Compile-first and source-audit gates

Add:

```text
tests/app/task_0023u_profile_store_compile_smoke.gd
tests/app/task_0023u_profile_filesystem_store.gd
```

After the first store draft, run only the compile smoke. It must preload the path policy, codec and store class but perform no filesystem operation.

Before the behavior test, source-audit the authorized source/tests and require:

- accepted Task 0023R static policy still present;
- no `create_production`;
- no AppRoot, MemoryProgress, scene, route or aggregate integration;
- no command-line/environment-derived path;
- no arbitrary path setter/constructor;
- no path normalization/decoding before validation;
- all filesystem calls occur only in store instance methods reachable after `create_test` validation;
- test script obtains paths only from `build_test_profile_path`.

## 10. Required synthetic behavior tests

Cover at minimum:

1. invalid and production paths reject with zero I/O;
2. missing fixture target returns `MISSING_CLEAN` and no eager write;
3. first persist creates deterministic Profile JSON;
4. reconstructing a new store loads the same canonical Profile;
5. equivalent persist is `NO_CHANGE` and does not change metadata;
6. changed persist replaces an existing target and updates committed state only after success;
7. salvageable v1 returns `SANITIZED`, preserves source before first replacement and writes canonical replacement;
8. malformed, truncated, oversized, wrong-root and unknown-version sources preserve recovery copy and activate clean state;
9. recovery-copy collision handling is bounded and does not overwrite existing owned synthetic copies;
10. injected recovery failure leaves source untouched and disables writes;
11. injected temp/write/replace failure preserves target and committed state and removes only owned temp;
12. temp read-back mismatch/failure cannot commit;
13. unique temp names and no orphan after success/failure;
14. reset removes only the owned target and returns clean in-memory state; no product Reset UI;
15. deterministic status/result shape without raw content or full OS-path disclosure;
16. production Profile existence/size/modified-time metadata remains unchanged;
17. Task 0023R and Task 0023T tests still pass after behavior cleanup.

Required markers exactly once:

```text
TASK_0023U_PROFILE_STORE_COMPILE_SMOKE_PASS
TASK_0023U_PROFILE_FILESYSTEM_STORE_TESTS_PASS
```

No aggregate marker is added.

## 11. Execution order

1. Protected metadata snapshot.
2. Task 0023R + Task 0023T prerequisite runs.
3. Edit store and compile smoke only.
4. Static source audit.
5. Recheck protected metadata.
6. Run one standalone filesystem behavior test in one owned fixture.
7. Clean exact owned files/directory.
8. Rerun Task 0023R + Task 0023T tests.
9. Final protected metadata and test-root-existence comparison.

Stop immediately if production metadata changes, any content-oriented production access occurs, the test root is enumerated, a fixture escapes the canonical grammar, compile/parser/runtime errors occur, or owned residue remains.

## 12. Authorized repository paths

```text
scripts/app/local_profile.gd
tests/app/task_0023u_profile_store_compile_smoke.gd
tests/app/task_0023u_profile_filesystem_store.gd
docs/reports/0023U_PROFILE_FILESYSTEM_STORE_GATE_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/production/COMPLETE_FLOW_PRODUCTION_CLOSURE_PLAN_CURRENT.md
```

Do not modify `profile_codec.gd`, `memory_progress.gd`, `app_root.gd`, existing tests, `tests/run_all.gd`, scenes, project settings, formal data, catalog, Simulation, solver, schema, Gameplay, UI, localization, assets, export, release or submission surfaces.

## 13. Evidence, report, Git and rollback

Use only:

```text
D:\Delayed_Self_Evidence\0023U_profile_filesystem_store_gate\
```

Record prerequisite/compile/behavior commands, stdout/stderr/exits, source audit, synthetic fixture file hashes/status traces, exact owned cleanup inventory, retained/new Windows replacement probe identity, protected metadata and final Git state. Do not stage fixture or evidence files.

Create `docs/reports/0023U_PROFILE_FILESYSTEM_STORE_GATE_REPORT.md`.

Require one commit:

```text
feat: add Delayed Self test-only profile filesystem store
```

Finish with clean worktree, `HEAD == origin/main`, divergence `0/0`, no Godot process and no owned fixture residue.

Rollback removes only Task 0023U store additions below the accepted path-policy block, its two tests/report/current-document updates. It must not access the production Profile or unrelated test-root contents.

## 14. Terminal verdict

Return exactly one:

```text
PROFILE_FILESYSTEM_STORE_READY_FOR_GPT_REVIEW
BLOCKED_PROFILE_FILESYSTEM_STORE
```

Include commit SHA if produced, compile/behavior counts, all status and failure-seam results, replacement probe, production metadata, fixture cleanup, changed paths, evidence root and final Git state.

This task does not authorize production Profile access, AppRoot/MemoryProgress integration, aggregate, menu/settings/localization, build/export, RC, release or submission.
