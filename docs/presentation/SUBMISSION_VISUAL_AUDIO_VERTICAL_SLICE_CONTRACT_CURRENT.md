# Submission visual/audio vertical slice contract (CURRENT)

- Task: `0024BAD_first_submission_visual_ui_and_sfx_vertical_slice`
- Canonical verdict: `PASS_FOR_GPT_REVIEW`
- Candidate scope: production-eight vertical slice only (no S04 / no protected migration)
- Owner defaults: `10_OF_10_ACCEPTED_RECOMMENDED_DEFAULTS`
- `next_gate = OWNER_VISUAL_AUDIO_VERTICAL_SLICE_REVIEW`

## Required implementation outcome

`visual_required_families = 10/10`
`UI_surfaces_reskinned = 2/2`
`generated_SFX = 6`

- `visual_slice_status = IMPLEMENTED_BASELINE_OWNER_REVIEW_PENDING`
- `SFX_router_status = PASS`
- `visual_snapshot_deterministic = YES`
- `SFX_bytes_deterministic = YES`
- `review_capture_count = 2`

## Runtime import and reuse constraints

- `music_imported = NO`
- `third_party_graphics_imported = NO`
- `font_imported = NO`
- `DeepSeek_optional_delegation = NOT_USED`
- `Profile_accessed = NO`
- `production_catalog_modified = NO`
- `formal_finale_modified = NO`

## Six required SFX for this baseline

All six are project-procedural WAV files (mono, 16-bit PCM), no sampling:

1. `audio/sfx/ui/focus_move.wav`
2. `audio/sfx/ui/confirm.wav`
3. `audio/sfx/gameplay/you_move.wav`
4. `audio/sfx/gameplay/echo_move.wav`
5. `audio/sfx/gameplay/blocked_invalid.wav`
6. `audio/sfx/gameplay/level_complete.wav`

## Exact cue semantics

- `YOU_move`: cardinal action where the player position changes.
- `blocked_or_invalid`: cardinal action where the player position does not change.
- `ECHO_move`: once when any ECHO position actually changes, including a turn where YOU is blocked.
- A blocked YOU turn therefore emits `blocked_or_invalid` and may also emit `ECHO_move`, but never emits `YOU_move`.
- `WAIT`: no movement or blocked cue.
- `level_complete`: only the first `false -> true` completion transition.

## Evidence bundle (slice deliverables)

| Artifact | Path | SHA-256 |
|---|---|---|
| Screenshot (main menu) | `docs/reviews/evidence/0024BAD/main_menu.png` | `97D237F4D65A983DE0A8C467579384DDC93CC115BB88B49BF4318F9D5478F7EF` |
| Screenshot (gameplay) | `docs/reviews/evidence/0024BAD/gameplay.png` | `412A96FA7BD2418C3B21597D5B98B4C40AE23281143635738AF1E1C9F77727D4` |
| ui_focus_or_move.wav | `audio/sfx/ui/focus_move.wav` | `59E3DE8F78A0734247AF9233210062827E6612FBF6E6B6E7AFB5C8CAA0CA002A` |
| ui_confirm.wav | `audio/sfx/ui/confirm.wav` | `64210394F3E448196DCA0F13E60DFC1AF6CAE43C2F394DEB45F0B2B9D5918690` |
| you_move.wav | `audio/sfx/gameplay/you_move.wav` | `F367F3E9B1CF04AA28ECDE42AFF45F615FD725F784CEAEB05AC9E529BACC58EF` |
| echo_move.wav | `audio/sfx/gameplay/echo_move.wav` | `968DBC0CBE6B8C52E4824771656EFAC229860F23C70EA1A87AC1D4D1DB2F3EDD` |
| blocked_invalid.wav | `audio/sfx/gameplay/blocked_invalid.wav` | `9EACA82A3345BF1413EA6846BEC1862081EA8A70F0E062589E0344BE46B57F18` |
| level_complete.wav | `audio/sfx/gameplay/level_complete.wav` | `D1B8C01520BA7ACBB4C23F6ED52E3EBFA6034EF89F22F9DE99DB794D035CE4CB` |

## Visual families confirmed at this vertical slice

- paper field
- floor sparse ticks
- wall dense hatch
- YOU solid core + Y
- ECHO dashed/double outline + E2/E3/E4
- exit double diamond
- plate inactive/active structural difference
- door closed bars / open frame
- blocked X
- timeline current / echo / action glyphs

## Notes

- Crow Producer music evidence was captured for attribution/legal follow-up, but no music import occurred.
- This contract records baseline scope only and is open for owner review before any protected production expansion.
- Focused visual `PASS assertions=97`; focused audio `PASS assertions=112`; Aggregate `PASS assertions=621 vectors=9` with stderr exactly `LEVEL_ID_MISMATCH`; complete-v2 `PASS` with empty stderr.
