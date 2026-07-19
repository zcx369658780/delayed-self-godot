# Task 0023Z GPT AppRoot test-profile session unclassified-exit adjudication

- Reported terminal verdict: `BLOCKED_APP_ROOT_TEST_PROFILE_SESSION_RETRY`
- Repository state reviewed: remote `main` at `005c879248095d59250f08ac34a7c8c67e92ab07`
- Implementation commit: none
- Product-source change accepted: none
- Adjudication: `TASK_0023Z_BLOCKED_BY_UNCLASSIFIED_BEHAVIOR_PROCESS_EXIT`

## Reported result

Task 0023Z successfully passed both zero-I/O preflights:

1. the full behavior-script parser preload gate;
2. the off-tree AppRoot interface compile gate.

The first fixed-fixture behavior process then returned exit code 1. That run did not retain diagnostic output sufficient to classify the failure as an assertion failure, test-harness runtime error, AppRoot implementation error, frozen-dependency error, process crash, or data-safety fault.

The task prohibited blind repair after an unclassified behavior-stage failure. Codex therefore stopped and precisely rolled back all uncommitted Task 0023Z AppRoot/test changes.

Reported final state:

```text
tracked/untracked worktree clean
HEAD == origin/main
divergence = 0/0
production Profile metadata = true / 473 / 2026-07-19T08:15:02.2089459Z
Task 0023Z fixed fixture absent
residual Godot process = none
implementation commit = none
```

## GPT finding

This result closes the Task 0023Y parser-coverage gap but exposes a second task-design gap: **behavior-process observability and evidence retention were not mandatory enough to guarantee classification of an exit-1 run**.

No repository evidence identifies the failed stage, assertion, file, line, stack, or subsystem. Therefore this adjudication does not claim that AppRoot, the accepted store, the accepted adapter, Gameplay, or the test harness is defective.

The correct conclusion is:

```text
UNCLASSIFIED_BEHAVIOR_PROCESS_EXIT
```

not implementation rejection and not permission to guess.

## Closed task

Do not directly resume:

```text
tasks/0023Z_app_root_test_profile_session_retry_after_parser_gate.md
```

Task 0023Z is historical and blocked. Its fixture ID must not be reused.

The two Task 0023Y files remain historical blocked/superseded records and also must not be resumed.

## Frozen accepted authorities

Tasks 0023R, 0023T, 0023V, 0023W and 0023X remain accepted and unchanged. In particular:

- production Profile content remains unopened and protected;
- Task 0023W remains the accepted configured-instance test filesystem store;
- Task 0023X remains the accepted pure Profile-to-MemoryProgress adapter;
- normal unconfigured AppRoot remains memory-only;
- no production Profile activation, default persistence, aggregate registration, menu/settings/localization work, build/export, release, upload, or festival submission is authorized.

## Required next gate

A new Task 0023ZA may retry the bounded AppRoot test-profile session with an **instrumented diagnostic-first behavior gate**. Before the first behavior run it must require:

1. complete parser and interface preflights;
2. deterministic stage-begin/stage-pass markers in the behavior script;
3. assertion labels that include the active stage;
4. independent stdout and stderr redirection to retained evidence files;
5. an explicit exit-code record even when the process fails;
6. a retained pre-rollback worktree patch and hash after every failed behavior attempt;
7. exact owned-fixture cleanup evidence;
8. classification before any correction.

Only evidence-classified, contract-local corrections may be attempted. Unclassified exit, crash without diagnostic markers, frozen-dependency uncertainty, cross-layer inconsistency, or player-data safety uncertainty must stop without repair.

```text
TASK_0023Z_BLOCKED_BY_UNCLASSIFIED_BEHAVIOR_PROCESS_EXIT
```
