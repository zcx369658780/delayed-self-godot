[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$OutputPath,
    [ValidateSet('PRE_TASK','PRE_FINAL','POST_FINAL')][string]$Phase = 'PRE_TASK'
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

$fixedSets = @(
    [ordered]@{ name = 'sequence_9'; commit = '445122ab035a4c9210f3280af58d054a35bef2bd'; paths = @('data/levels/crate_shadow_timing.json','tests/levels/task_0024y_crate_shadow_timing_validation.gd','docs/level_design/validation/sequence_09_crate_shadow_timing_validation.json','docs/reports/0024Y_SEQUENCE_9_CRATE_SHADOW_TIMING_MACHINE_VALIDATION_REPORT.md') },
    [ordered]@{ name = 'sequence_10'; commit = 'b8378bc2e1e96642ff99eded436df65e2435cc9f'; paths = @('data/levels/key_route_commitment.json','tests/levels/task_0024z_key_route_commitment_validation.gd','docs/level_design/validation/sequence_10_key_route_commitment_validation.json','docs/reports/0024Z_SEQUENCE_10_KEY_ROUTE_COMMITMENT_MACHINE_VALIDATION_REPORT.md') },
    [ordered]@{ name = 'sequence_11'; commit = 'e6cd9fe76c19a144315b173b480ad5f9ccf2f115'; paths = @('data/levels/identity_shift_bridge.json','tests/levels/task_0024ab_identity_shift_bridge_validation.gd','docs/level_design/validation/sequence_11_identity_shift_bridge_validation_0024ab.json','docs/reports/0024AB_SEQUENCE_11_EVIDENCE_CAPTURE_CORRECTION_REPORT.md') }
)
$fixedMismatches = [Collections.Generic.List[object]]::new()
$fixedHashes = [ordered]@{}
foreach ($set in $fixedSets) {
    foreach ($relative in $set.paths) {
        $spec = ('{0}:{1}' -f $set.commit, $relative)
        $expectedBlob = (git -C $root rev-parse $spec).Trim()
        $actualBlob = (git -C $root hash-object -- $relative).Trim()
        $sha = (Get-FileHash -LiteralPath (Join-Path $root $relative) -Algorithm SHA256).Hash.ToLowerInvariant()
        $fixedHashes[$relative] = [ordered]@{ accepted_commit = $set.commit; sha256 = $sha; git_blob = $actualBlob }
        if ($expectedBlob -ne $actualBlob) { $fixedMismatches.Add([ordered]@{ set = $set.name; path = $relative; expected_blob = $expectedBlob; actual_blob = $actualBlob }) }
    }
}

$aaCommit = 'e2938b61a6207e970302675db8bb454c08c40cd3'
$aaPaths = @((git -C $root ls-tree -r --name-only $aaCommit) | Where-Object { $_ -like 'tests/tools/task_0024aa_*' }) + @('data/levels/identity_shift_bridge.json','tests/levels/task_0024aa_identity_shift_bridge_validation.gd','docs/level_design/validation/sequence_11_identity_shift_bridge_validation.json','docs/reports/0024AA_SEQUENCE_11_IDENTITY_SHIFT_BRIDGE_MACHINE_VALIDATION_REPORT.md')
$aaMismatches = [Collections.Generic.List[object]]::new()
foreach ($relative in $aaPaths) {
    $expectedBlob = (git -C $root rev-parse ('{0}:{1}' -f $aaCommit, $relative)).Trim()
    $actualBlob = (git -C $root hash-object -- $relative).Trim()
    if ($expectedBlob -ne $actualBlob) { $aaMismatches.Add([ordered]@{ path = $relative; expected_blob = $expectedBlob; actual_blob = $actualBlob }) }
}

$abCommit = 'e6cd9fe76c19a144315b173b480ad5f9ccf2f115'
$abPaths = @((git -C $root ls-tree -r --name-only $abCommit) | Where-Object { $_ -like 'tests/tools/task_0024ab_*' }) + @('tests/levels/task_0024ab_identity_shift_bridge_validation.gd','docs/level_design/validation/sequence_11_identity_shift_bridge_validation_0024ab.json','docs/reports/0024AB_SEQUENCE_11_EVIDENCE_CAPTURE_CORRECTION_REPORT.md')
$abMismatches = [Collections.Generic.List[object]]::new()
foreach ($relative in $abPaths) {
    $expectedBlob = (git -C $root rev-parse ('{0}:{1}' -f $abCommit, $relative)).Trim()
    $actualBlob = (git -C $root hash-object -- $relative).Trim()
    if ($expectedBlob -ne $actualBlob) { $abMismatches.Add([ordered]@{ path = $relative; expected_blob = $expectedBlob; actual_blob = $actualBlob }) }
}

$headFrozenPaths = @(
    'scripts/simulation/level_loader.gd','scripts/simulation/simulation.gd','scripts/solver/bfs_solver.gd',
    'schemas/level_v1.schema.json','schemas/level_v2.schema.json','schemas/catalog_v1.schema.json',
    'docs/level_design/reference/turn_transition_vectors_v1.json','docs/level_design/reference/turn_transition_vectors_v2.json',
    'data/catalog/level_catalog_v1.json',
    'data/levels/tutorial_reach_exit.json','data/levels/tutorial_echo_bridge.json','data/levels/vertical_slice_delay_3.json','data/levels/door_one_turn_late.json','data/levels/two_keys_one_door.json','data/levels/staggered_doors.json','data/levels/echo_spacing_bridge.json','data/levels/two_echo_convergence.json',
    'tests/tools/run_owned_godot_headless.ps1',
    'docs/reports/0024W_GPT_COMPLETE_CORE_MECHANICS_FOUNDATION_ACCEPTANCE.md','docs/reports/0024X_GPT_SUBMISSION_CORE_LEVELS_9_12_SCOPE_ACCEPTANCE.md',
    'docs/reports/0024Y_GPT_SEQUENCE_9_CRATE_SHADOW_TIMING_MACHINE_VALIDATION_ACCEPTANCE.md','docs/reports/0024Z_GPT_SEQUENCE_10_KEY_ROUTE_COMMITMENT_MACHINE_VALIDATION_ACCEPTANCE.md',
    'docs/reports/0024AA_GPT_EVIDENCE_RETENTION_BLOCKER_ACCEPTANCE.md','docs/reports/0024AB_GPT_SEQUENCE_11_IDENTITY_SHIFT_BRIDGE_CORRECTED_MACHINE_VALIDATION_ACCEPTANCE.md',
    'tasks/0024AA_sequence_11_identity_shift_bridge_candidate_authoring_and_machine_validation.md','tasks/0024AB_sequence_11_evidence_capture_correction_and_fresh_validation.md'
)
$headMismatches = [Collections.Generic.List[object]]::new()
$headHashes = [ordered]@{}
foreach ($relative in $headFrozenPaths) {
    $path = Join-Path $root $relative
    $headBlob = (git -C $root rev-parse ('HEAD:{0}' -f $relative)).Trim()
    $actualBlob = (git -C $root hash-object -- $relative).Trim()
    $headHashes[$relative] = [ordered]@{ sha256 = (Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash.ToLowerInvariant(); git_blob = $actualBlob }
    if ($headBlob -ne $actualBlob) { $headMismatches.Add([ordered]@{ path = $relative; expected_blob = $headBlob; actual_blob = $actualBlob }) }
}

$wrapperBlob = (git -C $root hash-object -- 'tests/tools/run_owned_godot_headless.ps1').Trim()
$status = if ($repositoryMismatches.Count -eq 0 -and $externalMismatches.Count -eq 0 -and $fixedMismatches.Count -eq 0 -and $aaMismatches.Count -eq 0 -and $abMismatches.Count -eq 0 -and $headMismatches.Count -eq 0 -and $wrapperBlob -eq '5f14eb0feff903b40311c1c7283b20e2eabbffc2') { 'PASS' } else { 'DRIFT' }
$result = [ordered]@{
    schema_version = 1
    task = '0024AC'
    phase = $Phase
    audited_utc = [DateTime]::UtcNow.ToString('o')
    head = (git -C $root rev-parse HEAD).Trim()
    seal_path = $sealPath
    seal_sha256 = $sealHash
    repository_file_count = $repositoryEntries.Count
    repository_mismatch_count = $repositoryMismatches.Count
    repository_mismatches = @($repositoryMismatches)
    historical_external_evidence_file_count = $externalEntries.Count
    historical_external_evidence_mismatch_count = $externalMismatches.Count
    historical_external_evidence_mismatches = @($externalMismatches)
    fixed_accepted_hashes = $fixedHashes
    fixed_accepted_mismatch_count = $fixedMismatches.Count
    fixed_accepted_mismatches = @($fixedMismatches)
    historical_0024aa_path_count = $aaPaths.Count
    historical_0024aa_mismatch_count = $aaMismatches.Count
    historical_0024aa_mismatches = @($aaMismatches)
    historical_0024ab_path_count = $abPaths.Count
    historical_0024ab_mismatch_count = $abMismatches.Count
    historical_0024ab_mismatches = @($abMismatches)
    head_frozen_hashes = $headHashes
    head_frozen_mismatch_count = $headMismatches.Count
    head_frozen_mismatches = @($headMismatches)
    wrapper_blob = $wrapperBlob
    status = $status
}
[IO.File]::WriteAllText($output, ($result | ConvertTo-Json -Depth 100) + "`n", [Text.UTF8Encoding]::new($false))
Write-Output ("TASK_0024AC_FROZEN_HASH_AUDIT_" + $status + " " + $output)
if ($status -ne 'PASS') { exit 1 }
