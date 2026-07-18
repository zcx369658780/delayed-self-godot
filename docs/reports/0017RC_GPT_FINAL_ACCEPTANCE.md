# Task 0017RC GPT final acceptance

- Reviewed commit: `6af843c00e755794276647f1c395ff600d20a436`
- Verdict: `TASK_0017RC_BRIDGE_CONTEXTUAL_HELP_REPAIR_ACCEPTED_MACHINE_PRESENTATION`
- Product direction: `BYTE_IDENTICAL_BRIDGE_PLUS_CONTEXTUAL_CAUSAL_HELP`
- Accepted bridge SHA-256: `805cdc05ea9b3805189ba7be4938cb7ede4e7056b9ae9a7e911df96a801d58ee`
- Curriculum status: `NOT_CLOSED_PENDING_OWNER_RETEST`

## Accepted scope

Task 0017RC changes only reusable Gameplay Help presentation, focused tests/capture harnesses, aggregate registration, the implementation report, and authorized current documentation. Formal level data, catalog data, Simulation, solver, Timeline, AppRoot, Level Select, scenes, project settings, persistence, build, export, and release surfaces remain unchanged.

The contextual section is manual, modal, static, zero-turn, and non-route:

```text
SPACING · Closed DOOR/wall BLOCKS one ECHO while another MOVES, changing spacing.
EXPERIMENT · Compare MOVED/BLOCKED; try another route or loop.
A+B · Two ECHOS hold separate Plates; YOU stays free to cross. Only YOU completes.
```

It does not disclose inputs, coordinates, turns, target spacing, next action, exact E2/A–E4/B assignment, branch selection, solver output, remaining distance, or state evaluation.

## Trigger acceptance

The bridge-specific section is selected only from validated level facts:

- `metadata.intended_mechanics` contains `echo_spacing_change`;
- at least two ECHOs exist;
- exactly two distinct Plates occupy distinct cells;
- at least one Door depends on both Plate IDs.

The trigger does not inspect level ID, title, coordinates, current turn, actor positions, history, completion progress, witness data, or solver state. Tests establish true for `echo_spacing_bridge` and false for byte-identical `two_echo_convergence`, zero/single-ECHO rooms, missing spacing metadata, incorrect Plate cardinality/placement, and non-A+B dependencies.

## State and presentation acceptance

Opening and closing Help preserve the full runtime state, canonical key, turn index, positions, Door states, history, completion, disclosure state, and Timeline snapshot. The copy remains identical before play and after the real bridge spacing-change transition. Help does not open automatically or persist after closing.

At 960×540 the contextual body fits within the existing Help area at the bridge-only 16 px treatment. Non-target Help remains 18 px. Nine native Compatibility captures establish readable closed/open Help, post-divergence Help, non-target isolation, grayscale, reduced motion, and sequence-8 Level Select reachability.

## Validation acceptance

Focused validation passes 28 assertions. Aggregate validation passes 578 assertions / 9 vectors with all thirteen markers exactly once, including:

```text
TASK_0017RC_BRIDGE_CONTEXTUAL_HELP_REPAIR_TESTS_PASS
```

Native exit is 0. Stderr contains only the accepted intentional `LEVEL_ID_MISMATCH` diagnostic. All eight formal hashes, bridge metrics, catalog hash, progression, Task 0017P scrollability, and prior markers remain exact. No generated-file cleanup was required.

## Boundary

This acceptance establishes only machine correctness and presentation containment. It does not prove that the Help would have prevented the owner's original give-up, reduced first-attempt difficulty, closed the curriculum P2, established fresh/independent review, accepted the bridge difficulty curve, authorized finale planning, or establish production/export/release/submission readiness.

The owner has prior bridge completion and route exposure. A separately authorized owner-only retest must therefore evaluate Help notice, causal comprehension, credible experiment formation, two-ECHO/free-YOU role understanding, route-disclosure risk, and Timeline independence. Completion time and restarts are contextual only and cannot be treated as first-discovery evidence.
