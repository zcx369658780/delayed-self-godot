[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$OutputPath,
    [ValidateSet('PRE_TASK', 'PRE_FINAL', 'POST_FINAL')][string]$Phase = 'PRE_TASK'
)

$ErrorActionPreference = 'Stop'
$projectRoot = 'D:\Delayed_Self'
$sealPath = 'D:\Delayed_Self_Evidence\0024W_complete_core_mechanics_final_validation\pre_execution_seal.json'
$expectedSealSha256 = '0e288adfe29c5881ab1f8cf40adf2df842a6fbbb8c6e5bce7aa14c797cf67ec0'
$resolvedOutput = [IO.Path]::GetFullPath((Join-Path $projectRoot $OutputPath))
if (Test-Path -LiteralPath $resolvedOutput) {
    throw "Audit output already exists: $resolvedOutput"
}

$sealHash = (Get-FileHash -LiteralPath $sealPath -Algorithm SHA256).Hash.ToLowerInvariant()
if ($sealHash -ne $expectedSealSha256) {
    throw "Task 0024W seal identity mismatch: $sealHash"
}
$seal = Get-Content -LiteralPath $sealPath -Raw | ConvertFrom-Json -Depth 100
$repositoryEntries = @($seal.sealed_files.PSObject.Properties)
$externalEntries = @($seal.external_evidence.PSObject.Properties)
if ($repositoryEntries.Count -ne 53 -or $externalEntries.Count -ne 12) {
    throw "Unexpected Task 0024W seal cardinality: repository=$($repositoryEntries.Count) external=$($externalEntries.Count)"
}

$extraPaths = @(
    'data/levels/crate_shadow_timing.json',
    'tests/levels/task_0024y_crate_shadow_timing_validation.gd',
    'docs/level_design/validation/sequence_09_crate_shadow_timing_validation.json',
    'docs/reports/0024Y_SEQUENCE_9_CRATE_SHADOW_TIMING_MACHINE_VALIDATION_REPORT.md',
    'docs/reports/0024Y_GPT_SEQUENCE_9_CRATE_SHADOW_TIMING_MACHINE_VALIDATION_ACCEPTANCE.md',
    'tests/tools/task_0024y_final_qualification_summary.json',
    'tests/tools/task_0024y_run_case.ps1',
    'tests/tools/run_owned_godot_headless.ps1'
)
$extraHashes = [ordered]@{}
foreach ($relativePath in $extraPaths) {
    $path = Join-Path $projectRoot $relativePath
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        throw "Required accepted sequence-9 path missing: $relativePath"
    }
    $extraHashes[$relativePath] = (Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash.ToLowerInvariant()
}

$repositoryMismatches = [Collections.Generic.List[object]]::new()
foreach ($entry in $repositoryEntries) {
    $path = Join-Path $projectRoot ([string]$entry.Name)
    $actual = if (Test-Path -LiteralPath $path -PathType Leaf) { (Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash.ToLowerInvariant() } else { 'MISSING' }
    $expected = ([string]$entry.Value).ToLowerInvariant()
    if ($actual -ne $expected) {
        $repositoryMismatches.Add([ordered]@{ path = [string]$entry.Name; expected_sha256 = $expected; actual_sha256 = $actual })
    }
}
$externalMismatches = [Collections.Generic.List[object]]::new()
foreach ($entry in $externalEntries) {
    $relativePath = [string]$entry.Name
    $path = Join-Path 'D:\Delayed_Self_Evidence' $relativePath
    $actual = if (Test-Path -LiteralPath $path -PathType Leaf) { (Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash.ToLowerInvariant() } else { 'MISSING' }
    $expected = ([string]$entry.Value).ToLowerInvariant()
    if ($actual -ne $expected) {
        $externalMismatches.Add([ordered]@{ path = $relativePath; expected_sha256 = $expected; actual_sha256 = $actual })
    }
}

$result = [ordered]@{
    schema_version = 1
    task = '0024Z'
    phase = $Phase
    audited_utc = [DateTime]::UtcNow.ToString('o')
    head = (git -C $projectRoot rev-parse HEAD)
    seal_path = $sealPath
    seal_sha256 = $sealHash
    repository_file_count = $repositoryEntries.Count
    repository_mismatch_count = $repositoryMismatches.Count
    repository_mismatches = @($repositoryMismatches)
    historical_external_evidence_file_count = $externalEntries.Count
    historical_external_evidence_mismatch_count = $externalMismatches.Count
    historical_external_evidence_mismatches = @($externalMismatches)
    accepted_sequence_9_and_wrapper_hashes = $extraHashes
    status = if ($repositoryMismatches.Count -eq 0 -and $externalMismatches.Count -eq 0) { 'PASS' } else { 'DRIFT' }
}
$utf8NoBom = [Text.UTF8Encoding]::new($false)
[IO.File]::WriteAllText($resolvedOutput, ($result | ConvertTo-Json -Depth 20) + "`n", $utf8NoBom)
Write-Output ("TASK_0024Z_FROZEN_HASH_AUDIT_WRITTEN " + $resolvedOutput)
if ($result.status -ne 'PASS') {
    exit 1
}
