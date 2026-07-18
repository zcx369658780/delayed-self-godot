# Bridge equal-delay gate adjudication (CURRENT)

- Status: `STRICT_EQUAL_DELAY_GATE_RETAINED`
- Task: `tasks/0017RA_equal_delay_control_gate_adjudication.md`
- Selected policy: `A — PRESERVE STRICT GATE`
- Near candidate: `DIAGNOSTIC_ONLY_NOT_FORMAL`
- Product change: none

## Decision

The strict requirement remains:

```text
equal-delay 2/2 = UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE
equal-delay 4/4 = UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE
```

The `[5,4]`-closed near candidate remains rejected. Although it meets the prospective metric band and every completion requires a real spacing-changing `BLOCKED/MOVED` event, complete augmented search found completed states that bypass the intended YOU-free entry chain and found YOU substitution in every completed class.

Policy B is unavailable because its three direct curriculum gates did not all pass. Policy C is unavailable because the evidence does not show geometry simplification itself to be fundamentally incompatible with the lesson; it shows that this particular near candidate is invalid.

## Formal invariant

For shared-spawn equal-delay ECHOs:

1. equal delay selects the same history index and therefore the same action each turn;
2. both start each transition at the same cell;
3. both resolve through the same deterministic `_destination` function against the same start-of-turn closed-Door snapshot;
4. therefore both settle at the same cell and remain overlapped by induction.

One occupied cell cannot press two distinct Plate cells. Equal-delay ECHOs cannot realize the separated E2-on-A/E4-on-B role chain. Any equal-delay solution to a two-Plate A+B room would require YOU on at least one Plate at the useful open result.

The runtime diagnostic observed the overlap invariant over the complete reachable state spaces. For the normalized near-candidate controls, both equal-delay variants were fully unsolved:

| Control | Status | Visited | Frontier |
|---|---|---:|---:|
| 2/2 | complete finite-state unsolved | 175 | 45 |
| 4/4 | complete finite-state unsolved | 4,375 | 1,125 |

## Near-candidate direct gates

The exact candidate changes only terrain cell `[5,4]` from floor to wall. Its solver facts reproduce as `L*=14`, `N*=7 EXACT`, 9,683 visited, frontier 2,362.

Complete augmented reachability explored 441,222 augmented states with maximum frontier 31,886:

- no completion exists without a real spacing-changing mixed `BLOCKED/MOVED` event;
- a completion exists without the intended E2/A–E4/B, YOU-free open-snapshot entry chain;
- completed routes exist with YOU occupying a Plate at an A+B-open result;
- no completed class realizes the intended chain without prior YOU substitution.

Completed augmented classes were `spacing=1 / intended-crossing=0 / substitution=1` (410 unique completed augmented states) and `1 / 1 / 1` (784). These counts classify reachable completed states, not solution-path counts.

## Consequence

Future bridge geometry work may resume only under a fresh task with a larger but still bounded topology search. It must preserve both the strict equal-delay controls and the direct curriculum gates. The current accepted bridge remains byte-identical at SHA-256 `805cdc05ea9b3805189ba7be4938cb7ede4e7056b9ae9a7e911df96a801d58ee`.

Finale planning remains blocked. This adjudication does not authorize implementation, Help changes, owner retest, production, export, release, or submission.
