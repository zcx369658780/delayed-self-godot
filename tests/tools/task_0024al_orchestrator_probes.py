from __future__ import annotations

import hashlib
import importlib.util
import json
import tempfile
import uuid
from datetime import datetime, timezone
from pathlib import Path


ROOT = Path(r"D:\Delayed_Self")
TOOLS = ROOT / "tests" / "tools"
SOURCE = TOOLS / "task_0024al_orchestrator.py"


def load_module():
    spec = importlib.util.spec_from_file_location("al_orchestrator_probe_target", SOURCE)
    if spec is None or spec.loader is None:
        raise RuntimeError("IMPORT_FAILED")
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def expect_rejection(name, action, expected):
    try:
        action()
    except Exception as exc:
        if expected not in str(exc):
            raise RuntimeError(f"WRONG_REJECTION:{name}:{exc}") from exc
        return {"name": name, "rejected": True, "reason": expected}
    raise RuntimeError(f"ACCEPTED_INVALID:{name}")


def main() -> int:
    module = load_module()
    token = uuid.uuid4().hex
    case_objects = [
        {"name": case[0], "kind": case[1], "script_path": case[2],
         "marker": case[3], "stderr_policy": case[4]}
        for case in module.EXPECTED_CASES
    ]
    focused_plan = {
        "schema_version": 1, "task_identity": "0024AL",
        "qualification_run_id": token, "status": "QUALIFICATION_PLAN",
        "qualification_kind": "focused", "cases": case_objects[:1],
    }
    focused_kind, focused_cases = module.validate_manifest_shape(
        focused_plan, "qualification", token
    )
    if focused_kind != "focused" or len(focused_cases) != 1:
        raise RuntimeError("FOCUSED_PLAN_POSITIVE_INVALID")
    full_plan = dict(focused_plan)
    full_plan.update({"qualification_kind": "full_rehearsal", "cases": case_objects})
    full_kind, full_cases = module.validate_manifest_shape(
        full_plan, "qualification", token
    )
    if full_kind != "full_rehearsal" or len(full_cases) != 5:
        raise RuntimeError("FULL_PLAN_POSITIVE_INVALID")
    expected = module.EXPECTED_CASES[1]
    path = TOOLS / f"task_0024al_probe_{token}_case_02_{expected[0]}.json"
    source_object = {
        "schema_version": 2, "status": "PASS", "underlying_status": "PASS",
        "native_exit_code": 0, "marker_pass": True,
        "stdout": [expected[3]], "stderr": [], "cleanup_invocation_count": 1,
        "cleanup_order": [123], "remaining_owned_pids": [],
        "remaining_unproven_pids": [], "qualification_flag": "--probe",
        "case_script_path": expected[2], "godot_before_count": 0,
        "godot_after_count": 0,
    }
    source_raw = module.compact(source_object)
    record = {
        "schema_version": 1, "task_identity": "0024AL", "run_mode": "qualification",
        "manifest_id": None, "qualification_run_id": token, "invocation_id": token,
        "ordinal": 2, "case_name": expected[0], "case_kind": expected[1],
        "script_path": expected[2], "required_marker": expected[3],
        "stderr_policy": expected[4], "required_marker_occurrence_count": 1,
        "parsed_status": "PASS", "underlying_status": "PASS", "native_exit_code": 0,
        "marker_pass": True, "cleanup_invocation_count": 1, "cleanup_order": [123],
        "remaining_owned_pids": [], "remaining_unproven_pids": [], "stderr": [],
        "worker_godot_count_before": 0, "worker_godot_count_after": 0,
        "raw_wrapper_or_runner_json": source_raw,
        "raw_wrapper_or_runner_sha256": hashlib.sha256(source_raw.encode()).hexdigest(),
        "raw_utf8_byte_count": len(source_raw.encode()),
        "source_parsed_record": source_object, "aj_evidence": None,
        "route_facts": {
            "qualification_flag": "--probe", "case_script_path": expected[2],
            "godot_before_count": 0, "godot_after_count": 0,
        },
        "created_utc": datetime.now(timezone.utc).isoformat(),
        "canonical_case_record_sha256": module.ZERO_HASH,
    }
    basis = module.compact(record).encode()
    record["canonical_case_record_sha256"] = hashlib.sha256(basis).hexdigest()
    raw = module.compact(record).encode()
    accepted = module.validate_case_record(
        path, raw, mode="qualification", run_id=token, invocation_id=token,
        ordinal=2, expected=expected, tools_root=TOOLS,
    )
    results = []
    for count in (2, 3, 4):
        bad_shape = dict(full_plan)
        bad_shape["cases"] = case_objects[:count]
        results.append(expect_rejection(
            f"qualification_{count}_cases",
            lambda bad_shape=bad_shape: module.validate_manifest_shape(
                bad_shape, "qualification", token),
            "FULL_REHEARSAL_PLAN_MUST_HAVE_FIVE_CASES"))
    wrong_singleton = dict(focused_plan)
    wrong_singleton["cases"] = case_objects[1:2]
    results.append(expect_rejection(
        "focused_wrong_singleton",
        lambda: module.validate_manifest_shape(
            wrong_singleton, "qualification", token),
        "MANIFEST_CASE_CONTRACT_INVALID:1"))
    retained_singleton = {
        "schema_version": 1, "task_identity": "0024AL", "manifest_id": token,
        "status": "DECLARED", "cases": case_objects[:1],
    }
    results.append(expect_rejection(
        "retained_singleton",
        lambda: module.validate_manifest_shape(retained_singleton, "retained", token),
        "RETAINED_MANIFEST_MUST_BE_FULL_FIVE"))
    missing_kind = dict(focused_plan)
    missing_kind.pop("qualification_kind")
    results.append(expect_rejection(
        "qualification_kind_missing",
        lambda: module.validate_manifest_shape(missing_kind, "qualification", token),
        "QUALIFICATION_KIND_INVALID"))
    duplicate_raw = raw[:-1] + b',"ordinal":2}'
    results.append(expect_rejection(
        "duplicate_json_key",
        lambda: module.validate_case_record(
            path, duplicate_raw, mode="qualification", run_id=token,
            invocation_id=token, ordinal=2, expected=expected, tools_root=TOOLS),
        "DUPLICATE_JSON_KEY"))
    results.append(expect_rejection(
        "malformed_worker_json",
        lambda: module.validate_case_record(
            path, b"{", mode="qualification", run_id=token, invocation_id=token,
            ordinal=2, expected=expected, tools_root=TOOLS),
        "CASE_RECORD_INVALID_JSON"))
    for name, key, value, reason in (
        ("wrong_task", "task_identity", "0024XX", "CASE_RECORD_IDENTITY_INVALID"),
        ("wrong_ordinal", "ordinal", 3, "CASE_RECORD_IDENTITY_INVALID"),
        ("wrong_run_id", "qualification_run_id", "wrong", "CASE_RECORD_RUN_ID_INVALID"),
        ("wrong_marker", "required_marker", "WRONG", "CASE_RECORD_CONTRACT_INVALID"),
        ("wrong_raw_hash", "raw_wrapper_or_runner_sha256", "0" * 64, "CASE_RECORD_RAW_HASH_INVALID"),
        ("wrong_canonical_hash", "canonical_case_record_sha256", "f" * 64,
         "CASE_RECORD_CANONICAL_HASH_MISMATCH"),
        ("bool_ordinal", "ordinal", True, "CASE_RECORD_INTEGER_TYPE_INVALID"),
        ("invalid_created_utc", "created_utc", "not-a-time",
         "CASE_RECORD_CREATED_UTC_INVALID"),
    ):
        changed = dict(record)
        changed[key] = value
        results.append(expect_rejection(
            name,
            lambda changed=changed: module.validate_case_record(
                path, module.compact(changed).encode(), mode="qualification",
                run_id=token, invocation_id=token, ordinal=2, expected=expected,
                tools_root=TOOLS),
            reason))
    missing = dict(record)
    missing.pop("created_utc")
    results.append(expect_rejection(
        "missing_required_field",
        lambda: module.validate_case_record(
            path, module.compact(missing).encode(), mode="qualification",
            run_id=token, invocation_id=token, ordinal=2, expected=expected,
            tools_root=TOOLS),
        "CASE_RECORD_SCHEMA_FIELDS_INVALID"))
    unknown = dict(record)
    unknown["unknown"] = 1
    results.append(expect_rejection(
        "unknown_field",
        lambda: module.validate_case_record(
            path, module.compact(unknown).encode(), mode="qualification",
            run_id=token, invocation_id=token, ordinal=2, expected=expected,
            tools_root=TOOLS),
        "CASE_RECORD_SCHEMA_FIELDS_INVALID"))
    ak_record = json.loads(
        (TOOLS / "task_0024ak_qualification_repeatable_2.json").read_text(
            encoding="utf-8")
    )
    focused_raw = ak_record["capture"]["raw_wrapper_json"]
    derived = module.parse_aj_evidence_from_wrapper(focused_raw)
    forged = json.loads(json.dumps(derived))
    forged["lifecycle_signature_map"]["barrier_closed"] = "FORGED"
    focused_record = dict(record)
    focused_expected = module.EXPECTED_CASES[0]
    focused_source = module.strict_json_loads(focused_raw)
    focused_path = TOOLS / (
        f"task_0024al_probe_{token}_case_01_{focused_expected[0]}.json"
    )
    focused_record.update({
        "ordinal": 1, "case_name": focused_expected[0], "case_kind": focused_expected[1],
        "script_path": focused_expected[2], "required_marker": focused_expected[3],
        "stderr_policy": focused_expected[4], "raw_wrapper_or_runner_json": focused_raw,
        "raw_wrapper_or_runner_sha256": hashlib.sha256(focused_raw.encode()).hexdigest(),
        "raw_utf8_byte_count": len(focused_raw.encode()), "aj_evidence": forged,
        "route_facts": None, "source_parsed_record": focused_source,
        "parsed_status": focused_source["status"],
        "underlying_status": focused_source["underlying_status"],
        "native_exit_code": focused_source["native_exit_code"],
        "marker_pass": focused_source["marker_pass"],
        "stderr": focused_source["stderr"],
        "cleanup_invocation_count": focused_source["cleanup_invocation_count"],
        "cleanup_order": focused_source["cleanup_order"],
        "remaining_owned_pids": focused_source["remaining_owned_pids"],
        "remaining_unproven_pids": focused_source["remaining_unproven_pids"],
        "canonical_case_record_sha256": module.ZERO_HASH,
    })
    focused_basis = module.compact(focused_record).encode()
    focused_record["canonical_case_record_sha256"] = hashlib.sha256(
        focused_basis).hexdigest()
    results.append(expect_rejection(
        "detached_forged_aj_evidence",
        lambda: module.validate_case_record(
            focused_path, module.compact(focused_record).encode(),
            mode="qualification", run_id=token, invocation_id=token,
            ordinal=1, expected=focused_expected, tools_root=TOOLS),
        "CASE_RECORD_AJ_EVIDENCE_MISMATCH"))
    forged_wrapper_object = json.loads(focused_raw)
    forged_wrapper_object["stdout"] = [
        line.replace('"action_10_reached":true', '"action_10_reached":false', 1)
        for line in forged_wrapper_object["stdout"]
    ]
    forged_raw_wrapper = module.compact(forged_wrapper_object)
    results.append(expect_rejection(
        "forged_raw_aj_control",
        lambda: module.parse_aj_evidence_from_wrapper(forged_raw_wrapper),
        "AJ_SWAPPED_CONTROL_INVALID"))
    results.append(expect_rejection(
        "noncanonical_output",
        lambda: module.validate_case_record(
            Path(tempfile.gettempdir()) / path.name, raw, mode="qualification",
            run_id=token, invocation_id=token, ordinal=2, expected=expected,
            tools_root=TOOLS),
        "NONCANONICAL_PATH"))
    missing = TOOLS / f"task_0024al_probe_{token}_missing.json"
    if missing.exists():
        raise RuntimeError("MISSING_FIXTURE_UNEXPECTEDLY_EXISTS")
    results.append({"name": "missing_output", "rejected": True, "reason": "absent"})
    with tempfile.TemporaryDirectory(prefix="task_0024al_orchestrator_probe_") as temp:
        duplicate = Path(temp) / "duplicate.json"
        module.atomic_write(duplicate, b"{}", exclusive=True)
        results.append(expect_rejection(
            "duplicate_output", lambda: module.atomic_write(
                duplicate, b"{}", exclusive=True), "OUTPUT_ALREADY_EXISTS"))
        progress = Path(temp) / "progress.json"
        module.atomic_write(progress, module.compact({
            "completed_case_count": 1, "cases": [accepted["case_name"]]
        }).encode())
        if json.loads(progress.read_text())["completed_case_count"] != 1:
            raise RuntimeError("PROGRESS_JOURNAL_INVALID")
    print(json.dumps({
        "schema_version": 1, "task_identity": "0024AL", "status": "PASS",
        "accepted_case_validated": True, "negative_count": len(results),
        "negatives": results, "progress_journal_atomic": True,
        "parent_standard_library_only": True,
    }, separators=(",", ":")))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
