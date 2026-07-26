# Task 0024AYR — Reconcile the C03 next-turn Door contract and run one bounded redesign retry

- Status: `READY`
- Gate: `C03 CONTRACT RECONCILIATION / BOUNDED REDESIGN / INDEPENDENT MACHINE VALIDATION`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Required predecessor checkpoint: `d8240a967dc46c5933b2159533629614d27cb766`
- Historical predecessor: Task 0024AY, immutable `BLOCKED`
- GPT adjudication: `TASK_0024AY_BLOCKER_ACCEPTED_CONTRACT_RECONCILIATION_RETRY_AUTHORIZED`
- Candidate: `C03 / phase_1_c03_crate_delayed_door`
- Production catalog: sequences 1–8 only; formal finale: sequence 8
- Candidate admission/Profile/catalog/finale migration: `NOT_AUTHORIZED`
- DeepSeek project-code routing: `DISABLED`
- This is the only authorized C03 retry before a cut/continue decision.

## 1. Predecessor facts and corrected contract

Task 0024AY best discarded layout was `SOLVED`, `L*=15`, exact `N*=14`, but the old eight-event mask passed only `2/14`; `12` paths omitted the intentional same-turn failed Door input. They still retained crate push, ECHO crate block, useful phase shift, Plate entry and later Door crossing. No candidate/test was retained, PRE_FINAL was not reached, and no manifest existed.

Do not resume 0024AY, recover temporary/deleted candidate bytes, or create a retroactive manifest.

The product-relevant C03 lesson is:

```text
crate commitment
→ ECHO phase shift
→ ECHO enters Plate
→ Door is closed at the start of that transition
→ Door opens only after transition resolution
→ YOU crosses on a later transition whose start snapshot is open
→ YOU reaches EXIT
```

A failed same-turn Door input is no longer mandatory in every shortest solution. Instead, every shortest solution must satisfy strict temporal separation, and one separate reachable shared-Simulation diagnostic must prove a same-turn Door attempt is blocked.

## 2. Required reads

Read `AGENTS.md`, current startup/active docs, this task, the GPT 0024AY blocker adjudication, the 0024AY blocker report/JSON, the C03 brief and Phase-1 plans, schema/Simulation/BFS contracts and implementations, accepted C02/S01/sequence-9 evidence, the accepted owned Godot wrapper, current Aggregate, and current complete-v2 test. Read existing level names/hashes. Profile data is forbidden.

## 3. Startup gate

Require synchronized `main`, divergence `0/0`, checkpoint ancestry, clean tracked/staged state, only accepted `.codex/config.toml`, accepted hash, Godot `4.7.1.stable.steam.a13da4feb`, zero pre-existing Godot processes, no 0024AYR artifacts, and frozen loader/Simulation/BFS/schema/wrapper/Aggregate/complete-v2/catalog/level/evidence hashes. Consumed 0024AW/0024AX manifests remain immutable and must never run.

## 4. Authorized paths

```text
data/levels/phase_1_c03_crate_delayed_door.json
tests/levels/task_0024ayr_c03_crate_delayed_door_validation.gd
tests/levels/task_0024ayr_c03_crate_delayed_door_validation.gd.uid
tests/tools/task_0024ayr_*.ps1
tests/tools/task_0024ayr_*.py
tests/tools/task_0024ayr_*.json
docs/level_design/validation/phase_1_c03_crate_delayed_door_retry_validation.json
docs/reports/0024AYR_C03_NEXT_TURN_DOOR_RETRY_REPORT.md
docs/handoffs/DELAYED_SELF_SESSION_HANDOFF_AFTER_TASK_0024AYR_C03_RETRY_2026_07_26.md
docs/level_design/phase_1/C03_CRATE_DELAYED_DOOR_BRIEF.md
docs/level_design/phase_1/PHASE_1_SIX_CANDIDATE_BRIEFS_CURRENT.md
docs/level_design/phase_1/PHASE_1_SIX_CANDIDATE_VALIDATION_PLAN_CURRENT.md
docs/level_design/OWNER_FEEDBACK_LEVEL_PORTFOLIO_MATRIX_CURRENT.md
docs/production/EXPANDED_CONTENT_SUBMISSION_ROADMAP_CURRENT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
```

No other path may change. Protect catalog, pre-existing levels/tests, scripts, scenes, schemas, Aggregate, simulation tests, wrapper, Profile, presentation/release surfaces, and immutable 0024AY report/blocked JSON.

## 5. Bounded redesign limit

Before PRE_FINAL:

```text
maximum topology families = 3
maximum total candidate variants = 6
```

Record each family/variant hash, topology summary, solver result, revised-mask result, diagnostic result and rejection reason. If none passes, return `BLOCKED_RETRY_EXHAUSTED` and recommend cut/replacement. Do not expand the search.

## 6. Candidate and solver contract

Strict schema-v2 level with one YOU, one delay-2–4 ECHO, one crate, one Plate, one initially closed Door dependent on that Plate, one YOU-only EXIT, and zero sensors/barriers/keys/locks/latches. Stable IDs: `echo_window`, `crate_window`, `plate_window`, `door_window`. Footprint 8–11 by 6–8. Every shortest completion uses 1–3 consequential pushes and 1–2 ECHO crate blocks.

Solver envelope:

```text
target L* = 12–20; hard cap 24
exact N* = 1–64; all-shortest cap 128
soft/hard states = 100,000 / 250,000
soft/hard elapsed = 30 / 90 seconds
maximum depth = 56
```

Timeout, cutoff, truncation or hard-limit breach means redesign or `UNVERIFIED`; never widen limits.

## 7. Focused validation and revised all-shortest proof

Create the dedicated test with marker `TASK_0024AYR_C03_NEXT_TURN_DOOR_PASS`. Use only public loader, shared Simulation and BFS. Prove identity/schema, catalog absence, exact solver metrics, deterministic replay, exact restart, canonical crate identity and YOU-only completion.

Mandatory seven-event mask:

```text
LEGAL_CRATE_PUSH
ECHO_BLOCKED_BY_CRATE
ECHO_PHASE_CHANGED
ECHO_ENTERS_PLATE
DOOR_OPENS_AFTER_PLATE
YOU_LATER_CROSSES_DOOR
YOU_REACHES_EXIT
```

Every shortest completion must contain all seven events in order and prove:

- `plate_entry_turn < door_cross_turn`;
- Door start state on Plate-entry transition is closed;
- Door end state is open;
- YOU does not cross on the Plate-entry transition;
- crossing transition starts open;
- 1–3 pushes and 1–2 ECHO blocks.

Require exact `N*/N*`, omissions zero and complete enumeration. Do not require a failed Door input in shortest solutions and do not implement parallel Simulation.

## 8. Reachable blocked-Door diagnostic

Find one reachable shared-Simulation trace, not necessarily shortest, where YOU is adjacent to closed Door, ECHO enters Plate, YOU moves toward Door and remains blocked, Door ends open, and YOU crosses on the next transition from an open start snapshot. Retain the reachable prefix and exact before/after actor/crate/Plate/Door/history state. If no reachable diagnostic exists, fail the candidate.

## 9. Controls and probes

Every control must public-load; no limit result may be called unsolved. Required controls: no-push, no-crate, displaced crate, pre-positioned crate, static wall substitution, no-ECHO, Plate/Door dependency removed, timing-bypass geometry, no-block control, and Door initially open. No-push and no-ECHO must be complete-unsolved; others must be complete-unsolved or materially change metrics with zero revised-mask completions as appropriate.

Also prove no Door bypass, ECHO cannot push/enter crate, illegal YOU push is stable, Door uses start snapshot, Plate affects Door after movement, crate remains in lane, no useful phase exists without commitment, YOU cannot finish without ECHO Plate, ECHO cannot finish, shortest witnesses avoid repeated blocked-input macros, and restart is exact.

Do not modify scenes. `presentation_status = MACHINE_CONTRACT_READY_OWNER_REVIEW_PENDING` only after static cue audit.

## 10. Iteration, PRE_FINAL and retained lifecycle

Each iteration uses the accepted wrapper, unique identity, bounded budgets, cleanup once, no owned/unproven PID, final Godot zero and protected-hash preservation.

After a passing variant: freeze hashes; run static/parser/schema/protected audits; run focused twice; run current Aggregate and complete-v2; record exact markers/assertions/stderr; create PRE_FINAL seal; prohibit edits; require Godot zero; create one fresh 0024AYR manifest.

Final lifecycle follows accepted Task 0024AL architecture: Python stdlib parent, fresh PowerShell worker per case, accepted wrapper, atomic case record/reopen, independent parent validation/journal, no shared PowerShell lifetime. Consume once and run focused C03 retry, current Aggregate and current complete-v2 exactly once. Any consumed-cycle failure closes `BLOCKED`; no repair/rerun/replacement/reconstruction.

## 11. Evidence, current docs, commit

Create retry validation JSON, report and handoff. On success mark C03 `MACHINE_VALIDATED_FOR_GPT_REVIEW`; on exhaustion mark `BLOCKED_RETRY_EXHAUSTED` and `CUT_OR_REPLACE_AT_PHASE_1_CHECKPOINT`. S03 remains closed pending GPT.

Require one retained level/test+UID on success or none on blocker; zero schema/Simulation/solver/Aggregate/existing-level/catalog/Profile/scenes/gameplay changes; DeepSeek not invoked; catalog 8; finale 8; Godot zero.

Commit exactly once:

```text
feat: reconcile and retry Phase-1 C03 delayed door
```

Push, verify synchronized clean state, only `.codex/config.toml` untracked, Godot zero. No second implementation commit.

## 12. Required final fields

```text
candidate_slot = C03
level_id = phase_1_c03_crate_delayed_door
topology_families_used = <0-3>
candidate_variants_used = <0-6>
solver_status = SOLVED / UNSOLVED / LIMIT_REACHED / NOT_RUN
shortest_solution_length = <exact or NOT_VERIFIED>
shortest_solution_count = <exact or NOT_VERIFIED>
revised_all_shortest_full_mask = <exact>/<exact> / NOT_VERIFIED
revised_all_shortest_omissions = <exact or NOT_VERIFIED>
strict_plate_to_cross_turn_separation = YES / NO / NOT_VERIFIED
same_turn_blocked_door_diagnostic = PASS / FAIL / NOT_VERIFIED
no_push_control = COMPLETE_UNSOLVED / OTHER / NOT_VERIFIED
no_crate_control = COMPLETE_UNSOLVED / OTHER / NOT_VERIFIED
displaced_crate_control = <exact or NOT_VERIFIED>
prepositioned_crate_control = <exact or NOT_VERIFIED>
static_wall_control = <exact or NOT_VERIFIED>
no_echo_control = COMPLETE_UNSOLVED / OTHER / NOT_VERIFIED
timing_bypass_control = <exact or NOT_VERIFIED>
replay_deterministic = YES / NO / NOT_VERIFIED
restart_exact = YES / NO / NOT_VERIFIED
canonical_crate_identity = PASS / FAIL / NOT_VERIFIED
presentation_status = MACHINE_CONTRACT_READY_OWNER_REVIEW_PENDING / NOT_REACHED
production_catalog_modified = NO / YES
formal_finale_modified = NO / YES
Profile_accessed = NO / YES
next_task_authorized = NO
final_task_verdict = PASS_FOR_GPT_REVIEW / BLOCKED_RETRY_EXHAUSTED / BLOCKED / UNVERIFIED
```

Only GPT adjudication may open S03/0024AZ. If retry exhausts, GPT may cut C03 or select a replacement at the Phase-1 checkpoint.