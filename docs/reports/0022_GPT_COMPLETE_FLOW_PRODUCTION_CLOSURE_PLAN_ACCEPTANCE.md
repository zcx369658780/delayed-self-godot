# Task 0022 GPT complete-flow production-closure plan acceptance

- Reviewed commit: `8d4918f2d49320e0eb55a9d4d67dd1a7139a18ba`
- Verdict: `TASK_0022_COMPLETE_FLOW_PRODUCTION_CLOSURE_PLAN_ACCEPTED`
- Selected first implementation slice: `PERSISTENT_LOCAL_PROFILE_CORE_WITH_ISOLATED_TESTS`
- Formal product scope: eight levels; sequence 8 remains sole final
- Product changes in this acceptance: none

## Accepted planning decisions

Task 0022 correctly orders production closure behind a protected-data foundation. The accepted sequence is:

1. local persistent Profile core and isolated tests;
2. New Game / Continue / Reset plus pause and confirmations;
3. persistent language, window-mode, and reduced-motion settings;
4. centralized English and Simplified-Chinese localization plus a separately licensed font decision and bounded narrative copy;
5. Credits/attribution, public-status accuracy, icon/splash, and explicit polish deferrals;
6. complete-flow machine/capture acceptance;
7. owner-only complete-flow walkthrough;
8. separately authorized Windows export/build validation.

The following scope decisions are accepted:

- audio/music: `OMIT_FOR_RC`;
- visual reskin: deferred;
- image Help: deferred and never a route walkthrough;
- Level 7 transition: disclosed residual limitation, no new room or geometry change;
- controller, Web, cloud/accounts, named slots, cutscenes, and display-scale UI: deferred;
- localization target: `en` plus `zh-Hans`, with no font import before a separate license/glyph/text-fit gate.

## Slice-1 architectural clarification

Preserve `DelayedSelfMemoryProgress` as the pure catalog-derived progress model with no file I/O. Add one bounded local Profile adapter/store that owns the versioned JSON, validation, recovery, transactional replacement, settings defaults, and persistence status. AppRoot may switch from direct `MemoryProgress` construction to this adapter, but the adapter must preserve the existing `snapshot`, `is_unlocked`, and `record_completion` semantics used by Level Select and finale routing.

The production path is fixed under `user://`; no runtime command-line or arbitrary filesystem path may redirect production data. Tests may configure only an explicit test-only `user://` subtree before the adapter is loaded. Every AppRoot/profile test must use a unique fixture path and prove the production profile is neither read nor written.

The initial stored root remains schema version 1 with `progress` and minimum future `settings` ownership. Slice 1 stores/defaults settings data but adds no Settings UI and applies no language, window, or reduced-motion change.

## Protected-data acceptance requirements

The implementation task must prove:

- missing profile -> clean in-memory v1 without eager file creation;
- bounded-size JSON parsing and exact schema-version/type validation;
- catalog-known, unique, prerequisite-consistent completed IDs;
- positive best turns only for retained completed IDs;
- invalid individual progress/settings values are deterministically sanitized without inventing progress;
- malformed, truncated, unreadable, or unknown-version input is never silently overwritten;
- a bounded same-directory recovery copy is retained before clean recovery; if preservation fails, the original remains untouched and boot enters a bounded Safe Error path;
- writes use a unique same-directory temp file, explicit write/flush/close, and a replace operation whose overwrite behavior is verified on the pinned Windows/Godot toolchain;
- replace failure leaves the previous valid target intact and removes only the temp file created by that attempt;
- completion and best-turn changes become active only when persistence succeeds; I/O failure is distinguishable from ordinary locked/invalid completion rejection;
- reset primitives may exist for tests/core integration, but no product Reset UI or destructive action is authorized in slice 1;
- catalog, all eight formal level files and metrics, Simulation, solver, Help, Timeline, finale acknowledgment, route behavior, and accepted markers remain exact.

Godot documentation states that `DirAccess.rename()`/`rename_absolute()` overwrites an existing writable destination and that `FileAccess.flush()`/explicit close are available for persistent file handling; the implementation must still record an actual pinned-toolchain Windows probe rather than relying on documentation alone. citeturn476677search0turn476677search1

## Boundaries

This acceptance does not authorize menu, pause, confirmation, Settings UI/application, localization, font acquisition/import, Credits, assets, icon/splash, audio, export, owner review, RC, release, upload, or festival submission work. It does not claim persistence correctness before implementation and machine evidence.

```text
TASK_0022_COMPLETE_FLOW_PRODUCTION_CLOSURE_PLAN_ACCEPTED
```
