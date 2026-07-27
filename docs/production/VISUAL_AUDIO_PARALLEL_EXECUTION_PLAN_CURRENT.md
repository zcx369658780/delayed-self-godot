# Visual/audio parallel execution plan (CURRENT)

Planning window: 2026-07-30 through 2026-08-12. Dates and paths are proposals only and authorize no implementation.

| Lane | Dates | Owner | Subagent roles | Dependencies | Future paths | Exit evidence | Hard cut | Parallelizable with |
|---|---|---|---|---|---|---|---|---|
| V1_visual_token_and_entity_assets | Jul 30–Aug 7 | visual owner/main | planner, mapper, implementer, reviewer | decisions 1–3; intake | `assets/visual/tokens/`, `assets/visual/entities/` | monochrome token sheet + provenance | retain procedural minimum | V2,V3,A1,L |
| V2_UI_surface_reskin | Aug 4–Aug 12 | UI owner/main | mapper, implementer, reviewer | V1; decision 4 | `assets/visual/ui/` plus future authorized scenes/scripts | 12-surface first pass | cut decoration/animation | V3,A1,A2,L |
| V3_font_zh_Hans_fit | Jul 30–Aug 12 | localization owner | reader, mapper, reviewer | decision 5; license evidence | `assets/fonts/`, `localization/` | coverage/license/960×540 and 1080p fit | licensed fallback; no unverified font | V1,A1,A2,L |
| A1_essential_SFX | Jul 30–Aug 7 | audio owner/main | mapper, implementer, reviewer | decision 8; trigger map | `audio/sfx/ui/`, `audio/sfx/gameplay/` | 14-event essential baseline | cut variations, not core cues | V1,V3,A2,L |
| A2_music_license_and_audition | Jul 30–Aug 7 | owner/license reviewer | reader, planner, reviewer | decisions 6,7,9,10 | `audio/music/` | bounded audition + permission evidence | remove unresolved music | V1,V3,A1,L |
| L_license_ledger | Jul 30–Aug 12 | license reviewer | reader, reviewer | every future source | `docs/licenses/` intake/ledger/attribution | every shipped byte verified | reject unresolved dependency | all |
| Q_owner_review_and_QA | Aug 3–Aug 12 | owner/main | planner, independent reviewer | lane exits | future evidence paths only | decisions + visual/audio/fit review | fallback defaults apply | serialized at exits |

```text
2026-08-03 plan and owner defaults frozen
2026-08-07 first visual token sheet and essential SFX baseline target
2026-08-12 production-eight visual/UI/zh-Hans first-pass target
```
