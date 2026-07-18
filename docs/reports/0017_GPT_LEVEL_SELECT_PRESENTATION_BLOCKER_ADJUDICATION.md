# Task 0017 GPT Level Select presentation-blocker adjudication

- Date: 2026-07-18
- Repository: `zcx369658780/delayed-self-godot`
- Blocked task: `tasks/0017_echo_spacing_bridge_implementation.md`
- Blocked checkpoint: `HEAD == origin/main == 039010144abb4d15580301df1fc6f60eada84773`
- Reported terminal verdict: `BLOCKED_PRESENTATION_READABILITY`
- GPT verdict: `TASK_0017_BLOCKER_ACCEPTED_LEVEL_SELECT_SCROLLABILITY_PREREQUISITE_REQUIRED`

## 1. Adjudication

The stop is correct. Task 0017 forbids changes under `scripts/app/` and `scenes/`, but the eight-entry catalog exposes a pre-existing App Shell scalability defect: `scripts/app/level_select.gd` creates one fixed `VBoxContainer` at `600×410`, places the title, every 56-pixel level button, and the Back button in that same non-scrollable column, and provides no `ScrollContainer` or equivalent access mechanism.

With eight catalog entries, the lower entries are clipped at the accepted 960×540 viewport. The bridge and shifted `two_echo_convergence` therefore cannot both remain reachable through the normal Level Select surface. This is a product-navigation blocker, not a bridge-puzzle proof failure.

## 2. Preserved bridge evidence boundary

The reported rejected working candidate established prospective evidence:

```text
L* = 16
N* = 12 EXACT
visited_states = 19059
maximum_frontier = 3734
all 12 shortest solutions: E2→A, E4→B, A+B open-snapshot crossing
no-ECHO, E2-only, E4-only: complete finite-state unsolved
```

Because the repository was fully rolled back and no product commit was made, these results remain external diagnostic/authoring evidence only. They do not establish a tracked formal level, accepted hash, catalog migration, regression result, or implementation acceptance. A later resumed Task 0017 must recreate and revalidate the final tracked candidate rather than claiming the rolled-back state as committed evidence.

## 3. Required prerequisite

Before Task 0017 may resume, implement one bounded Level Select scalability repair:

- retain the accepted 960×540 logical viewport;
- keep the title and Back action persistently reachable;
- place level entries inside a bounded `ScrollContainer` or equivalently tested scrollable region;
- ensure every entry is reachable by mouse wheel/scrollbar and keyboard/controller focus navigation;
- on normal return after completion, ensure the highest newly unlocked entry can be brought into view without requiring hidden knowledge;
- preserve unlocked/locked semantics, selection signals, route behavior, reset behavior, window scaling, and Safe Error behavior;
- validate at least the current seven-entry baseline, the proposed eight-entry sequence, and a synthetic larger list so the repair is not hardcoded to eight;
- do not modify formal level data, catalog data, Simulation, solver, Gameplay, Help, Timeline, or bridge content.

The preferred implementation surface is `scripts/app/level_select.gd` plus narrowly necessary app tests/capture harness and current documentation. `scenes/ui/level_select.tscn` should remain unchanged unless the code-only repair is demonstrably insufficient.

## 4. Status boundary

```text
TASK_0017 = BLOCKED_PENDING_LEVEL_SELECT_SCROLLABILITY_REPAIR
BRIDGE_PLAN = STILL_ACCEPTED
BRIDGE_CANDIDATE_EXTERNAL_RESULTS = AUTHORING_EVIDENCE_ONLY
SIGNAL_CONVERGENCE = STILL_UNAUTHORIZED
```

This adjudication does not authorize bridge implementation, catalog migration, finale implementation, Help/Timeline redesign, art/audio production, export, release, or submission.

After the Level Select repair passes machine and native 960×540 validation and receives GPT acceptance, issue a fresh bounded continuation task for `echo_spacing_bridge` using the accepted Task 0016R contract and full Task 0017 proof package.