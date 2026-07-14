# M2 system skeleton implementation plan

- Status: `PLANNING_RECOMMENDATION_FOR_GPT`
- Planning source: Task 0005
- Authorization boundary: this plan does not authorize any future task, file change, commit, or push
- Candidate milestone: `2026-08-10`; final submission deadline remains unchanged

## Planning principles

- Reuse accepted loader/simulation/solver before adding abstractions.
- Keep one reusable Gameplay scene and data-driven formal levels.
- Keep catalog/progression/tutorial presentation separate from `level_v1`.
- Preserve Windows completion before Web and eight validated levels before new mechanics.
- Stop content multiplication when fresh-player evidence shows P0/P1.

## Dependency chain

```text
Task 0005 planning acceptance
-> Task 0006 app shell + catalog + in-memory progress
-> Task 0007 reusable gameplay loading + Tutorial 0–1 formal levels
-> Task 0008 progressive HUD + tutorial UX evidence
-> Task 0009 remaining schema-v1 candidate levels + validation matrix
-> separate complete-flow/save/audio/visual/export/review gates
```

Tasks may overlap only when their explicit task files define safe disjoint surfaces. No overlap is assumed here.

## Task 0006 — reusable app shell and catalog

| Field | Recommendation |
|---|---|
| Objective | implement Boot, Menu, Level Select, reusable route payloads, Safe Error, catalog validation, and in-memory progression |
| Dependencies | Task 0005 GPT acceptance; current 135-assertion baseline |
| Allowed surfaces | future explicit task may authorize `scenes/app`, `scenes/ui`, `scripts/app`, catalog schema/data, focused tests, current docs/report |
| Protected surfaces | `simulation_v1`, `level_v1`, existing formal level, solver semantics, persistence, exports, assets |
| Implementation | thin `AppRoot`/router, versioned separate JSON catalog, deterministic unlock policy, in-memory `ProgressStore`, development direct-level route, existing slice reachable through reusable payload |
| Tests/evidence | catalog shape/cross-reference/cycle failures; route transition matrix; unknown route/level safe error; in-memory unlock/reset; old conformance suite; bounded window launch |
| Commit suggestion | one focused implementation/docs commit only if its future task authorizes it |
| Stop conditions | catalog requires formal-level schema pollution; partial menu on invalid data; source baseline unexpectedly changes; save persistence becomes necessary |
| Window | 2026-07-15–07-17 if authorized promptly |
| Scope cuts | omit animation, settings implementation, credits polish, controller navigation; retain Boot/Menu/Select/Gameplay/Error |

Acceptance target: the accepted vertical slice launches by catalog ID through one router, while invalid catalog/level cases construct no gameplay state.

## Task 0007 — Tutorial 0–1 and reusable gameplay loading

| Field | Recommendation |
|---|---|
| Objective | make Gameplay load validated catalog-selected formal levels; create Tutorial 0 and Tutorial 1 within schema v1; validate/replay both |
| Dependencies | accepted Task 0006 catalog/router; accepted tutorial plan |
| Allowed surfaces | future explicit task may authorize reusable gameplay/controller/view seams, two formal level JSON files, catalog entries, solver/loader test extensions, report/evidence |
| Protected surfaces | transition semantics, schema changes, accepted vertical slice content, save, export, final art/audio |
| Implementation | parameterize level path/ID; preserve state-before-presentation; Tutorial 0 zero-echo exception; Tutorial 1 one delay-3 echo, one plate, one door; no per-level scene rules |
| Tests/evidence | schema validity; solve/replay; exact/capped `N*`; restart; Tutorial 1 echo-necessity controlled variant; all normative vectors; three-level launch matrix |
| Commit suggestion | one content/runtime/test commit plus report only if a future task explicitly permits that scope |
| Stop conditions | tutorial needs unsupported goals/mechanics; solver limit prevents a solvability claim; reusable controller breaks vertical-slice parity |
| Window | 2026-07-18–07-21 |
| Scope cuts | keep geometric presentation; omit narrative, best-turn thresholds, optional transitions |

Acceptance target: three catalog-selected levels use one gameplay authority; new levels reach REPLAY_VALIDATED, not automatically human-accepted.

## Task 0008 — progressive HUD and tutorial UX evidence

| Field | Recommendation |
|---|---|
| Objective | implement `INTRO_MINIMAL`, `GUIDED_ECHO`, and `STANDARD_COMPACT`; run fresh-player tutorial evidence |
| Dependencies | accepted Task 0007 levels and reusable gameplay; Task 0004V P2 carried observation |
| Allowed surfaces | future explicit task may authorize HUD scenes/scripts, tutorial presentation data/string keys, catalog HUD mode, focused tests, external UX evidence, report |
| Protected surfaces | transition/level semantics, solver, level topology unless a separate stop/replan is issued, localization rollout, new mechanics |
| Implementation | compact slot timeline, contract-derived echo pointers, contextual objective/legend, help recovery, unchanged prominent completion, Chinese-first candidate copy |
| Tests/evidence | HUD-mode snapshot tests; no-echo mode hides echo data; multi-delay synthetic state presentation; restart/help behavior; 960×540 clipping checks; fresh reviewer after Tutorials 0–1 |
| Commit suggestion | one focused UX/test/docs commit after evidence gates |
| Stop conditions | HUD duplicates history indexing; copy reveals a route; fresh review finds P0/P1; mode selection leaks into formal simulation data |
| Window | 2026-07-22–07-24 |
| Scope cuts | retain contextual text and compact timeline; cut animation, optional expanded polish, English |

Acceptance target: no P0/P1 in a fresh Tutorial 0–1 run before producing the remaining level spine.

## Task 0009 — remaining candidate levels and validation matrix

| Field | Recommendation |
|---|---|
| Objective | create levels 4–8 from the accepted roadmap, validate each, and assemble the eight-level candidate content spine |
| Dependencies | Task 0008 fresh-player gate; stable catalog/gameplay/HUD; solver budget reviewed |
| Allowed surfaces | future explicit task may authorize formal level JSON, catalog entries, validation records, solver/test tooling needed for metrics, bounded gameplay presentation fixes, report |
| Protected surfaces | schema-v2 mechanics, route divergence, save/export/release, broad visual/audio redesign |
| Implementation | geometry/timing variety only: next-turn door, WAIT, AND plate, staggered doors, two delays; preserve player-only EXIT |
| Tests/evidence | per-level validity, solve/replay, `L*`, `N*` status, limits, necessity variants, WAIT evidence, shortcuts, regression suite; four-level and pre-candidate human checkpoints |
| Commit suggestion | prefer small task-defined content batches rather than one broad commit; exact commit count must be authorized by future task files |
| Stop conditions | any level needs unsupported mechanics; solver/runtime mismatch; P0/P1 in sequence review; validation budget threatens complete flow |
| Window | 2026-07-25–07-31 |
| Scope cuts | cut level 8 first, then level 7; never ship unvalidated filler |

Acceptance target: eight levels at least REPLAY_VALIDATED, with human state recorded separately; six-level cut requires GPT approval.

## Later separate gates

These are not Task 0006–0009 scope:

| Gate | Earliest window | Required boundary |
|---|---|---|
| persistent save/progress adapter | 2026-08-01–08-02 | version/path/migration/corruption/isolated-profile task |
| settings, pause/continue polish, final completion, credits/licenses | 2026-08-01–08-05 | complete-flow task; no asset license assumptions |
| audio and visual direction | after stable flow, no later than 2026-08-05 first pass | asset ledger and bounded presentation task |
| Windows export and clean-machine smoke | 2026-08-03–08-05 | export-specific authorization and evidence |
| fresh/independent complete-flow review | 2026-08-06–08-09 | reviewer exposure record and P0–P3 adjudication |
| Web compatibility | after Windows candidate | separate inventory/export gate |
| public release/submission | after final acceptance | explicit user authorization |

## Schedule reconciliation

### Proposed critical path

| Date | Gate | Output |
|---|---|---|
| Jul 14 | Task 0005 | planning package |
| Jul 15–17 | Task 0006 | shell/catalog/in-memory progress |
| Jul 18–21 | Task 0007 | reusable gameplay + two tutorials |
| Jul 22–24 | Task 0008 | progressive HUD + fresh tutorial evidence |
| Jul 25–31 | Task 0009 | remaining validated content |
| Aug 1–5 | separate complete-flow gates | save/settings/final flow/Windows export evidence |
| Aug 6–10 | stabilization | scope freeze, P0/P1 closure, independent review, candidate package under separate authorization |

`PLANNING_RECOMMENDATION_FOR_GPT`: the dates remain feasible only because the accepted vertical slice and planning completed before the original M1 window. The schedule assumes rapid issuance of separate task files and no P0/P1 from Tutorial 0–1.

### Schedule risks and safest adjustment

- If Task 0006 is not accepted by Jul 18, move level 8 to optional immediately.
- If fresh Tutorial 0–1 evidence is not accepted by Jul 25, pause Task 0009 content multiplication and repair the tutorial/HUD.
- If fewer than six levels are REPLAY_VALIDATED by Jul 31, preserve six strong levels and complete flow rather than chase eight.
- If menu-to-results is not stable by Aug 3, cut English, visual effects, optional audio breadth, challenge content, and multi-delay finale before cutting core flow.
- Do not move the Sep 6 final submission deadline; use Aug 11–Sep 6 for polish only after a stable candidate.

## Cross-task acceptance invariants

Every future task should require:

1. clean root/branch/remote startup gate and task-defined paths;
2. no broad staging or history rewrite;
3. existing normative vectors and accepted level regression;
4. explicit status labels for proposed versus evidenced levels;
5. no save/export/release implication outside its task;
6. external evidence kept out of Git;
7. remote-drift check before any authorized push.

## Post-MVP backlog

### Player/ECHO route divergence

- Status: `DEFERRED_POST_MVP`.
- Potential value: makes actor identity affect route choice and may create replayable branching puzzles.
- Likely implications: alternate goals or actor-sensitive traversal, new catalog/progress branches, schema and transition changes, solver state/goal expansion, save migration, tutorial burden.
- Risks: weakens the single player-only EXIT rule, increases solver branching and content QA, threatens schedule, may create multiple endings by accident.
- Reconsider only after the candidate build is stable, all eight/six accepted levels pass complete-flow review, solver headroom is measured, and at least two high-quality level concepts need the mechanic.
- Any reconsideration begins with a separate design/contract task and schema-version decision; it is not an additive `level_v1` metadata flag.
