# Task 0023 profile-test isolation amendment

- Applies to: `tasks/0023_persistent_local_profile_core_implementation.md`
- Authority: later, narrower correction; this file governs where the two files conflict
- Product scope change: none

## Required correction

Automated tests must not read the real production Profile, including for hashing.

Replace the Task 0023 Section 8 requirement:

```text
captures production-profile existence/hash/size/modified-time metadata
```

with:

```text
captures only production-profile existence, size, and modified-time metadata
```

A content hash, parse, copy, backup, open-for-read, or content comparison of `user://delayed_self_profile.json` is forbidden in automated tests and evidence collection. The invariant is proven through the test-only path allowlist, source audit, fixture traces, and unchanged non-content metadata. A pre-existing production Profile must remain unopened and untouched.

Synthetic fixture Profiles under `user://delayed_self_test_profiles/` may be read and hashed normally.

## Authorized-path formatting clarification

`tests/run_all.gd` is authorized by Task 0023. The leading space before that path in the Markdown code block has no semantic meaning.

All other Task 0023 requirements, stop conditions, terminal verdicts, and non-claims remain unchanged.
