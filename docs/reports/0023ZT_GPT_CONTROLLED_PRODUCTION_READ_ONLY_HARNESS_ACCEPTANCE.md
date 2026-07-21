# Task 0023ZT GPT controlled production read-only harness acceptance

- Reviewed implementation commit: `09e83bc6e21aa2c6598043a5ea2dfa602953429d`
- Required predecessor: `7739ac26420e4c006b8fc6eba0f6b01a9d641ea1`
- Accepted product implementation under future observation: `afe8c6fffdc98992b732fce46f206ad0dc8553a1`
- GPT verdict: `TASK_0023ZT_CONTROLLED_PRODUCTION_READ_ONLY_HARNESS_ACCEPTED`
- Real production Profile access authorized by this acceptance: **none**

## Acceptance basis

The implementation changes only the five Task 0023ZT harness artifacts, its report and the authorized CURRENT documentation. Product source, scenes, project settings, the memory-only main scene, autoload state, catalog/formal data and accepted historical harnesses remain frozen.

The future Task 0023ZU execution is protected by three independent authority layers:

1. the PowerShell runner requires exact owner parameter `TASK_0023ZU_OWNER_AUTHORIZED_PRODUCTION_READ_ONLY`;
2. the runner requires the CURRENT authority document to name Task 0023ZU and status `OWNER_AUTHORIZED_CONTROLLED_PRODUCTION_READ_ONLY_EXECUTION` before ordinary user-data discovery;
3. the child process independently requires the exact environment guard and exact sole user argument before loading product code or performing any filesystem/configuration operation.

The future authorized branch is limited to one `PRODUCTION_READ_ONLY` composition and one guard-passing child process. It cannot select `PRODUCTION_WRITE_ON_INTENT`, persist, reset, recover, clean, restore or retry.

The future runner may retain only bounded load/boot/route classifications, completed/best-turn/unlocked counts, exact public progress-key count, target existence/length/UTC write-time before and after, and exact counts for four fixed owned sibling categories over indices 0–7. Raw Profile bytes/JSON, content hashes, completed IDs, best-turn values, settings, unsupported numeric version, ordinary absolute paths, sibling filenames, raw filesystem errors and store/adapter objects remain forbidden.

The runner performs no parent enumeration or wildcard search. It checks exactly 32 fixed sibling candidates before and after and requires exact equality. It performs no deletion, cleanup, copy, rename, restoration or rollback.

The parser smoke passed. The corrected static validator passed 123 assertions. All 14 authorized zero-I/O regressions passed. The GDScript missing-guard proof and runner missing-owner-authorization proof each exited 2 with empty stderr and no guard-passing child process. Production content, metadata, siblings, ordinary user-data discovery, test-root operations and future evidence-root creation remained zero.

## Verdict

```text
TASK_0023ZT_CONTROLLED_PRODUCTION_READ_ONLY_HARNESS_ACCEPTED
```

This acceptance establishes only that the dormant harness is sufficiently bounded for a future explicitly authorized execution task. It does not authorize or perform the real production read-only observation.

## Owner authorization boundary

Task 0023ZU must not be created or activated until the owner explicitly authorizes all of the following in one instruction:

- exactly one controlled `PRODUCTION_READ_ONLY` boot against the existing production Profile;
- reading Profile content only through the accepted product code path to derive bounded classifications and counts;
- reading exact target existence, byte length and UTC write time before and after;
- checking existence of exactly 32 fixed production-owned sibling candidates and retaining category counts only;
- creation of the fixed external evidence root;
- no write, recovery copy, activation backup, target replacement, reset, deletion, cleanup, retry or raw-content/path disclosure.

A narrower or ambiguous statement is not sufficient authorization.
