[CmdletBinding()]
param()
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$AkProbeModule = Join-Path $PSScriptRoot 'task_0024ak_evidence_parser.psm1'
Import-Module -Name $AkProbeModule -Force -Scope Local -ErrorAction Stop
$AkProbeValid = '{"schema_version":2,"status":"PASS","underlying_status":"PASS","native_exit_code":0,"timed_out":false,"marker_pass":true,"stderr_policy":"ForbidNonempty","stderr_pass":true,"cleanup_invocation_count":1,"cleanup_order":["terminate_owned_tree"],"cleanup_closed_pids":[],"remaining_owned_pids":[],"remaining_unproven_pids":[],"owned_records":[],"unproven_records":[],"stdout":["marker"],"stderr":[],"wrapper_error":"","cleanup_error":""}'
function Assert-Task0024AKWrapperRejected {
    param(
        [Parameter(Mandatory)][string]$AkProbeName,
        [Parameter(Mandatory)][AllowEmptyCollection()][object[]]$AkProbeValues,
        [Parameter(Mandatory)][string]$AkProbeExpected,
        [string]$AkProbeRequiredMarker = ''
    )
    $AkProbeMessage = ''
    try {
        [void](ConvertFrom-Task0024AKWrapperValues `
            -AkParserValues $AkProbeValues `
            -AkParserRequiredMarker $AkProbeRequiredMarker)
    }
    catch {
        $AkProbeMessage = $_.Exception.Message
    }
    if (-not $AkProbeMessage.Contains($AkProbeExpected)) {
        throw "TASK_0024AK_WRAPPER_PROBE_FAIL:$AkProbeName`:$AkProbeMessage"
    }
    [ordered]@{ name = $AkProbeName; rejected = $true; reason = $AkProbeExpected }
}
$AkProbeResults = @(
    (Assert-Task0024AKWrapperRejected -AkProbeName 'missing_output' -AkProbeValues @() -AkProbeExpected 'EXPECTED_ONE_NONEMPTY_VALUE'),
    (Assert-Task0024AKWrapperRejected -AkProbeName 'missing_field' -AkProbeValues @($AkProbeValid.Replace(',"cleanup_error":""', '')) -AkProbeExpected 'MISSING_OR_NULL:cleanup_error'),
    (Assert-Task0024AKWrapperRejected -AkProbeName 'duplicate' -AkProbeValues @($AkProbeValid, $AkProbeValid) -AkProbeExpected 'EXPECTED_ONE_NONEMPTY_VALUE'),
    (Assert-Task0024AKWrapperRejected -AkProbeName 'extra_output' -AkProbeValues @($AkProbeValid, 'noise') -AkProbeExpected 'EXPECTED_ONE_NONEMPTY_VALUE'),
    (Assert-Task0024AKWrapperRejected -AkProbeName 'non_json' -AkProbeValues @('x') -AkProbeExpected 'RESULT_NOT_JSON_OBJECT'),
    (Assert-Task0024AKWrapperRejected -AkProbeName 'invalid_json' -AkProbeValues @('{not-json}') -AkProbeExpected 'INVALID_JSON'),
    (Assert-Task0024AKWrapperRejected -AkProbeName 'truncated' -AkProbeValues @('{"schema_version":2') -AkProbeExpected 'RESULT_NOT_JSON_OBJECT'),
    (Assert-Task0024AKWrapperRejected -AkProbeName 'array_root' -AkProbeValues @('[]') -AkProbeExpected 'RESULT_NOT_JSON_OBJECT'),
    (Assert-Task0024AKWrapperRejected -AkProbeName 'null_field' -AkProbeValues @($AkProbeValid.Replace('"native_exit_code":0', '"native_exit_code":null')) -AkProbeExpected 'MISSING_OR_NULL:native_exit_code'),
    (Assert-Task0024AKWrapperRejected -AkProbeName 'wrong_version' -AkProbeValues @($AkProbeValid.Replace('"schema_version":2', '"schema_version":1')) -AkProbeExpected 'SCHEMA_VERSION_NOT_2'),
    (Assert-Task0024AKWrapperRejected -AkProbeName 'wrong_type' -AkProbeValues @($AkProbeValid.Replace('"marker_pass":true', '"marker_pass":"true"')) -AkProbeExpected 'WRONG_TYPE:marker_pass:boolean')
)
$AkProbeAccepted = ConvertFrom-Task0024AKWrapperValues -AkParserValues @($AkProbeValid)
$AkProbeMarkerAccepted = ConvertFrom-Task0024AKWrapperValues `
    -AkParserValues @($AkProbeValid) `
    -AkParserRequiredMarker 'marker'
$AkProbeMarkerZero = $AkProbeValid.Replace('"stdout":["marker"]', '"stdout":["other"]')
$AkProbeMarkerTwiceSameLine = $AkProbeValid.Replace(
    '"stdout":["marker"]',
    '"stdout":["marker then marker"]'
)
$AkProbeMarkerRegexLookalike = $AkProbeValid.Replace(
    '"stdout":["marker"]',
    '"stdout":["axb"]'
)
$AkProbeMarkerResults = @(
    (Assert-Task0024AKWrapperRejected -AkProbeName 'marker_zero_literal_occurrences' -AkProbeValues @($AkProbeMarkerZero) -AkProbeExpected 'REQUIRED_MARKER_OCCURRENCE_COUNT:0' -AkProbeRequiredMarker 'marker'),
    (Assert-Task0024AKWrapperRejected -AkProbeName 'marker_two_literal_occurrences_same_line' -AkProbeValues @($AkProbeMarkerTwiceSameLine) -AkProbeExpected 'REQUIRED_MARKER_OCCURRENCE_COUNT:2' -AkProbeRequiredMarker 'marker'),
    (Assert-Task0024AKWrapperRejected -AkProbeName 'marker_literal_not_regex' -AkProbeValues @($AkProbeMarkerRegexLookalike) -AkProbeExpected 'REQUIRED_MARKER_OCCURRENCE_COUNT:0' -AkProbeRequiredMarker 'a.b')
)
$AkProbeEvidenceKinds = @(
    'multi_subagent_ledger',
    'adapter_parser_qualification',
    'static_preservation',
    'candidate_route_preflight',
    'sensor_public_contract_inventory',
    'sensor_barrier_lifecycle',
    'swapped_identity_wrong_actor_control',
    'lifecycle_signature_registry',
    'crate_lifecycle',
    'key_lock_inventory_lifecycle',
    'latch_lifecycle',
    'fit_layering_v1_regression',
    'summary'
)
$AkProbeEvidenceBase = @($AkProbeEvidenceKinds | ForEach-Object {
    "TASK_0024AJ_EVIDENCE {`"schema_version`":1,`"kind`":`"$_`"}"
})
function Assert-Task0024AKEvidenceRejected {
    param(
        [Parameter(Mandatory)][string]$AkProbeName,
        [Parameter(Mandatory)][AllowEmptyCollection()][string[]]$AkProbeLines,
        [Parameter(Mandatory)][string]$AkProbeExpected
    )
    $AkProbeMessage = ''
    try {
        [void](ConvertFrom-Task0024AKEvidenceLines -AkParserLines $AkProbeLines)
    }
    catch {
        $AkProbeMessage = $_.Exception.Message
    }
    if (-not $AkProbeMessage.Contains($AkProbeExpected)) {
        throw "TASK_0024AK_EVIDENCE_PROBE_FAIL:$AkProbeName`:$AkProbeMessage"
    }
    [ordered]@{ name = $AkProbeName; rejected = $true; reason = $AkProbeExpected }
}
$AkProbeEvidenceResults = @(
    (Assert-Task0024AKEvidenceRejected -AkProbeName 'missing_kind' -AkProbeLines $AkProbeEvidenceBase[0..11] -AkProbeExpected 'EVIDENCE_MISSING_KIND:summary'),
    (Assert-Task0024AKEvidenceRejected -AkProbeName 'duplicate_kind' -AkProbeLines @($AkProbeEvidenceBase + $AkProbeEvidenceBase[0]) -AkProbeExpected 'EVIDENCE_DUPLICATE_KIND'),
    (Assert-Task0024AKEvidenceRejected -AkProbeName 'invalid_json' -AkProbeLines @($AkProbeEvidenceBase[0..11] + 'TASK_0024AJ_EVIDENCE {') -AkProbeExpected 'EVIDENCE_INVALID_JSON'),
    (Assert-Task0024AKEvidenceRejected -AkProbeName 'over_bound' -AkProbeLines @($AkProbeEvidenceBase[0..11] + ('TASK_0024AJ_EVIDENCE {"schema_version":1,"kind":"summary","x":"' + ('a' * 1800) + '"}')) -AkProbeExpected 'EVIDENCE_OVER_BOUND')
)
$AkProbeAcceptedEvidenceFile = Join-Path $PSScriptRoot 'task_0024aj_qualification_repeatable_6.json'
if (-not (Test-Path -LiteralPath $AkProbeAcceptedEvidenceFile -PathType Leaf)) {
    throw 'TASK_0024AK_EVIDENCE_PROBE_FAIL:ACCEPTED_AJ_EVIDENCE_MISSING'
}
$AkProbeAcceptedEvidenceContainer = Get-Content -Raw -LiteralPath $AkProbeAcceptedEvidenceFile |
    ConvertFrom-Json -Depth 100 -ErrorAction Stop
$AkProbeAjPrefixCapture = ConvertFrom-Task0024AKWrapperValues `
    -AkParserValues @([string]$AkProbeAcceptedEvidenceContainer.raw_wrapper_json) `
    -AkParserRequiredMarker 'TASK_0024AJ_SENSOR_CONTRACT_DYNAMIC_SIGNATURE_PASS'
$AkProbeAcceptedEvidenceLines = @($AkProbeAcceptedEvidenceContainer.parsed_record.stdout)
$AkProbeAcceptedEvidence = ConvertFrom-Task0024AKEvidenceLines -AkParserLines $AkProbeAcceptedEvidenceLines
function Edit-Task0024AKEvidenceKind {
    param(
        [Parameter(Mandatory)][string[]]$AkProbeLines,
        [Parameter(Mandatory)][string]$AkProbeKind,
        [Parameter(Mandatory)][scriptblock]$AkProbeEdit
    )
    @($AkProbeLines | ForEach-Object {
        $AkProbeLine = [string]$_
        if (-not $AkProbeLine.StartsWith('TASK_0024AJ_EVIDENCE ')) {
            return $AkProbeLine
        }
        $AkProbeRaw = $AkProbeLine.Substring('TASK_0024AJ_EVIDENCE '.Length)
        $AkProbeRecord = $AkProbeRaw | ConvertFrom-Json -Depth 100 -ErrorAction Stop
        if ($AkProbeRecord.kind -ne $AkProbeKind) {
            return $AkProbeLine
        }
        & $AkProbeEdit $AkProbeRecord
        'TASK_0024AJ_EVIDENCE ' + ($AkProbeRecord | ConvertTo-Json -Depth 100 -Compress)
    })
}
$AkProbeMissingControl = @($AkProbeAcceptedEvidenceLines | Where-Object {
    $_ -notlike 'TASK_0024AJ_EVIDENCE *"kind":"swapped_identity_wrong_actor_control"*'
})
$AkProbeWrongControl = @(Edit-Task0024AKEvidenceKind `
    -AkProbeLines $AkProbeAcceptedEvidenceLines `
    -AkProbeKind 'swapped_identity_wrong_actor_control' `
    -AkProbeEdit { param($AkProbeRecord) $AkProbeRecord.block_player_unchanged = $false })
$AkProbeWrongAction11Cell = @(Edit-Task0024AKEvidenceKind `
    -AkProbeLines $AkProbeAcceptedEvidenceLines `
    -AkProbeKind 'sensor_barrier_lifecycle' `
    -AkProbeEdit {
        param($AkProbeRecord)
        $AkProbeAction11 = @($AkProbeRecord.per_group_actions | Where-Object { [int]$_.action -eq 11 })[0]
        $AkProbeAction11.occupied_cells = , @(5, 1)
    })
$AkProbeWrongAction12Deferred = @(Edit-Task0024AKEvidenceKind `
    -AkProbeLines $AkProbeAcceptedEvidenceLines `
    -AkProbeKind 'sensor_barrier_lifecycle' `
    -AkProbeEdit {
        param($AkProbeRecord)
        $AkProbeAction12 = @($AkProbeRecord.per_group_actions | Where-Object { [int]$_.action -eq 12 })[0]
        $AkProbeAction12.closure_deferred = $false
    })
$AkProbeSemanticEvidenceResults = @(
    (Assert-Task0024AKEvidenceRejected -AkProbeName 'missing_swapped_control' -AkProbeLines $AkProbeMissingControl -AkProbeExpected 'EVIDENCE_MISSING_KIND:swapped_identity_wrong_actor_control'),
    (Assert-Task0024AKEvidenceRejected -AkProbeName 'wrong_swapped_control' -AkProbeLines $AkProbeWrongControl -AkProbeExpected 'EVIDENCE_SWAPPED_IDENTITY_CONTROL_INVALID'),
    (Assert-Task0024AKEvidenceRejected -AkProbeName 'wrong_action11_cell' -AkProbeLines $AkProbeWrongAction11Cell -AkProbeExpected 'EVIDENCE_SENSOR_BARRIER_CELL_DEFERRED_INVALID'),
    (Assert-Task0024AKEvidenceRejected -AkProbeName 'wrong_action12_deferred' -AkProbeLines $AkProbeWrongAction12Deferred -AkProbeExpected 'EVIDENCE_SENSOR_BARRIER_CELL_DEFERRED_INVALID')
)
[ordered]@{
    schema_version = 1
    task_identity = '0024AK'
    status = 'PASS'
    powershell_version = $PSVersionTable.PSVersion.ToString()
    wrapper_probes = $AkProbeResults
    marker_occurrence_probes = $AkProbeMarkerResults
    accepted_marker_occurrence_count = $AkProbeMarkerAccepted.required_marker_occurrence_count
    accepted_aj_prefix_occurrence_count = $AkProbeAjPrefixCapture.required_marker_occurrence_count
    evidence_probes = $AkProbeEvidenceResults
    semantic_evidence_probes = $AkProbeSemanticEvidenceResults
    accepted_evidence_record_count = $AkProbeAcceptedEvidence.record_count
    accepted_raw_sha256 = $AkProbeAccepted.raw_utf8_sha256
    accepted_raw_bytes = $AkProbeAccepted.raw_utf8_byte_count
} | ConvertTo-Json -Depth 10 -Compress
