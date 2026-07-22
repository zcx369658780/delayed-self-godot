# Task 0024X — Finalize the submission-core scope and curriculum for levels 9–12

- Status: `READY`
- Gate: `PRODUCT SCOPE FINALIZATION / DOCS ONLY / NO CONTENT IMPLEMENTATION`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Required accepted checkpoint: `328d1d87be7dbb4da513961abe0edc3d0cb67f00`
- Accepted foundation verdict: `TASK_0024W_COMPLETE_CORE_MECHANICS_FOUNDATION_ACCEPTED`
- Accepted foundation commit: `7072566ef814f6969693bbc9335fcced5e424585`
- Accepted seal SHA-256: `0e288adfe29c5881ab1f8cf40adf2df842a6fbbb8c6e5bce7aa14c797cf67ec0`
- Implemented product baseline: exactly eight formal levels
- Recommended Codex model: `GPT-5.6 Sol Max`; fallback `GPT-5.6 Sol High`

## 1. Objective

Produce the binding planning package for the four submission-core rooms that may later append as sequences 9–12.

This task must freeze:

1. one exact design brief for each future sequence 9, 10, 11 and 12;
2. the mechanic curriculum and dependency order across those rooms;
3. solver, replay, necessity-control and difficulty-evidence requirements for each room;
4. the no-shortcut and restart/canonical-state expectations for formal admission;
5. the future catalog, progression, finale and Profile compatibility contract;
6. the cut policy if a room or mechanic family cannot meet the schedule;
7. the separately gated implementation sequence after this planning task.

This is planning only. Do not create or modify formal level JSON, catalog entries, Profile code/data, Gameplay/UI, scenes, localization, assets, audio, project settings, build/export or release surfaces.

## 2. Binding accepted foundation

Task 0024W is GPT accepted as the complete validation gate for the corrected schema-v2 / shared Simulation / BFS foundation.

Accepted mechanics available for planning are:

- YOU-only push crates;
- YOU-only consumable keys and matching locks;
- typed sensors: `ANY_ACTOR`, `YOU_ONLY`, `ECHO_ONLY`, with explicit crate eligibility;
- grouped multi-cell barriers / bridges;
- one-shot room-local latches;
- shared deterministic restart, canonical-state and BFS/replay behavior.

Do not reopen, rerun or modify Task 0024W sealed artifacts, tests, driver, evidence or accepted implementation.

## 3. Binding product and sequence policy

Preserve without exception:

- existing level IDs and sequences 1–8;
- existing progression among sequences 1–8;
- `two_echo_convergence` remains sequence 8;
- sequence 8 remains the current sole formal finale until a later catalog/Profile integration gate;
- future rooms append only as sequences 9–12;
- future level 9 unlocks only after completion of the stable sequence-8 room;
- existing completed IDs, best-turn records, settings and language values must remain preserved;
- existing Profiles must never be silently reset, rewritten or assigned a new language;
- new-profile default `zh-Hans` remains a later compatibility/default-activation gate;
- a future sequence-12 room may be proposed as the finale candidate, but this task must not move the final flag or claim that it is already the formal finale.

The submission-core target is twelve levels. Levels 13–14 and paired portals, one-way gates, fragile floors and conveyors remain stretch scope and must not appear in the sequence 9–12 core briefs.

## 4. Required read-only audit

Before drafting the scope package, read and reconcile at least:

- `AGENTS.md`;
- `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`;
- `docs/CODEX_ACTIVE_TASK_CURRENT.md`;
- this full task;
- `docs/reports/0024W_GPT_COMPLETE_CORE_MECHANICS_FOUNDATION_ACCEPTANCE.md`;
- `docs/production/EXPANDED_CONTENT_SUBMISSION_ROADMAP_CURRENT.md`;
- `docs/reports/0023ZW_GPT_GAMEPLAY_PRESENTATION_ROADMAP_REBASELINE_ACCEPTANCE.md`;
- current gameplay/simulation and level-schema contracts;
- the current catalog and all eight formal level JSON files;
- existing level-validation reports and accepted solver metrics for sequences 1–8;
- the five accepted schema-v2 fixtures and complete-v2 coverage list.

The audit must summarize:

- what each existing sequence 1–8 teaches or combines;
- where the current difficulty curve rises or repeats;
- which accepted v2 mechanics are not yet taught in formal content;
- which combinations would duplicate an existing room rather than add a new reasoning structure;
- which future room should be the strongest submission capstone without depending on stretch mechanics.

Read-only JSON/Python/PowerShell inspection is allowed. Do not launch Godot or the owned wrapper; no runtime validation is necessary in this planning gate. Do not access production Profile content/metadata/siblings, ordinary user data or the test-profile root.

## 5. Binding curriculum skeleton

The final package must use the following sequence responsibilities unless the read-only audit proves a direct contradiction. Any departure must be narrowly justified in the report and remain within the same five accepted mechanic families.

### Sequence 9 — crate teaching room

Primary family:

- YOU-only push crates.

Required learning facts:

- YOU can push a crate by one legal cell;
- ECHOs never replay a crate push;
- a crate can block an ECHO path or participate in a sensor state;
- the solution requires deliberate coordination between a persistent crate position and delayed ECHO movement.

The room must not be a generic Sokoban puzzle. It should introduce one crate-dependent temporal decision and remain the easiest of sequences 9–12.

### Sequence 10 — key/lock routing room

Primary family:

- YOU-only consumable key and matching lock.

Required learning facts:

- only YOU collects the key;
- the matching lock consumes the key on the same accepted turn;
- an ECHO cannot collect or spend the key;
- the irreversible route choice must interact with delayed movement rather than merely lengthen the path.

Avoid multiple key colors unless the audit proves they are needed. Submission-core scope should prefer one clearly readable key type.

### Sequence 11 — typed sensor and grouped-barrier room

Primary families:

- typed occupancy sensors;
- grouped multi-cell barrier / bridge.

Required learning facts:

- at least two actor-eligibility modes must matter to the solution;
- crate eligibility must be explicit and visible in the design brief;
- grouped barrier state changes apply on the next-turn doctrine;
- occupied-cell closure deferral or a comparable grouped-barrier timing consequence must be necessary, not decorative.

The room must test actor identity and timing, not only simultaneous occupancy cardinality.

### Sequence 12 — latch synthesis and finale candidate

Primary family:

- one-shot room-local latch.

Secondary scope:

- combine only previously taught accepted mechanics;
- use at most three mechanic families in the critical solution chain;
- no stretch mechanic and no new rule may debut here.

Required learning facts:

- a latch permanently changes a room-local barrier state until restart;
- restart reconstructs all mutable room state;
- the solution requires a staged plan across at least two temporal phases;
- the room works as a submission capstone and finale candidate while remaining solvable and explainable.

This task may label sequence 12 `FINALE_CANDIDATE_ONLY`. It must not label it the formal finale, edit the existing sequence-8 final flag or authorize Profile/catalog migration.

## 6. Required design brief fields

For each sequence 9–12, freeze:

- proposed stable `level_id`;
- Simplified-Chinese player-facing title and concise English working title;
- sequence number;
- classification (`core`, with sequence 12 additionally `FINALE_CANDIDATE_ONLY`);
- unlock predecessor policy;
- primary and secondary mechanic families;
- exact teaching objective;
- exact required temporal insight;
- allowed entity cardinality ranges;
- prohibited mechanics and complexity limits;
- target room footprint range;
- target shortest-turn band stated as a planning range, derived relative to accepted sequences 6–8 rather than invented without comparison;
- target shortest-solution-count posture (`many`, `moderate`, or `narrow`) with rationale;
- maximum intended search depth/state/time budget for future validation;
- mandatory solver witness and shared-Simulation replay requirement;
- mandatory restart/canonical-state requirement;
- required necessity-control variants;
- expected shortcut probes;
- player-facing failure feedback requirement;
- tutorialization and HUD/presentation notes without asset implementation;
- admission criteria and hard-cut fallback.

Do not create ASCII maps or formal JSON in this task unless used only as clearly non-authoritative explanatory sketches inside the planning document. No sketch may be presented as a validated or accepted level.

## 7. Necessity-control requirements

The package must define future controlled variants that prove the intended mechanic is necessary.

At minimum:

- sequence 9: a no-push or displaced-crate control must fail or materially lose the intended solution chain;
- sequence 10: a no-key/no-lock or ECHO-item control must prove player-only item behavior is necessary;
- sequence 11: actor-type substitutions and barrier-timing controls must distinguish the required sensor identities and next-turn grouped-barrier behavior;
- sequence 12: a latch-disabled/reset control must prove the irreversible phase transition is necessary.

The future implementation task must run these controls through the same loader, Simulation and solver. AI-authored candidate solutions are not evidence until replayed.

## 8. Difficulty and quality doctrine

The planning package must preserve a readable curriculum:

- sequence 9 is an introduction to persistent object state;
- sequence 10 adds irreversible inventory routing;
- sequence 11 increases actor-identity and timing complexity;
- sequence 12 synthesizes prior mechanics without introducing a new rule.

Difficulty must not be justified only by shortest-turn length. Include expected reasoning burden, dead-end readability, number of irreversible decisions, required waits, ECHO participation and dependency-chain depth.

Every future formal room must eventually record:

- solvable status;
- shortest turn count;
- shortest solution count or bounded status;
- one machine-replayed witness;
- mechanism-necessity controls;
- shortcut audit;
- exact restart;
- owner/manual playthrough status.

## 9. Future catalog and Profile compatibility contract

Freeze a no-write compatibility plan only. It must state:

- sequences 1–8 and their IDs remain byte/semantic stable unless an unrelated accepted defect task exists;
- level 9 future prerequisite is sequence-8 completion;
- levels 10–12 form a linear submission-core continuation unless the audit demonstrates a safer deterministic dependency structure;
- sequence 12 final-flag promotion is deferred to a later catalog/Profile integration gate;
- existing completion and best-turn records remain valid;
- new level IDs append without renaming historical IDs;
- existing unlocked/completed snapshots must not be recomputed destructively;
- no Profile read/write, migration, reset or default-language activation occurs in this task;
- future migration tests must use isolated synthetic/test profiles and preserve existing language/settings.

## 10. Cut policy

Freeze the following cut order:

1. remove optional secondary combinations from a room;
2. simplify entity cardinality and room footprint;
3. remove the weakest accepted family from a combined critical chain while retaining its earlier dedicated teaching room where possible;
4. freeze at fewer than twelve levels only if a later GPT gate formally accepts the schedule/stability cut;
5. do not activate levels 13–14 or stretch mechanics to replace a failed core room;
6. never weaken solver/replay/restart evidence or Profile protections to preserve content count.

The package must identify the weakest or highest-risk sequence 9–12 concept and its pre-agreed fallback design.

## 11. Required outputs

Create:

```text
docs/level_design/SUBMISSION_CORE_LEVELS_9_12_SCOPE_CURRENT.md
docs/reports/0024X_SUBMISSION_CORE_LEVELS_9_12_SCOPE_FINALIZATION_REPORT.md
```

Update only as needed:

```text
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/production/EXPANDED_CONTENT_SUBMISSION_ROADMAP_CURRENT.md
```

The scope document must be durable and answer-first. The report must identify all sources read, decisions frozen, unresolved items, deviations from the binding skeleton, protected surfaces confirmed untouched, and the proposed sequence of later implementation tasks.

## 12. Protected surfaces

Do not modify:

```text
AGENTS.md
project.godot
schemas/**
scripts/**
scenes/**
tests/**
data/catalog/**
data/levels/**
assets/**
audio/**
shaders/**
**/*.uid
```

Do not create external evidence roots, seals, attempt records or build outputs. Do not access Profile/user-data surfaces.

Historical Task 0024T/0024U/0024V/0024W artifacts, reports and external evidence remain immutable.

## 13. Commit and push policy

After the documents are internally consistent:

1. verify only authorized documentation paths changed;
2. explicitly stage only authorized files;
3. run `git diff --cached --check` and inspect staged paths;
4. create one single-topic commit;
5. do not amend, rebase or squash;
6. fetch before push and stop on remote drift;
7. push only a clean fast-forward to `origin/main`;
8. require post-push `HEAD == origin/main`, divergence `0/0` and clean worktree.

Suggested commit:

```text
docs: finalize submission core levels 9-12 scope
```

## 14. Terminal verdict

Return exactly one:

```text
SUBMISSION_CORE_LEVELS_9_12_SCOPE_READY_FOR_GPT_REVIEW
BLOCKED_SUBMISSION_CORE_LEVELS_9_12_SCOPE_FINALIZATION
PROTECTED_DATA_BOUNDARY_BREACH
```

A pass accepts only the planning package for GPT review. It does not authorize formal level JSON, catalog/Profile changes, Gameplay/UI integration, localization, fonts/audio/assets, build/export, release, upload or submission. A later GPT decision must authorize the first implementation gate.
