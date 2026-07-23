[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$AlWorkerGodotExecutable,
    [Parameter(Mandatory)][string]$AlWorkerProjectRoot,
    [Parameter(Mandatory)][ValidateSet('qualification', 'retained')][string]$AlWorkerRunMode,
    [Parameter(Mandatory)][string]$AlWorkerRunId,
    [Parameter(Mandatory)][string]$AlWorkerInvocationId,
    [Parameter(Mandatory)][ValidateRange(1, 5)][int]$AlWorkerOrdinal,
    [Parameter(Mandatory)][string]$AlWorkerCaseName,
    [Parameter(Mandatory)][ValidateSet('wrapper', 'route')][string]$AlWorkerCaseKind,
    [Parameter(Mandatory)][string]$AlWorkerScriptPath,
    [Parameter(Mandatory)][string]$AlWorkerRequiredMarker,
    [Parameter(Mandatory)][ValidateSet('RequireEmpty', 'AggregateMismatch')][string]$AlWorkerStderrPolicy,
    [Parameter(Mandatory)][string]$AlWorkerOutputPath,
    [string]$AlWorkerSyntheticInputPath = '',
    [switch]$AlWorkerSyntheticProbe,
    [switch]$AlWorkerSyntheticProbeOmitCanonical,
    [ValidateRange(1, 3)][int]$AlWorkerModuleImportCount = 1
)
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
function Stop-Task0024ALWorker {
    param([Parameter(Mandatory)][string]$AlWorkerReason)
    throw "TASK_0024AL_CASE_WORKER_FAIL:$AlWorkerReason"
}
function Get-Task0024ALWorkerGodotCount {
    @((Get-Process -ErrorAction SilentlyContinue | Where-Object {
        $_.ProcessName -like 'godot*'
    })).Count
}
function Get-Task0024ALWorkerSha256 {
    param([Parameter(Mandatory)][byte[]]$AlWorkerBytes)
    $AlWorkerAlgorithm = [Security.Cryptography.SHA256]::Create()
    try {
        -join ($AlWorkerAlgorithm.ComputeHash($AlWorkerBytes) | ForEach-Object {
            $_.ToString('x2')
        })
    }
    finally { $AlWorkerAlgorithm.Dispose() }
}
$AlWorkerRoot = [IO.Path]::GetFullPath($AlWorkerProjectRoot)
if ($AlWorkerRoot.TrimEnd('\') -ne 'D:\Delayed_Self') {
    Stop-Task0024ALWorker 'PROJECT_ROOT_INVALID'
}
$AlWorkerExpectedCases = @(
    [ordered]@{ name = 'sensor_contract_dynamic_signature'; kind = 'wrapper'; script = 'res://tests/presentation/task_0024aj_sensor_contract_and_dynamic_signature_validation.gd'; marker = 'TASK_0024AJ_SENSOR_CONTRACT_DYNAMIC_SIGNATURE_PASS'; stderr = 'RequireEmpty' },
    [ordered]@{ name = 'isolated_staging_route'; kind = 'route'; script = 'res://tests/playtest/task_0024ae_submission_core_owner_review_launcher.gd'; marker = 'TASK_0024AE_ISOLATED_STAGING_OWNER_ROUTE_PASS'; stderr = 'RequireEmpty' },
    [ordered]@{ name = 'batch_1_12'; kind = 'wrapper'; script = 'res://tests/curriculum/task_0024ad_submission_core_1_12_batch_validation.gd'; marker = 'TASK_0024AD_SUBMISSION_CORE_1_12_BATCH_PASS'; stderr = 'RequireEmpty' },
    [ordered]@{ name = 'aggregate'; kind = 'wrapper'; script = 'res://tests/run_all.gd'; marker = 'TASK_0003_TESTS_PASS assertions=621 vectors=9'; stderr = 'AggregateMismatch' },
    [ordered]@{ name = 'complete_v2'; kind = 'wrapper'; script = 'res://tests/simulation/task_0024v_v2_solver_replay_canonical_malformed.gd'; marker = 'TASK_0024V_V2_COMPLETE_PASS'; stderr = 'RequireEmpty' }
)
$AlWorkerExpected = $AlWorkerExpectedCases[$AlWorkerOrdinal - 1]
if ($AlWorkerCaseName -ne $AlWorkerExpected.name -or
    $AlWorkerCaseKind -ne $AlWorkerExpected.kind -or
    $AlWorkerScriptPath -ne $AlWorkerExpected.script -or
    $AlWorkerRequiredMarker -ne $AlWorkerExpected.marker -or
    $AlWorkerStderrPolicy -ne $AlWorkerExpected.stderr) {
    Stop-Task0024ALWorker 'CASE_ORDINAL_CONTRACT_INVALID'
}
if ($AlWorkerSyntheticProbe) {
    if ($AlWorkerRunMode -ne 'qualification' -or
        $AlWorkerRunId -notlike 'probe-*' -or
        [string]::IsNullOrWhiteSpace($AlWorkerSyntheticInputPath)) {
        Stop-Task0024ALWorker 'SYNTHETIC_PROBE_AUTHORITY_INVALID'
    }
}
elseif (-not [string]::IsNullOrEmpty($AlWorkerSyntheticInputPath)) {
    Stop-Task0024ALWorker 'SYNTHETIC_INPUT_WITHOUT_PROBE_FLAG'
}
if ($AlWorkerSyntheticProbeOmitCanonical -and -not $AlWorkerSyntheticProbe) {
    Stop-Task0024ALWorker 'OMIT_CANONICAL_WITHOUT_SYNTHETIC_PROBE'
}
$AlWorkerCanonicalOutput = [IO.Path]::GetFullPath($AlWorkerOutputPath)
if ([IO.Path]::GetDirectoryName($AlWorkerCanonicalOutput) -ne [IO.Path]::GetFullPath($PSScriptRoot) -or
    [IO.Path]::GetFileName($AlWorkerCanonicalOutput) -notmatch
        '^task_0024al_.+_case_0[1-5]_[a-z0-9_]+\.json$') {
    Stop-Task0024ALWorker 'OUTPUT_PATH_NOT_CANONICAL'
}
if (Test-Path -LiteralPath $AlWorkerCanonicalOutput) {
    Stop-Task0024ALWorker 'OUTPUT_ALREADY_EXISTS'
}
$AlWorkerExpectedOrdinalToken = '_case_{0:d2}_' -f $AlWorkerOrdinal
if (-not [IO.Path]::GetFileName($AlWorkerCanonicalOutput).Contains(
    $AlWorkerExpectedOrdinalToken, [StringComparison]::Ordinal
)) {
    Stop-Task0024ALWorker 'OUTPUT_ORDINAL_MISMATCH'
}
$AlWorkerModulePath = Join-Path $PSScriptRoot 'task_0024al_worker_parser.psm1'
for ($AlWorkerImportIndex = 0; $AlWorkerImportIndex -lt $AlWorkerModuleImportCount; $AlWorkerImportIndex++) {
    $AlWorkerModules = @(Import-Module -Name $AlWorkerModulePath -Force -Scope Local -PassThru)
    if ($AlWorkerModules.Count -ne 1 -or $AlWorkerModules[0].ExportedVariables.Count -ne 0) {
        Stop-Task0024ALWorker 'MODULE_IMPORT_CONTRACT_FAILED'
    }
}
$AlWorkerGodotBefore = Get-Task0024ALWorkerGodotCount
if ($AlWorkerGodotBefore -ne 0) {
    Stop-Task0024ALWorker "GODOT_NOT_ZERO_BEFORE:$AlWorkerGodotBefore"
}
$AlWorkerCapture = $null
$AlWorkerAjEvidence = $null
$AlWorkerRouteFacts = $null
if ($AlWorkerSyntheticProbe) {
    if (-not (Test-Path -LiteralPath $AlWorkerSyntheticInputPath -PathType Leaf)) {
        Stop-Task0024ALWorker 'SYNTHETIC_INPUT_MISSING'
    }
    $AlWorkerSyntheticRaw = [IO.File]::ReadAllText($AlWorkerSyntheticInputPath)
    $AlWorkerCapture = ConvertFrom-Task0024ALWrapperValues `
        -AlParserValues @($AlWorkerSyntheticRaw) `
        -AlParserRequiredMarker $AlWorkerRequiredMarker `
        -AlParserStderrPolicy $AlWorkerStderrPolicy
}
elseif ($AlWorkerCaseKind -eq 'wrapper') {
    $AlWorkerWrapper = Join-Path $PSScriptRoot 'run_owned_godot_headless.ps1'
    $AlWorkerWrapperPolicy = if ($AlWorkerStderrPolicy -eq 'RequireEmpty') {
        'ForbidNonempty'
    } else { 'Allow' }
    $AlWorkerInvocation = @{
        GodotPath = $AlWorkerGodotExecutable
        ProjectPath = $AlWorkerRoot
        ScriptPath = $AlWorkerScriptPath
        RequiredMarker = $AlWorkerRequiredMarker
        StderrPolicy = $AlWorkerWrapperPolicy
        TimeoutSeconds = 240
        GraceSeconds = 3
    }
    $AlWorkerValues = @(& {
        param(
            [Parameter(Mandatory)][string]$AlChildWrapper,
            [Parameter(Mandatory)][hashtable]$AlChildInvocation
        )
        Set-StrictMode -Off
        & $AlChildWrapper @AlChildInvocation
    } $AlWorkerWrapper $AlWorkerInvocation 2>&1)
    $AlWorkerCapture = ConvertFrom-Task0024ALWrapperValues `
        -AlParserValues $AlWorkerValues `
        -AlParserRequiredMarker $AlWorkerRequiredMarker `
        -AlParserStderrPolicy $AlWorkerStderrPolicy
}
else {
    $AlWorkerRouteRunner = Join-Path $PSScriptRoot 'task_0024ae_owner_review_route_runner.ps1'
    $AlWorkerRouteTemp = "$AlWorkerCanonicalOutput.route_runner.$([guid]::NewGuid().ToString('N')).json"
    $AlWorkerRouteRelative = [IO.Path]::GetRelativePath($AlWorkerRoot, $AlWorkerRouteTemp)
    try {
        $AlWorkerRouteValues = @(& $AlWorkerRouteRunner -OutputPath $AlWorkerRouteRelative 2>&1)
        if ($LASTEXITCODE -ne 0 -or @($AlWorkerRouteValues).Count -ne 1 -or
            [string]$AlWorkerRouteValues[0] -notlike 'TASK_0024AE_ROUTE_RECORD_WRITTEN *') {
            Stop-Task0024ALWorker 'ROUTE_RUNNER_FAILED'
        }
        if (-not (Test-Path -LiteralPath $AlWorkerRouteTemp -PathType Leaf)) {
            Stop-Task0024ALWorker 'ROUTE_RECORD_MISSING'
        }
        $AlWorkerRouteRaw = [IO.File]::ReadAllText($AlWorkerRouteTemp)
        $AlWorkerCapture = ConvertFrom-Task0024ALRouteRecord `
            -AlParserRaw $AlWorkerRouteRaw `
            -AlParserRequiredMarker $AlWorkerRequiredMarker `
            -AlParserExpectedScript $AlWorkerScriptPath
        $AlWorkerRouteFacts = $AlWorkerCapture.route_facts
    }
    finally {
        if (Test-Path -LiteralPath $AlWorkerRouteTemp) {
            Remove-Item -LiteralPath $AlWorkerRouteTemp -Force
        }
    }
}
$AlWorkerGodotAfter = Get-Task0024ALWorkerGodotCount
if ($AlWorkerGodotAfter -ne 0) {
    Stop-Task0024ALWorker "GODOT_NOT_ZERO_AFTER:$AlWorkerGodotAfter"
}
if ($AlWorkerCaseName -eq 'sensor_contract_dynamic_signature') {
    $AlWorkerAjEvidence = ConvertFrom-Task0024ALEvidenceLines `
        -AlParserLines @($AlWorkerCapture.parsed_record.stdout)
}
if ($AlWorkerSyntheticProbeOmitCanonical) {
    $AlWorkerSyntheticAck = [ordered]@{
        schema_version = 1
        task_identity = '0024AL'
        status = 'PASS'
        invocation_id = $AlWorkerInvocationId
        ordinal = $AlWorkerOrdinal
        case_name = $AlWorkerCaseName
        output_path = $AlWorkerCanonicalOutput
        canonical_case_record_sha256 = ('0' * 64)
        synthetic_probe_omitted_canonical = $true
    } | ConvertTo-Json -Compress
    [Console]::Out.WriteLine($AlWorkerSyntheticAck)
    [Console]::Out.Flush()
    exit 0
}
$AlWorkerZeroHash = '0' * 64
$AlWorkerRecord = [ordered]@{
    schema_version = 1
    task_identity = '0024AL'
    run_mode = $AlWorkerRunMode
    manifest_id = if ($AlWorkerRunMode -eq 'retained') { $AlWorkerRunId } else { $null }
    qualification_run_id = if ($AlWorkerRunMode -eq 'qualification') { $AlWorkerRunId } else { $null }
    invocation_id = $AlWorkerInvocationId
    ordinal = $AlWorkerOrdinal
    case_name = $AlWorkerCaseName
    case_kind = $AlWorkerCaseKind
    script_path = $AlWorkerScriptPath
    required_marker = $AlWorkerRequiredMarker
    required_marker_occurrence_count = [long]$AlWorkerCapture.required_marker_occurrence_count
    stderr_policy = $AlWorkerStderrPolicy
    raw_wrapper_or_runner_json = $AlWorkerCapture.raw_json
    raw_wrapper_or_runner_sha256 = $AlWorkerCapture.raw_sha256
    raw_utf8_byte_count = [long]$AlWorkerCapture.raw_utf8_byte_count
    parsed_status = [string]$AlWorkerCapture.parsed_record.status
    underlying_status = [string]$AlWorkerCapture.parsed_record.underlying_status
    native_exit_code = [int]$AlWorkerCapture.parsed_record.native_exit_code
    marker_pass = [bool]$AlWorkerCapture.parsed_record.marker_pass
    stderr = @($AlWorkerCapture.parsed_record.stderr)
    cleanup_invocation_count = [int]$AlWorkerCapture.parsed_record.cleanup_invocation_count
    cleanup_order = @($AlWorkerCapture.parsed_record.cleanup_order)
    remaining_owned_pids = @($AlWorkerCapture.parsed_record.remaining_owned_pids)
    remaining_unproven_pids = @($AlWorkerCapture.parsed_record.remaining_unproven_pids)
    worker_godot_count_before = $AlWorkerGodotBefore
    worker_godot_count_after = $AlWorkerGodotAfter
    source_parsed_record = $AlWorkerCapture.parsed_record
    aj_evidence = $AlWorkerAjEvidence
    route_facts = $AlWorkerRouteFacts
    created_utc = [DateTime]::UtcNow.ToString('o')
    canonical_case_record_sha256 = $AlWorkerZeroHash
}
$AlWorkerHashBasisJson = $AlWorkerRecord | ConvertTo-Json -Depth 100 -Compress
$AlWorkerHash = Get-Task0024ALWorkerSha256 `
    -AlWorkerBytes ([Text.Encoding]::UTF8.GetBytes($AlWorkerHashBasisJson))
$AlWorkerRecord.canonical_case_record_sha256 = $AlWorkerHash
$AlWorkerFinalJson = $AlWorkerRecord | ConvertTo-Json -Depth 100 -Compress
$AlWorkerTempPath = "$AlWorkerCanonicalOutput.tmp.$([guid]::NewGuid().ToString('N'))"
try {
    $AlWorkerFinalBytes = [Text.UTF8Encoding]::new($false).GetBytes($AlWorkerFinalJson)
    $AlWorkerStream = [IO.File]::Open(
        $AlWorkerTempPath, [IO.FileMode]::CreateNew, [IO.FileAccess]::Write, [IO.FileShare]::None
    )
    try {
        $AlWorkerStream.Write($AlWorkerFinalBytes, 0, $AlWorkerFinalBytes.Length)
        $AlWorkerStream.Flush($true)
    }
    finally { $AlWorkerStream.Dispose() }
    [IO.File]::Move($AlWorkerTempPath, $AlWorkerCanonicalOutput, $false)
}
finally {
    if (Test-Path -LiteralPath $AlWorkerTempPath) {
        Remove-Item -LiteralPath $AlWorkerTempPath -Force
    }
}
$AlWorkerPersistedRaw = [IO.File]::ReadAllText($AlWorkerCanonicalOutput)
try {
    try {
        $AlWorkerPersisted = $AlWorkerPersistedRaw | ConvertFrom-Json -Depth 100 -ErrorAction Stop
    }
    catch { Stop-Task0024ALWorker 'PERSISTED_RECORD_INVALID_JSON' }
    if ($AlWorkerPersisted.task_identity -ne '0024AL' -or
        $AlWorkerPersisted.canonical_case_record_sha256 -ne $AlWorkerHash) {
        Stop-Task0024ALWorker 'PERSISTED_RECORD_REVALIDATION_FAILED'
    }
}
catch {
    if (Test-Path -LiteralPath $AlWorkerCanonicalOutput) {
        Remove-Item -LiteralPath $AlWorkerCanonicalOutput -Force
    }
    throw
}
[ordered]@{
    schema_version = 1
    task_identity = '0024AL'
    status = 'PASS'
    invocation_id = $AlWorkerInvocationId
    ordinal = $AlWorkerOrdinal
    case_name = $AlWorkerCaseName
    output_path = $AlWorkerCanonicalOutput
    canonical_case_record_sha256 = $AlWorkerHash
} | ConvertTo-Json -Compress
