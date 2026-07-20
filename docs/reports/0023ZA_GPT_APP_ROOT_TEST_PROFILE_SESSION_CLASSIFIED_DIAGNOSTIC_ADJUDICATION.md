# Task 0023ZA GPT AppRoot test-profile session classified-diagnostic adjudication

- Reviewed diagnostic commit: `d03f467a0db03307b0ca0e3f214f80f419ee7d33`
- Reported verdict: `BLOCKED_APP_ROOT_TEST_PROFILE_SESSION_DIAGNOSTIC_CLASSIFIED`
- Implementation commit: none
- Product/test source accepted: none
- Adjudication: `TASK_0023ZA_CLASSIFIED_APPROOT_FIX_DIRECTION_ACCEPTED_EVIDENCE_INCOMPLETE`

## Accepted diagnostic finding

Attempt 1 retained independent process output, exit code, protected metadata, fixture state, process state, and a pre-rollback binary patch with SHA-256. The retained marker was:

```text
TASK_0023ZA_ASSERT_FAIL stage=tutorial_0_persist label=persist_commit
```

The failure is accepted as `APPROOT_IMPLEMENTATION_CLASSIFIED`: in configured test-profile mode, AppRoot's existing public progress API exposed the Task 0023X adapter wrapper snapshot instead of the required public runtime progress shape.

The required public shape remains exactly:

```text
completed_level_ids
best_turns
unlocked_level_ids
```

A later implementation must return a defensive copy of the adapter's nested runtime snapshot in test-profile mode, while the normal memory-only path continues returning the existing MemoryProgress snapshot.

## Attempt 2 disposition

After one targeted AppRoot correction, Attempt 2 exited 0. This is supporting evidence that the classified correction direction is plausible and contract-local.

It is not acceptance because:

1. not every independently required capture file was retained;
2. the diagnostic behavior script covered only a reduced subset of the required matrix;
3. the complete TEMP_WRITE, TEMP_READBACK, REPLACE, POST_REPLACE_VERIFY, malformed recovery, unknown-version recovery, public-snapshot, cleanup, and repeat-clean-run evidence set was not established;
4. all AppRoot and test drafts were rolled back and no implementation commit exists.

No source can therefore be accepted from Attempt 2, and no AppRoot integration claim follows.

## Safety result

The final reported state is accepted:

```text
worktree clean
HEAD == origin/main
divergence = 0/0
production Profile metadata = true / 473 / 2026-07-19T08:15:02.2089459Z
production Profile content not accessed
Task 0023ZA fixture absent
residual Godot process = none
```

Tasks 0023R, 0023T, 0023V, 0023W, and 0023X remain accepted and unchanged.

## Closed task

Do not resume:

```text
tasks/0023ZA_app_root_test_profile_session_instrumented_diagnostic_retry.md
```

Its diagnostic evidence remains read-only external evidence. Its fixture ID must not be reused.

## Next gate

A new Task 0023ZB may rebuild the bounded AppRoot test-profile session from the clean accepted repository state. It must:

- encode the classified public-progress-shape correction as a mandatory contract, not rediscover it;
- use a new fixed fixture ID;
- qualify the external stdout/stderr/exit capture procedure before the first behavior run;
- retain all required capture files for successful and failed runs;
- execute the complete required behavior matrix;
- obtain two full clean-fixture passes before acceptance;
- preserve persistence-before-runtime-commit ordering and all accepted rollback contracts;
- keep production Profile activation and aggregate closed.

```text
TASK_0023ZA_CLASSIFIED_APPROOT_FIX_DIRECTION_ACCEPTED_EVIDENCE_INCOMPLETE
```
