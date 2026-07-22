[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$OutputPath,
    [ValidateSet('PRE_TASK', 'PRE_FINAL', 'POST_FINAL')][string]$Phase = 'PRE_TASK'
)

$ErrorActionPreference = 'Stop'
$root = 'D:\Delayed_Self'
$sealPath = 'D:\Delayed_Self_Evidence\0024W_complete_core_mechanics_final_validation\pre_execution_seal.json'
$expectedSealSha256 = '0e288adfe29c5881ab1f8cf40adf2df842a6fbbb8c6e5bce7aa14c797cf67ec0'
$output = [IO.Path]::GetFullPath((Join-Path $root $OutputPath))
if (Test-Path -LiteralPath $output) { throw "Audit output already exists: $output" }

$sealHash = (Get-FileHash -LiteralPath $sealPath -Algorithm SHA256).Hash.ToLowerInvariant()
if ($sealHash -ne $expectedSealSha256) { throw "Task 0024W seal identity mismatch: $sealHash" }
$seal = Get-Content -LiteralPath $sealPath -Raw | ConvertFrom-Json -Depth 100
$repositoryEntries = @($seal.sealed_files.PSObject.Properties)
$externalEntries = @($seal.external_evidence.PSObject.Properties)
if ($repositoryEntries.Count -ne 53 -or $externalEntries.Count -ne 12) { throw "Unexpected seal cardinality: repository=$($repositoryEntries.Count) external=$($externalEntries.Count)" }

$repositoryMismatches = [Collections.Generic.List[object]]::new()
foreach ($entry in $repositoryEntries) {
    $path = Join-Path $root ([string]$entry.Name)
    $actual = if (Test-Path -LiteralPath $path -PathType Leaf) { (Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash.ToLowerInvariant() } else { 'MISSING' }
    $expected = ([string]$entry.Value).ToLowerInvariant()
    if ($actual -ne $expected) { $repositoryMismatches.Add([ordered]@{ path = [string]$entry.Name; expected_sha256 = $expected; actual_sha256 = $actual }) }
}
$externalMismatches = [Collections.Generic.List[object]]::new()
foreach ($entry in $externalEntries) {
    $relative = [string]$entry.Name
    $path = Join-Path 'D:\Delayed_Self_Evidence' $relative
    $actual = if (Test-Path -LiteralPath $path -PathType Leaf) { (Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash.ToLowerInvariant() } else { 'MISSING' }
    $expected = ([string]$entry.Value).ToLowerInvariant()
    if ($actual -ne $expected) { $externalMismatches.Add([ordered]@{ path = $relative; expected_sha256 = $expected; actual_sha256 = $actual }) }
}

$explicitPaths = @(
    'scripts/simulation/level_loader.gd',
    'scripts/simulation/simulation.gd',
    'scripts/solver/bfs_solver.gd',
    'schemas/level_v1.schema.json',
    'schemas/level_v2.schema.json',
    'schemas/catalog_v1.schema.json',
    'docs/level_design/reference/turn_transition_vectors_v1.json',
    'docs/level_design/reference/turn_transition_vectors_v2.json',
    'tests/simulation/fixtures/task_0023zx_crate_echo.json',
    'tests/simulation/fixtures/task_0023zx_integration.json',
    'tests/simulation/fixtures/task_0023zx_key_lock.json',
    'tests/simulation/fixtures/task_0023zx_latch_defer.json',
    'tests/simulation/fixtures/task_0023zx_sensor_barrier.json',
    'data/catalog/level_catalog_v1.json',
    'data/levels/tutorial_reach_exit.json',
    'data/levels/tutorial_echo_bridge.json',
    'data/levels/vertical_slice_delay_3.json',
    'data/levels/door_one_turn_late.json',
    'data/levels/two_keys_one_door.json',
    'data/levels/staggered_doors.json',
    'data/levels/echo_spacing_bridge.json',
    'data/levels/two_echo_convergence.json',
    'data/levels/crate_shadow_timing.json',
    'tests/levels/task_0024y_crate_shadow_timing_validation.gd',
    'docs/level_design/validation/sequence_09_crate_shadow_timing_validation.json',
    'docs/reports/0024Y_SEQUENCE_9_CRATE_SHADOW_TIMING_MACHINE_VALIDATION_REPORT.md',
    'docs/reports/0024Y_GPT_SEQUENCE_9_CRATE_SHADOW_TIMING_MACHINE_VALIDATION_ACCEPTANCE.md',
    'data/levels/key_route_commitment.json',
    'tests/levels/task_0024z_key_route_commitment_validation.gd',
    'docs/level_design/validation/sequence_10_key_route_commitment_validation.json',
    'docs/reports/0024Z_SEQUENCE_10_KEY_ROUTE_COMMITMENT_MACHINE_VALIDATION_REPORT.md',
    'docs/reports/0024Z_GPT_SEQUENCE_10_KEY_ROUTE_COMMITMENT_MACHINE_VALIDATION_ACCEPTANCE.md',
    'tests/tools/run_owned_godot_headless.ps1'
)
$explicitHashes = [ordered]@{}
$headMismatches = [Collections.Generic.List[object]]::new()
foreach ($relative in $explicitPaths) {
    $path = Join-Path $root $relative
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) { throw "Required frozen path missing: $relative" }
    $currentBlob = (git -C $root hash-object -- $relative).Trim()
    $headBlob = (git -C $root rev-parse "HEAD:$relative").Trim()
    if ($currentBlob -ne $headBlob) { $headMismatches.Add([ordered]@{ path = $relative; expected_blob = $headBlob; actual_blob = $currentBlob }) }
    $explicitHashes[$relative] = [ordered]@{ sha256 = (Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash.ToLowerInvariant(); git_blob = $currentBlob }
}

$acceptedChecks = @(
    [ordered]@{ commit = '445122ab035a4c9210f3280af58d054a35bef2bd'; paths = @('data/levels/crate_shadow_timing.json', 'tests/levels/task_0024y_crate_shadow_timing_validation.gd', 'docs/level_design/validation/sequence_09_crate_shadow_timing_validation.json', 'docs/reports/0024Y_SEQUENCE_9_CRATE_SHADOW_TIMING_MACHINE_VALIDATION_REPORT.md') },
    [ordered]@{ commit = 'b8378bc2e1e96642ff99eded436df65e2435cc9f'; paths = @('data/levels/key_route_commitment.json', 'tests/levels/task_0024z_key_route_commitment_validation.gd', 'docs/level_design/validation/sequence_10_key_route_commitment_validation.json', 'docs/reports/0024Z_SEQUENCE_10_KEY_ROUTE_COMMITMENT_MACHINE_VALIDATION_REPORT.md') }
)
$acceptedMismatches = [Collections.Generic.List[object]]::new()
foreach ($check in $acceptedChecks) {
    foreach ($relative in $check.paths) {
        $acceptedBlob = (git -C $root rev-parse "$($check.commit):$relative").Trim()
        $currentBlob = (git -C $root hash-object -- $relative).Trim()
        if ($acceptedBlob -ne $currentBlob) { $acceptedMismatches.Add([ordered]@{ path = $relative; accepted_commit = $check.commit; expected_blob = $acceptedBlob; actual_blob = $currentBlob }) }
    }
}

$historicalCommit = 'e2938b61a6207e970302675db8bb454c08c40cd3'
$historicalPaths = @((git -C $root ls-tree -r --name-only $historicalCommit) | Where-Object { $_ -like 'tests/tools/task_0024aa_*' }) + @(
    'data/levels/identity_shift_bridge.json',
    'tests/levels/task_0024aa_identity_shift_bridge_validation.gd',
    'docs/level_design/validation/sequence_11_identity_shift_bridge_validation.json',
    'docs/reports/0024AA_SEQUENCE_11_IDENTITY_SHIFT_BRIDGE_MACHINE_VALIDATION_REPORT.md'
)
$historicalMismatches = [Collections.Generic.List[object]]::new()
foreach ($relative in $historicalPaths) {
    $historicalSpec = ('{0}:{1}' -f $historicalCommit, $relative)
    $expectedBlob = (git -C $root rev-parse $historicalSpec).Trim()
    $actualBlob = (git -C $root hash-object -- $relative).Trim()
    if ($expectedBlob -ne $actualBlob) { $historicalMismatches.Add([ordered]@{ path = $relative; expected_blob = $expectedBlob; actual_blob = $actualBlob }) }
}
$candidateSha256 = (Get-FileHash -LiteralPath (Join-Path $root 'data/levels/identity_shift_bridge.json') -Algorithm SHA256).Hash.ToLowerInvariant()
$historicalValidatorSha256 = (Get-FileHash -LiteralPath (Join-Path $root 'tests/levels/task_0024aa_identity_shift_bridge_validation.gd') -Algorithm SHA256).Hash.ToLowerInvariant()
$wrapperBlob = (git -C $root hash-object -- 'tests/tools/run_owned_godot_headless.ps1').Trim()
$status = if ($repositoryMismatches.Count -eq 0 -and $externalMismatches.Count -eq 0 -and $headMismatches.Count -eq 0 -and $acceptedMismatches.Count -eq 0 -and $historicalMismatches.Count -eq 0 -and $candidateSha256 -eq '8856d3c64978cef7cff7f1680a7ae2f412c9b0cab058d598cbe3aee0225052e0' -and $historicalValidatorSha256 -eq 'bff20626fb4830f4a8fed2e3b7f4b485a172d443db358978d1d1eeafeebc5a82' -and $wrapperBlob -eq '5f14eb0feff903b40311c1c7283b20e2eabbffc2') { 'PASS' } else { 'DRIFT' }
$result = [ordered]@{
    schema_version = 1
    task = '0024AB'
    phase = $Phase
    audited_utc = [DateTime]::UtcNow.ToString('o')
    head = (git -C $root rev-parse HEAD)
    seal_path = $sealPath
    seal_sha256 = $sealHash
    repository_file_count = $repositoryEntries.Count
    repository_mismatch_count = $repositoryMismatches.Count
    repository_mismatches = @($repositoryMismatches)
    historical_external_evidence_file_count = $externalEntries.Count
    historical_external_evidence_mismatch_count = $externalMismatches.Count
    historical_external_evidence_mismatches = @($externalMismatches)
    explicit_frozen_path_count = $explicitPaths.Count
    explicit_frozen_hashes = $explicitHashes
    head_blob_mismatch_count = $headMismatches.Count
    head_blob_mismatches = @($headMismatches)
    accepted_candidate_mismatch_count = $acceptedMismatches.Count
    accepted_candidate_mismatches = @($acceptedMismatches)
    historical_commit = $historicalCommit
    historical_path_count = $historicalPaths.Count
    historical_mismatch_count = $historicalMismatches.Count
    historical_mismatches = @($historicalMismatches)
    candidate_sha256 = $candidateSha256
    historical_validator_sha256 = $historicalValidatorSha256
    wrapper_blob = $wrapperBlob
    status = $status
}
$utf8NoBom = [Text.UTF8Encoding]::new($false)
[IO.File]::WriteAllText($output, ($result | ConvertTo-Json -Depth 30) + "`n", $utf8NoBom)
Write-Output ("TASK_0024AB_FROZEN_HASH_AUDIT_WRITTEN " + $output)
if ($status -ne 'PASS') { exit 1 }
