# Submission-minimum visual/UI production plan (CURRENT)

- Scope: `STABLE_EIGHT_LEVELS`
- Direction: `HAND_DRAWN_DELAYED_NOTEBOOK / INK_ECHO`
- Recommendation: `RECOMMEND_VISUAL_V1`
- Mandatory fallback: project-native procedural/vector drawing with zero unresolved third-party dependencies
- Logical cell: 60 px; audited viewport/target: 960×540, presentation review also required at 1920×1080
- Status: planning only; no generation, acquisition, import or implementation authorized

## Production-eight audit

| Surface/entity | present_in_cataloged_eight | source_level_ids | runtime_rendering_path | state_variants | readability requirement | visual asset required | audio event required |
|---|---|---|---|---|---|---|---|
| terrain_and_grid | YES | all 1–8 | `vertical_slice.gd::_draw` | floor, wall | wall/floor differ by hatch and value | token/vector pattern | NO |
| YOU | YES | all 1–8 | `vertical_slice.gd::_draw` | idle, moved, blocked, complete | solid unique body and `Y`/core | vector token | YOU_move, blocked_or_invalid |
| ECHO_by_delay_or_generation | YES | 2–8 | `_draw`, timeline model | E2/E3/E4, moved, blocked, waited, overlap | outline/badge carries delay without color | vector token + badges | ECHO_move |
| exit | YES | all 1–8 | `_draw_exit_base/_overlay` | available, occupied/complete | diamond and EXIT mark | vector token | level_complete |
| plates_or_trigger_surfaces | YES | 2–8 | `_draw`, `_plate_snapshots` | inactive, active, A/B identity | hollow/filled plus shape/label | vector token | plate_activate/release |
| doors_or_barriers | YES | 2–8 | `_draw`, `_door_snapshots` | closed, open, linked pips | bars/hollow and OPEN/CLOSED text in help | vector token | door_open/close |
| keys_tokens_or_equivalent | NO | none | not used by production eight | NOT_APPLICABLE | candidate-only primitives excluded | NO | NO |
| locks_or_equivalent | NO | none | not used by production eight | NOT_APPLICABLE | candidate-only primitives excluded | NO | NO |
| timeline_history | YES | 2–8 | timeline model + HUD labels | hidden, compact, expanded, current/ECHO pointer | action glyph plus accessible label | UI token/glyph set | ui_focus_or_move |
| tutorial_help_markers | YES | 1–8 | HUD/help card/teaching badge | collapsed, expanded, contextual | no animation-only instruction | panel/icon tokens | ui_confirm/back |
| selection_lock_completion_states | YES | app shell/catalog UI | `level_select.gd`, app shell | locked, available, selected, completed | icon/shape/text redundancy | UI tokens | ui_focus/confirm/back |
| finale_specific_states | YES | 8 | final acknowledgement overlay | hidden, visible, acknowledged | static readable acknowledgement | finale panel token | finale_acknowledge |
| error_failure_restart_feedback | YES | app/gameplay | safe error, blocked cue, restart | error, blocked, recovery, restart | X/notch/text and focus recovery | UI tokens | blocked, restart, error_recovery |

Candidate-only crates, typed sensors, grouped barriers and latches are outside the mandatory package.

## Strategy comparison

| Dimension | V1 procedural/vector | V2 AI concepts + owner vectors | V3 licensed pack |
|---|---|---|---|
| schedule speed | HIGH | MEDIUM | HIGH |
| style coherence | VERY_HIGH | HIGH | MEDIUM |
| license risk | LOW | MEDIUM | HIGH |
| owner effort | MEDIUM | VERY_HIGH | MEDIUM |
| implementation effort | MEDIUM | HIGH | MEDIUM |
| revision control | VERY_HIGH | HIGH | LOW |
| accessibility control | VERY_HIGH | HIGH | MEDIUM |
| submission portability | VERY_HIGH | HIGH | MEDIUM |

V1 is selected because it preserves the existing procedural board contract, exposes every state in controllable shapes, and has a dependency-free fallback. V2 may provide non-shipping concepts only after provenance review; V3 is excluded from the minimum.

## Font and zh-Hans gate

`font_recommendation = RECOMMEND_DUAL_FONT_TEST_GATE`.

Test `LXGW_WenKai_GB_candidate` only after OFL text, source identity, glyph coverage and redistribution evidence are retained. Compare it with Godot builtin/system fallback at 960×540 and 1920×1080. Freeze title/body roles, ASCII input glyphs, punctuation, line wrapping, minimum sizes, long level titles, help, settings, credits, errors and finale copy. Do not overwrite the Profile language; zh-Hans becomes the submission default only through a later authorized implementation gate. Full English remains deferred.

## Exit gate

Owner approves the ten decision rows; every item reaches provenance status suitable for its future source; token sheet proves monochrome state identity, focus visibility and text fit. Until then all assets remain planned.
