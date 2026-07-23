from __future__ import annotations

import hashlib
import importlib.util
import json
import os
import subprocess
import sys
import tempfile
import uuid
from pathlib import Path

ROOT = Path(r"D:\Delayed_Self")
TOOLS = ROOT / "tests" / "tools"
ORCHESTRATOR = TOOLS / "task_0024al_orchestrator.py"


def load_orchestrator():
    spec = importlib.util.spec_from_file_location("al_probe_orchestrator", ORCHESTRATOR)
    if spec is None or spec.loader is None:
        raise RuntimeError("ORCHESTRATOR_IMPORT_FAILED")
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def main() -> int:
    source = ORCHESTRATOR.read_text(encoding="utf-8")
    forbidden = [value for value in ("Import-Module", "dot-source", "-Command")
                 if value in source]
    if forbidden or '"-NoProfile", "-NonInteractive", "-File"' not in source:
        raise RuntimeError(f"ORCHESTRATOR_SOURCE_CONTRACT:{forbidden}")
    module = load_orchestrator()
    token = uuid.uuid4().hex
    run_id = f"probe-{token}"
    prefix = TOOLS / f"task_0024al_probe_rehearsal_{token}"
    plan = TOOLS / f"task_0024al_qualification_plan_probe_{token}.json"
    case_path = Path(str(prefix) + "_case_01_sensor_contract_dynamic_signature.json")
    journal_path = Path(str(prefix) + "_progress.json")
    result_path = Path(str(prefix) + "_result.json")
    missing_prefix = TOOLS / f"task_0024al_missing_rehearsal_{token}"
    missing_journal = TOOLS / f"task_0024al_missing_rehearsal_{token}_progress.json"
    missing_result = TOOLS / f"task_0024al_missing_rehearsal_{token}_result.json"
    missing_case = TOOLS / (
        f"task_0024al_missing_rehearsal_{token}_case_01_"
        "sensor_contract_dynamic_signature.json"
    )
    focused_prefix = TOOLS / f"task_0024al_probe_focused_{token}"
    focused_plan = TOOLS / f"task_0024al_qualification_plan_focused_{token}.json"
    focused_case = Path(
        str(focused_prefix) + "_case_01_sensor_contract_dynamic_signature.json"
    )
    focused_journal = Path(str(focused_prefix) + "_progress.json")
    focused_result = Path(str(focused_prefix) + "_result.json")
    qualification_sidecar = Path(str(plan) + ".consumed.json")
    plan.write_text(json.dumps({
        "schema_version": 1, "task_identity": "0024AL",
        "qualification_run_id": run_id, "status": "QUALIFICATION_PLAN",
        "qualification_kind": "full_rehearsal",
        "cases": [
            {"name": case[0], "kind": case[1], "script_path": case[2],
             "marker": case[3], "stderr_policy": case[4]}
            for case in module.EXPECTED_CASES
        ],
    }, separators=(",", ":")), encoding="utf-8")
    first_case = module.EXPECTED_CASES[0]
    focused_plan.write_text(json.dumps({
        "schema_version": 1, "task_identity": "0024AL",
        "qualification_run_id": run_id, "status": "QUALIFICATION_PLAN",
        "qualification_kind": "focused",
        "cases": [{
            "name": first_case[0], "kind": first_case[1],
            "script_path": first_case[2], "marker": first_case[3],
            "stderr_policy": first_case[4],
        }],
    }, separators=(",", ":")), encoding="utf-8")
    sentinel_name = "TASK_0024AL_PARENT_SENTINEL"
    sentinel_prior = os.environ.get(sentinel_name)
    os.environ[sentinel_name] = "parent-byte-stable-value"
    before_crash_bytes = b""
    missing_parent_returncode = None
    missing_parent_stderr = ""
    try:
        with tempfile.TemporaryDirectory(prefix="task_0024al_probe_") as temporary:
            focused_fixture = Path(temporary) / "focused.json"
            ak_record = json.loads(
                (TOOLS / "task_0024ak_qualification_repeatable_2.json").read_text(
                    encoding="utf-8"
                )
            )
            focused_fixture.write_text(
                ak_record["capture"]["raw_wrapper_json"], encoding="utf-8"
            )
            aggregate_fixture = Path(temporary) / "aggregate.json"
            aggregate_fixture.write_text(json.dumps({
                "schema_version": 2, "status": "PASS", "underlying_status": "PASS",
                "native_exit_code": 0, "timed_out": False, "marker_pass": True,
                "stderr_pass": True, "cleanup_invocation_count": 1,
                "cleanup_order": [999], "remaining_owned_pids": [],
                "remaining_unproven_pids": [],
                "stdout": ["TASK_0003_TESTS_PASS assertions=621 vectors=9"],
                "stderr": ["LEVEL_ID_MISMATCH"], "wrapper_error": "",
                "cleanup_error": "",
            }, separators=(",", ":")), encoding="utf-8")
            focused_command = [
                sys.executable, "-B", str(ORCHESTRATOR), "--mode", "qualification",
                "--manifest", str(focused_plan), "--run-id", run_id,
                "--invocation-id", f"focused-{token}",
                "--output-prefix", str(focused_prefix),
                "--project-root", str(ROOT), "--godot-executable", "synthetic-no-godot",
                "--synthetic-probe-input", str(focused_fixture),
                "--synthetic-probe-aggregate-input", str(aggregate_fixture),
            ]
            focused_run = subprocess.run(
                focused_command, capture_output=True, text=True
            )
            if focused_run.returncode != 0:
                raise RuntimeError(
                    f"FOCUSED_REAL_ORCHESTRATOR_FAILED:{focused_run.stderr}"
                )
            focused_record = json.loads(focused_run.stdout)
            focused_progress = json.loads(focused_journal.read_text(encoding="utf-8"))
            focused_persisted = json.loads(focused_result.read_text(encoding="utf-8"))
            focused_case_files = list(
                TOOLS.glob(f"{focused_prefix.name}_case_*.json")
            )
            if (
                not focused_case.exists()
                or len(focused_case_files) != 1
                or focused_record.get("qualification_kind") != "focused"
                or focused_record.get("completed_case_count") != 1
                or focused_progress.get("completed_case_count") != 1
                or focused_persisted != focused_record
                or len(focused_record.get("cases", [])) != 1
                or focused_record["cases"][0].get("case_name") != first_case[0]
            ):
                raise RuntimeError("FOCUSED_EXACTLY_ONE_CASE_INVALID")
            command = [
                sys.executable, "-B", str(ORCHESTRATOR), "--mode", "qualification",
                "--manifest", str(plan), "--run-id", run_id,
                "--invocation-id", token, "--output-prefix", str(prefix),
                "--project-root", str(ROOT), "--godot-executable", "synthetic-no-godot",
                "--inject-failure-after-case", "1",
                "--synthetic-probe-input", str(focused_fixture),
                "--synthetic-probe-aggregate-input", str(aggregate_fixture),
                "--synthetic-probe-module-import-count", "2",
            ]
            crashed = subprocess.run(command, capture_output=True, text=True)
            if (crashed.returncode == 0 or
                    "INJECTED_PARENT_FAILURE_AFTER_CASE:1" not in crashed.stderr):
                raise RuntimeError(f"CRASH_INJECTION_FAILED:{crashed.stderr}")
            if os.environ[sentinel_name] != "parent-byte-stable-value":
                raise RuntimeError("PARENT_SENTINEL_CHANGED")
            if not case_path.exists() or not journal_path.exists():
                raise RuntimeError("CASE_OR_JOURNAL_NOT_DURABLE")
            before_crash_bytes = case_path.read_bytes()
            json.loads(before_crash_bytes.decode("utf-8"))
            journal = json.loads(journal_path.read_text(encoding="utf-8"))
            if journal.get("completed_case_count") != 1:
                raise RuntimeError("JOURNAL_COUNT_INVALID")
            if qualification_sidecar.exists():
                raise RuntimeError("QUALIFICATION_CREATED_SIDECAR")
            missing_command = [
                sys.executable, "-B", str(ORCHESTRATOR), "--mode", "qualification",
                "--manifest", str(plan), "--run-id", run_id,
                "--invocation-id", f"missing-{token}",
                "--output-prefix", str(missing_prefix),
                "--project-root", str(ROOT), "--godot-executable", "synthetic-no-godot",
                "--synthetic-probe-input", str(focused_fixture),
                "--synthetic-probe-aggregate-input", str(aggregate_fixture),
                "--synthetic-probe-omit-canonical-ordinal", "1",
            ]
            missing_run = subprocess.run(missing_command, capture_output=True, text=True)
            missing_parent_returncode = missing_run.returncode
            missing_parent_stderr = missing_run.stderr.strip()
            if (missing_run.returncode == 0 or
                    "WORKER_ACK_OR_FILE_INVALID:1" not in missing_run.stderr):
                raise RuntimeError(
                    f"MISSING_CANONICAL_NOT_FAIL_CLOSED:{missing_run.stderr}"
                )
            if (missing_case.exists() or missing_journal.exists() or
                    missing_result.exists() or qualification_sidecar.exists()):
                raise RuntimeError("MISSING_CANONICAL_CREATED_FALSE_PROGRESS")
            invalid_worker_output = TOOLS / (
                f"task_0024al_probe_{token}_invalid_case_01_"
                "sensor_contract_dynamic_signature.json"
            )
            invalid_worker = subprocess.run([
                "pwsh", "-NoProfile", "-NonInteractive", "-File",
                str(TOOLS / "task_0024al_case_worker.ps1"),
                "-AlWorkerGodotExecutable", "synthetic-no-godot",
                "-AlWorkerProjectRoot", str(ROOT),
                "-AlWorkerRunMode", "qualification", "-AlWorkerRunId", run_id,
                "-AlWorkerInvocationId", token, "-AlWorkerOrdinal", "1",
                "-AlWorkerCaseName", "wrong_case_name", "-AlWorkerCaseKind", "wrapper",
                "-AlWorkerScriptPath", module.EXPECTED_CASES[0][2],
                "-AlWorkerRequiredMarker", module.EXPECTED_CASES[0][3],
                "-AlWorkerStderrPolicy", "RequireEmpty",
                "-AlWorkerOutputPath", str(invalid_worker_output),
                "-AlWorkerSyntheticInputPath", str(focused_fixture),
                "-AlWorkerSyntheticProbe",
            ], capture_output=True, text=True)
            if (invalid_worker.returncode == 0 or
                    "CASE_ORDINAL_CONTRACT_INVALID" not in invalid_worker.stderr or
                    invalid_worker_output.exists()):
                raise RuntimeError("WORKER_EXACT_CASE_CONTRACT_NOT_ENFORCED")
            probe_sidecar = Path(temporary) / "retained_probe.consumed.json"
            sidecar_command = [
                sys.executable, "-B", str(ORCHESTRATOR), "--mode", "qualification",
                "--manifest", str(plan), "--run-id", run_id,
                "--output-prefix", str(
                    TOOLS / f"task_0024al_sidecar_rehearsal_{token}"
                ),
                "--project-root", str(ROOT), "--godot-executable", "synthetic-no-godot",
                "--probe-retained-sidecar", str(probe_sidecar),
            ]
            first = subprocess.run(sidecar_command, capture_output=True, text=True)
            second = subprocess.run(sidecar_command, capture_output=True, text=True)
            if ("INJECTED_RETAINED_SIDECAR_PROBE_AFTER_PUBLISH" not in first.stderr or
                    "EXCLUSIVE_FILE_EXISTS" not in second.stderr):
                raise RuntimeError(f"SIDECAR_EXACTLY_ONCE_FAILED:{first.stderr}:{second.stderr}")
            persisted_sidecar = json.loads(probe_sidecar.read_text(encoding="utf-8"))
            if persisted_sidecar.get("status") != "CONSUMED_BEFORE_FIRST_CASE":
                raise RuntimeError("SIDECAR_REOPEN_INVALID")
    finally:
        for candidate in (
            case_path, journal_path, result_path, missing_case, missing_journal,
            missing_result, focused_case, focused_journal, focused_result,
            focused_plan, plan, qualification_sidecar
        ):
            if candidate.exists():
                candidate.unlink()
        if sentinel_prior is None:
            os.environ.pop(sentinel_name, None)
        else:
            os.environ[sentinel_name] = sentinel_prior
    print(json.dumps({
        "schema_version": 1, "task_identity": "0024AL", "status": "PASS",
        "real_orchestrator_subprocess": True,
        "fresh_worker_command": ["pwsh", "-NoProfile", "-NonInteractive", "-File"],
        "worker_module_import_count": 2, "parent_sentinel_preserved": True,
        "worker_exact_case_contract_rejected": True,
        "missing_canonical_real_parent_rejected": True,
        "missing_canonical_error": "WORKER_ACK_OR_FILE_INVALID:1",
        "missing_parent_returncode": missing_parent_returncode,
        "missing_parent_stderr": missing_parent_stderr,
        "missing_canonical_journal_count": 0,
        "durable_case_after_parent_crash": True,
        "parent_crash_case_sha256": hashlib.sha256(before_crash_bytes).hexdigest(),
        "journal_completed_case_count": 1, "qualification_sidecar_created": False,
        "focused_real_orchestrator_exactly_one_case": True,
        "focused_completed_case_count": 1,
        "retained_sidecar_created_exactly_once": True,
        "retained_reuse_rejected": True,
    }, separators=(",", ":")))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
