# Task 0023W — Implement the configured test-only Profile filesystem store

- Status: `READY`
- Gate: `PROTECTED PLAYER DATA / CONFIGURED TEST-ONLY FILESYSTEM STORE`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- GPT prerequisite acceptance: `docs/reports/0023V_GPT_PROFILE_STORE_INSTANCE_CONFIGURATION_GATE_ACCEPTANCE.md`
- Required checkpoint: `3d796d74884ef123cb9ea32f4a5101d7f1ee7340`
- Fixed task-owned fixture ID: `task_0023w_profile_filesystem_store`

## 1. Objective

Extend the already accepted, externally constructed and successfully `configure_test`-configured `DelayedSelfLocalProfile` instance with a bounded filesystem store operating only inside one fixed task-owned canonical test fixture.

Prove Profile v1 missing/load/sanitize/recovery preservation/deterministic persistence/transactional replacement/failure rollback/test-only reset behavior while preserving the accepted Tasks 0023R, 0023T and 0023V gates.

This task does **not** authorize a production constructor or production Profile operation, AppRoot or MemoryProgress integration, process-restart product integration, existing AppRoot tests, aggregate registration, menu/settings/localization work, scenes, export, RC, release, upload or festival submission.

## 2. Startup and remote gate

Before edits or Godot processes:

1. require absolute root `D:\Delayed_Self`, branch `main`, expected origin and clean tracked/untracked worktree;
2. run the repository startup Git facts required by `AGENTS.md`;
3. fetch and fast-forward only;
4. require `HEAD == origin/main` and ancestry of `3d796d74884ef123cb9ea32f4a5101d7f1ee7340`;
5. read the complete Task 0023V GPT acceptance before implementation;
6. verify the pinned Godot `4.7.stable.steam.5b4e0cb0f` or the exact documented equivalent;
7. require no residual Godot process.

Stop on divergence, conflict, unexpected tracked/untracked work, remote mismatch or missing checkpoint.

## 3. Protected production metadata boundary

Outside Godot, record only the fixed production Profile's non-content metadata:

```text
exists
Length
LastWriteTimeUtc
```

Expected accepted baseline:

```text
exists = true
Length = 473
LastWriteTimeUtc = 2026-07-19T08:15:02.2089459Z
```

Do not open, read, parse, hash, copy, rename, back up, delete, reset, repair, compare or write the production Profile content.

For `user://delayed_self_test_profiles/`, record only whether the root exists. Do not enumerate it, clean it or inspect unrelated fixtures.

Any production metadata change or content-oriented production access is an immediate safety stop with no implementation commit.

## 4. Mandatory accepted prerequisites

Before editing, rerun exactly:

```text
godot.windows.opt.tools.64.exe --headless --path D:\Delayed_Self --script res://tests/app/task_0023r_profile_test_isolation_gate.gd
godot.windows.opt.tools.64.exe --headless --path D:\Delayed_Self --script res://tests/app/task_0023t_profile_codec_compile_smoke.gd
godot.windows.opt.tools.64.exe --headless --path D:\Delayed_Self --script res://tests/app/task_0023t_pure_profile_codec.gd
godot.windows.opt.tools.64.exe --headless --path D:\Delayed_Self --script res://tests/app/task_0023v_profile_store_instance_compile_smoke.gd
godot.windows.opt.tools.64.exe --headless --path D:\Delayed_Self --script res://tests/app/task_0023v_profile_store_instance_configuration.gd
```

Require:

- Task 0023R: 123 assertions / 4 positive / 39 negative;
- Task 0023T: compile marker and 34 assertions;
- Task 0023V: compile marker and 28 assertions;
- exit code 0, required markers exactly once and empty stderr for every run.

Recheck protected production metadata and test-root existence afterward. Stop before edits on any regression.

## 5. Frozen accepted authorities

Preserve exactly:

- Task 0023R constants and static path-policy semantics in `scripts/app/local_profile.gd`;
- Task 0023V external construction and one-time `configure_test` behavior;
- all accepted semantics and bytes of `scripts/app/profile_codec.gd`;
- the production Profile and all unrelated test-root contents;
- the eight-level catalog, formal hashes/metrics, Simulation, solver, schema, canonical state, Gameplay, final acknowledgment, Help, Timeline, Level Select behavior and presentation baselines.

Do not modify `profile_codec.gd` in this task. Stop and report if an essential codec change appears necessary.

Do not restore a class-internal `create_test` factory or reference `DelayedSelfLocalProfile` as a type inside its own script.

## 6. Required construction and pre-I/O gate

Every store instance must still be constructed externally:

```gdscript
const LocalProfileScript = preload("res://scripts/app/local_profile.gd")
var store: RefCounted = LocalProfileScript.new()
var configured: Dictionary = store.configure_test(catalog_facts, canonical_test_profile_path)
```

All I/O-capable instance methods must:

1. reject when `is_configured() == false`;
2. return a deterministic structured result such as `STORE_NOT_CONFIGURED`;
3. perform zero filesystem calls before successful configuration;
4. use only the exact canonical virtual path retained by accepted `configure_test`;
5. accept no caller-supplied path, directory, filename, OS path, environment value or command-line override.

No `create_production`, arbitrary-path constructor/setter, service locator, autoload, background thread or production fallback is permitted.

`ProjectSettings.globalize_path` may be used only inside private filesystem methods after successful accepted configuration. It must never validate or transform a caller-supplied path.

## 7. Fixed task-owned fixture discipline

Use exactly:

```text
fixture ID: task_0023w_profile_filesystem_store
virtual target: user://delayed_self_test_profiles/task_0023w_profile_filesystem_store/delayed_self_profile.json
```

The behavior test must obtain the target only from `build_test_profile_path`, then successfully call `configure_test` before any fixture I/O.

After configuration, it may check only the exact fixed fixture directory/target and its own explicitly tracked sibling names. It must never enumerate the test root or inspect another fixture.

If the fixed fixture directory or target already exists at behavior-test startup, stop without opening or changing it and return the blocked verdict. Do not treat pre-existing content as disposable.

The test must maintain an exact inventory of every target, temp, transaction-backup and recovery-copy path it creates. Cleanup may remove only that inventory and the fixed fixture directory after proving it contains no untracked task-owned residue. The test-root directory itself must remain untouched.

## 8. Filesystem interface and maximum size

Append only the bounded instance/store behavior needed for this gate to `scripts/app/local_profile.gd`.

Expose structured operations equivalent to:

```text
load_profile() -> Dictionary
persist_profile(candidate_profile: Dictionary) -> Dictionary
reset_test_profile() -> Dictionary
get_committed_profile() -> Dictionary
```

Exact names may vary only if recorded in the report and all semantics below remain explicit.

Maximum accepted source size:

```text
65536 bytes
```

Use the accepted codec for all Profile v1 normalization, candidate and serialization decisions. Do not duplicate codec rules in the store.

Required externally observable statuses include:

```text
STORE_NOT_CONFIGURED
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

Additional narrow internal/test statuses are allowed when documented, deterministic and free of raw content or OS paths.

## 9. Load contract

### 9.1 Missing target

- Return `MISSING_CLEAN` with a defensive clean default Profile in memory.
- Do not eagerly create the target, fixture directory, temp file or recovery copy.
- Store remains writable after an explicit later persist.

### 9.2 Valid canonical target

- Read at most the bounded size, parse, normalize and retain the canonical Profile.
- Return `LOADED`.
- Do not rewrite, touch metadata or create sibling files.

### 9.3 Salvageable Profile v1

- Return `SANITIZED` with the codec-normalized Profile in memory.
- Do not immediately overwrite the source.
- Mark that exact original source for one collision-safe recovery copy before the first later persist that would replace it.
- An equivalent persist is not `NO_CHANGE` while canonical repair and source preservation remain pending.

### 9.4 Malformed, truncated, oversized, wrong-root or unknown-version source

- Preserve the exact source as one collision-safe sibling recovery copy before activating a clean default Profile.
- If preservation succeeds, return `RECOVERED_CLEAN`; leave the original target untouched until an explicit later persist and keep writes enabled.
- If preservation fails through the narrow deterministic seam, return `RECOVERY_FAILED`, leave the original target unchanged and disable persist/reset mutations for that store instance.
- Do not expose source content or a globalized path in any result.

## 10. Recovery-copy policy

Use bounded, deterministic, collision-safe sibling candidate generation inside the fixed owned fixture directory.

- Never overwrite an existing sibling recovery copy.
- Test only a bounded sequence of exact candidate names; do not list the directory.
- Preserve at most one new recovery copy per loaded original source state.
- Record the selected virtual sibling name, never a full OS path.
- If the bounded candidate set is exhausted, return `RECOVERY_FAILED` with the original target and committed state unchanged.

The behavior test must prove collision handling with its own tracked synthetic sibling files.

## 11. Deterministic persistence and `NO_CHANGE`

For every candidate:

1. normalize/canonicalize and serialize through the accepted codec without mutating committed state;
2. reject invalid candidates without filesystem mutation;
3. produce deterministic JSON bytes;
4. return `NO_CHANGE` only when no pending recovery/canonical repair exists and the intended canonical bytes equal the known committed canonical target;
5. on `NO_CHANGE`, do not rewrite and prove target metadata is unchanged;
6. otherwise execute the transactional replacement contract below.

The committed in-memory Profile may change only after the new target is fully verified and committed.

## 12. Transactional replacement and rollback

For each changed persist:

1. create a bounded unique same-directory owned temp sibling;
2. write the complete canonical JSON, flush and close;
3. read back only the owned temp;
4. enforce the size bound, parse, normalize and reserialize it;
5. require exact canonical JSON equivalence with the intended Profile;
6. preserve/prepare the old target through a same-directory owned transaction mechanism that can restore the exact old bytes;
7. replace the target using the pinned Godot 4.7 API and ordering proven on the fixed synthetic fixture;
8. verify the committed target before changing in-memory committed state;
9. on any failure, restore or preserve the exact old target, keep committed state unchanged and remove only owned transaction/temp files.

A replacement failure must never leave the target missing, truncated or changed. If this cannot be proven on the pinned Windows/Godot environment, stop with the blocked verdict.

Use the previously retained synthetic replacement evidence only if it exactly covers the final implementation ordering. Otherwise run a new narrow task-owned fixture-only probe as part of the standalone behavior test/evidence. Do not use the production Profile.

## 13. Narrow deterministic failure seams

Provide a test-only, configured-instance-only fixed-stage seam with a whitelist equivalent to:

```text
NONE
RECOVERY_COPY
TEMP_WRITE
TEMP_READBACK
REPLACE
POST_REPLACE_VERIFY
```

The seam:

- must accept no path or arbitrary operation;
- must be inaccessible before successful configuration;
- must affect only the fixed configured test instance;
- must not introduce production mode;
- must reset deterministically between cases.

Prove:

- recovery failure leaves source and committed state untouched and disables writes;
- temp/write/read-back failure leaves old target and committed state unchanged;
- replacement/post-replacement verification failure restores the exact old target;
- only owned temp/transaction artifacts are removed;
- no owned residue remains.

## 14. Test-only reset

`reset_test_profile` is authorized only on a successfully configured test instance.

It must:

- reject before configuration with zero I/O;
- reject while the instance is write-disabled after `RECOVERY_FAILED`;
- remove only the exact configured task-owned target;
- remove no recovery copy, unrelated sibling, other fixture or test-root content unless the specific file was created and tracked by the current reset test case;
- return `RESET` and restore a clean default committed Profile;
- create no replacement target eagerly.

This task creates no Reset UI and no production reset path.

## 15. Compile-first gate

Add:

```text
tests/app/task_0023w_profile_store_compile_smoke.gd
```

It must preload `local_profile.gd`, instantiate externally, compile the accepted `configure_test` call and compile all new store method calls without performing filesystem I/O.

Required marker exactly once:

```text
TASK_0023W_PROFILE_STORE_COMPILE_SMOKE_PASS
```

Run it immediately after the first store draft. Allow at most five compile-only correction attempts inside authorized files. If it still fails, restore the accepted 0023V source state, remove Task 0023W implementation/test additions and return the blocked verdict.

## 16. Standalone filesystem behavior test

Only after compile smoke and source audit pass, add:

```text
tests/app/task_0023w_profile_filesystem_store.gd
```

Use synthetic in-memory catalog facts and the one fixed canonical fixture only. Do not instantiate AppRoot or MemoryProgress and do not run `tests/run_all.gd`.

Cover at minimum:

1. every I/O method rejects before configuration with zero I/O;
2. production/invalid configuration paths reject and still permit no I/O;
3. fixed canonical configuration succeeds once;
4. missing target returns `MISSING_CLEAN` with no eager write;
5. first persist creates deterministic canonical JSON;
6. a fresh externally constructed/configured store reloads the same Profile as `LOADED`;
7. equivalent persist returns `NO_CHANGE` without metadata change;
8. changed persist replaces the target and updates committed state only after success;
9. salvageable v1 returns `SANITIZED`, delays rewrite, preserves one exact recovery copy and then commits canonical bytes;
10. malformed, truncated, oversized, wrong-root and unknown-version cases return `RECOVERED_CLEAN` after exact preservation;
11. recovery-copy collisions are bounded and never overwrite tracked siblings;
12. recovery failure returns `RECOVERY_FAILED`, preserves source and disables writes/reset;
13. temp write failure preserves old target and committed state;
14. temp read-back mismatch/failure cannot commit;
15. replacement and post-replacement verification failures restore exact old target and committed state;
16. unique bounded temp/transaction names leave no orphan on success or failure;
17. invalid persist candidates cause no I/O;
18. reset removes only the exact configured target and returns clean in-memory state without eager write;
19. defensive committed-profile snapshots cannot mutate internal state;
20. deterministic status/result shapes contain no source contents or globalized OS paths;
21. fixed fixture cleanup removes only the exact tracked inventory and leaves no owned residue;
22. production Profile non-content metadata and test-root existence remain unchanged.

Required marker exactly once:

```text
TASK_0023W_PROFILE_FILESYSTEM_STORE_TESTS_PASS
```

Exit 0 and empty stderr are mandatory. No aggregate marker is added.

## 17. Static source audit

Before filesystem behavior testing and again after it, audit authorized source/tests and require:

- accepted 0023R and 0023V surfaces remain present;
- no `create_test` factory and no `create_production`;
- no AppRoot, MemoryProgress, scene, route or aggregate integration;
- no command-line/environment-derived path;
- no arbitrary path setter/constructor;
- no filesystem operation before successful `configure_test`;
- filesystem calls use only private state retained from accepted configuration;
- test paths originate only from `build_test_profile_path`;
- no test-root enumeration;
- no modification of `profile_codec.gd`;
- no production Profile content operation.

## 18. Execution order

1. Startup Git/environment checks.
2. Protected production metadata and test-root-existence snapshot.
3. Pre-edit Tasks 0023R, 0023T and 0023V regressions.
4. Implement minimal store draft.
5. Run Task 0023W compile smoke only.
6. Static source audit and protected metadata recheck.
7. Confirm fixed owned fixture path is absent without opening or enumerating anything else.
8. Run one standalone Task 0023W filesystem behavior suite.
9. Clean the exact tracked owned inventory and fixed fixture directory.
10. Rerun Tasks 0023R, 0023T, 0023V and Task 0023W compile/behavior tests from a clean fixture state.
11. Repeat source audit, protected metadata and test-root-existence comparison.
12. Require no owned fixture residue and no residual Godot process.
13. Write report/current-document updates, explicit-stage, commit and push.

Stop immediately on production metadata change, any production content access, test-root enumeration, canonical-path escape, inability to preserve/restore the old target, parser/runtime error outside the bounded compile-correction phase, cleanup uncertainty or unexpected repository drift.

## 19. Authorized repository paths

```text
scripts/app/local_profile.gd
tests/app/task_0023w_profile_store_compile_smoke.gd
tests/app/task_0023w_profile_filesystem_store.gd
docs/reports/0023W_PROFILE_FILESYSTEM_STORE_AFTER_INSTANCE_GATE_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/production/COMPLETE_FLOW_PRODUCTION_CLOSURE_PLAN_CURRENT.md
```

Do not modify:

```text
scripts/app/profile_codec.gd
scripts/app/memory_progress.gd
scripts/app/app_root.gd
existing tests
tests/run_all.gd
project.godot
scenes
formal level data/catalog
Simulation/solver/schema/canonical state
Gameplay/UI/Help/Timeline/Level Select
localization/assets/export/release/submission surfaces
```

Do not restore or execute the historical blocked task files 0023, 0023S or 0023U as active scopes.

## 20. Evidence and report

Use only:

```text
D:\Delayed_Self_Evidence\0023W_profile_filesystem_store_after_instance_gate\
```

Record:

- startup Git/environment facts;
- protected metadata before/after every major gate;
- all prerequisite and Task 0023W commands, stdout/stderr/exit codes and marker counts;
- compile-attempt ledger;
- interface/status contract;
- source-audit results;
- synthetic fixture hashes and metadata only for task-owned files;
- recovery collision and every failure-seam trace;
- exact replacement/rollback proof;
- exact owned path inventory and cleanup proof;
- changed/staged files and final Git state;
- explicit non-claims.

Create:

```text
docs/reports/0023W_PROFILE_FILESYSTEM_STORE_AFTER_INSTANCE_GATE_REPORT.md
```

Do not stage evidence, fixture files, generated logs or machine-local artifacts.

## 21. Git policy

Require one implementation commit:

```text
feat: add Delayed Self configured profile filesystem store
```

Stage authorized paths explicitly. Run `git diff --cached --check`. Fetch and verify no remote drift before pushing normally.

Finish with:

- clean worktree;
- `HEAD == origin/main`;
- divergence `0/0`;
- no Godot process;
- no task-owned fixture residue;
- production Profile metadata unchanged.

If the safety boundary or transactional rollback cannot be proven, do not commit a partial store implementation. Restore only Task 0023W changes to the accepted 0023V checkpoint and report the blocker without touching protected data.

## 22. Terminal verdict

Return exactly one:

```text
PROFILE_FILESYSTEM_STORE_AFTER_INSTANCE_GATE_READY_FOR_GPT_REVIEW
BLOCKED_PROFILE_FILESYSTEM_STORE_AFTER_INSTANCE_GATE
```

Include commit SHA if produced, compile attempts, assertion count, status/failure-seam matrix, replacement proof, production metadata, fixture cleanup, changed paths, evidence root and final Git state.

This task does not authorize production Profile access, AppRoot/MemoryProgress integration, aggregate, menus/settings/localization, build/export, RC, release, upload or festival submission.