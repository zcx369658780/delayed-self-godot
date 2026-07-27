# Owner decision sheet: visual/audio minimum package (Task 0024BAB v2)

- File purpose: exact 10 owner decisions required by Task 0024BAB v2
- Scope: stable eight production minimum only
- Owner decision gate: `OWNER_VISUAL_AUDIO_DECISIONS_10_OF_10_ACCEPTED`
- Acceptance source: `docs/reports/0024BAD_GPT_OWNER_VISUAL_AUDIO_DECISIONS_ACCEPTANCE.md`

## Decisions

| decision_id | accepted_default | alternatives retained for history | owner_status |
|---|---|---|---|
| visual_strategy_approval | `RECOMMEND_VISUAL_V1` | `RECOMMEND_VISUAL_V2`, `RECOMMEND_VISUAL_V3`, `RECOMMEND_VISUAL_HYBRID_V1_V2` | OWNER_ACCEPTED_RECOMMENDED_DEFAULT |
| paper_ink_direction_approval | `HAND_DRAWN_DELAYED_NOTEBOOK_KEEP` | `TONE_DOWN`, `ADJUST_GRID` | OWNER_ACCEPTED_RECOMMENDED_DEFAULT |
| YOU_ECHO_shape_approval | `YOU_AND_ECHO_GEOMETRIC_SEPARATION` | shared glyph with color-only difference rejected | OWNER_ACCEPTED_RECOMMENDED_DEFAULT |
| UI_density_approval | `KEEP_MIN_DENSITY` | increased polish density deferred | OWNER_ACCEPTED_RECOMMENDED_DEFAULT |
| font_recommendation_approval | `RECOMMEND_DUAL_FONT_TEST_GATE` | `RECOMMEND_LXGW_PENDING_LICENSE_COVERAGE_GATE`, `RECOMMEND_LICENSED_FALLBACK_FIRST` | OWNER_ACCEPTED_RECOMMENDED_DEFAULT |
| music_shortlist_audition | `AUDITION_WITH_OWNER_ON_GATED_IMPORT_LIST` | skip music remains fallback | OWNER_ACCEPTED_RECOMMENDED_DEFAULT |
| music_license_evidence_available | `SELECT_TRACK_AFTER_LEGAL_EVIDENCE` | unresolved track remains blocked | OWNER_ACCEPTED_RECOMMENDED_DEFAULT |
| SFX_strategy_approval | `RECOMMEND_AUDIO_A1` | `RECOMMEND_AUDIO_A2`, `RECOMMEND_AUDIO_A3` | OWNER_ACCEPTED_RECOMMENDED_DEFAULT |
| finale_music_optional_or_required | `OPTIONAL` | required only if legal and calm | OWNER_ACCEPTED_RECOMMENDED_DEFAULT |
| no_music_fallback_acceptance | `YES` | `NO` rejected | OWNER_ACCEPTED_RECOMMENDED_DEFAULT |

## External-source note

The owner authorizes independent search for free graphic, sprite and animation assets. Any future use still requires exact license/provenance intake. Core production-eight visuals remain project-native under V1. Crow Producer music may enter a later gated audition/license task; this decision sheet does not authorize music download, conversion or runtime import.

## Gate result

The decision hold is cleared. A bounded visual/UI and essential-SFX vertical-slice task may be published. Full UI rollout, font import, music import, external graphic import, build/export and public submission remain separately gated.

## Task 0024BAD implementation disposition

All 10 defaults remain accepted. The project-native visual/UI baseline and six deterministic project-created WAVs are `IMPLEMENTED_BASELINE_OWNER_REVIEW_PENDING`. This is machine evidence, not owner acceptance. Eight further SFX remain planned; music, fonts and third-party graphics remain unimported. Next gate: `OWNER_VISUAL_AUDIO_VERTICAL_SLICE_REVIEW`.
