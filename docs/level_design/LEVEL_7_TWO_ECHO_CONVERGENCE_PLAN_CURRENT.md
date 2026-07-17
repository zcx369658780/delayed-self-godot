# Level 7 two-ECHO convergence plan (CURRENT)

- Status: `GPT_ACCEPTED_INTERNAL_PLAYABLE / OWNER_REVIEW_NON_PROMOTION_PENDING_GPT_ADJUDICATION`
- Task: [`0014`](../../tasks/0014_level_7_two_echo_convergence_planning.md)
- Proposed formal ID: `two_echo_convergence`
- Proposed display title: `Two Echo Convergence / 双影汇流`
- Frozen authority: [`simulation_v1`](../game_design/GAMEPLAY_SIMULATION_CONTRACT_CURRENT.md) and [`level_v1`](LEVEL_SCHEMA_V1_CURRENT.md)
- Baseline: six accepted formal levels; Level 6 implementation `1e43e9baa82a578fdb14f556e4895d42863513d9`
- Human evidence boundary: `FRESH_INDEPENDENT_REVIEW_UNAVAILABLE_BY_OWNER_CONSTRAINT`

Task 0015 implements and machine-validates this target; GPT accepted it at `INTERNAL_PLAYABLE`. Exact result: `L*=19`, `N*=6 EXACT`, visited 61,975, frontier 21,449, one-turn required convergence, and SHA-256 `772410d3b8bb807e35472ee2a7d07b703de66e1e0e92ffb4d1ff8433a345d5fd`.

Task 0015V owner review is non-promotion. The owner understood E2/E4, E2-on-A/E4-on-B, and A+B, but gave up after Help and later high-level assistance because relative ECHO spacing was interpreted as invariant. Findings are P0=0/P1=0/P2=4/P3=4. Recommend separately authorized Level 7 presentation/difficulty diagnosis or repair and owner-only repeat before Level 8.

## 1. Accepted baseline and sequence role

Level 6 `staggered_doors` uses one delay-3 ECHO, two Plates, and two unavoidable single-dependency Doors. Its accepted exact evidence is `L*=15`, `N*=4 EXACT`, visited `6772`, maximum frontier `1179`, with two distinct open-snapshot Door windows. The authenticated owner completed it unassisted at visible Turn 16 in approximately 1 minute with two restarts, understood the two Door events, and requested a more complex Level 7.

Level 7 must create a clear increase through two future replay offsets and one simultaneous convergence, not through hidden relationships, reverse-counting, a larger empty map, repeated blocked inputs, or corridor length. Level 8 retains the later synthesis role: three Plates and a mixed single-dependency/AND two-Door chain across two visible stages.

## 2. Frozen boundary and non-goals

Allowed concepts are only rectangular floor/walls, one current player, two fixed-delay ECHOs reading the same history, Plates, combinational `all_plate_ids` Doors, one player-only EXIT, legal actor overlap, restart, and accepted next-turn/open-snapshot behavior.

The target introduces no Gate, latch, toggle, switch, timer, key, inventory, box, hazard, enemy, combat, teleport, new action, new actor type, second input history, independent ECHO control, goal change, schema field, runtime rule, solver rule, catalog rule, asset, audio, narrative, or save behavior. Literal `WAIT` is not a teaching goal and may not be counted as a meaningful decision or used as padding.

## 3. Candidate-comparison method

Each candidate is a bounded structural proposal. Scores are planning judgments on a five-point scale, not solver or player evidence.

| Criterion | Weight | Question |
|---|---:|---|
| Temporal reasoning | 25% | Does the puzzle require understanding two different replay offsets? |
| Observability | 20% | Can roles, dependencies, and the relevant window be read from the board? |
| Necessity/proof feasibility | 15% | Can both ECHOs and every dependency be isolated with decisive controls? |
| Recovery quality | 15% | Do plausible mistakes create understandable, bounded recovery rather than a hidden dead state? |
| Level 8 preservation | 15% | Does Level 8 retain a materially larger two-stage synthesis role? |
| Production risk | 10% | Can primitive 960×540 presentation support the structure without a prerequisite redesign? |

| Candidate | Temporal | Observable | Proofable | Recovery | Preserves L8 | Risk | Weighted result |
|---|---:|---:|---:|---:|---:|---:|---:|
| A — AND convergence | 5 | 4 | 5 | 4 | 5 | 4 | 4.55 |
| B — dual-ECHO staggered windows | 4 | 3 | 4 | 4 | 3 | 3 | 3.55 |
| C — bounded three-actor hybrid | 5 | 3 | 4 | 2 | 4 | 3 | 3.70 |

## 4. Candidate A — AND convergence (selected)

- Working ID/title: `two_echo_convergence` / `Two Echo Convergence / 双影汇流`
- Mental model: record one branching loop so the delay-4 ECHO occupies Plate A while the delay-2 ECHO occupies Plate B, opening one AND Door for YOU on the following input.
- ECHOs: `echo_late`, delay 4; `echo_near`, delay 2.
- Plates/Doors: two Plates; one Door with dependency set `{plate_a, plate_b}`.
- Board envelope: 9×7.
- Route topology: compact figure-eight/recovery loop feeding one visible convergence lane; the Door is the sole terrain articulation to EXIT.
- Synchronization obligation: one required 1–2-turn simultaneous two-ECHO occupancy window.
- ECHO necessity hypothesis: the delay gap places the two replays at different points of the recorded loop; neither one actor nor a longer single route can occupy both distinct Plate cells simultaneously.

Concept sketch only; letters are not final formal coordinates or a route:

```text
#########
#.....#X#
#.....#D#
#.A.B...#
#.#...#.#
#S......#
#########

S = shared YOU/ECHO spawn
A/B = distinct Plates
D = AND Door requiring A+B
X = player-only EXIT
```

Coordinate-level authoring seed: shared spawn near `[1,5]`; Plate A near `[2,3]`; Plate B near `[4,3]`; Door near `[7,2]`; EXIT near `[7,1]`. The later implementation task may adjust floor cells and these seed coordinates only while preserving the frozen 9×7 envelope, figure-eight/recovery topology, two-action Plate separation hypothesis, Door articulation, and proof obligations. No coordinate is accepted until strict load, solve, and controls pass.

Expected meaningful decisions:

1. choose which loop branch records the first Plate approach;
2. choose the crossover that preserves the two-offset separation;
3. decide whether to commit to the convergence lane or take the visible recovery loop;
4. enter the Door approach only after the two-ECHO occupancy result is visible;
5. recover after a missed window without repeating a blocked input.

Expected recovery: a wrong branch or one-step overshoot should remain recoverable in approximately 2–6 additional actions or a voluntary restart. No mistake may create an unreadable soft lock. Distinct alternatives must create different future canonical states or measurable solution penalties.

Shortcut risks: YOU presses a Plate; one ECHO reaches both Plate positions through overlap; a loop bypasses the Door; the open result persists wide enough to erase timing; a blocked action accidentally substitutes for intended synchronization. Observability risks: overlapping ECHOs appear as one actor; A/B dependencies look identical; the player mistakes the committed open result for same-input entry permission.

Provisional targets: `L*=17–25`; `N*=1–8 EXACT`; visited `8000–150000`; maximum frontier `1000–25000`; one required 1–2-turn window. Selection reason: it adds two-delay simultaneous reasoning, is cleanly controllable, stays readable with one Door, and leaves the larger mixed two-stage chain to Level 8.

## 5. Candidate B — dual-ECHO staggered windows (rejected)

- Working ID/title: `split_echo_windows` / `Split Echo Windows`
- Mental model: delay-2 and delay-5 ECHOs create two separate single-Plate Door openings along different branches.
- ECHOs: delays 2 and 5.
- Plates/Doors: two Plates; two Doors with `{plate_a}` and `{plate_b}`.
- Board envelope: 9×7.
- Topology: central fork, two unequal loops, then a serial Door corridor.
- ECHO necessity hypothesis: delay-2 is the only intended actor aligned with the first Plate window and delay-5 with the second; removing either should make the corresponding articulation uncrossable.

```text
#########
#..A.D.X#
#..#.#..#
#S.#....#
#..#.#..#
#..B.D..#
#########
```

Both ECHOs would be intended to own different windows; four route/timing choices and 2–5-action recovery were targeted. Provisional metrics were `L*=18–27`, `N*=1–12`, visited `10000–180000`, frontier `1500–30000`.

- Expected decisions: choose the first branch, commit to the first window, select the inter-branch recovery route, and commit to the second window.
- Shortcut risks: one ECHO services both single dependencies, YOU substitutes on a Plate, or a side corridor bypasses either Door.
- Observability risks: two Doors, two paths, and two delay roles recreate ordering ambiguity and crossing relationship lines.
- Level 8 effect: consumes the staged-Door grammar that should remain the later finale synthesis.

Rejected because two serial single-dependency windows too closely repeat Level 6's visible grammar. Distinct delays add state, but the player-facing experience risks becoming “Level 6 with another ECHO.” Two dependency paths also recreate the same-color/order burden and consume part of Level 8's staged-Door role. Proof is feasible, but sequence differentiation and primitive legibility are weaker than Candidate A.

## 6. Candidate C — bounded three-actor hybrid (rejected)

- Working ID/title: `three_actor_threshold` / `Three-Actor Threshold`
- Mental model: the two ECHOs align on Plates A/B while YOU deliberately holds Plate C; the committed result opens one three-Plate AND Door for the next input.
- Preparatory obligation: YOU must reach and hold C before the two delayed arrivals; the simultaneous convergence is A+B+C in the resulting state.
- ECHOs: delays 2 and 4.
- Plates/Doors: three Plates; one Door with `{plate_a, plate_b, plate_c}`.
- Board envelope: 9×7.
- Topology: triangular hub with three short approach lanes and one exit articulation.
- ECHO necessity hypothesis: YOU occupies Plate C while the delay-2 and delay-4 ECHOs occupy distinct A/B cells; no actor can cover two Plate positions, so removing either ECHO should prevent the three-way result.

```text
#########
#...A..X#
#..#...D#
#B...C..#
#..#.#..#
#S......#
#########
```

Both ECHOs and YOU would have explicit simultaneous roles. Provisional metrics were `L*=19–27`, `N*=1–6`, visited `15000–200000`, frontier `2000–35000`.

- Expected decisions: choose the recorded branch, assign YOU to Plate C, preserve both delayed arrivals, and commit to the open snapshot.
- Expected recovery: a missed three-actor alignment likely costs 4–8 actions or a restart, with higher soft-lock perception risk.
- Shortcut risks: YOU plus one ECHO satisfy multiple roles through route timing, actor overlap erases a role, or the three-way Door stays open too widely.
- Observability risks: three occupied Plates, two ECHO badges, YOU, and one Door state crowd the same 960×540 decision frame.
- Level 8 effect: spends the three-Plate escalation even though Level 8 retains a second Door stage.

Rejected for Level 7 because three simultaneous role assignments create high overlap and recovery risk before two-ECHO convergence has been established. It also spends the three-Plate escalation intended for Level 8. The structure is mechanically legal, but likely difficulty would come partly from state crowding and brittle repositioning rather than a clean new temporal idea.

## 7. Selected formal target freeze

Exactly one preferred target is selected: Candidate A.

| Field | Frozen target |
|---|---|
| `level_id` | `two_echo_convergence` |
| Display title | `Two Echo Convergence / 双影汇流` |
| ECHOs | exactly 2: `echo_near` delay 2 and `echo_late` delay 4 |
| Spawn relationship | YOU and both ECHOs share one declared spawn |
| Plates | exactly 2: `plate_a`, `plate_b` |
| Doors | exactly 1: `door_convergence` |
| Door dependency | exactly `all_plate_ids=[plate_a, plate_b]` as an unordered AND-set |
| Initial Door state | `initial_open=false`, cross-validated against the shared spawn |
| Board | exactly 9×7; compact figure-eight/recovery loop plus one convergence lane |
| Door topology | `door_convergence` is a terrain articulation on every YOU-to-EXIT path |
| EXIT | exactly one player-only EXIT beyond the Door; ECHO access never completes |
| Synchronization | at least one necessary two-ECHO occupancy window, width 1–2 turns |
| Meaningful decisions | at least 4, excluding repeated blocked actions, corridor continuation, and padding |
| WAIT | not a teaching goal; cannot satisfy the meaningful-decision count |

Intended reasoning chain:

1. identify delay-2 and delay-4 ECHOs as two views of the same history at different offsets;
2. record a branch/crossover pattern that places their future positions on two distinct Plates together;
3. preserve the alignment while YOU reaches the visible convergence lane;
4. observe the committed A+B open result;
5. cross from the accepted open start-turn snapshot on the following input.

This is a reasoning description, not a movement sequence or solution witness.

### Anti-padding and recovery freeze

- The 9×7 room may contain no long forced corridor added only to raise `L*`.
- A meaningful decision must change the future canonical state or have a measured shortest-completion penalty.
- Repeated collision with a wall/closed Door, literal WAIT, and a forced corridor step do not count.
- At least three audited wrong choices must be recoverable; target penalty is 2–6 actions.
- A one-window miss may invite restart, but the board must make the cause legible and must not appear frozen.
- If the shortest solution works through blind repeated movement or one actor taking a longer route, reject the layout.

## 8. Prospective quantitative gate

These bands are frozen before implementation and are not results.

| Metric | Required target |
|---|---:|
| `L*` | 17–25 |
| `N*` | 1–8, status `EXACT` |
| Visited states | 8,000–150,000 |
| Maximum frontier | 1,000–25,000 |
| Required synchronization window | 1–2 turns |
| Meaningful decisions | at least 4 |
| Audited recoverable wrong choices | at least 3 |

Starting solver limits:

```text
depth_limit = 64
state_limit = 500000
time_limit_ms = 30000
solution_count_cap = 1000000
```

`N*` counts distinct shortest action sequences under the accepted solver contract. A capped result is `CAPPED`, not exact, and does not satisfy this target. `UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE` is valid only after complete reachable-state exhaustion without a depth, state, or time limit. Any limit result remains unverified and returns the layout to bounded authoring; do not widen limits merely to force acceptance.

Owner-facing target: `OWNER_REVIEW_TARGET_NOT_FRESH_NOT_INDEPENDENT` — seek a clear reasoning increase over Level 6's approximately 1 minute/two restarts, provisionally 3–8 minutes and 1–5 restarts, without relying on obscurity. This is a review target, not a difficulty promise.

The earlier roadmap proposed 5–10 minutes. Task 0014 refines that to 3–8 minutes because the authenticated owner completed Level 6 in approximately 1 minute: a 3-minute lower bound still seeks a clear increase, while treating confusion beyond 8 minutes as success would risk rewarding poor observability. Only directly supplied timing may be recorded later.

## 9. Mandatory machine-proof package for implementation

The later implementation task must provide all of the following:

1. strict `level_v1` load and seven-entry catalog validation;
2. solver `SOLVED`, witness replay, exact restart equality, canonical metrics, limits, and formal SHA-256;
3. `N*=1–8 EXACT` under the frozen count cap;
4. remove/isolate `echo_near` while retaining `echo_late`: complete unsolved or a decisive loss of the convergence structure;
5. remove/isolate `echo_late` while retaining `echo_near`: the same standard;
6. no-ECHO/player-only control: complete unsolved;
7. isolate `plate_a` and isolate `plate_b`: each complete unsolved if the finite state can be exhausted;
8. replace the AND dependency with A-only and B-only controls: each must materially simplify exact solution structure and fail the two-ECHO teaching role;
9. remove `door_convergence`: materially changed exact structure, never treated as equivalent;
10. equalize delays to 2/2 and separately to 4/4: each must destroy or materially change the intended two-offset synchronization;
11. relocate Plate A and separately Plate B to declared control cells: at least one control must destroy the target structure and neither may preserve an equivalent hidden solution;
12. terrain/articulation audit proving no player-only, single-ECHO, or side-route Door bypass;
13. ECHO-on-EXIT non-terminal and YOU-on-EXIT completion controls;
14. trace every shortest or bounded accepted solution through the required A+B result and open-snapshot Door crossing;
15. actor-role trace mapping both ECHO IDs/delays to their Plate occupancy without presentation-derived logic;
16. at least four meaningful decisions with distinct successors or measured penalties; at least three bounded recovery traces;
17. legal overlap audit proving actor overlap cannot substitute one actor for both Plate cells;
18. all six prior formal hashes, accepted metrics, catalog order, progression, direct launch, reusable Gameplay, and aggregate markers unchanged except the authorized Level 7 additions.

Controlled variants are test-only evidence and must never enter the product catalog. A control ending at a resource limit is not called unsolved.

## 10. Dependency and actor legibility freeze

Difficulty must remain readable without color. The implementation gate must use at least two redundant persistent cues:

- Plate A and its Door contribution use the visible label `A` plus a triangular/pip shape; Plate B uses `B` plus a circular/pip shape.
- `door_convergence` displays both dependency tokens as `A + B`, with each pip filled independently from committed Plate occupancy.
- Color families may supplement those labels/shapes but cannot be the only relationship cue.
- `echo_near` carries a stable `E2` delay badge and solid-outline token; `echo_late` carries `E4` and a double/dashed-outline token.

When both ECHOs overlap, render two readable concentric/offset outlines and both `E2`/`E4` badges rather than replacing them with one undifferentiated actor. At 960×540 with 60 px cells, primary A/B and E2/E4 marks must remain legible inside or adjacent to the cell without covering YOU, Door state, or EXIT. Static labels/shapes survive screenshots; a short pulse may reinforce changes in motion but cannot be the sole cue. Grayscale inspection must preserve label, shape, outline, and filled/unfilled distinctions.

Connecting lines are optional contextual reinforcement only. They must not cross unrelated entities, become the primary cue, or imply a dependency absent from `all_plate_ids`.

## 11. Timeline and Help decisions

Primary Timeline disposition:

```text
TIMELINE_REMOVED_FROM_LEVEL_7_TEACHING_GOAL
```

Level 7 must be solvable from visible board positions, stable E2/E4 identity, A/B dependencies, committed Door state, and learned replay rules without reverse-counting a timeline. The currently accepted compact Timeline may remain as an inherited optional status surface and may show only contract-derived next replay actions; Task 0014 does not authorize changing its indexing, layout, or expanded form. Owner review success will not require opening or using it. A later redesign requires separate evidence that board-first reasoning is insufficient for reasons other than poor dependency/actor cues; Timeline redesign is not a prerequisite for formal Level 7 implementation.

Primary Help disposition:

```text
HELP_CONTEXTUAL_OPTIONAL
```

Help remains a zero-turn modal reference, not a solution tool. For Level 7 it may identify controls, E2/E4 meaning, A/B shape-label matching, combinational `A+B`, and next-turn Door semantics. It must not provide a movement sequence, route, branch choice, exact timing count, Plate occupancy schedule, or solver witness. Level 7 must remain understandable without opening Help; Help cannot compensate for unreadable board state. Any visual Help redesign remains separately gated.

## 12. Recommended implementation order

1. author bounded 9×7 terrain candidates under the frozen entity structure without changing runtime/schema;
2. reject invalid, bypassable, or visually ambiguous layouts before expensive counting;
3. run solve/replay and exact metric capture under frozen starting limits;
4. run both-ECHO, Plate, dependency, delay-equality, relocation, articulation, overlap, and decision controls;
5. add the formal JSON and catalog entry only for a target-compliant candidate;
6. implement only the primitive A/B, E2/E4, and A+B cues required by this plan through the reusable Gameplay presentation;
7. run complete regression, progression/direct-launch smoke, capture, hash comparison, and owner-review preparation.

No step authorizes a runtime, solver, schema, project setting, Timeline, Help, asset, audio, narrative, save, export, or release change.

## 13. Owner-only review plan

The later human review must be classified exactly:

```text
AUTHENTICATED_OWNER_NOT_FRESH_NOT_INDEPENDENT_LEVEL_7_REVIEW
```

The owner is the only available playtester. Do not seek, require, contact, recruit, or suggest a third party. Preserve `FRESH_INDEPENDENT_REVIEW_UNAVAILABLE_BY_OWNER_CONSTRAINT` as an explicit residual limitation.

Record only supplied or directly observed facts:

- unassisted/assisted completion status, visible turn, elapsed time, restarts, and operational assistance;
- whether the owner distinguishes E2 and E4 and explains their different offsets;
- whether both ECHO roles and A+B causality are understood;
- whether the synchronization was predicted, inferred through observation, found by trial and error, or accidental;
- whether labels, shapes, overlap rendering, and committed Door state are readable;
- whether Timeline or Help was used and whether either aided, cluttered, or confused;
- whether difficulty exceeds Level 6 because of reasoning rather than hidden state or corridor length;
- failure/recovery comprehension, P0–P3 findings, and preserve/simplify/repair/replace recommendation.

Ask after the attempt, before revealing any witness:

1. Was Level 7 clearly harder than Level 6, and was the increase caused by reasoning or by unclear state?
2. What did E2 and E4 do differently with the same earlier inputs?
3. Which ECHO did you expect on Plate A and which on Plate B at the useful convergence?
4. Did you predict the A+B window, infer it after observation, find it through trial and error, or reach it accidentally?
5. Why was the Door passable on the crossing input?
6. Were A/B labels and shapes readable and correctly paired with the Door pips?
7. Could you distinguish E2 and E4 when they overlapped?
8. Did Timeline help, add clutter, or remain unused? Did you need reverse-counting?
9. Did Help add useful context without revealing the route?
10. Were failed attempts understandable and recoverable, and should the level be preserved, simplified, repaired, or replaced?

No result may be labeled fresh, blind, first-player, independent, population-level, or candidate acceptance evidence.

## 14. Stop conditions and unresolved risks

Stop implementation authoring and return to design if any occurs:

- both ECHOs cannot be individually proven necessary;
- one actor or overlap can satisfy both Plate roles;
- a player-only/single-ECHO/terrain route bypasses the convergence;
- the target bands or exact-count requirement cannot be met under frozen limits after bounded iteration;
- meaningful difficulty comes from WAIT, repeated blocked moves, corridor padding, unreadable overlap, or dependency ambiguity;
- the required synchronization window is absent or wider than 2 turns without a written re-adjudication;
- primitive A/B and E2/E4 cues cannot remain readable at 960×540 or in grayscale;
- implementation would require schema/runtime/solver/catalog-contract expansion;
- the structure grows into Level 8's three-Plate mixed two-Door synthesis;
- any prior formal hash/metric or accepted behavior changes.

Primary unresolved risks are legal actor overlap creating an unintended substitute, the shared history producing more shortest solutions than targeted, and compact overlap badges becoming crowded. These are proof/presentation risks for the implementation task, not accepted defects or permission to change the contract.

## 15. Next gate and non-claims

After GPT acceptance, issue one bounded implementation task for exactly this selected target. It may authorize one formal Level 7 JSON, the seventh catalog entry/final-flag transfer, focused validation/capture tests, required primitive dependency/actor cues, current-document synchronization, and one implementation report.

This plan does not establish a created, valid, solvable, replayable, difficult, fun, balanced, internally playable, fresh-reviewed, or candidate Level 7. It does not authorize Level 8, Timeline/Help redesign, assets, audio, narrative, animation, localization, accessibility acceptance, Gate, persistence, export, release, or submission.
