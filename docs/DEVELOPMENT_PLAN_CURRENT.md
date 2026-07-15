# Development plan (CURRENT)

The canonical milestone detail remains in the [GDD](game_design/DELAYED_SELF_GAME_DESIGN_DOCUMENT_CURRENT.md). This document records the accepted execution spine and clearly labels future tasks as planning recommendations until separately authorized.

## Near-term gates

```text
0000 governance bootstrap
→ 0001 read-only environment and release-target inventory
→ 0002 gameplay simulation contract
→ 0003 minimal vertical slice
→ 0004 first-player evidence
→ 0004R focused UX repair
→ 0004V user retest
→ 0005 system skeleton and tutorial planning
→ 0006 app shell/catalog/in-memory progress (GPT accepted)
→ 0007 tutorials/reusable gameplay (GPT accepted)
→ 0008 progressive HUD/owner retest (GPT accepted with observations)
→ 0009A door timing/WAIT batch (stopped cleanly; WAIT research deferred)
→ 0009AR door timing/AND-door replacement batch (implemented, pending GPT review)
```

Task 0001 inventories installed Godot/export tooling and evaluates Windows/Web targets without upgrades or downloads. Task 0002 freezes deterministic state transition, collision/settlement order, level schema, and solver/runtime contract. Task 0003 implements one minimal validated room and its conformance harness.

Tasks 0000–0008 are GPT accepted with recorded observations. Task 0009A stopped cleanly when strict literal-WAIT relevance was not established; WAIT remains deferred research, not rejected. Task 0009AR implements two validated replacement levels and a five-entry catalog and is pending GPT review. A qualifying fresh/independent review remains mandatory after the current five-level continuous sequence and no later than candidate acceptance.

## Milestone spine

| Milestone | Dates | Outcome |
|---|---|---|
| M0 Rules and repository freeze | 2026-07-14–07-15 | Governance plus read-only environment inventory |
| M1 Minimal vertical slice | 2026-07-16–07-19 | One understandable, validated delayed-echo puzzle |
| M2 System skeleton | 2026-07-20–07-24 | Data-driven levels, core flow, four validated levels |
| M3 Content production | 2026-07-25–07-31 | Eight candidate levels and first coherent presentation |
| M4 Complete flow | 2026-08-01–08-05 | Menu-to-ending flow, settings, save, license page, export |
| M5 Candidate | 2026-08-06–08-10 | P0/P1 closure and independent review candidate |
| M6 Polish and final submission | 2026-08-11–09-06 | Final audit, stable package, separately authorized submission |
| M7 Video | by 2026-09-10 | Gameplay/theme presentation |

If the vertical slice, solver/runtime parity, or complete flow misses the GDD gates, reduce optional levels, languages, controller support, shaders, and extra mechanics before reducing the core delayed-echo loop or complete product flow.
