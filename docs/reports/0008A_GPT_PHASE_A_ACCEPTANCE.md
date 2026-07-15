# Task 0008 Phase A GPT acceptance

- Verdict: `TASK_0008_PHASE_A_PROGRESSIVE_HUD_ACCEPTED_PENDING_FRESH_PLAYER_REVIEW`
- Accepted implementation commit: `3f35078b5d7e71db871140ca440c38069ea5d057`
- Accepted task: `tasks/0008_progressive_hud_compact_timeline_and_fresh_player_tutorial_review.md`
- Accepted phase: `A — implementation`
- Acceptance date: 2026-07-14
- Accepted by: GPT Project Sources advisor

## Review basis

GitHub review confirmed that Phase A is exactly one commit ahead of the Task 0008 issue point and changes only the authorized HUD/presentation, pure timeline-query, focused test, implementation-report, design-reconciliation, and current-document surfaces. No formal level, tracked catalog, schema, LevelLoader, BFS solver, normative fixture, AppRoot route, in-memory progress, project setting, GDD, project rule, persistence, asset, plugin, export, build, release, account, or repository-setting surface changed.

## Accepted implementation claims

For commit `3f35078b5d7e71db871140ca440c38069ea5d057`, the following are accepted:

1. `INTRO_MINIMAL` hides Echo, delay, timeline, Plate, Door, and WAIT-as-puzzle concepts and collapses full controls after the first legal action while retaining discoverable help.
2. `GUIDED_ECHO` initially exposes player-only completion, YOU/ECHO identity, delay, Plate/Door causality, and a compact three-slot timeline; the legend and long causality copy collapse only after accepted observable gameplay events.
3. `STANDARD_COMPACT` uses a one-line player-only objective and the compact timeline as the primary planning surface instead of permanently duplicating full History and separate Echo-next prose.
4. Help expansion through `H` is presentation-only: it does not call `Simulation.transition`, advance `turn_index`, or change the canonical key.
5. Restart reconstructs the accepted logical initial state while preserving already-earned disclosure flags within the current gameplay session.
6. Completion remains prominent and explicitly states that YOU reached EXIT.
7. The new `DelayedSelfTimelineModel` is presentation-only and does not predict movement, doors, completion, or any puzzle rule.
8. `Simulation.echo_history_index_for_state` is a pure shared query used by both accepted Echo action lookup and HUD presentation, preventing duplicated delay/history indexing without changing transitions, states, or canonical keys.

## Accepted regression and visual evidence

The implementation report records:

- baseline: `TASK_0003_TESTS_PASS assertions=220 vectors=9` plus Task 0006 and Task 0007 pass markers;
- final: `TASK_0003_TESTS_PASS assertions=239 vectors=9`;
- `TASK_0006_APP_SHELL_TESTS_PASS`;
- `TASK_0007_TUTORIAL_LEVELS_TESTS_PASS`;
- `TASK_0008_PROGRESSIVE_HUD_TESTS_PASS`;
- unchanged Tutorial 0, Tutorial 1, and vertical-slice solver/replay/necessity metrics;
- 13 bounded 960×540 game-root captures covering initial, progressed, help-expanded, and completion states.

The compact timeline preserves oldest-to-newest action identity, including blocked cardinal actions, and supports multiple delays through contract-derived pointers in synthetic presentation tests. Zero-Echo Tutorial 0 produces no timeline.

## Human-gate status

No qualifying fresh reviewer participated in Phase A. The authenticated project owner and Codex are ineligible substitutes. Therefore:

- Phase A implementation is accepted;
- Phase B remains mandatory;
- Tutorial 0 and Tutorial 1 remain `INTERNAL_PLAYABLE`, not `FRESH_PLAYER_REVIEWED` or `CANDIDATE_ACCEPTED`;
- the prior information-density P2 is not closed;
- Task 0009 is not authorized.

A qualifying Phase B reviewer must not have seen solver routes, action sequences, level JSON, prior design discussion, Task reports, development direct-level instructions, or the earlier user review. The reviewer may be recorded under a privacy-safe role label such as `colleague_1`, `student_1`, `friend_1`, or `family_1`.

## Next gate

Continue the existing Task 0008 Phase B only after a qualifying fresh reviewer is available. Phase B must use the exact accepted implementation commit (or its fast-forward descendants containing only this acceptance artifact/task governance), run the required preflight, launch the normal catalog sequence, collect direct Tutorial 0–1 evidence, and create only the authorized documentation-only review commit.

Any P0/P1 finding blocks Task 0009 and requires a focused repair task. A positive Phase B review returns for GPT adjudication before Task 0009 is issued.
