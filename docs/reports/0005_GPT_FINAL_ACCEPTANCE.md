# Task 0005 GPT final acceptance

- Verdict: `TASK_0005_SYSTEM_SKELETON_AND_TUTORIAL_PLANNING_ACCEPTED`
- Accepted planning commit: `0de8fa7435dc1024f35161d90cd03419a53730dd`
- Accepted task: `tasks/0005_system_skeleton_and_tutorial_level_planning.md`
- Acceptance date: 2026-07-14
- Accepted by: GPT Project Sources advisor

## Review basis

GitHub review confirmed that the planning implementation is exactly one commit ahead of the Task 0005 issue point and changes exactly the eleven authorized Markdown paths. No runtime, scene, formal level, schema, test, project setting, asset, save, export, build, plugin, dependency, license, release, submission, or prior accepted artifact changed.

The package consistently distinguishes `ACCEPTED_EXISTING_FACT`, `PLANNING_RECOMMENDATION_FOR_GPT`, `UNVERIFIED_DESIGN_TARGET`, `DEFERRED_POST_MVP`, and `OUT_OF_SCOPE`. It does not report proposed levels, target shortest-path bands, catalog fields, architecture names, or future tasks as implemented or solver-evidenced facts.

## Accepted planning decisions

The following recommendations are accepted as the implementation baseline for Task 0006 and later separately authorized gates:

1. Use a thin application shell with Boot, Main Menu, Level Select, Gameplay, and Safe Error as the first implementation slice. Pause, Results, Final Completion, persistent progress, settings, credits polish, and export remain later gates.
2. Keep `simulation_v1`, `level_v1`, `LevelLoader`, `Simulation`, and `BfsSolver` as existing authorities; application, catalog, progress, menu, and HUD layers must not duplicate puzzle rules.
3. Use a versioned separate JSON level catalog rather than extending `level_v1`, using a Godot Resource catalog, or hard-coding the registry.
4. Keep player-facing ordering, title key, classification, formal level path, unlock prerequisites, HUD mode, optional evidenced best-turn threshold, and final-level routing in the catalog boundary rather than formal puzzle data.
5. Use an in-memory progress adapter for the early system skeleton. Persistent storage path, format, migration, corruption recovery, backup, and deletion remain protected behind a later save-specific task.
6. Plan the three HUD modes `INTRO_MINIMAL`, `GUIDED_ECHO`, and `STANDARD_COMPACT`, with progressive disclosure and a compact contract-derived timeline. Implementation belongs to Task 0008 or another explicit task, not Task 0006.
7. Use the accepted eight-level schema-v1 roadmap as the content spine: Tutorial 0, Tutorial 1, the unchanged accepted vertical slice, and five geometry/timing-focused core concepts.
8. Preserve the acceptance ladder `CONCEPT -> SCHEMA_VALID -> SOLVER_VALIDATED -> REPLAY_VALIDATED -> INTERNAL_PLAYABLE -> FRESH_PLAYER_REVIEWED -> CANDIDATE_ACCEPTED`.
9. If schedule slips, cut level 8 first and level 7 second; do not retain unvalidated filler merely to preserve an eight-level count.
10. Retain player/ECHO route divergence only as `DEFERRED_POST_MVP`; it is not adopted into `simulation_v1`, `level_v1`, the pre-candidate roadmap, or Tasks 0006–0009.

## Accepted tutorial/content planning

- Tutorial 0 teaches YOU, movement, EXIT, restart, and completion through the zero-echo tutorial exception.
- Tutorial 1 teaches ECHO identity, delay-3 replay, pressure plate/door causality, and player-only completion.
- The existing `vertical_slice_delay_3` remains unchanged and becomes the first less-guided puzzle.
- No proposed uncreated level receives a solvability, difficulty, `L*`, `N*`, WAIT-necessity, or human-clarity claim until the required future evidence exists.
- Fresh-player review remains mandatory after Tutorials 0–1, after the first four-level sequence, and before candidate acceptance.

## Observations and boundaries

- Task 0006–0009 descriptions in the M2 plan are dependency and scope recommendations only. Each requires a separately issued task file.
- The Task 0004V P2 information-density finding is carried into progressive disclosure; Task 0006 must not attempt the final HUD redesign.
- Chinese-first candidate copy is accepted as planning direction, but localization implementation is not yet authorized.
- No persistent save, menu-complete product claim, export, Web, final art/audio, release, or submission readiness follows from this acceptance.

## Next gate

`Task 0006 — reusable app shell, level catalog, scene routing, and in-memory progression` is authorized as the next implementation gate. It may implement only Boot/Main Menu/Level Select/Gameplay/Safe Error, a strict separate catalog-v1 boundary, deterministic in-memory progress, a development direct-level route, and routing of the currently accepted vertical slice by catalog ID. It must preserve all accepted runtime and solver evidence and must not create Tutorial 0–1, persistent saves, settings, pause/results/final-completion flow, exports, assets, plugins, Web work, releases, or submission operations.
