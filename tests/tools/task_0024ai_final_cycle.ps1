[CmdletBinding()]param([Parameter(Mandatory)][string]$GodotPath,[Parameter(Mandatory)][string]$ProjectPath,[Parameter(Mandatory)][string]$ManifestPath)
Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'
function Stop-Task0024AIFinal([string]$Reason) { throw "TASK_0024AI_FINAL_CYCLE_FAIL:$Reason" }
if(-not(Test-Path -LiteralPath $ManifestPath -PathType Leaf)){Stop-Task0024AIFinal 'MANIFEST_NOT_FOUND'}
try{$manifest=Get-Content -Raw -LiteralPath $ManifestPath|ConvertFrom-Json -Depth 100 -ErrorAction Stop}catch{Stop-Task0024AIFinal 'MANIFEST_INVALID_JSON'}
if($manifest.schema_version -ne 1 -or $manifest.task_identity -ne '0024AI' -or $manifest.status -ne 'DECLARED'){Stop-Task0024AIFinal 'MANIFEST_NOT_DECLARED'}
if($null -eq $manifest.cases -or $manifest.cases -isnot [array] -or $manifest.cases.Count -ne 5){Stop-Task0024AIFinal 'MANIFEST_CASES_INVALID'}
$expected=@(
 [ordered]@{name='candidate_route_dynamic_signature';marker='TASK_0024AI_CANDIDATE_ROUTE_DYNAMIC_SIGNATURE_PASS';stderr_policy='RequireEmpty'},
 [ordered]@{name='isolated_staging_route';marker='TASK_0024AE_ISOLATED_STAGING_OWNER_ROUTE_PASS';stderr_policy='RequireEmpty'},
 [ordered]@{name='batch_1_12';marker='TASK_0024AD_SUBMISSION_CORE_1_12_BATCH_PASS';stderr_policy='RequireEmpty'},
 [ordered]@{name='aggregate';marker='TASK_0003_TESTS_PASS assertions=621 vectors=9';stderr_policy='Allow'},
 [ordered]@{name='complete_v2';marker='TASK_0024V_V2_COMPLETE_PASS';stderr_policy='RequireEmpty'})
. (Join-Path $PSScriptRoot 'task_0024ai_invoke_wrapper_case.ps1') -Library
$records=@()
for($i=0;$i -lt $expected.Count;$i++){
 $case=$manifest.cases[$i]; $rule=$expected[$i]
 if($case.name -ne $rule.name -or $case.marker -ne $rule.marker -or [string]::IsNullOrWhiteSpace([string]$case.script_path)){Stop-Task0024AIFinal "CASE_CONTRACT_INVALID:$i"}
 $values=@(& (Join-Path $PSScriptRoot 'run_owned_godot_headless.ps1') -GodotPath $GodotPath -ProjectPath $ProjectPath -ScriptPath $case.script_path -RequiredMarker $rule.marker -StderrPolicy $(if($rule.stderr_policy -eq 'RequireEmpty'){'ForbidNonempty'}else{'Allow'}) 2>&1)
 $captured=ConvertFrom-Task0024AIWrapperValues -Values $values; $record=$captured.parsed_record
 if($record.status -ne 'PASS' -or $record.underlying_status -ne 'PASS' -or $record.native_exit_code -ne 0 -or -not $record.marker_pass -or $record.remaining_owned_pids.Count -ne 0 -or $record.remaining_unproven_pids.Count -ne 0){Stop-Task0024AIFinal "CASE_FAILED:$($rule.name)"}
 if($rule.stderr_policy -eq 'RequireEmpty' -and $record.stderr.Count -ne 0){Stop-Task0024AIFinal "STDERR_NOT_EMPTY:$($rule.name)"}
 if($rule.name -eq 'aggregate' -and (@($record.stderr) -join "`n") -ne 'LEVEL_ID_MISMATCH'){Stop-Task0024AIFinal 'AGGREGATE_STDERR_MISMATCH'}
 $records += [ordered]@{name=$rule.name;marker=$rule.marker;raw_utf8_sha256=$captured.raw_utf8_sha256;raw_utf8_byte_count=$captured.raw_utf8_byte_count;parsed_record=$record}
}
[ordered]@{schema_version=1;task_identity='0024AI';status='PASS';manifest_path=$ManifestPath;cases=$records}|ConvertTo-Json -Depth 100 -Compress
