# Tutorial and HUD progression plan (CURRENT)

- Status: `PLANNING_RECOMMENDATION_FOR_GPT` unless a statement is explicitly tagged otherwise
- Authority: tutorial copy and HUD presentation may explain but never redefine `simulation_v1`
- Candidate language: Chinese-first; current English development copy may remain until a later implementation/localization gate

## Accepted evidence and design response

- `ACCEPTED_EXISTING_FACT`: explicit YOU/ECHO/PLATE/DOOR/EXIT copy enabled the same user to complete the repaired slice without a movement hint.
- `ACCEPTED_EXISTING_FACT`: the same user found the screen information-dense and reported Echo next and History as only modestly useful.
- `PLANNING_RECOMMENDATION_FOR_GPT`: retain planning information but introduce it progressively, then compress it after demonstrated understanding.
- `DEFERRED_POST_MVP`: the user suggestion for player/echo route divergence is not a tutorial or schema-v1 goal.

## Learning sequence

Each step introduces one primary idea and requires an observable demonstration before the next step:

1. YOU, EXIT, movement, restart, and completion.
2. ECHO identity and a declared delay.
3. current actions become future echo actions.
4. pressure plate and door relationship.
5. the newly calculated door state affects entry on the following turn.
6. WAIT is an intentional planning action.
7. independent solution of a combined puzzle without route copy.

Copy may repeat an already learned fact only when it prevents a known P1; it may not disclose a movement sequence.

## Tutorial sequence

### Tutorial 0 — 到达出口 / Reach the Exit

| Field | Plan |
|---|---|
| Status | `UNVERIFIED_DESIGN_TARGET` |
| Primary goal | teach YOU, movement, EXIT, restart, and unmistakable completion |
| Schema-v1 use | zero echoes with `allow_zero_echo_tutorial=true`; walls/floor; one EXIT; no plate/door required |
| Player demonstration | move YOU to EXIT, observe completion, restart once during review |
| Initial HUD | `INTRO_MINIMAL`: short Chinese objective, direct YOU/EXIT labels, movement/restart controls |
| Disclosure change | controls collapse after first legal action; objective collapses after first completion, but restart remains reachable |
| Not introduced | ECHO, delay, History, Echo next, plates, doors, WAIT as a puzzle tool |
| Risks | player treats EXIT as decoration; control hint fades too early |
| Solver gate | schema validation, `SOLVED`, replay completion; no invented shortest claim |
| Human gate | fresh player identifies YOU/EXIT and completes without oral explanation |
| Echo necessary | no; explicit tutorial-zero exception |
| Target `L*` | `UNVERIFIED_DESIGN_TARGET`: 2–5 |

### Tutorial 1 — 三回合后的我 / Three Turns Later

| Field | Plan |
|---|---|
| Status | `UNVERIFIED_DESIGN_TARGET` |
| Primary goal | teach ECHO identity, delay, action-to-future replay, plate/door causality |
| Schema-v1 use | one echo, target delay 3, one plate, one combinational door, one EXIT |
| Player demonstration | make ECHO hold PLATE while YOU crosses DOOR and reaches EXIT |
| Initial HUD | `GUIDED_ECHO`: contextual three-line objective, entity legend, delay-labelled timeline, highlighted next echo action |
| Disclosure change | legend collapses after the player sees the first replay; plate/door explanation collapses after ECHO opens the door; timeline remains |
| Not introduced | multiple echoes, multiple doors, AND plates, forced WAIT, branching goals |
| Risks | role inversion; EXIT/ECHO occlusion; player reads current door update as same-turn entry permission |
| Solver gate | formal validity, solved/replay, exact/capped `N*`, echo-isolated mechanic variant, shortcut review |
| Human gate | at least one fresh reviewer explains roles before solving and completes without a route |
| Echo necessary | yes; must be machine-demonstrated through a controlled variant |
| Target `L*` | `UNVERIFIED_DESIGN_TARGET`: 6–10 |

### Tutorial 2 / Core 1 — Three Turns Late

| Field | Plan |
|---|---|
| Status | `ACCEPTED_EXISTING_FACT` for the formal level and solver evidence; roadmap role is `PLANNING_RECOMMENDATION_FOR_GPT` |
| Primary goal | independent application of delay-3 cooperation with reduced prose |
| Formal level | preserve `vertical_slice_delay_3` unchanged |
| Player demonstration | complete without route guidance, using ECHO-held PLATE for YOU |
| Initial HUD | `STANDARD_COMPACT`, with one temporary objective card because fresh-player evidence is still pending |
| Disclosure change | objective card collapses after first input or manual acknowledgment; compact timeline and direct board labels remain |
| Not introduced | new mechanics, forced WAIT, multiple echoes |
| Risks | removal of repair copy recreates the previous P1; compact timeline may be too subtle |
| Solver gate | retain accepted `L*=9`, `N*=31 (EXACT)`, replay, 1,318 states, and echo-isolated result |
| Human gate | a fresh reviewer who has not seen route/design discussion must complete or produce evidence before copy removal is accepted |
| Echo necessary | yes; already evidenced for this level |
| Target `L*` | accepted value 9, not a new target |

### Later teaching checkpoints

- `UNVERIFIED_DESIGN_TARGET`: the next-turn door-timing level asks the player to predict that an opening committed now permits entry next turn.
- `UNVERIFIED_DESIGN_TARGET`: the WAIT level requires at least one shortest solution WAIT and a no-WAIT controlled search that cannot match the intended result.
- `UNVERIFIED_DESIGN_TARGET`: multi-echo introduction occurs only after single-echo standard play is fresh-player reviewed.

## Progressive HUD modes

### Visibility matrix

| Surface | `INTRO_MINIMAL` | `GUIDED_ECHO` | `STANDARD_COMPACT` |
|---|---|---|---|
| Objective | one short explicit sentence, temporary | explicit contextual objective; role causality until demonstrated | one-line level goal on entry, then collapsed objective icon/card |
| Entity legend | YOU/EXIT only, temporary | YOU/ECHO/PLATE/DOOR/EXIT, contextual | hidden by default; available in pause/help |
| Echo next | hidden because no echo | represented as highlighted timeline slot plus readable action label | highlighted slot; separate prose label only if testing proves necessary |
| History/timeline | hidden | full delay-length visual slots, oldest to newest | compact visual timeline; expanded view available |
| Turn count | hidden during first moves; visible in pause/results | small persistent counter | small persistent counter |
| Delay | hidden | explicit ECHO delay label and timeline marker | marker per echo on timeline; expanded labels on demand |
| Door status | board state plus temporary explanation | board state plus contextual CLOSED/OPEN text during teaching | board state only unless accessibility testing requires text |
| Controls | movement/restart shown initially, then collapse | WAIT/restart plus movement shown contextually | pause/help; restart remains discoverable |
| Completion | prominent overlay naming YOU and EXIT | same | same |

### Timeline design

- `PLANNING_RECOMMENDATION_FOR_GPT`: use `max_delay` ordered slots rather than duplicating the full queue as prose.
- `PLANNING_RECOMMENDATION_FOR_GPT`: the oldest slot is visually emphasized as the next action for a delay equal to `max_delay`; each echo receives a labelled pointer to its contract-derived slot `history[max_delay - delay]`.
- `PLANNING_RECOMMENDATION_FOR_GPT`: slot glyphs combine arrow/WAIT symbol with text or accessible label; color is supplementary.
- `PLANNING_RECOMMENDATION_FOR_GPT`: an expanded view shows oldest-to-newest wording, all action names, echo-delay pointers, and a one-sentence explanation.
- `PLANNING_RECOMMENDATION_FOR_GPT`: the HUD consumes state plus pure query helpers; it never indexes history differently from the simulation contract.
- `UNVERIFIED_DESIGN_TARGET`: fresh players can predict the next replay using the compact timeline without persistent duplicate prose.

### Disclosure triggers

- Tutorial hints collapse only after an observable event, not a timer alone: first legal move, first visible replay, first ECHO-held plate, or first completion.
- Restart restores logical state but does not automatically erase an already-earned tutorial understanding flag during the same session; the persistent policy is deferred to the save task.
- A help/pause surface must restore any collapsed objective/legend without advancing a turn.
- Failed or blocked movement may re-surface a concise control/door explanation only when repeated confusion is observed; exact thresholds require UX evidence.

### Evidence required before removal

Do not remove the explicit player-only goal, actor identity, or timeline labels from standard play until:

1. at least one fresh reviewer has not seen the solver route or prior design discussion;
2. the reviewer states the victory condition and ECHO role accurately;
3. ECHO-on-EXIT remains distinguishable;
4. next action can be predicted at least once from the compact timeline;
5. no P0/P1 appears across Tutorial 0, Tutorial 1, and the accepted slice.

## Copy and language policy

### Chinese-first candidate

- `PLANNING_RECOMMENDATION_FOR_GPT`: Simplified Chinese is the candidate language; English localization is cut first if schedule slips.
- `OUT_OF_SCOPE`: Task 0005 does not change the current English development HUD.
- `PLANNING_RECOMMENDATION_FOR_GPT`: text is referenced through stable string keys rather than embedded per level or scene once localization work is authorized.

### Ownership

| String family | Recommended owner | Examples |
|---|---|---|
| global UI | localization/string table | menu, pause, restart, quit, error actions |
| entity vocabulary | localization/string table | YOU, ECHO, PLATE, DOOR, EXIT |
| tutorial steps | tutorial presentation data keyed by catalog entry/event | temporary objective and explanation cards |
| level title | catalog `display_title_key` | player-facing select/result title |
| formal diagnostic title/goal | `level_v1` | loader/authoring evidence, not menu ordering |
| runtime values | HUD formatting layer | turn, delay, action glyph/label |

### Copy rules

- State the goal, not the route: “让本体到达出口” is allowed; directional sequences are not.
- Name the exceptional rule explicitly at first exposure: ECHO cannot finish; YOU can.
- Teach next-turn door timing with cause/effect wording and a visual state change, not an instruction telling the next move.
- Keep one concept per line/card; avoid the repaired slice's permanent three-line objective once fresh-player evidence permits collapse.
- Completion always names the successful actor and destination.
- Error copy distinguishes malformed content from ordinary blocked movement.

## Human validation schedule

| Gate | Minimum evidence | Blocking rule |
|---|---|---|
| after Tutorial 0–1 and progressive HUD | one fresh reviewer, no prior route/design exposure; questions on identity, delay, next action, door timing | any P0/P1 blocks content multiplication |
| after four-level sequence | fresh or independent reviewer runs Tutorial 0 through Core 2; confusion and first-attempt completion recorded | repeated tutorial bypass/confusion triggers focused repair |
| before 2026-08-10 candidate | at least one independent complete-flow review from clean progress plus reveal review | unresolved P0/P1 blocks candidate acceptance |

Codex or subagent review is not independent human evidence.

## Acceptance targets for later implementation

`UNVERIFIED_DESIGN_TARGET`:

1. three HUD modes are selectable from catalog presentation data, not formal level semantics;
2. Tutorial 0 has no echo-only controls or timeline clutter;
3. Tutorial 1 links Echo next to the oldest applicable timeline slot without duplicate logic;
4. standard HUD removes permanent prose only after fresh-player evidence;
5. completion, restart, error, and pause copy remain readable at 960×540;
6. all tutorial strings can move to Chinese-first localization ownership without changing simulation data.
