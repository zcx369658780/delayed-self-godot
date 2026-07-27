# GodotHub Festival 2026 submission critical path (CURRENT)

- Task 0024BAB v2 overlay: owner defaults Aug 3, token/essential-SFX target Aug 7, and stable-eight visual/UI/zh-Hans first pass Aug 12. These planning milestones do not authorize implementation. Current next gate is `HOLD_FOR_OWNER_VISUAL_AUDIO_DECISIONS`.
- Frozen: 2026-07-27 by Task 0024BAA
- Recommended scope: `RECOMMEND_OPTION_A`
- S04: `DEFER_S04_UNTIL_POST_SUBMISSION`
- Submission deadline: 2026-09-06 23:59
- Video deadline: 2026-09-10
- Final buffer: 2026-09-04 through 2026-09-05

Workstreams: P product/content; V visual/UI; A audio/license; F flow/localization/Profile; B build/stability; S submission. Protected gates (Profile, export/build, release, upload, candidate admission) are serialized behind explicit authorization; disjoint planning/authoring may run in parallel.

| Milestone | start_date | end_date | owner | dependencies | exit_evidence | hard_cut_if_missed | parallelizable_with |
|---|---|---|---|---|---|---|---|
| planning_and_scope_freeze | 2026-07-27 | 2026-07-29 | P/main+owner | GPT accepts 0024BAA | signed stable-eight scope | cut all candidate admission and S04 | V,A |
| visual_system_and_asset_plan | 2026-07-30 | 2026-08-03 | V/owner | scope freeze | approved minimum inventory and source/license plan | use minimum readable vector set | A,P |
| audio_SFX_music_license_plan | 2026-07-30 | 2026-08-03 | A/owner | scope freeze | SFX list, music shortlist, license evidence plan | ship without music if license unresolved; retain essential SFX only | V,P |
| selected_content_owner_review | 2026-07-30 | 2026-08-03 | P/owner | scope freeze | stable-eight disposition; optional candidates explicitly deferred | no candidate ships | V,A |
| catalog_Profile_integration_if_authorized | 2026-08-04 | 2026-08-07 | F/main | explicit scope and protected authorization | migration tests and owner disposition | retain catalog 8 and existing Profile semantics | V,A |
| zh_Hans_font_and_text_fit | 2026-08-04 | 2026-08-12 | F+V/owner | visual plan | full string inventory, license, coverage and fit evidence | shorten copy; retain licensed fallback | A,B |
| complete_flow_and_fresh_profile_walkthrough | 2026-08-13 | 2026-08-17 | F/owner | UI/text/content frozen | recorded fresh-profile walkthrough | cut optional polish/content | A,V |
| Windows_export_and_candidate_build | 2026-08-18 | 2026-08-21 | B/main | flow walkthrough; export authorization | installable versioned Windows candidate and hashes | stop Web work and optional assets | S,A |
| P0_P1_fix_window | 2026-08-22 | 2026-08-28 | B+P+V+A+F | candidate build | zero open P0; accepted P1 disposition; regression evidence | cut all nonblocking polish | S |
| screenshots_cover_and_submission_copy | 2026-08-24 | 2026-08-30 | S+V/owner | representative stable build | approved screenshots, cover, description/theme statement | use minimum compliant media/copy | B,A |
| gameplay_video_capture | 2026-08-29 | 2026-09-03 | S/owner | stable build and final UI/audio | approved capture/master and upload plan | use clean single-take minimum; complete by Sep 10 | final license audit |
| final_license_audit | 2026-08-29 | 2026-09-01 | A+V+S/owner | asset/audio freeze | complete ledger/credits/source evidence | remove any unresolved asset/audio | video |
| submission_dry_run | 2026-09-01 | 2026-09-02 | S/main+owner | candidate, media, copy, licenses | completed form/package checklist without public submission | remove optional fields/media | none |
| owner_authorized_upload | 2026-09-03 | 2026-09-03 | owner | successful dry run and explicit authorization | accepted platform receipt/draft state | escalate same day; do not defer first upload | none |
| buffer | 2026-09-04 | 2026-09-05 | all/owner | upload completed | correction-only reserve; final confirmation | no new scope, assets, platform, or first build | none |

September 6 is confirmation/emergency correction only, never the first build or first upload. September 7–10 is reserved solely for an already-planned video requirement, not for changing the submitted game scope.
