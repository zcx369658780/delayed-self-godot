# Owner audio feedback repair contract (CURRENT)

- Task: `0024BAE_OWNER_VISUAL_ENTITY_AUDIO_FEEDBACK_AND_MUSIC_TRIAL_REPAIR`
- Canonical gate: `TASK_0024BAE_OWNER_VISUAL_AUDIO_REPAIR_PASS`
- Previous accepted baseline: six-procedural-SFX accepted under `TASK_0024BAD`.
- Scope: visual/audio event contract refresh for stable-eight gameplay; no simulation/solver/profile/levels/forma-l finale/catalog touch.
- `next_gate = OWNER_VISUAL_AUDIO_REPAIR_REVIEW`

## Required playback semantics

- `level_complete` must become a clear success cadence (non-pickup-like).
- `wall_facing_cardinal_recorded_turn` must emit:
  - `wall_bump` exactly once for the legal recorded wall-facing action,
  - no `YOU_move`,
  - no change to turn/history semantics.
- `plate_activate`:
  - must emit once when pressed-plate state first gains at least one plate this turn,
  - no event on release or unchanged plate set.
- `door_open`:
  - must emit once when at least one closed→open transition occurs,
  - aggregate same-turn openings into one event.
- `level_complete` is primary when completion and mechanism events co-occur.
- Existing movement and replay semantics must remain unchanged.

## Required SFX inventory

- `audio/sfx/gameplay/level_complete.wav` (replaced with distinct multi-tone success cadence)
- `audio/sfx/gameplay/wall_bump.wav` (new)
- `audio/sfx/gameplay/plate_activate.wav` (new)
- `audio/sfx/gameplay/door_open.wav` (new)

## Required music trial context (conditional)

- Source: `优哉游哉(loop).wav`
  - Drive ID: `1_l8gcHescLwdhJ3X_8Xco48zYX96vRSO`
  - size: `25,404,968` bytes
  - sha256: `E4552E433479AECD0790A901A84E9738448B7092BEE51109E0D748A8B9F3E850`
  - format: PCM 16-bit stereo 44100Hz
  - duration: `144.017868s`
- Notice ID: `1ID9Fy3Xmt7erOrORCblrEuGxMQsG1nhv` (PNG `647,122` bytes, sha256 `7B5FD2FB42019CC51D1EE67EB542FBF3BB70F71AE49A16306F948295BD9309DF`)
- Exact credit: `音乐由[乌鸦Producer]提供`

## Terminal fields (CURRENT)

```text
level_complete_replacement = CLEAR_SUCCESS_CADENCE_PASS
wall_bump = PASS
plate_activate = PASS
door_open = PASS
audio_event_order = PASS
wall_recorded_turn_semantics = PASS
music_trial_status = IMPORTED_ORIGINAL_WAV_VERIFIED
music_SHA256 = E4552E433479AECD0790A901A84E9738448B7092BEE51109E0D748A8B9F3E850
music_source_bytes_modified = NO
music_attribution = PASS
DeepSeek_optional_delegation = NOT_USED
```

## Notes

- Music trial is complete with exact-source import and no bytes changed.
- `owner_review = NOT_REVIEWED`; `final_task_verdict = PASS_FOR_GPT_REVIEW`.
