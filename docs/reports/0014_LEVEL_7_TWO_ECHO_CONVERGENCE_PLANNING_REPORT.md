# Task 0014 Level 7 two-ECHO convergence planning report

- Terminal verdict: `LEVEL_7_IMPLEMENTATION_PLAN_READY_FOR_GPT_REVIEW`
- Date: 2026-07-17
- Repository: `zcx369658780/delayed-self-godot`
- Branch: `main`
- Start checkpoint: `HEAD == origin/main == f2cf69e59b4201f9aa89ddd1e151d3ae8f223403`
- Prior accepted gate: `TASK_0013B_OWNER_LEVEL_6_REVIEW_ACCEPTED_INTERNAL_EVIDENCE`
- Output plan: [`LEVEL_7_TWO_ECHO_CONVERGENCE_PLAN_CURRENT.md`](../level_design/LEVEL_7_TWO_ECHO_CONVERGENCE_PLAN_CURRENT.md)

Final Git requirement: one documentation-only commit with the authorized message, pushed normally so the final worktree is clean and `HEAD == origin/main`.

## Result

Task 0014 compares three bounded `simulation_v1`/`level_v1` candidates and selects exactly one implementation target:

```text
two_echo_convergence / Two Echo Convergence / 双影汇流
```

Selected structure: two shared-history ECHOs with delays 2 and 4, two Plates, one `A+B` combinational Door, one player-only EXIT, a 9×7 figure-eight/recovery topology, and one required 1–2-turn two-ECHO convergence window. Both ECHOs must be individually necessary, the Door must be an unavoidable articulation, and at least four non-padding decisions must be machine-audited.

## Candidate comparison

- Candidate A, AND convergence: selected for the clearest new two-offset reasoning, strongest necessity controls, readable one-Door dependency, bounded recovery, and preservation of Level 8.
- Candidate B, dual-ECHO staggered windows: rejected because two serial single-dependency Doors too closely repeat Level 6 and consume part of Level 8's staged-Door role.
- Candidate C, bounded three-actor hybrid: rejected because three simultaneous Plate roles raise crowding/brittleness and prematurely spend Level 8's three-Plate escalation.

The comparison considered temporal reasoning, observability, proof feasibility, recovery, sequence role, and production risk. Predicted metrics and sketches remain proposals, not validation evidence.

## Frozen targets

```text
L* = 17–25
N* = 1–8 EXACT
visited_states = 8000–150000
maximum_frontier = 1000–25000
required synchronization window = 1–2 turns
meaningful decisions >= 4
audited recoverable wrong choices >= 3
```

Starting limits are depth 64, states 500,000, time 30,000 ms, and count cap 1,000,000. Limit results remain unverified; complete-unsolved is valid only after finite-state exhaustion.

## Product decisions

Timeline verdict:

```text
TIMELINE_REMOVED_FROM_LEVEL_7_TEACHING_GOAL
```

The accepted compact Timeline may remain optional and contract-derived, but Level 7 must be solvable through board-state reasoning without reverse-counting. No Timeline redesign is a prerequisite or authorized here.

Help verdict:

```text
HELP_CONTEXTUAL_OPTIONAL
```

Help may explain controls and the E2/E4, A/B, `A+B`, and next-turn vocabulary. It cannot reveal routes, movement, or exact timing and cannot compensate for unreadable state.

Dependency legibility requires redundant cues: A/B labels plus distinct shapes for Plates/Door pips, E2/E4 badges plus different outlines for the ECHOs, supplementary color only, readable overlap composition, grayscale survival, and 960×540 verification.

## Proof and review gates

The later implementation proof package covers strict load/catalog, solve/replay/restart, exact metrics/hash, individual ECHO controls, Plate/dependency/relocation controls, equal-delay controls, no-ECHO/single-ECHO/player-only bypasses, overlap, open-snapshot crossing, decision penalties, prior-level hash/metric preservation, progression, reusable Gameplay, capture, and full regression.

The later owner review classification is exactly `AUTHENTICATED_OWNER_NOT_FRESH_NOT_INDEPENDENT_LEVEL_7_REVIEW`. `FRESH_INDEPENDENT_REVIEW_UNAVAILABLE_BY_OWNER_CONSTRAINT` remains durable; no third party may be sought or required unless the owner reverses the decision.

## Repository scope

Created:

- `docs/level_design/LEVEL_7_TWO_ECHO_CONVERGENCE_PLAN_CURRENT.md`
- `docs/reports/0014_LEVEL_7_TWO_ECHO_CONVERGENCE_PLANNING_REPORT.md`

Updated only the necessary current planning, startup, handoff, index, memory, roadmap, and presentation documents authorized by Task 0014.

Updated:

- `docs/CODEX_ACTIVE_TASK_CURRENT.md`
- `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`
- `docs/DEVELOPMENT_PLAN_CURRENT.md`
- `docs/DOC_INDEX_CURRENT.md`
- `docs/HANDOFF_MASTER_CURRENT.md`
- `docs/project_memory.md`
- `docs/level_design/FIVE_LEVEL_DIFFICULTY_RECOVERY_AND_LEVELS_6_8_PLAN.md`
- `docs/level_design/INITIAL_LEVEL_ROADMAP_AND_VALIDATION_MATRIX_CURRENT.md`
- `docs/ux/PRESENTATION_VIEWPORT_AND_HUD_DIRECTION_CURRENT.md`

No formal level, catalog JSON, schema, runtime, solver, source, scene, test, fixture, project setting, asset, font, audio, shader, import, plugin, dependency, user data, evidence, build, export, release, account, or submission surface changed. Godot, the editor, gameplay, imports, and the solver were not run.

## Unresolved risks and next task

Implementation must still prove that legal overlap cannot substitute one actor for both Plates, the shared history produces exact multiplicity inside the frozen band, the 1–2-turn window exists, and E2/E4 overlap remains readable. Any schema/runtime expansion, observability failure, target-band failure, bypass, or Level 8 role collapse stops the implementation attempt.

Recommended next task after GPT acceptance: one bounded Level 7 implementation task for exactly the selected target, seventh catalog progression, focused machine controls/captures, and the required primitive A/B and E2/E4 cues. Level 8, Timeline/Help redesign, assets/audio/narrative, Gate, persistence, export, release, and submission remain separate gates.

This report is not GPT final acceptance and does not authorize implementation.
