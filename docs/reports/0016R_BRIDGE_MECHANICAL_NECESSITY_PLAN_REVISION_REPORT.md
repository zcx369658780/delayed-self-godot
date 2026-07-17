# Task 0016R bridge mechanical-necessity plan revision report

- Task: `tasks/0016R_bridge_mechanical_necessity_plan_revision.md`
- Repository: `zcx369658780/delayed-self-godot`
- Root/branch: `D:\Delayed_Self` / `main`
- Start `HEAD == origin/main`: `22073e48855123eaefe95865e957f34c02f30fda`
- Parent planning commit: `264989088089fcab4d2f2989bafca65a780ffc73`
- GPT adjudication: `TASK_0016_PLAN_REQUEST_CHANGES_SCHEMA_V1_NECESSITY_CONTRADICTION`
- Scope: documentation-only mechanical-feasibility correction

## Startup and evidence

The named task was initially absent from the clean local checkout. A proxy-scoped `git fetch origin` showed local `main` was behind by exactly two commits with no local-only commit. `git merge --ff-only origin/main` advanced to `22073e48855123eaefe95865e957f34c02f30fda`, adding the GPT adjudication and Task 0016R. No persistent Git configuration changed.

The required startup chain, Task 0016R, GPT adjudication, parent plan/report, simulation/schema/catalog contracts, machine schema, tracked seven-entry catalog, all seven formal JSON files, Task 0012 and Task 0015 necessity evidence, Task 0015D diagnostic/plan, Task 0015RV owner review/acceptance, and current difficulty/presentation/development/handoff/index/memory documents were read.

No Godot process, editor, solver, Simulation script, test, capture, import, build, or export command was run.

## Contradiction and accepted GPT reasoning

The withdrawn Task 0016 contract combined:

```text
two ECHOs d=2/d=4
one Plate
one single-dependency Door
both ECHOs individually necessary
```

Under `simulation_v1`, actors move independently, do not collide, may overlap, and any actor can press the only Plate. The only Door crossing needs at most one Plate holder. If E2 is the successful holder, removing E4 preserves the same Plate/Door crossing; the symmetric argument applies to E4. An additional ECHO may improve observation but is not mechanically necessary.

The high-level sequence direction remains provisionally accepted:

```text
INSERT_BRIDGE_BEFORE_CURRENT_LEVEL_7
```

## Candidate feasibility lemmas

### A — simplified two-Plate AND tutorial

Entity grammar:

```text
two shared-spawn ECHOs d=2/d=4
two distinct Plates A/B
one A+B Door
one player-only EXIT
```

E2 must occupy A and E4 must occupy B in the required committed result while YOU waits in the Door-approach lane. Both Plates are at least two traversable moves from the Door, so YOU cannot leave a substituted Plate and enter the Door during the single open start snapshot. One remaining ECHO cannot occupy two cells, and overlap presses only one Plate. Removing either ECHO therefore leaves too few independent bodies to hold A+B while YOU crosses.

This candidate is mechanically credible and remains subject to exact complete-state controls.

### B — dual single-dependency windows

Entity grammar:

```text
two shared-spawn ECHOs d=2/d=4
two distinct Plates
two distinct single-dependency Doors
one player-only EXIT
```

E2 would own the first Door window and E4 a later window after YOU crosses the first articulation. Removing E2 blocks stage one; removing E4 blocks stage two. This is mechanically plausible, but it closely repeats Level 6's staged single-dependency Doors and consumes part of the future finale's multi-stage identity.

### C — one-Plate multi-window

Disposition:

```text
REJECTED_CONTRACT_INFEASIBLE
```

One Plate opens every Door that references it simultaneously. Schema v1 has no actor-specific Plate ownership, consumed window, one-shot, latch, or stage memory. Without a formal layout and complete searches, an asserted early E2 press and later E4 press is only an unproven schedule; the remaining actor or YOU may reuse the same Plate. No rigorous dual-necessity lemma is available at this planning boundary.

### Observational second ECHO

Disposition:

```text
REJECTED_SINGLE_ECHO_SOLUTION_SURVIVES
```

If one ECHO performs the only mechanical opening and the other merely demonstrates spacing, removing the observer leaves the successful sequence intact.

## Weighted comparison and decision

Weights are mechanical feasibility 25%, curriculum continuity 20%, differentiation from current Level 7 15%, finale preservation 15%, observability/recovery 10%, proof/control feasibility 10%, and catalog/presentation risk 5%.

| Candidate | Weighted planning score | Disposition |
|---|---:|---|
| A — simplified two-Plate AND tutorial | 4.63 / 5 | **selected** |
| B — dual single-dependency windows | 3.78 / 5 | viable, not selected |
| C — one-Plate multi-window | not scored | `REJECTED_CONTRACT_INFEASIBLE` |
| observational second ECHO | not scored | rejected |

Unique target:

```text
SIMPLIFIED_TWO_PLATE_AND_TUTORIAL
```

Scores are planning judgments, not measured evidence.

## Revised target

```text
level_id: echo_spacing_bridge
title: Diverging Echoes / 错位回声
sequence role: mandatory bridge at proposed sequence 7
ECHOs: exactly two, shared spawn, delays 2 and 4
Plates: exactly two, A and B
Doors: exactly one, dependency set [A, B]
EXIT: exactly one, player-only
board: at most 8×7
topology: early asymmetric blocker fork, two separated Plate pockets,
          YOU staging lane, one unavoidable Door articulation
```

E2 necessity:

> E2 must occupy A after the early spacing divergence while YOU is staged at the Door; without E2, E4 and YOU cannot hold both separated Plates and still have YOU cross.

E4 necessity:

> E4 must simultaneously occupy B; without E4 the symmetric two-body insufficiency eliminates every A+B crossing.

The Plate-to-Door distance guard prevents YOU substitution, and distinct Plate cells prevent overlap substitution.

## Differentiation and finale preservation

- Level 6 uses one delay-3 ECHO and two sequential single-dependency Door stages; the bridge instead uses one early spacing experiment and one simultaneous A+B result.
- Current Level 7 uses the same broad entity grammar, but remains the larger challenge: 9×7, `L*=19`, 61,975 visited states, frontier 21,449, six decisions, and a longer phase/recovery loop. The bridge targets at most 8×7, 2–3 decisions, earlier divergence, and direct recovery.
- Future `signal_convergence` retains three Plates, two Doors, mixed single/AND dependencies, multi-zone depth, and two-stage synthesis.

## Revised prospective bands

| Measure | Target |
|---|---:|
| `L*` | 13–16 |
| `N*` | 2–32 `EXACT` |
| Visited states | 3,000–25,000 |
| Maximum frontier | 500–5,000 |
| Meaningful decisions | 2–3 |
| Recoverable alternatives | at least 2 |
| Dependency stages | exactly 1 |
| Required event | every shortest solution contains early `BLOCKED/MOVED` divergence |
| A+B window | required E2/E4 simultaneous result, useful for 1–2 turns |
| Owner-only target | 2–5 minutes, 1–3 restarts; target only |

These are unverified implementation targets. Resource-limit results cannot establish exactness or complete unsolvability.

## Future catalog migration

The proposed later order remains:

```text
existing Levels 1–6
→ echo_spacing_bridge
→ byte-identical two_echo_convergence
→ future signal_convergence finale
```

During bridge implementation, `two_echo_convergence` shifts to sequence 8, requires the bridge, and remains sole final. Only the future finale gate may add sequence 9 and transfer sole-final status. No catalog or formal file changed in Task 0016R.

## Future proof/control package

The revised plan requires strict load/catalog/progression, solve/replay/restart/hash and exact metrics; complete no-ECHO/E2-only/E4-only searches; YOU-substitution and overlap controls; all-shortest E2→A/E4→B, divergence, and open-snapshot traces; both Plate isolation/relocation controls; A-only/B-only dependency simplifications; Door removal/articulation/bypass; delay equalization; ECHO/EXIT rules; decision/recovery audits; all seven prior hashes/metrics; reusable Gameplay/AppRoot/direct route/capture/aggregate regression; and an explicit measured-burden comparison with current Level 7.

## Presentation and owner-review policy

The policy remains:

```text
LABEL_SHAPE_PIP_PRIMARY_NO_NEW_LINES
```

Board state and transition feedback are primary. Timeline is optional. Help is contextual, zero-turn, and non-route. Exact walkthroughs are rejected. A/B labels/shapes/pips and E2/E4 badges/outlines remain primary; color is supplementary.

Future review remains authenticated owner only, explicitly not fresh or independent. It must test causal spacing understanding, dual-ECHO necessity, YOU-substitution understanding, recovery, and whether bridge→current Level 7 smooths the difficulty ramp without feeling repetitive.

## Changed paths and protected surfaces

Created:

- `docs/reports/0016R_BRIDGE_MECHANICAL_NECESSITY_PLAN_REVISION_REPORT.md`

Updated only the current plan and minimum current navigation/state documents authorized by Task 0016R.

- `docs/level_design/LEVEL_8_FINALE_AND_DIFFICULTY_BRIDGE_PLAN_CURRENT.md`
- `docs/CODEX_ACTIVE_TASK_CURRENT.md`
- `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`
- `docs/DEVELOPMENT_PLAN_CURRENT.md`
- `docs/DOC_INDEX_CURRENT.md`
- `docs/HANDOFF_MASTER_CURRENT.md`
- `docs/project_memory.md`
- `docs/level_design/INITIAL_LEVEL_ROADMAP_AND_VALIDATION_MATRIX_CURRENT.md`
- `docs/level_design/FIVE_LEVEL_DIFFICULTY_RECOVERY_AND_LEVELS_6_8_PLAN.md`
- `docs/ux/PRESENTATION_VIEWPORT_AND_HUD_DIRECTION_CURRENT.md`

Historical Task 0016 report and GPT adjudication remain unchanged. No formal JSON, catalog, schema, simulation, solver, Gameplay, scene, test, fixture, project setting, Timeline, Help, asset, audio, persistence, build, export, release, or submission surface changed.

## Risks, non-claims, and next gate

Primary risks are similarity to current Level 7, an unintended YOU/single-ECHO substitution, search burden exceeding the bridge role, optional rather than necessary divergence, and owner-only evidence limitations.

This report does not claim the bridge exists, is solvable, meets the target bands, is fun, or has passed necessity controls. It does not authorize implementation or the finale.

After GPT accepts this revision, the next gate is one bounded bridge implementation and complete validation task. Until then, implementation remains blocked.
