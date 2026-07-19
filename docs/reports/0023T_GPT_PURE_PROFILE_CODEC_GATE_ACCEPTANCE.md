# Task 0023T GPT pure Profile codec gate acceptance

- Reviewed commit: `8556cf7a82142b81ef321b01519542bc82900f09`
- Verdict: `TASK_0023T_PURE_PROFILE_CODEC_GATE_ACCEPTED`
- Product/Profile filesystem implementation: none
- AppRoot/MemoryProgress/aggregate integration: none

## Accepted scope

Task 0023T successfully separated the prior compile/type blocker from all Profile filesystem and product integration work.

The accepted implementation adds `scripts/app/profile_codec.gd` as an explicitly typed, zero-I/O pure helper. It provides:

```text
default_profile()
normalize_profile(raw_value, catalog_facts)
serialize_profile(profile)
build_progress_candidate(current_profile, level_id, turns, catalog_facts)
```

The codec owns only Profile v1 in-memory defaults, validation/sanitation, deterministic canonicalization/serialization, and candidate-progress construction. It has no Profile path, filesystem, resource, process, environment, AppRoot, scene, route, or MemoryProgress dependency.

The accepted Task 0023R path policy in `scripts/app/local_profile.gd` remains semantically unchanged.

## Accepted behavior

The codec:

- requires exact Profile schema version `1` and Dictionary root/progress/settings containers;
- accepts only unique, catalog-known completion IDs;
- iteratively removes completions whose prerequisite closure is absent;
- retains only positive integer best turns for retained completed IDs;
- validates `en|zh-Hans`, `windowed|fullscreen`, and Boolean reduced motion, defaulting invalid individual settings;
- never serializes unlocks or invents progress;
- sorts completion IDs and best-turn keys before serialization;
- produces byte-identical JSON for repeated equivalent canonical inputs;
- constructs progress candidates without mutating the input Profile;
- distinguishes `PROGRESS_REJECTED`, `NO_CHANGE`, and `CANDIDATE_READY`.

## Accepted evidence

```text
Task 0023R before: 123 assertions / 4 positive / 39 negative / exit 0 / stderr empty
Compile smoke: attempt 1 / exit 0 / stderr empty / marker once
Pure behavior: 34 assertions / exit 0 / stderr empty / marker once
Task 0023R after: 123 assertions / 4 positive / 39 negative / exit 0 / stderr empty
Prohibited I/O/integration audit: 0 hits
```

The production Profile remained observed only through existence, length and modification-time metadata. It remained `exists=true`, `Length=473`, and `LastWriteTimeUtc=2026-07-19T08:15:02.2089459Z`. The test-root existence fact also remained unchanged. No fixture or Profile file was opened or created.

## Adjudication

Accept the pure codec/type gate. Do not resume Task 0023 or Task 0023S.

The next gate is a separately bounded **test-fixture-only filesystem store**. It may extend `DelayedSelfLocalProfile` below the accepted static path-policy block and consume the accepted codec, but it must not yet:

- provide or exercise a production store factory;
- open the real production Profile;
- integrate AppRoot or MemoryProgress;
- modify existing product tests;
- run aggregate;
- implement menus, settings UI/application, localization, assets, export, release, or submission.

Only after the filesystem store is independently accepted may a later task authorize MemoryProgress/AppRoot integration and aggregate regression.

## Non-claims

This acceptance is not Profile filesystem, recovery, transaction, reset, process-restart, AppRoot, aggregate, menu/settings, production, export, release, or submission acceptance.

```text
TASK_0023T_PURE_PROFILE_CODEC_GATE_ACCEPTED
```
