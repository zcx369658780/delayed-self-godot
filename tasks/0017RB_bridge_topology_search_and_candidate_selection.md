# Task 0017RB — Bounded bridge topology search and candidate selection

- Status: `READY`
- Gate: `EXTERNAL TOPOLOGY SEARCH / STRICT-GATE CANDIDATE SELECTION`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Parent blocked implementation: `tasks/0017R_bridge_curriculum_geometry_and_help_repair.md`
- Equal-delay adjudication: `docs/level_design/BRIDGE_EQUAL_DELAY_GATE_ADJUDICATION_CURRENT.md`
- GPT acceptance: `docs/reports/0017RA_GPT_EQUAL_DELAY_GATE_ACCEPTANCE.md`
- Current accepted bridge SHA-256: `805cdc05ea9b3805189ba7be4938cb7ede4e7056b9ae9a7e911df96a801d58ee`

## 1. Objective

Run one larger but still bounded external topology search and select at most one replacement candidate for:

```text
echo_spacing_bridge / Diverging Echoes / 错位回声
```

The task is diagnostic and candidate-selection only. It must not write a formal level, modify Gameplay Help, edit tests, migrate the catalog, conduct owner review, or begin `signal_convergence`.

The selected candidate, if one exists, must satisfy both the retained strict proxy controls and the complete direct curriculum gates. No hard gate may be weakened.

## 2. Startup and continuity

Before external diagnostics:

- verify root exactly `D:\Delayed_Self`, branch `main`, SSH/expected origin, and accepted Godot 4.7 toolchain;
- require a clean tracked and untracked worktree;
- fetch and fast-forward only with `git fetch origin` and `git merge --ff-only origin/main` when needed;
- require local `HEAD == origin/main` and presence of `86cff672fde4c89625a61e90a5bb19bcea6f3b30` plus this task;
- require no residual Godot process.

Stop on divergence, unexpected files, wrong root/remote, or materially different toolchain.

Intermediate progress messages are not terminal outcomes. Continue the same execution until a task terminal verdict is reached unless an explicit stop condition occurs.

## 3. Required reads

Read `AGENTS.md`, current startup/task documents, this task, Task 0017RA and its adjudication/report/GPT acceptance, the preserved Task 0017R blocker report, Task 0017R and Task 0017D, Task 0017V owner evidence, Task 0017C validation, the current accepted bridge, `two_echo_convergence`, `simulation_v1`, schema/catalog/progression contracts, solver helpers, presentation/Help direction, capture rules, and generated-file safety rules.

Inspect and preserve the external evidence roots from Tasks 0017R and 0017RA. Do not overwrite their artifacts.

## 4. Frozen product and lesson contract

Every candidate must retain:

- schema v1;
- `level_id = echo_spacing_bridge` and title `Diverging Echoes`;
- one YOU;
- exactly two shared-spawn ECHOs with delays 2 and 4;
- exactly two distinct Plates A/B;
- exactly one initially closed A+B Door;
- exactly one player-only EXIT beyond the Door;
- board no larger than 8×7;
- required real spacing-changing mixed `BLOCKED/MOVED` transition before the final staging chain;
- fixed shortest-solution roles E2 on A and E4 on B;
- YOU free/staged for the following open-snapshot Door crossing;
- both-ECHO necessity and YOU-substitution exclusion;
- no literal WAIT requirement, repeated blocked-input macro, corridor padding, or route-specific presentation.

Do not introduce a new mechanic, second Door, third Plate, new level, catalog change, schema/runtime/solver change, actor collision, persistent Door, Gate, latch, box, key, timer, hazard, exact walkthrough, target spacing, next-action hint, or always-on line.

The contextual Help bundle remains accepted in principle but is not implemented in this task.

## 5. Bounded search budget

Use deterministic external generation and staged filtering. Record every generated candidate ID and disposition.

### Stage A — cheap structural generation

Generate at most 512 raw candidates across these families:

1. baseline-derived candidates with two to five terrain-cell changes and at most one Plate relocation;
2. compact fork/rejoin templates with 10–18 traversable cells, one Door articulation, separated Plate pockets, and a visible lower staging/recovery lane;
3. rotated/reflected Door–EXIT orientations with re-authored Plate pockets and blocker cells.

Cheaply reject invalid schema, disconnected spawn/Plate regions, missing Door articulation, Plate-to-Door terrain distance <=1, excessive floor area, obvious player-only bypass, or duplicate canonical geometry.

### Stage B — normal solver screening

Run the tracked solver on at most 32 structurally distinct survivors. Require:

```text
11 <= L* <= 14
4 <= N* <= 64
N* status = EXACT
1000 <= visited_states <= 12000
100 <= maximum_frontier <= 2500
```

Reject resource-limit outcomes and candidates whose shortest witnesses require WAIT or padding.

### Stage C — strict controls

Run the full strict control set on at most 10 Stage-B survivors. Require complete finite-state unsolved without limits for:

- no ECHO;
- E2 only;
- E4 only;
- equal delays 2/2;
- equal delays 4/4.

Also screen A-only, B-only, Door removal, Plate relocation, blocker relocation, overlap, articulation/bypass, ECHO-on-EXIT, YOU-on-EXIT, restart, and witness replay.

### Stage D — complete augmented curriculum proof

Run complete augmented finite-state searches on at most four Stage-C survivors. Require all of the following complete-negative results:

1. no completion exists without a true post-activation mixed `BLOCKED/MOVED` spacing-change event;
2. no completion exists without reaching E2 on A, E4 on B, A+B open, and YOU free/staged for the following open-snapshot Door entry;
3. no completed route uses YOU substitution on either Plate at the useful A+B result;
4. no completion reverses the fixed E2/A and E4/B roles.

The augmented search must classify reachable completed states, not only shortest solutions. Resource limits invalidate the candidate.

## 6. Curriculum and recovery ranking

A surviving candidate must also provide:

- 2–3 meaningful decisions;
- at least three recoverable non-optimal alternatives, each with an exact bounded recovery or a short visible return route;
- no known nonterminal overshoot pocket requiring restart as the only recovery;
- a required divergence that occurs before the two-Plate staging loop and is legible through existing board geometry and Task 0015R feedback;
- materially less burden than the accepted bridge and shifted `two_echo_convergence`;
- compatibility with the accepted non-route contextual Help semantics and 960×540/grayscale presentation.

Rank complete survivors in this order:

1. all hard gates pass;
2. fewer augmented visited states and fewer misleading branches;
3. lower normal visited/frontier within the accepted band;
4. earlier legible divergence and shorter recovery penalties;
5. simpler terrain and fewer visually ambiguous pockets;
6. higher exact N* only as a final tie-breaker within the allowed band.

Select exactly one best candidate or none. Do not average candidates or silently relax a condition.

## 7. External evidence

Use a new subdirectory:

```text
D:\Delayed_Self_Evidence\0017RB_bridge_topology_search\
```

Record:

- generator/search scripts and hashes;
- deterministic seeds and candidate canonical definitions;
- Stage A–D ledgers;
- solver limits, outputs, exits, and stderr;
- complete control and augmented-state definitions;
- selected candidate canonical JSON outside Git;
- rejected near-candidate comparison;
- evidence index with SHA-256.

No external artifact enters Git.

## 8. Repository outputs

Create only:

```text
docs/level_design/BRIDGE_REPAIR_TOPOLOGY_CANDIDATE_CURRENT.md
docs/reports/0017RB_BRIDGE_TOPOLOGY_SEARCH_REPORT.md
```

Update only the minimum CURRENT navigation, handoff, plan, index, and project-memory Markdown files required to point to the result.

The candidate document must include, when selected:

- exact terrain and entity table;
- canonical external candidate ID and SHA-256;
- normal metrics and one witness for later replay only;
- strict-control results;
- complete augmented curriculum-class results;
- decisions/recoveries;
- comparison with the accepted bridge and rejected `[5,4]`-closed near candidate;
- the exact surfaces a later implementation task would be authorized to change.

Do not modify `data/`, `scripts/`, `tests/`, `schemas/`, `scenes/`, project settings, catalog, prior tasks/reports/acceptances, assets, persistence, build, export, or release paths.

## 9. Stop conditions

Return a blocked terminal verdict without product changes if:

- no candidate survives every Stage-D gate;
- the bounded budget is exhausted;
- a required negative result is resource-limited;
- the only survivor needs forbidden scope or route-style Help;
- evidence cannot distinguish a survivor from the rejected YOU-substitution candidate;
- an unexpected repository path changes.

Do not broaden the search budget, weaken a metric/control/curriculum gate, or switch to Help-only policy without a new GPT task.

## 10. Git discipline and terminal verdict

Stage explicit authorized Markdown files only. Require `git diff --check` and cached checks. Commit exactly once:

```text
docs: select Delayed Self bridge repair topology
```

Fetch and stop on remote drift before normal push. Require a clean tracked/untracked worktree and `HEAD == origin/main`.

Return exactly one terminal verdict:

```text
BRIDGE_REPAIR_TOPOLOGY_CANDIDATE_READY_FOR_GPT_REVIEW
BLOCKED_NO_BOUNDED_STRICT_GATE_CANDIDATE
```

Include commit SHA, raw/screened/proven candidate counts, selected candidate ID or blocker reason, metrics, strict controls, augmented curriculum results, evidence paths, output documents, and final Git state.

This task does not implement a formal replacement, modify Help, conduct owner retest, authorize finale planning, or establish export/release/submission readiness.
