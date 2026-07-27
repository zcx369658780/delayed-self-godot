# Task 0024BAE — Repair gameplay entity visuals, event-specific audio feedback, and run one direct-WAV music trial

- Status: `READY`
- Gate: `OWNER-REQUIRED VISUAL REPAIR / AUDIO EVENT SEMANTICS / CONDITIONAL ORIGINAL-WAV MUSIC TRIAL / MULTI-SUBAGENT`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Required checkpoint in ancestry: `43082581e974332fb077550ce0a2aabdf78788b8`
- Previous accepted gate: `TASK_0024BAD_FIRST_SUBMISSION_VISUAL_AUDIO_VERTICAL_SLICE_ACCEPTED`
- Owner review: `OWNER_VISUAL_AUDIO_VERTICAL_SLICE_REVIEW = CHANGES_REQUIRED`
- Owner review source: `docs/reports/0024BAD_OWNER_VISUAL_AUDIO_VERTICAL_SLICE_REVIEW_ADJUDICATION.md`
- Submission scope: `STABLE_EIGHT_LEVELS`
- Production catalog: exactly eight levels
- Formal finale: sequence 8 `two_echo_convergence`
- S04 / Task 0024BB: `DEFER_S04_UNTIL_POST_SUBMISSION`
- Task type: bounded visual repair, SFX event expansion, completion-cue replacement, and one conditional direct-WAV music trial
- Font/zh-Hans rollout: `NOT_AUTHORIZED`
- Third-party graphic import: `NOT_AUTHORIZED`
- Profile, catalog, finale, levels, Simulation, solver, build, release and public submission: `NOT_AUTHORIZED`
- DeepSeek route: optional; not required; never counts as a GPT subagent

## 1. Objective

Task 0024BAE must preserve the accepted Task 0024BAD technical foundation while correcting the specific owner-facing defects.

Codex must:

1. replace the abstract/noisy wall rendering with a concrete connected wall language;
2. replace the grille-like door with a clear doorframe/door-leaf/open-passage language;
3. make YOU a concrete controllable-character silhouette;
4. make ECHO a related but unmistakably delayed/ghosted silhouette;
5. make the plate read as a floor pressure mechanism;
6. make EXIT read as a destination doorway/portal;
7. reduce nonsemantic floor/wall noise;
8. replace the item-pickup-like completion cue with an unmistakable completion cadence;
9. add a distinct wall-bump cue for legal recorded wall-facing turns;
10. add a distinct plate/mechanism activation cue;
11. add a distinct door-opening cue;
12. preserve movement, history, replay and turn semantics exactly;
13. perform one conditional trial of the owner-supplied original `优哉游哉(loop).wav` in Godot without modifying its bytes;
14. update license/attribution evidence when and only when the original file is verified;
15. generate real runtime captures for owner re-review;
16. run focused and complete regressions;
17. create exactly one implementation commit and push it;
18. return `PASS_FOR_GPT_REVIEW`, `BLOCKED`, or `UNVERIFIED`.

The music trial is conditional and non-blocking for the mandatory visual/audio repair. A source-download failure must fail closed for music while allowing the mandatory repair to complete honestly.

## 2. Frozen owner feedback

### 2.1 Visual

```text
wall = CHANGES_REQUIRED_ABSTRACT_AND_NOISY
door = CHANGES_REQUIRED_NOT_DOORLIKE
YOU = CHANGES_REQUIRED_MORE_CONCRETE
ECHO = CHANGES_REQUIRED_MORE_CONCRETE_AND_GHOSTED
plate = CHANGES_REQUIRED_FLOOR_MECHANISM
exit = CHANGES_REQUIRED_DESTINATION_DOORWAY
floor_decoration = REDUCE_NONSEMANTIC_NOISE
UI_shell = OUT_OF_SCOPE_FOR_THIS_REVIEW
```

### 2.2 Audio

```text
basic_movement = ACCEPTABLE
level_complete = REPLACE_WITH_CLEAR_SUCCESS_CADENCE
wall_facing_recorded_turn = DISTINCT_WALL_BUMP_REQUIRED
new_plate_activation = DISTINCT_MECHANISM_CUE_REQUIRED
door_closed_to_open = DISTINCT_DOOR_OPEN_CUE_REQUIRED
music = ONE_ORIGINAL_WAV_GODOT_TRIAL_AUTHORIZED
```

A cardinal input into a wall is a legal recorded turn. The cue must change; the Simulation contract must not.

## 3. Mandatory multi-subagent execution

Use at least five distinct configured GPT roles:

```text
planner_high
docs_reader
code_mapper
impl_worker
code_reviewer
```

A `docs_writer` role is recommended.

Required responsibilities:

- `planner_high`: freeze event priority, visual semantics, path ownership, run matrix and fallback;
- `docs_reader`: owner feedback, accepted contracts, music license and source facts;
- `code_mapper`: current draw code, transition outcomes, plate/door state seams, audio router and app-root music seam;
- `impl_worker`: exclusive bounded code/audio-generator implementation;
- `code_reviewer`: independent mechanics-preservation, audio-event, visual-readability, license and staged-path review;
- `docs_writer`: reports and current docs only when used.

The main agent exclusively owns interfaces, Godot/tests, optional network acquisition, integration, Git and verdict.

Subagents must not:

- commit or push;
- invoke DeepSeek;
- access Profile/player data;
- change Simulation/solver/levels/catalog;
- download external files;
- expand scope.

If fewer than three distinct usable GPT roles exist, return `BLOCKED_MULTI_SUBAGENT_UNAVAILABLE`.

## 4. DeepSeek boundary

DeepSeek is optional and not required.

If considered, first verify the accepted identities:

```text
wrapper =
f604001d001cd206e742e5252a69995c29f96c983e6520ec6fd0374ae4908750

worker aggregate =
7949540c811e530ea777d655b5c1882b71b45ab31640702eae8f2180d335cbe8

CLI =
d0596c70dd102b98a3ed77a02c99195ccff23f6d126fb400ff3c47c25a232a36
```

The only allowed delegation is one low-risk documentation edit to the new Task 0024BAE report draft. DeepSeek may not edit code, tests, scenes, assets, audio, license evidence, current pointers or task files.

Identity drift or wrapper failure blocks only optional delegation. No MCP/native fallback. Do not expose secrets.

## 5. Required reads

```text
AGENTS.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
tasks/0024BAE_owner_visual_entity_audio_feedback_and_music_trial_repair.md
docs/reports/0024BAD_GPT_FIRST_SUBMISSION_VISUAL_AUDIO_VERTICAL_SLICE_ACCEPTANCE.md
docs/reports/0024BAD_OWNER_VISUAL_AUDIO_VERTICAL_SLICE_REVIEW_ADJUDICATION.md
docs/reports/0024BAD_FIRST_SUBMISSION_VISUAL_AUDIO_VERTICAL_SLICE_REPORT.md
docs/presentation/SUBMISSION_VISUAL_AUDIO_VERTICAL_SLICE_CONTRACT_CURRENT.md
docs/presentation/SUBMISSION_VISUAL_STYLE_TOKEN_SPEC_CURRENT.md
docs/presentation/SUBMISSION_MINIMUM_VISUAL_ASSET_MANIFEST_CURRENT.json
docs/audio/SUBMISSION_MINIMUM_AUDIO_MANIFEST_CURRENT.json
docs/licenses/CROW_PRODUCER_MUSIC_LICENSE_EVIDENCE_CURRENT.md
docs/licenses/THIRD_PARTY_ASSET_LEDGER_CURRENT.md
docs/licenses/ATTRIBUTION_CURRENT.md
docs/audio/MUSIC_SOURCE_LICENSE_AND_AUDITION_PLAN_CURRENT.md
default_bus_layout.tres
scenes/app/app_root.tscn
scripts/app/app_root.gd
scenes/vertical_slice/vertical_slice.tscn
scripts/gameplay/vertical_slice.gd
scripts/presentation/submission_visual_theme.gd
scripts/audio/submission_sfx_router.gd
tools/audio/generate_submission_sfx.py
tests/presentation/task_0024bad_visual_contract.gd
tests/audio/task_0024bad_sfx_contract.gd
tests/tools/run_owned_godot_headless.ps1
data/catalog/level_catalog_v1.json
all eight cataloged level JSON files
scripts/simulation/simulation.gd
tests/run_all.gd
```

Read all current SFX hashes and Task 0024BAD captures before editing.

## 6. Visual repair contract

Keep the existing 960×540 viewport and 60-pixel logical cell.

Create no raster entity sprites. Use project-native deterministic drawing.

### 6.1 Connected wall

Replace per-cell fan/cross-hatch motifs with a connected mass.

Required semantics:

- adjacent wall cells visually merge;
- outer contour is dark and continuous;
- interior uses sparse brick/seam/crack marks only;
- no repeated fan, web, arch-window or radial motif;
- wall reads as solid and impassable in monochrome;
- wall marks remain subordinate to YOU/ECHO/Plate/Door/EXIT;
- adjacency may be represented by a deterministic four-neighbor bitmask;
- visual continuity must not alter collision or terrain data.

Expose a pure wall descriptor or adjacency snapshot for tests.

### 6.2 Floor

- remove most corner ticks;
- keep at most one subtle paper/grid registration mark per cell;
- floor must not compete with gameplay objects;
- keep exact cell bounds.

### 6.3 Door

Closed door:

- clear frame connected to wall/topology;
- one or two door leaves/panels;
- visible blocking crossbar/handle/hinge cue;
- not a grille, battery, hazard bar or collectible.

Open door:

- frame remains;
- center is visibly passable;
- leaf/panel is offset or absent;
- open state differs structurally without color.

### 6.4 YOU

Use a concrete top-down/person-like token:

- head/core;
- body/shoulder or directional wedge;
- stable facing indicator when available;
- solid outline;
- small `Y` remains secondary;
- readable at 960×540 and in monochrome.

Do not add gameplay facing state if none exists. A static forward marker is visual only and must not imply mechanics.

### 6.5 ECHO

Use the same family as YOU but clearly delayed:

- offset duplicate silhouette or ghosted double contour;
- broken/dashed outer line;
- short static ink-trail mark;
- `E2/E3/E4` secondary badge;
- silhouette remains distinct when color is ignored;
- overlap readability preserved.

### 6.6 Plate

Use a floor pressure-device structure:

- base plate inset into floor;
- raised/unpressed center;
- depressed/filled active center;
- optional mechanical notch or foot marker;
- A/B identity remains when required;
- activation state is not color-only.

### 6.7 EXIT

Use a destination doorway/portal:

- visible frame/arch/tab;
- inward/outward arrow or threshold;
- center passage distinct from collectible crystal;
- completion state may add a check/ink stamp;
- no color-only identity.

### 6.8 Visual test states and captures

Capture at least three real runtime PNGs under:

```text
docs/reviews/evidence/0024BAE/
```

Required states:

1. initial room with closed door, wall, YOU, ECHO, plate and EXIT visible;
2. plate active and door open;
3. a production level with two ECHOs or the sequence-8 finale state.

All captures:

```text
960×540
real Godot runtime
no mockup
no external graphic
SHA-256 recorded
```

## 7. Audio repair contract

Update the deterministic standard-library generator.

### 7.1 Replace completion cue

Regenerate:

```text
audio/sfx/gameplay/level_complete.wav
```

Required structure:

- clearly longer than movement/pickup cues;
- at least three sequential ascending or resolving tones;
- total duration target: 500–1000 ms;
- audible cadence with a clear ending;
- no random bytes;
- no sampled third-party material;
- deterministic output and recorded parameters.

Focused validation must inspect PCM timing/tone segments sufficiently to prove it is not the former short pickup-like cue.

### 7.2 Add wall bump

Create:

```text
audio/sfx/gameplay/wall_bump.wav
```

Event:

```text
wall_bump
```

Required:

- short physical impact;
- distinct from successful YOU movement and `blocked_or_invalid`;
- plays exactly once when a cardinal action is accepted as a turn but YOU position does not change due to wall/blocked terrain;
- the turn/history/action remains recorded;
- ECHO movement from the same turn may still play its own cue;
- no successful YOU movement cue for the blocked YOU action.

True transition errors may continue using `blocked_or_invalid`.

### 7.3 Add plate activation

Create:

```text
audio/sfx/gameplay/plate_activate.wav
```

Event:

```text
plate_activate
```

Required:

- button/mechanical press identity;
- plays when the pressed-plate set gains at least one plate ID;
- one event per turn, even when multiple plates newly activate;
- ordinary actor movement may remain, but plate feedback must be independently present and dominant enough to be audible;
- no event for unchanged pressed set;
- no event on release in this task.

### 7.4 Add door open

Create:

```text
audio/sfx/gameplay/door_open.wav
```

Event:

```text
door_open
```

Required:

- mechanical opening/slide identity;
- plays once when at least one production door changes closed→open;
- merge multiple same-turn door openings into one cue;
- no cue for unchanged/open→open;
- door-close cue remains future scope.

### 7.5 Event priority

For one transition:

```text
completion:
  suppress YOU_move
  play level_complete once

recorded wall-facing cardinal:
  play wall_bump
  do not play YOU_move

new plate activation:
  play plate_activate once

door closed→open:
  play door_open once

ECHO moved:
  ECHO_move may also play

successful ordinary YOU movement:
  YOU_move
```

If completion and another mechanism event occur in the same turn, completion remains the primary cue; mechanism cues may be suppressed to avoid clutter. Freeze and test one deterministic policy.

### 7.6 Event classifier

Prefer a pure/deterministic event-classification function based on:

```text
level
before state
after state
action
public Simulation helpers or accepted state fields
```

It must not:

- duplicate transition rules;
- mutate state;
- infer gameplay from presentation colors;
- access files/Profile/catalog;
- change history, turn order or completion.

Expose a machine-auditable ordered event list.

## 8. Conditional Crow Producer music trial

### 8.1 Exact source

Trial only:

```text
title = 优哉游哉(loop).wav
Drive file ID = 1_l8gcHescLwdhJ3X_8Xco48zYX96vRSO
public metadata size = 25,404,968 bytes
MIME = audio/wav
```

Public evidence:

```text
Drive root =
https://drive.google.com/drive/folders/1ce8LP87A2Yc1xRLvaCpZr13KI5S-f_Aw?usp=sharing

usage notice =
https://drive.google.com/file/d/1ID9Fy3Xmt7erOrORCblrEuGxMQsG1nhv/view
```

### 8.2 License boundary

Accepted source-supported terms:

```text
author/copyright = 乌鸦Producer
commercial game use = permitted
additional royalty = not required
attribution = 音乐由[乌鸦Producer]提供
exclusive use = no
direct resale of music = forbidden
modification = forbidden by notice
```

Therefore:

- original WAV bytes only;
- no trim;
- no normalization;
- no transcode;
- no remix;
- no fade baked into file;
- no sample extraction;
- no filename/title ownership claim;
- runtime volume and playback loop configuration may change without altering file bytes.

### 8.3 Acquisition

Network access is authorized only for the exact two Google Drive file IDs:

```text
music = 1_l8gcHescLwdhJ3X_8Xco48zYX96vRSO
usage notice = 1ID9Fy3Xmt7erOrORCblrEuGxMQsG1nhv
```

Use PowerShell or Python standard library only. Do not install `gdown`, requests or another dependency.

Download first to a task-specific temporary directory outside the repository.

Validate music:

```text
exact size = 25,404,968 bytes
RIFF/WAVE header
Godot AudioStreamWAV load succeeds
duration and channels recorded
SHA-256 recorded
source response is not HTML/interstitial
```

If validation passes, copy exact unchanged bytes to:

```text
audio/music/crow_producer/优哉游哉(loop).wav
```

Copy the exact usage-notice PNG to:

```text
docs/licenses/evidence/crow_producer/使用注意事项.png
```

Record both SHA-256 values and source IDs.

If acquisition/validation fails:

```text
music_trial_status = BLOCKED_SOURCE_RETRIEVAL_OR_IDENTITY
music_file_in_repo = NO
```

Do not attempt another track, mirror, conversion or unofficial source. Continue the mandatory visual/audio repair.

### 8.4 Runtime trial

If imported, create:

```text
scripts/audio/submission_music_controller.gd
scripts/audio/submission_music_controller.gd.uid
```

Integrate through:

```text
scenes/app/app_root.tscn
```

Do not modify `scripts/app/app_root.gd`.

Required:

- Music bus;
- low audition volume, target `-14 dB` to `-18 dB`;
- original source bytes unchanged;
- runtime/in-memory loop configuration only;
- no playback in headless mode;
- no duplicate music player across route changes;
- music continues safely across menu/gameplay route changes;
- no music is required for completion or gameplay timing;
- mute/silent fallback remains valid.

If the source cannot be imported, do not create a fake or generated music substitute.

## 9. Focused validation

Create:

```text
tests/presentation/task_0024bae_owner_visual_repair_validation.gd
tests/presentation/task_0024bae_owner_visual_repair_validation.gd.uid
tests/audio/task_0024bae_audio_feedback_and_music_trial_validation.gd
tests/audio/task_0024bae_audio_feedback_and_music_trial_validation.gd.uid
```

Marker:

```text
TASK_0024BAE_OWNER_VISUAL_AUDIO_REPAIR_PASS
TASK_0024BAE_OWNER_VISUAL_AUDIO_REPAIR_FAIL
```

### 9.1 Visual assertions

Prove:

- connected wall descriptors/adjacency are deterministic;
- no wall fan/web/radial signature remains;
- floor decoration density is reduced;
- wall reads structurally different from floor;
- closed/open door structures are distinct;
- YOU/ECHO monochrome signatures are distinct and more concrete;
- E2/E3/E4 labels remain;
- plate active/inactive structures are distinct;
- EXIT doorway structure exists;
- all required bounds stay in viewport;
- snapshots do not mutate state;
- restart restores exact visual snapshot;
- all eight production levels render/load.

### 9.2 Audio semantics assertions

Prove with real Simulation/public loader:

- ordinary move → `YOU_move`;
- legal wall-facing recorded turn:
  - transition accepted;
  - turn index increments;
  - history records the action;
  - YOU position unchanged;
  - event list includes `wall_bump`;
  - event list excludes `YOU_move`;
- new plate pressed → `plate_activate` exactly once;
- door closed→open → `door_open` exactly once;
- unchanged mechanism states emit neither cue;
- completion emits `level_complete` once and suppresses `YOU_move`;
- completion WAV has the new multi-segment success structure;
- ECHO movement remains independently represented;
- event classification is deterministic and state-pure;
- restart clears one-shot completion state.

### 9.3 Music assertions

When imported:

- repository music SHA equals temporary verified SHA;
- exact byte size is 25,404,968;
- RIFF/WAVE and Godot load pass;
- controller uses Music bus;
- one controller only;
- headless does not play;
- loop is configured in memory;
- source file remains byte-identical after Godot import;
- exact attribution exists in license/credits docs.

When blocked:

- music path absent;
- controller absent or disabled;
- Music bus remains safe/silent;
- mandatory repair tests still pass;
- report states exact blocker without overclaim.

## 10. Full regression

Run with the accepted owned Godot wrapper:

```text
Task 0024BAE focused visual
Task 0024BAE focused audio/music
Task 0024BAD focused visual
Task 0024BAD focused audio
current Aggregate
current complete-v2
app shell/menu/level-select regression
all eight production-level solver/replay regression
real runtime capture
```

Each Godot invocation:

- fresh process;
- unique run identity;
- bounded timeout;
- cleanup once;
- zero owned/unproven PID residue;
- final Godot count zero.

No historical retained manifest may be rerun. If current policy requires a new retained lifecycle, use a fresh Task 0024BAE identity only.

## 11. Documentation and evidence

Create:

```text
docs/presentation/OWNER_VISUAL_ENTITY_REPAIR_CONTRACT_CURRENT.md
docs/audio/OWNER_AUDIO_FEEDBACK_REPAIR_CONTRACT_CURRENT.md
docs/reports/0024BAE_OWNER_VISUAL_ENTITY_AUDIO_FEEDBACK_AND_MUSIC_TRIAL_REPORT.md
docs/handoffs/DELAYED_SELF_SESSION_HANDOFF_AFTER_TASK_0024BAE_OWNER_REPAIR_2026_07_27.md
```

Update:

```text
docs/presentation/SUBMISSION_MINIMUM_VISUAL_ASSET_MANIFEST_CURRENT.json
docs/audio/SUBMISSION_MINIMUM_AUDIO_MANIFEST_CURRENT.json
docs/licenses/CROW_PRODUCER_MUSIC_LICENSE_EVIDENCE_CURRENT.md
docs/licenses/THIRD_PARTY_ASSET_LEDGER_CURRENT.md
docs/licenses/ATTRIBUTION_CURRENT.md
docs/production/SUBMISSION_READINESS_SCORECARD_CURRENT.md
docs/production/GODOTHUB_FESTIVAL_2026_SUBMISSION_CRITICAL_PATH_CURRENT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
```

Evidence:

```text
docs/reviews/evidence/0024BAE/*.png
docs/licenses/evidence/crow_producer/使用注意事项.png only if exact source validation passes
```

Do not store download cookies, HTML interstitials, task temp files or network logs.

## 12. Authorized repository paths

Create/modify only:

```text
default_bus_layout.tres

scripts/presentation/submission_visual_theme.gd
scripts/gameplay/vertical_slice.gd
scenes/vertical_slice/vertical_slice.tscn

scripts/audio/submission_sfx_router.gd
tools/audio/generate_submission_sfx.py
audio/sfx/gameplay/level_complete.wav
audio/sfx/gameplay/wall_bump.wav
audio/sfx/gameplay/plate_activate.wav
audio/sfx/gameplay/door_open.wav

scripts/audio/submission_music_controller.gd
scripts/audio/submission_music_controller.gd.uid
scenes/app/app_root.tscn
audio/music/crow_producer/优哉游哉(loop).wav

tests/presentation/task_0024bae_owner_visual_repair_validation.gd
tests/presentation/task_0024bae_owner_visual_repair_validation.gd.uid
tests/audio/task_0024bae_audio_feedback_and_music_trial_validation.gd
tests/audio/task_0024bae_audio_feedback_and_music_trial_validation.gd.uid
tests/tools/task_0024bae_*.ps1
tests/tools/task_0024bae_*.py
tests/tools/task_0024bae_*.json

docs/reviews/evidence/0024BAE/*.png
docs/licenses/evidence/crow_producer/使用注意事项.png
docs/presentation/OWNER_VISUAL_ENTITY_REPAIR_CONTRACT_CURRENT.md
docs/audio/OWNER_AUDIO_FEEDBACK_REPAIR_CONTRACT_CURRENT.md
docs/reports/0024BAE_OWNER_VISUAL_ENTITY_AUDIO_FEEDBACK_AND_MUSIC_TRIAL_REPORT.md
docs/handoffs/DELAYED_SELF_SESSION_HANDOFF_AFTER_TASK_0024BAE_OWNER_REPAIR_2026_07_27.md
docs/presentation/SUBMISSION_MINIMUM_VISUAL_ASSET_MANIFEST_CURRENT.json
docs/audio/SUBMISSION_MINIMUM_AUDIO_MANIFEST_CURRENT.json
docs/licenses/CROW_PRODUCER_MUSIC_LICENSE_EVIDENCE_CURRENT.md
docs/licenses/THIRD_PARTY_ASSET_LEDGER_CURRENT.md
docs/licenses/ATTRIBUTION_CURRENT.md
docs/production/SUBMISSION_READINESS_SCORECARD_CURRENT.md
docs/production/GODOTHUB_FESTIVAL_2026_SUBMISSION_CRITICAL_PATH_CURRENT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
```

Conditional music paths may change only when source validation passes. No other path may change.

## 13. Protected surfaces

Do not modify:

```text
project.godot
data/**
scripts/simulation/**
scripts/solver/**
scripts/app/**
except no app script is authorized
schemas/**
tests/run_all.gd
all existing tests
localization/**
fonts/**
third-party graphic assets
audio/music files other than exact authorized track
all other audio files
shaders/**
build/**
export/**
release/**
submission/**
docs/playtest/**
docs/reviews/** except 0024BAE evidence
all historical reports/evidence
D:\Delayed_Self\.codex\config.toml
user-level wrapper/worker/config/environment
```

Do not modify level JSON, catalog, progression, finale, Profile semantics, Simulation or solver.

## 14. Startup gate

Before writing:

1. root `D:\Delayed_Self`, branch `main`, expected origin;
2. no Git operation in progress;
3. fetch and fast-forward only;
4. `HEAD == origin/main`, divergence `0/0`;
5. Task 0024BAE/current pointers from origin;
6. checkpoint `43082581e974332fb077550ce0a2aabdf78788b8` in ancestry;
7. tracked/staged clean;
8. only `.codex/config.toml` untracked;
9. config SHA unchanged:
   `D4C670DA3C2404921A1AB177F4E5405449BC8321D713CC0B42B8046201FD33CC`;
10. accepted Godot identity;
11. Godot count zero;
12. hash/freeze catalog, all eight levels, Simulation, solver, Profile and app-root script;
13. initialize subagent ledger;
14. stop on drift, unexpected dirty path, Profile need or mechanics change.

## 15. Iteration and failure policy

Before final qualification, repair is allowed only on task-owned new files and explicitly authorized runtime files.

Return `BLOCKED` for:

- Simulation/history/turn/replay change;
- wall attempt no longer recorded;
- visual entities still fail structural distinctions;
- audio event duplication or missing required event;
- completion cue remains pickup-like by contract metrics;
- unauthorized source modification/conversion;
- wrong music file/size/MIME;
- source or license overclaim;
- protected path change;
- Profile access;
- process cleanup ambiguity.

Return `UNVERIFIED` for bounded capture/test limitations without a proven defect.

A failed conditional music acquisition is not itself a mandatory-task blocker when all repair work passes and the route remains silent/fail-closed.

## 16. Commit policy

Before commit:

```powershell
git status --short --untracked-files=all
git diff --check
git diff --name-only
git diff --stat
```

Require:

```text
catalog count = 8
finale = sequence 8
level changes = 0
Simulation/solver changes = 0
Profile access = NO
wall_bump WAV = present
plate_activate WAV = present
door_open WAV = present
level_complete WAV = replaced
review PNG count >= 3
Godot final count = 0
```

Music is either:

```text
IMPORTED_ORIGINAL_WAV_VERIFIED
or
BLOCKED_SOURCE_RETRIEVAL_OR_IDENTITY
```

Explicitly stage authorized paths. Inspect complete staged diff and binary file list. Run `git diff --cached --check`.

Commit exactly once:

```text
fix: repair gameplay visuals and audio feedback
```

Push `main`, then require:

```text
HEAD == origin/main
divergence = 0/0
tracked/staged clean
only untracked = unchanged .codex/config.toml
Godot count = 0
```

No amend, rebase, squash, force push or second implementation commit.

## 17. Terminal fields

```text
owner_review =
  CHANGES_REQUIRED_ADDRESSED /
  BLOCKED /
  UNVERIFIED

wall_visual =
  CONNECTED_CONCRETE_PASS /
  FAIL /
  NOT_VERIFIED

door_visual =
  DOORFRAME_LEAF_PASS /
  FAIL /
  NOT_VERIFIED

YOU_ECHO_visual =
  CONCRETE_GHOSTED_PASS /
  FAIL /
  NOT_VERIFIED

plate_exit_visual =
  MECHANISM_DESTINATION_PASS /
  FAIL /
  NOT_VERIFIED

wall_recorded_turn_semantics =
  PASS /
  FAIL /
  NOT_VERIFIED

audio_event_order =
  PASS /
  FAIL /
  NOT_VERIFIED

level_complete_replacement =
  CLEAR_SUCCESS_CADENCE_PASS /
  FAIL /
  NOT_VERIFIED

wall_bump =
  PASS /
  FAIL /
  NOT_VERIFIED

plate_activate =
  PASS /
  FAIL /
  NOT_VERIFIED

door_open =
  PASS /
  FAIL /
  NOT_VERIFIED

music_trial_status =
  IMPORTED_ORIGINAL_WAV_VERIFIED /
  BLOCKED_SOURCE_RETRIEVAL_OR_IDENTITY /
  NOT_ATTEMPTED

music_SHA256 =
  <exact or NONE>

music_source_bytes_modified =
  NO /
  YES /
  NOT_APPLICABLE

music_attribution =
  PASS /
  FAIL /
  NOT_APPLICABLE

production_eight_regression =
  PASS /
  FAIL /
  NOT_VERIFIED

review_capture_count =
  <exact>

DeepSeek_optional_delegation =
  NOT_USED /
  USED_ACCEPTED /
  USED_REJECTED /
  BLOCKED_FAIL_CLOSED

production_catalog_modified =
  NO /
  YES

formal_finale_modified =
  NO /
  YES

Profile_accessed =
  NO /
  YES

next_gate =
  OWNER_VISUAL_AUDIO_REPAIR_REVIEW /
  BLOCKED /
  UNVERIFIED

final_task_verdict =
  PASS_FOR_GPT_REVIEW /
  BLOCKED /
  UNVERIFIED
```

## 18. Next gate

Success opens only:

```text
OWNER_VISUAL_AUDIO_REPAIR_REVIEW
```

The owner must inspect the new runtime captures, wall/door/actor/plate/EXIT readability, the completion cadence, wall bump, mechanism/door feedback and—when imported—the music balance.

Do not open full UI rollout, remaining SFX, font/zh-Hans, more music, external graphics, build/export, additional levels or S04 before owner review.
