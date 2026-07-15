# Asset, font, and audio license/pipeline plan (CURRENT)

- Status: `PLANNING_RECOMMENDATION_FOR_GPT`; no candidate is approved, downloaded, imported, or release-cleared.
- Research date: 2026-07-16.
- Existing authority: [`THIRD_PARTY_ASSET_LEDGER_CURRENT.md`](../licenses/THIRD_PARTY_ASSET_LEDGER_CURRENT.md) remains empty and authoritative.
- Rule: “free,” a storefront label, or a license name without source evidence is insufficient.

## Acceptance policy

| Class | Policy |
|---|---|
| CC0 / public-domain-equivalent | preferred; preserve provenance and the exact dedication/reference even when attribution is not required |
| CC-BY 4.0 | conditionally acceptable with author/title/source/license link, modification note, and shipped attribution |
| MIT / BSD | conditionally acceptable when the grant clearly covers the actual asset/code files; preserve notice text |
| SIL OFL 1.1 fonts | conditionally acceptable; preserve OFL text, copyright, Reserved Font Names, and rename modified fonts when required |
| custom permissive license | separate legal/product decision before download or use |
| unclear, custom no-redistribution, non-commercial, no-derivatives, incompatible share-alike, ripped/derivative commercial-game assets | prohibited without a separate legal decision; default reject |
| AI-generated media | prohibited when model/source rights, training/output terms, authorship, or redistribution rights are unclear; separate decision required even for user-generated output |
| missing source or license evidence | prohibited, regardless of file availability |

For every accepted file/package preserve: asset ID, exact title/version, original publisher page, direct source or release reference, author/publisher, acquisition date, exact license and full text/stable reference, attribution string, original and local filenames, modifications, intended use, import settings, cryptographic hash, reviewer, and approval status.

## Provenance and import gate

Continue using the tracked path `docs/licenses/THIRD_PARTY_ASSET_LEDGER_CURRENT.md`; a later asset-acquisition task may expand its table or introduce a machine-readable companion only with explicit authorization. Store license texts/snapshots under a future `docs/licenses/third_party/<asset_id>/` path and generate `docs/licenses/ATTRIBUTION_CURRENT.md` from accepted entries before a candidate.

Template only—these are field names, not imaginary assets:

| Field | Required value |
|---|---|
| `asset_id` | stable lower-snake-case ID |
| `title_version` | exact package/file title and version/release |
| `source_url` | original publisher/author page |
| `author_publisher` | credited creator and publisher |
| `acquired_utc` | download timestamp from the future acquisition gate |
| `original_files` / `local_files` | every used filename mapping |
| `license_spdx_or_name` | exact license; `LicenseRef-*` for reviewed custom terms |
| `license_evidence` | stored text/snapshot plus stable authoritative URL |
| `attribution_required` / `attribution_string` | exact obligation and shipped wording |
| `modifications` | crop, recolor, resample, edit, loop, normalize, etc. |
| `intended_use` | entity/UI/SFX/music role |
| `import_settings` | Godot filter, mipmap, loop, compression, sample-rate choices |
| `sha256` | hash of original and transformed files |
| `approval_status` | `RESEARCH_ONLY`, `DOWNLOADED_PENDING_REVIEW`, `DEV_PLACEHOLDER`, `RELEASE_CLEARED`, or `REJECTED` |
| `approved_by_commit` | exact later acceptance commit |

Future import sequence:

1. approve one acquisition task and exact source page;
2. capture license/source evidence before or with download;
3. hash and inventory the archive without importing;
4. review file-level contents, embedded licenses, fonts, and unwanted executables;
5. create ledger entry and attribution text;
6. import only approved files with explicit Godot settings;
7. run visual/audio, repository-size, and license-ledger tests;
8. GPT acceptance before release-cleared use.

## Visual directions

### Direction V1 — minimalist temporal-neon laboratory (recommended)

- Dark desaturated facility floor and walls; restrained cyan, violet, amber, and red/green-independent state shapes.
- YOU: solid pale suit/core with `Y`, cyan directional notch.
- ECHO: same silhouette as YOU but hollow/dashed, purple trail, delay badge when multiple delays exist.
- Floor/walls: low-detail modular panels; walls use mass and edge lighting, not only darkness.
- Plates: recessed amber rings with pressed depth and dependency port.
- Combinational Doors: framed barriers with visible per-Plate pips and live circuit paths.
- EXIT: persistent diamond/beacon with word/icon overlay.
- UI: translucent laboratory panels, limited line lengths, high-contrast type.
- Temporal effects: dotted replay trail, one-way dependency pulse, restrained scan noise.

Advantages: evolves current readable primitives, works with scalable procedural/vector art, lowest animation cost, supports precise Door feedback, and matches the delayed-signal narrative. Risk: generic “neon sci-fi” if environment motifs and typography are not disciplined.

### Direction V2 — readable pixel-art maintenance station

- 30/60 px or 32/64 px modular tiles, compact maintenance robot, ghosted pixel ECHO, industrial switches and doors.
- Advantages: abundant low-cost packs, tactile personality, clear grid, easy authored environmental details.
- Costs/risks: current 60 px pitch does not map cleanly to every pack; mixed pixel densities and nearest-neighbor scaling can look inconsistent; Chinese UI still requires a separate readable font; character/door animation workload is higher.

### Selection

Choose V1 for the first licensed visual pass. Use external packs as modular references/components, not as permission to combine incompatible styles. Freeze one palette, outline weight, cell scale, and entity silhouette sheet before replacing every primitive. If one coherent pack proves substantially cheaper and passes readability captures, V2 may be reconsidered by the owner in the asset-acquisition gate.

## Research-only visual shortlist

All Kenney pages below were reached successfully on 2026-07-16 and identify `Creative Commons CC0`. Publisher/author is Kenney. CC0 imposes no attribution requirement, but the project should still credit the source and preserve the [CC0 1.0 reference](https://creativecommons.org/publicdomain/zero/1.0/).

| Candidate | Stable source | Exact license / attribution | Relevant content and fit | Risks / missing decisions |
|---|---|---|---|---|
| Kenney **Sci-Fi RTS** | https://kenney.nl/assets/sci-fi-rts | Creative Commons CC0; attribution not legally required | top-down sci-fi structures/units; possible facility modules and silhouettes | RTS visual scale and perspective may not fit 60 px puzzle cells; file-level audit still required |
| Kenney **UI Pack - Sci-Fi** | https://kenney.nl/assets/ui-pack-sci-fi | Creative Commons CC0; attribution not legally required | panels, buttons, icons for a coherent laboratory HUD | could feel ornamental or consume board area; typography not included as a Chinese solution |
| Kenney **1-Bit Pack** | https://kenney.nl/assets/1-bit-pack | Creative Commons CC0; attribution not legally required | broad monochrome icon/tile vocabulary; easy recolor and state shapes | 1-bit style may be too abstract and inconsistent with soft neon; selective icon use only |

No package was downloaded. Exact archive version, contained filenames, hashes, and embedded license text remain `NOT_ACQUIRED / NOT_VERIFIED`.

## Font candidates and gate

| Candidate | Author/publisher | Source / license evidence | Intended role | Risk |
|---|---|---|---|---|
| Source Han Sans | Adobe and project contributors | https://github.com/adobe-fonts/source-han-sans — SIL Open Font License 1.1 in `LICENSE.txt`; Reserved Font Name `Source` | Chinese-first UI and narrative | large CJK files; subset/weight choice and Godot import size require review |
| Atkinson Hyperlegible Next | Atkinson Hyperlegible Next Project Authors / Google Fonts repo | https://github.com/googlefonts/atkinson-hyperlegible-next — SIL OFL 1.1 in `OFL.txt` | Latin fallback, numbers, accessibility tests | does not replace the Chinese face; mixed metrics require layout testing |

Recommendation: evaluate Source Han Sans as the single Chinese/Latin UI family first; add Atkinson only if measured legibility outweighs mixed-family complexity. A font task must pin an exact release, retain OFL/copyright, test Chinese glyph coverage, check Reserved Font Names, and verify package size. Godot fallback font remains until then.

## Research-only audio/music shortlist

| Candidate | Author/publisher | Stable source | Exact license / attribution | Relevant content and fit | Risks |
|---|---|---|---|---|---|
| Kenney **UI Audio** | Kenney | https://kenney.nl/assets/ui-audio | Creative Commons CC0; attribution not legally required | menu navigation, confirm/cancel, compact UI feedback | sounds may be overused or too generic; file audition and loudness audit required |
| Kenney **Digital Audio** | Kenney | https://kenney.nl/assets/digital-audio | Creative Commons CC0; attribution not legally required | ECHO replay, Plate pulse, Door state layers | tonal palette must avoid fatigue and preserve event distinction |
| Kenney **Interface Sounds** | Kenney | https://kenney.nl/assets/interface-sounds | Creative Commons CC0; attribution not legally required | additional blocked/move/menu candidates | overlap with UI Audio; choose one coherent subset, not both wholesale |
| **cc0 space music** | madeso / OpenGameArt | https://opengameart.org/content/cc0-space-music | CC0 per publisher page/description; attribution not required, credit recommended | calm/semi-calm space music; page exposes `MyVeryOwnDeadShip.ogg`, `ObservingTheStar.ogg`, and `OutThere.ogg` | loop points, normalization, exact original metadata, and file integrity not yet reviewed |
| Kenney **Music Jingles** | Kenney | https://kenney.nl/assets/music-jingles | Creative Commons CC0; attribution not legally required | level completion/menu stings | jingles are not low-distraction gameplay loops; use sparingly |

The shortlist exceeds the required three audio/music sources but does not accept any file. OpenGameArt is a hosting/source page; a later task must preserve the individual creator record and verify the actual downloaded file license/metadata.

## Minimal audio set

Priority 1, state-critical:

- player move: short, centered, dry;
- blocked move: lower/duller, clearly not a valid displacement;
- ECHO replay/move: filtered tail or shifted pitch distinct from player;
- Plate press and release: paired on/off cues;
- Door open and close: paired rising/falling cues synchronized with visible state;
- level completion: brief non-looping resolution.

Priority 2, product flow:

- menu move/confirm/back;
- one low-distraction facility/space loop for early levels;
- a second sparse variation or layered stem for the finale only if schedule permits.

Mixing targets are proposals for a later audio task: keep routine SFX peaks consistent, Duck music 2–4 dB during critical Door/Plate cues, limit identical rapid sounds, avoid hard panning of essential information, and test laptop speakers/headphones. Music must loop without clicks and leave temporal rhythm space for ECHO cues.

Controls/settings boundary:

- master, music, and SFX volume plus mute are candidate requirements;
- defaults and session-only behavior may be tested first;
- persistent settings path/format/migration remain a separate protected save/settings gate;
- audio must never be the sole state channel; captions/icon feedback remain functional at mute;
- reduce repetitive high-frequency cues and provide a safe minimum/maximum range.

## First visual/audio production slice

1. Complete board/HUD and primitive Door feedback before asset import.
2. Acquire at most one visual pack, one UI pack if needed, one font family, one SFX pack, and one music source under separate authorization.
3. Build a single representative Level 4/5 style sheet and audio event map.
4. Compare against the primitive baseline at 960×540, grayscale, mute, and reduced motion.
5. Reject packs that reduce entity/state readability even when aesthetically stronger.

## Stop conditions

Stop acquisition/import on missing exact license, redirected/unverifiable source, unclear author, prohibited terms, archive executables, inconsistent file-level licenses, unmanageable attribution, unbounded package size, or visual/audio cues that become the only way to read state. No candidate becomes `RELEASE_CLEARED` through this planning document.
