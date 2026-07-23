from __future__ import annotations

import argparse
import csv
import hashlib
import json
import os
import subprocess
import sys
import tempfile
import uuid
from datetime import datetime
from pathlib import Path
from typing import Any

TASK = "0024AL"
EXPECTED_CASES = (
    ("sensor_contract_dynamic_signature", "wrapper",
     "res://tests/presentation/task_0024aj_sensor_contract_and_dynamic_signature_validation.gd",
     "TASK_0024AJ_SENSOR_CONTRACT_DYNAMIC_SIGNATURE_PASS", "RequireEmpty"),
    ("isolated_staging_route", "route",
     "res://tests/playtest/task_0024ae_submission_core_owner_review_launcher.gd",
     "TASK_0024AE_ISOLATED_STAGING_OWNER_ROUTE_PASS", "RequireEmpty"),
    ("batch_1_12", "wrapper",
     "res://tests/curriculum/task_0024ad_submission_core_1_12_batch_validation.gd",
     "TASK_0024AD_SUBMISSION_CORE_1_12_BATCH_PASS", "RequireEmpty"),
    ("aggregate", "wrapper", "res://tests/run_all.gd",
     "TASK_0003_TESTS_PASS assertions=621 vectors=9", "AggregateMismatch"),
    ("complete_v2", "wrapper",
     "res://tests/simulation/task_0024v_v2_solver_replay_canonical_malformed.gd",
     "TASK_0024V_V2_COMPLETE_PASS", "RequireEmpty"),
)
ZERO_HASH = "0" * 64


class AlError(RuntimeError):
    pass


def compact(value: Any) -> str:
    return json.dumps(value, ensure_ascii=False, separators=(",", ":"))

def strict_json_loads(raw: str) -> Any:
    def reject_duplicates(pairs: list[tuple[str, Any]]) -> dict[str, Any]:
        result: dict[str, Any] = {}
        for key, value in pairs:
            if key in result:
                raise AlError(f"DUPLICATE_JSON_KEY:{key}")
            result[key] = value
        return result
    return json.loads(raw, object_pairs_hook=reject_duplicates)


def atomic_write(path: Path, data: bytes, *, exclusive: bool = False) -> None:
    path.parent.mkdir(parents=False, exist_ok=True)
    if exclusive and path.exists():
        raise AlError(f"OUTPUT_ALREADY_EXISTS:{path.name}")
    fd, temporary = tempfile.mkstemp(prefix=path.name + ".tmp.", dir=str(path.parent))
    temporary_path = Path(temporary)
    try:
        with os.fdopen(fd, "wb") as stream:
            stream.write(data)
            stream.flush()
            os.fsync(stream.fileno())
        if exclusive:
            try:
                os.link(temporary_path, path)
            except FileExistsError as exc:
                raise AlError(f"OUTPUT_ALREADY_EXISTS:{path.name}") from exc
            temporary_path.unlink()
        else:
            os.replace(temporary_path, path)
    finally:
        if temporary_path.exists():
            temporary_path.unlink()


def create_exclusive(path: Path, value: dict[str, Any]) -> None:
    data = compact(value).encode("utf-8")
    descriptor, temporary = tempfile.mkstemp(prefix=path.name + ".tmp.", dir=str(path.parent))
    temporary_path = Path(temporary)
    try:
        with os.fdopen(descriptor, "wb") as stream:
            stream.write(data)
            stream.flush()
            os.fsync(stream.fileno())
        try:
            os.link(temporary_path, path)
        except FileExistsError as exc:
            raise AlError(f"EXCLUSIVE_FILE_EXISTS:{path.name}") from exc
        temporary_path.unlink()
        persisted = path.read_bytes()
        if persisted != data:
            raise AlError(f"EXCLUSIVE_REOPEN_BYTES_MISMATCH:{path.name}")
        try:
            reparsed = strict_json_loads(persisted.decode("utf-8"))
        except (UnicodeDecodeError, json.JSONDecodeError) as exc:
            raise AlError(f"EXCLUSIVE_REOPEN_JSON_INVALID:{path.name}") from exc
        if reparsed != value:
            raise AlError(f"EXCLUSIVE_REOPEN_VALUE_MISMATCH:{path.name}")
    finally:
        if temporary_path.exists():
            temporary_path.unlink()


def godot_count() -> int:
    if os.name != "nt":
        completed = subprocess.run(
            ["ps", "-A", "-o", "comm="], check=True, capture_output=True, text=True
        )
        return sum(Path(line.strip()).name.lower().startswith("godot")
                   for line in completed.stdout.splitlines())
    completed = subprocess.run(
        ["tasklist", "/FO", "CSV", "/NH"], check=True, capture_output=True,
        text=True, encoding="utf-8", errors="replace"
    )
    count = 0
    for row in csv.reader(completed.stdout.splitlines()):
        if row and row[0].lower().startswith("godot"):
            count += 1
    return count


def canonical_tools_path(path: Path, tools_root: Path, pattern_prefix: str) -> Path:
    resolved = path.resolve()
    if resolved.parent != tools_root.resolve() or not resolved.name.startswith(pattern_prefix):
        raise AlError(f"NONCANONICAL_PATH:{resolved}")
    return resolved

def parse_aj_evidence_from_wrapper(raw_wrapper: str) -> dict[str, Any]:
    try:
        wrapper = strict_json_loads(raw_wrapper)
    except json.JSONDecodeError as exc:
        raise AlError("AJ_RAW_WRAPPER_INVALID_JSON") from exc
    if type(wrapper) is not dict or type(wrapper.get("stdout")) is not list:
        raise AlError("AJ_RAW_WRAPPER_STDOUT_INVALID")
    required = (
        "multi_subagent_ledger", "adapter_parser_qualification", "static_preservation",
        "candidate_route_preflight", "sensor_public_contract_inventory",
        "sensor_barrier_lifecycle", "swapped_identity_wrong_actor_control",
        "lifecycle_signature_registry", "crate_lifecycle",
        "key_lock_inventory_lifecycle", "latch_lifecycle",
        "fit_layering_v1_regression", "summary",
    )
    seen: dict[str, dict[str, Any]] = {}
    records: list[dict[str, Any]] = []
    prefix = "TASK_0024AJ_EVIDENCE "
    for line in wrapper["stdout"]:
        if type(line) is not str:
            raise AlError("AJ_STDOUT_ITEM_NOT_STRING")
        if not line.startswith(prefix):
            continue
        raw = line[len(prefix):]
        raw_bytes = raw.encode("utf-8")
        if len(raw_bytes) >= 1800:
            raise AlError("AJ_EVIDENCE_OVER_BOUND")
        try:
            evidence = strict_json_loads(raw)
        except json.JSONDecodeError as exc:
            raise AlError("AJ_EVIDENCE_INVALID_JSON") from exc
        if (type(evidence) is not dict or type(evidence.get("schema_version")) is not int
                or evidence["schema_version"] != 1 or
                type(evidence.get("kind")) is not str or evidence["kind"] not in required):
            raise AlError("AJ_EVIDENCE_IDENTITY_INVALID")
        kind = evidence["kind"]
        if kind in seen:
            raise AlError(f"AJ_EVIDENCE_DUPLICATE:{kind}")
        seen[kind] = evidence
        records.append({
            "kind": kind, "raw_utf8_byte_count": len(raw_bytes),
            "raw_sha256": hashlib.sha256(raw_bytes).hexdigest(), "record": evidence,
        })
    if set(seen) != set(required) or len(records) != 13:
        raise AlError("AJ_EVIDENCE_REQUIRED_KINDS_INVALID")
    registry = seen["lifecycle_signature_registry"]
    signatures = registry.get("label_to_signature")
    if (type(registry.get("count")) is not int or registry["count"] != 13 or
            type(signatures) is not dict or len(signatures) != 13 or
            any(type(value) is not str or not value for value in signatures.values()) or
            len(set(signatures.values())) != 13):
        raise AlError("AJ_SIGNATURE_REGISTRY_INVALID")
    route = seen["candidate_route_preflight"]
    route_records = route.get("records")
    if (type(route.get("candidate_count")) is not int or route["candidate_count"] != 4 or
            type(route_records) is not list or len(route_records) != 4 or
            any(item.get("runtime_ready") is not True or item.get("snapshot_equal") is not True
                for item in route_records if type(item) is dict) or
            any(type(item) is not dict for item in route_records)):
        raise AlError("AJ_CANDIDATE_PREFLIGHT_INVALID")
    control = seen["swapped_identity_wrong_actor_control"]
    if (control.get("action_10_reached") is not True or
            control.get("block_action") != "RIGHT" or
            control.get("block_player_unchanged") is not True or
            type(control.get("control_digest")) is not str or
            len(control["control_digest"]) != 64 or
            any(character not in "0123456789abcdef" for character in control["control_digest"]) or
            control.get("sensor_echo", {}).get("occupying_actor") != "ECHO" or
            control.get("sensor_echo", {}).get("required_activator") != "YOU_ONLY" or
            control.get("sensor_echo", {}).get("stable_id") != "sensor:sensor_echo" or
            control.get("sensor_you", {}).get("occupying_actor") != "YOU" or
            control.get("sensor_you", {}).get("required_activator") != "ECHO_ONLY" or
            control.get("sensor_you", {}).get("stable_id") != "sensor:sensor_you"):
        raise AlError("AJ_SWAPPED_CONTROL_INVALID")
    lifecycle = seen["sensor_barrier_lifecycle"]
    actions = lifecycle.get("per_group_actions")
    if type(actions) is not list or len(actions) != 4:
        raise AlError("AJ_LIFECYCLE_ACTIONS_INVALID")
    by_action = {item.get("action"): item for item in actions if type(item) is dict}
    if set(by_action) != {10, 11, 12, 13}:
        raise AlError("AJ_LIFECYCLE_ACTION_IDENTITIES_INVALID")
    expected = {
        10: (True, True, False, []),
        11: (False, True, True, [[4, 1]]),
        12: (False, True, True, [[5, 1]]),
        13: (False, False, False, []),
    }
    for action, contract in expected.items():
        item = by_action[action]
        if (type(item.get("requested_open")) is not bool or
                type(item.get("effective_open")) is not bool or
                type(item.get("closure_deferred")) is not bool or
                type(item.get("occupied_cells")) is not list):
            raise AlError(f"AJ_LIFECYCLE_ACTION_TYPE_INVALID:{action}")
        actual = (
            item.get("requested_open"), item.get("effective_open"),
            item.get("closure_deferred"), item.get("occupied_cells"),
        )
        if actual != contract:
            raise AlError(f"AJ_LIFECYCLE_ACTION_CONTRACT_INVALID:{action}")
    return {
        "schema_version": 1, "status": "PASS", "record_count": 13,
        "records": records, "lifecycle_signature_map": signatures,
    }


def validate_manifest_shape(
    manifest: dict[str, Any], mode: str, run_id: str
) -> tuple[str, tuple[tuple[str, str, str, str, str], ...]]:
    if not isinstance(manifest, dict) or manifest.get("schema_version") != 1:
        raise AlError("MANIFEST_SCHEMA_INVALID")
    if manifest.get("task_identity") != TASK:
        raise AlError("MANIFEST_TASK_INVALID")
    id_field = "manifest_id" if mode == "retained" else "qualification_run_id"
    expected_status = "DECLARED" if mode == "retained" else "QUALIFICATION_PLAN"
    if manifest.get("status") != expected_status or manifest.get(id_field) != run_id:
        raise AlError("MANIFEST_ID_OR_STATUS_INVALID")
    cases = manifest.get("cases")
    if not isinstance(cases, list):
        raise AlError("MANIFEST_CASES_NOT_ARRAY")
    if mode == "retained":
        if "qualification_kind" in manifest or len(cases) != 5:
            raise AlError("RETAINED_MANIFEST_MUST_BE_FULL_FIVE")
        qualification_kind = "retained"
        expected_cases = EXPECTED_CASES
    else:
        qualification_kind = manifest.get("qualification_kind")
        if qualification_kind == "focused":
            if len(cases) != 1:
                raise AlError("FOCUSED_PLAN_MUST_HAVE_ONE_CASE")
            expected_cases = EXPECTED_CASES[:1]
        elif qualification_kind == "full_rehearsal":
            if len(cases) != 5:
                raise AlError("FULL_REHEARSAL_PLAN_MUST_HAVE_FIVE_CASES")
            expected_cases = EXPECTED_CASES
        else:
            raise AlError("QUALIFICATION_KIND_INVALID")
    for ordinal, (case, expected) in enumerate(zip(cases, expected_cases), 1):
        if not isinstance(case, dict):
            raise AlError(f"MANIFEST_CASE_NOT_OBJECT:{ordinal}")
        actual = (
            case.get("name"), case.get("kind"), case.get("script_path"),
            case.get("marker"), case.get("stderr_policy"),
        )
        if actual != expected:
            raise AlError(f"MANIFEST_CASE_CONTRACT_INVALID:{ordinal}")
    return qualification_kind, tuple(expected_cases)


def load_manifest(
    path: Path, mode: str, run_id: str, tools_root: Path
) -> tuple[dict[str, Any], bytes, str, tuple[tuple[str, str, str, str, str], ...]]:
    path = canonical_tools_path(
        path, tools_root,
        "task_0024al_retained_manifest.json" if mode == "retained"
        else "task_0024al_qualification_plan_"
    )
    if mode == "retained" and path.name != "task_0024al_retained_manifest.json":
        raise AlError("RETAINED_MANIFEST_NAME_INVALID")
    raw = path.read_bytes()
    try:
        manifest = strict_json_loads(raw.decode("utf-8"))
    except (UnicodeDecodeError, json.JSONDecodeError) as exc:
        raise AlError("MANIFEST_INVALID_JSON") from exc
    qualification_kind, validated_cases = validate_manifest_shape(manifest, mode, run_id)
    if mode == "retained":
        duplicate_count = 0
        for candidate in tools_root.glob("task_0024al_*manifest*.json"):
            if candidate.resolve() == path.resolve():
                continue
            try:
                other = strict_json_loads(candidate.read_text(encoding="utf-8"))
            except (UnicodeDecodeError, json.JSONDecodeError):
                continue
            if (isinstance(other, dict) and other.get("task_identity") == TASK and
                    other.get("manifest_id") == run_id):
                duplicate_count += 1
        if duplicate_count:
            raise AlError("DUPLICATE_MANIFEST_ID")
    return manifest, raw, qualification_kind, validated_cases


def validate_case_record(
    path: Path,
    raw: bytes,
    *,
    mode: str,
    run_id: str,
    invocation_id: str,
    ordinal: int,
    expected: tuple[str, str, str, str, str],
    tools_root: Path,
) -> dict[str, Any]:
    canonical_tools_path(path, tools_root, "task_0024al_")
    expected_token = f"_case_{ordinal:02d}_{expected[0]}.json"
    if not path.name.endswith(expected_token):
        raise AlError("CASE_OUTPUT_PATH_INVALID")
    try:
        record = strict_json_loads(raw.decode("utf-8"))
    except (UnicodeDecodeError, json.JSONDecodeError) as exc:
        raise AlError("CASE_RECORD_INVALID_JSON") from exc
    if not isinstance(record, dict):
        raise AlError("CASE_RECORD_NOT_OBJECT")
    required_fields = {
        "schema_version", "task_identity", "run_mode", "manifest_id",
        "qualification_run_id", "invocation_id", "ordinal", "case_name", "case_kind",
        "script_path", "required_marker", "required_marker_occurrence_count",
        "stderr_policy", "raw_wrapper_or_runner_json",
        "raw_wrapper_or_runner_sha256", "raw_utf8_byte_count", "parsed_status",
        "underlying_status", "native_exit_code", "marker_pass", "stderr",
        "cleanup_invocation_count", "cleanup_order", "remaining_owned_pids",
        "remaining_unproven_pids", "worker_godot_count_before",
        "worker_godot_count_after", "source_parsed_record", "aj_evidence",
        "route_facts", "created_utc", "canonical_case_record_sha256",
    }
    actual_fields = set(record)
    if actual_fields != required_fields:
        missing = sorted(required_fields - actual_fields)
        unknown = sorted(actual_fields - required_fields)
        raise AlError(f"CASE_RECORD_SCHEMA_FIELDS_INVALID:missing={missing}:unknown={unknown}")
    integer_fields = (
        "schema_version", "ordinal", "required_marker_occurrence_count",
        "raw_utf8_byte_count", "native_exit_code", "cleanup_invocation_count",
        "worker_godot_count_before", "worker_godot_count_after",
    )
    if any(type(record[key]) is not int for key in integer_fields):
        raise AlError("CASE_RECORD_INTEGER_TYPE_INVALID")
    string_fields = (
        "task_identity", "run_mode", "invocation_id", "case_name", "case_kind",
        "script_path", "required_marker", "stderr_policy",
        "raw_wrapper_or_runner_json", "raw_wrapper_or_runner_sha256",
        "parsed_status", "underlying_status", "created_utc",
        "canonical_case_record_sha256",
    )
    if any(type(record[key]) is not str or not record[key] for key in string_fields):
        raise AlError("CASE_RECORD_STRING_TYPE_INVALID")
    if type(record["marker_pass"]) is not bool:
        raise AlError("CASE_RECORD_BOOLEAN_TYPE_INVALID")
    if any(type(record[key]) is not list for key in (
        "stderr", "cleanup_order", "remaining_owned_pids", "remaining_unproven_pids"
    )):
        raise AlError("CASE_RECORD_ARRAY_TYPE_INVALID")
    if (any(type(item) is not str for item in record["stderr"]) or
            any(type(item) is not int for item in record["cleanup_order"]) or
            any(type(item) is not int for item in record["remaining_owned_pids"]) or
            any(type(item) is not int for item in record["remaining_unproven_pids"])):
        raise AlError("CASE_RECORD_ARRAY_ITEM_TYPE_INVALID")
    if type(record["source_parsed_record"]) is not dict:
        raise AlError("CASE_RECORD_SOURCE_RECORD_TYPE_INVALID")
    if record["aj_evidence"] is not None and type(record["aj_evidence"]) is not dict:
        raise AlError("CASE_RECORD_AJ_EVIDENCE_TYPE_INVALID")
    if record["route_facts"] is not None and type(record["route_facts"]) is not dict:
        raise AlError("CASE_RECORD_ROUTE_FACTS_TYPE_INVALID")
    try:
        created = datetime.fromisoformat(record["created_utc"].replace("Z", "+00:00"))
    except ValueError as exc:
        raise AlError("CASE_RECORD_CREATED_UTC_INVALID") from exc
    if created.utcoffset() is None or created.utcoffset().total_seconds() != 0:
        raise AlError("CASE_RECORD_CREATED_UTC_NOT_UTC")
    if (record.get("schema_version") != 1 or record.get("task_identity") != TASK or
            record.get("run_mode") != mode or record.get("invocation_id") != invocation_id or
            record.get("ordinal") != ordinal):
        raise AlError("CASE_RECORD_IDENTITY_INVALID")
    if mode == "retained":
        if record.get("manifest_id") != run_id or record.get("qualification_run_id") is not None:
            raise AlError("CASE_RECORD_RUN_ID_INVALID")
    else:
        if record.get("qualification_run_id") != run_id or record.get("manifest_id") is not None:
            raise AlError("CASE_RECORD_RUN_ID_INVALID")
    actual_contract = (
        record.get("case_name"), record.get("case_kind"), record.get("script_path"),
        record.get("required_marker"), record.get("stderr_policy"),
    )
    if actual_contract != expected:
        raise AlError("CASE_RECORD_CONTRACT_INVALID")
    required_scalars = {
        "required_marker_occurrence_count": 1, "parsed_status": "PASS",
        "underlying_status": "PASS", "native_exit_code": 0, "marker_pass": True,
        "cleanup_invocation_count": 1, "worker_godot_count_before": 0,
        "worker_godot_count_after": 0,
    }
    for key, expected_value in required_scalars.items():
        if record.get(key) != expected_value:
            raise AlError(f"CASE_RECORD_FIELD_INVALID:{key}")
    for key in ("cleanup_order", "remaining_owned_pids", "remaining_unproven_pids", "stderr"):
        if not isinstance(record.get(key), list):
            raise AlError(f"CASE_RECORD_FIELD_TYPE_INVALID:{key}")
    if len(record["cleanup_order"]) != 1 or record["remaining_owned_pids"] or record["remaining_unproven_pids"]:
        raise AlError("CASE_RECORD_CLEANUP_INVALID")
    if expected[4] == "RequireEmpty" and record["stderr"]:
        raise AlError("CASE_RECORD_STDERR_INVALID")
    if expected[4] == "AggregateMismatch" and record["stderr"] != ["LEVEL_ID_MISMATCH"]:
        raise AlError("CASE_RECORD_AGGREGATE_STDERR_INVALID")
    source_raw = record.get("raw_wrapper_or_runner_json")
    source_hash = record.get("raw_wrapper_or_runner_sha256")
    if not isinstance(source_raw, str) or not isinstance(source_hash, str):
        raise AlError("CASE_RECORD_RAW_FIELDS_INVALID")
    source_bytes = source_raw.encode("utf-8")
    if (len(source_bytes) != record.get("raw_utf8_byte_count") or
            hashlib.sha256(source_bytes).hexdigest() != source_hash):
        raise AlError("CASE_RECORD_RAW_HASH_INVALID")
    try:
        source_record = strict_json_loads(source_raw)
    except json.JSONDecodeError as exc:
        raise AlError("CASE_RECORD_RAW_JSON_INVALID") from exc
    if type(source_record) is not dict or type(source_record.get("stdout")) is not list:
        raise AlError("CASE_RECORD_RAW_SCHEMA_INVALID")
    marker_count = 0
    for line in source_record["stdout"]:
        if type(line) is not str:
            raise AlError("CASE_RECORD_RAW_STDOUT_TYPE_INVALID")
        offset = 0
        while offset <= len(line) - len(expected[3]):
            found = line.find(expected[3], offset)
            if found < 0:
                break
            marker_count += 1
            offset = found + len(expected[3])
    if (marker_count != 1 or source_record.get("schema_version") != 2 or
            source_record.get("status") != "PASS" or
            source_record.get("underlying_status") != "PASS" or
            type(source_record.get("native_exit_code")) is not int or
            source_record["native_exit_code"] != 0 or
            source_record.get("marker_pass") is not True or
            type(source_record.get("stderr")) is not list or
            type(source_record.get("cleanup_invocation_count")) is not int or
            source_record["cleanup_invocation_count"] != 1 or
            type(source_record.get("cleanup_order")) is not list or
            len(source_record["cleanup_order"]) != 1 or
            source_record.get("remaining_owned_pids") != [] or
            source_record.get("remaining_unproven_pids") != []):
        raise AlError("CASE_RECORD_RAW_CONTRACT_INVALID")
    if (record["source_parsed_record"] != source_record or
            record["parsed_status"] != source_record["status"] or
            record["underlying_status"] != source_record["underlying_status"] or
            record["native_exit_code"] != source_record["native_exit_code"] or
            record["marker_pass"] != source_record["marker_pass"] or
            record["stderr"] != source_record["stderr"] or
            record["cleanup_invocation_count"] != source_record["cleanup_invocation_count"] or
            record["cleanup_order"] != source_record["cleanup_order"] or
            record["remaining_owned_pids"] != source_record["remaining_owned_pids"] or
            record["remaining_unproven_pids"] != source_record["remaining_unproven_pids"]):
        raise AlError("CASE_RECORD_DERIVED_FIELDS_MISMATCH")
    canonical_hash = record.get("canonical_case_record_sha256")
    if not isinstance(canonical_hash, str) or len(canonical_hash) != 64:
        raise AlError("CASE_RECORD_CANONICAL_HASH_INVALID")
    needle = f'"canonical_case_record_sha256":"{canonical_hash}"'.encode("utf-8")
    if raw.count(needle) != 1:
        raise AlError("CASE_RECORD_CANONICAL_HASH_BINDING_INVALID")
    basis = raw.replace(
        needle, f'"canonical_case_record_sha256":"{ZERO_HASH}"'.encode("utf-8"), 1
    )
    if hashlib.sha256(basis).hexdigest() != canonical_hash:
        raise AlError("CASE_RECORD_CANONICAL_HASH_MISMATCH")
    if expected[0] == "sensor_contract_dynamic_signature":
        evidence = record.get("aj_evidence")
        if type(evidence) is not dict or evidence.get("record_count") != 13:
            raise AlError("CASE_RECORD_AJ_EVIDENCE_INVALID")
        signatures = evidence.get("lifecycle_signature_map")
        if (not isinstance(signatures, dict) or len(signatures) != 13 or
                len(set(signatures.values())) != 13 or not all(signatures.values())):
            raise AlError("CASE_RECORD_AJ_SIGNATURES_INVALID")
        independently_derived = parse_aj_evidence_from_wrapper(source_raw)
        if evidence != independently_derived:
            raise AlError("CASE_RECORD_AJ_EVIDENCE_MISMATCH")
        if record["route_facts"] is not None:
            raise AlError("CASE_RECORD_UNEXPECTED_ROUTE_FACTS")
    elif expected[0] == "isolated_staging_route":
        expected_route_facts = {
            "qualification_flag": source_record.get("qualification_flag"),
            "case_script_path": source_record.get("case_script_path"),
            "godot_before_count": source_record.get("godot_before_count"),
            "godot_after_count": source_record.get("godot_after_count"),
        }
        if (record["route_facts"] != expected_route_facts or
                expected_route_facts["case_script_path"] != expected[2] or
                expected_route_facts["godot_before_count"] != 0 or
                expected_route_facts["godot_after_count"] != 0):
            raise AlError("CASE_RECORD_ROUTE_FACTS_MISMATCH")
        if record["aj_evidence"] is not None:
            raise AlError("CASE_RECORD_UNEXPECTED_AJ_EVIDENCE")
    elif record["aj_evidence"] is not None or record["route_facts"] is not None:
        raise AlError("CASE_RECORD_UNEXPECTED_DERIVED_EVIDENCE")
    return record


def worker_command(
    pwsh: str, worker: Path, *, godot: Path, project: Path, mode: str, run_id: str,
    invocation_id: str, ordinal: int, case: tuple[str, str, str, str, str],
    output: Path, synthetic_probe_input: Path | None = None,
    synthetic_probe_module_import_count: int = 1,
    synthetic_probe_omit_canonical: bool = False,
) -> list[str]:
    name, kind, script, marker, stderr_policy = case
    command = [
        pwsh, "-NoProfile", "-NonInteractive", "-File", str(worker),
        "-AlWorkerGodotExecutable", str(godot),
        "-AlWorkerProjectRoot", str(project),
        "-AlWorkerRunMode", mode, "-AlWorkerRunId", run_id,
        "-AlWorkerInvocationId", invocation_id,
        "-AlWorkerOrdinal", str(ordinal), "-AlWorkerCaseName", name,
        "-AlWorkerCaseKind", kind, "-AlWorkerScriptPath", script,
        "-AlWorkerRequiredMarker", marker, "-AlWorkerStderrPolicy", stderr_policy,
        "-AlWorkerOutputPath", str(output),
    ]
    if synthetic_probe_input is not None:
        command.extend([
            "-AlWorkerSyntheticInputPath", str(synthetic_probe_input),
            "-AlWorkerSyntheticProbe",
            "-AlWorkerModuleImportCount", str(synthetic_probe_module_import_count),
        ])
        if synthetic_probe_omit_canonical:
            command.append("-AlWorkerSyntheticProbeOmitCanonical")
    return command


def run(args: argparse.Namespace) -> dict[str, Any]:
    project = Path(args.project_root).resolve()
    if project != Path(r"D:\Delayed_Self"):
        raise AlError("PROJECT_ROOT_INVALID")
    tools_root = (project / "tests" / "tools").resolve()
    worker = tools_root / "task_0024al_case_worker.ps1"
    manifest, manifest_raw, qualification_kind, validated_cases = load_manifest(
        Path(args.manifest), args.mode, args.run_id, tools_root
    )
    prefix = canonical_tools_path(Path(args.output_prefix), tools_root, "task_0024al_")
    if prefix.suffix:
        raise AlError("OUTPUT_PREFIX_MUST_HAVE_NO_SUFFIX")
    required_prefix_token = {
        "focused": "_focused_",
        "full_rehearsal": "_rehearsal_",
        "retained": "_retained_",
    }[qualification_kind]
    if required_prefix_token not in prefix.name:
        raise AlError(f"OUTPUT_PREFIX_IDENTITY_INVALID:{qualification_kind}")
    invocation_id = args.invocation_id or str(uuid.uuid4())
    if args.synthetic_probe_input or args.synthetic_probe_aggregate_input:
        if (args.mode != "qualification" or not args.run_id.startswith("probe-") or
                not args.synthetic_probe_input or not args.synthetic_probe_aggregate_input):
            raise AlError("SYNTHETIC_PROBE_ARGUMENTS_INVALID")
    if (args.synthetic_probe_omit_canonical_ordinal and
            (not args.synthetic_probe_input or
             args.synthetic_probe_omit_canonical_ordinal not in range(1, 6))):
        raise AlError("SYNTHETIC_OMIT_CANONICAL_ARGUMENT_INVALID")
    progress_path = Path(str(prefix) + "_progress.json")
    final_path = Path(str(prefix) + "_result.json")
    consumption_path = Path(str(Path(args.manifest).resolve()) + ".consumed.json")
    existing = list(tools_root.glob(prefix.name + "_case_*.json"))
    if existing or progress_path.exists() or final_path.exists():
        raise AlError("RUN_OUTPUT_ALREADY_EXISTS")
    if godot_count() != 0:
        raise AlError("GODOT_NOT_ZERO_AT_START")
    manifest_hash = hashlib.sha256(manifest_raw).hexdigest()
    if args.mode == "retained":
        if Path(args.manifest).resolve().read_bytes() != manifest_raw:
            raise AlError("MANIFEST_CHANGED_BEFORE_CONSUMPTION")
        create_exclusive(consumption_path, {
            "schema_version": 1, "task_identity": TASK, "manifest_id": args.run_id,
            "manifest_sha256": manifest_hash, "status": "CONSUMED_BEFORE_FIRST_CASE",
        })
    elif consumption_path.exists():
        raise AlError("QUALIFICATION_CONSUMPTION_SIDECAR_FORBIDDEN")
    if args.probe_retained_sidecar:
        if args.mode != "qualification" or not args.run_id.startswith("probe-"):
            raise AlError("RETAINED_SIDECAR_PROBE_AUTHORITY_INVALID")
        create_exclusive(Path(args.probe_retained_sidecar).resolve(), {
            "schema_version": 1, "task_identity": TASK,
            "probe_run_id": args.run_id, "status": "CONSUMED_BEFORE_FIRST_CASE",
        })
        raise AlError("INJECTED_RETAINED_SIDECAR_PROBE_AFTER_PUBLISH")
    accepted: list[dict[str, Any]] = []
    for ordinal, expected in enumerate(validated_cases, 1):
        if godot_count() != 0:
            raise AlError(f"GODOT_NOT_ZERO_BEFORE_WORKER:{ordinal}")
        output = Path(f"{prefix}_case_{ordinal:02d}_{expected[0]}.json")
        command = worker_command(
            args.pwsh, worker, godot=Path(args.godot_executable), project=project,
            mode=args.mode, run_id=args.run_id, invocation_id=invocation_id,
            ordinal=ordinal, case=expected, output=output,
            synthetic_probe_input=(
                Path(args.synthetic_probe_aggregate_input)
                if args.synthetic_probe_input and expected[0] == "aggregate"
                else Path(args.synthetic_probe_input) if args.synthetic_probe_input else None
            ),
            synthetic_probe_module_import_count=args.synthetic_probe_module_import_count,
            synthetic_probe_omit_canonical=(
                args.synthetic_probe_omit_canonical_ordinal == ordinal
            ),
        )
        completed = subprocess.run(command, capture_output=True, text=True)
        if completed.returncode != 0:
            raise AlError(f"WORKER_FAILED:{ordinal}:{completed.stderr.strip()}")
        stdout_lines = [line for line in completed.stdout.splitlines() if line.strip()]
        if len(stdout_lines) != 1:
            raise AlError(f"WORKER_STDOUT_CARDINALITY_INVALID:{ordinal}")
        try:
            acknowledgement = json.loads(stdout_lines[0])
        except json.JSONDecodeError as exc:
            raise AlError(f"WORKER_ACK_INVALID:{ordinal}") from exc
        if acknowledgement.get("status") != "PASS" or not output.exists():
            raise AlError(f"WORKER_ACK_OR_FILE_INVALID:{ordinal}")
        raw = output.read_bytes()
        record = validate_case_record(
            output, raw, mode=args.mode, run_id=args.run_id,
            invocation_id=invocation_id, ordinal=ordinal, expected=expected,
            tools_root=tools_root,
        )
        if godot_count() != 0:
            raise AlError(f"GODOT_NOT_ZERO_AFTER_WORKER:{ordinal}")
        accepted.append({
            "ordinal": ordinal, "case_name": expected[0], "path": str(output),
            "sha256": hashlib.sha256(raw).hexdigest(),
            "canonical_case_record_sha256": record["canonical_case_record_sha256"],
        })
        atomic_write(progress_path, compact({
            "schema_version": 1, "task_identity": TASK, "run_mode": args.mode,
            "run_id": args.run_id, "invocation_id": invocation_id,
            "completed_case_count": len(accepted), "completed_cases": accepted,
        }).encode("utf-8"))
        if args.inject_failure_after_case == ordinal:
            raise AlError(f"INJECTED_PARENT_FAILURE_AFTER_CASE:{ordinal}")
    if godot_count() != 0:
        raise AlError("GODOT_NOT_ZERO_AT_CLOSEOUT")
    result = {
        "schema_version": 1, "task_identity": TASK, "status": "PASS",
        "run_mode": args.mode, "run_id": args.run_id, "invocation_id": invocation_id,
        "qualification_kind": (
            qualification_kind if args.mode == "qualification" else None
        ),
        "manifest_sha256": manifest_hash,
        "completed_case_count": len(validated_cases),
        "progress_path": str(progress_path), "cases": accepted, "final_godot_count": 0,
        "synthetic_probe": bool(args.synthetic_probe_input),
        "orchestrator_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        "worker_sha256": hashlib.sha256(worker.read_bytes()).hexdigest(),
        "parser_sha256": hashlib.sha256(
            (tools_root / "task_0024al_worker_parser.psm1").read_bytes()
        ).hexdigest(),
    }
    result["progress_sha256"] = hashlib.sha256(progress_path.read_bytes()).hexdigest()
    atomic_write(final_path, compact(result).encode("utf-8"), exclusive=True)
    return result


def parser() -> argparse.ArgumentParser:
    result = argparse.ArgumentParser()
    result.add_argument("--mode", choices=("qualification", "retained"), required=True)
    result.add_argument("--manifest", required=True)
    result.add_argument("--run-id", required=True)
    result.add_argument("--invocation-id")
    result.add_argument("--output-prefix", required=True)
    result.add_argument("--project-root", required=True)
    result.add_argument("--godot-executable", required=True)
    result.add_argument("--pwsh", default="pwsh")
    result.add_argument("--inject-failure-after-case", type=int, default=0)
    result.add_argument("--synthetic-probe-input")
    result.add_argument("--synthetic-probe-aggregate-input")
    result.add_argument("--synthetic-probe-module-import-count", type=int, default=1)
    result.add_argument("--synthetic-probe-omit-canonical-ordinal", type=int, default=0)
    result.add_argument("--probe-retained-sidecar")
    return result


def main() -> int:
    try:
        result = run(parser().parse_args())
        print(compact(result))
        return 0
    except Exception as exc:
        try:
            final_count = godot_count()
        except Exception as count_exc:
            print(
                f"TASK_0024AL_ORCHESTRATOR_FAIL:{exc}:FINAL_GODOT_COUNT_ERROR:{count_exc}",
                file=sys.stderr,
            )
            return 1
        print(
            f"TASK_0024AL_ORCHESTRATOR_FAIL:{exc}:FINAL_GODOT_COUNT:{final_count}",
            file=sys.stderr,
        )
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
