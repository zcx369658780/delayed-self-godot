# Initial level roadmap and validation matrix (CURRENT)

- Candidate spine: exactly 8 levels including tutorials
- Scope: `level_v1` mechanics only; all uncreated levels are concepts, not solvability claims
- Goal predicate for every level: current player reaches EXIT

## Status boundary

- `ACCEPTED_EXISTING_FACT`: only `vertical_slice_delay_3` currently exists as a formal accepted level.
- `UNVERIFIED_DESIGN_TARGET`: all other working IDs, layouts, difficulty, WAIT requirements, and `L*` bands.
- `PLANNING_RECOMMENDATION_FOR_GPT`: sequence, teaching role, validation variants, HUD modes, and scope-cut order.
- `DEFERRED_POST_MVP`: route-trigger goals, alternate actor goals, latches, switches, hazards, anchors, teleporters, collectibles, and branching endings.

## Eight-level candidate spine

### Design matrix

| # | Working ID / title | Teaching or design goal | Echoes | Plates / doors | Intended reasoning | WAIT | Echo cooperation | Tier | Target `L*` band | Multiplicity tendency | HUD | Cut priority |
|---:|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | `tutorial_reach_exit` / 到达出口 | YOU, movement, EXIT, restart, completion | none; tutorial-zero exception | 0 / 0 | direct route with one harmless wall choice | no | no | tutorial | 2–5 unverified | many | `INTRO_MINIMAL` | preserve |
| 2 | `tutorial_echo_bridge` / 三回合后的我 | ECHO identity, delay-3 replay, plate opens door for YOU | one, d=3 | 1 / 1 | record a short path so ECHO holds PLATE while YOU uses the next opening | not targeted | required | tutorial | 6–10 unverified | many-to-moderate | `GUIDED_ECHO` | preserve |
| 3 | `vertical_slice_delay_3` / Three Turns Late | first less-guided cooperation puzzle | one, d=3 | 1 / 1 | apply role causality independently across split corridor | not required by accepted shortest witness | required | easy | accepted `L*=9` | accepted `N*=31 (EXACT)`; not a target | `STANDARD_COMPACT` with temporary goal card | preserve unchanged |
| 4 | `door_one_turn_late` / 门晚一回合 | door state committed now affects entry next turn; blocked history remains recorded | one, d=2 | 1 / 1 | align ECHO plate arrival one turn before YOU attempts the door; use a wall/door corridor to expose stale assumptions | no target | required | easy | 7–12 unverified | moderate | `STANDARD_COMPACT` plus contextual timing card | preserve |
| 5 | `wait_for_the_echo` / 等一等过去 | WAIT as deliberate scheduling | one, d=3 | 1 / 1 | geometry makes movement-only timing miss the useful plate window; WAIT aligns replay | required target | required | easy-medium | 9–15 unverified | moderate | `STANDARD_COMPACT` | preserve |
| 6 | `two_keys_one_door` / 两把时间钥匙 | combinational AND door with simultaneous plate occupancy | one, d=3 | 2 / 1 AND | ECHO holds one plate while YOU uses the other to open a shared door, then crosses on the committed next turn | evidence required; not assumed | required | medium | 11–18 unverified | moderate-to-few | `STANDARD_COMPACT` | preserve if stable; first six-level cut line |
| 7 | `staggered_doors` / 错开的门 | two doors with different plate sets; plan a dependency chain | one, d=3 | 2 / 2 with distinct reference sets | one recorded route creates two useful plate windows; current player chooses when to traverse each door | optional target | required | medium | 14–22 unverified | few-to-moderate | `STANDARD_COMPACT` expanded timeline available | cut second |
| 8 | `two_echo_convergence` / 两条时间线 | combine two delays without new mechanics | two, d=2 and d=4 | 2 / 1 AND | synchronize two ECHOs on separate plates so YOU crosses; overlapping actors remains legal | required target if solver supports | both echoes required target | medium-hard finale | 16–28 unverified | few | `STANDARD_COMPACT` multi-delay timeline | cut first |

Target bands guide authoring limits only. They are not `expected_min_turns` values and must not enter formal data until a solver validates the created level.

### Validation and human-gate matrix

| # | Mandatory solver checks | Mechanic-necessity variant | Human checkpoint | Shortcut / bypass question |
|---:|---|---|---|---|
| 1 | schema valid with zero-echo flag; `SOLVED`; replay; `N*` status; resource summary | no-echo is intended; verify direct EXIT cannot be completed at spawn and restart is exact | fresh player identifies YOU/EXIT and completes without oral help | can the wall be ignored without losing the movement lesson? acceptable if yes |
| 2 | schema valid; solve/replay; `L*`; `N*` exact/capped; echo participation trace | relocate/isolate ECHO or search a player-only controlled variant; intended level must then be unsolved or fail the door-crossing teaching event | fresh player predicts first replay and states ECHO holds PLATE for YOU | can YOU bypass door/plate or can ECHO alone appear to finish? both forbidden |
| 3 | preserve accepted solve/replay, `L*=9`, `N*=31 (EXACT)`, visited/frontier summary | preserve accepted isolated-ECHO complete unsolved result | fresh reviewer not exposed to route completes with compact HUD | does reduced copy recreate the prior role/EXIT P1? |
| 4 | solve/replay plus transition trace proving entry uses start-of-turn door state | compare a controlled layout/trace where same-turn door update cannot grant entry; isolate ECHO | reviewer explains “opens now, enter next turn” before or after first failure | is there a corridor path that never exercises next-turn timing? |
| 5 | solve/replay; search with WAIT removed from action expansion; record `W_req` evidence | no-WAIT search must not produce an equal-or-better teaching-goal completion; isolate ECHO | reviewer intentionally uses WAIT and can explain why | can blocked movement substitute invisibly for WAIT and bypass teaching? |
| 6 | solve/replay; AND-state trace; exact/capped `N*`; limits | remove/relocate each plate separately and test echo isolation; each intended dependency must matter | reviewer distinguishes both plates and next-turn traversal | can one actor sequence open the door without the intended simultaneous occupancy? |
| 7 | solve/replay; traces for both doors and referenced sets; resource limits | neutralize each door/plate dependency separately; isolate ECHO | four-level sequence review records confusion and restarts | can either door be bypassed or solved without its taught dependency? |
| 8 | solve/replay; multi-delay action traces; `N*` status; frontier/time/state limits; WAIT evidence | remove each ECHO in turn, equalize delays, and relocate each plate; both echoes/delay difference must remain relevant | independent reviewer reads both timeline markers and completes or yields actionable P1 evidence | can one ECHO or actor overlap trivialize the intended convergence? |

## Variety within schema v1

The roadmap varies geometry and timing without adding semantics:

- tutorial-zero direct traversal;
- one echo with delays 2 or 3;
- single and AND pressure-plate sets;
- one or two doors with distinct plate references;
- two echoes with different delays;
- legal actor overlap;
- historical cardinal actions blocked by the current door snapshot;
- intentional WAIT;
- next-turn door entry timing.

No level changes the player-only EXIT goal.

## Mandatory metrics

### Authoring stage

- working ID, version, teaching goal, allowed mechanics, intended reasoning, risk hypotheses, and scope priority;
- `UNVERIFIED_DESIGN_TARGET` `L*` band and multiplicity tendency only;
- candidate layout and any author route explicitly labelled proposal, never proof.

### Solver stage

- loader validity and stable error codes;
- solver status, `L*`, `N*`, and `EXACT`/`CAPPED`; a limit is never called unsolvable;
- visited states, maximum frontier, depth/state/time/count limits;
- one solver-produced action sequence replayed through the shared transition;
- exact restart reconstruction;
- echo/mechanic-necessity controlled variants;
- `W_req` or equivalent no-WAIT evidence when WAIT is a teaching goal;
- traces for next-turn door entry and required plate/door dependencies;
- shortcut and teaching-goal bypass audit.

### Human-review stage

- reviewer exposure status, first-attempt completion, elapsed/restarts when supplied, hints, and confusion notes;
- ability to state victory, actor roles, next action, door timing, and WAIT purpose at the relevant point;
- P0–P3 findings and whether the level should return to concept/layout iteration;
- best-turn threshold only after solver distribution and human evidence; never from the target band alone.

## Acceptance ladder

```text
CONCEPT
-> SCHEMA_VALID
-> SOLVER_VALIDATED
-> REPLAY_VALIDATED
-> INTERNAL_PLAYABLE
-> FRESH_PLAYER_REVIEWED
-> CANDIDATE_ACCEPTED
```

| State | Advancement authority/evidence | Claims allowed | Claims prohibited |
|---|---|---|---|
| CONCEPT | designer/Codex planning proposal | intended goal and risks | valid, solvable, difficult, fun |
| SCHEMA_VALID | strict loader/schema checks | formal shape valid | solvable or teaching-effective |
| SOLVER_VALIDATED | bounded solver returns `SOLVED` and metrics | machine-solvable under recorded limits | replay parity, human clarity |
| REPLAY_VALIDATED | solver witness completes through shared runtime contract | solution replays; recorded metrics | good difficulty or tutorial quality |
| INTERNAL_PLAYABLE | developer/Codex smoke plus no runtime blocker | locally playable at named commit | fresh-player clarity or candidate readiness |
| FRESH_PLAYER_REVIEWED | authenticated fresh human evidence with exposure record | observed comprehension/findings | independent acceptance if reviewer is not independent |
| CANDIDATE_ACCEPTED | GPT acceptance after automated, human, complete-flow, and scope evidence | candidate inclusion at exact commit | release/export/submission readiness without separate gates |

Any simulation or formal-level change returns affected levels to at least SCHEMA_VALID and reruns solver/replay comparisons.

## Fresh-player checkpoints

1. after levels 1–2 and progressive HUD implementation;
2. after levels 1–4 form a continuous sequence;
3. before 2026-08-10 candidate acceptance across the complete selected spine.

At least one reviewer in these gates must not have seen the solver route or prior design discussion.

## Scope cuts

- Preserve levels 1–5, the accepted core loop, and complete application flow before preserving variety.
- If content schedule slips, cut level 8 first and level 7 second, producing a six-level candidate only through explicit GPT scope acceptance.
- Never substitute an unvalidated level merely to retain the count of eight.
- English, multi-delay presentation polish, challenge variants, and post-MVP route divergence are cut before tutorials or validation evidence.
