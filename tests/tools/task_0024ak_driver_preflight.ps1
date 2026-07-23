[CmdletBinding()]
param(
    [Parameter(Mandatory)][AllowEmptyString()][string]$AkPreflightGodotExecutable,
    [Parameter(Mandatory)][AllowEmptyString()][string]$AkPreflightProjectRoot,
    [Parameter(Mandatory)][AllowEmptyString()][string]$AkPreflightManifestPath,
    [AllowEmptyString()][string]$AkPreflightManifestJson = '',
    [string[]]$AkPreflightKnownManifestIds = @(),
    [switch]$AkPreflightProbeConsumptionExists
)
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
function Stop-Task0024AKPreflight {
    param([Parameter(Mandatory)][string]$AkPreflightReason)
    throw "TASK_0024AK_DRIVER_PREFLIGHT_FAIL:$AkPreflightReason"
}
foreach ($AkPreflightValue in ([ordered]@{
    EXECUTABLE = $AkPreflightGodotExecutable
    ROOT = $AkPreflightProjectRoot
    MANIFEST = $AkPreflightManifestPath
}).GetEnumerator()) {
    if ([string]::IsNullOrWhiteSpace([string]$AkPreflightValue.Value)) {
        Stop-Task0024AKPreflight "EMPTY_$($AkPreflightValue.Key)"
    }
}
$AkPreflightCanonicalDirectory = [IO.Path]::GetFullPath($PSScriptRoot)
try {
    $AkPreflightFullManifest = [IO.Path]::GetFullPath($AkPreflightManifestPath)
}
catch {
    Stop-Task0024AKPreflight 'MANIFEST_PATH_INVALID'
}
if ([IO.Path]::GetDirectoryName($AkPreflightFullManifest) -ne $AkPreflightCanonicalDirectory -or
    [IO.Path]::GetFileName($AkPreflightFullManifest) -ne 'task_0024ak_retained_manifest.json') {
    Stop-Task0024AKPreflight 'MANIFEST_NOT_CANONICAL_AK_TOOLS_PATH'
}
if ([string]::IsNullOrEmpty($AkPreflightManifestJson)) {
    if (-not (Test-Path -LiteralPath $AkPreflightFullManifest -PathType Leaf)) {
        Stop-Task0024AKPreflight 'MANIFEST_NOT_FOUND'
    }
    $AkPreflightManifestBytes = [IO.File]::ReadAllBytes($AkPreflightFullManifest)
    try {
        $AkPreflightManifestJson = [Text.UTF8Encoding]::new($false, $true).GetString(
            $AkPreflightManifestBytes
        )
    }
    catch {
        Stop-Task0024AKPreflight 'MANIFEST_NOT_VALID_UTF8'
    }
}
else {
    $AkPreflightManifestBytes = [Text.Encoding]::UTF8.GetBytes($AkPreflightManifestJson)
}
try {
    $AkPreflightRecord = $AkPreflightManifestJson | ConvertFrom-Json -Depth 100 -ErrorAction Stop
}
catch {
    Stop-Task0024AKPreflight 'MANIFEST_INVALID_JSON'
}
if ($AkPreflightRecord -is [array] -or $AkPreflightRecord -isnot [pscustomobject]) {
    Stop-Task0024AKPreflight 'MANIFEST_NOT_OBJECT'
}
if ($AkPreflightRecord.schema_version -isnot [int] -and $AkPreflightRecord.schema_version -isnot [long]) {
    Stop-Task0024AKPreflight 'MANIFEST_SCHEMA_WRONG_TYPE'
}
if ([int]$AkPreflightRecord.schema_version -ne 1 -or
    $AkPreflightRecord.task_identity -ne '0024AK' -or
    $AkPreflightRecord.status -ne 'DECLARED' -or
    $AkPreflightRecord.manifest_id -isnot [string] -or
    [string]::IsNullOrWhiteSpace([string]$AkPreflightRecord.manifest_id)) {
    Stop-Task0024AKPreflight 'MANIFEST_DECLARATION_INVALID'
}
if (@($AkPreflightKnownManifestIds | Where-Object { $_ -eq [string]$AkPreflightRecord.manifest_id }).Count -gt 0) {
    Stop-Task0024AKPreflight 'DUPLICATE_MANIFEST_ID'
}
$AkPreflightExpected = @(
    [ordered]@{ name = 'sensor_contract_dynamic_signature'; script_path = 'res://tests/presentation/task_0024aj_sensor_contract_and_dynamic_signature_validation.gd'; marker = 'TASK_0024AJ_SENSOR_CONTRACT_DYNAMIC_SIGNATURE_PASS' },
    [ordered]@{ name = 'isolated_staging_route'; script_path = 'res://tests/playtest/task_0024ae_submission_core_owner_review_launcher.gd'; marker = 'TASK_0024AE_ISOLATED_STAGING_OWNER_ROUTE_PASS' },
    [ordered]@{ name = 'batch_1_12'; script_path = 'res://tests/curriculum/task_0024ad_submission_core_1_12_batch_validation.gd'; marker = 'TASK_0024AD_SUBMISSION_CORE_1_12_BATCH_PASS' },
    [ordered]@{ name = 'aggregate'; script_path = 'res://tests/run_all.gd'; marker = 'TASK_0003_TESTS_PASS assertions=621 vectors=9' },
    [ordered]@{ name = 'complete_v2'; script_path = 'res://tests/simulation/task_0024v_v2_solver_replay_canonical_malformed.gd'; marker = 'TASK_0024V_V2_COMPLETE_PASS' }
)
if ($AkPreflightRecord.cases -isnot [array] -or @($AkPreflightRecord.cases).Count -ne 5) {
    Stop-Task0024AKPreflight 'MANIFEST_CASES_INVALID'
}
for ($AkPreflightIndex = 0; $AkPreflightIndex -lt $AkPreflightExpected.Count; $AkPreflightIndex++) {
    $AkPreflightActualCase = $AkPreflightRecord.cases[$AkPreflightIndex]
    $AkPreflightExpectedCase = $AkPreflightExpected[$AkPreflightIndex]
    if ($AkPreflightActualCase.name -ne $AkPreflightExpectedCase.name -or
        $AkPreflightActualCase.script_path -ne $AkPreflightExpectedCase.script_path -or
        $AkPreflightActualCase.marker -ne $AkPreflightExpectedCase.marker) {
        Stop-Task0024AKPreflight "CASE_ORDER_OR_CONTRACT_INVALID:$AkPreflightIndex"
    }
}
$AkPreflightSidecar = "$AkPreflightFullManifest.consumed.json"
if ($AkPreflightProbeConsumptionExists -or (Test-Path -LiteralPath $AkPreflightSidecar)) {
    Stop-Task0024AKPreflight 'CONSUMPTION_SIDECAR_EXISTS'
}
[byte[]]$AkPreflightHashBytes = [Security.Cryptography.SHA256]::HashData(
    $AkPreflightManifestBytes
)
$AkPreflightManifestSha256 = -join ($AkPreflightHashBytes | ForEach-Object {
    $_.ToString('x2')
})
[ordered]@{
    schema_version = 1
    task_identity = '0024AK'
    status = 'PASS'
    manifest_id = [string]$AkPreflightRecord.manifest_id
    manifest_path = $AkPreflightFullManifest
    consumption_path = $AkPreflightSidecar
    manifest_byte_count = [long]$AkPreflightManifestBytes.Length
    manifest_sha256 = $AkPreflightManifestSha256
    manifest_utf8_base64 = [Convert]::ToBase64String($AkPreflightManifestBytes)
    validated_manifest = $AkPreflightRecord
    case_count = 5
} | ConvertTo-Json -Depth 10 -Compress
