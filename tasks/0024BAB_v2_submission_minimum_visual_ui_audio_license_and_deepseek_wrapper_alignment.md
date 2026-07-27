# Task 0024BAB v2 — Freeze the submission-minimum visual/UI asset plan, audio/music/license package, and wrapper-only DeepSeek route

- Status: `READY`
- Authority: this v2 task supersedes `tasks/0024BAB_submission_minimum_visual_ui_audio_license_planning.md` for execution
- User-level DeepSeek gate: `DEEPSEEK_MCP_CONFIG_REMOVAL_ACCEPTED`
- Gate: `SUBMISSION-MINIMUM VISUAL/UI + AUDIO/LICENSE PRODUCTION PLANNING / MANDATORY MULTI-SUBAGENT / NO ASSET IMPORT`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Required accepted checkpoint in ancestry: `677a812d1ecf9c6b87309cab3591cdfc87c2860e`
- Previous accepted gate: `TASK_0024BAA_PROJECT_RULE_MULTI_SUBAGENT_AND_SUBMISSION_REBASELINE_ACCEPTED`
- Submission scope: `RECOMMEND_OPTION_A` — stable eight-level submission
- S04 / Task 0024BB: `DEFER_S04_UNTIL_POST_SUBMISSION`
- Submission deadline: `2026-09-06 23:59`
- Video deadline: `2026-09-10`
- Final buffer: `2026-09-04` through `2026-09-05`
- Task type: documentation, read-only implementation mapping, asset/audio specification and owner-decision planning only
- Godot/solver/Profile execution: `NOT_AUTHORIZED`
- Asset/audio/font generation, download, import or transcode: `NOT_AUTHORIZED`
- Product code, scenes, catalog, build, release and submission changes: `NOT_AUTHORIZED`
- DeepSeek formal route: `WRAPPER_BACKED_CLI_EXTERNAL_FILE_WORKER_ONLY`
- DeepSeek MCP/native provider/automatic native sub-agent: `REMOVED / FORBIDDEN / FORBIDDEN`

## 1. Objective

Convert the accepted hand-drawn notebook / ink-ECHO direction and stable-eight scope into an implementation-ready, license-safe production package.

Deliver:

1. exact production-eight entity/state audit;
2. exact UI-surface and player-facing text audit;
3. selected visual production strategy and fallback;
4. visual style-token specification;
5. machine-readable visual asset manifest;
6. UI coherence matrix;
7. zh-Hans/font recommendation and evidence gate;
8. existing audio-bus/call-site audit;
9. essential SFX inventory;
10. selected audio production strategy and no-music fallback;
11. bounded music shortlist and license blockers;
12. machine-readable audio manifest;
13. license/provenance intake checklist;
14. ten-row owner decision sheet;
15. dated parallel execution plan through August 12;
16. one exact next implementation recommendation;
17. one documentation-only commit and push.

Do not create or import actual images, vectors, fonts, SFX or music.

## 2. Binding decisions

```text
submission_scope = STABLE_EIGHT_LEVELS
production_catalog_count = 8
formal_finale = sequence_8
S04 = DEFERRED_POST_SUBMISSION
candidate_admission = NOT_AUTHORIZED
candidate_owner_review = NOT_REVIEWED
visual_direction = HAND_DRAWN_DELAYED_NOTEBOOK / INK_ECHO
default_submission_language = zh-Hans
full_English = DEFERRED
minimum_music = menu_loop + gameplay_loop
optional_music = restrained_finale_cue
unresolved_music_license = REMOVE_OR_SHIP_WITHOUT
```

Candidate-only mechanics must not inflate the mandatory stable-eight asset package unless the same visual primitive is used by the cataloged eight.

## 3. Mandatory multi-subagent execution

Use at least five distinct configured GPT roles:

- `planner_high`: strategies, dates, dependencies, cuts;
- `docs_reader`: accepted visual/audio/font/license requirements;
- `code_mapper`: production entities, UI/text surfaces, audio buses/call sites and target integration paths;
- `docs_writer`: manifests, matrices, plans and decision package;
- `code_reviewer`: independent completeness, contradiction, license and allowlist review.

The main agent integrates results and owns the verdict.

Read local `D:\Delayed_Self\.codex\config.toml`; record only path and SHA-256. Never expose, modify, stage or copy contents. Configured GPT roles remain mandatory. The DeepSeek wrapper-backed CLI worker does not count as a GPT subagent role and may be used only under the explicit wrapper contract in Section 4.

Retain a routing ledger with role, scope, route class, inputs, inspected/proposed paths, summary, main-agent disposition, and confirmations of no Git writes, Godot/solver, Profile, or asset/audio acquisition.

If fewer than three distinct usable GPT roles are available, return `BLOCKED_MULTI_SUBAGENT_UNAVAILABLE`; do not silently fall back.

## 4. Wrapper-only DeepSeek route alignment

This task must synchronize the repository with the accepted user-level cleanup gate:

```text
DEEPSEEK_MCP_CONFIG_REMOVAL_ACCEPTED
```

### 4.1 Sole formal invocation path

The only authorized DeepSeek path is:

```powershell
& "C:\Users\zcxve\.codex\helpers\Invoke-DeepSeekFileTask.ps1" `
  -TaskFile "<absolute task JSON path>"
```

No DeepSeek MCP delegate, MCP ping/startup gate, native DeepSeek provider, native/automatic DeepSeek subagent, Anthropic compatibility route, or fallback-to-MCP path is permitted.

### 4.2 Worker identity and role

DeepSeek-V4-Pro is a wrapper-backed CLI external file editing worker. It is not:

- a native Codex provider;
- an MCP service;
- a mandatory GPT subagent;
- a planner, architect, tester, Git authority, release authority, or final reviewer.

It may receive only GPT-5.6-frozen, low-risk, sharply bounded and easily verified work such as:

- read-only code or document extraction;
- one or a few explicitly allowed regular-file edits;
- mechanical Markdown/JSON normalization;
- low-risk repetitive changes with deterministic diff review.

It must not independently choose architecture, scope, APIs, allowed paths, tests, build commands, Git actions, release actions, or acceptance criteria.

### 4.3 GPT-5.6 retained authority

GPT-5.6 Sol/Terra remains responsible for:

```text
planning_and_architecture
task_decomposition
allowed_paths
task_JSON_authoring
DeepSeek_output_review
full_diff_review
tests_build_and_regression
Git_stage_commit_push
release_and_submission
terminal_verdict_and_final_acceptance
```

DeepSeek output is advisory until the GPT-5.6 main agent verifies and integrates it.

### 4.4 Explicit delegation contract

DeepSeek use is optional, not required for this task.

If used, the main agent must create a temporary user/local task JSON outside the repository containing only:

```text
task_identity
frozen_objective
absolute_project_root
allowed_paths
forbidden_paths
input_files
required_output
verification_commands
stop_conditions
```

The JSON must not contain any API key, token, secret, credential, private configuration content, Profile/player data, or unnecessary repository content.

The report must record only:

```text
wrapper_invoked = YES / NO
task_identity
allowed_paths
result_status
main_agent_disposition
wrapper_SHA256_match
worker_SHA256_match
```

Do not retain the task JSON in Git or copy it into reports.

### 4.5 Secret and user-scope protections

Never write or expose:

```text
DEEPSEEK_API_KEY
ANTHROPIC_API_KEY
ANTHROPIC_AUTH_TOKEN
```

in:

```text
.codex/config.toml
repository files
task JSON
logs
reports
Git history
terminal transcript excerpts
```

Do not modify, copy, replace, reformat, hash-disclose beyond accepted identity records, or redistribute:

```text
C:\Users\zcxve\.codex\helpers\Invoke-DeepSeekFileTask.ps1
the user-level DeepSeek CLI wrapper
the user-level file worker
user-level environment variables
```

### 4.6 Fail-closed behavior

If the wrapper, worker, or Windows User-scope `DEEPSEEK_API_KEY` is unavailable when an explicitly authorized DeepSeek delegation is attempted:

```text
DEEPSEEK_DELEGATION = BLOCKED_FAIL_CLOSED
MCP_FALLBACK = FORBIDDEN
NATIVE_PROVIDER_FALLBACK = FORBIDDEN
```

The main task may continue using configured GPT subagents when DeepSeek is optional and no DeepSeek-produced output is required. It must report the optional delegation as not used or blocked; it must never attempt MCP recovery.

### 4.7 Hash and smoke policy

Retrieve accepted wrapper and worker SHA-256 identities from existing accepted project evidence without exposing file contents.

- If both SHA-256 identities match accepted evidence, no project-level DeepSeek smoke retest is required.
- If either SHA-256 differs, do not use DeepSeek. Return a route blocker for future delegation and require a separately authorized reevaluation.
- The accepted project-level `DEEPSEEK_PROJECT_PILOT_ENABLED` status remains valid when identities are unchanged.
- This task does not authorize modifying or re-smoke-testing the user-level infrastructure.

### 4.8 Project-source synchronization

Update live project rules, current docs, the 0024BAB report/handoff, and a new Project Source package to state:

```text
DeepSeek_MCP = REMOVED
DeepSeek_native_provider = FORBIDDEN
DeepSeek_automatic_native_subagent = FORBIDDEN
DeepSeek_formal_route = WRAPPER_BACKED_CLI_EXTERNAL_FILE_WORKER
DeepSeek_scope = GPT_FROZEN_LOW_RISK_BOUNDED_EASY_TO_VERIFY
GPT_5_6_authority = PLANNING_TEST_GIT_RELEASE_ACCEPTANCE
```

Historical reports remain immutable and may retain superseded MCP/pilot history when clearly historical.

## 5. Source reads and read-only audit

Read:

```text
AGENTS.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
tasks/0024BAB_v2_submission_minimum_visual_ui_audio_license_and_deepseek_wrapper_alignment.md
tasks/0024BAB_submission_minimum_visual_ui_audio_license_planning.md  # historical superseded task
docs/reports/0024BAA_GPT_PROJECT_RULE_AND_SUBMISSION_REBASELINE_ACCEPTANCE.md
docs/reports/0024BAA_PROJECT_RULE_MULTI_SUBAGENT_AND_SUBMISSION_REBASELINE_REPORT.md
docs/production/GODOTHUB_FESTIVAL_2026_SUBMISSION_CRITICAL_PATH_CURRENT.md
docs/production/SUBMISSION_READINESS_SCORECARD_CURRENT.md
docs/production/FINAL_SCOPE_DECISION_MATRIX_CURRENT.md
docs/presentation/HAND_DRAWN_NOTEBOOK_PRESENTATION_DIRECTION_CURRENT.md
docs/presentation/SCHEMA_V2_MINIMUM_OWNER_REVIEW_VISUAL_CONTRACT_CURRENT.md
docs/audio/MUSIC_SOURCE_LICENSE_AND_AUDITION_PLAN_CURRENT.md
docs/game_design/DELAYED_SELF_GAME_DESIGN_DOCUMENT_CURRENT.md
docs/game_design/DELAYED_SELF_GAME_DESIGN_REBASELINE_CURRENT.md
docs/production/EIGHT_LEVEL_FINALE_CLOSURE_AND_PRODUCTION_PLAN_CURRENT.md
docs/production/COMPLETE_FLOW_PRODUCTION_CLOSURE_PLAN_CURRENT.md
docs/licenses/THIRD_PARTY_LICENSE_LEDGER.md
docs/licenses/ATTRIBUTION.md
docs/agents/PROJECT_RULE_CODEX_MULTI_SUBAGENT_MODEL_ROUTING.md
docs/project_rules/PROJECT_RULE_MULTI_SUBAGENT_AND_SUBMISSION_EXECUTION_CURRENT.md
docs/workflows/PROJECT_BOOTSTRAP_AND_TASK_WORKFLOW.md
docs/workflows/DEEPSEEK_FILE_WORKER_CLI_PILOT_WORKFLOW.md
docs/reports/0024AO_DEEPSEEK_RELATIVE_PATH_CONTRACT_AND_PROJECT_PILOT_REPORT.md
docs/reports/0024AR_DEEPSEEK_MCP_CODE_QUALITY_ADJUDICATION.md
docs/PROJECT_SOURCE_INDEX_CURRENT.md
docs/project_source/DELAYED_SELF_PROJECT_SOURCE_SYNC_CURRENT_AFTER_0024BA_2026_07_27.md
```

Read-only implementation audit:

```text
project.godot
data/catalog/level_catalog_v1.json
all eight cataloged level JSON files
scenes/**
scripts/app/**
scripts/gameplay/**
scripts/simulation/**
localization/**
assets/**
audio/**
shaders/**
docs/licenses/**
```

Record missing paths as `NOT_PRESENT`. Do not inspect Profile/player data.

## 6. Production-eight content audit

Audit:

```text
terrain_and_grid
YOU
ECHO_by_delay_or_generation
exit
plates_or_trigger_surfaces
doors_or_barriers
keys_tokens_or_equivalent
locks_or_equivalent
timeline_history
tutorial_help_markers
selection_lock_completion_states
finale_specific_states
error_failure_restart_feedback
```

For each record:

```text
present_in_cataloged_eight
source_level_ids
runtime_rendering_path
state_variants
player_readability_requirement
visual_asset_required
audio_event_required
```

Do not import candidate-only crates, typed sensors, grouped barriers or latches into the mandatory package unless already shared by production-eight surfaces.

## 7. Visual strategy comparison and recommendation

Compare exactly:

- `V1` project-native procedural/vector drawing;
- `V2` AI-assisted concepts, owner-finalized project vectors;
- `V3` third-party licensed asset pack.

Dimensions: schedule speed, style coherence, license risk, owner effort, implementation effort, revision control, accessibility control, submission portability. Ratings: `LOW`, `MEDIUM`, `HIGH`, `VERY_HIGH`.

Choose one:

```text
RECOMMEND_VISUAL_V1
RECOMMEND_VISUAL_V2
RECOMMEND_VISUAL_V3
RECOMMEND_VISUAL_HYBRID_V1_V2
```

Define a mandatory fallback with zero unresolved third-party dependencies.

## 8. Visual style tokens

Create `docs/presentation/SUBMISSION_VISUAL_STYLE_TOKEN_SPEC_CURRENT.md`.

Semantic tokens:

```text
paper_background
primary_ink
secondary_ink
echo_ink
warning_mark
success_mark
disabled_mark
grid_line
focus_outline
```

Non-color signatures:

```text
YOU_shape
ECHO_shape_and_delay_badge
wall_hatch
floor_mark
plate_inactive
plate_active
door_closed
door_open
exit_mark
locked_level
completed_level
selected_level
error
restart
timeline_current
timeline_echo
```

Require no color-only state, 1080p readability, visible keyboard focus, non-color ECHO delay identity, grid-safe decoration and no animation-only information.

## 9. Visual manifest

Create `docs/presentation/SUBMISSION_MINIMUM_VISUAL_ASSET_MANIFEST_CURRENT.json`, schema 1.

Top level:

```text
schema_version
submission_scope
visual_strategy_recommendation
mandatory_fallback
logical_cell_size_from_audit
target_resolution
items
summary
owner_decisions
```

Each item:

```text
asset_id
category
surface_or_entity
production_required
cataloged_level_usage
state_variants
source_strategy
shipping_format
target_future_path
logical_size
scale_policy
monochrome_signature
text_or_glyph
animation_requirement
license_class
license_status
attribution_required
implementation_dependency
owner_approval
cut_priority
```

Use task enums from the accepted v1 planning contract. Every future path must be repository-relative and actionable.

## 10. UI surface matrix

Create `docs/presentation/SUBMISSION_MINIMUM_UI_SURFACE_MATRIX_CURRENT.md` with exactly 12 rows:

```text
title_main_menu
continue_new_game
level_select
gameplay_board
timeline_history_HUD
help_tutorial
settings
pause_return
level_result
finale_ending
credits_licenses
error_recovery
```

Each row: current scene/script, status, visual tokens, zh-Hans strings, focus navigation, feedback, asset/audio dependencies, owner question, future test and cut policy.

## 11. zh-Hans and font package

Freeze all player-facing text surfaces, title/body roles, glyph coverage, fallback, license evidence, 1080p fit/overflow, input glyphs, wrapping/minimum size and Profile-language non-overwrite.

Evaluate:

```text
LXGW_WenKai_GB_candidate
Godot_builtin_or_system_fallback
other_OFL_candidate_only_if_evidence_exists
```

Choose one:

```text
RECOMMEND_LXGW_PENDING_LICENSE_COVERAGE_GATE
RECOMMEND_LICENSED_FALLBACK_FIRST
RECOMMEND_DUAL_FONT_TEST_GATE
```

No download/import.

## 12. Audio strategy comparison

Compare:

- `A1` project-created/procedural SFX + licensed music shortlist;
- `A2` project-created/procedural SFX + music-minimal fallback;
- `A3` licensed SFX pack + licensed music shortlist.

Dimensions: schedule, license risk, coherence, owner effort, integration, loop quality, portability, cut flexibility.

Choose exactly one `RECOMMEND_AUDIO_A1/A2/A3`. Mandatory fallback: `ESSENTIAL_SFX_ONLY_NO_MUSIC`.

## 13. Essential SFX inventory

Audit/classify at least:

```text
ui_focus_or_move
ui_confirm
ui_back
YOU_move
ECHO_move
blocked_or_invalid
plate_activate
plate_release
door_open
door_close
restart
level_complete
finale_acknowledge
error_recovery
```

Each: runtime trigger path, required status, variations, duration, loop, source strategy, future path, bus, priority, simultaneous policy, variation, license, approval, cut and future test. Missing triggers are `IMPLEMENTATION_REQUIRED`.

## 14. Music shortlist/license package

Do not access/download remote files. Limits:

```text
menu_candidates <= 2
gameplay_candidates <= 3
finale_candidates <= 2
```

Each track: identity, use, reference, local presence NO, license text, author, distribution/edit/convert permission, attribution, loop, size, owner audition and decision.

Decisions: `SHORTLIST_OWNER_AUDITION`, `BLOCKED_LICENSE_EVIDENCE`, `CUT_FROM_SUBMISSION`, `SELECTED_PENDING_IMPORT_GATE`.

## 15. Audio manifest

Create `docs/audio/SUBMISSION_MINIMUM_AUDIO_MANIFEST_CURRENT.json` with:

```text
schema_version
submission_scope
audio_strategy_recommendation
mandatory_fallback
existing_bus_audit
sfx_items
music_candidates
summary
owner_decisions
```

Future path families are `audio/sfx/ui/`, `audio/sfx/gameplay/`, `audio/music/`; do not create them.

## 16. License/provenance checklist

Create `docs/licenses/SUBMISSION_ASSET_AUDIO_LICENSE_INTAKE_CHECKLIST_CURRENT.md`.

Require:

```text
asset_id
original_filename
source_url_or_generation_record
author_or_generator
creation_or_download_date
license_or_terms
license_text_snapshot
commercial_game_permission
redistribution_in_game_permission
modification_permission
conversion_permission
attribution_text
modifications
final_repository_path
file_SHA256
reviewer
status
```

Statuses: `NOT_ACQUIRED`, `EVIDENCE_PENDING`, `VERIFIED_FOR_IMPORT`, `REJECTED`, `REMOVED`.

No import before `VERIFIED_FOR_IMPORT`. Project-created and AI-assisted work still requires provenance/hash. Credits must match ledger.

## 17. Owner decision sheet

Create `docs/production/OWNER_VISUAL_AUDIO_DECISION_SHEET_CURRENT.md` with exactly ten decisions:

```text
visual_strategy_approval
paper_ink_direction_approval
YOU_ECHO_shape_approval
UI_density_approval
font_recommendation_approval
music_shortlist_audition
music_license_evidence_available
SFX_strategy_approval
finale_music_optional_or_required
no_music_fallback_acceptance
```

Each: recommended default, alternatives, deadline, effect if delayed, fallback, `owner_status = PENDING`.

## 18. Dated parallel plan

Create `docs/production/VISUAL_AUDIO_PARALLEL_EXECUTION_PLAN_CURRENT.md` covering July 30–August 12.

Lanes:

```text
V1_visual_token_and_entity_assets
V2_UI_surface_reskin
V3_font_zh_Hans_fit
A1_essential_SFX
A2_music_license_and_audition
L_license_ledger
Q_owner_review_and_QA
```

Each package: dates, owner, subagent roles, dependencies, future paths, exit evidence, hard cut, parallelizable-with.

Freeze:

```text
2026-08-03 plan and owner defaults frozen
2026-08-07 first visual token sheet and essential SFX baseline target
2026-08-12 production-eight visual/UI/zh-Hans first-pass target
```

No implementation is authorized by these dates.

## 19. Required documents

Create:

```text
docs/presentation/SUBMISSION_MINIMUM_VISUAL_UI_PRODUCTION_PLAN_CURRENT.md
docs/presentation/SUBMISSION_VISUAL_STYLE_TOKEN_SPEC_CURRENT.md
docs/presentation/SUBMISSION_MINIMUM_VISUAL_ASSET_MANIFEST_CURRENT.json
docs/presentation/SUBMISSION_MINIMUM_UI_SURFACE_MATRIX_CURRENT.md
docs/audio/SUBMISSION_MINIMUM_AUDIO_LICENSE_PRODUCTION_PLAN_CURRENT.md
docs/audio/SUBMISSION_MINIMUM_AUDIO_MANIFEST_CURRENT.json
docs/licenses/SUBMISSION_ASSET_AUDIO_LICENSE_INTAKE_CHECKLIST_CURRENT.md
docs/production/OWNER_VISUAL_AUDIO_DECISION_SHEET_CURRENT.md
docs/production/VISUAL_AUDIO_PARALLEL_EXECUTION_PLAN_CURRENT.md
docs/reports/0024BAB_SUBMISSION_MINIMUM_VISUAL_AUDIO_PLANNING_REPORT.md
docs/handoffs/DELAYED_SELF_SESSION_HANDOFF_AFTER_TASK_0024BAB_VISUAL_AUDIO_PLAN_2026_07_27.md
docs/project_source/DELAYED_SELF_PROJECT_SOURCE_SYNC_CURRENT_AFTER_0024BAB_2026_07_27.md
```

Update:

```text
docs/production/SUBMISSION_READINESS_SCORECARD_CURRENT.md
docs/production/GODOTHUB_FESTIVAL_2026_SUBMISSION_CRITICAL_PATH_CURRENT.md
docs/presentation/HAND_DRAWN_NOTEBOOK_PRESENTATION_DIRECTION_CURRENT.md
docs/audio/MUSIC_SOURCE_LICENSE_AND_AUDITION_PLAN_CURRENT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
AGENTS.md
docs/agents/PROJECT_RULE_CODEX_MULTI_SUBAGENT_MODEL_ROUTING.md
docs/project_rules/PROJECT_RULE_MULTI_SUBAGENT_AND_SUBMISSION_EXECUTION_CURRENT.md
docs/workflows/PROJECT_BOOTSTRAP_AND_TASK_WORKFLOW.md
docs/workflows/DEEPSEEK_FILE_WORKER_CLI_PILOT_WORKFLOW.md
docs/PROJECT_SOURCE_INDEX_CURRENT.md
```

Do not mark any asset/audio/font item implemented or release-ready.

## 20. Authorized paths

Only the paths listed in Section 19 may change.

Protected:

```text
docs/project_rules/PROJECT_RULE_SOURCE_SEED_CURRENT.md
docs/project_source files other than `DELAYED_SELF_PROJECT_SOURCE_SYNC_CURRENT_AFTER_0024BAB_2026_07_27.md`
docs/agents files other than `PROJECT_RULE_CODEX_MULTI_SUBAGENT_MODEL_ROUTING.md`
docs/workflows files other than `PROJECT_BOOTSTRAP_AND_TASK_WORKFLOW.md` and `DEEPSEEK_FILE_WORKER_CLI_PILOT_WORKFLOW.md`
docs/game_design/**
data/**
scripts/**
scenes/**
project.godot
schemas/**
tests/**
localization/**
assets/**
audio/**
shaders/**
build/**
export/**
release/**
submission/**
docs/playtest/**
docs/reviews/**
all existing reports/evidence
D:\Delayed_Self\.codex\config.toml
C:\Users\zcxve\.codex\**
```

Read-only implementation inspection is authorized. Profile/player data is forbidden.

## 21. Startup gate

Require root/branch/origin, no Git operation, fetch/fast-forward only, `HEAD == origin/main`, divergence `0/0`, Task 0024BAB v2/current pointers, checkpoint `677a812d1ecf9c6b87309cab3591cdfc87c2860e` and historical 0024BAB startup `95f00cc91b2d93dcd16332f7991e7fddd696ef05` in ancestry, clean tracked/staged state, only `.codex/config.toml` untracked with unchanged hash, and Godot process count zero.

## 22. Validation

Run Git status/diff checks.

Require:

```text
multi_subagent_mode = MANDATORY
distinct_subagent_roles_used >= 5
subagent_Git_writes = 0
subagent_Godot_or_solver_runs = 0
subagent_Profile_access = 0
config_hash_unchanged = YES
submission_scope = STABLE_EIGHT_LEVELS
production_catalog_count = 8
formal_finale = sequence_8
S04 = DEFERRED_POST_SUBMISSION
visual_strategy_recommendation = EXACTLY_ONE
audio_strategy_recommendation = EXACTLY_ONE
font_recommendation = EXACTLY_ONE
visual_manifest_items > 0
audio_manifest_sfx_items >= 10
UI_surfaces = 12
owner_decisions_required = 10
music_shortlist_limits_respected = YES
unresolved_license_treated_as_permission = NO
mandatory_audio_fallback = ESSENTIAL_SFX_ONLY_NO_MUSIC
asset/audio/font_generation_or_import = NO
Godot/solver/Profile = NO
catalog/finale modification = NO
deepseek_user_gate = DEEPSEEK_MCP_CONFIG_REMOVAL_ACCEPTED
deepseek_mcp = REMOVED
deepseek_native_provider = FORBIDDEN
deepseek_automatic_native_subagent = FORBIDDEN
deepseek_formal_route = WRAPPER_BACKED_CLI_EXTERNAL_FILE_WORKER
deepseek_counts_as_GPT_subagent = NO
deepseek_task_JSON_contains_secret = NO
deepseek_user_scope_files_modified = NO
deepseek_MCP_fallback = FORBIDDEN
deepseek_wrapper_worker_hashes = MATCH_ACCEPTED / BLOCKED
deepseek_smoke_retest = NOT_REQUIRED_UNCHANGED_HASH / BLOCKED_HASH_CHANGED
project_source_package_created = YES
project_source_SHA256_recorded = YES
```

Parse both JSON manifests; validate enums and repository-relative future paths. Check Markdown links and UTF-8.

## 23. One-commit policy

Exactly one commit:

```text
docs: freeze visual audio plan and wrapper-only DeepSeek route
```

Before commit: complete routing ledger, documents/manifests, count/enum/link consistency, fetch/divergence check, explicit staging, staged allowlist, `git diff --cached --check`, full staged diff, config unchanged.

Push main and require synchronized remote, clean tracked/staged, only `.codex/config.toml` untracked and Godot zero. Post-push omission means `BLOCKED`; no second implementation commit.

## 24. Required final fields

```text
task_0024baa_status = TASK_0024BAA_PROJECT_RULE_MULTI_SUBAGENT_AND_SUBMISSION_REBASELINE_ACCEPTED
multi_subagent_mode = MANDATORY / INCOMPLETE
distinct_subagent_roles_used = <count>
submission_scope = STABLE_EIGHT_LEVELS / OTHER
visual_strategy_recommendation = RECOMMEND_VISUAL_V1 / RECOMMEND_VISUAL_V2 / RECOMMEND_VISUAL_V3 / RECOMMEND_VISUAL_HYBRID_V1_V2
font_recommendation = RECOMMEND_LXGW_PENDING_LICENSE_COVERAGE_GATE / RECOMMEND_LICENSED_FALLBACK_FIRST / RECOMMEND_DUAL_FONT_TEST_GATE
audio_strategy_recommendation = RECOMMEND_AUDIO_A1 / RECOMMEND_AUDIO_A2 / RECOMMEND_AUDIO_A3
mandatory_audio_fallback = ESSENTIAL_SFX_ONLY_NO_MUSIC
visual_manifest_items = <exact>
audio_SFX_items = <exact>
music_shortlist_items = <exact>
UI_surface_rows = 12
owner_decision_rows = 10
asset_generation_or_import = NO / YES
audio_generation_or_import = NO / YES
font_download_or_import = NO / YES
production_catalog_modified = NO / YES
formal_finale_modified = NO / YES
Profile_accessed = NO / YES
Godot_or_solver_run = NO / YES
deepseek_user_gate = DEEPSEEK_MCP_CONFIG_REMOVAL_ACCEPTED / OTHER
deepseek_formal_route = WRAPPER_BACKED_CLI_EXTERNAL_FILE_WORKER / OTHER
deepseek_MCP = REMOVED / PRESENT
deepseek_native_provider = FORBIDDEN / OTHER
deepseek_automatic_native_subagent = FORBIDDEN / OTHER
deepseek_wrapper_used = YES / NO
deepseek_wrapper_worker_hashes = MATCH_ACCEPTED / BLOCKED_HASH_CHANGED / NOT_VERIFIED
deepseek_fail_closed = YES / NO
deepseek_smoke_retest = NOT_REQUIRED_UNCHANGED_HASH / BLOCKED_HASH_CHANGED / NOT_VERIFIED
Project_Source_package = docs/project_source/DELAYED_SELF_PROJECT_SOURCE_SYNC_CURRENT_AFTER_0024BAB_2026_07_27.md
Project_Source_SHA256 = <exact>
next_recommended_task = <exact identity or HOLD_FOR_OWNER_VISUAL_AUDIO_DECISIONS>
final_task_verdict = PASS_FOR_GPT_REVIEW / BLOCKED
```

## 25. Next gate

Recommend exactly one next implementation gate, without publishing/executing it:

```text
submission-minimum visual token sheet and UI prototype authoring
essential SFX creation and bus integration
font/zh-Hans license and fit qualification
combined visual-token + essential-SFX first baseline
HOLD_FOR_OWNER_VISUAL_AUDIO_DECISIONS
```

Do not reopen S04.
