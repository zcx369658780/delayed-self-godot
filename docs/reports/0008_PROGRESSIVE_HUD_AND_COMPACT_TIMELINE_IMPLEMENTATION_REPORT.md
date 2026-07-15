# Task 0008 progressive HUD and compact timeline implementation report

- Phase: A — implementation
- Verdict: `IMPLEMENTATION_READY_FOR_FRESH_PLAYER_REVIEW`
- Task: `tasks/0008_progressive_hud_compact_timeline_and_fresh_player_tutorial_review.md`
- Starting HEAD and `origin/main`: `7d0f1e1c96fd2eb3e7d825095e3d37f2c930ea0c`
- Final implementation: the single Phase A commit containing this report; exact commit is authoritative in Git history and the external evidence index
- Toolchain: Godot `4.7.stable.steam.5b4e0cb0f`, GDScript, Compatibility renderer, 960×540

## Architecture and changed paths

`scripts/gameplay/timeline_model.gd` is a presentation-only `RefCounted` helper. It consumes validated immutable level data, a read-only accepted state, and the shared Simulation query. It returns ordered labelled slots and per-Echo pointers, plus compact and expanded text. It never predicts movement, doors, or completion.

`scripts/simulation/simulation.gd` adds only `echo_history_index_for_state(level,state,echo_id)`. Existing `echo_action_for_state` now calls that query, so transition execution and HUD presentation cannot drift on `history[max_delay-delay]`. No transition/state/key output changed.

Exact changed Phase A paths are:

- runtime/presentation: `scripts/simulation/simulation.gd`, `scripts/gameplay/timeline_model.gd`, `scripts/gameplay/vertical_slice.gd`, `scenes/vertical_slice/vertical_slice.tscn`;
- tests/evidence harness: `tests/run_all.gd`, `tests/gameplay/capture_progressive_hud.gd`;
- design/report: `docs/game_design/TUTORIAL_AND_HUD_PROGRESSION_PLAN_CURRENT.md`, `docs/reports/0008_PROGRESSIVE_HUD_AND_COMPACT_TIMELINE_IMPLEMENTATION_REPORT.md`;
- current handoff: `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`, `docs/CODEX_ACTIVE_TASK_CURRENT.md`, `docs/DOC_INDEX_CURRENT.md`, `docs/DEVELOPMENT_PLAN_CURRENT.md`, `docs/HANDOFF_MASTER_CURRENT.md`, `docs/project_memory.md`.

## Implemented HUD behavior

- `INTRO_MINIMAL`: YOU/EXIT objective, identity key, movement/restart/help controls, no Echo/timeline/Plate/Door/WAIT concepts; full controls collapse after the first legal input. `H` restores full objective and controls.
- `GUIDED_ECHO`: initial player-only objective, roles, delay 3, Plate/Door causality, compact three-slot timeline, and next Echo pointer. The full legend collapses only after the first visible non-WAIT Echo movement; the long causality text collapses only after ECHO occupies PLATE and changes the Door state.
- `STANDARD_COMPACT`: one-line player-only objective on entry, compact identity key, and the timeline as the primary planning surface. The objective collapses after the first legal input. Permanent full History and separate Echo-next prose are absent.
- All modes retain prominent `YOU reached EXIT` completion. `H` toggles mode-appropriate expanded help without calling `Simulation.transition`, changing `turn_index`, or changing the canonical key. Restart reconstructs exact logical state while retaining earned disclosure flags in the current gameplay instance.

English development copy remains because Phase A does not authorize a localization framework or external font. Built-in fallback glyphs were visually verified at 960×540.

## Timeline model examples

Tutorial 1 initially renders three oldest-to-newest `WAIT` slots and `ECHO d3 → slot 1: WAIT next`. After recorded input, the slot labels retain original cardinal actions even when movement was blocked. A synthetic test with delays 2 and 4 points to distinct history indices 2 and 0 without adding a formal level. Zero-Echo Tutorial 0 returns no timeline.

## Automated and visual evidence

Baseline:

- `TASK_0003_TESTS_PASS assertions=220 vectors=9`
- `TASK_0006_APP_SHELL_TESTS_PASS`
- `TASK_0007_TUTORIAL_LEVELS_TESTS_PASS`

Final:

- `TASK_0003_TESTS_PASS assertions=239 vectors=9`
- `TASK_0006_APP_SHELL_TESTS_PASS`
- `TASK_0007_TUTORIAL_LEVELS_TESTS_PASS`
- `TASK_0008_PROGRESSIVE_HUD_TESTS_PASS`

Tests cover zero-Echo, ordered slots, accepted next-action indexing, blocked cardinal recording, synthetic multi-delay pointers, model immutability, compact/expanded agreement, disclosure triggers, help zero-turn/canonical-key invariance, exact restart with session disclosure, completion, three catalog routes, and direct routes.

Accepted metrics remain Tutorial 0 `L*=3`, `N*=3 (EXACT)`, 6 visited/frontier 2; Tutorial 1 `L*=9`, `N*=12 (EXACT)`, 1,975 visited/frontier 509 and no-Echo complete unsolved with 10 states; vertical slice `L*=9`, `N*=31 (EXACT)`, 1,318 visited and Echo-isolated complete unsolved with 1,006 states.

External evidence root: `D:\Delayed_Self_Evidence\0008_progressive_hud\`. It contains baseline/final logs, AppRoot and three direct-route logs, 13 game-root captures, and `EVIDENCE_INDEX.md` with commands, timestamps, sizes, and hashes. Initial visual overlap findings were repaired before the final captures; final initial/progressed/help/completion states fit the 960×540 viewport.

## Protected surfaces and non-claims

No formal level, catalog, schema, LevelLoader, solver, normative fixture, AppRoot, route, progress, project setting, GDD, project rule, persistence, asset, plugin, export, build, release, account, or repository-setting surface changed. The pure simulation query changes no gameplay semantics.

No qualifying fresh reviewer was available during this execution. The authenticated project owner from Tasks 0004/0004V is explicitly ineligible, and Codex inspection is not human evidence. This report does not claim fresh-player comprehension, `FRESH_PLAYER_REVIEWED`, P2 closure, candidate acceptance, Task 0009 authority, persistence, export, release, or submission readiness.

## Phase B readiness

After this exact Phase A commit is pushed, a qualifying unexposed reviewer may follow Task 0008 sections 14–20. Until then the terminal state is `IMPLEMENTATION_READY_FOR_FRESH_PLAYER_REVIEW`; do not begin Task 0009.
