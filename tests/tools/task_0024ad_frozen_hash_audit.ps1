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
if ($repositoryEntries.Count -ne 53 -or $externalEntries.Count -ne 12) { throw "Unexpected seal cardinality" }

function Compare-HashEntries([object[]]$Entries, [string]$Base) {
    $mismatches = [Collections.Generic.List[object]]::new()
    foreach ($entry in $Entries) {
        $path = Join-Path $Base ([string]$entry.Name)
        $actual = if (Test-Path -LiteralPath $path -PathType Leaf) { (Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash.ToLowerInvariant() } else { 'MISSING' }
        $expected = ([string]$entry.Value).ToLowerInvariant()
        if ($actual -ne $expected) { $mismatches.Add([ordered]@{ path = [string]$entry.Name; expected_sha256 = $expected; actual_sha256 = $actual }) }
    }
    return @($mismatches)
}

$repositoryMismatches = @(Compare-HashEntries $repositoryEntries $root)
$externalMismatches = @(Compare-HashEntries $externalEntries 'D:\Delayed_Self_Evidence')

$acceptedSets = @(
    [ordered]@{ name='sequence_9'; commit='445122ab035a4c9210f3280af58d054a35bef2bd'; paths=@('data/levels/crate_shadow_timing.json','tests/levels/task_0024y_crate_shadow_timing_validation.gd','docs/level_design/validation/sequence_09_crate_shadow_timing_validation.json','docs/reports/0024Y_SEQUENCE_9_CRATE_SHADOW_TIMING_MACHINE_VALIDATION_REPORT.md') },
    [ordered]@{ name='sequence_10'; commit='b8378bc2e1e96642ff99eded436df65e2435cc9f'; paths=@('data/levels/key_route_commitment.json','tests/levels/task_0024z_key_route_commitment_validation.gd','docs/level_design/validation/sequence_10_key_route_commitment_validation.json','docs/reports/0024Z_SEQUENCE_10_KEY_ROUTE_COMMITMENT_MACHINE_VALIDATION_REPORT.md') },
    [ordered]@{ name='sequence_11'; commit='e6cd9fe76c19a144315b173b480ad5f9ccf2f115'; paths=@('data/levels/identity_shift_bridge.json','tests/levels/task_0024ab_identity_shift_bridge_validation.gd','docs/level_design/validation/sequence_11_identity_shift_bridge_validation_0024ab.json','docs/reports/0024AB_SEQUENCE_11_EVIDENCE_CAPTURE_CORRECTION_REPORT.md') },
    [ordered]@{ name='sequence_12'; commit='5843b851d7b63d8b0645c6a8550e2199694b17b1'; paths=@('data/levels/lasting_echo_latch.json','tests/levels/task_0024ac_lasting_echo_latch_validation.gd','docs/level_design/validation/sequence_12_lasting_echo_latch_validation.json','docs/reports/0024AC_SEQUENCE_12_LASTING_ECHO_LATCH_MACHINE_VALIDATION_REPORT.md') }
)
$acceptedMismatches = [Collections.Generic.List[object]]::new()
$acceptedHashes = [ordered]@{}
foreach ($set in $acceptedSets) {
    foreach ($relative in $set.paths) {
        $expectedBlob = (git -C $root rev-parse ('{0}:{1}' -f $set.commit, $relative)).Trim()
        $actualBlob = (git -C $root hash-object -- $relative).Trim()
        $acceptedHashes[$relative] = [ordered]@{ accepted_commit=$set.commit; sha256=(Get-FileHash -LiteralPath (Join-Path $root $relative) -Algorithm SHA256).Hash.ToLowerInvariant(); git_blob=$actualBlob }
        if ($expectedBlob -ne $actualBlob) { $acceptedMismatches.Add([ordered]@{ set=$set.name; path=$relative; expected_blob=$expectedBlob; actual_blob=$actualBlob }) }
    }
}
$acceptancePaths = @(
    'docs/reports/0024Y_GPT_SEQUENCE_9_CRATE_SHADOW_TIMING_MACHINE_VALIDATION_ACCEPTANCE.md',
    'docs/reports/0024Z_GPT_SEQUENCE_10_KEY_ROUTE_COMMITMENT_MACHINE_VALIDATION_ACCEPTANCE.md',
    'docs/reports/0024AB_GPT_SEQUENCE_11_IDENTITY_SHIFT_BRIDGE_CORRECTED_MACHINE_VALIDATION_ACCEPTANCE.md',
    'docs/reports/0024AC_GPT_SEQUENCE_12_LASTING_ECHO_LATCH_MACHINE_VALIDATION_ACCEPTANCE.md'
)
foreach ($acceptancePath in $acceptancePaths) {
    $actualBlob = (git -C $root hash-object -- $acceptancePath).Trim()
    $headBlob = (git -C $root rev-parse ('HEAD:{0}' -f $acceptancePath)).Trim()
    if ($actualBlob -ne $headBlob) { $acceptedMismatches.Add([ordered]@{ set='gpt_acceptance'; path=$acceptancePath; expected_blob=$headBlob; actual_blob=$actualBlob }) }
    $acceptedHashes[$acceptancePath] = [ordered]@{ accepted_commit=(git -C $root log -1 --format=%H -- $acceptancePath).Trim(); sha256=(Get-FileHash -LiteralPath (Join-Path $root $acceptancePath) -Algorithm SHA256).Hash.ToLowerInvariant(); git_blob=$actualBlob }
}

$historicalSets = @(
    [ordered]@{ name='0024AA'; commit='e2938b61a6207e970302675db8bb454c08c40cd3'; prefix='tests/tools/task_0024aa_*'; extra=@('tests/levels/task_0024aa_identity_shift_bridge_validation.gd','docs/level_design/validation/sequence_11_identity_shift_bridge_validation.json','docs/reports/0024AA_SEQUENCE_11_IDENTITY_SHIFT_BRIDGE_MACHINE_VALIDATION_REPORT.md') },
    [ordered]@{ name='0024AB'; commit='e6cd9fe76c19a144315b173b480ad5f9ccf2f115'; prefix='tests/tools/task_0024ab_*'; extra=@('tests/levels/task_0024ab_identity_shift_bridge_validation.gd','docs/level_design/validation/sequence_11_identity_shift_bridge_validation_0024ab.json','docs/reports/0024AB_SEQUENCE_11_EVIDENCE_CAPTURE_CORRECTION_REPORT.md') }
)
$historicalCounts = [ordered]@{}
$historicalMismatches = [Collections.Generic.List[object]]::new()
foreach ($set in $historicalSets) {
    $paths = @((git -C $root ls-tree -r --name-only $set.commit) | Where-Object { $_ -like $set.prefix }) + @($set.extra)
    $historicalCounts[$set.name] = $paths.Count
    foreach ($relative in $paths) {
        $expectedBlob = (git -C $root rev-parse ('{0}:{1}' -f $set.commit, $relative)).Trim()
        $actualBlob = (git -C $root hash-object -- $relative).Trim()
        if ($expectedBlob -ne $actualBlob) { $historicalMismatches.Add([ordered]@{ set=$set.name; path=$relative; expected_blob=$expectedBlob; actual_blob=$actualBlob }) }
    }
}

$frozenPaths = @(
    'data/catalog/level_catalog_v1.json',
    'data/levels/tutorial_reach_exit.json','data/levels/tutorial_echo_bridge.json','data/levels/vertical_slice_delay_3.json','data/levels/door_one_turn_late.json','data/levels/two_keys_one_door.json','data/levels/staggered_doors.json','data/levels/echo_spacing_bridge.json','data/levels/two_echo_convergence.json',
    'scripts/simulation/level_loader.gd','scripts/simulation/simulation.gd','scripts/solver/bfs_solver.gd',
    'schemas/level_v1.schema.json','schemas/level_v2.schema.json','schemas/catalog_v1.schema.json','docs/level_design/reference/turn_transition_vectors_v1.json','docs/level_design/reference/turn_transition_vectors_v2.json',
    'tests/tools/run_owned_godot_headless.ps1','tests/run_all.gd','tests/levels/task_0012_staggered_doors_validation.gd','tests/simulation/task_0024v_v2_solver_replay_canonical_malformed.gd',
    'scripts/app/app_root.gd','scripts/app/catalog_loader.gd','scripts/app/route_request.gd','scripts/app/memory_progress.gd','scripts/app/local_profile.gd','scripts/app/profile_progress_adapter.gd','scripts/app/profile_codec.gd',
    'scripts/gameplay/vertical_slice.gd','scenes/app/app_root.tscn','scenes/vertical_slice/vertical_slice.tscn','project.godot',
    'docs/reports/0024W_GPT_COMPLETE_CORE_MECHANICS_FOUNDATION_ACCEPTANCE.md','docs/reports/0024X_GPT_SUBMISSION_CORE_LEVELS_9_12_SCOPE_ACCEPTANCE.md'
)
$frozenHashes = [ordered]@{}
$frozenMismatches = [Collections.Generic.List[object]]::new()
foreach ($relative in $frozenPaths) {
    $headBlob = (git -C $root rev-parse ('HEAD:{0}' -f $relative)).Trim()
    $actualBlob = (git -C $root hash-object -- $relative).Trim()
    $frozenHashes[$relative] = [ordered]@{ sha256=(Get-FileHash -LiteralPath (Join-Path $root $relative) -Algorithm SHA256).Hash.ToLowerInvariant(); git_blob=$actualBlob }
    if ($headBlob -ne $actualBlob) { $frozenMismatches.Add([ordered]@{ path=$relative; expected_blob=$headBlob; actual_blob=$actualBlob }) }
}

$wrapperBlob = (git -C $root hash-object -- 'tests/tools/run_owned_godot_headless.ps1').Trim()
$status = if ($repositoryMismatches.Count -eq 0 -and $externalMismatches.Count -eq 0 -and $acceptedMismatches.Count -eq 0 -and $historicalMismatches.Count -eq 0 -and $frozenMismatches.Count -eq 0 -and $wrapperBlob -eq '5f14eb0feff903b40311c1c7283b20e2eabbffc2') { 'PASS' } else { 'DRIFT' }
$result = [ordered]@{
    schema_version=1; task='0024AD'; phase=$Phase; audited_utc=[DateTime]::UtcNow.ToString('o'); head=(git -C $root rev-parse HEAD).Trim()
    seal_path=$sealPath; seal_sha256=$sealHash; repository_file_count=$repositoryEntries.Count; repository_mismatch_count=$repositoryMismatches.Count; repository_mismatches=@($repositoryMismatches)
    historical_external_evidence_file_count=$externalEntries.Count; historical_external_evidence_mismatch_count=$externalMismatches.Count; historical_external_evidence_mismatches=@($externalMismatches)
    accepted_hashes=$acceptedHashes; accepted_mismatch_count=$acceptedMismatches.Count; accepted_mismatches=@($acceptedMismatches)
    historical_path_counts=$historicalCounts; historical_mismatch_count=$historicalMismatches.Count; historical_mismatches=@($historicalMismatches)
    frozen_hashes=$frozenHashes; frozen_mismatch_count=$frozenMismatches.Count; frozen_mismatches=@($frozenMismatches)
    wrapper_blob=$wrapperBlob; production_profile_accessed=$false; test_profile_root_accessed=$false; status=$status
}
[IO.File]::WriteAllText($output, ($result | ConvertTo-Json -Depth 100) + "`n", [Text.UTF8Encoding]::new($false))
Write-Output ("TASK_0024AD_FROZEN_HASH_AUDIT_" + $status + " " + $output)
if ($status -ne 'PASS') { exit 1 }
