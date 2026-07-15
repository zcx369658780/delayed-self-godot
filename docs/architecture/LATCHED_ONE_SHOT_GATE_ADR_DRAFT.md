# Latched / one-shot Gate ADR draft

- Status: `DRAFT_NOT_ACCEPTED`
- Date: 2026-07-16
- Decision owner: GPT Project Sources advisor, with owner product input
- Current authority: `simulation_v1` and `level_v1` support combinational Plate Doors only.
- Non-effect: this draft changes no contract, schema, state, canonical key, level, solver, runtime, or catalog.

## Context

The owner proposed preserving the current combinational Door while evaluating a distinct obstacle that stays open or disappears after activation. The proposal could add useful “past action permanently changes the route” puzzles, but it introduces future-relevant memory and may be confused with the accepted Door unless its rule and visual language are clearly separate.

The project first needs presentation recovery and stronger schema-v1 levels. A new mechanic is valuable only if it supports at least two non-duplicative levels and remains deterministic, explainable, and machine-validatable.

## Decision

**Defer pending an isolated contract/prototype branch.** Do not add a Gate to Levels 6–8 or modify existing Doors. Reconsider only after viewport/Door feedback recovery and at least one multi-delay schema-v1 level demonstrates whether permanent topology change is still needed.

If GPT later authorizes research, prefer a **latched Gate that becomes permanently open after all declared trigger Plates are pressed in one committed result**. It preserves a visible frame and audit trail, is easier to explain and restart than disappearance, and does not require an `INTERACT` action. This preference is not acceptance.

## Shared naming and visual boundary

- **DOOR**: live combinational barrier; open iff all referenced Plates are currently pressed; red/green-independent framed aperture with live dependency pips.
- **GATE**: persistent barrier; once triggered, remains open for the rest of the attempt; gold/white sealed bars with a latch/broken-chain icon and persistent “latched” mark.
- Never recolor one sprite to represent both rules.
- Tutorial copy must name the exception once; later state remains visible without prose.

## Option 1 — no new Gate

| Concern | Analysis |
|---|---|
| Player rule | all barriers remain combinational Doors |
| Schema/state/key | no change |
| Transition/restart/replay | no change |
| Solver | no new state dimension |
| Compatibility/migration | exact; none |
| Validation | existing vectors and level evidence remain sufficient |
| Content value | forces designers to deepen timing, multi-delay, and AND combinations first |
| Risk | some desired irreversible-route puzzles are unavailable; content may feel mechanically narrow |
| Door confusion | none |

This is the active accepted behavior.

## Option 2 — latched Gate

### Player rule

When all Gate trigger conditions are satisfied in a committed result, the Gate becomes latched open. It remains open even after actors leave the Plates. Entry uses the start-of-turn Gate snapshot, matching the Door timing boundary.

### Candidate representation

Requires a future schema/contract version, not a silent `level_v1` field:

```text
gates[]:
  id
  position
  all_plate_ids[]
  initial_latched_open
```

Runtime state needs `gate_states[{id, latched_open}]`, sorted by ID. `latched_open` is future-relevant and must enter the canonical key. Initial values must be validated against an explicit policy; safest default is `false` with any initial-open case separately justified.

### Transition order

1. capture Door and Gate start snapshots;
2. resolve simultaneous actor movement against both snapshots;
3. evaluate Plates;
4. recompute combinational Doors;
5. set each Gate `next_latched_open = current_latched_open OR all_triggers_pressed`;
6. evaluate player EXIT, history, and turn as specified by the accepted contract.

Newly latched state affects entry on the next submitted turn. Animation cannot latch it.

### Consequences

- Restart reconstructs the declared initial latch state; replay reproduces every latch transition.
- Solver state grows by up to `2^G` combinations for G independent Gates, though monotonic false→true state limits practical cycles.
- Backward compatibility can be clean only through a new schema version or explicit optional-family contract; existing levels migrate **none** and contain no Gates.
- Required vectors: trigger this turn/enter next, stay open after release, restart reset, already-open start, actor on closing-equivalent cell, multiple Gates, malformed references, canonical-key distinction, replay parity, ECHO-on-EXIT.
- Content value: staged routes, irreversible progress, shorter second traversal, delayed cause with persistent effect.
- Confusion risk: high unless the permanent latch icon and name are explicit.

## Option 3 — one-shot disappearing Gate

| Concern | Analysis |
|---|---|
| Player rule | first valid activation permanently removes collision and visual obstruction for the attempt |
| Schema | Gate definition similar to Option 2, with `removed`/`consumed` state |
| Runtime/key | `removed` is future-relevant and enters canonical key |
| Transition | trigger after movement; removal affects next-turn entry unless a new ordering is explicitly accepted |
| Restart/replay | restart restores barrier; replay reproduces removal |
| Solver | monotonic binary dimension per Gate, similar to latch |
| Compatibility | new schema/contract; no existing-level migration |
| Validation | all latch vectors plus render/collision consistency when the node disappears |
| Content value | strong irreversible “break seal” beat and uncluttered open route |
| Risks | disappearance can look like a rendering bug, removes state visibility, and weakens environmental continuity |
| Door confusion | somewhat lower after disappearance, but activation rule is still easily confused before it fires |

This option is not preferred because a persistent frame communicates state and provenance better.

## Option 4 — environmental switch controlling a persistent Gate

This is materially distinct only if the switch has its own activation semantics rather than being a renamed Plate.

| Concern | Analysis |
|---|---|
| Player rule | step on or interact with a switch to set/toggle a persistent Gate |
| Schema | switch entities, Gate references, mode (`SET_OPEN` or toggle), and possibly a new action |
| Runtime/key | switch/Gate state enters key; toggle creates reversible cycles |
| Transition | must define movement-versus-interaction order, simultaneous activation, repeated triggers, and conflicts |
| Restart/replay | reconstruct all states; replay includes any new action exactly |
| Solver | larger branching and state space; `INTERACT` would change the action set and every history/ECHO rule |
| Compatibility | highest migration and validation burden |
| Content value | manual routing and persistent world changes |
| Risks | scope explosion across schema, inputs, history, HUD, solver, tutorials, save/replay, and assets |
| Door confusion | lower visually if a lever/console is unique; higher rule burden overall |

Reject this option for the current candidate schedule. A walk-on “set open” switch is functionally close to Option 2; an interact/toggle switch is a separate mechanic family.

## Comparison

| Option | New mutable state | Approximate solver impact | Teaching cost | Content gain | Recommendation |
|---|---:|---:|---:|---:|---|
| no Gate | none | none | none | low–medium | active baseline |
| latched Gate | one monotonic bit/Gate | bounded `2^G`, often less reachable | medium | medium–high | defer, preferred prototype if later justified |
| disappearing Gate | one monotonic bit/Gate | similar to latch | medium | medium | defer/reject behind latch |
| persistent switch Gate | one or more bits plus possible action | highest | high | high but broad | reject for candidate scope |

## Validation and evidence required before adoption

1. GPT accepts this or a successor ADR and freezes an exact player rule.
2. A new contract/schema task names the versioning and backward-compatibility strategy.
3. Normative vectors cover state, ordering, canonical keys, errors, restart, replay, and multi-entity cases.
4. Runtime and solver implement one shared transition and retain every v1 metric/hash.
5. One isolated prototype level proves the Gate necessary; a Door-only controlled variant cannot reproduce its intended reasoning.
6. Automated shortcut and state-space evidence is recorded.
7. Owner review distinguishes DOOR from GATE without a route hint.
8. Qualifying fresh review precedes candidate-content use.

## Future task sequence if research is authorized

```text
contract/ADR acceptance
→ schema and simulation vectors
→ runtime/solver parity implementation
→ isolated prototype level and controlled variants
→ owner rule-language review
→ fresh human review
→ separate decision on candidate-content use
```

Each arrow is a stop gate. No task may combine contract invention, content multiplication, and candidate acceptance.

## Consequences of the draft recommendation

- Levels 6–8 remain schema-v1 and use only accepted combinational Doors.
- Presentation work can establish a strong Door visual language before a contrasting Gate is attempted.
- The owner proposal remains preserved, not silently rejected.
- Schedule and validation capacity stay focused on known P2 findings.
- This document remains `DRAFT_NOT_ACCEPTED`; no implementation may cite it as authority.
