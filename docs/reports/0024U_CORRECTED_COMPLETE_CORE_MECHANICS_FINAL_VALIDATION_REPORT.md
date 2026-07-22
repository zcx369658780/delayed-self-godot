# Task 0024U corrected complete core-mechanics final validation report

- Verdict: `BLOCKED_COMPLETE_CORE_MECHANICS_FOUNDATION_VALIDATION`
- Final-driver execution baseline: `29af14858ab47fb2710120e1e3fb01d7e8c8e9c4`
- Required checkpoint `34e3d721a98708dc49811e5118fd2fd08e4727d4`: ancestor confirmed
- Accepted wrapper blob: `5f14eb0feff903b40311c1c7283b20e2eabbffc2`
- New pre-execution seal SHA-256: `2e2ca41e22f54f73b4566125991e2b1ec47dd4a8d052a7a96b6c51028e4e49ed`
- Exactly-once final-driver invocation: consumed
- Cases executed: `4 / 4`, each exactly once

## Corrected preparation and qualification

Task 0024U preserved the five historical Task 0024T repository artifacts, the read-only historical seal and its SHA-256 `c9f7f2eb1f781280bc9d4a778367da2cde2dfc805ce20578c42098e9bb3caf29` without modification.

Five new Task 0024U preparation artifacts were created. Pure PowerShell qualification passed before seal creation:

- scalar count `0` passed and scalar count `1` failed;
- the historical command-argument expression was rejected;
- the assigned-scalar expression was accepted;
- the exact driver contained four process-count assignments and four explicit binary comparisons;
- its AST contained zero command comparisons with `-eq` passed as an argument;
- wrapper/Godot launch count was zero;
- external seal/attempt creation count was zero;
- qualification output was bounded and deterministic.

The complete static validator then passed four exact manifest cases, 44 immutable coverage IDs, 26 frozen files, five historical Task 0024T files, the historical seal and the accepted wrapper blob. No Godot validation case ran during preparation.

The new seal was written once, immediately reverified and marked read-only. It binds all five Task 0024U artifacts, the immutable complete-v2 GDScript, all frozen files, all historical Task 0024T repository artifacts and the historical seal identity. No sealed artifact changed afterward.

## Exactly-once final session

The corrected driver passed its preconditions, created one read-only attempt record and executed all four cases in manifest order through the accepted wrapper. Godot version reported by the cases was `4.7.1.stable.steam.a13da4feb`.

| Case | Status | Native | Marker | Stderr fact | Cleanup | Godot before/after |
|---|---|---:|---:|---|---:|---:|
| `aggregate_v1_formal_regression` | `NONZERO_EXIT` | 1 | false | three lines; exact allowlist failed | 1 | 0 / 0 |
| `task_0012_standalone_regression` | `PASS` | 0 | true | empty | 1 | 0 / 0 |
| `v2_focused_foundation` | `PASS` | 0 | true | empty | 1 | 0 / 0 |
| `v2_complete_solver_replay_canonical_malformed` | `NONZERO_EXIT` | 1 | false | 32 bounded parse/load lines | 1 | 0 / 0 |

The aggregate completed 621 assertions with one failure. Its exact stderr was:

```text
TEST_FAIL: unsupported version returns UNSUPPORTED_SCHEMA_VERSION
LEVEL_ID_MISMATCH
TASK_0003_TESTS_FAIL failures=1 assertions=621
```

`LEVEL_ID_MISMATCH` remains the accepted diagnostic line, but the other two lines and native exit 1 make this case a substantive nonpass. The final pass marker was absent.

Task 0012 standalone passed with `TASK_0012_FOCUSED_PASS`, native exit 0 and empty stderr. The focused schema-v2 foundation passed with `TASK_0023ZX_PASS`, native exit 0 and empty stderr.

The immutable Task 0024T complete-v2 script failed to parse before entering its assertions. Godot reported 15 type-inference errors at lines 76, 85, 90, 103, 111, 130, 140, 148, 172, 184, 193, 196, 208, 209 and 231, followed by the final script-load failure. `TASK_0024T_V2_COMPLETE_PASS` was absent. Task 0024U explicitly froze this script, so no repair was authorized after the session.

## Lifecycle, hashes and evidence

Every wrapper invocation reported `cleanup_invocation_count=1`. No owned or unproven PID remained after any case. Godot counts were zero before and after every case and zero at session end. No unrelated process was touched.

All 26 frozen hashes and all five historical Task 0024T hashes matched before and after the session. The changed-path audit remained limited to the five sealed Task 0024U preparation paths. Production Profile, ordinary user data and test-profile root were not accessed.

External evidence root:

```text
D:\Delayed_Self_Evidence\0024U_corrected_complete_core_mechanics_final_validation
```

- `pre_execution_seal.json`: read-only; SHA-256 `2e2ca41e22f54f73b4566125991e2b1ec47dd4a8d052a7a96b6c51028e4e49ed`
- `attempt_record.json`: read-only; SHA-256 `4d6d7fdccd18c390ee9aa0b6bd0ae97ef5f44c742ace4063731642c12121424e`
- `final_summary.json`: SHA-256 `69f11128b97b1f4fa9bfb0fbcd30d91fd541be12dd986e40cccb185145a391e2`
- four bounded per-case JSON records are retained.

The one fresh driver authorization is consumed. No case or driver was rerun. The aggregate failure and immutable complete-v2 parse failure are substantive final-session failures, so the foundation remains provisional. Any diagnosis, source/test correction, resealing or new validation requires a separate bounded task.
