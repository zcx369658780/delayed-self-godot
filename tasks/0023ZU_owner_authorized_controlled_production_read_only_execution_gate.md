# Task 0023ZU — Execute exactly one owner-authorized controlled production Profile read-only observation

- Status: `READY`
- Gate: `PROTECTED PLAYER DATA / OWNER-AUTHORIZED SINGLE PRODUCTION READ-ONLY OBSERVATION`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- GPT prerequisite acceptance: `docs/reports/0023ZT_GPT_CONTROLLED_PRODUCTION_READ_ONLY_HARNESS_ACCEPTANCE.md`
- Required checkpoint: `e474294604ab937abce4692e0969a177d4efefde`
- Accepted harness implementation: `09e83bc6e21aa2c6598043a5ea2dfa602953429d`
- Accepted product implementation under observation: `afe8c6fffdc98992b732fce46f206ad0dc8553a1`
- Maximum guard-passing observation processes: **exactly one**
- Retry authority: **none**
- Write/recovery/reset authority: **none**

## 1. Owner authorization

The owner explicitly authorizes Task 0023ZU to perform exactly one controlled `PRODUCTION_READ_ONLY` boot against the existing production Profile.

The authorization permits:

1. reading Profile content only through the accepted product-code path;
2. retaining only bounded load/boot/route classifications, completed/best-turn/unlocked counts and public progress-key count;
3. observing before and after the target's existence, byte length and UTC modification time;
4. checking exactly 32 fixed owned sibling candidates: categories `recovery`, `activation_backup`, `temp`, `transaction`, indices `0..7`, retaining category counts only;
5. creating the fixed external evidence root:

```text
D:\Delayed_Self_Evidence\0023ZU_controlled_production_read_only\
```

The owner explicitly does **not** authorize:

- any Profile or sibling write;
- recovery-copy or activation-backup creation;
- target replacement;
- reset, deletion, cleanup, restoration or rollback;
- a second execution or any failure retry;
- retention of raw Profile content, content hashes, completed IDs, best-turn values, settings, unsupported numeric versions, absolute paths, sibling filenames or raw filesystem errors.

This authorization is exhausted as soon as the single guard-passing child process is started, regardless of its exit status or result.

## 2. Objective

Execute the already accepted inert Task 0023ZT runner exactly once and retain only the bounded observations authorized above.

The task establishes one of these bounded outcomes:

```text
MISSING_CLEAN / PRODUCTION_PROFILE_READY / MAIN_MENU
LOADED / PRODUCTION_PROFILE_READY / MAIN_MENU
SANITIZED_PENDING_RECOVERY / PRODUCTION_PROFILE_READY / MAIN_MENU
RECOVERY_REQUIRED_READ_ONLY / FAILED_RECOVERY_REQUIRED_READ_ONLY / SAFE_ERROR
UNSUPPORTED_VERSION_READ_ONLY / FAILED_UNSUPPORTED_VERSION_READ_ONLY / SAFE_ERROR
```

No product, harness or behavior repair is authorized.

## 3. Startup and authority checks

Before any ordinary user-data discovery, Profile metadata observation, sibling check or evidence-root creation:

1. require absolute root `D:\Delayed_Self`, branch `main`, expected origin and no Git operation in progress;
2. require a clean tracked/untracked/staged worktree;
3. fetch and fast-forward only;
4. require `HEAD == origin/main` and ancestry of checkpoint `e474294604ab937abce4692e0969a177d4efefde`;
5. require ancestry of harness commit `09e83bc6e21aa2c6598043a5ea2dfa602953429d` and product commit `afe8c6fffdc98992b732fce46f206ad0dc8553a1`;
6. read the complete 0023ZO plan, 0023ZS acceptance, 0023ZT task/report/GPT acceptance, the five accepted 0023ZT harness files and all CURRENT authority documents;
7. require `docs/CODEX_ACTIVE_TASK_CURRENT.md` to contain exactly Task `0023ZU` and status `OWNER_AUTHORIZED_CONTROLLED_PRODUCTION_READ_ONLY_EXECUTION` as required by the runner;
8. require zero residual Godot processes;
9. require the fixed future evidence root absent;
10. freeze hashes for all product source, scenes, project settings, catalog/formal data, historical harnesses and the five 0023ZT harness files.

Stop before ordinary data discovery if any check fails. No retry task or alternate execution is implied.

## 4. Absolute execution limits

### 4.1 Exactly one execution

Run exactly one command equivalent to:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tests/app/task_0023zt_capture_controlled_production_read_only.ps1 `
  -OwnerAuthorization TASK_0023ZU_OWNER_AUTHORIZED_PRODUCTION_READ_ONLY `
  -GodotExe <resolved Godot executable>
```

The invocation count of the runner with the valid owner authorization must be exactly one.

The count of child processes receiving both valid child guards must be at most one and, once started, exactly one.

Do not run the observation GDScript directly with valid guards. Do not duplicate, wrap, repeat or replay the runner invocation.

### 4.2 No retry after any result

After the valid runner invocation begins, do not rerun for:

- nonzero exit;
- stderr output;
- unexpected load classification;
- metadata mismatch;
- sibling mismatch;
- disclosure rejection;
- missing evidence;
- process residue;
- tool interruption;
- suspected transient failure.

Preserve bounded evidence and stop. A later action requires a new explicit owner authorization.

### 4.3 Read-only boundary

The only product policy is `PRODUCTION_READ_ONLY`.

Do not invoke or authorize:

```text
PRODUCTION_WRITE_ON_INTENT
persist_profile
recovery-copy helpers
activation-backup helpers
reset_test_profile
set_test_failure_seam
transaction/replace/rollback helpers
```

Do not create, modify, copy, rename, delete, clean, restore or repair the production target or any production sibling.

Do not access `user://delayed_self_test_profiles/` or any historical fixture.

## 5. Fixed metadata and sibling observations

The runner may derive the ordinary target only after all owner/CURRENT authority gates pass.

Allowed target facts before and after are exactly:

```text
exists
length
last_write_time_utc
```

Allowed sibling checks are exactly these 32 `-LiteralPath` candidates:

```text
.delayed_self_profile_recovery_0.json       ... _7.json
.delayed_self_profile_activation_backup_0.json ... _7.json
.delayed_self_profile_temp_0.json           ... _7.json
.delayed_self_profile_transaction_0.json    ... _7.json
```

Retain only category totals before and after. Do not retain candidate paths or filenames.

Parent enumeration, wildcard/glob search, recursive search and unrelated sibling checks are forbidden.

Target metadata and all four sibling-category totals must be exactly equal before and after. If the target is absent before, it must remain absent after.

## 6. Bounded child observation

The child process must receive exactly:

```text
DELAYED_SELF_0023ZU_PRODUCTION_READ_AUTHORIZATION=TASK_0023ZU_OWNER_AUTHORIZED_PRODUCTION_READ_ONLY
--task-0023zu-controlled-production-read-only
```

It may load only the accepted bootstrap/product path, configure exactly `PRODUCTION_READ_ONLY`, add exactly one composition root, wait the fixed three frames and inspect only bounded public snapshots.

Allowed retained child outputs are exactly:

```text
load_status
boot_status
route
completed_count
best_turn_count
unlocked_count
public_progress_key_count
observation_started marker count
observation_pass marker count
native exit
stderr byte count
```

Forbidden retained outputs include raw dictionaries, arrays, JSON, bytes, IDs, best-turn values, settings, raw errors, paths, filenames, store/adapter objects or unsupported numeric version.

## 7. Evidence handling

Create only:

```text
D:\Delayed_Self_Evidence\0023ZU_controlled_production_read_only\stdout.txt
D:\Delayed_Self_Evidence\0023ZU_controlled_production_read_only\stderr.txt
D:\Delayed_Self_Evidence\0023ZU_controlled_production_read_only\audit.json
D:\Delayed_Self_Evidence\0023ZU_controlled_production_read_only\engine.log
```

The runner may create these files only after the owner/CURRENT gates pass.

Do not clean or delete the evidence root after execution. Do not place external evidence in Git.

If disclosure validation fails, do not copy unbounded stdout/stderr into any new file or repository report. Retain only the bounded audit facts the runner safely writes.

## 8. Validation surrounding the single read

Before the single authorized execution, only zero-I/O checks are allowed:

```text
0023ZT parser smoke
0023ZT static validator (123 assertions)
0023ZP compile smoke + static contract
0023ZS parser smoke + static validator
0023R path policy
0023T codec compile + pure codec
0023V store configuration compile + pure configuration
0023X adapter compile + pure adapter
0023ZC parser + zero-I/O compile contract
0023ZF parser only
```

All 14 required checks/processes must pass with native expected exits, empty stderr, required marker once and zero residual Godot processes.

Do not run the 0023ZT negative authorization proofs after CURRENT is activated for 0023ZU if doing so could create ambiguity in execution accounting. Do not run any valid-guard proof before the one authorized execution.

After the single execution, do not rerun the product observation. Static/zero-I/O checks may be rerun only if they do not inspect ordinary data or the evidence root and are necessary for closeout; they cannot justify or trigger a retry.

## 9. Classification

Classify the single run as one of:

```text
PASS_CONTROLLED_PRODUCTION_READ_ONLY_OBSERVATION
BLOCKED_BEFORE_AUTHORIZED_CHILD_START
CONTROLLED_PRODUCTION_READ_ONLY_OBSERVATION_NONPASS_NO_RETRY
PROTECTED_DATA_BOUNDARY_BREACH
```

- `PASS_CONTROLLED_PRODUCTION_READ_ONLY_OBSERVATION` requires native exit 0, empty stderr, exact markers, one allowed outcome, metadata equality, sibling-count equality, no disclosure and zero residual processes.
- `BLOCKED_BEFORE_AUTHORIZED_CHILD_START` means startup/preflight stopped before the valid child began; do not execute an alternate command.
- `CONTROLLED_PRODUCTION_READ_ONLY_OBSERVATION_NONPASS_NO_RETRY` means the single authorized child started but did not meet the complete pass contract; the authorization is consumed and no retry is allowed.
- `PROTECTED_DATA_BOUNDARY_BREACH` requires immediate stop, no repair and no repository commit beyond already published authority.

## 10. Repository output

If no protected-data boundary breach occurred, create exactly:

```text
docs/reports/0023ZU_CONTROLLED_PRODUCTION_READ_ONLY_OBSERVATION_REPORT.md
```

The report may contain only:

- execution count and classification;
- bounded load/boot/route classifications;
- progress counts and public-key count;
- target existence/length/UTC-write-time before/after and equality result;
- four sibling-category totals before/after and equality result;
- native exit, stderr-byte and marker counts;
- zero-write statement;
- frozen-hash/process/Git facts;
- explicit no-retry statement and non-claims.

It must not contain raw content, hashes, IDs, values, settings, paths, filenames or raw errors.

Authorized documentation paths after execution are:

```text
docs/reports/0023ZU_CONTROLLED_PRODUCTION_READ_ONLY_OBSERVATION_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/production/COMPLETE_FLOW_PRODUCTION_CLOSURE_PLAN_CURRENT.md
```

Do not modify product source, harnesses, project settings, tests or any other path.

Commit bounded documentation only with:

```text
docs: record Delayed Self controlled production read-only observation
```

Push normally after staged-path, diff-check, remote-drift, process and worktree audits. A nonpass result may still be documented and pushed, but must remain explicitly no-retry.

## 11. Stop conditions

Stop immediately on:

- execution count above one;
- any write/recovery/reset/delete/cleanup attempt;
- parent enumeration, glob or unrelated sibling probing;
- raw content/path/value disclosure;
- test-root or historical fixture access;
- harness/product/project modification;
- unexpected evidence-root preexistence;
- protected metadata or sibling change;
- residual Godot process;
- remote divergence.

Do not diagnose or repair product behavior in this task.

## 12. Terminal verdict

Return exactly one:

```text
CONTROLLED_PRODUCTION_READ_ONLY_OBSERVATION_READY_FOR_GPT_REVIEW
BLOCKED_CONTROLLED_PRODUCTION_READ_ONLY_OBSERVATION_NO_RETRY
PROTECTED_DATA_BOUNDARY_BREACH
```

A passing result establishes only one controlled read-only observation of the existing Profile. It does not authorize recovery, first write, default activation, aggregate registration, Menu New/Continue/Reset, settings/localization, build/export, RC, release, upload or festival submission.