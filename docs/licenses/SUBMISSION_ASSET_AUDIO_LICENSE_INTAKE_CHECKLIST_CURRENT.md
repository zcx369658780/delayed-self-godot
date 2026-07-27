# Submission asset/audio license intake checklist (CURRENT)

This checklist feeds, and does not replace, `THIRD_PARTY_ASSET_LEDGER_CURRENT.md` and `ATTRIBUTION_CURRENT.md`. No file may be imported before `status = VERIFIED_FOR_IMPORT`; no current item has that status.

| Required field | Rule |
|---|---|
| asset_id | stable manifest identifier |
| original_filename | exact source filename |
| source_url_or_generation_record | original URL or dated project-creation record |
| author_or_generator | legal author/source/tool identity |
| creation_or_download_date | ISO date |
| license_or_terms | exact license/terms identity |
| license_text_snapshot | retained readable evidence |
| commercial_game_permission | explicit YES required |
| redistribution_in_game_permission | explicit YES required |
| modification_permission | explicit value |
| conversion_permission | explicit value |
| attribution_text | exact shipping copy or NONE |
| modifications | complete transformation record |
| final_repository_path | repository-relative target |
| file_SHA256 | exact final bytes |
| reviewer | accountable reviewer |
| status | enum below |

Allowed statuses: `NOT_ACQUIRED`, `EVIDENCE_PENDING`, `VERIFIED_FOR_IMPORT`, `REJECTED`, `REMOVED`.

Project-created procedural/vector/SFX work still records creation, author, modifications and final hash. AI-assisted concepts require tool/model, generation record, owner transformation record, terms evidence and final hash. Credits and ledger must match. Missing or ambiguous commercial, redistribution, modification or conversion permission means `REJECTED` or `REMOVED`, never implied permission.
