# Owner decision sheet: visual/audio minimum package (Task 0024BAB v2)

- File purpose: exact 10 owner decisions required by task section 17
- Scope: stable eight production minimum only
- Current default status: all `PENDING`

## Decisions

| decision_id | recommended_default | alternatives | deadline | effect_if_delayed | fallback | owner_status |
|---|---|---|---|---|---|---|
| visual_strategy_approval | `RECOMMEND_VISUAL_V1` | `RECOMMEND_VISUAL_V2`, `RECOMMEND_VISUAL_V3`, `RECOMMEND_VISUAL_HYBRID_V1_V2` | 2026-08-03 | scope remains in conceptual mode; no visual authoring | continue with paper-only primitives | PENDING |
| paper_ink_direction_approval | `HAND_DRAWN_DELAYED_NOTEBOOK_KEEP` | `TONE_DOWN`, `ADJUST_GRID` | 2026-08-03 | visual density may overrun 960x540 | reduce overlay count and remove decorative extras | PENDING |
| YOU_ECHO_shape_approval | `YOU_AND_ECHO_GEOMETRIC_SEPARATION` | share one glyph with color-only difference | 2026-08-07 | accessibility risk in late replay states | enforce shape-only markers on both actors | PENDING |
| UI_density_approval | `KEEP_MIN_DENSITY` | increase polish details | 2026-08-07 | risk of unreadable menu/tutorial layout | cut optional decorative marks | PENDING |
| font_recommendation_approval | `RECOMMEND_DUAL_FONT_TEST_GATE` | `RECOMMEND_LXGW_PENDING_LICENSE_COVERAGE_GATE`, `RECOMMEND_LICENSED_FALLBACK_FIRST` | 2026-08-12 | zh-Hans rollout delayed | use verified builtin/system fallback | PENDING |
| music_shortlist_audition | `AUDITION_WITH_OWNER_ON_GATED_IMPORT_LIST` | skip music | 2026-08-12 | project proceeds with fallback | lock `ESSENTIAL_SFX_ONLY_NO_MUSIC` | PENDING |
| music_license_evidence_available | `SELECT_TRACK_AFTER_LEGAL_EVIDENCE` | `BLOCKED_TRACK` | owner-dependent | potential final scope shift to no-music fallback | use SFX-only plan | PENDING |
| SFX_strategy_approval | `RECOMMEND_AUDIO_A1` | `RECOMMEND_AUDIO_A2`, `RECOMMEND_AUDIO_A3` | 2026-08-07 | mute-only behavior may remain | essential SFX only, no music | PENDING |
| finale_music_optional_or_required | `OPTIONAL` | `REQUIRED_IF_LEGAL_AND_CALM` | 2026-08-12 | no additional gate if omitted | keep `ESSENTIAL_SFX_ONLY_NO_MUSIC` | PENDING |
| no_music_fallback_acceptance | `YES` | `NO` | 2026-08-12 | delayed close to music-only gate and extra risk | ship final with SFX-only and muted option | PENDING |

## Gate lock

- Next implementation gate is blocked until this sheet is reviewed as a set.
- Rows remain at `PENDING` until explicit owner confirmation.
