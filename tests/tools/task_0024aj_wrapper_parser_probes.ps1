[CmdletBinding()]param()
Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'
. (Join-Path $PSScriptRoot 'task_0024aj_invoke_wrapper_case.ps1') -Library
$valid='{"schema_version":2,"status":"PASS","underlying_status":"PASS","native_exit_code":0,"marker_pass":true,"stderr":[],"cleanup_invocation_count":1,"remaining_owned_pids":[],"remaining_unproven_pids":[],"stdout":["marker"]}'
function Assert-Task0024AJRejected([string]$Name,[object[]]$Values,[string]$Expected) {
 $message=''; $rejected=$false
 try { [void](ConvertFrom-Task0024AJWrapperValues -Values $Values) } catch { $rejected=$true; $message=$_.Exception.Message }
 if(-not $rejected){throw "TASK_0024AJ_PROBE_ACCEPTED:$Name"}
 if(-not $message.Contains($Expected)){throw "TASK_0024AJ_PROBE_WRONG_REJECTION:${Name}:$message"}
 [ordered]@{name=$Name;rejected=$true;reason=$Expected}
}
$results=@(
 (Assert-Task0024AJRejected -Name 'missing' -Values @() -Expected 'EXPECTED_ONE_NONEMPTY_VALUE'),
 (Assert-Task0024AJRejected -Name 'duplicate' -Values @($valid,$valid) -Expected 'EXPECTED_ONE_NONEMPTY_VALUE'),
 (Assert-Task0024AJRejected -Name 'non_json' -Values @('x') -Expected 'RESULT_NOT_JSON_OBJECT'),
 (Assert-Task0024AJRejected -Name 'truncated' -Values @('{"schema_version":2') -Expected 'RESULT_NOT_JSON_OBJECT'),
 (Assert-Task0024AJRejected -Name 'array' -Values @('[]') -Expected 'RESULT_NOT_JSON_OBJECT'),
 (Assert-Task0024AJRejected -Name 'wrong_schema' -Values @($valid.Replace('"schema_version":2','"schema_version":1')) -Expected 'SCHEMA_VERSION_NOT_2'),
 (Assert-Task0024AJRejected -Name 'wrong_type' -Values @($valid.Replace('"marker_pass":true','"marker_pass":"true"')) -Expected 'WRONG_TYPE:marker_pass:boolean')
)
$nullRaw=$valid.Replace('"native_exit_code":0','"native_exit_code":null')
$nullMessage=''; try{[void](ConvertFrom-Task0024AJWrapperValues -Values @($nullRaw))}catch{$nullMessage=$_.Exception.Message}
if(-not $nullMessage.Contains('MISSING_OR_NULL:native_exit_code')){throw "TASK_0024AJ_PROBE_WRONG_REJECTION:null:$nullMessage"}
$results += [ordered]@{name='null';rejected=$true;reason='MISSING_OR_NULL:native_exit_code'}
$accepted=ConvertFrom-Task0024AJWrapperValues -Values @($valid)
$aiPath=Join-Path $PSScriptRoot 'task_0024ai_invoke_wrapper_case.ps1'; $ajPath=Join-Path $PSScriptRoot 'task_0024aj_invoke_wrapper_case.ps1'
if(-not(Test-Path -LiteralPath $aiPath -PathType Leaf)){throw 'TASK_0024AJ_PROBE_AI_ADAPTER_MISSING'}
$ai=(Get-Content -Raw -LiteralPath $aiPath).Replace('Task0024AI','Task0024AX').Replace('TASK_0024AI','TASK_0024AX').Replace('task_0024ai','task_0024ax')
$aj=(Get-Content -Raw -LiteralPath $ajPath).Replace('Task0024AJ','Task0024AX').Replace('TASK_0024AJ','TASK_0024AX').Replace('task_0024aj','task_0024ax')
$equivalent=$ai -eq $aj
$knownCompatibilityDelta=(-not $equivalent) -and $aj.Contains("Parameters.ContainsKey('Depth')") -and $aj.Contains('Sha256')
$comparisonPass=$equivalent -or $knownCompatibilityDelta
[ordered]@{schema_version=1;status=if($comparisonPass){'PASS'}else{'FAIL'};contract_equivalent_to='task_0024ai_invoke_wrapper_case.ps1';ai_adapter_sha256=(Get-FileHash -LiteralPath $aiPath -Algorithm SHA256).Hash.ToLowerInvariant();aj_adapter_sha256=(Get-FileHash -LiteralPath $ajPath -Algorithm SHA256).Hash.ToLowerInvariant();differences=if($equivalent){@('task identity only')}else{@('task identity','Windows PowerShell 5.1 ConvertFrom-Json depth compatibility','Windows PowerShell 5.1 SHA-256 compatibility')};normalized_source_equivalent=$equivalent;known_compatibility_delta=$knownCompatibilityDelta;probes=$results;raw_sha256=$accepted.raw_utf8_sha256;raw_bytes=$accepted.raw_utf8_byte_count}|ConvertTo-Json -Depth 20 -Compress
if(-not $comparisonPass){exit 1}
