# Echo Spacing Bridge validation

- Level: `echo_spacing_bridge / Diverging Echoes / 错位回声`
- Status: `INTERNAL_PLAYABLE / PASS_FOR_GPT_REVIEW`
- Provenance: exact reconstruction of external Task 0017 `candidate_07.json`
- Formal SHA-256: `805cdc05ea9b3805189ba7be4938cb7ede4e7056b9ae9a7e911df96a801d58ee`
- Toolchain: Godot `4.7.stable.steam.5b4e0cb0f`

## Formal and exact result

The schema-v1 board is 8×7. YOU and E2/E4 share spawn `[3,5]`; delays are 2 and 4. Plate A is `[5,3]`, Plate B is `[6,5]`, the initially closed A+B Door is `[6,2]`, and the player-only EXIT is `[6,1]`. Plate-to-Door terrain distances are 2 and 3. Removing the Door cell disconnects YOU from EXIT.

```text
L* = 16
N* = 12 EXACT
visited_states = 19059
maximum_frontier = 3734
limits = depth 64 / states 500000 / time 30000 ms / count 1000000
```

Stable witness:

```text
RIGHT RIGHT RIGHT UP UP UP LEFT RIGHT DOWN DOWN UP LEFT RIGHT UP UP UP
```

All 12 shortest solutions include a pre-convergence `BLOCKED/MOVED` spacing change, E2 on A and E4 on B with YOU staged at `[6,3]`, the A+B open result, and the following input entering Door `[6,2]`. No shortest solution reverses E2/E4 roles.

## Complete controls

| Control | Status | Visited | Frontier |
|---|---:|---:|---:|
| no ECHO | complete unsolved | 8 | 3 |
| E2 only | complete unsolved | 200 | 90 |
| E4 only | complete unsolved | 5,000 | 2,250 |
| equal delays 2/2 | complete unsolved | 200 | 90 |
| equal delays 4/4 | complete unsolved | 5,000 | 2,250 |

A-only solves in 8 turns; B-only in 7; Door removal in 7. Relocating A or B to `[5,4]` solves in 9. The declared blocker relocation retains `L*=16` but changes `N*` from 12 to 5 and visited states from 19,059 to 11,661. These controls establish that the blocker, two offsets, two distinct Plates, and A+B dependency are material.

YOU substitution is excluded by the Plate-to-Door distances and complete single-ECHO searches. Legal overlap on one Plate presses only that Plate. ECHO-on-EXIT remains non-terminal; YOU entering EXIT completes.

## Decisions, catalog, and runtime

Three shortest-path decisions have distinct recoverable alternatives: turn 5 `RIGHT` costs +3, turn 10 `RIGHT` costs +1, and turn 14 `DOWN` costs +4. The witness contains no WAIT and no repeated blocked-input macro.

The catalog has eight contiguous entries. The bridge is sequence 7 after `staggered_doors`; byte-identical `two_echo_convergence` is sequence 8 after the bridge and remains sole final. Reset, ordered unlock, direct launch, completion return, tail focus, and Task 0017P scroll behavior pass.

Existing A/B labels/shapes/pips and E2/E4 badges/outlines are reused. At turn 9, presentation truthfully reports `E2 BLOCKED · E4 MOVED`; the preceding stable-spacing control stays quiet. Timeline is optional and Help remains zero-turn/non-route.

Focused validation passes 61 assertions. Aggregate validation passes 550 assertions / 9 vectors; all prior eleven markers and `TASK_0017_ECHO_SPACING_BRIDGE_TESTS_PASS` appear exactly once. Native stderr contains only intentional `LEVEL_ID_MISMATCH`.

Twelve native 960×540 Compatibility captures cover locked/unlocked progression, initial cues, stable spacing, divergence, recovery, A+B, open-snapshot crossing, shifted Level 7 unlock, tail focus, reduced motion, and grayscale:

```text
D:\Delayed_Self_Evidence\0017_echo_spacing_bridge\continuation_0017C\
```

All seven prior formal hashes and exact solver metrics remain unchanged.
