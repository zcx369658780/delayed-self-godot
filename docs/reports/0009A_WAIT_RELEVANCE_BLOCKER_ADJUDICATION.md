# Task 0009A WAIT-relevance blocker adjudication

- Verdict: `TASK_0009A_BLOCKED_CLEANLY_WAIT_LEVEL_DEFERRED`
- Blocked task: `tasks/0009A_door_timing_and_wait_content_batch.md`
- Blocked task issue point: `107b51d404fca460eae3a965da1dd821db82b52d`
- Adjudication date: 2026-07-15
- Adjudicated by: GPT Project Sources advisor

## Reported execution state

Codex returned `BLOCKED_WAIT_NOT_MECHANICALLY_RELEVANT` after attempting to satisfy the mandatory Level 5 literal-WAIT proof. All experimental repository changes were removed. The local worktree was reported clean at the Task 0009A issue point, with no commit and no push.

GitHub review confirms that remote `main` remains at the Task 0009A issue point and contains no Task 0009A implementation commit.

## Technical interpretation

This result does **not** establish a theorem that literal `WAIT` can never be mechanically relevant under `simulation_v1`.

A blocked cardinal action and literal `WAIT` both consume the current player turn, but they record different history actions. When replayed later, the recorded cardinal action may move an Echo if that direction is then open, while `WAIT` never moves the Echo. Therefore the two actions are not generally transition-equivalent.

However, the attempted bounded content-authoring pass did not find a Level 5 layout satisfying all of the following simultaneously without changing frozen mechanics:

1. the full-action optimal witness contains literal `WAIT`;
2. the no-WAIT search still permits blocked cardinal turn consumption;
3. the no-WAIT optimum is strictly worse or completely unsolved;
4. Echo cooperation, Door/Plate gating, and player-only completion remain necessary;
5. the level remains a clear, bounded candidate puzzle rather than a pathological construction.

The mandatory proof remains a valid high bar. It is not weakened or reinterpreted as merely “the intended author route uses WAIT.”

## Schedule and scope decision

Continuing to hand-author the same WAIT concept would create disproportionate schedule risk and could encourage acceptance of a decorative or non-necessary WAIT level. The candidate content spine will therefore proceed without claiming that the WAIT lesson is solved.

Decisions:

- `wait_for_the_echo` is removed from the immediate candidate implementation batch.
- Its status becomes `DEFERRED_VALIDATION_RESEARCH`, not rejected and not implemented.
- A future dedicated feasibility task may use bounded procedural layout search or other test-only authoring tools to search for a strict literal-WAIT level under unchanged semantics.
- Any future WAIT level must still pass the original full-action versus no-WAIT comparison, including blocked-cardinal substitutes.
- No solver, simulation, action, schema, or blocked-movement rule will be changed merely to force a WAIT proof.

## Replacement content decision

Task 0009A is superseded by a narrower replacement gate:

- Level 4 remains `door_one_turn_late` with the original start-of-turn Door timing proof.
- Level 5 becomes `two_keys_one_door`, promoted from the accepted roadmap concept.
- `two_keys_one_door` uses one delayed Echo, two Plates, and one combinational AND Door. It must prove that both Plate dependencies and Echo/player cooperation are mechanically necessary.

This preserves schema-v1 content progress while retaining strong machine-verification standards.

## Accepted claims and non-claims

Accepted:

- Task 0009A stopped safely at its explicit blocker condition.
- No repository implementation or history change requires rollback.
- The literal-WAIT proof remains unresolved and deferred.
- A replacement bounded content batch may proceed.

Not accepted:

- that WAIT is globally redundant;
- that no valid WAIT-required level exists;
- any Level 4 or Level 5 implementation result;
- any change to `simulation_v1`, `level_v1`, action order, blocked-movement semantics, solver semantics, HUD, viewport, save, export, release, or candidate status.

## Next gate

`Task 0009AR — Door timing and AND-door replacement content batch` is authorized. It must create only `door_one_turn_late` and `two_keys_one_door`, extend the catalog to five entries, preserve all accepted files and metrics, and record `wait_for_the_echo` as deferred research rather than implemented content.