# Owner visual entity repair contract (CURRENT)

- Task: `0024BAE_OWNER_VISUAL_ENTITY_AUDIO_FEEDBACK_AND_MUSIC_TRIAL_REPAIR`
- Canonical gate: `TASK_0024BAE_OWNER_VISUAL_AUDIO_REPAIR_PASS`
- Previous accepted baseline: `TASK_0024BAD_FIRST_SUBMISSION_VISUAL_AUDIO_VERTICAL_SLICE_ACCEPTED`
- Scope: stable-eight gameplay, no S04, no level/catalog/simulation/finale/Profile changes
- Task-specific precedence: this contract replaces earlier token-level wording from older 0024x reports for repaired entities.
- `next_gate = OWNER_VISUAL_AUDIO_REPAIR_REVIEW`

## Required visual outcome

Task 0024BAE must make the following visual families concrete and role-distinct in monochrome, while keeping runtime semantics unchanged.

- `wall_visual = CONNECTED_CONCRETE_PASS`
- `door_visual = DOORFRAME_LEAF_PASS`
- `YOU_ECHO_visual = CONCRETE_GHOSTED_PASS`
- `plate_exit_visual = MECHANISM_DESTINATION_PASS`

## Required visual structure checks

- `wall` must use connected wall mass, not fan/web/radial/grille motifs.
- `wall` should read as impassable matter in 960×540.
- `door` must read as frame + leaf/panel, with distinct closed and open geometry.
- `YOU` should read as concrete controllable character token, not an abstract mark.
- `ECHO` must be same-family but unmistakably delayed/ghosted.
- `plate` must read as floor mechanism (not decorative ring).
- `EXIT` must read as destination portal/threshold (not collectible-only motif).
- `floor` noise reduced; floor ornaments must not dominate semantic entities.

## Contract-owned evidence points

- 3 real runtime captures are required under `docs/reviews/evidence/0024BAE/`:
  1) initial room (closed door, YOU, ECHO, plate, EXIT visible)
  2) plate active + door open
  3) production-level with 2 ECHOs or finale state
- Capture constraints: `960×540`, real Godot runtime, no mockup, no external graphics.

## Terminal fields (CURRENT)

```text
owner_review = NOT_REVIEWED
wall_visual = CONNECTED_CONCRETE_PASS
door_visual = DOORFRAME_LEAF_PASS
YOU_ECHO_visual = CONCRETE_GHOSTED_PASS
plate_exit_visual = MECHANISM_DESTINATION_PASS
production_eight_regression = PASS
review_capture_count = 3
production_catalog_modified = NO
formal_finale_modified = NO
Profile_accessed = NO
next_gate = OWNER_VISUAL_AUDIO_REPAIR_REVIEW
final_task_verdict = PASS_FOR_GPT_REVIEW
```

## Notes

- Visual verification passed via focused visual assertions=151 (stderr empty), all required 3×960x540 captures recorded, and owner review is still `NOT_REVIEWED` at this boundary.
