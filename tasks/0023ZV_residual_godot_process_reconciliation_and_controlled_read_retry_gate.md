# Task 0023ZV — Reconcile Delayed Self preflight process residue and perform one newly authorized controlled read

- Status: `READY`
- Gate: `PROTECTED PLAYER DATA / OWNER-AUTHORIZED PROCESS RECONCILIATION + SINGLE READ-ONLY OBSERVATION`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Required checkpoint: `73006a43f71a5829a093b09ed9e318b054e674dc`
- Accepted harness: `09e83bc6e21aa2c6598043a5ea2dfa602953429d`
- Accepted product implementation: `afe8c6fffdc98992b732fce46f206ad0dc8553a1`
- Prior valid controlled-read child count: `0`
- New controlled-read child limit: **one**
- Retry authority: **none**
- Production write/recovery/reset authority: **none**

## 1. Owner authorization

The owner authorizes this bounded task to:

1. inspect only PID, executable identity/path and command line for the currently residual Godot processes;
2. classify whether each process is clearly attributable to the Delayed Self Task 0023ZU zero-I/O preflight;
3. terminate only processes whose Delayed Self preflight ownership is unambiguous;
4. stop without terminating an ambiguous, unrelated, editor, project-manager or possibly manual process;
5. after the Godot process count is proven zero, perform exactly one new `PRODUCTION_READ_ONLY` observation of the existing production Profile;
6. retain only the bounded classifications, counts and non-content metadata accepted by Task 0023ZT;
7. create the fixed external evidence roots;
8. preserve, reconcile and commit the eight locally retained Task 0023ZU blocker documentation paths.

The owner does not authorize any production write, recovery copy, activation backup, replacement, reset, deletion, cleanup, restoration, second read or retry. Raw Profile content, content hashes, IDs, best-turn values, settings, absolute Profile paths, sibling filenames and raw filesystem errors remain forbidden.

## 2. Exact continuation documents

At startup the only permitted dirty repository paths are:

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

Before any fetch or edit:

- require exactly this dirty-path set and no staged changes;
- record SHA-256, bytes, lines and tracked/untracked state;
- copy all eight files byte-identically to
  `D:\Delayed_Self_Evidence\0023ZV_process_reconciliation_and_controlled_read\continuation_inputs\`;
- verify the copies before restoring only those local documentation changes needed to allow a fast-forward.

Do not use broad reset/clean/stash operations. The preserved inputs must later be reconciled into current documentation without restoring stale 0023ZU active authority.

After preservation, fetch and fast-forward only. Require `HEAD == origin/main` and ancestry of the required checkpoint, accepted harness and accepted product implementation.

## 3. Process ownership gate

Inspect Godot processes only after the continuation documents are preserved.

Retain externally only bounded facts: PID, executable basename and boolean/token classifications. Do not retain raw executable paths or complete command lines in Git.

A process is terminable only when its executable identity and command line together prove all of the following:

- headless Godot execution;
- exact Delayed Self repository root;
- one exact zero-I/O preflight script named by Task 0023ZU;
- no editor, project-manager, interactive main-scene, export/build or other-project indicators.

Unavailable or conflicting process facts make the process ambiguous and non-terminable.

Classify the complete Godot process set before any termination. If any process is ambiguous or unrelated, stop without terminating any process and without performing the controlled read.

If every residual process is clearly owned by the Delayed Self preflight, revalidate ownership immediately before terminating only those identified processes. Do not use process-name-wide or wildcard termination. Perform one bounded termination phase only, then require the Godot process count to become zero. No termination retry is authorized.

If the initial count is already zero, record that fact and continue.

## 4. Protected-data sequencing

Production Profile content/metadata, ordinary user-data discovery, production sibling checks, the test root and the controlled-read evidence root remain closed until:

- continuation preservation and repository fast-forward are complete;
- process ownership is resolved;
- the Godot process count is zero;
- all frozen hashes match.

No product, harness, test or project-setting modification is authorized.

## 5. Accepted runner compatibility

Task 0023ZV is the actual active task. The CURRENT file may include one explicitly labeled compatibility block containing the exact Task 0023ZU task/status strings required by the frozen Task 0023ZT runner. Those strings are runner tokens only and must not describe Task 0023ZU as active or resumed.

Do not modify the accepted Task 0023ZT runner or observation script.

## 6. Exactly one newly authorized observation

After all gates pass, invoke the accepted Task 0023ZT runner exactly once with its exact owner authorization value and resolved Godot executable.

- valid runner invocation count: exactly one;
- guard-passing controlled-read child count: at most one, and once started exactly one;
- authorization consumed when that child starts, regardless of result;
- direct valid-guard observation invocation, alternate commands and retries are forbidden.

The only product policy is `PRODUCTION_READ_ONLY`.

Allowed retained observations are exactly:

```text
load_status / boot_status / route
completed_count / best_turn_count / unlocked_count
public_progress_key_count
target exists / length / last_write_time_utc before and after
recovery / activation_backup / temp / transaction category totals before and after
native exit / stderr byte count / bounded marker counts
```

The runner may check only the 32 fixed owned sibling candidates already frozen by Task 0023ZT. Target metadata and all category totals must be identical before and after. No directory enumeration or wildcard search is authorized.

## 7. Evidence

Use:

```text
D:\Delayed_Self_Evidence\0023ZV_process_reconciliation_and_controlled_read\
D:\Delayed_Self_Evidence\0023ZU_controlled_production_read_only\
```

Do not delete the retained evidence and do not place external evidence in Git.

## 8. Classifications

Use one bounded classification:

```text
PASS_CONTROLLED_PRODUCTION_READ_ONLY_OBSERVATION
BLOCKED_PROCESS_OWNERSHIP_AMBIGUOUS
BLOCKED_PROCESS_TERMINATION_INCOMPLETE
BLOCKED_BEFORE_AUTHORIZED_CHILD_START
CONTROLLED_PRODUCTION_READ_ONLY_OBSERVATION_NONPASS_NO_RETRY
PROTECTED_DATA_BOUNDARY_BREACH
```

Ambiguity stops before termination. Process reconciliation failure stops before the read. A child-start nonpass consumes authorization and forbids retry.

## 9. Repository outputs

Authorized final paths are exactly:

```text
docs/reports/0023ZU_CONTROLLED_PRODUCTION_READ_ONLY_OBSERVATION_REPORT.md
docs/reports/0023ZV_PROCESS_RECONCILIATION_AND_CONTROLLED_READ_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/production/COMPLETE_FLOW_PRODUCTION_CLOSURE_PLAN_CURRENT.md
```

The 0023ZU report must preserve the original `BLOCKED_BEFORE_AUTHORIZED_CHILD_START` result. The 0023ZV report records only bounded process classifications, authorized termination outcomes and the new controlled-read result.

Commit only these documentation paths with:

```text
docs: reconcile Delayed Self controlled-read preflight and record authorized observation
```

## 10. Stop conditions

Stop on any unexpected dirty path, failed continuation preservation, ambiguous process, unresolved process residue, premature player-data contact, execution count above one, write/recovery/reset/delete action, enumeration/glob, forbidden disclosure, test-root access, source/harness/project modification, unexpected evidence-root state, metadata/sibling change or remote divergence.

Do not diagnose or repair product behavior.

## 11. Terminal verdict

Return exactly one:

```text
PROCESS_RECONCILIATION_AND_CONTROLLED_READ_READY_FOR_GPT_REVIEW
BLOCKED_PROCESS_RECONCILIATION_OR_CONTROLLED_READ_NO_RETRY
PROTECTED_DATA_BOUNDARY_BREACH
```

A pass establishes only bounded process reconciliation and one controlled read-only observation. It does not authorize recovery, first write, default activation, aggregate registration, Menu flow, settings/localization, build/export, RC, release, upload or festival submission.