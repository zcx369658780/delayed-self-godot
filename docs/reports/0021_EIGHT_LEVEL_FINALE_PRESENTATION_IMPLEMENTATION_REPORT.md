# Task 0021 eight-level finale-presentation implementation report

- Task: `tasks/0021_final_completion_overlay_and_bounded_return_implementation.md`
- Gate: `FINALE PRESENTATION IMPLEMENTATION / HEADLESS MACHINE REGRESSION`
- Result: `EIGHT_LEVEL_FINALE_PRESENTATION_READY_FOR_GPT_REVIEW`
- Baseline: `01aa893c5bf30fcd06edca205e1c674e2116acf2`
- Godot: `4.7.stable.steam.5b4e0cb0f`
- Formal scope: exactly eight levels; sequence 8 remains the sole final
- Native capture acceptance: not run; remains Gate 2

## Implementation

AppRoot now binds completion and back requests to the active Gameplay instance.
Each newly routed Gameplay resets one completion guard. The first completion
callback for that active instance makes at most one progress-recording attempt;
later callbacks from completion replay or direct invocation are ignored.

The branch uses only the active Gameplay route payload's validated,
catalog-derived `final_level` boolean:

```text
non-final: record once -> existing automatic LEVEL_SELECT route
final:     record once -> remain GAMEPLAY
```

No level ID, title, sequence number, progress count, witness state, coordinate,
or new metadata identifies the finale. Development-direct routing receives the
same catalog fact. If its prerequisites are incomplete, the memory-progress
adapter still rejects recording while Gameplay correctly presents the ending.

Gameplay derives the bounded presentation fact:

```text
FINAL_ACKNOWLEDGEMENT_VISIBLE
```

from `hosted_by_app`, `route_payload.final_level`, and ordinary
`state.completed`. It is not added to Simulation or the canonical state. The
existing completion label is reused at a bounded 960x540 rectangle with 22 px
static text:

```text
THE SIGNAL ARRIVED LATE.
IT WAS HEARD.

Enter / Space: Level Select
R: Replay
```

While visible, Timeline and Help are hidden; H, movement, and gameplay WAIT
cannot enter Simulation. Enter/`ui_accept`, Space/`wait_turn`, and Esc each use
one guarded existing `request_back` signal. R reconstructs the exact initial
state, clears the acknowledgment/return guard, and permits replay. AppRoot's
session guard prevents replay completion from recording or routing twice.

## Changed paths

Product/test:

- `scripts/app/app_root.gd`
- `scripts/gameplay/vertical_slice.gd`
- `tests/app/task_0021_eight_level_finale_presentation.gd`
- `tests/run_all.gd`

Documentation:

- `docs/reports/0021_EIGHT_LEVEL_FINALE_PRESENTATION_IMPLEMENTATION_REPORT.md`
- `docs/CODEX_ACTIVE_TASK_CURRENT.md`
- `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`
- `docs/DEVELOPMENT_PLAN_CURRENT.md`
- `docs/DOC_INDEX_CURRENT.md`
- `docs/HANDOFF_MASTER_CURRENT.md`
- `docs/project_memory.md`
- `docs/ux/PRESENTATION_VIEWPORT_AND_HUD_DIRECTION_CURRENT.md`

No scene, project setting, catalog, formal level, schema, Simulation, solver,
progress adapter, Help copy/predicate, Timeline model, persistence, asset,
audio, build, export, release, or submission path changed.

## Focused evidence

Command:

```text
godot.windows.opt.tools.64.exe --headless --path D:\Delayed_Self --script res://tests/run_all.gd -- --task-0021-focused
```

Final result:

```text
exit 0
TASK_0021_FOCUSED_TESTS_PASS assertions=42
TASK_0021_EIGHT_LEVEL_FINALE_PRESENTATION_TESTS_PASS
stderr: empty
```

The focused test proves:

- exact catalog hash and all eight exact formal hashes;
- catalog-derived true/false final route facts and no hard-coded final ID in
  the two implementation sources;
- non-final record-once plus automatic Level Select return;
- unlocked final record-once plus retained Gameplay;
- exact copy, state name, bounded completion surface, and reduced-motion/static
  meaning;
- full completed state and canonical key unchanged across H, movement,
  Enter/Space/Esc handling;
- Enter, Space, and Esc emit at most one back request each;
- R exact restart, replay, and same-session no-second-record behavior;
- development-direct final presentation with unchanged locked-progress
  rejection;
- Help/Timeline pre-completion behavior, Safe Error, reset test profile, Level
  Select scroll facts, and resize presentation remain intact.

The first focused attempt exposed one GDScript type-inference parse error in
AppRoot and exited 1. It was corrected within the authorized AppRoot path.
Two subsequent test-harness attempts diagnosed an integer lambda capture used
to count signals; changing the test counter to a mutable one-element Array
made the already-emitted signals observable. These failed logs are retained
externally and no failed attempt is treated as acceptance evidence.

## Aggregate evidence

Final aggregate:

```text
exit 0
TASK_0003_TESTS_PASS assertions=621 vectors=9
all prior thirteen stable markers exactly once
TASK_0021_EIGHT_LEVEL_FINALE_PRESENTATION_TESTS_PASS exactly once
stderr: LEVEL_ID_MISMATCH
```

The single stderr line is the accepted intentional catalog/formal mismatch
fixture diagnostic. There is no parser, script, runtime, assertion, route, or
cleanup error. Accepted metrics remain:

| Level | L* | N* | Visited | Frontier |
|---|---:|---:|---:|---:|
| Tutorial 0 | 3 | 3 EXACT | 6 | 2 |
| Tutorial 1 | 9 | 12 EXACT | 1,975 | 509 |
| Level 3 | 9 | 31 EXACT | 1,318 | 393 |
| Level 4 | 9 | 7 EXACT | 291 | 116 |
| Level 5 | 12 | 1 EXACT | 1,260 | 225 |
| Level 6 | 15 | 4 EXACT | 6,772 | 1,179 |
| Bridge | 16 | 12 EXACT | 19,059 | 3,734 |
| Final | 19 | 6 EXACT | 61,975 | 21,449 |

## Frozen hashes

| File | SHA-256 |
|---|---|
| catalog | `a2bfa892f77370ac4d7e93ba5b6ce5970f0d7ba75160e1b2d00c4384f3da4e51` |
| tutorial_reach_exit | `38e466bb5922f1987a99d79c7527a4a8eab8e6cfdbe76fd8159f80b0a40cf2c4` |
| tutorial_echo_bridge | `681d99057c4e6034a490644d75960ff23d8f43bd1b91850f48179b79fc04a3cf` |
| vertical_slice_delay_3 | `8751da5051fbebaaa5ae7c895d9be9f086e8d8f2e87876a80c379dc06262f1d8` |
| door_one_turn_late | `1775cf89ae4a94f65a76dac2b791a31395443de88205d0ed1b6233331dbda577` |
| two_keys_one_door | `f4c6791dfc84d17fb450721e654091a2baeb522e55d660a5d73878cd977651cd` |
| staggered_doors | `3f14c19b50775e36dd5b52664798381cf1292b0a30b377641c03435f45696bc8` |
| echo_spacing_bridge | `805cdc05ea9b3805189ba7be4938cb7ede4e7056b9ae9a7e911df96a801d58ee` |
| two_echo_convergence | `772410d3b8bb807e35472ee2a7d07b703de66e1e0e92ffb4d1ff8433a345d5fd` |

## Evidence, cleanup, and rollback

External evidence root:

```text
D:\Delayed_Self_Evidence\0021_eight_level_finale_presentation\
```

It contains focused/aggregate stdout and stderr, failed-attempt logs, command
records, hash inventory, route/progress/state/input traces, cleanup audit, and
an evidence index. It is not staged.

Every Godot process exited. Godot produced no tracked `project.godot` change,
untracked `.gd.uid`, cache, import, or repository-local evidence file, so
generated-file cleanup was not needed.

Rollback is one topic: remove the AppRoot completion-instance guard and final
branch, the Gameplay derived acknowledgment/input behavior, the Task 0021
test/registration, this report, and its minimum CURRENT-document updates.
Formal data and catalog require no rollback.

## Non-claims

Task 0021 establishes implementation plus headless machine regression only.
It does not establish native capture acceptance, final copy/localization,
owner acceptance, complete-flow or production readiness, save/settings/menu
readiness, build/export readiness, RC acceptance, release, upload, or festival
submission.
