# Submission-core levels 9–12 scope (CURRENT)

- Status: `FROZEN PLANNING PACKAGE / READY FOR GPT REVIEW`
- Task: `0024X`
- Scope: future sequences 9–12 only; no formal level implementation
- Foundation: `TASK_0024W_COMPLETE_CORE_MECHANICS_FOUNDATION_ACCEPTED`

## Frozen answer

The submission-core target remains twelve levels. Existing IDs and sequences 1–8 are immutable. Future rooms append linearly as sequences 9–12; sequence 9 requires completion of `two_echo_convergence`. Sequence 8 remains the sole formal finale until a separate catalog/Profile integration gate. Sequence 12 is only `FINALE_CANDIDATE_ONLY`.

The curriculum is frozen as:

1. sequence 9 — a player-positioned crate creates persistent timing state;
2. sequence 10 — one `main` key/lock creates an irreversible YOU-only route commitment;
3. sequence 11 — actor identity controls a grouped bridge under next-turn and occupied-cell closure rules;
4. sequence 12 — a one-shot latch creates a permanent phase transition, then synthesizes already taught sensor/barrier timing.

No room may introduce paired portals, one-way gates, fragile floors, conveyors, a second key type, or any other stretch rule.

## Read-only audit of sequences 1–8

| Seq. | Stable ID | Teaching/combination role | Accepted solver facts |
|---:|---|---|---|
| 1 | `tutorial_reach_exit` | movement, YOU-only EXIT, restart; no ECHO | `L*=3`, `N*=3 EXACT`, visited 6, frontier 2 |
| 2 | `tutorial_echo_bridge` | first delay-3 ECHO, Plate hold, next-turn Door crossing | `L*=9`, `N*=12 EXACT`, visited 1,975, frontier 509 |
| 3 | `vertical_slice_delay_3` | reinforces the same delay-3 Plate/Door contract in the formal slice | `L*=9`, `N*=31 EXACT`, visited 1,318, frontier 393 |
| 4 | `door_one_turn_late` | isolates the closed-result/open-next-snapshot doctrine | `L*=9`, `N*=7 EXACT`, visited 291, frontier 116 |
| 5 | `two_keys_one_door` | despite its historical title, uses two Plates and one AND Door; teaches distinct YOU/ECHO occupancy | `L*=12`, `N*=1 EXACT`, visited 1,260, frontier 225 |
| 6 | `staggered_doors` | one ECHO creates two distinct Door windows | `L*=15`, `N*=4 EXACT`, visited 6,772, frontier 1,179 |
| 7 | `echo_spacing_bridge` | two ECHOs, deliberate spacing divergence, A+B convergence | `L*=16`, `N*=12 EXACT`, visited 19,059, frontier 3,734 |
| 8 | `two_echo_convergence` | strongest current recovery/convergence room and current finale | `L*=19`, `N*=6 EXACT`, visited 61,975, frontier 21,449 |

The curve is flat at `L*=9` across sequences 2–4, rises at sequence 5, then becomes materially harder across 6–8 through dependency depth, recovery choices and two-ECHO role separation. Sequence 7 and 8 overlap in their A+B/two-ECHO result, but sequence 7 teaches spacing divergence while sequence 8 demands a longer recovery/convergence plan.

No formal room currently teaches crates, consumable keys/locks, typed sensors, grouped barriers, or latches. The five accepted schema-v2 fixtures prove engine contracts, not authored curriculum or formal admission. A new room that merely replaces a v1 Plate with a sensor, repeats the sequence-7 static blocker, or repeats a two-Plate convergence would add no new reasoning structure.

The future bands below are planning targets, not solver claims. They are anchored to sequences 6–8 (`L*=15/16/19`, exact shortest counts `4/12/6`) and require later machine measurement.

## Sequence 9 — 箱影定拍 / Crate-Shadow Timing

- Proposed stable `level_id`: `crate_shadow_timing`
- Sequence/classification: `9`; `core`
- Unlock: requires `two_echo_convergence`; no other prerequisite
- Primary family: YOU-only push crates
- Secondary families: delayed ECHO plus existing v1 Plate/Door only
- Teaching objective: establish that only YOU pushes and that the crate's chosen resting cell persists while delayed input continues.
- Required temporal insight: one deliberate push places the crate in an ECHO lane; the resulting one-turn ECHO block changes its phase, after which the ECHO holds the required Plate while YOU crosses. Static terrain alone must not produce the same phase.
- Entity cardinality: exactly 1 crate; exactly 1 ECHO, delay 2–4; 0–1 v1 Plate; 0–1 v1 Door; no v2 sensor, barrier, key, lock, or latch.
- Footprint: 7–9 by 5–7 cells; one readable push lane and one recovery loop.
- Complexity limits: at most two consequential pushes in a shortest witness; no crate corner maze, multi-crate ordering, generic Sokoban packing, or long blocked-input macro.
- Target shortest-turn band: 13–16, overlapping sequence 6/7 length but with lower dependency burden than sequence 10–12.
- Shortest-solution posture: `moderate`; target exact count 4–20 so the lesson is required without forcing one opaque input string.
- Future solver budget: depth 48, 250,000 states, 20,000 ms, count cap 1,000,000.
- Mandatory evidence: bounded BFS solve; one witness replayed through shared Simulation; exact/capped `N*`; exact restart and canonical-key trace equality.
- Necessity controls: no-push control and displaced-crate control must be complete-unsolved or materially eliminate the required phase-changing chain; static-blocker substitution must not qualify as equivalent evidence.
- Shortcut probes: walk-around route, ECHO entering/pushing through crate, push from an illegal side, repeated collision macro, EXIT without ECHO-held dependency.
- Failure feedback: distinguish `YOU can push` from `ECHO blocked by crate`, and make a recoverable misplacement visibly different from a hard restart state.
- Tutorial/HUD note: one concise crate-push cue and persistent crate outline; no route or solution text.
- Admission: intended crate/ECHO event occurs in every shortest solution; no-push/displaced controls pass; witness replay, restart, shortcut audit and owner playthrough pass.
- Hard-cut fallback: one crate, one phase-changing push, one ECHO/Plate window; remove any optional second push or recovery branch.

## Sequence 10 — 独行钥匙 / The Key Is Yours

- Proposed stable `level_id`: `key_route_commitment`
- Sequence/classification: `10`; `core`
- Unlock: requires `crate_shadow_timing`
- Primary family: YOU-only consumable key and matching lock
- Secondary families: delayed ECHO plus one existing v1 Plate/Door dependency
- Teaching objective: only YOU collects and spends the single `main` key; lock removal is persistent until restart.
- Required temporal insight: the key detour writes the ECHO history needed downstream, and the lock must be consumed on the accepted turn only after that phase is prepared. The key/lock cannot merely add walking distance.
- Entity cardinality: exactly 1 `main` key and 1 matching lock; exactly 1 ECHO, delay 2–4; 0–1 v1 Plate and 0–1 v1 Door; no second key color, crate, typed sensor, grouped barrier, or latch.
- Footprint: 8–10 by 6–8 cells; one pre-lock preparation loop and one post-lock route.
- Complexity limits: one irreversible inventory decision; no hidden inventory count, multi-lock bookkeeping, or consumable soft-lock without readable restart feedback.
- Target shortest-turn band: 15–19, at or above sequence 6 and no longer than the current sequence-8 result without evidence.
- Shortest-solution posture: `narrow`; target exact count 1–8 because the irreversible route commitment should be legible and material.
- Future solver budget: depth 56, 400,000 states, 25,000 ms, count cap 1,000,000.
- Mandatory evidence: shared-Simulation BFS/witness replay; same-turn key consumption trace; restart restores key and lock; canonical state distinguishes remaining/held keys and removed locks.
- Necessity controls: no-key, no-lock and ECHO-item substitutions; at least one must be complete-unsolved and all must prove that ECHO cannot collect/spend and that the irreversible commitment changes the intended chain.
- Shortcut probes: approach lock without key, ECHO crossing/removing lock, collect key after lock, bypass around lock, consume without inventory, exploit restart residue.
- Failure feedback: show key collected, matching lock consumed, and why an ECHO contact is inert; a committed bad phase must recommend restart without revealing the route.
- Tutorial/HUD note: use one `main` key icon/type label and an inventory-presence cue; no second color.
- Admission: all shortest solutions use YOU-only collection and same-turn matching-lock consumption in the intended delayed route; controls, replay, restart, shortcut audit and owner playthrough pass.
- Hard-cut fallback: retain one key, one lock and one ECHO-timed downstream Door; remove optional branch/recovery geometry.

## Sequence 11 — 身份错拍桥 / Identity-Shift Bridge

- Proposed stable `level_id`: `identity_shift_bridge`
- Sequence/classification: `11`; `core`
- Unlock: requires `key_route_commitment`
- Primary families: typed occupancy sensors; grouped multi-cell barrier/bridge
- Secondary family: one crate only if the primary candidate remains within budgets
- Teaching objective: actor identity, not occupancy count alone, controls a grouped bridge whose state affects entry on the following turn.
- Required temporal insight: YOU first arms a YOU-only sensor, then an ECHO-only result changes the grouped bridge for the next snapshot; the critical crossing or exit requires occupied-cell closure deferral. At least these two eligibility modes must be necessary.
- Entity cardinality: 1 ECHO, delay 2–4; exactly 2 critical sensors (`YOU_ONLY`, `ECHO_ONLY`) with `include_crates=false`; 1 grouped barrier with 2–3 cells. The primary candidate may add exactly 1 auxiliary `ANY_ACTOR` sensor with `include_crates=true` and exactly 1 crate; those additions are optional and must not obscure identity teaching.
- Footprint: 9–11 by 7–9 cells; barrier cells must read as one group.
- Complexity limits: at most three critical sensor states, one barrier group, one crate and no key/lock/latch; no color-only identity communication.
- Target shortest-turn band: 18–23, above sequence 7 and centered above sequence 8 because identity and next-turn state both matter.
- Shortest-solution posture: `narrow`; target exact count 1–8, with all shortest paths sharing the identity/timing event.
- Future solver budget: depth 64, 750,000 states, 35,000 ms, count cap 1,000,000.
- Mandatory evidence: BFS/witness replay; exact sensor eligibility trace; grouped next-turn transition; necessary occupied-cell closure deferral; restart/canonical distinction for barriers and crate if present.
- Necessity controls: swap YOU/ECHO activators; change either critical sensor to `ANY_ACTOR`; toggle `include_crates`; reduce the group to one cell; force immediate rather than next-turn closure; disable closure deferral. Controls must distinguish identity and timing, not only path length.
- Shortcut probes: single-actor occupancy, crate satisfying a false-eligibility sensor, barrier side route, entry on the same result turn, closure around an occupied cell without deferral, ECHO-on-EXIT.
- Failure feedback: sensor badges must name eligible actor class; grouped cells share one identity; show requested close versus deferred close without relying on color.
- Tutorial/HUD note: introduce identity icons and a next-turn bridge cue; no route hint. Crate eligibility must be stated explicitly even when false.
- Admission: both critical actor modes, next-turn state and closure deferral occur in every shortest solution; all identity/timing controls, replay, restart, shortcut audit and owner playthrough pass.
- Hard-cut fallback: highest-risk room. Remove the auxiliary crate and `ANY_ACTOR` sensor, keep exactly YOU-only + ECHO-only sensors and a two-cell bridge, with `include_crates=false` explicit. Do not cut identity or next-turn/deferral evidence.

## Sequence 12 — 余响落锁 / The Lasting Echo

- Proposed stable `level_id`: `lasting_echo_latch`
- Sequence/classification: `12`; `core`; `FINALE_CANDIDATE_ONLY`
- Unlock: requires `identity_shift_bridge`
- Primary family: one-shot room-local latch
- Secondary families: typed sensors and one grouped barrier; exactly three accepted families in the critical chain
- Teaching objective: a latch permanently changes room-local topology until restart, enabling a second phase that reuses already taught identity/barrier timing.
- Required temporal insight: phase one coordinates YOU/ECHO to activate one latch and permanently open the route; phase two returns through the changed topology and solves a previously taught typed-sensor/grouped-barrier crossing. No new rule debuts.
- Entity cardinality: 1 latch; 1 target barrier group of 1–3 cells; 1–2 typed sensors using modes already taught in sequence 11; 1–2 ECHOs with existing delays; no crate, key or lock in the critical chain.
- Footprint: 10–12 by 7–9 cells with two visually separable phases and a readable return path.
- Complexity limits: one latch activation, at most three mechanic families, at most two ECHOs, no hidden reset exception, no stretch mechanic.
- Target shortest-turn band: 21–28, above sequence 8 in dependency depth but capped to remain explainable and searchable.
- Shortest-solution posture: `narrow`; target exact count 1–6 or a justified low capped bound, with a deterministic first witness.
- Future solver budget: depth 80, 1,000,000 states, 45,000 ms, count cap 1,000,000.
- Mandatory evidence: bounded solve; deterministic witness and shared-Simulation replay; explicit pre-/post-latch canonical states; restart restores latch and barrier immutably; all shortest solutions include both phases.
- Necessity controls: latch disabled, latch reset after activation, target state reversed, and direct post-latch-route control. The latch-disabled/reset variants must be complete-unsolved or materially eliminate the required two-phase chain.
- Shortcut probes: reach EXIT before latch, sensor/barrier-only bypass, persistent state leaking across restart, repeated latch activation, more than three critical families, ECHO completion.
- Failure feedback: show `latched for this attempt` and make Restart's full-state reset explicit; phase transition must be legible without declaring the solution.
- Tutorial/HUD note: no new tutorial panel; reuse sequence-11 sensor/bridge language and add one persistent latch-state badge.
- Admission: two-phase latch event appears in every shortest solution; latch controls, replay, canonical/restart, shortcut audit, presentation readability and owner capstone playthrough pass.
- Hard-cut fallback: retain one latch opening one grouped route and one already taught typed-sensor crossing; remove the second ECHO or optional secondary sensor before reducing the twelve-level target.

## Formal-admission evidence contract

Every future room must record loader validity, `SOLVED`, measured `L*`, exact or honestly capped `N*`, visited states, frontier, configured limits, one deterministic witness, shared-Simulation replay, exact restart, canonical-state checks, required necessity controls, shortcut audit, and owner/manual playthrough status. AI-authored layouts or solutions are candidates only until machine solved and replayed.

Difficulty review must also record dependency-chain depth, irreversible decisions, required waits, ECHO participation, dead-end readability and recovery burden. Turn count alone is not acceptance. A wait or blocked input may be present only when its role is explicit and not a repeated-input exploit.

## Catalog, progression, finale and Profile compatibility

- Sequences 1–8 and their IDs remain byte/semantic stable absent an unrelated accepted defect task.
- Future sequence 9 requires completion of `two_echo_convergence`; 10 requires 9, 11 requires 10, and 12 requires 11.
- New IDs append; historical IDs are never renamed or reused.
- Sequence 8 remains `final_level=true`. Promotion of sequence 12 and removal of sequence-8 final status are deferred to a separate accepted catalog/Profile integration gate.
- Existing completion, best-turn, unlock, settings and language values remain valid. Existing snapshots are extended non-destructively, never recomputed or reset.
- This task performs no Profile read/write/migration/reset and does not activate `zh-Hans`. Future migration tests use isolated synthetic/test profiles and prove existing language/settings preservation.

## Cut policy and later gates

Cut in this order: optional secondary combinations; entity count/footprint; weakest family from a combined chain while keeping its dedicated teaching room; fewer than twelve only after a later GPT schedule/stability acceptance. Never substitute levels 13–14 or stretch mechanics, and never weaken solver/replay/restart or Profile protections.

Sequence 11 is the highest-risk concept because identity, grouped next-turn state, closure deferral and optional crate eligibility multiply state and communication burden. Its pre-agreed fallback is the two-sensor/two-cell-barrier form above. Sequence 12's fallback removes optional synthesis but retains the latch phase transition.

Proposed separately authorized gates:

1. author and validate sequence 9 only;
2. author and validate sequence 10 only;
3. author and validate sequence 11, beginning with its fallback envelope;
4. author and validate sequence 12 as `FINALE_CANDIDATE_ONLY`;
5. batch regression and owner curriculum playthrough for 1–12 without catalog/Profile writes;
6. separate catalog/progression/finale/Profile compatibility implementation and isolated migration tests;
7. later Gameplay/UI presentation, localization/assets/audio, build/export and submission gates.
