from __future__ import annotations

import argparse
import hashlib
import json
import os
import subprocess
import tempfile
import uuid
from datetime import datetime, timezone
from pathlib import Path

ROOT = Path(r"D:\Delayed_Self")
TOOLS = ROOT / "tests" / "tools"
WORKER = TOOLS / "task_0024aw_case_worker.ps1"
CASES = (
    ("focused_c02", "res://tests/levels/task_0024aw_c02_crate_pressure_imprint_validation.gd",
     "TASK_0024AW_C02_CRATE_PRESSURE_IMPRINT_PASS", "RequireEmpty"),
    ("aggregate", "res://tests/run_all.gd",
     "TASK_0003_TESTS_PASS assertions=621 vectors=9", "AggregateMismatch"),
    ("complete_v2", "res://tests/simulation/task_0024v_v2_solver_replay_canonical_malformed.gd",
     "TASK_0024V_V2_COMPLETE_PASS", "RequireEmpty"),
)


def compact(value):
    return json.dumps(value, ensure_ascii=False, separators=(",", ":"))


def atomic(path: Path, value, exclusive=False):
    data = compact(value).encode("utf-8")
    fd, name = tempfile.mkstemp(prefix=path.name + ".tmp.", dir=path.parent)
    temporary = Path(name)
    try:
        with os.fdopen(fd, "wb") as stream:
            stream.write(data)
            stream.flush()
            os.fsync(stream.fileno())
        if exclusive:
            os.link(temporary, path)
            temporary.unlink()
        else:
            os.replace(temporary, path)
        if path.read_bytes() != data:
            raise RuntimeError("ATOMIC_REOPEN_MISMATCH")
    finally:
        temporary.unlink(missing_ok=True)


def file_sha(path: Path):
    return hashlib.sha256(path.read_bytes()).hexdigest().upper()


def godot_count():
    out = subprocess.run(["tasklist", "/FO", "CSV", "/NH"], check=True,
                         capture_output=True, text=True, encoding="utf-8",
                         errors="replace").stdout
    return sum(line.lower().startswith('"godot') for line in out.splitlines())


def consume_manifest(path: Path, run_id: str):
    manifest = json.loads(path.read_text(encoding="utf-8"))
    if manifest != {"schema_version": 1, "task_identity": "0024AW",
                    "manifest_id": run_id, "status": "DECLARED",
                    "cases": [list(case) for case in CASES]}:
        raise RuntimeError("MANIFEST_CONTRACT_INVALID")
    consumed = path.with_suffix(path.suffix + ".consumed.json")
    atomic(consumed, {"schema_version": 1, "task_identity": "0024AW",
                      "manifest_id": run_id, "status": "CONSUMED",
                      "consumed_utc": datetime.now(timezone.utc).isoformat()},
           exclusive=True)
    return consumed


def run(mode: str, kind: str, manifest: Path | None):
    run_id = manifest.stem.split("_")[-1] if mode == "retained" else str(uuid.uuid4())
    selected = CASES[:1] if kind == "focused" else (CASES[1:] if kind == "matrix" else CASES)
    if mode == "retained":
        if manifest is None:
            raise RuntimeError("MANIFEST_REQUIRED")
        data = json.loads(manifest.read_text(encoding="utf-8"))
        run_id = data["manifest_id"]
        consume_manifest(manifest, run_id)
        selected = CASES
    if godot_count() != 0:
        raise RuntimeError("PREEXISTING_GODOT")
    journal = []
    for ordinal, case in enumerate(selected, 1):
        name, script, marker, policy = case
        target = TOOLS / f"task_0024aw_{mode}_{run_id}_case_{ordinal:02d}_{name}.json"
        if target.exists():
            raise RuntimeError("CASE_OUTPUT_EXISTS")
        completed = subprocess.run([
            "pwsh", "-NoProfile", "-NonInteractive", "-File", str(WORKER),
            "-OutputPath", str(target), "-RunId", run_id, "-Ordinal", str(ordinal),
            "-CaseName", name, "-ScriptPath", script, "-Marker", marker,
            "-EvidenceStderrPolicy", policy,
        ], capture_output=True, text=True, encoding="utf-8", errors="replace")
        if not target.exists():
            raise RuntimeError(f"CASE_RECORD_MISSING:{name}:{completed.stderr}")
        record = json.loads(target.read_text(encoding="utf-8"))
        if (record["status"] != "PASS" or record["run_id"] != run_id or
                record["ordinal"] != ordinal or file_sha(target) == ""):
            raise RuntimeError(f"CASE_RECORD_INVALID:{name}")
        journal.append({"ordinal": ordinal, "case_name": name,
                        "record": target.name, "sha256": file_sha(target)})
        atomic(TOOLS / f"task_0024aw_{mode}_{run_id}_progress.json",
               {"schema_version": 1, "task_identity": "0024AW", "run_id": run_id,
                "status": "IN_PROGRESS", "completed": journal})
        if completed.returncode != 0:
            raise RuntimeError(f"WORKER_FAILED:{name}:{completed.stderr}")
    result = {"schema_version": 1, "task_identity": "0024AW", "run_id": run_id,
              "mode": mode, "kind": kind, "status": "PASS", "cases": journal,
              "godot_final_count": godot_count(),
              "completed_utc": datetime.now(timezone.utc).isoformat()}
    result_path = TOOLS / f"task_0024aw_{mode}_{run_id}_result.json"
    atomic(result_path, result, exclusive=True)
    print(compact({"status": "PASS", "run_id": run_id,
                   "result_path": str(result_path)}))


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--mode", choices=("qualification", "retained"), required=True)
    parser.add_argument("--kind", choices=("focused", "matrix", "full"), default="full")
    parser.add_argument("--manifest", type=Path)
    args = parser.parse_args()
    run(args.mode, args.kind, args.manifest)


if __name__ == "__main__":
    main()
