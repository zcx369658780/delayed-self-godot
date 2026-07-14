# System skeleton plan (CURRENT)

- Task: `tasks/0005_system_skeleton_and_tutorial_level_planning.md`
- Scope: planning only; no system in this document is implemented unless marked `ACCEPTED_EXISTING_FACT`
- Target: smallest complete Windows-first flow through the 2026-08-10 candidate

## Status vocabulary

| Status | Meaning |
|---|---|
| `ACCEPTED_EXISTING_FACT` | Already accepted and evidenced in repository history |
| `PLANNING_RECOMMENDATION_FOR_GPT` | Proposed architecture; requires GPT acceptance and a later implementation task |
| `UNVERIFIED_DESIGN_TARGET` | A target that needs implementation, solver, or human evidence |
| `DEFERRED_POST_MVP` | Intentionally excluded before the candidate milestone |
| `OUT_OF_SCOPE` | Not authorized by Task 0005 |

## Accepted foundation

- `ACCEPTED_EXISTING_FACT`: Godot 4.7 stable, GDScript, Compatibility renderer, 960×540 logical viewport, Windows x86_64 first.
- `ACCEPTED_EXISTING_FACT`: `simulation_v1` and `level_v1` govern deterministic transitions, formal level data, replay, tests, and solver behavior.
- `ACCEPTED_EXISTING_FACT`: only the current player reaching EXIT completes a schema-v1 level.
- `ACCEPTED_EXISTING_FACT`: the existing vertical slice directly owns level loading, input, board drawing, HUD, restart, and quit; it is a proven slice, not yet a reusable application shell.
- `ACCEPTED_EXISTING_FACT`: Task 0004V closed same-user P0/P1 while carrying a P2 information-density observation and a later fresh-player-review requirement.

### Current implementation seams and gaps

| Current surface | Observed responsibility | Planning implication |
|---|---|---|
| `project.godot` | boots directly into the vertical-slice scene | Task 0006 must replace the entry route only under explicit authorization and retain a development direct-level path |
| `vertical_slice.gd` | fixed `LEVEL_PATH`; input, transition commit, drawing, HUD, restart, quit | Tasks 0007–0008 must separate reusable controller/view/HUD without changing transition outcomes |
| current HUD | indexes `echoes[0]` and `door_states[0]` | it cannot yet render zero-echo Tutorial 0, no-door levels, multiple doors, or multiple echoes safely |
| `LevelLoader` | strict `level_v1` load, normalization, cross-field validation, including tutorial-zero exception | reuse unchanged unless a proven bug requires a separate task |
| `Simulation` | generic state construction, transition, replay, history queries, plates, canonical key | remains the shared gameplay authority and already represents zero/multiple echoes |
| `BfsSolver` | bounded BFS over the shared transition | remains authoring/validation evidence, not a required player-runtime service |
| `tests/run_all.gd` | conformance plus one formal-level solver and current-scene HUD smoke | future tasks add catalog, route, multi-level, and HUD-mode coverage while preserving the existing suite |

`PLANNING_RECOMMENDATION_FOR_GPT`: do not make Tutorial 0 fit by adding fake ECHO/DOOR data. Generalize presentation/application consumers to valid schema-v1 cardinalities.

## Application states and transitions

`PLANNING_RECOMMENDATION_FOR_GPT`:

```text
Boot
  -> Main Menu
      -> Continue -> Gameplay
      -> Level Select -> Gameplay
      -> Credits
      -> Quit Confirmation -> Desktop
Gameplay
  -> Pause -> Resume | Restart | Level Select | Main Menu
  -> Level Complete / Results -> Next Level | Level Select | Main Menu
  -> Final Completion / Credits -> Main Menu
Any load/route failure
  -> Safe Error Screen -> Retry source action | Main Menu
```

### State contract

| State | Owns | May transition to | Candidate requirement |
|---|---|---|---|
| Boot | dependency construction, catalog load, initial route selection | Main Menu, Gameplay in development mode, Safe Error | minimal deterministic bootstrap |
| Main Menu | New/Continue, Level Select, Credits, Quit | Level Select, Gameplay, Credits, Quit Confirmation | required |
| Level Select | ordered catalog view and availability | Gameplay, Main Menu | required; locked entries explain prerequisites |
| Gameplay | one loaded formal level and one in-memory attempt | Pause, Results, Safe Error | required |
| Pause | input suspension only; no simulation turn | Gameplay, Level Select, Main Menu | required |
| Results | completion summary and progress event | Gameplay next, Level Select, Main Menu | required |
| Final Completion / Credits | candidate ending acknowledgement and credits | Main Menu | required as a bounded text-first surface |
| Safe Error | non-partial failure explanation | Retry, Main Menu | required |

### Pause, restart, quit, and development launch

- `PLANNING_RECOMMENDATION_FOR_GPT`: pause prevents gameplay input dispatch and presentation playback but never mutates or advances `simulation_v1`.
- `ACCEPTED_EXISTING_FACT`: restart reconstructs the formal initial state; it is not a world action.
- `PLANNING_RECOMMENDATION_FOR_GPT`: desktop quit uses confirmation from menu or pause; development-only direct launch may exit immediately, matching current behavior.
- `PLANNING_RECOMMENDATION_FOR_GPT`: route changes abandon the current attempt only after confirmation when progress would be lost. Schema-v1 levels are short and no mid-level save is planned.
- `PLANNING_RECOMMENDATION_FOR_GPT`: a development launch argument such as `--level-id=<id>` may request a catalog entry. Unknown IDs must route to Safe Error, never a fallback level silently.
- `OUT_OF_SCOPE`: Task 0005 does not freeze a command-line syntax or implement any route.

### Candidate versus later polish

| 2026-08-10 candidate | Later polish |
|---|---|
| Boot, menu, select, gameplay, pause, results, next-level path, bounded final completion, error route | animated transitions, elaborate credits, controller navigation polish |
| in-memory progress during early skeleton; separately authorized persistent progress before candidate | cloud sync, multiple profiles |
| Chinese-first text and functional geometric presentation | optional English, final art/audio pass |
| Windows complete flow | Web compatibility gate |

## Scene and module ownership

All names below are `PLANNING_RECOMMENDATION_FOR_GPT`, not implementation facts.

| Concept | Recommended responsibility | Allowed dependencies | Forbidden authority |
|---|---|---|---|
| `AppRoot` | owns long-lived services and replaces the active routed screen | catalog, progress interface, screen factories | puzzle transitions, board rules |
| `SceneRouter` | validates route requests and performs one screen replacement | `AppRoot`, route payloads | loading unvalidated level data directly |
| `MainMenuScreen` | emits New/Continue/Select/Credits/Quit intents | read-only progress summary | progress mutation, simulation |
| `LevelSelectScreen` | renders ordered catalog entries and availability | catalog plus read-only progress | unlock rules outside catalog/progress policy |
| `GameplayScreen` | composes controller, board, HUD, pause, and completion events | validated level/session payload | catalog ordering or persistence |
| `GameplayController` | maps legal input intents to the shared transition, commits state before presentation, restarts | `LevelLoader`, `Simulation` | copied movement/door/goal rules |
| `BoardView` | draws terrain/entities and presents committed state | immutable level plus read-only state | calling transition or deciding completion |
| `GameplayHud` | renders selected HUD mode and emits pause/restart intents | catalog presentation config plus read-only state/query helpers | deriving hidden rules or mutating state |
| `ResultsScreen` | shows completion facts and emits navigation intent | completion event, catalog, progress interface | judging solver validity |
| `LevelCatalog` | owns sequence and product-facing metadata | separate catalog data, formal level paths | formal puzzle semantics |
| `ProgressStore` interface | read/update unlocked/completed/best-turn/tutorial flags | catalog IDs; later persistent adapter | level transitions |
| `SettingsStore` interface | read/update candidate settings through deterministic defaults | later persistent adapter; settings UI | progress unlocks, level transitions |
| `LevelLoader` | existing strict JSON/formal-level boundary | `level_v1` | menu metadata |
| `Simulation` | existing shared state construction/transition/replay/query authority | validated level/state only | presentation |
| `BfsSolver` | existing bounded validation tool | shared `Simulation` | runtime menu requirements |

### Transition-call boundary

- `ACCEPTED_EXISTING_FACT`: `Simulation.transition` is the shared gameplay/solver/test authority.
- `PLANNING_RECOMMENDATION_FOR_GPT`: only `GameplayController`, solver/replay tools, and automated tests may call transition/replay entry points.
- `PLANNING_RECOMMENDATION_FOR_GPT`: `BoardView`, `GameplayHud`, menus, catalog, progress, result, audio, and animation remain presentation/application-only.
- `PLANNING_RECOMMENDATION_FOR_GPT`: gameplay commits the logical result before board/HUD updates or animation.

## Level catalog decision record

### Context

`level_v1` is strict simulation data. Product flow additionally needs ordering, unlocks, localized titles, HUD modes, and final-level routing. Those fields must not become puzzle semantics.

### Options

| Option | Advantages | Costs/risks | Decision |
|---|---|---|---|
| Extend `level_v1.metadata` | one file per level | pollutes strict formal data; presentation changes require schema work; mixes authorities | reject for current project |
| Separate JSON catalog/manifest | explicit boundary, diffable, testable, engine-neutral | needs its own schema/validator and cross-reference checks | recommend |
| Godot Resource catalog | editor-friendly and typed inside Godot | import/editor coupling, harder external validation, machine-generated risk | defer unless JSON proves inadequate |
| Hard-coded registry | fastest initial code | ordering/unlocks scattered in code; poor validation and content workflow | reject beyond a throwaway spike |

### Recommendation and consequences

- `PLANNING_RECOMMENDATION_FOR_GPT`: use one versioned, separate JSON catalog validated before menu construction.
- `PLANNING_RECOMMENDATION_FOR_GPT`: catalog entries own sequence, player-facing `display_title_key`, classification (`tutorial` or `standard`), formal level path, unlock prerequisites, optional evidenced best-turn threshold, HUD mode, and final-level flag.
- `ACCEPTED_EXISTING_FACT`: `level_v1.title` remains a formal authoring/diagnostic field. The catalog localization key becomes the product-facing title only after implementation acceptance.
- `PLANNING_RECOMMENDATION_FOR_GPT`: catalog IDs equal formal `level_id`; duplicate IDs, missing paths, invalid classifications, prerequisite cycles, unknown HUD modes, multiple final flags, and unreachable entries fail catalog validation.
- `PLANNING_RECOMMENDATION_FOR_GPT`: one bad entry prevents publication of a partial selectable catalog. Development mode may show a safe diagnostic list only when explicitly enabled.
- `PLANNING_RECOMMENDATION_FOR_GPT`: catalog versions migrate independently from `level_v1`; a future catalog change must not rewrite formal levels unless the puzzle contract itself changes.
- `OUT_OF_SCOPE`: no catalog filename, schema, or data file is created by Task 0005.

### Candidate catalog field sketch

`PLANNING_RECOMMENDATION_FOR_GPT` only:

```text
catalog_version
entries[]:
  level_id
  level_path
  sequence
  display_title_key
  classification
  unlock_prerequisites[]
  hud_mode
  optional_best_turn_threshold
  final_level
```

Best-turn thresholds remain absent until solver and human evidence exists; author guesses must not become catalog values.

## Progress and save boundary

### Interface

`PLANNING_RECOMMENDATION_FOR_GPT`: route/UI code depends on a small progress interface rather than storage details:

```text
snapshot()
is_unlocked(level_id)
record_completion(level_id, turns)
mark_tutorial_flag(flag)
reset_test_profile()
```

`PLANNING_RECOMMENDATION_FOR_GPT`: a separate settings interface exposes `settings_snapshot()`, `read_setting(key)`, `write_setting(key, value)`, and `reset_settings_for_test()`. Progress and settings may later share one versioned storage container, but application consumers do not depend on that storage choice.

- `PLANNING_RECOMMENDATION_FOR_GPT`: early Tasks 0006–0008 use an in-memory adapter reset on launch, sufficient for route and unlock tests.
- `PLANNING_RECOMMENDATION_FOR_GPT`: candidate completion later requires a separately authorized persistent adapter containing save version, unlocked/completed IDs, best turns, settings, tutorial flags, and final-completion state.
- `PLANNING_RECOMMENDATION_FOR_GPT`: tests use an isolated profile and deterministic defaults.
- `RECOMMENDATION_FOR_GPT_DECISION`: use a versioned dictionary serialized through a Godot-supported local format, but do not freeze path, encoding, migration, backup, corruption recovery, or deletion behavior before a save-specific task.
- `OUT_OF_SCOPE`: persistent writes, player-data deletion, migration, platform paths, and real-profile tests.

## Failure and error handling

| Failure | Required behavior | Evidence gate |
|---|---|---|
| malformed catalog | no menu from partial data; Safe Error with stable diagnostic | catalog validation tests |
| catalog points to missing level | entry/cross-reference validation fails before selection | missing-path test |
| formal level invalid | `LevelLoader` error; no state constructed; Safe Error | existing plus per-level regression |
| solver validation unavailable | level may be development-only, never `CANDIDATE_ACCEPTED` | validation record marks unavailable/limited |
| completion route failure | keep completed state and offer safe Level Select/Main Menu fallback; log diagnostic | route integration test |
| future save corruption | quarantine/fail safe to explicit recovery UI; never partially apply progress | separate save gate |
| unknown route or level ID | stable error route; never silently choose another level | router tests |

No failure may enter Gameplay with a partially validated catalog, formal level, or progress snapshot.

## Implementation seams and risks

- `PLANNING_RECOMMENDATION_FOR_GPT`: migrate the current vertical-slice node into reusable controller/view/HUD seams incrementally; retain conformance while each seam moves.
- `PLANNING_RECOMMENDATION_FOR_GPT`: keep solver optional at player runtime; validation belongs to authoring/CI evidence so solver resource limits cannot block ordinary play.
- `UNVERIFIED_DESIGN_TARGET`: menu-to-results flow remains stable across all eight catalog entries with no per-level scene logic.
- Risk: premature service framework growth. Mitigation: plain nodes/ref-counted helpers and explicit payloads before autoload proliferation.
- Risk: catalog/progress coupling. Mitigation: catalog defines prerequisites; progress only records facts and evaluates through one policy layer.
- Risk: UI becoming a second rule authority. Mitigation: HUD reads state and pure query helpers only.

## Acceptance criteria for a future skeleton

`UNVERIFIED_DESIGN_TARGET`:

1. one reusable Gameplay scene loads at least Tutorial 0, Tutorial 1, and the accepted vertical slice by catalog ID;
2. Boot, Menu, Select, Gameplay, Pause, Results, Next, and safe-error routes have automated transition tests;
3. no UI/catalog/progress module duplicates `simulation_v1` rules;
4. invalid catalog and formal-level cases construct no partial gameplay state;
5. in-memory progress unlocks deterministically and resets in isolated tests;
6. existing 135 assertions, 9 vectors, solver result, and accepted vertical-slice behavior remain unchanged.
