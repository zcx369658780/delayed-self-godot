# Task 0011RV owner window-fill retest

- Reviewer: `authenticated_project_owner`
- Review status: `NOT_FRESH_NOT_BLIND_OWNER_WINDOW_FILL_RETEST`
- Date: 2026-07-16
- Accepted implementation commit: `a07c4be075aaa5c57e9d48869392f29dadaaa1d5`
- Execution-task baseline: `ec46bf9ec4f5b545cd97a752d2a9ed0e0fc22725`
- Environment: Windows, Godot `4.7.stable.steam.5b4e0cb0f`, Compatibility renderer
- Product surface: `STANDALONE_NATIVE_GAME_WINDOW`
- Selected branch: `EMBEDDED_PREVIEW_ONLY_NOT_PRODUCT_WINDOW_BLOCKER`

## Qualification and scope

The reviewer is the authenticated project owner and had already seen the accepted levels and earlier presentation surfaces. This review is not fresh, blind, first-player, or independent. It is limited to physical-window fill, centering, resize, route/state preservation, and input behavior. It does not re-review level difficulty or establish candidate acceptance.

The product evidence came from a separate native game process started directly from the terminal:

```text
"D:\Program Files (x86)\Steam\steamapps\common\Godot Engine\godot.windows.opt.tools.64.exe" --path D:\Delayed_Self
```

The process had PID `25368`, window title `Delayed Self (DEBUG)`, and no `--editor` or `--headless` flag. No embedded editor preview, Codex Browser, or hosted preview was used as standalone product evidence.

## Accepted diagnostic baseline

Task 0011RVD produced two fresh native runs with exit code `0`. Both runs contained all seven accepted markers:

```text
TASK_0003_TESTS_PASS assertions=314 vectors=9
TASK_0006_APP_SHELL_TESTS_PASS
TASK_0007_TUTORIAL_LEVELS_TESTS_PASS
TASK_0008_PROGRESSIVE_HUD_TESTS_PASS
TASK_0009AR_LEVELS_4_5_TESTS_PASS
TASK_0011_PRESENTATION_RECOVERY_TESTS_PASS
TASK_0011R_WINDOW_FILL_TESTS_PASS
```

The prior baseline stop is classified as `FALSE_BLOCKER_EXPECTED_NEGATIVE_PATH_STDERR`: `LEVEL_ID_MISMATCH` was the expected tested negative path, not a regression.

## Generated-worktree incident and bounded cleanup

Before the standalone retest, a Godot tool process had rewritten tracked `project.godot` and generated 24 untracked `.gd.uid` files. The full diff, status, hashes, stage record, UID paths/metadata, process state, and prior screenshot reference were preserved under the authorized external evidence root.

Safety checks established that `project.godot` was the only tracked change, each UID path was individually untracked and ended exactly in `.gd.uid`, no accepted tracked file required those generated artifacts, and no Godot process remained. Cleanup used only:

- `git restore --source=HEAD --worktree -- project.godot`;
- 24 explicit `Remove-Item -LiteralPath '<exact individual path>'` operations.

No `git clean`, wildcard deletion, recursive deletion, directory restore, reset, checkout, rebase, amend, force operation, or broad staging was used. The worktree was clean before launch. After the owner closed the standalone client, no Godot process remained, the worktree was still exactly clean, and no second-wave cleanup was required.

## Standalone surface discrimination

The earlier screenshot showed the small centered presentation on `GODOT_EDITOR_EMBEDDED_PREVIEW`. The standalone native client did not reproduce it. The owner reported that the standalone presentation enlarged to fill the screen/client and continued to scale with the game window. The former right/bottom asymmetric gray L-shaped region was absent. A deliberately non-16:9 client used symmetric dark bars that the owner considered natural.

## Direct owner answers

The owner's exact answers to the ten Task 0011RVE questions were:

1. `是`
2. `是`
3. `否，拉伸到全屏了`
4. `是，比较自然`
5. `是`
6. `否`
7. `否`
8. `只在嵌入式预览，会随着游戏窗口而缩放。`
9. `同意。`
10. `没发现`

These answers confirm consistent scaling across Main Menu, Level Select, Gameplay, and Help; no route, level, turn, history, Help-state, or input change on resize; and no dropped, duplicated, reordered, or synthesized input.

## Findings and classification

Finding counts for this bounded window-fill retest: P0=0, P1=0, P2=0, P3=0.

Selected classification:

```text
EMBEDDED_PREVIEW_ONLY_NOT_PRODUCT_WINDOW_BLOCKER
```

The former asymmetric window-fill defect is closed on the standalone native client. The prior small-centered-canvas observation belongs to the embedded preview surface and is not a product-window blocker. The owner found no P0, P1, or blocking P2 and still agrees to proceed toward the planned difficult Level 6 after GPT final adjudication.

## Evidence index

External evidence root: `D:\Delayed_Self_Evidence\0011RVE_cleanup_and_standalone_retest\`.

- `EVIDENCE_INDEX.md` records evidence sizes and SHA-256 hashes.
- `EVIDENCE_INDEX.md` SHA-256: `9733BF788745ADF8CDEF7BB3556B5E2149FECB7891D05A486D6562C821C0529E`.
- `owner_direct_answers.txt` SHA-256: `E4E697125446770EFE712991BCAAA87F3B1EB08ECA412AC39A7A72350897C34B`.
- `standalone_session_record.txt` SHA-256: `D007BF2B889CCD22075AC9776EF11C4EDB1581650469C3F922CA9C10FB04FA96`.
- Initial `project.godot` diff SHA-256: `6411FACDD6958E599651769D0E65E4CF7BC90D882F69DDA2B5DAF37AE6FC9267`.
- Initial 24-file UID metadata SHA-256: `4E48B56479A1320C7AF66AD5270714C500EFDA01B2080272BBBE47B4899FBBE3`.
- Prior screenshot SHA-256: `7A03A2F332E5FB2072E9A7A171CF5980347BBA01DCF03B8B216BC2BB53262629`.

External evidence is not staged in the repository.

## Non-claims and recommendation

No implementation, project-setting baseline, scene, test, level, catalog, schema, asset, font, audio, gameplay, save, export, release, or repository-setting change was made. This retest does not establish final responsive layout, final art, asset/font clearance, accessibility, localization, fresh/independent review, `CANDIDATE_ACCEPTED`, complete flow, export, release, or submission readiness.

Recommend GPT accept the authenticated-owner window-fill retest, close the embedded-preview observation as not a standalone product blocker, and separately authorize the planned difficult Level 6 `staggered_doors`. This document does not itself authorize Level 6.
