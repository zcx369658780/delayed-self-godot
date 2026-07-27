# Crow Producer music license evidence (CURRENT)

- Task: `0024BAE_OWNER_VISUAL_ENTITY_AUDIO_FEEDBACK_AND_MUSIC_TRIAL_REPAIR`
- Task scope: visual/audio repair with conditional music trial
- Status: `IMPORT_VERIFIED`
- Capture date: `2026-07-27`
- Previous decision dependency: `TASK_0024BAC_DEEPSEEK_WRAPPER_WORKER_IDENTITY_BASELINE_ACCEPTED`
- `DeepSeek_optional_delegation = NOT_USED`

## Source inputs used for gate

- Bilibili video: `https://www.bilibili.com/video/BV1uFcwe1EDV`
- Google Drive folder: `https://drive.google.com/drive/folders/1ce8LP87A2Yc1xRLvaCpZr13KI5S-f_Aw?usp=sharing`
- Direct file record: `https://drive.google.com/file/d/1ID9Fy3Xmt7erOrORCblrEuGxMQsG1nhv/view`

## Recorded terms

These are the source-supported terms frozen by the authorized Task 0024BAE from the three locators above; this report does not
add a legal interpretation beyond the recorded terms.

| Term | Recorded value |
|---|---|
| copyright holder | 乌鸦Producer |
| commercial-game use | allowed, no extra royalty |
| attribution | `音乐由[乌鸦Producer]提供` |
| exclusivity | non-exclusive |
| resale | no direct resale |
| legal basis | applicable-law compliant |
| editing/conversion permission | unchanged/no conversion/resampling |

## Candidate track audit list (project evidence + conditional trial result)

| Track | File/record ID | Size (bytes) | Proposed use | Evidence status | Planned attribution placement |
|---|---|---:|---|---|---|
| 晚安，星期八.wav | `1zucejf8-pe6sjPPe2fuVw62qY8F6icrY` | 34,440,316 | menu | planning-only | Credits / credits panel |
| 优哉游哉(loop).wav | `1_l8gcHescLwdhJ3X_8Xco48zYX96vRSO` | 25,404,968 | gameplay | **TRIAL_IMPORTED_ORIGINAL_BYTES_VERIFIED** | Credits / credits panel |
| 宇宙，我，和她.wav | `10O2IFtbbm4xkZ-mS3h8ZVi8YObAzDiSH` | 45,826,638 | optional finale | planning-only | Credits / credits panel |

## Verdict fields relevant to Task 0024BAD

- `Crow_Producer_license_status`: `COMMERCIAL_USE_ATTRIBUTION_CONFIRMED_EDIT_NO_CONVERSION`
- `music_imported`: `YES`
- `third_party_graphics_imported`: `NO`
- `font_imported`: `NO`
- `production_catalog_modified`: `NO`
- `formal_finale_modified`: `NO`
- `Profile_accessed`: `NO`
- `next_gate`: `OWNER_VISUAL_AUDIO_REPAIR_REVIEW`
- `final_task_verdict`: `PASS_FOR_GPT_REVIEW` (audio baseline evidence package only)

## Hard boundary notes

- Imported music bytes are exact and unchanged:
  - `audio/music/crow_producer/优哉游哉(loop).wav`
  - SHA `E4552E433479AECD0790A901A84E9738448B7092BEE51109E0D748A8B9F3E850`
  - source size `25,404,968`
  - duration `144.017868s`
  - sample format `PCM 16-bit stereo 44100Hz`
- Required credit text is fixed and must be preserved exactly: `音乐由[乌鸦Producer]提供`.
