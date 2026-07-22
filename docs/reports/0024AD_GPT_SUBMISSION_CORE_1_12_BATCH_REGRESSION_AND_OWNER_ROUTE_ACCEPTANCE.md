# Task 0024AD GPT acceptance — submission-core 1–12 batch regression and owner-route audit

- Verdict: `TASK_0024AD_SUBMISSION_CORE_1_12_BATCH_REGRESSION_AND_OWNER_ROUTE_AUDIT_ACCEPTED`
- Reviewed result commit: `b3e8da670925da3a5a106b13f0e85d13c8c474cf`
- Retained invocation: `fcd8d3bd-a67c-4b44-b664-98fa5e2f27d6`
- Accepted route classification: `ISOLATED_STAGING_CATALOG_REQUIRED`
- Review date: 2026-07-22

## Acceptance

Task 0024AD is accepted as the machine-readiness and safe-route-audit gate for the planned submission-core sequences 1–12.

The fresh direct-file batch solved all twelve rooms through the public loader, shared Simulation and accepted BFS solver. Every room retained exact shortest-solution count status, deterministic duplicate replay, exact restart and YOU-only completion. The accepted candidate facts for sequences 9–12 remained exact:

```text
9  crate_shadow_timing    L*=14  N*=6
10 key_route_commitment   L*=19  N*=8
11 identity_shift_bridge  L*=18  N*=1
12 lasting_echo_latch     L*=21  N*=6
```

The production catalog remained exactly eight ordered entries, sequence 8 remained the sole formal finale, and all four candidate IDs remained absent. No level, catalog, product route, Profile implementation or accepted evidence file changed.

## Curriculum disposition

Machine evidence supports `KEEP` for sequences 1, 2 and 4–8. Sequence 3 and sequences 9–12 remain `OWNER_REVIEW_REQUIRED`; no room is machine-recommended for revision or removal at this gate.

The following observations remain human-review items rather than machine failures:

- sequence 3 has exact `N*=31` and needs redundancy/shortcut review;
- sequence 5's historical title mentions keys although its current entities are Plates;
- the 8→9 and 10→11 shortest-length drops may be acceptable conceptual resets but require pacing review;
- sequence 12 is mechanically credible only as a finale candidate while sequence 8 remains the sole formal finale;
- current Gameplay does not visibly render schema-v2 crates, keys/locks, typed sensors, grouped barriers or latches.

All owner difficulty, clarity, enjoyment, confusion, shortcut, presentation and disposition fields remain explicitly `NOT_YET_REVIEWED`. This acceptance is not owner playthrough acceptance.

## Route decision

The accepted safe-route classification is `ISOLATED_STAGING_CATALOG_REQUIRED`.

The current `--level-id` route is catalog-ID-only, so the four uncatalogued candidates cannot be launched through the production catalog. A direct Gameplay launcher would bypass catalog validation, unlock progression, completion persistence and finale behavior. The minimum valid later route is therefore a test-owned twelve-entry staging catalog plus a test-owned launcher that:

1. instantiates AppRoot outside the tree;
2. sets the exported `catalog_path` to the staging catalog;
3. calls `configure_test_profile()` with one exact canonical test fixture path;
4. requires `APP_TEST_PROFILE_CONFIGURED` / `TEST_PROFILE` before tree entry;
5. exercises the normal AppRoot catalog → selection → Gameplay → completion → unlock/finale route;
6. never calls production Profile configuration and never probes production data.

Product code does not currently require an injection seam because these pre-tree seams already exist.

## Regression and lifecycle

The retained Task 0024AD cycle executed exactly once:

1. focused 1–12 batch validator;
2. accepted focused Task 0024AC;
3. accepted focused Task 0024AB;
4. accepted focused Task 0024Z;
5. accepted focused Task 0024Y;
6. Aggregate;
7. corrected complete-v2.

All seven cases passed with native exit zero and exact markers. Aggregate stderr was exactly `LEVEL_ID_MISMATCH`; all other stderr streams were empty. Cleanup ran once per case, no owned or unproven PID remained and final Godot count was zero. PRE_TASK, PRE_FINAL and POST_FINAL audits found zero protected mismatch.

The retained cycle is consumed and must not be rerun.

## Scope boundary

This acceptance establishes machine curriculum readiness and one implementation-ready safe-route recommendation. It does not authorize owner subjective acceptance, production catalog admission, formal finale movement, production Profile migration/default behavior, v2 presentation work, localization, assets/audio, build/export, release, upload or submission.

The next authorized stage may implement and machine-qualify the isolated staging catalog and launcher under a new test-owned task identity. Human owner playthrough must remain blocked until a separate presentation gate makes schema-v2 mechanics visibly understandable.