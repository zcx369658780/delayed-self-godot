# Task 0019 GPT candidate-A search blocker adjudication

- Reported verdict: `BLOCKED_NO_BOUNDED_CANDIDATE_A`
- Task checkpoint: `e2e73db3b14422f3b2a2ec8becf171c14d1cdc57`
- Product change: none
- GPT verdict: `TASK_0019_BLOCKER_ACCEPTED_RECONCILE_PLAN_BAND_BEFORE_FALLBACK`

## Adjudication

The stop is correct. Task 0019 authorized candidate A only, fixed solver limits, and prohibited widening limits, rewriting acceptance targets, or automatically activating fallback B. The reported run used 70 structural candidates and all 32 Stage-B solver slots, found no candidate satisfying the narrowed implementation band, and correctly stopped before Stage C/D or repository writes.

This does not yet establish that candidate A is infeasible under the accepted Task 0018 plan. Task 0018 pre-registered the wider planning band:

```text
21 <= L* <= 30
1 <= N* <= 12 EXACT
20000 <= visited_states <= 300000
2000 <= maximum_frontier <= 50000
```

Task 0019 later narrowed it to `22–28 / 1–8 / 30000–250000 / 3000–40000` before search. The next gate must reconcile the existing ledger against both bands and must not invent a third candidate-specific band after seeing results.

## Required next decision

Use the existing external ledger and exact candidate definitions first. Determine:

1. which metric or combination rejected each Stage-B candidate;
2. whether any candidate satisfies the original Task 0018 planning band but not the Task 0019 narrowed band;
3. the Pareto frontier and normalized distance of the nearest candidates to both bands;
4. whether nearest candidates still satisfy candidate-A structural requirements before expensive proof;
5. whether candidate A merits Stage C/D continuation under the original pre-registered band.

If at least one structurally valid candidate satisfies the original plan band, at most eight may enter strict controls and at most three may enter complete augmented proof under the already frozen solver/proof limits. No product write follows automatically.

If no candidate survives the original plan band, only then may a small external-only fallback-B pilot be used to decide whether B should be activated or sequence 8 should remain the final level. B remains unauthorized for product implementation.

## Boundary

No formal level, catalog, source, tests, Help, Timeline, schema, scene, setting, build, export, release, or submission change is authorized. Existing eight levels remain the accepted product baseline. Intermediate progress messages are not terminal verdicts; execution should continue until the new task returns one explicit terminal result.
