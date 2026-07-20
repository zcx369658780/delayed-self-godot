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
→ 0023X pure Profile-to-MemoryProgress adapter (ready for GPT review)
→ 0023Y/0023Z/0023ZA/0023ZB AppRoot fixture-session attempts (closed without accepted implementation)
→ 0023ZC AppRoot orchestration compile/architecture gate (ready for GPT review)
→ 0023ZD complete AppRoot Profile-session harness construction and zero-I/O qualification (ready for GPT review)
→ 0023ZE full-matrix execution (controlled abort at Tutorial-0 compound persistence assertion)
→ 0023ZF Tutorial-0 persistence subcondition diagnostic (expected bounded contract observed; ready for GPT review)
→ 0023ZG harness unlocked-order repair and 0023ZH retargeting (ready for GPT review)
→ 0023ZH repaired full-matrix execution (blocked: cleanup assertion and 9/17 runner evidence)
→ 0023ZI/0023ZK incomplete/circular continuation attempts (closed without commit)
→ 0023ZL cleanup assertion and capture-finalization repair (ready for GPT review; zero future-fixture execution)
→ 0023ZJ finalized full-matrix execution (blocked: observed 42 assertions vs required 41)
→ 0023ZM assertion/case cardinality normalization and 0023ZN retargeting (ready for GPT review; zero future-fixture execution)
→ 0023ZN normalized full-matrix execution (ready for GPT review; two consecutive complete-matrix passes)
→ 0023ZO production Profile activation design and explicit authorization package (ready for GPT review; zero player-data I/O)
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
blocker through a zero-I/O external-instance configuration gate. Tasks 0023W
and 0023X then establish the accepted configured test store and pure progress
adapter. Tasks 0023Y–0023ZB close without accepted AppRoot implementation.
Task 0023ZC isolates source architecture from fixture execution: parser smoke
and a 17-assertion zero-Profile-I/O contract pass while configured
adapter/store/load and persistence-before-commit branches remain unexecuted.
Task 0023ZD then constructs the complete guarded future harness: 18 stages, 41
stable cases, deterministic manifest, parser smoke, 251-assertion static
validator and two complete zero-I/O capture Qualifications. The execution
guard and full matrix remained closed until Task 0023ZE. Task 0023ZE later ran
one authorized attempt and controlled-aborted at the Tutorial-0 compound
persistence assertion. Task 0023ZF then isolated the authorized subconditions
without source repair: one minimal run observed the expected immediate and
one-frame-delayed route, progress, best-turn, unlock, persist-status, screen
and target facts. GPT adjudicated the reported failure as a harness expectation
defect: the product sorts unlocked IDs while the harness expected the reversed
literal. Task 0023ZG repairs both exact comparisons with a sorted local
expected array, reinforces the validator, and retargets the inert future
contract to 0023ZH. Parser, 279 static assertions, no-guard proof and two
zero-I/O Qualifications pass. Task 0023ZH then ran one authorized attempt:
16 stages through `router_contract` passed, `cleanup` failed its
no-test-root-enumeration assertion, and the behavior controlled-aborted. The
runner retained only 9/17 required files after its invocation environment
could not resolve `Get-FileHash`, so the task stopped as
`DIAGNOSTIC_CAPTURE_INCOMPLETE`. Attempt 2 was not run. Actual full-matrix
success remains unestablished. Task 0023ZL completes the bounded harness-only
repair: exact-owned-path cleanup, direct .NET SHA-256, fail-closed 17-file
finalization, a 313-assertion validator, no-guard proof, two zero-I/O
Qualifications and frozen regressions all pass. Actual execution remains a
later separately authorized Task 0023ZJ. Task 0023ZJ then ran Attempt 1 exactly
once through the accepted runner. All 18 ordered stages passed, no assertion
failure or abort occurred, all 17 canonical evidence files were retained, the
exact fixture was absent after cleanup, and the runner classified
`PASS_CANDIDATE`. The external acceptance audit observed
`TASK_0023ZJ_ASSERTIONS=42` instead of the required `=41`, so the task-level
classification is `UNCLASSIFIED_NONPASS`. Attempt 2, post-Qualification and
post-regressions were not run; actual two-attempt full-matrix success remains
unestablished. GPT identified one duplicated case ID rather than a product
defect: `single_active_screen_router` covered two distinct successful checks.
Task 0023ZM gives the fresh-reload check its own ID, normalizes the manifest to
schema 2 with 42 unique cases and expected assertion count 42, adds a
non-counting internal guard, reinforces one-to-one validation, and retargets
the inert future contract to Task 0023ZN. Parser, 328-validator, no-guard, two
zero-I/O Qualifications and frozen regressions pass without Execute or future
fixture operation. Actual two-attempt full-matrix success remains separately
gated.

Task 0023ZN then executed only the frozen normalized harness through the
accepted runner. Two separately fresh exact-fixture attempts each retained
17/17 evidence, passed all 18 ordered stages and 42 assertions, emitted one
final pass marker, exited 0 with empty stderr, and completed exact owned-path
cleanup. Both externally audit to `PASS_COMPLETE_MATRIX`. The first audit's
CRLF-sensitive parser false negative was corrected from retained evidence
without rerunning the product. Post-Qualification, complete post-regressions,
the 328-assertion validator, all 38 frozen hashes, protected state, exact
fixture absence, and pollution checks pass. This establishes the normalized
test-only matrix twice; production persistence activation remains separately
gated.

Task 0023ZO selects a dedicated composition bootstrap as the smallest safe
production activation owner. It configures AppRoot before tree entry while
AppRoot remains the sole router. The design separates zero-production-I/O
implementation, isolated fixture behavior, explicit-user-authorized read-only
boot, conditional recovery copy, explicit-user-authorized first intentional
write plus NO_CHANGE, final default activation, later aggregate registration,
and the Menu flow slice. The existing 473-byte Profile was not accessed and no
product source or runtime command changed. Production activation remains a
future protected gate pending GPT acceptance and explicit user authorization.

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
