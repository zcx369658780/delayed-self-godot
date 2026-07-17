# Task 0016 GPT finale-sequence plan adjudication

- Date: 2026-07-18
- Repository: `zcx369658780/delayed-self-godot`
- Branch: `main`
- Planning commit reviewed: `264989088089fcab4d2f2989bafca65a780ffc73`
- Parent task: `tasks/0016_level_8_finale_and_difficulty_bridge_planning.md`
- Plan: `docs/level_design/LEVEL_8_FINALE_AND_DIFFICULTY_BRIDGE_PLAN_CURRENT.md`
- Verdict: `TASK_0016_PLAN_REQUEST_CHANGES_SCHEMA_V1_NECESSITY_CONTRADICTION`

## 1. Scope and repository audit

The reviewed changeset is one documentation-only commit after the Task 0016 publication point. It creates the planning document and execution report and updates only authorized current Markdown sources. It does not modify formal level JSON, catalog data, runtime, solver, schema, tests, scenes, project settings, assets, or release surfaces.

The following strategic decisions are accepted in principle:

- insert a mandatory bridge before the accepted `two_echo_convergence` challenge;
- preserve all existing formal level files byte-for-byte;
- migrate only catalog sequence/prerequisite metadata during a later authorized implementation;
- preserve `signal_convergence` as a later sequence-9 finale concept;
- use `LABEL_SHAPE_PIP_PRIMARY_NO_NEW_LINES`;
- keep Timeline optional and Help non-route;
- do not introduce Gate, push boxes, persistent Doors, or other new mechanics in this bridge gate.

These accepted directions do not authorize implementation because the exact bridge entity contract below is mechanically inconsistent.

## 2. Blocking contract contradiction

Task 0016 freezes all of the following for `echo_spacing_bridge`:

```text
exactly two ECHOs: delay 2 and delay 4
exactly one Plate
exactly one single-Plate Door
one player-only EXIT
one unavoidable Door articulation
both ECHOs individually necessary
E2-only and E4-only controls each complete-unsolved
```

Under accepted `simulation_v1`:

1. each actor resolves independently from the shared history;
2. actors never block or otherwise affect one another;
3. a Plate is pressed if YOU or any one ECHO occupies its cell;
4. a one-Plate Door is open whenever that one Plate is pressed;
5. presentation state cannot affect the simulation.

For any successful crossing of the only Door, at most one actor needs to occupy the only Plate cell. If E2 occupies the Plate at the critical crossing, removing E4 leaves YOU, E2, history, Plate occupancy, Door state, and completion behavior unchanged under the same input sequence. The E2-only control therefore inherits a solution. The symmetric argument applies when E4 is the holder.

The articulation condition strengthens the contradiction: removing the Door cell separates YOU's start component from the EXIT component. Once YOU crosses the one articulation into the EXIT component, no second mechanic exists that can require a return crossing. A shortest successful route therefore needs only one Plate-held crossing window. The second ECHO cannot become mechanically necessary through actor collision, pushing, or occupancy interaction because all such interactions are absent and overlap is legal.

Therefore both of these cannot simultaneously be true:

```text
one Plate + one Door
both single-ECHO controls complete-unsolved
```

A second ECHO may remain visually present and make spacing changes observable, but that is observational/presentational necessity, not puzzle necessity. A bridge solvable after removing one ECHO would not force the intended two-ECHO spacing lesson and would fail the plan's own teaching and proof gate.

## 3. Decision

The high-level sequence decision is provisionally retained:

```text
INSERT_BRIDGE_BEFORE_CURRENT_LEVEL_7
```

The exact next target is not accepted for implementation. In particular, the following contract is withdrawn pending revision:

```text
exactly one Plate
exactly one Door
both ECHOs individually necessary
```

No formal bridge JSON, catalog migration, test, capture, presentation change, or Level 8/finale implementation is authorized.

The correction must select a schema-v1 grammar in which both ECHOs can be causally and mechanically necessary, while remaining materially simpler than `two_echo_convergence` and preserving the later finale role.

## 4. Required correction direction

A bounded revision must compare at least:

1. **Simplified two-Plate AND tutorial** — two ECHOs, two Plates, one A+B Door, but with an early obvious blocker-derived divergence, lower search burden, fewer decisions, and simpler recovery than current `two_echo_convergence`.
2. **Dual single-dependency windows** — two ECHOs, two Plates, and two single-dependency Door windows, with each delay role individually necessary; reject if it repeats Level 6 or consumes the future finale's multi-stage role.
3. **One-Plate multi-window structure** — one Plate with more than one required Door crossing/window is eligible only if a contract-level argument shows how both E2-only and E4-only controls can be complete-unsolved without new mechanics. Otherwise reject it explicitly.

The revision must also evaluate and reject the tempting but invalid fallback:

```text
two ECHOs present, only one ECHO mechanically necessary
```

The selected target must include a short necessity lemma before implementation: identify the exact distinct causal obligation assigned to E2 and E4 and explain why removing either actor destroys the intended solution under `simulation_v1`.

## 5. Claim boundary and next gate

Task 0016 is not GPT accepted as an implementation-ready plan. It is accepted only as evidence supporting a mandatory bridge and later finale sequence.

Current accepted facts remain unchanged:

- seven formal levels;
- `two_echo_convergence` byte-identical at its current catalog position until a later implementation task;
- Level 7 exact metrics and SHA-256 unchanged;
- Task 0015R presentation repair accepted;
- Task 0015RV closes only the owner false-unsolvable blocker;
- residual difficulty-ramp, Help, Timeline, and dotted-path P2 findings remain planning inputs;
- fresh/independent evidence remains unavailable by owner constraint.

Next gate: one documentation-only mechanical-necessity revision task. Implementation remains blocked until GPT accepts the revised target.
