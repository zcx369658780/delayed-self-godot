import hashlib
import json
import pathlib
import subprocess
import sys


def sha256(path: pathlib.Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def normalized_text(path: pathlib.Path) -> str:
    return path.read_text(encoding="utf-8").replace("\r\n", "\n").replace("\r", "\n")


def replace_exact(text: str, old: str, new: str, count: int) -> str:
    observed = text.count(old)
    if observed != count:
        raise ValueError(f"replacement count mismatch for {old!r}: {observed} != {count}")
    return text.replace(old, new)


def main() -> int:
    repo = pathlib.Path(sys.argv[1]).resolve()
    baseline = json.loads((repo / "tests/tools/task_0024v_test_correction_baseline.json").read_text(encoding="utf-8"))
    aggregate = baseline["aggregate"]
    historical_path = repo / baseline["complete_v2"]["historical_path"]
    corrected_path = repo / baseline["complete_v2"]["corrected_path"]

    committed_bytes = subprocess.run(
        ["git", "-C", str(repo), "show", f"{aggregate['source_commit']}:{aggregate['path']}"],
        check=True,
        stdout=subprocess.PIPE,
    ).stdout
    committed = committed_bytes.decode("utf-8").replace("\r\n", "\n").replace("\r", "\n")
    committed_hash = hashlib.sha256(committed.replace("\n", "\r\n").encode("utf-8")).hexdigest()
    if committed_hash != aggregate["pre_sha256"]:
        raise ValueError("aggregate committed baseline hash mismatch")
    current = normalized_text(repo / aggregate["path"])
    expected = replace_exact(committed, aggregate["old_line"], aggregate["new_line"], 1)
    if current != expected:
        raise ValueError("aggregate differs beyond the exact schema-version 2 to 3 correction")
    if sha256(repo / aggregate["path"]) != aggregate["corrected_sha256"]:
        raise ValueError("aggregate corrected hash mismatch")
    old_expect_calls = sum(1 for line in committed.splitlines() if line.lstrip().startswith(("_expect(", "_expect_code(")))
    new_expect_calls = sum(1 for line in current.splitlines() if line.lstrip().startswith(("_expect(", "_expect_code(")))
    if old_expect_calls != new_expect_calls:
        raise ValueError("aggregate expectation-call structure changed")
    if f"assertions=%d" not in current or "TASK_0003_TESTS_PASS" not in current:
        raise ValueError("aggregate 621-marker structure missing")
    probe = aggregate["new_line"] + "\n\t_expect_code(loader.validate_dict(value), \"UNSUPPORTED_SCHEMA_VERSION\", \"unsupported version\")"
    if current.count(probe) != 1:
        raise ValueError("corrected aggregate probe contract mismatch")

    if sha256(historical_path) != baseline["complete_v2"]["historical_sha256"]:
        raise ValueError("historical complete-v2 hash mismatch")
    historical = normalized_text(historical_path)
    transformed = historical
    replacements = [
        ("TASK_0024T_V2_COMPLETE_FAIL", "TASK_0024V_V2_COMPLETE_FAIL", 1),
        ("TASK_0024T_V2_COMPLETE_PASS", "TASK_0024V_V2_COMPLETE_PASS", 1),
        ("TASK_0024T_CASE_FAIL", "TASK_0024V_CASE_FAIL", 1),
        ('var source := _fixture("key_lock").level.duplicate(true)', 'var source: Dictionary = _fixture("key_lock").level.duplicate(true)', 2),
        ("var normalized_order_invariant := ordered.ok and reordered.ok", "var normalized_order_invariant: bool = ordered.ok and reordered.ok", 1),
        ('var level := _fixture("integration").level', 'var level: Dictionary = _fixture("integration").level', 1),
        ('var latch_level := _fixture("latch_defer").level', 'var latch_level: Dictionary = _fixture("latch_defer").level', 2),
        ('var door_source := _fixture("key_lock").level.duplicate(true)', 'var door_source: Dictionary = _fixture("key_lock").level.duplicate(true)', 1),
        ('var crate_level := _fixture("crate_echo").level', 'var crate_level: Dictionary = _fixture("crate_echo").level', 1),
        ('var key_level := _fixture("key_lock").level', 'var key_level: Dictionary = _fixture("key_lock").level', 1),
        ('var level := _fixture("sensor_barrier").level', 'var level: Dictionary = _fixture("sensor_barrier").level', 2),
        ('var crate_level := _fixture("integration").level', 'var crate_level: Dictionary = _fixture("integration").level', 1),
        ("var vacated_state := latched.state.duplicate(true) if latched.ok else {}", "var vacated_state: Dictionary = latched.state.duplicate(true) if latched.ok else {}", 1),
        ('var variant := source.duplicate(true); variant["unknown_top"] = true', 'var variant: Dictionary = source.duplicate(true); variant["unknown_top"] = true', 1),
        ("var v1 := source.duplicate(true)", "var v1: Dictionary = source.duplicate(true)", 1),
    ]
    for old, new, count in replacements:
        transformed = replace_exact(transformed, old, new, count)
    corrected = normalized_text(corrected_path)
    if corrected.rstrip("\n") + "\n" != transformed.rstrip("\n") + "\n":
        raise ValueError("complete-v2 differs beyond authorized declarations and Task markers")
    if sha256(corrected_path) != baseline["complete_v2"]["corrected_sha256"]:
        raise ValueError("complete-v2 corrected hash mismatch")
    coverage = baseline["complete_v2"]["coverage_ids"]
    counts = {coverage_id: corrected.count(coverage_id) for coverage_id in coverage}
    missing = sorted([key for key, value in counts.items() if value == 0])
    duplicates = sorted([key for key, value in counts.items() if value != 1 and value != 0])
    if len(coverage) != 44 or len(set(coverage)) != 44 or missing or duplicates:
        raise ValueError("complete-v2 coverage ID set/count mismatch")
    if "TASK_0023ZX_COMPLETE_MATRIX_PASS" in corrected or "task_0023zx_core_mechanics_complete_matrix.gd" in corrected:
        raise ValueError("forbidden historical incomplete matrix reference present")

    result = {
        "status": "PASS",
        "aggregate_committed_sha256": committed_hash,
        "aggregate_corrected_sha256": sha256(repo / aggregate["path"]),
        "aggregate_expect_calls_before": old_expect_calls,
        "aggregate_expect_calls_after": new_expect_calls,
        "aggregate_runtime_assertions": aggregate["runtime_assertions"],
        "complete_historical_sha256": sha256(historical_path),
        "complete_corrected_sha256": sha256(corrected_path),
        "authorized_declaration_sites": 15,
        "coverage_ids": len(coverage),
        "coverage_missing": missing,
        "coverage_duplicates": duplicates,
        "marker": "TASK_0024V_EQUIVALENCE_PASS",
    }
    print(json.dumps(result, sort_keys=True, separators=(",", ":")))
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except Exception as exc:
        print(json.dumps({"status": "FAIL", "error": str(exc)}, sort_keys=True, separators=(",", ":")))
        raise SystemExit(1)
