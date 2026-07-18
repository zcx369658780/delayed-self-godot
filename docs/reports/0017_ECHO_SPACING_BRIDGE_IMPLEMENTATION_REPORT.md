# Task 0017C echo spacing bridge implementation report

- Date: 2026-07-18
- Status: `ECHO_SPACING_BRIDGE_READY_FOR_GPT_REVIEW`
- Start: clean synchronized `main` at `a89283ea24b0b5719ec38bb68b3156e8f881a117`
- Accepted prerequisite: `TASK_0017P_LEVEL_SELECT_SCROLLABILITY_REPAIR_ACCEPTED`
- Required commit: `feat: add Delayed Self echo spacing bridge`

## Candidate provenance and formal result

The external Task 0017 evidence root retained complete canonical `candidate_07.json`. Task 0017C reconstructed it exactly; no re-authoring iteration was consumed. Fresh solver, trace, control, focused, aggregate, and native capture evidence reproduced the authoring facts.

The 8×7 schema-v1 room has shared-spawn E2/E4 delays 2/4, Plate A `[5,3]`, Plate B `[6,5]`, one initially closed A+B Door `[6,2]`, and player-only EXIT `[6,1]`.

```text
SHA-256 = 805cdc05ea9b3805189ba7be4938cb7ede4e7056b9ae9a7e911df96a801d58ee
L* = 16
N* = 12 EXACT
visited_states = 19059
maximum_frontier = 3734
limits = 64 / 500000 / 30000 ms / 1000000
witness = RIGHT RIGHT RIGHT UP UP UP LEFT RIGHT DOWN DOWN UP LEFT RIGHT UP UP UP
```

All 12 shortest paths contain required spacing divergence, E2→A/E4→B committed result, and following-input Door crossing. Reversed-role shortest paths are zero. The selected witness has `E2 BLOCKED · E4 MOVED` at turn 9, A+B at turn 14, Door entry at turn 15, and YOU completion at turn 16.

## Necessity, controls, and recovery

No-ECHO, E2-only, and E4-only exhaust completely unsolved at 8, 200, and 5,000 visited states. Equal-delay 2/2 and 4/4 also exhaust completely unsolved. A-only, B-only, and no-Door solve in 8, 7, and 7 turns; relocating either Plate solves in 9; blocker relocation changes exact structure to `L*=16 / N*=5 / visited=11661`.

Plate-to-Door distances are 2 and 3. Complete single-ECHO searches corroborate YOU-substitution exclusion. One overlapped cell presses at most one Plate. Removing Door disconnects spawn from EXIT. ECHO-on-EXIT does not complete; YOU-on-EXIT does.

Three meaningful decisions have recoverable penalties +3, +1, and +4 at turns 5, 10, and 14. The witness uses no WAIT and no repeated blocked-input macro.

## Catalog, tests, and captures

Entries 1–6 retain their semantic fields. The bridge is non-final sequence 7 after `staggered_doors`; byte-identical `two_echo_convergence` shifts to sequence 8 after the bridge and remains sole final. No `signal_convergence` entry exists. Reset, ordered progression, direct route, completion return, and Task 0017P tail focus/scroll pass without Level Select source changes.

```text
focused: exit 0; 61 assertions
aggregate: exit 0; 550 assertions / 9 vectors
markers: prior 11 plus Task 0017, each exactly once
stderr: intentional LEVEL_ID_MISMATCH only
captures: 12 native 960×540 Compatibility frames
```

Evidence:

```text
D:\Delayed_Self_Evidence\0017_echo_spacing_bridge\continuation_0017C\
```

Manual capture inspection confirms visible locked/unlocked tail entries, fixed Title/Back, no horizontal overflow, readable A/B and E2/E4 cues, truthful divergence, A+B open state, open-snapshot crossing, reduced motion, and grayscale.

## Preservation and scope

The seven previous hashes remain exact:

| Level | SHA-256 |
|---|---|
| `tutorial_reach_exit` | `38e466bb5922f1987a99d79c7527a4a8eab8e6cfdbe76fd8159f80b0a40cf2c4` |
| `tutorial_echo_bridge` | `681d99057c4e6034a490644d75960ff23d8f43bd1b91850f48179b79fc04a3cf` |
| `vertical_slice_delay_3` | `8751da5051fbebaaa5ae7c895d9be9f086e8d8f2e87876a80c379dc06262f1d8` |
| `door_one_turn_late` | `1775cf89ae4a94f65a76dac2b791a31395443de88205d0ed1b6233331dbda577` |
| `two_keys_one_door` | `f4c6791dfc84d17fb450721e654091a2baeb522e55d660a5d73878cd977651cd` |
| `staggered_doors` | `3f14c19b50775e36dd5b52664798381cf1292b0a30b377641c03435f45696bc8` |
| `two_echo_convergence` | `772410d3b8bb807e35472ee2a7d07b703de66e1e0e92ffb4d1ff8433a345d5fd` |

No unintended `project.godot`, UID, cache, import, or evidence file appeared in the repository. No App, Gameplay, Simulation, solver, schema, scene, project setting, existing level, asset, persistence, build, export, or release surface changed.

Product data paths are the new level and catalog. Test paths are the Task 0017 validation/capture, the catalog-count update to the Task 0017P focus test, and aggregate registration. Documentation is limited to authorized validation/report/CURRENT paths. Rollback is the single implementation commit.

## Non-claims

This is `INTERNAL_PLAYABLE / PASS_FOR_GPT_REVIEW`, not GPT acceptance, owner acceptance, fresh/independent review, balance/fun acceptance, finale implementation, candidate readiness, export, release, or submission readiness.
