[CmdletBinding()]
param()
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$AlProbeModule = Join-Path $PSScriptRoot 'task_0024al_worker_parser.psm1'
$AlProbeLoaded = @(Import-Module -Name $AlProbeModule -Force -Scope Local -PassThru)
if ($AlProbeLoaded.Count -ne 1 -or $AlProbeLoaded[0].ExportedVariables.Count -ne 0) {
    throw 'TASK_0024AL_PROBE_FAIL:MODULE_CONTRACT'
}
$AlProbeMarker = 'TASK_MARKER'
$AlProbeValid = '{"schema_version":2,"status":"PASS","underlying_status":"PASS","native_exit_code":0,"timed_out":false,"marker_pass":true,"stderr_pass":true,"cleanup_invocation_count":1,"cleanup_order":[1],"remaining_owned_pids":[],"remaining_unproven_pids":[],"stdout":["TASK_MARKER"],"stderr":[],"wrapper_error":"","cleanup_error":""}'
function Assert-Task0024ALWrapperRejected {
    param(
        [string]$AlProbeName, [object[]]$AlProbeValues, [string]$AlProbeExpected,
        [string]$AlProbeRequiredMarker = $AlProbeMarker,
        [string]$AlProbeStderrPolicy = 'RequireEmpty'
    )
    $AlProbeMessage = ''
    try {
        [void](ConvertFrom-Task0024ALWrapperValues `
            -AlParserValues $AlProbeValues `
            -AlParserRequiredMarker $AlProbeRequiredMarker `
            -AlParserStderrPolicy $AlProbeStderrPolicy)
    }
    catch { $AlProbeMessage = $_.Exception.Message }
    if (-not $AlProbeMessage.Contains($AlProbeExpected)) {
        throw "TASK_0024AL_PROBE_FAIL:$AlProbeName`:$AlProbeMessage"
    }
    [ordered]@{ name = $AlProbeName; rejected = $true; reason = $AlProbeExpected }
}
$AlProbeWrapperResults = @(
    (Assert-Task0024ALWrapperRejected 'missing' @() 'EXPECTED_ONE_NONEMPTY_VALUE'),
    (Assert-Task0024ALWrapperRejected 'duplicate' @($AlProbeValid, $AlProbeValid) 'EXPECTED_ONE_NONEMPTY_VALUE'),
    (Assert-Task0024ALWrapperRejected 'extra' @($AlProbeValid, 'noise') 'EXPECTED_ONE_NONEMPTY_VALUE'),
    (Assert-Task0024ALWrapperRejected 'non_string' @([pscustomobject]@{}) 'RESULT_NOT_STRING'),
    (Assert-Task0024ALWrapperRejected 'invalid' @('{x}') 'INVALID_JSON'),
    (Assert-Task0024ALWrapperRejected 'truncated' @('{"schema_version":2') 'RESULT_NOT_COMPACT_OBJECT'),
    (Assert-Task0024ALWrapperRejected 'array_root' @('[]') 'RESULT_NOT_COMPACT_OBJECT'),
    (Assert-Task0024ALWrapperRejected 'null_cleanup' @($AlProbeValid.Replace('"cleanup_order":[1]', '"cleanup_order":null')) 'MISSING_OR_NULL:cleanup_order'),
    (Assert-Task0024ALWrapperRejected 'null_pid' @($AlProbeValid.Replace('"remaining_owned_pids":[]', '"remaining_owned_pids":null')) 'MISSING_OR_NULL:remaining_owned_pids'),
    (Assert-Task0024ALWrapperRejected 'wrong_version' @($AlProbeValid.Replace('"schema_version":2', '"schema_version":1')) 'WRAPPER_PASS_CONTRACT_FAILED'),
    (Assert-Task0024ALWrapperRejected 'wrong_type' @($AlProbeValid.Replace('"marker_pass":true', '"marker_pass":"true"')) 'WRONG_TYPE:marker_pass:boolean'),
    (Assert-Task0024ALWrapperRejected 'marker_zero' @($AlProbeValid.Replace('TASK_MARKER', 'OTHER')) 'REQUIRED_MARKER'),
    (Assert-Task0024ALWrapperRejected 'marker_twice' @($AlProbeValid.Replace('TASK_MARKER', 'TASK_MARKER TASK_MARKER')) 'REQUIRED_MARKER'),
    (Assert-Task0024ALWrapperRejected 'marker_regex_lookalike' @($AlProbeValid.Replace('TASK_MARKER', 'axb')) 'REQUIRED_MARKER' 'a.b'),
    (Assert-Task0024ALWrapperRejected 'nonempty_stderr' @($AlProbeValid.Replace('"stderr":[]', '"stderr":["x"]')) 'STDERR_NOT_EMPTY'),
    (Assert-Task0024ALWrapperRejected 'aggregate_wrong_stderr' @($AlProbeValid.Replace('"stderr":[]', '"stderr":["x"]')) 'AGGREGATE_STDERR_MISMATCH' $AlProbeMarker 'AggregateMismatch')
)
$AlProbeAccepted = ConvertFrom-Task0024ALWrapperValues `
    -AlParserValues @($AlProbeValid) -AlParserRequiredMarker $AlProbeMarker `
    -AlParserStderrPolicy 'RequireEmpty'
$AlProbeAjFile = Join-Path $PSScriptRoot 'task_0024ak_qualification_repeatable_2.json'
if (-not (Test-Path -LiteralPath $AlProbeAjFile)) {
    $AlProbeAjFile = Join-Path $PSScriptRoot 'task_0024aj_qualification_repeatable_6.json'
}
$AlProbeAj = Get-Content -Raw -LiteralPath $AlProbeAjFile | ConvertFrom-Json -Depth 100
$AlProbeAjWrapperRecord = if ($null -ne $AlProbeAj.PSObject.Properties['capture']) {
    $AlProbeAj.capture.parsed_record
} else {
    $AlProbeAj.parsed_record
}
$AlProbeEvidence = ConvertFrom-Task0024ALEvidenceLines -AlParserLines @($AlProbeAjWrapperRecord.stdout)
$AlProbeMissingEvidence = @($AlProbeAjWrapperRecord.stdout | Where-Object {
    $_ -notlike 'TASK_0024AJ_EVIDENCE *"kind":"summary"*'
})
$AlProbeEvidenceMessage = ''
try { [void](ConvertFrom-Task0024ALEvidenceLines -AlParserLines $AlProbeMissingEvidence) }
catch { $AlProbeEvidenceMessage = $_.Exception.Message }
if (-not $AlProbeEvidenceMessage.Contains('EVIDENCE_MISSING:summary')) {
    throw "TASK_0024AL_PROBE_FAIL:EVIDENCE_MISSING:$AlProbeEvidenceMessage"
}
function Assert-Task0024ALEvidenceRejected {
    param([string]$AlProbeName, [string[]]$AlProbeLines, [string]$AlProbeExpected)
    $AlProbeMessage = ''
    try { [void](ConvertFrom-Task0024ALEvidenceLines -AlParserLines $AlProbeLines) }
    catch { $AlProbeMessage = $_.Exception.Message }
    if (-not $AlProbeMessage.Contains($AlProbeExpected)) {
        throw "TASK_0024AL_PROBE_FAIL:$AlProbeName`:$AlProbeMessage"
    }
    [ordered]@{ name = $AlProbeName; rejected = $true; reason = $AlProbeExpected }
}
$AlProbeEvidencePrefixLines = @($AlProbeAjWrapperRecord.stdout | Where-Object {
    $_ -like 'TASK_0024AJ_EVIDENCE *'
})
$AlProbeEvidenceResults = @(
    [ordered]@{ name = 'missing'; rejected = $true; reason = 'EVIDENCE_MISSING:summary' },
    (Assert-Task0024ALEvidenceRejected 'duplicate' @(
        $AlProbeAjWrapperRecord.stdout + $AlProbeEvidencePrefixLines[0]
    ) 'EVIDENCE_DUPLICATE'),
    (Assert-Task0024ALEvidenceRejected 'invalid' @(
        $AlProbeAjWrapperRecord.stdout + 'TASK_0024AJ_EVIDENCE {'
    ) 'EVIDENCE_INVALID_JSON'),
    (Assert-Task0024ALEvidenceRejected 'over_bound' @(
        $AlProbeMissingEvidence + (
            'TASK_0024AJ_EVIDENCE {"schema_version":1,"kind":"summary","x":"' +
            ('a' * 1800) + '"}'
        )
    ) 'EVIDENCE_OVER_BOUND')
)
$AlProbeRouteMessage = ''
try {
    [void](ConvertFrom-Task0024ALRouteRecord `
        -AlParserRaw '{}' -AlParserRequiredMarker 'x' -AlParserExpectedScript 'res://x')
}
catch { $AlProbeRouteMessage = $_.Exception.Message }
if (-not $AlProbeRouteMessage.Contains('MISSING_OR_NULL')) {
    throw "TASK_0024AL_PROBE_FAIL:ROUTE_MALFORMED:$AlProbeRouteMessage"
}
$AlProbeWorkerPath = Join-Path $PSScriptRoot 'task_0024al_case_worker.ps1'
$AlProbeWorkerTokens = $null
$AlProbeWorkerErrors = $null
$AlProbeWorkerAst = [Management.Automation.Language.Parser]::ParseFile(
    $AlProbeWorkerPath, [ref]$AlProbeWorkerTokens, [ref]$AlProbeWorkerErrors
)
if ($AlProbeWorkerErrors.Count -ne 0) {
    throw 'TASK_0024AL_PROBE_FAIL:WORKER_PARSE'
}
$AlProbeStrictCommands = @($AlProbeWorkerAst.FindAll({
    param($AlProbeNode)
    $AlProbeNode -is [Management.Automation.Language.CommandAst] -and
        $AlProbeNode.GetCommandName() -eq 'Set-StrictMode'
}, $true))
$AlProbeStrictLatest = @($AlProbeStrictCommands | Where-Object {
    $_.Extent.Text -eq 'Set-StrictMode -Version Latest'
})
$AlProbeStrictOff = @($AlProbeStrictCommands | Where-Object {
    $_.Extent.Text -eq 'Set-StrictMode -Off'
})
if ($AlProbeStrictLatest.Count -ne 1 -or $AlProbeStrictOff.Count -ne 1) {
    throw 'TASK_0024AL_PROBE_FAIL:WORKER_STRICT_BOUNDARY_CARDINALITY'
}
$AlProbeOffAncestor = $AlProbeStrictOff[0].Parent
while ($null -ne $AlProbeOffAncestor -and
    $AlProbeOffAncestor -isnot [Management.Automation.Language.ScriptBlockExpressionAst]) {
    $AlProbeOffAncestor = $AlProbeOffAncestor.Parent
}
if ($null -eq $AlProbeOffAncestor) {
    throw 'TASK_0024AL_PROBE_FAIL:STRICT_OFF_NOT_CHILD_SCRIPTBLOCK'
}
$AlProbeChildWrapperCalls = @($AlProbeOffAncestor.FindAll({
    param($AlProbeNode)
    $AlProbeNode -is [Management.Automation.Language.CommandAst] -and
        $AlProbeNode.InvocationOperator -eq
            [Management.Automation.Language.TokenKind]::Ampersand -and
        $AlProbeNode.Extent.Text -match '^\s*&\s+\$AlChildWrapper\s+@AlChildInvocation\s*$'
}, $true))
if ($AlProbeChildWrapperCalls.Count -ne 1) {
    throw 'TASK_0024AL_PROBE_FAIL:CHILD_WRAPPER_CALL_INVALID'
}
$AlProbeWorkerSource = [IO.File]::ReadAllText($AlProbeWorkerPath)
if ($AlProbeWorkerSource -notmatch
    '(?s)}\s+\$AlWorkerWrapper\s+\$AlWorkerInvocation\s+2>&1\)' -or
    $AlProbeWorkerSource -notmatch
    '(?s)\$AlWorkerRouteValues\s*=\s*@\(&\s+\$AlWorkerRouteRunner.+?2>&1\)') {
    throw 'TASK_0024AL_PROBE_FAIL:CAPTURE_OR_ROUTE_PROCESS_STRUCTURE'
}
$AlProbeCallerSentinel = 'caller-byte-stable'
$AlProbeChildScalarCount = @(& {
    param([Parameter(Mandatory)][int]$AlProbeChildScalar)
    Set-StrictMode -Off
    $AlProbeChildScalar.Count
} 7 2>&1)
if ($AlProbeChildScalarCount.Count -ne 1 -or
    [int]$AlProbeChildScalarCount[0] -ne 1 -or
    $AlProbeCallerSentinel -ne 'caller-byte-stable') {
    throw 'TASK_0024AL_PROBE_FAIL:CHILD_SCOPE_OR_SENTINEL'
}
$AlProbeCallerStrictPreserved = $false
try {
    [void]([pscustomobject]@{}).missing_property
}
catch {
    $AlProbeCallerStrictPreserved = $true
}
if (-not $AlProbeCallerStrictPreserved) {
    throw 'TASK_0024AL_PROBE_FAIL:CALLER_STRICTMODE_NOT_PRESERVED'
}
[ordered]@{
    schema_version = 1; task_identity = '0024AL'; status = 'PASS'
    powershell_version = $PSVersionTable.PSVersion.ToString()
    wrapper_negative_count = $AlProbeWrapperResults.Count
    wrapper_negatives = $AlProbeWrapperResults
    accepted_marker_count = $AlProbeAccepted.required_marker_occurrence_count
    accepted_evidence_count = $AlProbeEvidence.record_count
    evidence_negative_count = $AlProbeEvidenceResults.Count
    evidence_negatives = $AlProbeEvidenceResults
    malformed_route_rejected = $true
    worker_strict_latest = $true
    accepted_wrapper_child_scope_strict_off = $true
    accepted_wrapper_complete_stream_capture = $true
    route_runner_process_structure_preserved = $true
    caller_sentinel_preserved = $true
    caller_strictmode_preserved = $true
    exported_functions = @($AlProbeLoaded[0].ExportedFunctions.Keys | Sort-Object)
    exported_variable_count = $AlProbeLoaded[0].ExportedVariables.Count
} | ConvertTo-Json -Depth 20 -Compress
