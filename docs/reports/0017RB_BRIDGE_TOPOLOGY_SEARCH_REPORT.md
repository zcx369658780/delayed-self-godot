# Task 0017RB bridge topology search report

- Status: `BLOCKED_NO_BOUNDED_STRICT_GATE_CANDIDATE`
- Task: `tasks/0017RB_bridge_topology_search_and_candidate_selection.md`
- Start/synchronized baseline: `108c508ff14c0fdf026241629cd649f78ed7ea98`
- Root/branch/origin: `D:\Delayed_Self` / `main` / `git@github.com:zcx369658780/delayed-self-godot.git`
- Toolchain: Godot `4.7.stable.steam.5b4e0cb0f`
- Accepted bridge SHA-256: `805cdc05ea9b3805189ba7be4938cb7ede4e7056b9ae9a7e911df96a801d58ee`
- External evidence: `D:\Delayed_Self_Evidence\0017RB_bridge_topology_search\`

## Outcome

No bounded candidate survived every Stage-D hard gate. The search stopped at the task-defined budget and selected no replacement. No formal level, product source, Help, Timeline, test, schema, catalog, progression, scene, project setting, asset, persistence, build, export, or release path changed.

## Deterministic generation and Stage A

The external generator used sequential integer seeds in generation order and recorded every canonical definition and disposition. It produced 32 raw candidates:

- 24 baseline-derived candidates closing `[5,4]`, opening one additional cell, and optionally relocating at most one Plate;
- four compact fork/rejoin templates;
- four reflected Door/EXIT orientations derived from those templates.

All 32 passed the initial schema, size, spawn/Plate connectivity, Door articulation, Plate-distance, floor-area, bypass, and duplicate checks. The later full-floor connectivity audit rejected two Stage-B survivors whose new floor cells were disconnected unused components; these were not allowed to advance on solver metrics alone.

## Stage B normal solver

The tracked LevelLoader, Simulation, and BFS Solver screened exactly 32 candidates under depth/state/time/count limits `64 / 500,000 / 30,000 ms / 1,000,000`. Six passed the required normal band:

| Candidate | L* | N* | Visited | Frontier | Witness WAIT |
|---|---:|---:|---:|---:|---|
| `baseline_004` | 14 | 7 EXACT | 10,308 | 2,362 | no |
| `baseline_007` | 14 | 7 EXACT | 10,308 | 2,362 | no |
| `baseline_010` | 14 | 7 EXACT | 9,683 | 2,362 | no |
| `baseline_016` | 14 | 7 EXACT | 9,958 | 2,362 | no |
| `baseline_019` | 14 | 7 EXACT | 10,308 | 2,362 | no |
| `baseline_022` | 14 | 7 EXACT | 9,683 | 2,362 | no |

Twenty candidates exhausted complete-unsolved and six solved outside the metric band. No solver result was resource-limited.

## Stage C strict controls

`baseline_010` and `baseline_022` were rejected for disconnected unused floor components. The remaining four reproduced their witnesses, exact restart, Door articulation, distinct Plate cells, and Plate-to-Door distances `2 / 3`.

All five required controls exhausted complete-unsolved:

| Candidate | no ECHO | E2 only | E4 only | equal 2/2 | equal 4/4 |
|---|---:|---:|---:|---:|---:|
| `baseline_016` | 7/1 | 175/45 | 4,375/1,125 | 175/45 | 4,375/1,125 |
| `baseline_004` | 8/2 | 200/65 | 5,000/1,625 | 200/65 | 5,000/1,625 |
| `baseline_007` | 8/2 | 200/60 | 5,000/1,500 | 200/60 | 5,000/1,500 |
| `baseline_019` | 8/2 | 200/65 | 5,000/1,625 | 200/65 | 5,000/1,625 |

Cells show visited/frontier. A-only, B-only, Door removal, Plate relocation, blocker relocation, overlap, articulation, EXIT identity, replay, and restart diagnostics are retained in `stage_cd_results.json`. The strict-survivor count is four.

## Stage D complete augmented proof

The augmented key is the canonical Simulation state plus monotonic flags for:

1. a true mixed `BLOCKED/MOVED` spacing-changing event;
2. E2 on A and E4 on B with A+B open and YOU free adjacent to the Door, immediately followed by entry from that open snapshot;
3. YOU substitution at an A+B-open result;
4. reversed E2/B and E4/A roles at an A+B-open result.

All five accepted actions were expanded until each augmented finite state space was exhausted. No time, depth, or state cutoff was used.

| Candidate | States | Frontier | Completed states | Without spacing | Without crossing | With substitution | With reversed roles |
|---|---:|---:|---:|---|---|---|---|
| `baseline_016` | 644,077 | 39,044 | 1,664 | no | yes | yes | yes |
| `baseline_004` | 716,216 | 47,631 | 1,766 | no | yes | yes | yes |
| `baseline_007` | 736,156 | 43,962 | 1,742 | no | yes | yes | yes |
| `baseline_019` | 914,956 | 56,657 | 1,832 | no | yes | yes | yes |

Every candidate passes only the spacing-event necessity gate. Each fails the complete intended-chain, YOU-substitution, and fixed-role gates. Stage-D survivor count is zero.

## Candidate comparison and ranking disposition

The rejected `[5,4]`-closed near candidate already provided `L*=14`, `N*=7 EXACT`, 9,683 visited, frontier 2,362, and 441,222 augmented states/frontier 31,886. The four proven candidates add a floor cell but retain the same witness length/count and the same direct causal bypass classes while increasing augmented burden.

Because hard-gate survival ranks before recovery/presentation considerations, no candidate proceeds to curriculum/recovery ranking. No meaningful-decision, recovery, 960×540, grayscale, or Help compatibility score can promote a candidate that failed Stage D.

## Evidence and execution

Both external Godot processes exited normally with empty stderr:

```text
stage_ab_search.gd -> stage_ab_results.json
stage_cd_proof.gd -> stage_cd_results.json
```

Candidate definitions, deterministic seeds, complete ledgers, solver outputs, strict controls, augmented definitions/results, comparison, hashes, and the no-selection disposition are indexed by:

```text
D:\Delayed_Self_Evidence\0017RB_bridge_topology_search\EVIDENCE_INDEX.md
```

Nothing under the external evidence root enters Git. Prior Task 0017R and 0017RA evidence roots were inspected and left unchanged.

## Stop condition and required next authority

The task requires `BLOCKED_NO_BOUNDED_STRICT_GATE_CANDIDATE` when no candidate survives every Stage-D gate. The search budget was not expanded, no hard gate was weakened, and no Help-only policy was substituted.

A fresh GPT task must choose any next design direction. This task does not authorize a new search budget, formal replacement, Gameplay Help implementation, owner retest, finale planning, production, export, release, or submission.
