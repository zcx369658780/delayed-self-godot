# Task 0008 owner-targeted Tutorial 0–1 retest

- Reviewer: `authenticated_project_owner`
- Review status: `NOT_FRESH_NOT_BLIND_OWNER_RETEST`
- Date: 2026-07-15
- Accepted Phase A implementation: `3f35078b5d7e71db871140ca440c38069ea5d057`
- Retest governance baseline: `1da86aeabf2ec091ebda097f165c317051fbeeba`
- Environment: Windows, Godot `4.7.stable.steam.5b4e0cb0f`, Compatibility renderer, 960×540 configured viewport
- Launch protocol: normal `project.godot` AppRoot/Main Menu/Level Select flow; no development direct-level argument
- Bounded launch-smoke command: `& 'D:\Program Files (x86)\Steam\steamapps\common\Godot Engine\godot.windows.opt.tools.64.exe' --headless --path 'D:\Delayed_Self' --log-file 'D:\Delayed_Self_Evidence\0008_owner_tutorial_retest\normal_app_root_launch.log' --quit-after 3`

## Qualification and protocol

The reviewer is the authenticated project owner who has prior exposure to the project, earlier design discussion, and earlier gameplay. This is therefore an owner-targeted verification, not a fresh, blind, first-player, or independent review.

The owner replayed the current sequence through the normal game flow. No movement sequence, next-move advice, operational hint, or route was provided during the retest. The owner directly reported progressing normally from the first level through the third level.

## Preflight regression

The accepted repository-only suite passed immediately before documentation:

- `TASK_0003_TESTS_PASS assertions=239 vectors=9`
- `TASK_0006_APP_SHELL_TESTS_PASS`
- `TASK_0007_TUTORIAL_LEVELS_TESTS_PASS`
- `TASK_0008_PROGRESSIVE_HUD_TESTS_PASS`

Accepted metrics remained unchanged:

- Tutorial 0: `L*=3`, `N*=3 (EXACT)`, 6 visited states, maximum frontier 2;
- Tutorial 1: `L*=9`, `N*=12 (EXACT)`, 1,975 visited states, maximum frontier 509;
- Tutorial 1 controlled no-Echo variant: `UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE`, 10 visited states;
- vertical slice: `L*=9`, `N*=31 (EXACT)`, 1,318 visited states;
- vertical-slice Echo-isolated variant: `UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE`, 1,006 visited states.

## Tutorial 0 attempt

- Attempt status: `COMPLETED_UNASSISTED`
- Assistance: no movement sequence, next move, operational hint, or route supplied
- Final visible turn count: `NOT_PROVIDED`
- Approximate elapsed time: `NOT_PROVIDED`
- Restart count: `NOT_PROVIDED`
- Tutorial 1 unlock: owner reported normal progression from the first level through the third level, which includes the normal Tutorial 0 → Tutorial 1 unlock flow
- Screenshot: `NOT_PROVIDED`

Detailed observations about YOU/EXIT recognition, exact control-collapse timing, restart use, completion wording, clipping, and the single best Tutorial 0 improvement were not separately supplied. No crash, broken unlock flow, impossible completion, or blocking comprehension problem was reported.

### Tutorial 0 follow-up answers

1. Visually simple enough / unnecessary information: `NOT_PROVIDED`
2. Control-collapse timing: `NOT_PROVIDED`
3. `H` Help discoverability and usefulness: the owner reported limited practical value because all three current levels are very simple; discoverability was `NOT_PROVIDED`
4. Completion and Tutorial 1 unlock clarity: detailed answer `NOT_PROVIDED`; normal progression to later levels was reported
5. Single most useful improvement: `NOT_PROVIDED`

## Tutorial 1 attempt

- Attempt status: `COMPLETED_UNASSISTED`
- Assistance: no movement sequence, next move, operational hint, or route supplied
- Final visible turn count: `NOT_PROVIDED`
- Approximate elapsed time: `NOT_PROVIDED`
- Restart count: `NOT_PROVIDED`
- Normal-flow result: owner completed Tutorial 1 and reached the third level
- Screenshot: `NOT_PROVIDED`

The owner did not separately provide detailed answers about YOU/ECHO role interpretation, which timeline slot controlled the next Echo action, pointer readability, Plate/Door timing, disclosure timing, or whether Help changed the visible turn. No blocking comprehension problem was reported. The owner directly reported that the right-side text felt crowded and that the current 960×540 game viewport felt too small.

### Tutorial 1 follow-up answers

1. Timeline versus old History/Echo-next layout: `NOT_PROVIDED`
2. Next-action slot and pointer clarity: `NOT_PROVIDED`
3. Legend/objective collapse timing: `NOT_PROVIDED`
4. Plate/Door timing: `NOT_PROVIDED`
5. Most helpful/redundant information: `NOT_PROVIDED`
6. `H` Help sufficiency: limited practical value in the current simple three-level sequence
7. Continue to the third level: yes; the owner reported reaching it through normal flow
8. Single most useful Tutorial 1 improvement: `NOT_PROVIDED`; the separately reported layout concern is right-side crowding at 960×540

## Optional ratings

| Rating | Value |
|---|---|
| Entity distinction | `NOT_PROVIDED` |
| Objective clarity | `NOT_PROVIDED` |
| Control clarity | `NOT_PROVIDED` |
| Timeline/next-action usefulness | `NOT_PROVIDED` |
| Plate/Door causality | `NOT_PROVIDED` |
| Information density | `NOT_PROVIDED` |
| Completion/unlock clarity | `NOT_PROVIDED` |
| Willingness to continue | `NOT_PROVIDED` |

## Findings

Finding counts: P0=0, P1=0, P2=2, P3=0.

### P2-1 — Limited practical value of `H` Help

Direct owner statement: `H` Help was not particularly useful, mainly because all three current levels are very simple.

Classification: P2. The control remains available and its zero-turn behavior is covered by accepted automation, but its practical value has not yet been demonstrated in a more demanding sequence. Carry this into later fresh-player and complete-flow review; do not remove or redesign it from this documentation-only gate.

### P2-2 — Right-side HUD crowding at 960×540

Direct owner statement: the text on the right side felt crowded, and the current game viewport felt too small.

Classification: P2. This did not block completion or normal progression, but it is a material readability/layout concern. Carry it into later layout, fresh-player, four-level-sequence, and complete-flow review. The information-density issue is not closed.

## Gate result and non-claims

Both tutorials were completed unassisted through normal flow, the third level was reached, P0=0, and P1=0. This supports recommending GPT authorization of Task 0009 content production.

This owner retest does not establish fresh-player, blind, first-player, or independent comprehension; `FRESH_PLAYER_REVIEWED`; `CANDIDATE_ACCEPTED`; closure of information density; final HUD/layout quality; or export, release, and submission readiness. A qualifying fresh-player or independent review remains mandatory after the first four-level continuous sequence exists and no later than candidate acceptance.

## Evidence index

External evidence root: `D:\Delayed_Self_Evidence\0008_owner_tutorial_retest\`.

- `preflight_tests.log`: four accepted markers and unchanged solver summaries;
- `normal_app_root_launch.log`: bounded current normal-main-scene launch smoke;
- `owner_direct_feedback.txt`: direct owner feedback supplied for this retest;
- `EVIDENCE_INDEX.md`: timestamps, commands, sizes, and SHA-256 hashes.

No screenshot was provided. External evidence is not staged.

## Recommendation

Recommend GPT acceptance of this owner-targeted verification and issuance of `Task 0009 — remaining schema-v1 candidate levels and validation matrix`. Retain both P2 findings and the rescheduled fresh/independent review requirement.
