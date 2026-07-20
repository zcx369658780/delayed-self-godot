# Task 0023ZQ — Validate production Profile policies in an isolated APPDATA sandbox

- Status: `READY`
- Gate: `PROTECTED PLAYER DATA / ISOLATED APPDATA PRODUCTION POLICY MATRIX + ZERO REAL-USER-DATA CONTACT`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- GPT prerequisite acceptance: `docs/reports/0023ZP_GPT_PRODUCTION_PROFILE_STATIC_BOOTSTRAP_ACCEPTANCE.md`
- Required checkpoint: `59c9f77d7a744e34ce55a415878b0e03bf28bd02`
- Accepted implementation under test: `afe8c6fffdc98992b732fce46f206ad0dc8553a1`
- Real production Profile authority: **none**
- Test-root authority: **none**
- Authorized filesystem behavior: only exact external APPDATA sandboxes under the evidence root defined below

## 1. Objective

Build and execute a deterministic behavior matrix for the accepted production Profile composition/API seam while proving that every `user://` operation is redirected into a process-local external sandbox.

The task must validate runtime behavior for:

```text
bootstrap policy selection
+ production read-only boot
+ production write-on-intent boot
+ missing / valid / sanitizable / malformed / unsupported sources
+ NO_CHANGE
+ first intentional replacement with activation backup
+ recovery preservation
+ write-disable behavior
+ production rejection of test-only reset/failure seams
+ transactional failure rollback
```

The current project main scene must remain the memory-only AppRoot. The real production Profile, its metadata, its parent directory, and `user://delayed_self_test_profiles/` remain completely closed.

## 2. Startup and authority checks

Before creating files or running Godot:

1. require absolute root `D:\Delayed_Self`, branch `main`, expected origin and no Git operation in progress;
2. require a clean tracked/untracked worktree and no staged changes;
3. fetch and fast-forward only;
4. require `HEAD == origin/main` and ancestry of checkpoint `59c9f77d7a744e34ce55a415878b0e03bf28bd02`;
5. require ancestry of implementation `afe8c6fffdc98992b732fce46f206ad0dc8553a1`;
6. read the full 0023ZO plan, 0023ZP task/report/GPT acceptance, and all CURRENT authority documents;
7. require zero residual Godot processes;
8. freeze hashes for all product source, scenes, project settings, historical tests/harnesses, catalog and formal data.

Stop on divergence, dirty state, missing authority, unexpected process residue or any request to resume a historical task.

## 3. Absolute protected-data boundary

### 3.1 Never access real player data

Do not open, read, parse, hash, compare, copy, rename, back up, delete, reset, repair, write, stat or refresh metadata for:

```text
user://delayed_self_profile.json
```

when `user://` resolves to the ordinary project user-data directory.

Do not enumerate, inspect or probe:

- the ordinary production user-data directory;
- the real Profile parent directory;
- `user://delayed_self_test_profiles/`;
- any historical fixture path;
- any sibling of the real production Profile.

Do not record the ordinary user-data absolute path in repository or external evidence.

### 3.2 Process-local sandbox only

All behavior processes must receive process-local environment overrides, never persistent user/machine environment changes:

```text
APPDATA=<exact attempt sandbox appdata root>
LOCALAPPDATA=<exact attempt sandbox localappdata root>
DELAYED_SELF_0023ZQ_EXECUTION_GUARD=TASK_0023ZQ_EXECUTE
DELAYED_SELF_0023ZQ_ATTEMPT=<attempt id>
```

Forbidden:

- `setx`;
- user- or machine-scope environment mutation;
- registry changes;
- shell profile changes;
- changing the repository project name or custom-user-dir settings;
- symlinks, junctions or redirects to ordinary user-data locations.

Before any Profile configuration or filesystem operation in each behavior process, the harness must prove:

1. the guard is exact;
2. `OS.get_user_data_dir()` is absolute;
3. the normalized user-data directory is strictly inside the exact attempt APPDATA sandbox;
4. it is not equal to the APPDATA root itself;
5. the expected Profile target is exactly `<attested user-data-dir>/delayed_self_profile.json`;
6. no path segment escapes with `..`;
7. the external evidence/sandbox root is outside the repository;
8. the repository path is not inside the sandbox.

If attestation fails, emit the guard/attestation block marker and quit before any `FileAccess`, `DirAccess`, production configuration, scene instantiation or fixture creation.

The attestation output must be bounded and must not print the absolute path.

## 4. Evidence root and exact owned sandboxes

Use only:

```text
D:\Delayed_Self_Evidence\0023ZQ_isolated_production_policy_matrix\
```

Owned attempt roots:

```text
attempt_1\
attempt_2\
```

Each attempt may own only:

```text
<attempt>\appdata\
<attempt>\localappdata\
<attempt>\case_data\
<attempt>\stdout\
<attempt>\stderr\
<attempt>\audit\
```

The Profile target and production-owned siblings must exist only beneath the attested sandbox user-data directory.

Before each attempt, require the attempt root absent. Create it exactly. After the attempt, delete only the owned `appdata`, `localappdata`, and `case_data` trees after retaining required evidence. Never enumerate or clean any parent outside the exact task evidence root.

## 5. Frozen product implementation

Do not modify any product source, scene or project configuration in this task, including:

```text
scripts/app/app_bootstrap.gd
scenes/app/app_bootstrap.tscn
scripts/app/app_root.gd
scripts/app/local_profile.gd
scripts/app/profile_codec.gd
scripts/app/profile_progress_adapter.gd
scripts/app/memory_progress.gd
scripts/app/route_request.gd
project.godot
```

Also freeze all UI/gameplay scenes, catalog/formal data, Simulation/solver/schema, historical tests, manifests, runners and task files.

A runtime failure is evidence for a later diagnostic/repair task. Do not repair product behavior or weaken expectations here.

## 6. Authorized new harness paths

Only these test artifacts may be added:

```text
tests/app/task_0023zq_isolated_production_policy_case.gd
tests/app/task_0023zq_isolated_production_policy_parser_smoke.gd
tests/app/task_0023zq_isolated_production_policy_validator.gd
tests/app/task_0023zq_isolated_production_policy_manifest.json
tests/app/task_0023zq_capture_isolated_production_policy.ps1
```

Report/current documentation paths:

```text
docs/reports/0023ZQ_ISOLATED_PRODUCTION_POLICY_SANDBOX_MATRIX_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/production/COMPLETE_FLOW_PRODUCTION_CLOSURE_PLAN_CURRENT.md
```

Do not modify any other repository path.

## 7. Harness architecture

### 7.1 Case process

`task_0023zq_isolated_production_policy_case.gd` must:

- extend `SceneTree`;
- require exactly one allowlisted case ID supplied by an engine argument or bounded environment variable;
- perform sandbox attestation before any Profile or scene operation;
- use only the accepted production configuration APIs and production target constant;
- never call `configure_test()`, `configure_test_profile()`, `build_test_profile_path()` or any test-root helper;
- create/read/write only exact case-owned paths inside the attested sandbox;
- emit deterministic stage/case/assertion markers;
- emit no raw Profile content, absolute path, unsupported numeric version, raw filesystem error, store object or adapter object;
- stop on first failed assertion;
- leave exact cleanup evidence for the runner.

### 7.2 Manifest

The JSON manifest must freeze:

- schema version;
- ordered stage IDs;
- unique case IDs;
- expected terminal status for every case;
- whether target creation, target mutation, recovery sibling, activation backup, transaction sibling and write-disable are expected;
- exact expected marker cardinalities;
- required evidence files;
- forbidden disclosure tokens/categories.

Do not guess an assertion count in prose. The implemented manifest must declare the exact deterministic count, and the validator must prove one-to-one correspondence between executable assertions and manifest case IDs.

### 7.3 Parser smoke and static validator

The parser smoke may only parse/preload the five new harness files and accepted product artifacts. It performs no sandbox or Profile operation.

The validator must prove at minimum:

1. all five authorized harness artifacts exist;
2. case IDs and stages are unique and one-to-one with the manifest;
3. attestation executes before every filesystem/Profile/configuration call;
4. guard failure exits before behavior start;
5. no test configuration or test-root API is referenced;
6. no ordinary user-data path is embedded or queried;
7. production target remains hard-coded only in the store;
8. all product/frozen hashes match the 0023ZP accepted implementation;
9. project main scene and autoload state remain unchanged;
10. runner sets only process-local APPDATA/LOCALAPPDATA overrides;
11. runner never uses persistent environment mutation;
12. runner owns and cleans only exact attempt paths;
13. attempt 2 cannot run after attempt 1 failure or incomplete cleanup;
14. every write-expected case has a target/sibling/rollback audit;
15. every no-write case has byte/hash/length/timestamp and sibling-absence proof inside the sandbox;
16. all outputs are bounded and forbidden disclosures are rejected;
17. exact deterministic assertion and marker counts are printed.

## 8. Mandatory behavior matrix

The manifest may split these into additional bounded assertions, but it must include every behavior below without weakening exactness.

### 8.1 Bootstrap policy

1. **memory default** — unconfigured bootstrap previews/uses `MEMORY_ONLY`.
2. **development direct** — a valid direct-level request forces effective memory-only even after a production policy was selected.
3. **invalid direct** — an invalid direct request forces effective memory-only.
4. **normal production composition** — with no user arguments and an allowlisted production policy, AppRoot is configured before tree entry, exactly one AppRoot is added, and bootstrap owns no route/store behavior.

### 8.2 `PRODUCTION_READ_ONLY`

5. **missing target** — `MISSING_CLEAN`; Main Menu/runtime default; no target, directory-owned Profile file or sibling created.
6. **valid partial target** — `LOADED`; exact normalized progress; target bytes/hash/length/timestamp unchanged; no sibling.
7. **valid completed target** — `LOADED`; all accepted progress hydrates; target unchanged; no sibling.
8. **sanitizable target** — `SANITIZED_PENDING_RECOVERY`; only known normalized progress hydrates; source unchanged; no recovery or other sibling.
9. **malformed/truncated target** — bounded `RECOVERY_REQUIRED_READ_ONLY` and AppRoot safe error; source unchanged; no sibling.
10. **unsupported integer schema** — bounded `UNSUPPORTED_VERSION_READ_ONLY` and AppRoot safe error; source unchanged; no sibling; unsupported number never disclosed.
11. **write/reset/seam rejection** — persistence, recovery helpers reachable through public behavior, reset and failure seam are rejected before mutation.

### 8.3 `PRODUCTION_WRITE_ON_INTENT`

12. **missing boot** — `MISSING_CLEAN`; no target or sibling at boot.
13. **valid boot** — `LOADED`; target unchanged and no sibling before an intentional completion.
14. **NO_CHANGE** — prepared no-change exits before store persistence, adapter commit, recovery, activation backup, transaction or target mutation.
15. **first intentional write over valid target** — exactly one durable activation backup is created before target replacement; target becomes canonical intended data; adapter commits only after persistence succeeds; no recovery sibling is created.
16. **sanitizable then intentional write** — boot performs no write; later write preserves the original source through the required bounded recovery sibling, creates the required activation backup before replacement, writes canonical intended data and retains both durable preservation artifacts.
17. **malformed write-enabled boot** — exactly one bounded recovery copy is created; target remains byte-identical during boot; clean fallback loads; no activation backup or target replacement occurs merely by booting.
18. **unsupported write-enabled boot** — exactly one bounded recovery copy is created; target remains byte-identical; clean fallback status is bounded; process writes are disabled; later persist is rejected without target mutation or new sibling.
19. **recovery collision bound** — occupied owned recovery names are skipped only within the bounded name limit; exhaustion fails closed with target unchanged and no unrelated deletion.
20. **activation-backup collision bound** — occupied owned activation-backup names are skipped only within the bounded name limit; exhaustion fails closed before target replacement.
21. **transaction failure rollback** — an authorized sandbox-only failure seam or deterministic filesystem arrangement causes replacement verification failure; adapter does not commit, target is restored or remains intact, temporary/transaction artifacts are cleaned only when owned, and subsequent unsafe writes are blocked when integrity is not proven.
22. **production test seams rejected** — `reset_test_profile()` and `set_test_failure_seam()` reject production mode before filesystem mutation.

## 9. Execution protocol

### 9.1 Pre-execution validation

Run in fresh Godot processes:

```text
0023ZQ parser smoke
0023ZQ static validator
0023ZP compile smoke
0023ZP static contract
0023R path policy
0023T codec compile + pure codec
0023V store configuration compile + pure configuration
0023X adapter compile + pure adapter
0023ZC parser + zero-I/O compile contract
0023ZF parser only
```

All must exit natively, stderr empty, required markers once, Godot process count zero before/after.

### 9.2 Guard proof

Run the case harness once without the exact environment guard:

- native exit 2;
- one `TASK_0023ZQ_EXECUTION_GUARD_BLOCKED` marker;
- zero sandbox-attested marker;
- zero behavior-start marker;
- zero Profile/fixture creation;
- stderr empty.

### 9.3 Two complete attempts

Run the canonical PowerShell capture runner twice from separately absent attempt roots.

Attempt 1 must complete every manifest stage/case, retain all evidence, audit to `PASS_COMPLETE_MATRIX`, and complete exact sandbox cleanup before Attempt 2 begins.

Attempt 2 must independently repeat the same complete matrix from an entirely absent sandbox and also audit to `PASS_COMPLETE_MATRIX`.

On the first assertion failure, non-native exit, stderr output, missing evidence, forbidden disclosure, sandbox escape, cleanup failure or unexpected file:

- emit one bounded abort marker;
- stop the current attempt;
- do not run Attempt 2;
- do not modify product source;
- preserve external evidence;
- return the blocked verdict after exact owned cleanup if safe.

### 9.4 Post-execution validation

After two complete passes:

- rerun parser smoke and static validator;
- rerun all named zero-I/O regressions;
- recheck all frozen hashes, project main scene and autoload state;
- require exact sandbox data-tree cleanup with retained evidence only;
- require zero Godot processes;
- require clean Git state before documentation/commit.

Do not run Task 0023W, any historical configured fixture, the 0023ZN canonical matrix, aggregate, `tests/run_all.gd`, project main scene, export or build.

## 10. Evidence requirements

Retain for each attempt:

- startup Git/process facts;
- process-local environment assignment audit with values redacted to bounded attempt IDs;
- sandbox attestation result;
- manifest and validator outputs;
- per-case stdout/stderr/exit facts;
- target pre/post byte/hash/length/timestamp facts for sandbox targets only;
- exact sibling-name category/count facts without absolute paths;
- AppRoot/bootstrap/store/adapter bounded snapshots;
- marker cardinality audit;
- forbidden-disclosure scan;
- exact cleanup audit;
- final process/frozen-hash/Git facts.

Never include raw Profile JSON or absolute ordinary user-data paths in Git or retained evidence.

## 11. Stop conditions

Stop without product repair on any:

- real production Profile or ordinary user-data access;
- test-root or historical fixture access;
- sandbox attestation failure after any filesystem/Profile call;
- environment mutation outside the child process;
- symlink/junction/reparse-point escape;
- product/project/historical harness change;
- behavior mismatch;
- target or preservation artifact outside the exact sandbox;
- raw content/path/version/error disclosure;
- unauthorized deletion or cleanup;
- incomplete evidence;
- residual Godot process;
- remote divergence.

A protected-data boundary breach requires immediate stop and no repository commit.

## 12. Repository output

On two complete passing attempts, create:

```text
docs/reports/0023ZQ_ISOLATED_PRODUCTION_POLICY_SANDBOX_MATRIX_REPORT.md
```

The report must include exact changed paths, manifest cardinalities, both complete attempt classifications, all scenario outcomes, sandbox attestation/cleanup proof, frozen hashes, zero-real-data statement and explicit non-claims.

Commit authorized paths only with:

```text
test: validate Delayed Self production policies in isolated sandbox
```

Push normally after `git diff --cached --check`, remote-drift check and final clean/process audit.

## 13. Terminal verdict and non-claims

Return exactly one:

```text
ISOLATED_PRODUCTION_POLICY_SANDBOX_MATRIX_READY_FOR_GPT_REVIEW
BLOCKED_ISOLATED_PRODUCTION_POLICY_SANDBOX_MATRIX
```

A passing result establishes only production-policy behavior inside two external isolated APPDATA sandboxes. It does not authorize or establish access to the existing production Profile, recovery or write against real player data, default activation, aggregate registration, Menu New/Continue/Reset, settings/localization, build/export, RC, release, upload or festival submission readiness.
