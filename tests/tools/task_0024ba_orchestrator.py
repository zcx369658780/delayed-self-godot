from __future__ import annotations
import argparse, hashlib, json, os, subprocess, tempfile, uuid
from datetime import datetime, timezone
from pathlib import Path

ROOT=Path(r"D:\Delayed_Self"); TOOLS=ROOT/"tests"/"tools"
WORKER=TOOLS/"task_0024ba_case_worker.ps1"
CASES=(
 ("focused_c07","res://tests/levels/task_0024ba_c07_crate_echo_handoff_validation.gd","TASK_0024BA_C07_CRATE_ECHO_HANDOFF_PASS","RequireEmpty"),
 ("aggregate","res://tests/run_all.gd","TASK_0003_TESTS_PASS assertions=621 vectors=9","AggregateMismatch"),
 ("complete_v2","res://tests/simulation/task_0024v_v2_solver_replay_canonical_malformed.gd","TASK_0024V_V2_COMPLETE_PASS","RequireEmpty"),
)
def compact(v): return json.dumps(v,ensure_ascii=False,separators=(",",":"))
def atomic(path,value,exclusive=False):
 data=compact(value).encode(); fd,name=tempfile.mkstemp(prefix=path.name+".tmp.",dir=path.parent); temp=Path(name)
 try:
  with os.fdopen(fd,"wb") as stream: stream.write(data); stream.flush(); os.fsync(stream.fileno())
  if exclusive: os.link(temp,path); temp.unlink()
  else: os.replace(temp,path)
  if path.read_bytes()!=data: raise RuntimeError("ATOMIC_REOPEN_MISMATCH")
 finally: temp.unlink(missing_ok=True)
def sha(path): return hashlib.sha256(path.read_bytes()).hexdigest().upper()
def godot_count():
 out=subprocess.run(["tasklist","/FO","CSV","/NH"],check=True,capture_output=True,text=True,encoding="utf-8",errors="replace").stdout
 return sum(line.lower().startswith('"godot') for line in out.splitlines())
def consume(path,run_id):
 manifest=json.loads(path.read_text(encoding="utf-8"))
 expected={"schema_version":1,"task_identity":"0024BA","manifest_id":run_id,"status":"DECLARED","cases":[list(c) for c in CASES]}
 if manifest!=expected: raise RuntimeError("MANIFEST_CONTRACT_INVALID")
 atomic(path.with_suffix(path.suffix+".consumed.json"),{"schema_version":1,"task_identity":"0024BA","manifest_id":run_id,"status":"CONSUMED","consumed_utc":datetime.now(timezone.utc).isoformat()},True)
def run(mode,kind,manifest):
 run_id=str(uuid.uuid4()); selected=CASES[:1] if kind=="focused" else (CASES[1:] if kind=="matrix" else CASES)
 if mode=="retained":
  if manifest is None: raise RuntimeError("MANIFEST_REQUIRED")
  run_id=json.loads(manifest.read_text(encoding="utf-8"))["manifest_id"]; consume(manifest,run_id); selected=CASES
 if godot_count()!=0: raise RuntimeError("PREEXISTING_GODOT")
 journal=[]
 for ordinal,(name,script,marker,policy) in enumerate(selected,1):
  target=TOOLS/f"task_0024ba_{mode}_{run_id}_case_{ordinal:02d}_{name}.json"
  if target.exists(): raise RuntimeError("CASE_OUTPUT_EXISTS")
  done=subprocess.run(["pwsh","-NoProfile","-NonInteractive","-File",str(WORKER),"-OutputPath",str(target),"-RunId",run_id,"-Ordinal",str(ordinal),"-CaseName",name,"-ScriptPath",script,"-Marker",marker,"-EvidenceStderrPolicy",policy],capture_output=True,text=True,encoding="utf-8",errors="replace")
  if not target.exists(): raise RuntimeError(f"CASE_RECORD_MISSING:{name}:{done.stderr}")
  record=json.loads(target.read_text(encoding="utf-8"))
  if record["status"]!="PASS" or record["run_id"]!=run_id or record["ordinal"]!=ordinal: raise RuntimeError(f"CASE_RECORD_INVALID:{name}")
  journal.append({"ordinal":ordinal,"case_name":name,"record":target.name,"sha256":sha(target)})
  atomic(TOOLS/f"task_0024ba_{mode}_{run_id}_progress.json",{"schema_version":1,"task_identity":"0024BA","run_id":run_id,"status":"IN_PROGRESS","completed":journal})
  if done.returncode!=0: raise RuntimeError(f"WORKER_FAILED:{name}:{done.stderr}")
 result={"schema_version":1,"task_identity":"0024BA","run_id":run_id,"mode":mode,"kind":kind,"status":"PASS","cases":journal,"godot_final_count":godot_count(),"completed_utc":datetime.now(timezone.utc).isoformat()}
 path=TOOLS/f"task_0024ba_{mode}_{run_id}_result.json"; atomic(path,result,True)
 print(compact({"status":"PASS","run_id":run_id,"result_path":str(path)}))
def main():
 p=argparse.ArgumentParser();p.add_argument("--mode",choices=("qualification","retained"),required=True);p.add_argument("--kind",choices=("focused","matrix","full"),default="full");p.add_argument("--manifest",type=Path);a=p.parse_args();run(a.mode,a.kind,a.manifest)
if __name__=="__main__":main()
