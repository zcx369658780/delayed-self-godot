[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$AkDriverGodotExecutable,
    [Parameter(Mandatory)][string]$AkDriverProjectRoot,
    [Parameter(Mandatory)][string]$AkDriverManifestPath
)
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
function Stop-Task0024AKFinalCycle {
    param([Parameter(Mandatory)][string]$AkDriverReason)
    throw "TASK_0024AK_FINAL_CYCLE_FAIL:$AkDriverReason"
}
function Get-Task0024AKDriverGodotCount {
    @((Get-Process -ErrorAction SilentlyContinue | Where-Object { $_.ProcessName -like 'godot*' })).Count
}
$AkDriverStartupGodotExecutable = [string]$AkDriverGodotExecutable
$AkDriverStartupProjectRoot = [string]$AkDriverProjectRoot
$AkDriverStartupManifestFile = [string]$AkDriverManifestPath
$AkDriverImmutableGodotExecutable = [string]$AkDriverStartupGodotExecutable
$AkDriverImmutableProjectRoot = [string]$AkDriverStartupProjectRoot
$AkDriverImmutableManifestFile = [string]$AkDriverStartupManifestFile
function Assert-Task0024AKDriverBindings {
    param([Parameter(Mandatory)][string]$AkDriverCheckpoint)
    $AkDriverBindings = @(
        [ordered]@{ name = 'AkDriverGodotExecutable'; live = $AkDriverGodotExecutable; startup = $AkDriverStartupGodotExecutable; immutable = $AkDriverImmutableGodotExecutable },
        [ordered]@{ name = 'AkDriverProjectRoot'; live = $AkDriverProjectRoot; startup = $AkDriverStartupProjectRoot; immutable = $AkDriverImmutableProjectRoot },
        [ordered]@{ name = 'AkDriverManifestPath'; live = $AkDriverManifestPath; startup = $AkDriverStartupManifestFile; immutable = $AkDriverImmutableManifestFile }
    )
    foreach ($AkDriverBinding in $AkDriverBindings) {
        if ([string]::IsNullOrWhiteSpace([string]$AkDriverBinding.live) -or
            -not [string]::Equals([string]$AkDriverBinding.live, [string]$AkDriverBinding.startup, [StringComparison]::Ordinal) -or
            -not [string]::Equals([string]$AkDriverBinding.live, [string]$AkDriverBinding.immutable, [StringComparison]::Ordinal)) {
            Stop-Task0024AKFinalCycle "DRIVER_BINDING_CHANGED:$AkDriverCheckpoint`:$($AkDriverBinding.name)"
        }
    }
}
Assert-Task0024AKDriverBindings -AkDriverCheckpoint 'STARTUP'
$AkDriverParserModule = Join-Path $PSScriptRoot 'task_0024ak_evidence_parser.psm1'
$AkDriverAdapterTool = Join-Path $PSScriptRoot 'task_0024ak_wrapper_capture.ps1'
$AkDriverPreflightTool = Join-Path $PSScriptRoot 'task_0024ak_driver_preflight.ps1'
foreach ($AkDriverTool in @($AkDriverParserModule, $AkDriverAdapterTool, $AkDriverPreflightTool)) {
    if (-not (Test-Path -LiteralPath $AkDriverTool -PathType Leaf)) {
        Stop-Task0024AKFinalCycle "TOOL_NOT_FOUND:$AkDriverTool"
    }
}
$AkDriverLoadedModules = @(Import-Module -Name $AkDriverParserModule -Force -Scope Local -PassThru -ErrorAction Stop)
if ($AkDriverLoadedModules.Count -ne 1) {
    Stop-Task0024AKFinalCycle "MODULE_IMPORT_CARDINALITY_INVALID:$($AkDriverLoadedModules.Count)"
}
$AkDriverLoadedModule = $AkDriverLoadedModules[0]
$AkDriverExpectedExports = @(
    'ConvertFrom-Task0024AKEvidenceLines',
    'ConvertFrom-Task0024AKWrapperValues'
)
$AkDriverActualExports = @($AkDriverLoadedModule.ExportedFunctions.Keys | Sort-Object)
if (@(Compare-Object $AkDriverExpectedExports $AkDriverActualExports).Count -ne 0 -or
    $AkDriverLoadedModule.ExportedVariables.Count -ne 0) {
    Stop-Task0024AKFinalCycle 'MODULE_EXPORT_CONTRACT_INVALID'
}
Assert-Task0024AKDriverBindings -AkDriverCheckpoint 'AFTER_MODULE_IMPORT'
$AkDriverFullManifestFile = [IO.Path]::GetFullPath($AkDriverImmutableManifestFile)
$AkDriverKnownIds = @()
foreach ($AkDriverCandidateFile in @(Get-ChildItem -LiteralPath $PSScriptRoot -Filter 'task_0024ak_*.json' -File -ErrorAction Stop)) {
    if ($AkDriverCandidateFile.FullName -eq $AkDriverFullManifestFile) {
        continue
    }
    try {
        $AkDriverCandidateRecord = Get-Content -Raw -LiteralPath $AkDriverCandidateFile.FullName |
            ConvertFrom-Json -Depth 100 -ErrorAction Stop
        if ($AkDriverCandidateRecord.task_identity -eq '0024AK' -and
            $AkDriverCandidateRecord.status -eq 'DECLARED' -and
            $AkDriverCandidateRecord.manifest_id -is [string] -and
            -not [string]::IsNullOrWhiteSpace([string]$AkDriverCandidateRecord.manifest_id)) {
            $AkDriverKnownIds += [string]$AkDriverCandidateRecord.manifest_id
        }
    }
    catch {
        continue
    }
}
$AkDriverPreflightValues = @(& $AkDriverPreflightTool `
    -AkPreflightGodotExecutable $AkDriverImmutableGodotExecutable `
    -AkPreflightProjectRoot $AkDriverImmutableProjectRoot `
    -AkPreflightManifestPath $AkDriverFullManifestFile `
    -AkPreflightKnownManifestIds $AkDriverKnownIds 2>&1)
if ($AkDriverPreflightValues.Count -ne 1 -or $AkDriverPreflightValues[0] -isnot [string]) {
    Stop-Task0024AKFinalCycle 'PREFLIGHT_OUTPUT_CARDINALITY_INVALID'
}
try {
    $AkDriverPreflightRecord = [string]$AkDriverPreflightValues[0] |
        ConvertFrom-Json -Depth 100 -ErrorAction Stop
}
catch {
    Stop-Task0024AKFinalCycle 'PREFLIGHT_OUTPUT_INVALID'
}
if ($AkDriverPreflightRecord.status -ne 'PASS') {
    Stop-Task0024AKFinalCycle 'PREFLIGHT_FAILED'
}
if (($AkDriverPreflightRecord.manifest_byte_count -isnot [int] -and
    $AkDriverPreflightRecord.manifest_byte_count -isnot [long]) -or
    [long]$AkDriverPreflightRecord.manifest_byte_count -lt 1 -or
    $AkDriverPreflightRecord.manifest_sha256 -isnot [string] -or
    [string]$AkDriverPreflightRecord.manifest_sha256 -notmatch '^[0-9a-f]{64}$' -or
    $AkDriverPreflightRecord.manifest_utf8_base64 -isnot [string] -or
    [string]::IsNullOrWhiteSpace([string]$AkDriverPreflightRecord.manifest_utf8_base64) -or
    $AkDriverPreflightRecord.validated_manifest -isnot [pscustomobject]) {
    Stop-Task0024AKFinalCycle 'PREFLIGHT_BINDING_FIELDS_INVALID'
}
Assert-Task0024AKDriverBindings -AkDriverCheckpoint 'AFTER_PREFLIGHT'
try {
    $AkDriverPreflightBytes = [Convert]::FromBase64String(
        [string]$AkDriverPreflightRecord.manifest_utf8_base64
    )
}
catch {
    Stop-Task0024AKFinalCycle 'PREFLIGHT_MANIFEST_BASE64_INVALID'
}
if ($AkDriverPreflightBytes.Length -ne [long]$AkDriverPreflightRecord.manifest_byte_count) {
    Stop-Task0024AKFinalCycle 'PREFLIGHT_MANIFEST_BYTE_COUNT_MISMATCH'
}
$AkDriverDeclaredManifest = $AkDriverPreflightRecord.validated_manifest
$AkDriverManifestSha256 = [string]$AkDriverPreflightRecord.manifest_sha256
$AkDriverConsumptionFile = "$AkDriverFullManifestFile.consumed.json"
$AkDriverConsumeRecord = [ordered]@{
    schema_version = 1
    task_identity = '0024AK'
    manifest_id = [string]$AkDriverDeclaredManifest.manifest_id
    manifest_sha256 = $AkDriverManifestSha256
    consumed_utc = [DateTime]::UtcNow.ToString('o')
    status = 'CONSUMED_BEFORE_FIRST_CASE'
}
$AkDriverManifestLockStream = [IO.File]::Open(
    $AkDriverFullManifestFile,
    [IO.FileMode]::Open,
    [IO.FileAccess]::Read,
    [IO.FileShare]::Read
)
try {
    if ($AkDriverManifestLockStream.Length -gt [int]::MaxValue) {
        Stop-Task0024AKFinalCycle 'MANIFEST_BYTE_COUNT_OVER_BOUND'
    }
    $AkDriverCurrentManifestBytes = [byte[]]::new([int]$AkDriverManifestLockStream.Length)
    $AkDriverReadOffset = 0
    while ($AkDriverReadOffset -lt $AkDriverCurrentManifestBytes.Length) {
        $AkDriverReadCount = $AkDriverManifestLockStream.Read(
            $AkDriverCurrentManifestBytes,
            $AkDriverReadOffset,
            $AkDriverCurrentManifestBytes.Length - $AkDriverReadOffset
        )
        if ($AkDriverReadCount -lt 1) {
            Stop-Task0024AKFinalCycle 'MANIFEST_LOCKED_READ_TRUNCATED'
        }
        $AkDriverReadOffset += $AkDriverReadCount
    }
    $AkDriverCurrentManifestBase64 = [Convert]::ToBase64String($AkDriverCurrentManifestBytes)
    $AkDriverCurrentManifestHashBytes = [Security.Cryptography.SHA256]::HashData(
        $AkDriverCurrentManifestBytes
    )
    $AkDriverCurrentManifestSha256 = -join ($AkDriverCurrentManifestHashBytes | ForEach-Object {
        $_.ToString('x2')
    })
    if ($AkDriverCurrentManifestBytes.Length -ne [long]$AkDriverPreflightRecord.manifest_byte_count -or
        -not [string]::Equals(
            $AkDriverCurrentManifestBase64,
            [string]$AkDriverPreflightRecord.manifest_utf8_base64,
            [StringComparison]::Ordinal
        ) -or
        -not [string]::Equals(
            $AkDriverCurrentManifestSha256,
            [string]$AkDriverPreflightRecord.manifest_sha256,
            [StringComparison]::Ordinal
        )) {
        Stop-Task0024AKFinalCycle 'MANIFEST_CHANGED_AFTER_PREFLIGHT'
    }
    try {
        $AkDriverConsumptionStream = [IO.File]::Open(
            $AkDriverConsumptionFile,
            [IO.FileMode]::CreateNew,
            [IO.FileAccess]::Write,
            [IO.FileShare]::None
        )
        try {
            $AkDriverConsumptionBytes = [Text.Encoding]::UTF8.GetBytes(
                ($AkDriverConsumeRecord | ConvertTo-Json -Compress)
            )
            $AkDriverConsumptionStream.Write(
                $AkDriverConsumptionBytes,
                0,
                $AkDriverConsumptionBytes.Length
            )
        }
        finally {
            $AkDriverConsumptionStream.Dispose()
        }
    }
    catch {
        Stop-Task0024AKFinalCycle 'MANIFEST_CONSUMPTION_WRITE_FAILED_OR_ALREADY_CONSUMED'
    }
}
finally {
    $AkDriverManifestLockStream.Dispose()
}
$AkDriverExpectedCases = @(
    [ordered]@{ name = 'sensor_contract_dynamic_signature'; marker = 'TASK_0024AJ_SENSOR_CONTRACT_DYNAMIC_SIGNATURE_PASS'; stderr_policy = 'RequireEmpty' },
    [ordered]@{ name = 'isolated_staging_route'; marker = 'TASK_0024AE_ISOLATED_STAGING_OWNER_ROUTE_PASS'; stderr_policy = 'RequireEmpty' },
    [ordered]@{ name = 'batch_1_12'; marker = 'TASK_0024AD_SUBMISSION_CORE_1_12_BATCH_PASS'; stderr_policy = 'RequireEmpty' },
    [ordered]@{ name = 'aggregate'; marker = 'TASK_0003_TESTS_PASS assertions=621 vectors=9'; stderr_policy = 'Allow' },
    [ordered]@{ name = 'complete_v2'; marker = 'TASK_0024V_V2_COMPLETE_PASS'; stderr_policy = 'RequireEmpty' }
)
$AkDriverCaseRecords = @()
try {
    for ($AkDriverIndex = 0; $AkDriverIndex -lt $AkDriverExpectedCases.Count; $AkDriverIndex++) {
        Assert-Task0024AKDriverBindings -AkDriverCheckpoint "BEFORE_CASE_$AkDriverIndex"
        $AkDriverCase = $AkDriverDeclaredManifest.cases[$AkDriverIndex]
        $AkDriverRule = $AkDriverExpectedCases[$AkDriverIndex]
        $AkDriverCountBefore = Get-Task0024AKDriverGodotCount
        if ($AkDriverCountBefore -ne 0) {
            Stop-Task0024AKFinalCycle "GODOT_NOT_ZERO_BEFORE:$($AkDriverRule.name):$AkDriverCountBefore"
        }
        $AkDriverAdapterValues = @(& $AkDriverAdapterTool `
            -AkGodotExecutable $AkDriverImmutableGodotExecutable `
            -AkProjectRoot $AkDriverImmutableProjectRoot `
            -AkScriptPath ([string]$AkDriverCase.script_path) `
            -AkRequiredMarker ([string]$AkDriverRule.marker) `
            -AkStderrPolicy ([string]$AkDriverRule.stderr_policy) 2>&1)
        if ($AkDriverAdapterValues.Count -ne 1 -or $AkDriverAdapterValues[0] -isnot [string]) {
            Stop-Task0024AKFinalCycle "ADAPTER_OUTPUT_CARDINALITY_INVALID:$($AkDriverRule.name)"
        }
        try {
            $AkDriverCapture = [string]$AkDriverAdapterValues[0] |
                ConvertFrom-Json -Depth 100 -ErrorAction Stop
        }
        catch {
            Stop-Task0024AKFinalCycle "ADAPTER_OUTPUT_INVALID_JSON:$($AkDriverRule.name)"
        }
        if ($AkDriverCapture -isnot [pscustomobject] -or
            $AkDriverCapture.raw_wrapper_json -isnot [string] -or
            $AkDriverCapture.raw_utf8_sha256 -isnot [string] -or
            [string]$AkDriverCapture.raw_utf8_sha256 -notmatch '^[0-9a-f]{64}$' -or
            ($AkDriverCapture.raw_utf8_byte_count -isnot [int] -and $AkDriverCapture.raw_utf8_byte_count -isnot [long]) -or
            [long]$AkDriverCapture.raw_utf8_byte_count -lt 1 -or
            ($AkDriverCapture.marker_count -isnot [int] -and $AkDriverCapture.marker_count -isnot [long]) -or
            [int]$AkDriverCapture.marker_count -ne 1 -or
            $AkDriverCapture.parsed_record -isnot [pscustomobject]) {
            Stop-Task0024AKFinalCycle "ADAPTER_REQUIRED_FIELD_INVALID:$($AkDriverRule.name)"
        }
        $AkDriverMarkerValidatedCapture = ConvertFrom-Task0024AKWrapperValues `
            -AkParserValues @([string]$AkDriverCapture.raw_wrapper_json) `
            -AkParserRequiredMarker ([string]$AkDriverRule.marker)
        if (-not [string]::Equals(
            [string]$AkDriverMarkerValidatedCapture.raw_utf8_sha256,
            [string]$AkDriverCapture.raw_utf8_sha256,
            [StringComparison]::Ordinal
        ) -or
            [long]$AkDriverMarkerValidatedCapture.raw_utf8_byte_count -ne
            [long]$AkDriverCapture.raw_utf8_byte_count -or
            [long]$AkDriverMarkerValidatedCapture.required_marker_occurrence_count -ne 1) {
            Stop-Task0024AKFinalCycle "ADAPTER_RAW_REVALIDATION_FAILED:$($AkDriverRule.name)"
        }
        $AkDriverWrapperRecord = $AkDriverMarkerValidatedCapture.parsed_record
        $AkDriverCountAfter = Get-Task0024AKDriverGodotCount
        if ($AkDriverCountAfter -ne 0 -or [int]$AkDriverCapture.godot_count_before -ne 0 -or
            [int]$AkDriverCapture.godot_count_after -ne 0) {
            Stop-Task0024AKFinalCycle "GODOT_NOT_ZERO_AFTER:$($AkDriverRule.name):$AkDriverCountAfter"
        }
        $AkDriverMarkerCount = [long]$AkDriverMarkerValidatedCapture.required_marker_occurrence_count
        if ([int]$AkDriverWrapperRecord.schema_version -ne 2 -or
            $AkDriverWrapperRecord.status -ne 'PASS' -or
            $AkDriverWrapperRecord.underlying_status -ne 'PASS' -or
            [int]$AkDriverWrapperRecord.native_exit_code -ne 0 -or
            -not $AkDriverWrapperRecord.marker_pass -or
            $AkDriverMarkerCount -ne 1 -or
            [int]$AkDriverWrapperRecord.cleanup_invocation_count -ne 1 -or
            @($AkDriverWrapperRecord.cleanup_order).Count -ne 1 -or
            @($AkDriverWrapperRecord.remaining_owned_pids).Count -ne 0 -or
            @($AkDriverWrapperRecord.remaining_unproven_pids).Count -ne 0) {
            Stop-Task0024AKFinalCycle "CASE_CONTRACT_FAILED:$($AkDriverRule.name)"
        }
        if ($AkDriverRule.stderr_policy -eq 'RequireEmpty' -and @($AkDriverWrapperRecord.stderr).Count -ne 0) {
            Stop-Task0024AKFinalCycle "STDERR_NOT_EMPTY:$($AkDriverRule.name)"
        }
        if ($AkDriverRule.name -eq 'aggregate' -and
            (@($AkDriverWrapperRecord.stderr) -join "`n") -ne 'LEVEL_ID_MISMATCH') {
            Stop-Task0024AKFinalCycle 'AGGREGATE_STDERR_MISMATCH'
        }
        $AkDriverAjEvidence = $null
        if ($AkDriverRule.name -eq 'sensor_contract_dynamic_signature') {
            $AkDriverAjEvidence = ConvertFrom-Task0024AKEvidenceLines -AkParserLines @($AkDriverWrapperRecord.stdout)
        }
        $AkDriverCaseRecords += [ordered]@{
            name = [string]$AkDriverRule.name
            marker = [string]$AkDriverRule.marker
            marker_count = $AkDriverMarkerCount
            godot_count_before = $AkDriverCountBefore
            godot_count_after = $AkDriverCountAfter
            adapter_godot_count_before = $AkDriverCapture.godot_count_before
            adapter_godot_count_after = $AkDriverCapture.godot_count_after
            raw_utf8_sha256 = $AkDriverCapture.raw_utf8_sha256
            raw_utf8_byte_count = $AkDriverCapture.raw_utf8_byte_count
            parsed_record = $AkDriverWrapperRecord
            aj_evidence = $AkDriverAjEvidence
        }
        Assert-Task0024AKDriverBindings -AkDriverCheckpoint "AFTER_CASE_$AkDriverIndex"
    }
    [ordered]@{
        schema_version = 1
        task_identity = '0024AK'
        status = 'PASS'
        manifest_id = [string]$AkDriverDeclaredManifest.manifest_id
        manifest_sha256 = $AkDriverManifestSha256
        manifest_path = $AkDriverFullManifestFile
        consumption_path = $AkDriverConsumptionFile
        cases = $AkDriverCaseRecords
        final_godot_count = 0
    } | ConvertTo-Json -Depth 100 -Compress
}
finally {
    $AkDriverFinalGodotCount = Get-Task0024AKDriverGodotCount
    if ($AkDriverFinalGodotCount -ne 0) {
        throw "TASK_0024AK_FINAL_CYCLE_FAIL:GODOT_NOT_ZERO_FINALLY:$AkDriverFinalGodotCount"
    }
}
