# Task 0008 Phase B GPT gate amendment — owner targeted tutorial retest

- Decision: `OWNER_TARGETED_RETEST_REPLACES_IMMEDIATE_FRESH_PLAYER_GATE`
- Date: 2026-07-15
- Issued by: GPT Project Sources advisor
- Accepted Phase A commit: `3f35078b5d7e71db871140ca440c38069ea5d057`
- Phase A acceptance: `docs/reports/0008A_GPT_PHASE_A_ACCEPTANCE.md`
- Amended task: `tasks/0008_progressive_hud_compact_timeline_and_fresh_player_tutorial_review.md`

## Context

The project owner reports that no qualifying unexposed player is currently available for the immediate Task 0008 Phase B review. Continuing to block all content work solely on reviewer availability would create schedule risk without producing new implementation evidence.

The authenticated project owner has already seen prior design discussion and completed the earlier vertical slice. Therefore the owner cannot provide fresh-player or blind-discoverability evidence. However, the owner can still provide useful targeted evidence about the implemented Tutorial 0–1 sequence, progressive disclosure, compact timeline, help behavior, completion flow, information density, and runtime defects.

## Revised gate decision

Task 0008 Phase B is revised from an immediate fresh-player review into an owner-targeted tutorial retest.

The project owner may:

- launch the exact accepted Phase A implementation through the normal AppRoot/catalog sequence;
- reset in-memory progress by restarting the process;
- play Tutorial 0 and Tutorial 1 without receiving a movement sequence during the retest;
- record direct observations, completion status, visible turn counts, restarts when known, help/timeline use, information-density feedback, and P0–P3 findings;
- submit deliberately approved game-window-only screenshots;
- be recorded as `authenticated_project_owner` with review status `NOT_FRESH_NOT_BLIND_OWNER_RETEST`.

Codex must not describe this as a first-player, fresh-player, blind, or independent review.

## Gate consequences

A completed owner retest with no unresolved P0/P1 may permit GPT to authorize Task 0009 content production. This means only that the current owner can use the tutorials and HUD without a blocking defect; it does not prove first-time discoverability or general tutorial quality.

The following claims remain prohibited:

- `FRESH_PLAYER_REVIEWED` for Tutorial 0 or Tutorial 1;
- closure of the information-density P2 for new players;
- independent tutorial acceptance;
- `CANDIDATE_ACCEPTED` based on the owner retest;
- final tutorial, HUD, accessibility, or complete-flow acceptance.

At least one qualifying fresh-player or independent human review remains mandatory before candidate acceptance. The preferred rescheduled checkpoints are:

1. after Tutorial 0–1 plus the first four-level continuous sequence exist; or
2. no later than the pre-candidate complete-flow gate.

The reviewer must not have seen solver routes, level JSON, or prior design discussion. Any P0/P1 at that later review still blocks candidate acceptance and may require repair even if Task 0009 content has already been authored.

## Scope and safety

This amendment authorizes no implementation change. Phase B remains documentation-only and must not modify source, scenes, formal levels, catalog, schemas, tests, project settings, copy, or visuals.

The revised Phase B task may create only:

- `docs/reviews/0008_OWNER_TARGETED_TUTORIAL_0_1_RETEST.md`;
- `docs/reports/0008_OWNER_TARGETED_TUTORIAL_RETEST_REPORT.md`;
- narrowly necessary current-document updates.

The authorized external evidence directory is:

`D:\Delayed_Self_Evidence\0008_owner_tutorial_retest\`

External screenshots and logs must not be committed.

## Decision hierarchy

This amendment and the revised Task 0008 file supersede the immediate fresh-review requirement in the earlier Phase A acceptance only for deciding whether Task 0009 content production may begin. They do not remove the later fresh/independent human gate required for candidate acceptance.
