# Initial level roadmap and validation matrix (CURRENT)

- Tracked implemented spine: exactly 7 formal levels including tutorials
- Remaining sequence: Level 7 is internally playable pending GPT review; Level 8 remains an uncreated schema-v1 concept; final candidate count remains a later GPT scope decision
- Scope: `level_v1` mechanics only; all uncreated levels remain concepts, not solvability claims
- Goal predicate for every level: current player reaches EXIT

## Status boundary

- `ACCEPTED_EXISTING_FACT`: Tutorials 0–1 and `vertical_slice_delay_3` retain their accepted formal/runtime evidence.
- `INTERNAL_PLAYABLE`: Levels 1–6 are GPT accepted at their recorded implementation gates; Level 6 is not fresh-player reviewed or candidate accepted.
- `AUTHENTICATED_OWNER_NOT_FRESH_NOT_INDEPENDENT_LEVEL_6_REVIEW`: Task 0013B records owner comprehension, difficulty, and product judgment for Level 6 with P0=0/P1=0; it does not advance the fresh-player ladder state.
- `FRESH_INDEPENDENT_REVIEW_UNAVAILABLE_BY_OWNER_CONSTRAINT`: the owner is the only available playtester; third-party review must not be sought or required unless the owner reverses this decision. The gap is a disclosed residual limitation, not an ordinary internal-development blocker.
- `DEFERRED_VALIDATION_RESEARCH`: `wait_for_the_echo` is not implemented; strict literal-WAIT relevance remains unresolved without any claim that WAIT is impossible or redundant.
- `UNVERIFIED_DESIGN_TARGET`: remaining uncreated working IDs, layouts, difficulty, and target bands.
- `PLANNING_RECOMMENDATION_FOR_GPT`: sequence, teaching role, validation variants, HUD modes, and scope-cut order.
- `INTERNAL_PLAYABLE_PENDING_GPT_REVIEW`: Task 0015 creates and exactly validates Level 7 without human/candidate claims.
- `DEFERRED_POST_MVP`: route-trigger goals, alternate actor goals, latches, switches, hazards, anchors, teleporters, collectibles, and branching endings.

## Current candidate sequence

### Design matrix

| # | Working ID / title | Teaching or design goal | Echoes | Plates / doors | Intended reasoning | WAIT | Echo cooperation | Tier | Target `L*` band | Multiplicity tendency | HUD | Cut priority |
|---:|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | `tutorial_reach_exit` / 到达出口 | YOU, movement, EXIT, restart, completion | none; tutorial-zero exception | 0 / 0 | direct route with one harmless wall choice | no | no | tutorial | 2–5 unverified | many | `INTRO_MINIMAL` | preserve |
| 2 | `tutorial_echo_bridge` / 三回合后的我 | ECHO identity, delay-3 replay, plate opens door for YOU | one, d=3 | 1 / 1 | record a short path so ECHO holds PLATE while YOU uses the next opening | not targeted | required | tutorial | 6–10 unverified | many-to-moderate | `GUIDED_ECHO` | preserve |
| 3 | `vertical_slice_delay_3` / Three Turns Late | first less-guided cooperation puzzle | one, d=3 | 1 / 1 | apply role causality independently across split corridor | not required by accepted shortest witness | required | easy | accepted `L*=9` | accepted `N*=31 (EXACT)`; not a target | `STANDARD_COMPACT` with temporary goal card | preserve unchanged |
| 4 | `door_one_turn_late` / 门晚一回合 | door state committed now affects entry next turn; blocked history remains recorded | one, d=2 | 1 / 1 | compact folded corridor forces closed-snapshot blocking, then open-snapshot entry | not required | required | easy | actual `L*=9` | actual `N*=7 (EXACT)` | `STANDARD_COMPACT` | preserve |
| 5 | `two_keys_one_door` / 两把时间钥匙 | combinational AND door with simultaneous plate occupancy | one, d=3 | 2 / 1 AND | ECHO and YOU occupy distinct Plates together, then YOU enters on the committed next turn | not required | required | medium | actual `L*=12` | actual `N*=1 (EXACT)` | `STANDARD_COMPACT` | preserve |
| 6 | `staggered_doors` / 错开的门 | two doors with different plate sets; plan a dependency chain | one, d=3 | 2 / 2 with distinct one-Plate reference sets | one recorded route creates two distinct ECHO-held windows; YOU crosses each on the next input | not required; accepted witness has none | required and machine-proven | first core challenge; GPT accepted `INTERNAL_PLAYABLE`; owner review recorded | actual `L*=15` | actual `N*=4 (EXACT)` | `STANDARD_COMPACT` | preserve; owner recommends harder Level 7 |
| 7 | `two_echo_convergence` / 双影汇流 | combine two delays through one readable simultaneous convergence | two, d=2 and d=4 | 2 / 1 A+B AND | E2 on A and E4 on B create a one-turn committed opening | not required; selected witness has none | both ECHOs individually necessary and machine-proven | `INTERNAL_PLAYABLE / PENDING GPT REVIEW` | actual `L*=19` | actual `N*=6 EXACT` | `STANDARD_COMPACT`; Timeline not a teaching goal; A/B and E2/E4 redundant cues | preserve pending GPT review |

Actual Task 0009AR, Task 0012, and Task 0015 metrics are machine evidence, not best-turn thresholds. Task 0015 records 61,975 visited states, frontier 21,449, all-shortest convergence, complete necessity/equal-delay controls, and SHA-256 `772410d3b8bb807e35472ee2a7d07b703de66e1e0e92ffb4d1ff8433a345d5fd`.

### Deferred validation research — `wait_for_the_echo`

`wait_for_the_echo` is outside the tracked implemented sequence. Task 0009A's bounded authoring pass did not find a layout whose full-action optimum strictly requires literal `WAIT` relative to a no-WAIT search that still permits blocked cardinal turns. This does not establish that WAIT is impossible or redundant. Any future implementation requires a separate explicit task and the original strict comparison standard.

### Validation and human-gate matrix

| # | Mandatory solver checks | Mechanic-necessity variant | Human checkpoint | Shortcut / bypass question |
|---:|---|---|---|---|
| 1 | schema valid with zero-echo flag; `SOLVED`; replay; `N*` status; resource summary | no-echo is intended; verify direct EXIT cannot be completed at spawn and restart is exact | fresh player identifies YOU/EXIT and completes without oral help | can the wall be ignored without losing the movement lesson? acceptable if yes |
| 2 | schema valid; solve/replay; `L*`; `N*` exact/capped; echo participation trace | relocate/isolate ECHO or search a player-only controlled variant; intended level must then be unsolved or fail the door-crossing teaching event | fresh player predicts first replay and states ECHO holds PLATE for YOU | can YOU bypass door/plate or can ECHO alone appear to finish? both forbidden |
| 3 | preserve accepted solve/replay, `L*=9`, `N*=31 (EXACT)`, visited/frontier summary | preserve accepted isolated-ECHO complete unsolved result | fresh reviewer not exposed to route completes with compact HUD | does reduced copy recreate the prior role/EXIT P1? |
| 4 | accepted Task 0009AR solve/replay, `L*=9`, `N*=7 (EXACT)`, 291 visited/frontier 116, exact two-transition timing trace | no-Echo complete unsolved with 5 states | later five-level sequence reviewer explains “opens now, enter next turn” | machine audit found no corridor bypass |
| 5 | accepted Task 0009AR solve/replay, `L*=12`, `N*=1 (EXACT)`, 1,260 visited/frontier 225, simultaneous AND/open-entry trace | no-Echo 8-state complete unsolved; each Plate relocation 1,000-state complete unsolved; one-Plate controls solve | later reviewer distinguishes both Plates and next-turn traversal | distinct Plate positions and no-Echo search prevent one-actor/overlap bypass |
| 6 | accepted solve/replay; `L*=15`, `N*=4 EXACT`, 6,772 visited/frontier 1,179; both open-snapshot traces | no-ECHO and both Plate-isolation controls complete unsolved; Door/dependency controls change exact structure | Task 0013B owner completed unassisted, distinguished both events, reported two restarts and same-color order friction; not fresh/independent | machine audit proves neither Door is bypassable; owner review found no bypass |
| 7 | strict load/catalog; solve/replay/restart/hash; `N*=1–8 EXACT`; multi-delay/open-snapshot traces; four decision audits; prior regression | remove each ECHO; no-ECHO; isolate each Plate; A-only/B-only dependencies; equalize to 2/2 and 4/4; relocate Plates; remove Door | `AUTHENTICATED_OWNER_NOT_FRESH_NOT_INDEPENDENT_LEVEL_7_REVIEW`; test E2/E4 and A/B comprehension without requiring Timeline | can YOU, one ECHO, overlap, a side route, or a wide window trivialize convergence? |

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

## Human-evidence constraint

The earlier fresh-player checkpoints remain unsatisfied. The project owner is the only available playtester, and no task may seek or require another reviewer unless the owner explicitly reverses that decision. Owner sessions must be labeled not fresh and not independent. Internal planning and content work may continue when separately authorized, while candidate or release adjudication must disclose the missing independent evidence rather than treating it as obtained.

## Scope cuts

- Preserve implemented and accepted Levels 1–6 and the accepted core loop before preserving uncreated variety.
- If content schedule slips, cut uncreated concepts first; any change to the accepted six-level spine requires explicit GPT task authority.
- Never substitute an unvalidated level merely to retain the count of eight.
- English, multi-delay presentation polish, challenge variants, and post-MVP route divergence are cut before tutorials or validation evidence.
