# Task 0024BAD owner visual/audio vertical-slice review adjudication

- Owner disposition: `CHANGES_REQUIRED`
- Technical baseline: `TASK_0024BAD_FIRST_SUBMISSION_VISUAL_AUDIO_VERTICAL_SLICE_ACCEPTED`
- Review scope: real runtime gameplay/menu presentation and six implemented SFX
- Product scope remains: stable eight cataloged levels; sequence 8 sole finale; S04 deferred

## Accepted observations

- Basic movement audio is acceptable.
- The current six-SFX router and project-created WAV approach remain an accepted technical foundation.
- The current paper/ink direction may continue, but the board entities are not yet acceptable as final player-facing art.

## Required visual changes

1. Wall rendering is too abstract and visually noisy; it reads as a fan/web/window motif rather than a solid impassable wall.
2. Door rendering must read as a real doorframe/door leaf/open passage rather than a red grille or battery.
3. YOU must receive a more concrete controllable-character silhouette.
4. ECHO must receive a more concrete related-but-delayed silhouette with offset/ghost identity.
5. Plate/mechanism must read as a floor pressure device rather than a plain ring.
6. EXIT should read as a destination doorway/portal, not only as a crystal-like diamond.
7. Floor decoration should remain subordinate to puzzle readability.

## Required audio changes

1. `level_complete` currently resembles item pickup; replace it with an unmistakable completion/success cadence.
2. Entering or newly activating a plate/mechanism must produce a distinct button/mechanism cue rather than only ordinary movement feedback.
3. A door changing from closed to open must produce a distinct door-opening cue.
4. A cardinal input into a wall must produce a physical wall-bump cue.
5. Wall-facing input remains a legal recorded turn under the accepted Simulation contract. Audio must distinguish `recorded blocked turn` from successful movement without changing history, turn count or replay.
6. Completion, mechanism and wall events must not double-play misleading ordinary movement cues.

## Music authorization

The owner authorizes one bounded Godot music-import trial using the previously supplied free Crow Producer source.

Preferred trial source:

- Track: `优哉游哉(loop).wav`
- Drive file ID: `1_l8gcHescLwdhJ3X_8Xco48zYX96vRSO`
- Publicly listed size: `25,404,968` bytes
- Intended use: low-volume gameplay/menu audition baseline

License boundary:

- use the original WAV bytes directly;
- do not trim, normalize, transcode, remix or otherwise alter the file;
- retain author copyright;
- required attribution: `音乐由[乌鸦Producer]提供`;
- no direct resale of the music;
- if exact raw acquisition or license evidence cannot be verified, the music trial fails closed while the mandatory visual/audio repair may still continue.

## Gate decision

```text
OWNER_VISUAL_AUDIO_VERTICAL_SLICE_REVIEW = CHANGES_REQUIRED
NEXT_TASK = 0024BAE_OWNER_VISUAL_ENTITY_AUDIO_FEEDBACK_AND_MUSIC_TRIAL_REPAIR
```

The next task may repair only the owner-identified visual and audio semantics and perform one conditional direct-WAV music trial. It must not modify catalog, levels, Simulation, solver, Profile, finale, build/release/submission or reopen S04.
