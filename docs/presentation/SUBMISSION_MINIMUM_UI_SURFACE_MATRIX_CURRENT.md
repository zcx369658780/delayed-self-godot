# Submission-minimum UI surface matrix (CURRENT)

Exactly 12 audited rows; all zh-Hans strings are planning targets, not implemented localization.

| # | Surface | Current scene/script | Status | Tokens | zh-Hans strings | Focus navigation | Feedback | Asset/audio dependencies | Owner question | Future test | Cut policy |
|---:|---|---|---|---|---|---|---|---|---|---|---|
| 1 | title_main_menu | `main_menu.tscn`, app shell | IMPLEMENTED_NOT_RELEASE_READY | paper, title ink, focus | 迟到的我、开始、继续、设置、退出 | ordered keyboard loop | focus/confirm | title panel; UI SFX | title treatment? | keyboard/1080p | cut decoration |
| 2 | continue_new_game | app root/main menu | IMPLEMENTED_NOT_RELEASE_READY | warning, focus | 继续、新游戏、确认覆盖 | explicit confirm/cancel | warning/confirm/back | dialog tokens; UI SFX | overwrite wording? | fresh/existing profile fixture | never cut confirmation |
| 3 | level_select | `level_select.tscn/.gd` | IMPLEMENTED_NOT_RELEASE_READY | locked/completed/selected | 关卡选择、已完成、未解锁、返回 | grid movement and return | focus/confirm/back | state badges; UI SFX | density? | all 8 states/text fit | cut thumbnails |
| 4 | gameplay_board | `vertical_slice.tscn/.gd` | IMPLEMENTED_NOT_RELEASE_READY | grid, YOU/ECHO/exit/plate/door | 目标、回合、出口 | gameplay keys; Esc route | movement/blocked/state | entity tokens; gameplay SFX | ink weight? | 8-level screenshots | never cut readability |
| 5 | timeline_history_HUD | timeline model + HUD | IMPLEMENTED_NOT_RELEASE_READY | current/echo pointers | 时间线、当前、回声将在… | no focus; readable HUD | state-change cue | glyphs; optional UI cue | compact density? | E2/E3/E4 fit | cut animation |
| 6 | help_tutorial | HUD help card | IMPLEMENTED_NOT_RELEASE_READY | help panel, glyphs | 目标、操作、实体说明、返回 | H toggle, Esc close | open/close | panel/icons; UI SFX | wording length? | all HUD modes | retain essential help |
| 7 | settings | app shell settings | IMPLEMENTED_NOT_RELEASE_READY | selected/disabled/focus | 设置、语言、音量、减少动态 | linear/tab loop | focus/confirm | controls; UI SFX | exposed options? | persistence fixture only | cut nonessential options |
| 8 | pause_return | gameplay/app route | IMPLEMENTED_NOT_RELEASE_READY | pause panel/focus | 暂停、继续、重新开始、返回选关 | explicit resume/default | confirm/back/restart | panel; UI SFX | pause vs direct Esc? | no accidental exit | retain safe return |
| 9 | level_result | gameplay completion | IMPLEMENTED_NOT_RELEASE_READY | success/restart | 完成、回合数、重新开始、返回选关 | confirm/back | completion | result panel; complete SFX | result density? | completion once | cut flourish |
| 10 | finale_ending | final acknowledgement | IMPLEMENTED_NOT_RELEASE_READY | finale ink/success | 信号迟到了。它被听见了。 | Enter/Space return, R replay | acknowledge | finale panel; optional cue | final copy? | one-shot return | music optional |
| 11 | credits_licenses | app shell/credits plan | PLANNED_NOT_IMPLEMENTED | paper list/focus | 制作、字体、音乐、音效、许可 | scrolling/back | back | font/license records | credit order? | long text/links | never cut credits |
| 12 | error_recovery | `safe_error.tscn`, app root | IMPLEMENTED_NOT_RELEASE_READY | error/focus/restart | 发生错误、重试、返回主菜单 | safe default | error/recovery | error icon; recovery SFX | technical detail level? | malformed catalog fixture | never cut recovery |

## Task 0024BAD baseline

`main_menu`, `level_select`, and production-eight gameplay now share the project-native paper/ink theme with keyboard-readable double focus, locked/available/completed marks, and explicit E2/E3/E4 badges. Status is `IMPLEMENTED_BASELINE_OWNER_REVIEW_PENDING`; other surfaces remain at their prior status.
