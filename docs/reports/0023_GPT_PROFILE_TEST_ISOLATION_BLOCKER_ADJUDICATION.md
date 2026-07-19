# Task 0023 GPT profile-test isolation blocker adjudication

- Reviewed terminal verdict: `BLOCKED_PERSISTENT_LOCAL_PROFILE_CORE`
- Repository checkpoint: `6e206e25e628477284e657d1dc05273639ee5aca`
- Verdict: `TASK_0023_BLOCKER_ACCEPTED_REQUIRE_ISOLATION_GATE_BEFORE_PROFILE_RETRY`
- Product implementation retained: none; failed implementation was fully rolled back
- Real production Profile: preserve in place; do not read, hash, copy, parse, rename, delete, repair, or reset

## Accepted evidence and boundary

The operator reported that the attempted test-path validator rejected a legal path under `user://delayed_self_test_profiles/`. Subsequent focused execution may therefore have fallen back to or otherwise touched the production path `user://delayed_self_profile.json`. Focused execution stopped at 103 assertions / 65 failures / exit 1, aggregate was not run, all repository implementation changes were rolled back, and no commit or push was produced.

The real Profile was not read, hashed, copied, or deleted. Only its current existence, size (473 bytes), and modified-time metadata were observed. Because the content was deliberately not inspected and no trusted pre-run content baseline exists, this adjudication makes no claim about whether the failed run changed the Profile contents. The file must remain in place as protected player data.

The native Windows overwrite-replacement probe succeeded on synthetic data and cleaned up. That result may be reused as supporting environment evidence later, but it does not validate test-path isolation or authorize Profile implementation.

## Root-cause classification

The exact failed implementation is not available for code review because it was correctly rolled back without commit. Therefore no exact faulty line is asserted. The established failure class is sufficient:

```text
LEGAL_TEST_USER_PATH_REJECTED
+ POSSIBLE_PRODUCTION_PATH_FALLBACK_OR_ACCESS
= PROTECTED_DATA_ISOLATION_GATE_FAILURE
```

Task 0023 and its later amendment required automated tests to operate only below `user://delayed_self_test_profiles/` and prohibited reading or modifying the real production Profile. The observed behavior triggered their hard stop conditions.

## Adjudication

Do not rerun Task 0023 and do not reimplement the complete Profile core yet.

Before any adapter I/O, AppRoot integration, focused Profile suite, or aggregate run, establish one separately reviewable isolation gate with these properties:

1. One canonical virtual-path policy accepts only a file shaped exactly as:

   ```text
   user://delayed_self_test_profiles/<nonempty-fixture-id>/delayed_self_profile.json
   ```

2. It rejects the production path, sibling-prefix spoofing, empty fixture IDs, dot/dot-dot segments, doubled separators, backslashes, `res://`, absolute OS paths, drive/UNC paths, wrong filenames, directories, and post-load reconfiguration.
3. The gate contains no file I/O and cannot fall back to the production path.
4. Its standalone preflight does not instantiate AppRoot or any Profile store and does not run aggregate tests.
5. Production-file invariance is checked only outside Godot by non-content metadata (existence, length, modified time). No automated test or evidence collector may open the production Profile.
6. Failure of the preflight stops all later Profile work.

The current production Profile becomes the protected baseline *as it exists now*. Future evidence may prove that its non-content metadata remains unchanged from this checkpoint; it may not claim restoration to a pre-failure state.

## Decision policy after the isolation gate

- If the standalone isolation gate passes and GPT accepts it, issue a revised complete Profile implementation task that must run the isolation preflight before any AppRoot/Profile test.
- If the gate cannot accept legal fixture paths while rejecting all escape classes without arbitrary production-path injection, stop Profile work for a fresh architecture decision.

## Boundaries

No Profile load/write/recovery/reset, AppRoot integration, menu/settings/localization, production-file cleanup, asset/audio work, build/export, release, upload, or submission is authorized by this adjudication.

```text
TASK_0023_BLOCKER_ACCEPTED_REQUIRE_ISOLATION_GATE_BEFORE_PROFILE_RETRY
```
