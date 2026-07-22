# Task 0024X GPT acceptance — submission-core levels 9–12 scope finalization

- Verdict: `TASK_0024X_SUBMISSION_CORE_LEVELS_9_12_SCOPE_ACCEPTED`
- Reviewed commit: `a561f471c57e5b8c4c1349dde3c88fba1a2ed5b0`
- Accepted predecessor: `TASK_0024W_COMPLETE_CORE_MECHANICS_FOUNDATION_ACCEPTED`
- Review date: 2026-07-22

## Accepted planning package

The binding planning source is:

`docs/level_design/SUBMISSION_CORE_LEVELS_9_12_SCOPE_CURRENT.md`

The append-only submission-core curriculum is accepted as:

1. sequence 9 — `crate_shadow_timing`: YOU-only crate placement creates persistent timing state and deliberately changes an ECHO phase;
2. sequence 10 — `key_route_commitment`: one `main` key/lock creates an irreversible YOU-only delayed route commitment;
3. sequence 11 — `identity_shift_bridge`: YOU-only/ECHO-only sensor identity controls a grouped bridge under next-turn and occupied-cell closure rules;
4. sequence 12 — `lasting_echo_latch`: a one-shot latch creates a permanent room-local phase transition and synthesizes already taught sensor/barrier timing.

The target shortest-turn bands, shortest-solution posture, search budgets, necessity controls, shortcut probes, restart/canonical requirements, admission criteria and hard-cut fallbacks are accepted as planning constraints rather than measured solver claims.

## Binding sequence and compatibility policy

- Existing IDs and sequences 1–8 remain stable.
- `two_echo_convergence` remains sequence 8 and the current sole formal finale.
- Future sequence 9 requires sequence-8 completion; sequences 10–12 append linearly.
- Sequence 12 remains `FINALE_CANDIDATE_ONLY` until a separate catalog/Profile integration gate.
- Existing completion, best-turn, unlock, settings and language values must remain valid and must never be destructively recomputed or reset.
- No Profile read/write, migration, reset or `zh-Hans` default activation is authorized by this acceptance.

## Risk and cut decision

Sequence 11 is accepted as the highest-risk room. Its implementation must begin inside the frozen fallback envelope: exactly YOU-only and ECHO-only critical sensors, an explicit `include_crates=false` policy and a two-cell grouped bridge. The optional crate/`ANY_ACTOR` branch may be reconsidered only after the fallback candidate meets solver, readability and schedule budgets.

Cut order is binding: remove optional combinations first, then simplify entity count and footprint. Do not substitute stretch mechanics or levels 13–14, and do not weaken solver/replay/restart evidence or Profile protections to retain the twelve-level count.

## Scope boundary

Task 0024X changed documentation only. It created no formal level JSON, catalog entry, Profile migration, final-flag change, Gameplay/UI implementation, localization, asset/audio import, build/export or release authority.

The next authorized gate is sequence 9 candidate authoring and machine validation only. Catalog admission, owner curriculum playthrough and progression/Profile integration remain later independent gates.
