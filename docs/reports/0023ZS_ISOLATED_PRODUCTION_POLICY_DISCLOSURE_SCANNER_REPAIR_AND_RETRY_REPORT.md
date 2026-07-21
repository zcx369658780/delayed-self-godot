# Task 0023ZS isolated production-policy disclosure-scanner repair and retry report

- Terminal verdict: `ISOLATED_PRODUCTION_POLICY_SANDBOX_MATRIX_DISCLOSURE_RETRY_READY_FOR_GPT_REVIEW`
- Repository checkpoint: `6b40c0fbb590795714bdab6a32af6caacb35e2f1`
- Accepted implementation under test: `afe8c6fffdc98992b732fce46f206ad0dc8553a1`
- Runtime authority: fresh process-local APPDATA/LOCALAPPDATA sandboxes only
- Ordinary production Profile/test-root authority: none

## Startup continuation identity

The worktree contained exactly the five authorized untracked harness files, no
staged or modified/deleted tracked paths, no Git operation and zero Godot
processes. Both historical audits existed and the fresh retry root was absent.

| Path | Startup SHA-256 | Bytes | Lines | Differs from 0023ZR start |
|---|---|---:|---:|---|
| `tests/app/task_0023zq_capture_isolated_production_policy.ps1` | `887d3b20319be7b472d0afa73ade6a26db8103578b582fa4ba0a0754ccc396e0` | 15105 | 326 | yes, retained launcher repair |
| `tests/app/task_0023zq_isolated_production_policy_case.gd` | `a4c195f8216f15a2eb188687896c351fd6886c725175607a8f33e2151a375c25` | 28603 | 609 | no |
| `tests/app/task_0023zq_isolated_production_policy_manifest.json` | `aa96b15a33a7951642bbf08542cbdc2d298b3beb8da913fdb02cc22775a96a24` | 7800 | 73 | no |
| `tests/app/task_0023zq_isolated_production_policy_parser_smoke.gd` | `8a638516c9cdd166a06aa8e68034a2d5da8ba36f656693f99002f57c8d6f10ed` | 1443 | 43 | no |
| `tests/app/task_0023zq_isolated_production_policy_validator.gd` | `c8c1b2277578c9700ba04d1e8fdb2c6837267703a3772934cf43b83ece2a315e` | 12720 | 204 | yes, retained launcher proof |

The startup record is retained externally as
`0023zs_startup_untracked_identities.json`.

## Bounded repair

The qualified `ProcessStartInfo.FileName` plus one `ArgumentList` entry per
Godot argument remains the only launch path. The runner now uses one explicit
drive-path helper with left-boundary regex
`(?<![A-Za-z0-9+.\-])[A-Za-z]:[\\/]` and a separate active UNC classifier.
It does not strip URIs, blanket-allow `://`, whitelist the Godot banner or
downgrade disclosure failures.

The case harness changed only its attested evidence constant to the exact fresh
`0023ZS_disclosure_scanner_retry` root. The manifest and parser remain at their
startup hashes. The validator was minimally reinforced for the retained
launcher, boundary regex, vector inventory, UNC detection, fresh root and
anti-weakening rules; its final deterministic count is 393 assertions.

## Qualification and requalification

- Scanner qualification: 11/11 assertions; five drive positives, one UNC
  positive and five drive-category negatives.
- Required genuine drive forms, including `file:///C:/...`, were detected.
- HTTP/HTTPS, Godot banner, `res://` and `user://` vectors were not classified
  as Windows drive paths.
- Real Godot banner/parser qualification: native exit 0, empty stderr, parser
  marker once, zero disclosure/behavior/attestation/case markers, seven
  separately bound string arguments and zero residual processes.
- Pre-behavior zero-I/O validation: 14/14 passed.
- No-guard proof: native exit 2, guard-blocked marker once, attestation and
  behavior markers zero, empty stderr and retry root still absent.

Only after those gates passed was the exact fresh retry root created.

## Two fresh matrix attempts

| Attempt | Cases | Marker rows | Disclosure | Classification | Cleanup |
|---|---:|---:|---|---|---|
| `attempt_1` | 22/22 | 132/132 | PASS | `PASS_COMPLETE_MATRIX` | complete |
| `attempt_2` | 22/22 | 132/132 | PASS | `PASS_COMPLETE_MATRIX` | complete |

Each attempt used a separately absent APPDATA/LOCALAPPDATA sandbox, attested
before Profile/configuration/filesystem behavior, exited with empty runner
stderr and left zero Godot processes. Each owned `appdata`, `localappdata` and
`case_data` tree is absent after exact cleanup; only retained stdout, stderr
and audit evidence remains.

## Post-pass and preservation

The scanner qualification passed again at 11/11. Focused parser/validator and
the complete post 14/14 matrix passed with native exit 0, empty stderr, exact
markers and zero process residue. All ten manifest-frozen product/project
hashes match; every tracked path outside the authorized current/report docs
remained unchanged, covering the frozen catalog, formal data, historical
harnesses, main scene and autoload state.

Historical evidence remained byte-identical:

- `blocked_attempt_1_invocation_audit.json` —
  `a11abdba6cadcc3f640a42b634e397992845491080dbec2ca3e590218d037a2b`
- `0023zr_blocked_attempt_1_audit.json` —
  `47902b62fa8845dd4aa1fbede44b2d67a39f7947bc657c55dedef31cea17d5a2`

The retained historical 0023ZR Attempt 1 remained present and was neither
enumerated, reused, relabeled nor modified.

## Protected-data statement and non-claims

No ordinary production Profile, metadata, parent, sibling, ordinary user-data
location, test root or historical fixture was opened, probed, enumerated or
modified. No persistent environment change, symlink, junction, project-setting
change, product repair or behavior-expectation weakening occurred.

This result proves only the frozen production-policy behavior inside two fresh
process-local external sandboxes. It does not establish or authorize real
Profile access/recovery/write, default activation, aggregate registration,
Menu New/Continue/Reset, settings/localization, build/export, RC, release,
upload or festival submission readiness.
