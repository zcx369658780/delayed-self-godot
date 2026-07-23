[CmdletBinding()]param([Parameter(Mandatory)][string]$GodotPath,[Parameter(Mandatory)][string]$ProjectPath,[Parameter(Mandatory)][string]$ManifestPath)
Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'
function Stop-Task0024AJFinal([string]$Reason) { throw "TASK_0024AJ_FINAL_CYCLE_FAIL:$Reason" }
if(-not(Test-Path -LiteralPath $ManifestPath -PathType Leaf)){Stop-Task0024AJFinal 'MANIFEST_NOT_FOUND'}
try{$manifest=Get-Content -Raw -LiteralPath $ManifestPath|ConvertFrom-Json -Depth 100 -ErrorAction Stop}catch{Stop-Task0024AJFinal 'MANIFEST_INVALID_JSON'}
if($manifest.schema_version -ne 1 -or $manifest.task_identity -ne '0024AJ' -or $manifest.status -ne 'DECLARED' -or [string]::IsNullOrWhiteSpace([string]$manifest.manifest_id)){Stop-Task0024AJFinal 'MANIFEST_NOT_DECLARED'}
if($null -eq $manifest.cases -or $manifest.cases -isnot [array] -or $manifest.cases.Count -ne 5){Stop-Task0024AJFinal 'MANIFEST_CASES_INVALID'}
$adMatrixPath=Join-Path $ProjectPath 'docs\level_design\validation\submission_core_1_12_curriculum_matrix.json'
if(-not(Test-Path -LiteralPath $adMatrixPath -PathType Leaf)){Stop-Task0024AJFinal 'AD_MATRIX_MISSING'}
try{$adMatrix=Get-Content -Raw -LiteralPath $adMatrixPath|ConvertFrom-Json -Depth 100 -ErrorAction Stop}catch{Stop-Task0024AJFinal 'AD_MATRIX_INVALID_JSON'}
if($adMatrix.task -ne '0024AD' -or @($adMatrix.levels).Count -ne 12){Stop-Task0024AJFinal 'AD_MATRIX_CARDINALITY_INVALID'}
$adLNPairs=@($adMatrix.levels|ForEach-Object{[ordered]@{sequence=[int]$_.sequence;level_id=[string]$_.level_id;l_star=$_.solver.l_star;n_star=$_.solver.n_star;n_status=[string]$_.solver.n_status}})
if(@($adLNPairs|Where-Object{$_.sequence -lt 1 -or $_.sequence -gt 12 -or $null -eq $_.l_star -or $null -eq $_.n_star -or $_.n_status -ne 'EXACT'}).Count -ne 0 -or @($adLNPairs.sequence|Sort-Object -Unique).Count -ne 12){Stop-Task0024AJFinal 'AD_L_N_GATE_INVALID'}
$manifestHash=(Get-FileHash -LiteralPath $ManifestPath -Algorithm SHA256).Hash.ToLowerInvariant()
$consumptionPath="$ManifestPath.consumed.json"
if(Test-Path -LiteralPath $consumptionPath -PathType Leaf){Stop-Task0024AJFinal 'MANIFEST_ALREADY_CONSUMED'}
$authorizedRoot=[IO.Path]::GetFullPath($PSScriptRoot); $manifestDirectory=[IO.Path]::GetFullPath((Split-Path -Parent $ManifestPath))
if($manifestDirectory -ne $authorizedRoot -or -not ([IO.Path]::GetFileName($ManifestPath) -like 'task_0024aj_*.json')){Stop-Task0024AJFinal 'MANIFEST_NOT_CANONICAL_AJ_TOOLS_PATH'}
$expected=@(
 [ordered]@{name='sensor_contract_dynamic_signature';marker='TASK_0024AJ_SENSOR_CONTRACT_DYNAMIC_SIGNATURE_PASS';stderr_policy='RequireEmpty'},
 [ordered]@{name='isolated_staging_route';marker='TASK_0024AE_ISOLATED_STAGING_OWNER_ROUTE_PASS';stderr_policy='RequireEmpty'},
 [ordered]@{name='batch_1_12';marker='TASK_0024AD_SUBMISSION_CORE_1_12_BATCH_PASS';stderr_policy='RequireEmpty'},
 [ordered]@{name='aggregate';marker='TASK_0003_TESTS_PASS assertions=621 vectors=9';stderr_policy='Allow'},
 [ordered]@{name='complete_v2';marker='TASK_0024V_V2_COMPLETE_PASS';stderr_policy='RequireEmpty'})
$adapter=Join-Path $PSScriptRoot 'task_0024aj_invoke_wrapper_case.ps1'
if(-not(Test-Path -LiteralPath $adapter -PathType Leaf)){Stop-Task0024AJFinal 'AJ_ADAPTER_NOT_FOUND'}
. $adapter -Library
$evidenceParser=Join-Path $PSScriptRoot 'task_0024aj_evidence_capture_parser.ps1'
if(-not(Test-Path -LiteralPath $evidenceParser -PathType Leaf)){Stop-Task0024AJFinal 'EVIDENCE_CAPTURE_PARSER_NOT_FOUND'}
. $evidenceParser -Library
function Get-Task0024AJGodotCount { @((Get-Process -ErrorAction SilentlyContinue | Where-Object { $_.ProcessName -like 'godot*' })).Count }
$consume=[ordered]@{schema_version=1;task_identity='0024AJ';manifest_id=[string]$manifest.manifest_id;manifest_sha256=$manifestHash;consumed_utc=[DateTime]::UtcNow.ToString('o');status='CONSUMED_BEFORE_FIRST_CASE'}
try{$stream=[IO.File]::Open($consumptionPath,[IO.FileMode]::CreateNew,[IO.FileAccess]::Write,[IO.FileShare]::None); try{$bytes=[Text.Encoding]::UTF8.GetBytes(($consume|ConvertTo-Json -Compress));$stream.Write($bytes,0,$bytes.Length)}finally{$stream.Dispose()}}catch{Stop-Task0024AJFinal 'MANIFEST_CONSUMPTION_WRITE_FAILED_OR_ALREADY_CONSUMED'}
$records=@()
try {
for($i=0;$i -lt $expected.Count;$i++){
 $case=$manifest.cases[$i]; $rule=$expected[$i]
 if($case.name -ne $rule.name -or $case.marker -ne $rule.marker -or [string]::IsNullOrWhiteSpace([string]$case.script_path)){Stop-Task0024AJFinal "CASE_CONTRACT_INVALID:$i"}
 $before=Get-Task0024AJGodotCount; if($before -ne 0){Stop-Task0024AJFinal "GODOT_NOT_ZERO_BEFORE:$($rule.name):$before"}
 $values=@(& $adapter -GodotPath $GodotPath -ProjectPath $ProjectPath -ScriptPath $case.script_path -RequiredMarker $rule.marker -StderrPolicy $rule.stderr_policy 2>&1)
 $adapterValues=@($values|Where-Object{$_ -isnot [string] -or -not [string]::IsNullOrWhiteSpace([string]$_)})
 if($adapterValues.Count -ne 1 -or $adapterValues[0] -isnot [string]){Stop-Task0024AJFinal "ADAPTER_OUTPUT_CARDINALITY_INVALID:$($rule.name)"}
 try{$captured=([string]$adapterValues[0])|ConvertFrom-Json -Depth 100 -ErrorAction Stop}catch{Stop-Task0024AJFinal "ADAPTER_OUTPUT_INVALID_JSON:$($rule.name)"}
 if($captured -isnot [pscustomobject] -or $captured.raw_wrapper_json -isnot [string] -or [string]::IsNullOrWhiteSpace([string]$captured.raw_wrapper_json) -or ($captured.raw_utf8_byte_count -isnot [int] -and $captured.raw_utf8_byte_count -isnot [long]) -or [long]$captured.raw_utf8_byte_count -lt 1 -or $captured.raw_utf8_sha256 -isnot [string] -or [string]$captured.raw_utf8_sha256 -notmatch '^[0-9a-f]{64}$' -or $captured.parsed_record -isnot [pscustomobject] -or ($captured.godot_count_before -isnot [int] -and $captured.godot_count_before -isnot [long]) -or ($captured.godot_count_after -isnot [int] -and $captured.godot_count_after -isnot [long])){Stop-Task0024AJFinal "ADAPTER_OUTPUT_REQUIRED_FIELD_INVALID:$($rule.name)"}
 $record=$captured.parsed_record
 $after=Get-Task0024AJGodotCount; if($after -ne 0){Stop-Task0024AJFinal "GODOT_NOT_ZERO_AFTER:$($rule.name):$after"}
 if([int]$captured.godot_count_before -ne 0 -or [int]$captured.godot_count_after -ne 0){Stop-Task0024AJFinal "ADAPTER_GODOT_COUNT_INVALID:$($rule.name)"}
 if($record.status -ne 'PASS' -or $record.underlying_status -ne 'PASS' -or $record.native_exit_code -ne 0 -or -not $record.marker_pass -or $record.cleanup_invocation_count -ne 1 -or $record.remaining_owned_pids.Count -ne 0 -or $record.remaining_unproven_pids.Count -ne 0){Stop-Task0024AJFinal "CASE_FAILED:$($rule.name)"}
 if($rule.stderr_policy -eq 'RequireEmpty' -and $record.stderr.Count -ne 0){Stop-Task0024AJFinal "STDERR_NOT_EMPTY:$($rule.name)"}
 if($rule.name -eq 'aggregate' -and (@($record.stderr) -join "`n") -ne 'LEVEL_ID_MISMATCH'){Stop-Task0024AJFinal 'AGGREGATE_STDERR_MISMATCH'}
 $evidence=$null; if($rule.name -eq 'sensor_contract_dynamic_signature'){$evidence=ConvertFrom-Task0024AJEvidenceLines -Lines @($record.stdout)}
 $records += [ordered]@{name=$rule.name;marker=$rule.marker;godot_count_before=$before;godot_count_after=$after;adapter_godot_count_before=$captured.godot_count_before;adapter_godot_count_after=$captured.godot_count_after;evidence_capture=$evidence;raw_utf8_sha256=$captured.raw_utf8_sha256;raw_utf8_byte_count=$captured.raw_utf8_byte_count;parsed_record=$record}
}
 [ordered]@{schema_version=1;task_identity='0024AJ';status='PASS';manifest_id=$manifest.manifest_id;manifest_sha256=$manifestHash;ad_12_l_n_pairs=$adLNPairs;consumption_path=$consumptionPath;manifest_path=$ManifestPath;cases=$records}|ConvertTo-Json -Depth 100 -Compress
} finally {
 $finalGodotCount=Get-Task0024AJGodotCount
 if($finalGodotCount -ne 0){throw "TASK_0024AJ_FINAL_CYCLE_FAIL:GODOT_NOT_ZERO_FINALLY:$finalGodotCount"}
}
