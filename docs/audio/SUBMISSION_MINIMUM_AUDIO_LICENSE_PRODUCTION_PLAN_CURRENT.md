# Submission-minimum audio/license production plan (CURRENT)

- Scope: `STABLE_EIGHT_LEVELS`
- Recommendation: `RECOMMEND_AUDIO_A1`
- Mandatory fallback: `ESSENTIAL_SFX_ONLY_NO_MUSIC`
- Status: planning only; no generation, acquisition, download, import, transcode or runtime integration

## Existing audit

`project.godot` has no audio-bus section. No `AudioStreamPlayer`, `AudioServer` or runtime audio call site exists. The `audio/` directory is `NOT_PRESENT`. Every SFX trigger in the manifest is therefore `IMPLEMENTATION_REQUIRED`. Future buses are Master, UI, Gameplay and Music; their creation requires a separate task.

## Strategy comparison

| Dimension | A1 created SFX + licensed shortlist | A2 created SFX + music-minimal | A3 licensed SFX pack + licensed music |
|---|---|---|---|
| schedule | HIGH | VERY_HIGH | MEDIUM |
| license risk | MEDIUM | LOW | HIGH |
| coherence | HIGH | HIGH | MEDIUM |
| owner effort | HIGH | MEDIUM | MEDIUM |
| integration | MEDIUM | LOW | HIGH |
| loop quality | HIGH | LOW | HIGH |
| portability | MEDIUM | VERY_HIGH | MEDIUM |
| cut flexibility | VERY_HIGH | VERY_HIGH | MEDIUM |

A1 is selected to retain the desired menu/gameplay loop target while keeping music fully removable. Essential project-created SFX is the independent core. Any missing track identity, license text, distribution, modification/conversion, attribution or loop evidence removes that track. A3 is excluded from the minimum.

## Essential events

The machine-readable manifest freezes exactly 14 required IDs: `ui_focus_or_move`, `ui_confirm`, `ui_back`, `YOU_move`, `ECHO_move`, `blocked_or_invalid`, `plate_activate`, `plate_release`, `door_open`, `door_close`, `restart`, `level_complete`, `finale_acknowledge`, and `error_recovery`. Each defines trigger, duration, variations, bus, priority, simultaneous policy, provenance status and future test.

## Bounded music shortlist

| Use | Candidates | Local presence | Current decision |
|---|---|---|---|
| menu | 晚安，星期八; 1：0.618(loop) | NO | `BLOCKED_LICENSE_EVIDENCE` |
| gameplay | 1：0.618(loop); Circulation(loop); 优哉游哉(loop) | NO | `BLOCKED_LICENSE_EVIDENCE` |
| finale | 宇宙，我，和她; A Forever Friend | NO | `BLOCKED_LICENSE_EVIDENCE` |

These names and the provisional credit `音乐由[乌鸦Producer]提供` are owner-supplied planning references, not permission. No remote source was accessed. Owner audition follows only after evidence intake. Unresolved music is removed or the game ships without music; the finale cue is always optional.

## License flow

The new intake checklist feeds, but does not replace, `THIRD_PARTY_ASSET_LEDGER_CURRENT.md` and `ATTRIBUTION_CURRENT.md`. No current item is `VERIFIED_FOR_IMPORT`. Project-created SFX still requires a creation record, author, transformations and final SHA-256. Credits must exactly match the final verified ledger.
