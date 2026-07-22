[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$OutputPath,
    [ValidateSet('STATIC','PRE_FINAL','POST_FINAL')][string]$Phase = 'STATIC'
)

$ErrorActionPreference = 'Stop'
$root = 'D:\Delayed_Self'; $utf8 = [Text.UTF8Encoding]::new($false)
$output = [IO.Path]::GetFullPath((Join-Path $root $OutputPath))
if (Test-Path -LiteralPath $output) { throw "Qualification output already exists: $output" }
$errors = [Collections.Generic.List[string]]::new()
$productionPath = Join-Path $root 'data\catalog\level_catalog_v1.json'
$stagingPath = Join-Path $root 'tests\playtest\fixtures\task_0024ae_submission_core_staging_catalog.json'
$launcherPath = Join-Path $root 'tests\playtest\task_0024ae_submission_core_owner_review_launcher.gd'
$production = Get-Content -LiteralPath $productionPath -Raw | ConvertFrom-Json -Depth 50
$staging = Get-Content -LiteralPath $stagingPath -Raw | ConvertFrom-Json -Depth 50
$expectedIds = @('tutorial_reach_exit','tutorial_echo_bridge','vertical_slice_delay_3','door_one_turn_late','two_keys_one_door','staggered_doors','echo_spacing_bridge','two_echo_convergence','crate_shadow_timing','key_route_commitment','identity_shift_bridge','lasting_echo_latch')
$expectedPaths = @($expectedIds | ForEach-Object { "res://data/levels/$_.json" })
if ($staging.catalog_version -ne 1 -or @($staging.entries).Count -ne 12) { $errors.Add('staging_cardinality_or_version') }
$finals = @($staging.entries | Where-Object { $_.final_level })
if ($finals.Count -ne 1 -or $finals[0].level_id -ne 'lasting_echo_latch') { $errors.Add('staging_finale') }
$semanticDifferences = [Collections.Generic.List[object]]::new()
for ($index=0; $index -lt [Math]::Min(12,@($staging.entries).Count); $index++) {
    $entry = $staging.entries[$index]
    $expectedPrerequisite = if ($index -eq 0) { @() } else { @($expectedIds[$index-1]) }
    if ($entry.sequence -ne $index+1 -or $entry.level_id -ne $expectedIds[$index] -or $entry.level_path -ne $expectedPaths[$index] -or (@($entry.unlock_prerequisites) -join '|') -cne ($expectedPrerequisite -join '|')) { $errors.Add("entry_contract:$($index+1)") }
    if ($index -ge 8 -and ([string]::IsNullOrWhiteSpace([string]$entry.display_title_key) -or [string]::IsNullOrWhiteSpace([string]$entry.classification) -or [string]::IsNullOrWhiteSpace([string]$entry.hud_mode))) { $errors.Add("candidate_fields:$($index+1)") }
}
for ($index=0; $index -lt 8; $index++) {
    $prodJson = $production.entries[$index] | ConvertTo-Json -Compress -Depth 20
    $stageClone = $staging.entries[$index] | ConvertTo-Json -Depth 20 | ConvertFrom-Json -Depth 20
    if ($index -eq 7) { if ($stageClone.final_level -ne $false) { $errors.Add('sequence_8_not_demoted') }; $stageClone.final_level = $true; $semanticDifferences.Add([ordered]@{sequence=8;field='final_level';production=$true;staging=$false}) }
    $stageJson = $stageClone | ConvertTo-Json -Compress -Depth 20
    if ($prodJson -cne $stageJson) { $errors.Add("production_semantic_mismatch:$($index+1)") }
}
$launcher = Get-Content -LiteralPath $launcherPath -Raw
$tokens = [ordered]@{
    instantiate = 'AppRootScene.instantiate()'
    catalog = 'app.catalog_path = STAGING_CATALOG_PATH'
    configure = 'app.configure_test_profile(PROFILE_PATH)'
    add_tree = 'root.add_child(app)'
    canonical_profile = 'user://delayed_self_test_profiles/task_0024ae_owner_curriculum'
    canonical_catalog = 'res://tests/playtest/fixtures/task_0024ae_submission_core_staging_catalog.json'
}
foreach ($pair in $tokens.GetEnumerator()) { if (-not $launcher.Contains($pair.Value)) { $errors.Add("launcher_token:$($pair.Key)") } }
if ($launcher.IndexOf($tokens.instantiate,[StringComparison]::Ordinal) -ge $launcher.IndexOf($tokens.configure,[StringComparison]::Ordinal) -or $launcher.IndexOf($tokens.configure,[StringComparison]::Ordinal) -ge $launcher.IndexOf($tokens.add_tree,[StringComparison]::Ordinal)) { $errors.Add('launcher_pre_tree_order') }
foreach ($forbidden in @('configure_production_profile','user://delayed_self_profile.json','get_files(','get_directories(','DirAccess.open(','list_dir_begin(')) { if ($launcher.Contains($forbidden)) { $errors.Add("launcher_forbidden:$forbidden") } }
if (-not $launcher.Contains('owned_paths.size() != 25') -or -not $launcher.Contains('path.get_base_dir() != FIXTURE_DIRECTORY')) { $errors.Add('bounded_cleanup_inventory') }
$frozenPaths = @(
    'data/catalog/level_catalog_v1.json',
    ($expectedIds | ForEach-Object { "data/levels/$_.json" }),
    'scripts/app/app_root.gd','scripts/app/catalog_loader.gd','scripts/app/local_profile.gd','scripts/app/profile_progress_adapter.gd','scripts/app/memory_progress.gd','scripts/app/route_request.gd','scripts/gameplay/vertical_slice.gd','scenes/app/app_root.tscn','scenes/vertical_slice/vertical_slice.tscn','project.godot','tests/tools/run_owned_godot_headless.ps1','tests/curriculum/task_0024ad_submission_core_1_12_batch_validation.gd','tests/run_all.gd','tests/simulation/task_0024v_v2_solver_replay_canonical_malformed.gd',
    'docs/reports/0024Y_GPT_SEQUENCE_9_CRATE_SHADOW_TIMING_MACHINE_VALIDATION_ACCEPTANCE.md','docs/reports/0024Z_GPT_SEQUENCE_10_KEY_ROUTE_COMMITMENT_MACHINE_VALIDATION_ACCEPTANCE.md','docs/reports/0024AB_GPT_SEQUENCE_11_IDENTITY_SHIFT_BRIDGE_CORRECTED_MACHINE_VALIDATION_ACCEPTANCE.md','docs/reports/0024AC_GPT_SEQUENCE_12_LASTING_ECHO_LATCH_MACHINE_VALIDATION_ACCEPTANCE.md','docs/reports/0024AD_SUBMISSION_CORE_1_12_BATCH_REGRESSION_AND_OWNER_REVIEW_ROUTE_AUDIT_REPORT.md','docs/reports/0024AD_GPT_SUBMISSION_CORE_1_12_BATCH_REGRESSION_AND_OWNER_ROUTE_ACCEPTANCE.md'
)
$frozenPaths = @($frozenPaths | ForEach-Object { $_ })
$frozen = [ordered]@{}; $frozenMismatches = [Collections.Generic.List[object]]::new()
foreach ($relative in $frozenPaths) {
    $absolute = Join-Path $root $relative
    if (-not (Test-Path -LiteralPath $absolute -PathType Leaf)) { $frozenMismatches.Add([ordered]@{path=$relative;reason='MISSING'}); continue }
    $actualBlob = (git -C $root hash-object -- $relative).Trim(); $headBlob = (git -C $root rev-parse ('HEAD:{0}' -f $relative)).Trim()
    $sha = (Get-FileHash -LiteralPath $absolute -Algorithm SHA256).Hash.ToLowerInvariant(); $frozen[$relative]=[ordered]@{sha256=$sha;git_blob=$actualBlob}
    if ($actualBlob -ne $headBlob) { $frozenMismatches.Add([ordered]@{path=$relative;expected_blob=$headBlob;actual_blob=$actualBlob}) }
}
$adPaths = @((git -C $root ls-tree -r --name-only HEAD -- 'tests/tools/task_0024ad_*') | Where-Object { $_ })
$adMismatches = [Collections.Generic.List[object]]::new(); foreach($relative in $adPaths){$actual=(git -C $root hash-object -- $relative).Trim();$expected=(git -C $root rev-parse ('HEAD:{0}'-f$relative)).Trim();if($actual-ne$expected){$adMismatches.Add([ordered]@{path=$relative;expected_blob=$expected;actual_blob=$actual})}}
$statusLines = @(git -C $root status --porcelain=v1 --untracked-files=all)
$changedPaths = @($statusLines | ForEach-Object { ([string]$_).Substring(3).Replace('\','/') })
$allowPatterns = @(
    '^tests/playtest/task_0024ae_submission_core_owner_review_launcher\.gd(\.uid)?$','^tests/playtest/fixtures/task_0024ae_submission_core_staging_catalog\.json$','^tests/tools/task_0024ae_.*\.(ps1|json|py)$','^docs/playtest/SUBMISSION_CORE_1_12_OWNER_CURRICULUM_REVIEW_CURRENT\.md$','^docs/reports/0024AE_SUBMISSION_CORE_OWNER_REVIEW_ROUTE_REPORT\.md$','^docs/(CODEX_ACTIVE_TASK_CURRENT|CODEX_STARTUP_SNAPSHOT_CURRENT|DEVELOPMENT_PLAN_CURRENT|DOC_INDEX_CURRENT|HANDOFF_MASTER_CURRENT|project_memory)\.md$','^docs/production/EXPANDED_CONTENT_SUBMISSION_ROADMAP_CURRENT\.md$'
)
$unauthorized = @($changedPaths | Where-Object { $path=$_; -not @($allowPatterns | Where-Object { $path -match $_ }).Count })
if ($unauthorized.Count -ne 0) { $errors.Add('unauthorized_changed_paths') }
if ($frozenMismatches.Count -ne 0) { $errors.Add('frozen_hash_drift') }; if($adMismatches.Count-ne 0){$errors.Add('accepted_0024ad_drift')}
$wrapperBlob=(git -C $root hash-object -- 'tests/tools/run_owned_godot_headless.ps1').Trim();if($wrapperBlob-ne'5f14eb0feff903b40311c1c7283b20e2eabbffc2'){$errors.Add('wrapper_blob')}
$result=[ordered]@{schema_version=1;task='0024AE';phase=$Phase;status=if($errors.Count-eq 0){'PASS'}else{'FAIL'};audited_utc=[DateTime]::UtcNow.ToString('o');head=(git -C $root rev-parse HEAD).Trim();production_catalog_sha256=(Get-FileHash $productionPath -Algorithm SHA256).Hash.ToLowerInvariant();staging_catalog_sha256=(Get-FileHash $stagingPath -Algorithm SHA256).Hash.ToLowerInvariant();staging_entry_count=@($staging.entries).Count;staging_final_count=$finals.Count;staging_final_id=$finals[0].level_id;semantic_differences=@($semanticDifferences);launcher_sha256=(Get-FileHash $launcherPath -Algorithm SHA256).Hash.ToLowerInvariant();launcher_pre_tree_order=$true;production_profile_probe_count=0;test_profile_root_enumeration_count=0;frozen_hashes=$frozen;frozen_mismatch_count=$frozenMismatches.Count;frozen_mismatches=@($frozenMismatches);accepted_0024ad_path_count=$adPaths.Count;accepted_0024ad_mismatch_count=$adMismatches.Count;accepted_0024ad_mismatches=@($adMismatches);wrapper_blob=$wrapperBlob;changed_paths=$changedPaths;unauthorized_changed_paths=$unauthorized;errors=@($errors)}
[IO.File]::WriteAllText($output,($result|ConvertTo-Json -Depth 100)+"`n",$utf8)
Write-Output ('TASK_0024AE_STATIC_QUALIFICATION_'+$result.status+' '+$output)
if($errors.Count-ne 0){exit 1}
