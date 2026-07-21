# Gameplay breadth and mechanics rebaseline (CURRENT)

- Status: `PLANNING RECOMMENDATION / AWAITS GPT-OWNER ACCEPTANCE`
- Date: 2026-07-21; task: 0023ZW
- Scope: no implementation authority. The eight catalog entries, IDs, flags and Profile behavior remain frozen.

## Decision

Test **C: 12 submission-core levels plus two predeclared stretch levels**, with a Chinese-default complete flow. This improves variety without raising the current hardest-room planning ceiling. `two_echo_convergence` is retained as a chapter-2 capstone in the future curriculum; a new, simpler thematic finale may follow only after an accepted catalog/migration gate. Until then it remains sequence 8 and the sole implemented finale.

| Option | Pacing / finale | Profile and engineering cost | Date risk | Owner playtest burden | Score |
|---|---|---|---|---|---:|
| A: 12 formal | Clear three chapters; old finale must move | Catalog/profile migration plus four rooms | Medium | 12 rooms | 7/10 |
| B: 14 formal | More runway, but late rooms risk repetition | Six rooms, larger solver/test matrix | High | 14 rooms | 5/10 |
| **C: 12 + 2 gated stretch** | Three chapters; new finale only when core is stable | Core work bounded; 13–14 isolated | Medium-low | 12 first, then optional 2 | **9/10** |
| D: 8 + bonus after ending | Lowest migration pressure; weakens learning arc | Bonus routing/ending ambiguity | Medium | 8 + optional | 6/10 |

The observed development Profile (`7 completed / 7 best-turn / 8 unlocked`) is evidence, not permission to alter data. Any expanded sequence requires a separately authorized catalog policy, explicit existing-Profile migration/reset choice, fresh default policy, solver/state-space budgets and owner walkthrough. Stable IDs should be retained for existing rooms; future sequence order may change only through that gate.

## Puzzle doctrine

- Breadth and replayable roles, never execution difficulty, are the target.
- One unfamiliar family per onboarding room; core rooms combine at most three families.
- No undocumented priority; solution length/branching may not exceed the current hardest accepted room without written justification.
- Every chosen core family has an introduction and integration room; a mechanic must distinguish YOU, ECHO, crate, or bounded room state.
- Generic Sokoban is rejected: a crate room must require delayed-self timing or role separation.

## Candidate contracts (future schema/solver work)

All movement starts from the same turn-start snapshot. Resolve intended movement in this order: bounds/walls, locked or closed barrier cells, crate push feasibility, then actor placement; actors may retain existing shared-cell semantics unless a new contract says otherwise. After movement, collect YOU-only items, resolve sensors/latches, derive barrier state for the **next** turn, then test exit. Rendering follows the committed result only. Restart restores all room-local crates, keys, locks and latches; replay never copies a collection or push to ECHOs.

| Family | Exact semantics and visual rule |
|---|---|
| YOU-only crate | One cell; only YOU may push exactly one crate into an empty traversable cell. ECHO attempted push is blocked and does not move the crate. Crates block actor movement and may count as sensor occupancy only where declared. Wall, closed-door, crate, and actor blocking are checked before commit. Deadlocked corner/crate states are valid failures and must be surfaced/restartable, never silently repaired. |
| YOU-only key / lock | YOU entering a matching lock interaction with a matching key consumes one key and removes that lock for the room attempt. ECHOs cannot collect keys, open locks or reproduce removals. Submission core uses one color unless a later complexity review accepts two; color always has icon/shape backup. |
| Multi-cell barrier / bridge | A declared group opens/closes together and is marked by a shared ink color, icon and connective stroke. Changes apply next turn. An actor already on a cell when a bridge closes is never crushed or displaced: closure is deferred while occupied, with a visible pending mark. |
| Typed sensor | `ANY_ACTOR`, `YOU_ONLY`, `ECHO_ONLY`; declared crate inclusion is `NO` by default and must be visible as a crate stamp if enabled. Plate icon + actor silhouette communicates type; no hidden eligibility. |
| One-shot latch | First valid declared activator (YOU, ECHO, or ANY_ACTOR) permanently changes one named local barrier group until restart. No external persistence, toggling or spam state. |

Stretch-only review: paired pads (only paired identity/time relationship), one-way gates (only if timing legible), fragile floors (risk of punitive reset), conveyors (deterministic forced move adds state-space). None enter core without a role-distinction prototype, solver bounds and an accepted implementation gate.

## Candidate curriculum (not level data)

| Seq. | 12-core purpose / lesson | Families | Solution band |
|---:|---|---|---|
| 1–2 | Existing movement and first delayed bridge | baseline ECHO, plate/door | existing bands |
| 3–4 | Existing next-turn door and timing | baseline ECHO, door | existing bands |
| 5 | Crate introduction: YOU makes future ECHO route usable | crate + ECHO | 10–16 |
| 6 | Key introduction: consume now, ECHO benefits later | key/lock + ECHO | 10–16 |
| 7 | Existing `echo_spacing_bridge` integration | E2/E4 + barriers | existing band |
| 8 | Existing `two_echo_convergence` capstone | E2/E4 + AND door | existing band |
| 9 | Typed sensor introduction | ECHO-only sensor + barrier | 12–18 |
| 10 | Multi-cell bridge integration | sensor + bridge + ECHO | 14–20 |
| 11 | Latch introduction and bounded route change | latch + crate or ECHO | 14–20 |
| 12 | New thematic finale, if accepted | 2–3 selected families | 16–22 |

14-level extension: 13 is a crate/key/latch integration and 14 is a gentle optional synthesis/finale epilogue, each 16–24 turns and never required for submission. Existing IDs are not assigned replacement IDs here.

## Acceptance dependencies

GPT/owner must first choose count/finale policy, core subset, migration policy and date gate. Then authorize contracts/schema/solver work, vertical slices, catalog content, presentation, language and audio separately.
