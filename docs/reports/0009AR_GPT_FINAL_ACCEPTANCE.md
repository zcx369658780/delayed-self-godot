# Task 0009AR GPT final acceptance

- Verdict: `TASK_0009AR_DOOR_TIMING_AND_AND_DOOR_LEVELS_ACCEPTED`
- Accepted implementation commit: `9516c44688d5416c154167e8be002a60de7ce327`
- Accepted task: `tasks/0009AR_door_timing_and_and_door_replacement_batch.md`
- Acceptance date: 2026-07-15
- Accepted by: GPT Project Sources advisor

## Review basis

GitHub review confirmed that the implementation is exactly one commit ahead of the Task 0009AR issue point and changes only the authorized formal content, catalog, focused validation/test, report, roadmap, catalog-contract, and current-document surfaces. No simulation, LevelLoader, BFS solver, schema, normative fixture, accepted level 1–3 file, Gameplay/HUD implementation, viewport, AppRoot, catalog-loader, memory-progress, project setting, persistence, export, build, release, account, or repository-setting surface changed.

The superseded literal-WAIT level remains `DEFERRED_VALIDATION_RESEARCH`. No WAIT level was created, no validation standard was weakened, and no claim is accepted that WAIT is globally redundant or impossible to require.

## Accepted Level 4 evidence

For `door_one_turn_late`:

- strict result: `VALID_LEVEL`;
- one delay-2 Echo, one Plate, one dependent Door, and one player-only EXIT;
- solver: `SOLVED`;
- `L*=9`;
- `N*=7 (EXACT)`;
- 291 visited states and maximum frontier 116 under recorded limits;
- solver witness replays to completion and restart is exact;
- no-Echo controlled state space exhausts unsolved after 5 visited states;
- ECHO on EXIT does not complete and no corridor bypass exists.

The shortest witness contains the required two-transition timing lesson: a turn begins with the Door closed, ECHO reaches the Plate and the result opens the Door while YOU remains outside; the following turn begins open and YOU enters the Door cell. The accepted trace therefore demonstrates start-of-turn Door snapshot entry rather than retroactive same-turn opening.

## Accepted Level 5 evidence

For `two_keys_one_door`:

- strict result: `VALID_LEVEL`;
- one delay-3 Echo, two distinct Plates, one Door requiring both Plate IDs, and one player-only EXIT;
- solver: `SOLVED`;
- `L*=12`;
- `N*=1 (EXACT)`;
- 1,260 visited states and maximum frontier 225 under recorded limits;
- the unique shortest witness replays to completion and restart is exact;
- no-Echo controlled state space exhausts unsolved after 8 visited states;
- relocating either Plate beyond the closed Door makes the complete controlled state space unsolved;
- single-Plate dependency controls remain solvable, demonstrating that the committed two-Plate Door encodes a materially different AND requirement;
- ECHO on EXIT does not complete and no corridor bypass exists.

The accepted trace shows ECHO and YOU occupying two distinct Plate positions simultaneously, both IDs pressed, and the AND Door open. YOU then enters from an open start-of-turn snapshot. Distinct Plate positions prevent one actor or legal actor overlap from satisfying both dependencies.

## Catalog, progression, and regression

The tracked catalog now contains exactly five levels in one linear sequence:

1. `tutorial_reach_exit`;
2. `tutorial_echo_bridge`;
3. `vertical_slice_delay_3`;
4. `door_one_turn_late`;
5. `two_keys_one_door`.

Only Tutorial 0 is initially unlocked; each completion unlocks only its direct successor; only Level 5 is current-catalog final; no best-turn threshold or persistent progress was introduced.

Accepted final markers:

- `TASK_0003_TESTS_PASS assertions=280 vectors=9`;
- `TASK_0006_APP_SHELL_TESTS_PASS`;
- `TASK_0007_TUTORIAL_LEVELS_TESTS_PASS`;
- `TASK_0008_PROGRESSIVE_HUD_TESTS_PASS`;
- `TASK_0009AR_LEVELS_4_5_TESTS_PASS`.

The accepted hashes and solver/replay/necessity metrics for levels 1–3 remain unchanged.

## Accepted claims

For the exact accepted commit:

1. Five strict catalog-selected schema-v1 levels are implemented and internally playable through one reusable Gameplay path.
2. Level 4 mechanically exercises and proves next-turn Door entry timing.
3. Level 5 mechanically requires Echo/player cooperation, two distinct Plate dependencies, and a combinational AND Door.
4. No unresolved automated blocker prevents a bounded five-level human sequence review.

## Observations and non-claims

- Levels 4–5 have reached `INTERNAL_PLAYABLE`, not `FRESH_PLAYER_REVIEWED` or `CANDIDATE_ACCEPTED`.
- The owner’s earlier P2 findings—limited current Help utility and right-side HUD crowding at 960×540—remain open.
- Literal-WAIT feasibility remains deferred research.
- No fresh/independent review, final difficulty curve, final HUD/layout, persistent save, Pause/Results/Final Completion, final art/audio, accessibility, export, Web, candidate, release, or submission claim is accepted.

A qualifying fresh-player or independent human review remains mandatory before candidate acceptance. The authenticated owner may provide a non-fresh targeted five-level sequence review to determine whether further content production is safe, but that review cannot replace the later independent gate.

## Next gate

`Task 0009AV — owner five-level sequence and HUD readability review` is authorized as a documentation-only human-evidence gate. It must use the exact accepted five-level implementation, preserve all implementation surfaces, run the full regression, launch through normal AppRoot progression, and record the authenticated owner’s completion, difficulty progression, Help/timeline utility, Door/AND comprehension, and 960×540 HUD crowding findings. No Task 0009B content production is authorized until GPT adjudicates that review.