from __future__ import annotations

import argparse
import fnmatch
import hashlib
import json
import subprocess
import sys
from pathlib import Path


ROOT = Path(r"D:\Delayed_Self")
TOOLS = ROOT / "tests" / "tools"
ALLOWED_DOCS = {
    "docs/reports/0024AL_PROCESS_ISOLATED_WRITE_AHEAD_RETAINED_CYCLE_AND_SCHEMA_V2_VISUAL_VALIDATION_REPORT.md",
    "docs/presentation/SCHEMA_V2_MINIMUM_OWNER_REVIEW_VISUAL_CONTRACT_CURRENT.md",
    "docs/playtest/SUBMISSION_CORE_1_12_OWNER_CURRICULUM_REVIEW_CURRENT.md",
    "docs/CODEX_ACTIVE_TASK_CURRENT.md", "docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md",
    "docs/DEVELOPMENT_PLAN_CURRENT.md", "docs/DOC_INDEX_CURRENT.md",
    "docs/HANDOFF_MASTER_CURRENT.md", "docs/project_memory.md",
    "docs/production/EXPANDED_CONTENT_SUBMISSION_ROADMAP_CURRENT.md",
}
ALLOWED_TOOLS = {
    "tests/tools/task_0024al_case_worker.ps1",
    "tests/tools/task_0024al_worker_parser.psm1",
    "tests/tools/task_0024al_orchestrator.py",
    "tests/tools/task_0024al_process_isolation_probes.py",
    "tests/tools/task_0024al_worker_parser_probes.ps1",
    "tests/tools/task_0024al_orchestrator_probes.py",
    "tests/tools/task_0024al_static_preservation.py",
}
PROTECTED = (
    "project.godot", "scenes/*", "data/catalog/*", "data/levels/*", "scripts/*",
    "schemas/*", "tests/run_all.gd", "tests/simulation/*", "tests/levels/*",
    "tests/curriculum/*", "tests/playtest/*", "tests/presentation/*",
    "tests/tools/run_owned_godot_headless.ps1", "localization/*", "assets/*", "audio/*",
)


class AuditError(RuntimeError):
    pass


def git(*arguments: str) -> list[str]:
    completed = subprocess.run(
        ["git", "-C", str(ROOT), *arguments], capture_output=True, text=True
    )
    if completed.returncode:
        raise AuditError(f"GIT_FAILED:{arguments}:{completed.stderr.strip()}")
    return completed.stdout.splitlines()


def exactly_one(values: list[str], label: str) -> str:
    if len(values) != 1:
        raise AuditError(f"EXPECTED_ONE:{label}:{len(values)}")
    return values[0]


def blob(reference: str, path: str) -> str:
    return exactly_one(git("rev-parse", f"{reference}:{path}"), path)


def current_blob(path: str) -> str:
    return exactly_one(git("hash-object", "--", path), path)


def protected(path: str) -> bool:
    return any(fnmatch.fnmatchcase(path, pattern) for pattern in PROTECTED)


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--task-start-head", required=True)
    parser.add_argument("--expected-config-sha256", required=True)
    parser.add_argument("--phase", choices=("PRE_FINAL", "POST_FINAL"), required=True)
    parser.add_argument("--rehearsal-result", required=True)
    args = parser.parse_args()
    if ROOT.resolve() != Path(r"D:\Delayed_Self"):
        raise AuditError("ROOT_INVALID")
    resolved = exactly_one(git("rev-parse", args.task_start_head), "task_start_head")
    if resolved != args.task_start_head:
        raise AuditError("TASK_START_HEAD_NOT_EXACT")
    status = git("status", "--porcelain=v1", "--untracked-files=all")
    changed = [line[3:].replace("\\", "/") for line in status
               if line[3:].replace("\\", "/") != ".codex/config.toml"]
    unauthorized = [
        path for path in changed
        if path not in ALLOWED_TOOLS and path not in ALLOWED_DOCS and
        not (path.startswith("tests/tools/task_0024al_") and path.endswith(".json")
             and "/" not in path[len("tests/tools/"):])
    ]
    start_paths = git("ls-tree", "-r", "--name-only", args.task_start_head)
    historical_paths = [
        path for path in start_paths
        if any(token in path.lower() for token in
               ("task_0024af_", "task_0024ag_", "task_0024ah_", "task_0024ai_",
                "task_0024aj_", "task_0024ak_", "0024af", "0024ag", "0024ah",
                "0024ai", "0024aj", "0024ak"))
    ]
    historical = [
        {"path": path, "expected_blob": blob(args.task_start_head, path),
         "current_blob": current_blob(path)}
        for path in historical_paths
    ]
    protected_inventory = [
        {"path": path, "expected_blob": blob(args.task_start_head, path),
         "current_blob": current_blob(path)}
        for path in start_paths if protected(path)
    ]
    critical = [
        "tests/tools/task_0024aj_retained_manifest.json",
        "tests/tools/task_0024aj_retained_manifest.json.consumed.json",
        "tests/tools/task_0024aj_retained_cycle_blocker.json",
        "tests/tools/task_0024ak_retained_manifest.json",
        "tests/tools/task_0024ak_retained_manifest.json.consumed.json",
        "tests/tools/task_0024ak_retained_cycle_blocker.json",
    ]
    critical_inventory = [
        {"path": path, "expected_blob": blob(args.task_start_head, path),
         "current_blob": current_blob(path)} for path in critical
    ]
    consumed = all(
        json.loads((ROOT / path).read_text(encoding="utf-8")).get("status")
        == "CONSUMED_BEFORE_FIRST_CASE"
        for path in (critical[1], critical[4])
    )
    wrapper_blob = current_blob("tests/tools/run_owned_godot_headless.ps1")
    config = ROOT / ".codex" / "config.toml"
    config_hash = hashlib.sha256(config.read_bytes()).hexdigest()
    config_status = git("status", "--short", "--untracked-files=all", "--",
                        ".codex/config.toml")
    parent_source = (TOOLS / "task_0024al_orchestrator.py").read_text(encoding="utf-8")
    worker_source = (TOOLS / "task_0024al_case_worker.ps1").read_text(encoding="utf-8")
    architecture_pass = (
        "Import-Module" not in parent_source and "dot-source" not in parent_source
        and "-Command" not in parent_source
        and '"-NoProfile", "-NonInteractive", "-File"' in parent_source
        and "Import-Module" in worker_source
        and "$AlWorkerStream.Flush($true)" in worker_source
        and "[IO.File]::Move(" in worker_source
    )
    rehearsal_path = Path(args.rehearsal_result).resolve()
    rehearsal = json.loads(rehearsal_path.read_text(encoding="utf-8"))
    rehearsal_cases = rehearsal.get("cases", [])
    rehearsal_case_pass = type(rehearsal_cases) is list and len(rehearsal_cases) == 5
    if rehearsal_case_pass:
        for ordinal, item in enumerate(rehearsal_cases, 1):
            expected_name = (
                "sensor_contract_dynamic_signature", "isolated_staging_route",
                "batch_1_12", "aggregate", "complete_v2"
            )[ordinal - 1]
            case_path = Path(item.get("path", "")).resolve()
            case_raw = case_path.read_bytes() if case_path.exists() else b""
            try:
                case_record = json.loads(case_raw.decode("utf-8"))
            except (UnicodeDecodeError, json.JSONDecodeError):
                case_record = {}
            if (item.get("ordinal") != ordinal or item.get("case_name") != expected_name or
                    case_path.parent != TOOLS.resolve() or not case_path.exists() or
                    hashlib.sha256(case_raw).hexdigest() != item.get("sha256") or
                    case_record.get("task_identity") != "0024AL" or
                    case_record.get("ordinal") != ordinal or
                    case_record.get("case_name") != expected_name or
                    case_record.get("canonical_case_record_sha256") !=
                    item.get("canonical_case_record_sha256")):
                rehearsal_case_pass = False
                break
    progress_path = Path(rehearsal.get("progress_path", "")).resolve()
    progress_pass = False
    if progress_path.parent == TOOLS.resolve() and progress_path.exists():
        progress_raw = progress_path.read_bytes()
        progress = json.loads(progress_raw.decode("utf-8"))
        progress_pass = (
            progress.get("task_identity") == "0024AL" and
            progress.get("completed_case_count") == 5 and
            len(progress.get("completed_cases", [])) == 5 and
            progress.get("completed_cases") == rehearsal_cases and
            hashlib.sha256(progress_raw).hexdigest() == rehearsal.get("progress_sha256")
        )
    architecture_hashes_pass = (
        rehearsal.get("orchestrator_sha256") ==
        hashlib.sha256((TOOLS / "task_0024al_orchestrator.py").read_bytes()).hexdigest()
        and rehearsal.get("worker_sha256") ==
        hashlib.sha256((TOOLS / "task_0024al_case_worker.ps1").read_bytes()).hexdigest()
        and rehearsal.get("parser_sha256") ==
        hashlib.sha256((TOOLS / "task_0024al_worker_parser.psm1").read_bytes()).hexdigest()
    )
    rehearsal_pass = (
        rehearsal.get("task_identity") == "0024AL" and rehearsal.get("status") == "PASS"
        and rehearsal.get("run_mode") == "qualification"
        and rehearsal.get("qualification_kind") == "full_rehearsal"
        and rehearsal.get("completed_case_count") == 5
        and rehearsal.get("synthetic_probe") is False
        and rehearsal_case_pass and progress_pass and architecture_hashes_pass
    )
    catalog = json.loads((ROOT / "data/catalog/level_catalog_v1.json").read_text())
    entries = catalog["entries"]
    finales = [entry for entry in entries if entry.get("final_level")]
    catalog_pass = len(entries) == 8 and len(finales) == 1 and finales[0]["sequence"] == 8
    matrix_path = "docs/level_design/validation/submission_core_1_12_curriculum_matrix.json"
    matrix = json.loads((ROOT / matrix_path).read_text(encoding="utf-8"))
    pairs = [
        {"sequence": item["sequence"], "level_id": item["level_id"],
         "l_star": item["solver"]["l_star"], "n_star": item["solver"]["n_star"],
         "n_status": item["solver"]["n_status"]}
        for item in matrix["levels"]
    ]
    matrix_pass = (
        len(pairs) == 12 and {item["sequence"] for item in pairs} == set(range(1, 13))
        and all(item["n_status"] == "EXACT" for item in pairs)
        and blob(args.task_start_head, matrix_path) == current_blob(matrix_path)
    )
    mismatch = [
        item for item in historical + protected_inventory + critical_inventory
        if item["expected_blob"] != item["current_blob"]
    ]
    passed = (
        not unauthorized and not mismatch and consumed
        and wrapper_blob == "5f14eb0feff903b40311c1c7283b20e2eabbffc2"
        and config_hash == args.expected_config_sha256.lower()
        and len(config_status) == 1 and config_status[0].startswith("?? ")
        and architecture_pass and rehearsal_pass and catalog_pass and matrix_pass
    )
    result = {
        "schema_version": 1, "task_identity": "0024AL", "phase": args.phase,
        "status": "PASS" if passed else "FAIL", "task_start_head": args.task_start_head,
        "changed_paths": changed, "unauthorized_changed_paths": unauthorized,
        "historical_af_ak_inventory": historical,
        "protected_inventory": protected_inventory, "critical_inventory": critical_inventory,
        "mismatch_count": len(mismatch), "historical_manifests_consumed": consumed,
        "wrapper_blob": wrapper_blob, "config_path": ".codex/config.toml",
        "config_sha256_actual": config_hash,
        "config_sha256_expected": args.expected_config_sha256.lower(),
        "architecture_pass": architecture_pass, "rehearsal_pass": rehearsal_pass,
        "rehearsal_case_pass": rehearsal_case_pass,
        "rehearsal_progress_pass": progress_pass,
        "rehearsal_architecture_hashes_pass": architecture_hashes_pass,
        "catalog_count": len(entries), "finale_sequences": [x["sequence"] for x in finales],
        "ad_12_l_n_pairs": pairs, "ad_matrix_pass": matrix_pass,
    }
    print(json.dumps(result, separators=(",", ":")))
    return 0 if passed else 1


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except Exception as exc:
        print(f"TASK_0024AL_STATIC_PRESERVATION_FAIL:{exc}", file=sys.stderr)
        raise SystemExit(1)
