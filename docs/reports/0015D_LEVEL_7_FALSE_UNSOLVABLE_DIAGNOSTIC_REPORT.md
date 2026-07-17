# Task 0015D Level 7 false-unsolvable diagnostic report

- Task: `tasks/0015D_level_7_false_unsolvable_diagnostic_and_repair_planning.md`
- Start checkpoint: `HEAD == origin/main == de6e531cd911b774feb97358b06f32dbe6a03c26`
- Branch/root: `main` / `D:\Delayed_Self`
- Origin: `https://github.com/zcx369658780/delayed-self-godot.git`
- Accepted implementation: `27a678da47d1ba34ed012f8840b8c80c775e8be1`
- Classification: `BLOCKING_P2_FALSE_UNSOLVABLE_MENTAL_MODEL_AND_RECOVERY_FAILURE`
- Selected primary bundle: `TRANSITION_DERIVED_ECHO_DIVERGENCE_FEEDBACK`
- Terminal verdict: `LEVEL_7_FALSE_UNSOLVABLE_REPAIR_PLAN_READY_FOR_GPT_REVIEW`

## Startup and baseline

Live startup checks confirmed the exact repository root, `main`, expected `origin`, clean tracked/untracked state, and synchronized local/remote checkpoint. The accepted executable is:

```text
D:\Program Files (x86)\Steam\steamapps\common\Godot Engine\godot.windows.opt.tools.64.exe
Godot 4.7.stable.steam.5b4e0cb0f
```

Startup commands included `Get-Location`, `git branch --show-current`, `git rev-parse HEAD`, `git rev-parse origin/main`, `git remote -v`, `git status --short --untracked-files=all`, `git log -36 --oneline --decorate`, the accepted executable's `--version`, and `Get-Command` inspection.

Post-Task-0015 repository changes were verified as task/documentation-only. The complete Task 0015V aggregate evidence index was readable and its recorded stdout/stderr hashes were verified. The fresh aggregate was therefore reused as authorized:

- native exit 0;
- 367 assertions / 9 vectors;
- all nine accepted markers exactly once;
- only expected negative-path `LEVEL_ID_MISMATCH` stderr;
- Level 7 `L*=19`, `N*=6 EXACT`, visited 61,975, frontier 21,449;
- seven formal hashes unchanged, including Level 7 SHA-256 `772410d3b8bb807e35472ee2a7d07b703de66e1e0e92ffb4d1ff8433a345d5fd`.

No baseline contradiction required reopening machine correctness.

| Formal level | SHA-256 |
|---|---|
| `tutorial_reach_exit` | `38e466bb5922f1987a99d79c7527a4a8eab8e6cfdbe76fd8159f80b0a40cf2c4` |
| `tutorial_echo_bridge` | `681d99057c4e6034a490644d75960ff23d8f43bd1b91850f48179b79fc04a3cf` |
| `vertical_slice_delay_3` | `8751da5051fbebaaa5ae7c895d9be9f086e8d8f2e87876a80c379dc06262f1d8` |
| `door_one_turn_late` | `1775cf89ae4a94f65a76dac2b791a31395443de88205d0ed1b6233331dbda577` |
| `two_keys_one_door` | `f4c6791dfc84d17fb450721e654091a2baeb522e55d660a5d73878cd977651cd` |
| `staggered_doors` | `3f14c19b50775e36dd5b52664798381cf1292b0a30b377641c03435f45696bc8` |
| `two_echo_convergence` | `772410d3b8bb807e35472ee2a7d07b703de66e1e0e92ffb4d1ff8433a345d5fd` |

## Evidence and diagnostic loop

Authorized external root:

```text
D:\Delayed_Self_Evidence\0015D_level_7_false_unsolvable_diagnostic\
```

The external `diagnose_spacing.gd` is labeled `DIAGNOSTIC_ONLY_NOT_FORMAL`. It reads the accepted formal Level 7 and shared Simulation, records every selected-witness transition, reconstructs the owner screenshot state, and runs bounded recovery BFS from two failed prefixes. It writes no repository or product state.

Command:

```text
godot.exe --headless --path D:\Delayed_Self --script D:\Delayed_Self_Evidence\0015D_level_7_false_unsolvable_diagnostic\diagnose_spacing.gd
```

The first invocation exited 1 because two external-script variables needed explicit `int` annotations. Its stdout/stderr were retained. The corrected invocation exited 0, wrote zero-byte stderr, and ended `DIAGNOSTIC_SPACING_PASS`.

Final external artifact hashes:

| File | Bytes | SHA-256 |
|---|---:|---|
| `diagnose_spacing.gd` | 9,326 | `4c3490e9203eb93512e51f451e4e7bafea0e6ebe368f729d299370c526d9fbe5` |
| `diagnostic_attempt1_stdout.txt` | 70 | `77f7004f5966d6932528a84a0f50fe7aee0048357eaf9d6c1ede9ca6df847cb8` |
| `diagnostic_attempt1_stderr.txt` | 675 | `0cf7d0aa7d7e6fe3c043f5f8425481e63d7b68881ece3feda6361a7722e3f07b` |
| `diagnostic_stdout.txt` | 13,489 | `40d9e04e4c8afd2e924c98a65e4eff9b8693e0ea807ac94cad557f46f1f298d1` |
| `diagnostic_stderr.txt` | 0 | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` |

`EVIDENCE_INDEX.md` contains timestamps and is excluded from its own manifest. No external artifact enters Git.

## Hypotheses and findings

| Rank | Falsifiable hypothesis | Result |
|---:|---|---|
| 1 | opening-lane motion makes the two-turn separation appear invariant, so early restarts reinforce impossibility | supported: `RIGHT×6` preserves `(2,0)` after both ECHOs activate |
| 2 | current board exposes local positions but not the causal spacing change/recoverable phase | supported: spacing changes repeatedly without a transition-derived cue |
| 3 | the owner screenshot represents a truly dead state | rejected: exact state reconstructed and solved with a 17-action minimum recovery |
| 4 | formal Level 7 or runtime/solver evidence is contradictory | rejected: accepted exact baseline remains healthy |
| 5 | actor/dependency identity is the primary blocker | not supported: owner correctly read E2/E4, A/B, and A+B |

The accepted 19-turn trace is recorded in [`LEVEL_7_FALSE_UNSOLVABLE_REPAIR_PLAN_CURRENT.md`](../level_design/LEVEL_7_FALSE_UNSOLVABLE_REPAIR_PLAN_CURRENT.md). Core observations:

- physical spacing first changes at turn 3 when E2 begins replay while E4 still waits;
- the apparent stable two-cell vector during turns 5–8 makes the owner's model plausible;
- turn 9 changes the signed vector because E2 replays UP while E4 replays RIGHT;
- turn 14 collapses Manhattan spacing `2→0`;
- turn 15 blocks E2 while E4 moves, changing `0→1`;
- turn 16 expands `1→3`;
- turn 17 places E2 on A and E4 on B;
- turn 18 crosses the Door from the open start snapshot; turn 19 reaches EXIT.

The witness contains no turn where both ECHOs replay the same non-WAIT action and settle differently. The accurate lesson is that different history offsets, prior positions, route choices, and blocking jointly change relative spacing.

## Failed-prefix results

| Prefix | State | Result |
|---|---|---|
| `RIGHT×6` | YOU (7,5), E2 (5,5), E4 (3,5), `Δ=(2,0)` | `SOLVED`; minimum recovery 13 actions; 40,639 BFS visits |
| `RIGHT×6,UP×2,LEFT,UP` | exact owner screenshot: YOU (6,2), E2 (7,3), E4 (7,5), history `[UP,UP,LEFT,UP]` | screenshot match found after 14,375 visits; `SOLVED`; minimum recovery 17 actions; 42,514 BFS visits |

These exact states are recoverable. Recovery lengths are diagnostic evidence only and are not proposed runtime hints.

## Candidate decision

Weighted totals:

| Direction | Score /5 | Decision |
|---|---:|---|
| A geometry-only early divergence | 3.55 | optional fallback |
| B state-derived divergence feedback | 4.65 | selected primary |
| C recoverability/progress feedback | 3.45 | rejected |
| D contextual Help text | 4.30 | not primary |
| D small causal diagram | 4.50 | possible later supplement |
| E structural simplifications | 1.75 | rejected for immediate repair |

The selected bundle preserves formal data and adds only a reusable transition-derived moved/blocked and spacing-change cue. It directly addresses the false model without solver hints, exact moves, route hardcoding, Timeline teaching, Help walkthroughs, new mechanics, or Level 8 work.

One optional fallback is frozen: geometry-only early-divergence re-authoring, used only if the primary presentation repair fails the owner-only retest. It requires a new formal hash and the complete Task 0015 validation family.

## Repository outputs and scope audit

Created:

- `docs/level_design/LEVEL_7_FALSE_UNSOLVABLE_REPAIR_PLAN_CURRENT.md`
- `docs/reports/0015D_LEVEL_7_FALSE_UNSOLVABLE_DIAGNOSTIC_REPORT.md`

Updated only the necessary current Markdown navigation, gate, roadmap, memory, and presentation sources.

- `docs/CODEX_ACTIVE_TASK_CURRENT.md`
- `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`
- `docs/DOC_INDEX_CURRENT.md`
- `docs/DEVELOPMENT_PLAN_CURRENT.md`
- `docs/HANDOFF_MASTER_CURRENT.md`
- `docs/project_memory.md`
- `docs/level_design/INITIAL_LEVEL_ROADMAP_AND_VALIDATION_MATRIX_CURRENT.md`
- `docs/level_design/FIVE_LEVEL_DIFFICULTY_RECOVERY_AND_LEVELS_6_8_PLAN.md`
- `docs/ux/PRESENTATION_VIEWPORT_AND_HUD_DIRECTION_CURRENT.md`

No product implementation, level JSON, catalog, schema, simulation, solver, Gameplay, scene, test, fixture, project setting, Timeline model, Help code, asset, import, save data, build, export, release, or Level 8 surface changed.

## Non-claims and recommendation

This is planning and diagnostic evidence, not a repair, final GPT acceptance, owner promotion, fresh/independent evidence, candidate/balance/fun proof, Level 8 authorization, or release authority.

Recommended next gate: GPT review followed by one bounded presentation-only implementation of `TRANSITION_DERIVED_ECHO_DIVERGENCE_FEEDBACK`, full unchanged-hash/machine regression, focused 960×540/grayscale capture tests, and an `AUTHENTICATED_OWNER_NOT_FRESH_NOT_INDEPENDENT_LEVEL_7_RETEST`.

```text
LEVEL_7_FALSE_UNSOLVABLE_REPAIR_PLAN_READY_FOR_GPT_REVIEW
```
