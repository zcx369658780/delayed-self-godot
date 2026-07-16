# Task 0012 GPT final acceptance

- Verdict: `TASK_0012_STAGGERED_DOORS_ACCEPTED_INTERNAL_PLAYABLE`
- Accepted implementation commit: `1e43e9baa82a578fdb14f556e4895d42863513d9`
- Accepted task: `tasks/0012_difficult_level_6_staggered_doors.md`
- Acceptance date: 2026-07-16
- Accepted by: GPT Project Sources advisor

## Review basis

GitHub review confirmed that the implementation is exactly one commit ahead of the Task 0012 publication point and changes only the authorized Level 6 formal data, six-entry catalog, focused validation/capture tests, aggregate test entry, Level 6 report, accepted planning-status documents, and narrowly necessary current project documents.

No `project.godot`, simulation, solver, AppRoot, Gameplay, scene, schema, existing formal-level JSON, fixture, asset, font, audio, plugin, dependency, persistence, export, build, release, account, or repository-setting surface changed.

## Accepted formal content

The accepted formal level is:

```text
staggered_doors / Staggered Doors
```

Accepted structure:

- 9×7 schema-v1 geometry;
- one current player;
- one shared-spawn delay-3 ECHO;
- exactly two Plates: `plate_early` and `plate_late`;
- exactly two Doors: `door_early` and `door_late`;
- distinct one-Plate dependency sets;
- both Doors lie on the necessary player route to EXIT;
- no new mechanic, goal, schema, or runtime behavior.

The catalog now has exactly six entries. Level 5 is no longer final, Level 6 unlocks only after `two_keys_one_door`, and `staggered_doors` is the sole `final_level=true` entry. Existing entries retain their accepted order and facts.

## Accepted solver evidence

Accepted exact result:

```text
L* = 15
N* = 4
N* status = EXACT
visited_states = 6772
maximum_frontier = 1179
```

Accepted limits:

```text
depth_limit = 64
state_limit = 500000
time_limit_ms = 30000
solution_count_cap = 1000000
```

Accepted solver witness:

```text
UP RIGHT RIGHT DOWN UP RIGHT RIGHT RIGHT RIGHT UP UP UP LEFT LEFT LEFT
```

The result satisfies every hard Task 0012 target:

- `15 <= L* <= 21`;
- `1 <= N* <= 12`;
- exact solution multiplicity;
- `2000 <= visited_states <= 40000`.

Formal Level 6 SHA-256:

```text
3f14c19b50775e36dd5b52664798381cf1292b0a30b377641c03435f45696bc8
```

## Accepted two-window proof

The shortest witness demonstrates two distinct useful Door windows:

1. `door_early`: dependency result on turn 5 enables open-snapshot traversal on turn 6;
2. `door_late`: dependency result on turn 7 enables open-snapshot traversal on turn 8.

Both Doors close after traversal without invalidating the occupant, consistent with the accepted start-turn Door snapshot and closure-around-occupant semantics. All four shortest solutions cross both Door windows.

## Accepted necessity and difficulty controls

Accepted controls establish:

- the no-ECHO variant completely exhausts its finite state space without a solution;
- isolating either Plate completely exhausts its finite state space without a solution;
- both Doors are unavoidable on the formal player route;
- Door removal and dependency replacement materially change the exact solution structure rather than preserving the same puzzle;
- three meaningful decisions are present, with shortest-solution penalties of `+2`, `+7`, and `+2` for the audited alternatives;
- the level does not rely on a literal-WAIT teaching claim, long-corridor padding, repeated blocked moves, or blind trial-and-error as its primary difficulty source.

These controls support the machine claim that Level 6 materially increases planning depth over Levels 3–5. They do not establish human difficulty, balance, or fun.

## Accepted regression

The aggregate suite exits `0` and records:

```text
TASK_0003_TESTS_PASS assertions=349 vectors=9
TASK_0006_APP_SHELL_TESTS_PASS
TASK_0007_TUTORIAL_LEVELS_TESTS_PASS
TASK_0008_PROGRESSIVE_HUD_TESTS_PASS
TASK_0009AR_LEVELS_4_5_TESTS_PASS
TASK_0011_PRESENTATION_RECOVERY_TESTS_PASS
TASK_0011R_WINDOW_FILL_TESTS_PASS
TASK_0012_STAGGERED_DOORS_TESTS_PASS
```

The five prior formal level hashes and accepted metrics remain unchanged. Replay, restart, catalog validation, progression, direct-level routing, reusable Gameplay, presentation, capture, rapid-input order, and simulation semantics remain conformant.

## Gate adjudication

1. Task 0012 is accepted at `INTERNAL_PLAYABLE`.
2. Level 6 is accepted as the first deliberately harder schema-v1 challenge.
3. No implementation repair is required before human review.
4. Task 0012 does not establish fresh-player comprehension, human difficulty, fun, balance, or candidate acceptance.
5. A fresh/independent Level 6 sequence review is the next product-evidence gate.
6. Level 7, assets, fonts, audio, narrative, Gate, persistence, export, and release remain separately gated.

## Non-claims

This acceptance does not establish `FRESH_PLAYER_REVIEWED`, `CANDIDATE_ACCEPTED`, final content count, final art, final dependency visualization, accessibility, localization, licensed assets, audio, narrative, complete flow, save/settings, export, Web, release, or submission readiness.

WAIT remains `DEFERRED_VALIDATION_RESEARCH`. The latched/one-shot Gate remains `DRAFT_NOT_ACCEPTED`.

## Next gate

Before the next implementation or human-review task, perform one documentation-only project-source synchronization. It must record Task 0012 acceptance, preserve the next recommended gate as fresh/independent Level 6 review, and add the durable workflow rule that GitHub task files contain the complete execution scope and constraints while Codex launch prompts remain minimal by default.
