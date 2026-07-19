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
→ 0009AR door timing/AND-door replacement batch (GPT accepted)
→ 0009AV owner five-level sequence review (GPT accepted with findings)
→ 0010 presentation/difficulty/production recovery planning (GPT accepted)
→ 0011 primitive board/HUD and Door-feedback recovery (GPT accepted)
→ 0011V owner presentation review (GPT accepted; focused repair required)
→ 0011R physical-window fill repair (GPT accepted pending owner retest)
→ 0011RV standalone owner window-fill retest (GPT accepted)
→ 0012 difficult Level 6 `staggered_doors` (GPT accepted at INTERNAL_PLAYABLE)
→ 0012S project-source synchronization and session handoff checkpoint
→ 0013/0013A corrected baseline and owner-only review-path adjudication
→ 0013B authenticated-owner Level 6 review (GPT accepted internal evidence)
→ 0014 Level 7 two-ECHO convergence planning (GPT accepted)
→ 0015 Level 7 `two_echo_convergence` implementation (GPT accepted at INTERNAL_PLAYABLE)
→ 0015V authenticated-owner Level 7 comparison review (GPT adjudicated as blocking P2)
→ 0015D false-unsolvable diagnosis and bounded repair planning (GPT accepted)
→ 0015R transition-derived ECHO divergence feedback repair (GPT accepted)
→ 0015RV owner divergence-feedback retest (closed for GPT review)
→ 0016 Level 8 finale sequence and difficulty-bridge planning (GPT requested mechanical correction)
→ 0016R bridge mechanical-necessity plan revision (ready for GPT review)
→ 0017 bridge implementation stopped on Level Select presentation blocker (GPT accepted stop)
→ 0017P Level Select scrollability prerequisite repair (GPT accepted)
→ 0017C bridge implementation continuation (ready for GPT review)
→ 0017V authenticated-owner bridge sequence review (recommendation B ready for GPT review)
→ 0017D bridge curriculum difficulty and Help repair planning (primary D ready for GPT review)
→ 0017R bridge curriculum geometry/Help repair (stopped on equal-delay/direct-chain candidate failure)
→ 0017RA equal-delay control gate adjudication (policy A ready for GPT review)
→ 0017RB bounded topology search and candidate selection (blocked: no Stage-D survivor)
→ 0017RC byte-identical bridge contextual Help repair (GPT accepted at machine/presentation level)
→ 0017RCV authenticated-owner contextual Help retest (GPT accepted with residual limitations)
→ 0018 `signal_convergence` sequence-9 finale planning (ready for GPT review)
→ 0019 candidate-A implementation search (blocked: no bounded candidate-A)
→ 0019A band reconciliation and fallback-B pilot (blocked at B007 proof limit)
→ 0019B fixed B007 final complete-proof continuation (scope reassessment required)
→ 0020 eight-level finale closure and production-readiness planning (ready for GPT review)
→ 0021 final completion acknowledgment and bounded return (ready for GPT review)
→ 0021V native machine/capture acceptance (ready for GPT review)
→ 0021W owner walkthrough (adjudicated with P3 backlog)
→ 0022 complete-flow / protected-data / production-closure planning (ready for GPT review)
→ 0023 persistent Profile core (blocked and fully rolled back on isolation failure)
→ 0023R standalone Profile test-path isolation gate (ready for GPT review)
→ 0023T pure Profile codec compile gate (ready for GPT review)
→ 0023V Profile-store instance configuration compile gate (ready for GPT review)
→ 0023W configured test-only Profile filesystem store (ready for GPT review)
```

Task 0001 inventories installed Godot/export tooling and evaluates Windows/Web targets without upgrades or downloads. Task 0002 freezes deterministic state transition, collision/settlement order, level schema, and solver/runtime contract. Task 0003 implements one minimal validated room and its conformance harness.

Tasks through Task 0017C have recorded acceptance boundaries. Task 0017V records owner completion and correct eventual mechanism transfer but finds the Level 6→bridge jump unsmoothed, Help/Timeline ineffective, and YOU-substitution reasoning incomplete. Task 0017D selected minimal geometry plus contextual causal Help. Task 0017R stopped without product changes, Task 0017RA retained the strict equal-delay controls, and Task 0017RB exhausted its bounded topology family without a valid replacement. GPT then selected a byte-identical bridge plus contextual causal Help, Task 0017RC machine/capture-validated it, and GPT accepted Task 0017RCV's owner model with disclosed residual clarity/difficulty/policy limitations.

Task 0018 selected structure A for prospective sequence 9
`signal_convergence`. Task 0019 found no candidate-A survivor under the
accepted PLAN_BAND. Task 0019A retained external fallback-B candidate B007
after its exact metrics and strict controls passed, but its augmented proof hit
the 180-second limit. Task 0019B made the final authorized attempt and reached
the unchanged 2,000,000-state ceiling without exhaustion after 668,807 ms.
GPT accepted C1 by retaining sequence 8 as the formal finale and deferring
sequence 9 outside product scope. Task 0020 freezes eight levels, selects a
bounded final-completion overlay plus acknowledgment/return state, inventories
release gaps, and proposes the later gate spine: finale implementation,
machine/capture acceptance, owner-only walkthrough, complete-flow/production
closure, Windows build validation, RC acceptance, and festival packaging.
Task 0021 implements Gate 1 through the existing AppRoot/Gameplay seam:
catalog-marked final completion records once and waits in a deterministic
acknowledgment state; non-final auto-return remains unchanged. Focused 42 and
aggregate 621/9 pass. Task 0021V completed Gate 2 native Compatibility route
and capture acceptance with the frozen baseline intact. Task 0021W then
completed the owner-only walkthrough: P0=0/P1=0/P2=0/P3=3, with later narrative,
Help, and difficulty-transition repair requested. Task 0022 then selects
persistence-first production closure: profile core, menu/confirmation flow,
settings, localization/font/copy, Credits/polish decisions, machine acceptance,
owner walkthrough, and Windows export validation. These remain separate
implementation gates; only planning is complete here.

Task 0023 stopped before retaining product code because its failed path gate
could not prove protection of the real Profile. Task 0023R isolates that
prerequisite: one zero-I/O policy accepts only the exact canonical test path
grammar and a standalone 123-assertion preflight proves 4 positive and 39
negative paths. Task 0023T then separates the type/interface concern into a
zero-I/O pure codec gate: a first-attempt compile smoke and 34 synthetic
assertions prove defaulting, normalization, stable serialization and candidate
progress only. Task 0023V separately resolves the self-type construction
blocker through a zero-I/O external-instance configuration gate. No Profile
filesystem implementation may resume until GPT reviews this gate and issues a
later revised task.

## Milestone spine

| Milestone | Dates | Outcome |
|---|---|---|
| M0 Rules and repository freeze | 2026-07-14–07-15 | Governance plus read-only environment inventory |
| M1 Minimal vertical slice | 2026-07-16–07-19 | One understandable, validated delayed-echo puzzle |
| M2 System skeleton | 2026-07-20–07-24 | Data-driven levels, core flow, four validated levels |
| M3 Content production | 2026-07-25–07-31 | Eight candidate levels and first coherent presentation |
| M4 Complete flow | 2026-08-01–08-05 | Menu-to-ending flow, settings, save, license page, export |
| M5 Candidate | 2026-08-06–08-10 | P0/P1 closure and candidate-evidence adjudication with the owner-only limitation disclosed |
| M6 Polish and final submission | 2026-08-11–09-06 | Final audit, stable package, separately authorized submission |
| M7 Video | by 2026-09-10 | Gameplay/theme presentation |

If the vertical slice, solver/runtime parity, or complete flow misses the GDD gates, reduce optional levels, languages, controller support, shaders, and extra mechanics before reducing the core delayed-echo loop or complete product flow.

The eight-level count is now frozen. Sequence 9, reduced-grammar search, and
additional puzzle rooms are not schedule-recovery options. Protect complete
flow, persistent save/settings, licensing, Windows build evidence, and the
owner-only review boundary before optional controller, Web, visual variants,
or audio breadth.
