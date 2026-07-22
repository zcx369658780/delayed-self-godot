# Task 0024AA sequence-11 identity-shift bridge machine-validation report

- Terminal verdict: `BLOCKED_SEQUENCE_11_IDENTITY_SHIFT_BRIDGE_VALIDATION`
- Candidate: `identity_shift_bridge / Identity-Shift Bridge / 身份错拍桥`
- Classification: uncatalogued future sequence-11 core candidate
- Risk envelope: `FROZEN_FALLBACK`
- Baseline commit: `94791d70693093fb365ecfad3cae45213d9b871b`
- Godot: `4.7.1.stable.steam.a13da4feb`
- Accepted wrapper blob: `5f14eb0feff903b40311c1c7283b20e2eabbffc2`

## Outcome

The candidate and its focused validator technically passed every puzzle, control, all-shortest, regression and process check. The unique retained five-case cycle also passed all five native executions. The task is nevertheless blocked because the retained focused-case compact result and control lines were each cut at the accepted wrapper's 2048-character per-line bound. The exact `solver.elapsed_ms` field fell beyond that bound and is absent from every retained artifact. Task 0024AA requires that exact value to be recorded, and the final cycle is already consumed, so no rerun or replacement capture is permitted.

This is an evidence-retention blocker, not a claim that the candidate failed mechanically. It is not `READY_FOR_GPT_REVIEW`, not catalog admission and not owner acceptance.

## Candidate and solver facts

The final candidate is schema v2, 11×7, with one delay-2 `echo_identity`, `sensor_you` (`YOU_ONLY`), `sensor_echo` (`ECHO_ONLY`), explicit `include_crates=false` on both sensors, and one initially closed `bridge_identity` group at `[4,1]` and `[5,1]`. The group depends only on the two sensors. Plates, Doors, crates, keys, locks and latches are empty. EXIT is `[9,3]` and completion remains player-only through shared Simulation.

Retained exact solver facts are:

- status `SOLVED`;
- `L*=18`;
- exact `N*=1`;
- visited states `1002`;
- maximum frontier `130`;
- witness `RIGHT RIGHT UP UP LEFT LEFT UP UP RIGHT RIGHT RIGHT RIGHT RIGHT RIGHT RIGHT RIGHT DOWN DOWN`;
- waits `0`, blocked YOU actions `0`, longest repeated identical blocked macro `0`.

Candidate SHA-256 is `8856d3c64978cef7cff7f1680a7ae2f412c9b0cab058d598cbe3aee0225052e0`. The focused validator SHA-256 is `bff20626fb4830f4a8fed2e3b7f4b485a172d443db358978d1d1eeafeebc5a82`.

## Ordered and all-shortest proof

The retained event trace proves:

1. action 10 ends with YOU at `sensor_you`, ECHO at `sensor_echo`, both exact sensor IDs pressed, bridge open in the result, and neither actor on a bridge cell;
2. action 11 starts from the open snapshot and moves YOU into `[4,1]`; both sensors release, close is requested, and closure is classified `OCCUPIED_CELL_DEFERRED`;
3. action 12 moves YOU into `[5,1]` and retains the same occupied-close deferral;
4. action 13 moves YOU to `[6,1]`, clears group occupancy and closes the bridge;
5. action 18 places YOU at EXIT and completes.

The instrumented shared-`Simulation.transition` search completed at depth 18 with 1 completed path, 1 full-mask path (`31`), 0 omissions, 1 path crossing both bridge cells and 1707 composite states. Thus every shortest solution contains typed-pair activation, next-snapshot entry, occupied closure deferral, post-vacancy closure and the two-cell crossing.

Replay twice was identical with 19 canonical keys. Restart reconstructed the exact initial state. Canonical keys distinguished barrier open/closed state, actor positions and history.

## Necessity controls and shortcuts

- No ECHO: schema-valid, complete finite-state unsolved, 14 states, frontier 2.
- Swapped identity: schema-valid, complete finite-state unsolved, 710 states, frontier 130.
- YOU-sensor `ANY_ACTOR`: remains `18/1`, but eligibility changes from `{YOU}` to `{YOU,ECHO}` and the exact typed-identity necessity chain is eliminated.
- ECHO-sensor `ANY_ACTOR`: remains `18/1`, but eligibility changes from `{ECHO}` to `{YOU,ECHO}` and the exact typed-identity necessity chain is eliminated.
- One-cell group: solves at `14/1`, 949 states, frontier 185; it materially changes metrics and removes the two-cell entry/deferral/vacancy chain.
- No-deferral restricted search: rejects the one critical deferral transition and completely exhausts unsolved at 710 states, frontier 130.

Direct probes also passed wrong-actor exclusion, explicit no-crate eligibility, same-result closed-cell blocking, next-open-snapshot entry, deferral on both group cells, closure after vacancy, terrain articulation, no direct EXIT bypass, ECHO-on-EXIT noncompletion, blocked-macro limit and zero-residue restart.

## Authoring history

Seven authoring probes ran before the final cycle. Each used the accepted wrapper, invoked cleanup exactly once and ended with no owned/unproven PID and total Godot zero.

- Probe 1 established the initial `18/1` event route.
- Probe 2 showed that a serial two-cell corridor made the one-cell control retain `18/1`; that geometry was discarded.
- Probe 3 failed public loading because an experimental EXIT overlapped the ECHO spawn; no solver ran.
- Probe 4 exposed a 10-turn direct EXIT bypass; no-ECHO and no-deferral also solved, so that geometry was discarded.
- Probe 5 established the final 11×7 topology: baseline `18/1`, one-cell `14/1`, swapped/no-ECHO/no-deferral complete unsolved.
- Probes 6 and 7 passed the complete focused validator; probe 7 added explicit ANY-control eligibility evidence.

Historical authoring failures remain preserved as failures and were not relabeled as accepted evidence.

## Unique final qualification cycle

The retained cycle is consumed and must never be rerun under Task 0024AA.

| Case | Result | stderr | cleanup | PID residue |
|---|---|---|---:|---|
| focused 0024AA | native 0, marker PASS | empty | 1 | owned 0 / unproven 0 |
| focused 0024Z | native 0, marker PASS | empty | 1 | owned 0 / unproven 0 |
| focused 0024Y | native 0, marker PASS | empty | 1 | owned 0 / unproven 0 |
| Aggregate | native 0, exact `621 assertions / 9 vectors` marker | exactly `LEVEL_ID_MISMATCH` | 1 | owned 0 / unproven 0 |
| complete v2 | native 0, marker PASS | empty | 1 | owned 0 / unproven 0 |

Final Godot process count was zero. Case records and SHA-256 values are bound in the machine-readable summary. The focused case retained its marker and six complete event records, but its two compact JSON lines are exactly 2048 characters and syntactically truncated. No stream was reconstructed or replaced.

## Frozen audit

The pre-task audit passed against seal SHA-256 `0e288adfe29c5881ab1f8cf40adf2df842a6fbbb8c6e5bce7aa14c797cf67ec0`:

- 53 sealed repository files, 0 mismatches;
- 12 historical external evidence files, 0 mismatches;
- 33 explicit frozen paths, 0 HEAD blob mismatches;
- accepted sequence-9/10 artifacts, 0 mismatches;
- accepted wrapper blob exact.

Profile, test-profile and ordinary user-data surfaces were not accessed.

## Changed-path hash inventory

SHA-256 values below were computed after terminal documentation was finalized. This report's own hash is intentionally not embedded recursively and is reported from Git after commit.

```text
data/levels/identity_shift_bridge.json  8856d3c64978cef7cff7f1680a7ae2f412c9b0cab058d598cbe3aee0225052e0
tests/levels/task_0024aa_identity_shift_bridge_validation.gd  bff20626fb4830f4a8fed2e3b7f4b485a172d443db358978d1d1eeafeebc5a82
tests/tools/task_0024aa_frozen_hash_audit.ps1  d1ea451b30a96413abb4528cf8bd4aa3dcf785adff0b86cc09cecf553ca520ac
tests/tools/task_0024aa_pre_task_frozen_hash_audit.json  962bdaf6dc3138622ee0b34fb2264370286eaa492e3a59d0597b1fe46130dbbf
tests/tools/task_0024aa_run_case.ps1  f2d962eb2c1ac22eeacd48db21ae55a1499bf494fd70a344ab6ed6b5f4da28f2
tests/tools/task_0024aa_authoring_probe_01.json  679136e26ca1d5933ec3966369e79af04408771e914b09876f3cf44ce9983eb9
tests/tools/task_0024aa_authoring_probe_02.json  f0bb9b42b72fc4483bb238e5a16c28e8b14536222c4e7e6048042883d2ab0929
tests/tools/task_0024aa_authoring_probe_03.json  78e6f98b3e6483aaf821b59119a7aad202707179808fe646559a2f7b663df9c6
tests/tools/task_0024aa_authoring_probe_04.json  bf1077fefd5e906a9452ce24dab3c211b09bc219bb57150b9b94b6407a83c514
tests/tools/task_0024aa_authoring_probe_05.json  5f4bb4e4af904c7c0b5780e398c8f741c8b6241538813cfdff2d01ddd508c934
tests/tools/task_0024aa_authoring_probe_06.json  bbf91d55c844d506ce873b9c848bdd406654972c058ec5db2989a6e32f568bfd
tests/tools/task_0024aa_authoring_probe_07.json  03f0d4fa36daa91fcc0acd332ca490d7715ba3aa28a895061ef7b192b5c8bcd5
tests/tools/task_0024aa_final_case_01_identity_shift_bridge.json  d2adf20c8863e16927c0ae0b7494210ae1b2e6fc3db11c7ff0093b763e61438a
tests/tools/task_0024aa_final_case_02_sequence_10.json  67ccd00a40f16fac3ad8eba5bea937ef1e021c2087cf1c37bcca75fb1f859cfd
tests/tools/task_0024aa_final_case_03_sequence_09.json  c17a153a68adaf5826bd68385a9b7b44594dca32b4657479f744d925151b2056
tests/tools/task_0024aa_final_case_04_aggregate.json  8402696b83a6e05cc2f64d9a0b0a33639724e176a23eb50cb48a11bcd1fc27ff
tests/tools/task_0024aa_final_case_05_v2_complete.json  4e08635a6d808a477cd64909254a9ddd8c3517362a9a5c109a68c36686ea33f6
docs/level_design/validation/sequence_11_identity_shift_bridge_validation.json  b2dc166172cc45d16ab79896df998cd0b976bc9f8258207c7e96fba5e34afe0e
docs/CODEX_ACTIVE_TASK_CURRENT.md  0b71dfa510ea5125d8c166e0b319d65407c2bef5421b2f159d712feb2bba15b6
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md  55292cf3679a2ecfc544a8349d1a856149fbbae8b5c26a877b41fc469979a3a0
docs/DEVELOPMENT_PLAN_CURRENT.md  8b5e945c119613cd0b15dda0638a1a4470ec23483deed8770f5f1ac31ccb1edf
docs/DOC_INDEX_CURRENT.md  193535ac6c33d2dd25db46078a4f7c5d33cfd17dce001a751b26c8933df4c516
docs/HANDOFF_MASTER_CURRENT.md  903f389fa8e2e9bcfcc21616c8e7e80239da7b644a69da2e491b666ca9036b7b
docs/project_memory.md  c4ac2b2ef770514a036b0cb0e33a65f36ebf3fb7fc9f89c6a63f5eae4cdf9c72
docs/production/EXPANDED_CONTENT_SUBMISSION_ROADMAP_CURRENT.md  5c239ab4d096d105ae606a8153fead2661b878f7125c0dabb5a35d84dc19e3a0
```

## Evidence blocker and boundaries

The exact elapsed time cannot be recovered from the retained evidence without another Godot execution. The final cycle declaration makes such a rerun unauthorized. The correct disposition is therefore the blocker, while preserving all actual PASS streams and the missing-field fact.

The candidate remains uncatalogued. Owner playthrough is `PENDING_LATER_CURRICULUM_GATE`; catalog admission is `NOT_AUTHORIZED`. Sequence 12, catalog/finale/Profile, Gameplay/UI, localization, assets/fonts/audio, build/export, release, upload and submission remain closed.

`BLOCKED_SEQUENCE_11_IDENTITY_SHIFT_BRIDGE_VALIDATION`
