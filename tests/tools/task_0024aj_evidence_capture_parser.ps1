[CmdletBinding(DefaultParameterSetName='Parse')]
param([Parameter(Mandatory,ParameterSetName='Parse')][string[]]$Lines,[Parameter(ParameterSetName='Library',Mandatory)][switch]$Library)
Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'
function Stop-Task0024AJEvidence([string]$Reason){throw "TASK_0024AJ_EVIDENCE_CAPTURE_FAIL:$Reason"}
function Get-Task0024AJEvidenceSha256([byte[]]$Bytes){$algorithm=[Security.Cryptography.SHA256]::Create();try{return (-join ($algorithm.ComputeHash($Bytes)|ForEach-Object{$_.ToString('x2')}))}finally{$algorithm.Dispose()}}
function ConvertFrom-Task0024AJEvidenceLines {
 param([Parameter(Mandatory)][string[]]$Lines)
 $records=@(); $seen=@{}
 foreach($line in $Lines){
  if(-not $line.StartsWith('TASK_0024AJ_EVIDENCE ')){continue}
  $raw=$line.Substring('TASK_0024AJ_EVIDENCE '.Length); $bytes=[Text.Encoding]::UTF8.GetBytes($raw)
  if($bytes.Length -ge 1800){Stop-Task0024AJEvidence "OVER_BOUND:$($bytes.Length)"}
  try{if((Get-Command ConvertFrom-Json).Parameters.ContainsKey('Depth')){$record=$raw|ConvertFrom-Json -Depth 100 -ErrorAction Stop}else{$record=$raw|ConvertFrom-Json -ErrorAction Stop}}catch{Stop-Task0024AJEvidence 'INVALID_JSON'}
  if($record -is [array] -or $record -isnot [pscustomobject]){Stop-Task0024AJEvidence 'NOT_OBJECT'}
  if($null -eq $record.schema_version -or [int]$record.schema_version -ne 1 -or [string]::IsNullOrWhiteSpace([string]$record.kind)){Stop-Task0024AJEvidence 'MISSING_SCHEMA_OR_KIND'}
  if($seen.ContainsKey([string]$record.kind)){Stop-Task0024AJEvidence "DUPLICATE_KIND:$($record.kind)"}; $seen[[string]$record.kind]=$true
  $records += [ordered]@{kind=[string]$record.kind;utf8_byte_count=$bytes.Length;utf8_sha256=(Get-Task0024AJEvidenceSha256 -Bytes $bytes);record=$record}
 }
 $required=@('multi_subagent_ledger','adapter_parser_qualification','static_preservation','candidate_route_preflight','sensor_public_contract_inventory','sensor_barrier_lifecycle','swapped_identity_wrong_actor_control','lifecycle_signature_registry','crate_lifecycle','key_lock_inventory_lifecycle','latch_lifecycle','fit_layering_v1_regression','summary')
 foreach($kind in $required){if(-not $seen.ContainsKey($kind)){Stop-Task0024AJEvidence "MISSING_KIND:$kind"}}
 foreach($kind in $seen.Keys){if($required -notcontains $kind){Stop-Task0024AJEvidence "UNKNOWN_KIND:$kind"}}
 if($records.Count -ne $required.Count){Stop-Task0024AJEvidence "EXACT_COUNT_MISMATCH:$($records.Count)"}
 $totalUtf8Bytes=[long]0
 foreach($item in $records){$totalUtf8Bytes += [long]$item.utf8_byte_count}
 [ordered]@{schema_version=1;status='PASS';record_count=$records.Count;records=$records;total_utf8_bytes=$totalUtf8Bytes}
}
if($Library){return}
ConvertFrom-Task0024AJEvidenceLines -Lines $Lines|ConvertTo-Json -Depth 100 -Compress
