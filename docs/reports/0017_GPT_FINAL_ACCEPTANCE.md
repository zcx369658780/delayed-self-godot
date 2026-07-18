# Task 0017C GPT final acceptance

- Reviewed implementation: `47e40fa13cccc2725c3110969c64f1e328dee0a8`
- Parent continuation: `tasks/0017C_echo_spacing_bridge_implementation_continuation.md`
- Accepted prerequisite: `TASK_0017P_LEVEL_SELECT_SCROLLABILITY_REPAIR_ACCEPTED`
- Verdict: `TASK_0017_ECHO_SPACING_BRIDGE_ACCEPTED_INTERNAL_PLAYABLE`
- Accepted status: `INTERNAL_PLAYABLE / OWNER_SEQUENCE_REVIEW_REQUIRED`

## Accepted formal result

The tracked `echo_spacing_bridge / Diverging Echoes / 错位回声` is accepted as the mandatory sequence-7 curriculum bridge.

```text
board = 8×7
ECHO delays = 2 and 4, shared spawn
Plates = A [5,3], B [6,5]
Door = A+B at [6,2]
EXIT = [6,1]
SHA-256 = 805cdc05ea9b3805189ba7be4938cb7ede4e7056b9ae9a7e911df96a801d58ee
L* = 16
N* = 12 EXACT
visited_states = 19059
maximum_frontier = 3734
```

The implementation exactly reconstructs the externally preserved `candidate_07.json`; no replacement geometry iteration was used.

## Causal and necessity acceptance

All 12 shortest solutions contain:

1. an early post-activation spacing change where one ECHO is `BLOCKED` and the other `MOVED`;
2. the fixed role result E2 on A and E4 on B;
3. YOU staged for entry while A+B opens the Door;
4. the following input entering from the open start snapshot;
5. later completion by YOU only.

No shortest solution reverses the E2/E4 Plate roles.

Complete finite-state controls are accepted:

- no ECHO: unsolved;
- E2 only: unsolved;
- E4 only: unsolved;
- equal delays 2/2: unsolved;
- equal delays 4/4: unsolved.

Single-dependency, Door-removal, Plate-relocation, and blocker-relocation controls materially simplify or change the authored chain. Plate-to-Door distances, exhaustive single-ECHO controls, distinct Plate cells, and Door articulation exclude YOU substitution, overlap substitution, and route bypass.

Three meaningful decisions have exact recoverable penalties of +3, +1, and +4. The accepted witness requires neither WAIT nor a repeated blocked-input macro.

## Catalog and presentation acceptance

The catalog is accepted at eight contiguous entries:

- Levels 1–6 remain semantically unchanged;
- `echo_spacing_bridge` is non-final sequence 7 after `staggered_doors`;
- byte-identical `two_echo_convergence` is sequence 8 after the bridge and remains the sole final entry;
- no `signal_convergence` entry exists.

Reset, ordered unlock, direct launch, completion return, and Level Select tail focus/scroll are accepted. The Task 0017P App Shell implementation remains unchanged.

Existing reusable presentation is accepted for this machine gate: A/B labels, shapes and pips; E2/E4 badges and outlines; truthful Task 0015R spacing feedback; stable-spacing no-cue behavior; reduced-motion and grayscale readability; no new always-on relationship lines.

## Validation acceptance

Focused validation is accepted at 61 assertions. The fresh aggregate is accepted at:

```text
550 assertions / 9 vectors
12 markers, each exactly once
native exit = 0
stderr = intentional LEVEL_ID_MISMATCH only
```

Twelve native 960×540 Compatibility captures cover catalog progression, initial state, stable-spacing control, required divergence, recovery, A+B result, following-input crossing, shifted Level 8 unlock and tail focus, reduced motion, and grayscale.

All seven pre-bridge formal hashes and accepted metrics remain byte-exact, including `two_echo_convergence` SHA-256 `772410d3b8bb807e35472ee2a7d07b703de66e1e0e92ffb4d1ff8433a345d5fd`.

## Scope and claim boundary

This acceptance establishes machine correctness, formal necessity, catalog integration, reusable runtime presentation, and `INTERNAL_PLAYABLE` status.

It does not establish authenticated-owner comprehension, fresh or independent review, unbiased difficulty, fun, curriculum effectiveness, finale acceptance, candidate acceptance, export, release, or submission readiness.

The next gate is one `AUTHENTICATED_OWNER_NOT_FRESH_NOT_INDEPENDENT_BRIDGE_SEQUENCE_REVIEW`. The owner is the only available playtester; no third party may be sought or required. The review must test whether the bridge is understandable without an exact route, whether failure states support recovery, and whether the Level 6 → bridge → shifted `two_echo_convergence` sequence materially improves the difficulty curve.

`signal_convergence`, Help/Timeline redesign, production art/audio, export, release, and submission remain unauthorized.