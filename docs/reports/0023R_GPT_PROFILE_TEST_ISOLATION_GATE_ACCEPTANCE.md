# Task 0023R GPT Profile test-isolation gate acceptance

- Reviewed commit: `910535c9f7b1079e53d73ea2fd5b3feb7fe7655c`
- Verdict: `TASK_0023R_PROFILE_TEST_ISOLATION_GATE_ACCEPTED`
- Product persistence implementation accepted: no
- Next authority: one revised, persistence-core retry task with this gate as a mandatory precondition

## Accepted gate

The accepted canonical test Profile grammar is exactly:

```text
user://delayed_self_test_profiles/<fixture-id>/delayed_self_profile.json
```

where `fixture-id` is 1–64 ASCII characters matching:

```text
[A-Za-z0-9][A-Za-z0-9_-]{0,63}
```

The policy:

- rejects the production path explicitly;
- requires the exact trailing-slash test root;
- requires exactly two remainder segments;
- validates the fixture ID without normalization or decoding;
- requires the fixed Profile filename;
- rebuilds the canonical path and requires byte-for-byte equality;
- returns no usable `path` on rejection.

The four positive paths and 39 negative paths cover the required canonical, traversal, separator, prefix-spoofing, encoded, Unicode-lookalike, absolute, alternate-scheme, filename and suffix classes. Invalid builder inputs are deterministic and return no path.

## Accepted evidence

```text
assertions = 123
positive paths = 4
negative paths = 39
exit = 0
stderr = empty
TASK_0023R_PROFILE_TEST_ISOLATION_GATE_PASS = exactly once
```

The accepted source contains no Profile I/O, path normalization, AppRoot, MemoryProgress, scene or aggregate integration. The standalone test preloads only the policy class and invokes static functions.

Before and after execution, only production Profile existence, size and modification time were observed. They remained:

```text
exists = true
size = 473 bytes
modified time = unchanged
```

The production Profile was not opened, parsed, hashed, copied, renamed, backed up, repaired or deleted. The pre-existing test root was neither enumerated nor changed.

## Authority carried forward

The constants and static policy functions accepted in `scripts/app/local_profile.gd` are the mandatory authority for every later test fixture path. A revised persistence implementation may append storage behavior, but it must preserve the accepted path-policy block and independently rerun Task 0023R before any Profile I/O, AppRoot test, focused persistence suite or aggregate suite.

All automated Profile and AppRoot tests must use an exact path returned by `build_test_profile_path`. Validation failure must stop the test before any store construction or file operation; it may never fall back to `PRODUCTION_PROFILE_PATH`.

A later task must also provide a single test fixture helper and a source audit proving that AppRoot tests cannot instantiate an unconfigured production-path AppRoot. Production Profile content remains outside automated-test authority.

## Boundaries

This acceptance proves only virtual-path construction, rejection and the standalone no-I/O preflight. It does not accept Profile schema handling, loading, sanitation, recovery, writing, replacement, reset, AppRoot integration, process-restart persistence, aggregate isolation, menus, settings, localization, export, release or submission readiness.

The previously blocked Task 0023 remains closed and must not be resumed directly. A revised task is required.
