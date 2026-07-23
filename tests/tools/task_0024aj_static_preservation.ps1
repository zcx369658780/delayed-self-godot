[CmdletBinding()]param([string]$RepositoryRoot=(Resolve-Path (Join-Path $PSScriptRoot '..\\..')).Path,[ValidateSet('PRE_FINAL','POST_FINAL')][string]$Phase='PRE_FINAL',[Parameter(Mandatory)][string]$ExpectedConfigSha256)
Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'
$baseline='2df29272b4c1696063aae00ed8e796e28f4f5929'
$taskStartHead=(git -C $RepositoryRoot rev-parse HEAD).Trim()
$allowed=@(
 'scripts/gameplay/schema_v2_presentation.gd','scripts/gameplay/vertical_slice.gd',
 'tests/presentation/task_0024aj_sensor_contract_and_dynamic_signature_validation.gd','tests/presentation/task_0024aj_sensor_contract_and_dynamic_signature_validation.gd.uid',
 'docs/presentation/SCHEMA_V2_MINIMUM_OWNER_REVIEW_VISUAL_CONTRACT_CURRENT.md','docs/playtest/SUBMISSION_CORE_1_12_OWNER_CURRICULUM_REVIEW_CURRENT.md','docs/reports/0024AJ_SENSOR_CONTRACT_AND_DYNAMIC_SCHEMA_V2_VISUAL_VALIDATION_REPORT.md',
 'docs/CODEX_ACTIVE_TASK_CURRENT.md','docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md','docs/DEVELOPMENT_PLAN_CURRENT.md','docs/DOC_INDEX_CURRENT.md','docs/HANDOFF_MASTER_CURRENT.md','docs/project_memory.md','docs/production/EXPANDED_CONTENT_SUBMISSION_ROADMAP_CURRENT.md')
$changed=@(git -C $RepositoryRoot status --porcelain=v1 --untracked-files=all|ForEach-Object{$_.Substring(3).Replace('\\','/')}|Where-Object{$_ -ne '.codex/config.toml'})
$bad=@($changed|Where-Object{$_ -notin $allowed -and $_ -notlike 'tests/tools/task_0024aj_*'})
$historical=@(git -C $RepositoryRoot ls-files 'tests/presentation/task_0024af_*' 'tests/presentation/task_0024ag_*' 'tests/presentation/task_0024ah_*' 'tests/presentation/task_0024ai_*' 'tests/tools/task_0024af_*' 'tests/tools/task_0024ag_*' 'tests/tools/task_0024ah_*' 'tests/tools/task_0024ai_*' 'docs/reports/0024AF*' 'docs/reports/0024AG*' 'docs/reports/0024AH*' 'docs/reports/0024AI*' 'tasks/0024AF*' 'tasks/0024AG*' 'tasks/0024AH*' 'tasks/0024AI*')
$history=foreach($p in $historical){
 $expected=(git -C $RepositoryRoot rev-parse "$taskStartHead`:$p").Trim()
 [ordered]@{path=$p;expected_sha256=$expected;current_sha256=(git -C $RepositoryRoot hash-object -- $p);comparison_method='task_start_head_historical_immutability';comparison_ref=$taskStartHead}
}
$presentation=@('scripts/gameplay/schema_v2_presentation.gd','scripts/gameplay/vertical_slice.gd')|ForEach-Object{[ordered]@{path=$_;baseline_sha256=(git -C $RepositoryRoot rev-parse "$baseline`:$($_)").Trim();current_sha256=(git -C $RepositoryRoot hash-object -- $_)}}
$frozen=@(git -C $RepositoryRoot ls-files 'project.godot' 'scenes/**' 'data/catalog/**' 'data/levels/**' 'scripts/app/**' 'scripts/simulation/**' 'scripts/solver/**' 'scripts/gameplay/*.gd' 'schemas/**' 'tests/run_all.gd' 'tests/simulation/**' 'tests/levels/**' 'tests/curriculum/**' 'tests/playtest/**' 'tests/tools/run_owned_godot_headless.ps1')
$frozenInventory=foreach($p in $frozen){[ordered]@{path=$p;baseline_sha256=(git -C $RepositoryRoot rev-parse "$baseline`:$p").Trim();current_sha256=(git -C $RepositoryRoot hash-object -- $p)}}
$profileSafe=@($frozenInventory|Where-Object{$_.path -like 'scripts/app/*' -or $_.path -like '*profile*'})
$helperPath=Join-Path $RepositoryRoot 'scripts\gameplay\schema_v2_presentation.gd'
$helperForbidden=@('LevelLoader','load_file','FileAccess','DirAccess','user://','Profile','transition(','restart(','catalog')
$helperHits=@(Select-String -LiteralPath $helperPath -Pattern $helperForbidden -SimpleMatch -ErrorAction Stop|ForEach-Object{$_.Pattern})
$verticalPath=Join-Path $RepositoryRoot 'scripts\gameplay\vertical_slice.gd'; $verticalSource=Get-Content -Raw -LiteralPath $verticalPath
$drawStart=$verticalSource.IndexOf('func _draw() -> void:'); if($drawStart -lt 0){throw 'TASK_0024AJ_DRAW_FUNCTION_MISSING'}; $drawSource=$verticalSource.Substring($drawStart)
$schemaSource=Get-Content -Raw -LiteralPath $helperPath
$renderOrder=@{draw_start=$drawStart;terrain=$drawSource.IndexOf('for y in level.terrain_rows.size()');underlay=$drawSource.IndexOf('_draw_schema_v2_descriptors(false)');plates=$drawSource.IndexOf('for plate in level.plates');doors=$drawSource.IndexOf('for door in level.doors');echo_loop=$drawSource.IndexOf('for echo in state.echo_positions');player=$drawSource.IndexOf('draw_circle(_center(state.player_position), 15');tokens_inventory=$drawSource.IndexOf('_draw_schema_v2_descriptors(true)');schema_sensor_layer1=$schemaSource.IndexOf('sensor.position, 1');schema_crate_layer2=$schemaSource.IndexOf('crate.position, 2')}
$renderOrderPass=$renderOrder.terrain -ge 0 -and $renderOrder.underlay -gt $renderOrder.terrain -and $renderOrder.doors -gt $renderOrder.underlay -and $renderOrder.plates -gt $renderOrder.doors -and $renderOrder.echo_loop -gt $renderOrder.plates -and $renderOrder.player -gt $renderOrder.echo_loop -and $renderOrder.tokens_inventory -gt $renderOrder.player -and $renderOrder.schema_sensor_layer1 -ge 0 -and $renderOrder.schema_crate_layer2 -ge 0
$config=@(git -C $RepositoryRoot status --short --untracked-files=all -- '.codex/config.toml')
$configPath=Join-Path $RepositoryRoot '.codex\config.toml'; if(-not(Test-Path -LiteralPath $configPath -PathType Leaf)){throw 'TASK_0024AJ_CONFIG_MISSING'}
$configSha256=(Get-FileHash -LiteralPath $configPath -Algorithm SHA256).Hash.ToLowerInvariant()
$configExpected=$ExpectedConfigSha256.ToLowerInvariant()
$result=[ordered]@{schema_version=1;phase=$Phase;baseline=$baseline;task_start_head=$taskStartHead;changed_paths=@($changed);unauthorized_changed_paths=@($bad);historical=@($history);presentation=@($presentation);frozen_inventory=@($frozenInventory);profile_safe_hash_inventory=@($profileSafe);helper_forbidden_api_hits=@($helperHits);actual_vertical_slice_render_order=$renderOrder;render_order_pass=$renderOrderPass;config_sha256_input=$configExpected;config_sha256_actual=$configSha256;config_untracked=($config.Count -eq 1 -and $config[0] -like '?? *');status='PASS'}
if($bad.Count -or @($history|Where-Object{$_.expected_sha256 -ne $_.current_sha256}).Count -or @($presentation|Where-Object{$_.baseline_sha256 -ne $_.current_sha256}).Count -or @($frozenInventory|Where-Object{$_.baseline_sha256 -ne $_.current_sha256}).Count -or $helperHits.Count -or -not $renderOrderPass -or $configExpected -ne $configSha256 -or -not $result.config_untracked){$result.status='FAIL';$result|ConvertTo-Json -Depth 30 -Compress;exit 1};$result|ConvertTo-Json -Depth 30 -Compress
