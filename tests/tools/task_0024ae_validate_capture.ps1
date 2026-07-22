[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$RecordPath,
    [Parameter(Mandatory)][string]$OutputPath,
    [ValidateSet('QUALIFICATION','FINAL')][string]$Phase = 'QUALIFICATION'
)

$ErrorActionPreference = 'Stop'
$root = 'D:\Delayed_Self'; $utf8 = [Text.UTF8Encoding]::new($false)
$recordFile = [IO.Path]::GetFullPath((Join-Path $root $RecordPath)); $outputFile = [IO.Path]::GetFullPath((Join-Path $root $OutputPath))
if (Test-Path -LiteralPath $outputFile) { throw "Output already exists: $outputFile" }
$record = Get-Content -LiteralPath $recordFile -Raw | ConvertFrom-Json -Depth 100
$manifest = Get-Content -LiteralPath (Join-Path $root 'tests\tools\task_0024ae_owner_review_route_manifest.json') -Raw | ConvertFrom-Json -Depth 50
$expected = [ordered]@{}; foreach ($property in $manifest.expected_records.PSObject.Properties) { $expected[$property.Name] = [int]$property.Value }
$errors = [Collections.Generic.List[string]]::new(); $retained = [Collections.Generic.List[object]]::new(); $payloads = [ordered]@{}
foreach ($prefix in $expected.Keys) { $payloads[$prefix] = [Collections.Generic.List[object]]::new() }
foreach ($line in @($record.stdout)) {
    foreach ($prefix in $expected.Keys) {
        $leader = $prefix + ' '
        if (-not ([string]$line).StartsWith($leader, [StringComparison]::Ordinal)) { continue }
        $bytes = [Text.Encoding]::UTF8.GetByteCount([string]$line)
        if ($bytes -ge 1800) { $errors.Add("over_bound:$prefix`:$bytes") }
        try { $payload = ([string]$line).Substring($leader.Length) | ConvertFrom-Json -Depth 100 } catch { $errors.Add("non_json_or_truncated:$prefix"); $payload = $null }
        if ($null -ne $payload) { $payloads[$prefix].Add($payload) }
        $retained.Add([ordered]@{prefix=$prefix;utf8_bytes=$bytes;raw_line=[string]$line;payload=$payload}); break
    }
}
foreach ($prefix in $expected.Keys) { if ($payloads[$prefix].Count -ne $expected[$prefix]) { $errors.Add("count:$prefix`:$($payloads[$prefix].Count)/$($expected[$prefix])") } }
$markerCount = @($record.stdout | Where-Object { $_ -ceq [string]$manifest.marker }).Count
if ($markerCount -ne 1) { $errors.Add("marker_count:$markerCount") }
if (-not $record.marker_pass -or $record.native_exit_code -ne 0 -or $record.status -ne 'PASS') { $errors.Add('wrapper_or_native_status') }
if (@($record.stderr).Count -ne 0) { $errors.Add('stderr_nonempty') }
if ($record.cleanup_invocation_count -ne 1) { $errors.Add('cleanup_count') }
if (@($record.remaining_owned_pids).Count -ne 0 -or @($record.remaining_unproven_pids).Count -ne 0) { $errors.Add('pid_residue') }
if ($record.godot_before_count -ne 0 -or $record.godot_after_count -ne 0) { $errors.Add('godot_boundary') }
if ($payloads.TASK_0024AE_CONFIGURATION_JSON.Count -eq 1) { $p=$payloads.TASK_0024AE_CONFIGURATION_JSON[0]; if($p.mode-ne'TEST_PROFILE' -or $p.write_authorized -or $p.boot_status-ne'TEST_PROFILE_READY' -or $p.load_status-ne'MISSING_CLEAN' -or -not $p.configured_before_tree){$errors.Add('configuration_contract')} }
if ($payloads.TASK_0024AE_CATALOG_JSON.Count -eq 1) { $p=$payloads.TASK_0024AE_CATALOG_JSON[0]; if($p.entry_count-ne 12 -or $p.ordered_ids.Count-ne 12 -or $p.sole_finale-ne'lasting_echo_latch' -or $p.sequence_8_staging_final){$errors.Add('catalog_contract')} }
if ($payloads.TASK_0024AE_ROUTE_JSON.Count -eq 12) {
    $ids=@('tutorial_reach_exit','tutorial_echo_bridge','vertical_slice_delay_3','door_one_turn_late','two_keys_one_door','staggered_doors','echo_spacing_bridge','two_echo_convergence','crate_shadow_timing','key_route_commitment','identity_shift_bridge','lasting_echo_latch'); $turns=@(3,9,9,9,12,15,16,19,14,19,18,21)
    for($i=0;$i-lt 12;$i++){ $p=$payloads.TASK_0024AE_ROUTE_JSON[$i]; if($p.sequence-ne($i+1)-or$p.level_id-ne$ids[$i]-or$p.turns-ne$turns[$i]-or$p.development_direct-or$p.completed_count-ne($i+1)-or$p.unlocked_count-ne[Math]::Min($i+2,12)-or$p.route_after-ne $(if($i-eq 11){'GAMEPLAY'}else{'LEVEL_SELECT'})){ $errors.Add("route_contract:$($i+1)") } }
}
if ($payloads.TASK_0024AE_FINALE_JSON.Count -eq 1) { $p=$payloads.TASK_0024AE_FINALE_JSON[0]; if(-not$p.acknowledgement_visible-or$p.sequence_13_unlocked-or-not$p.staging_only-or$p.current_route-ne'GAMEPLAY'){$errors.Add('finale_contract')} }
if ($payloads.TASK_0024AE_RELOAD_JSON.Count -eq 1) { $p=$payloads.TASK_0024AE_RELOAD_JSON[0]; if($p.load_status-ne'LOADED'-or$p.completed_count-ne 12-or$p.best_turn_count-ne 12-or$p.unlocked_count-ne 12-or-not$p.exact_turns){$errors.Add('reload_contract')} }
if ($payloads.TASK_0024AE_BOUNDARY_JSON.Count -eq 1) { $p=$payloads.TASK_0024AE_BOUNDARY_JSON[0]; if($p.owned_path_count-ne 25-or$p.production_data_probe_count-ne 0-or$p.test_root_enumeration_count-ne 0-or$p.production_write_authorized-or$p.catalog_admission_status-ne'NOT_AUTHORIZED'-or$p.presentation_readiness-ne'BLOCKED_SCHEMA_V2_VISUALS'){$errors.Add('boundary_contract')} }
if ($payloads.TASK_0024AE_CLEANUP_JSON.Count -eq 1) { $p=$payloads.TASK_0024AE_CLEANUP_JSON[0]; if($p.exact_owned_path_count-ne 25-or-not$p.all_exact_owned_paths_absent-or-not$p.fixture_directory_absent-or$p.broad_enumeration_used-or$p.production_data_probe_count-ne 0){$errors.Add('cleanup_contract')} }
$maximumBytes=0;foreach($item in $retained){$maximumBytes=[Math]::Max($maximumBytes,[int]$item.utf8_bytes)}
$result=[ordered]@{schema_version=1;task='0024AE';phase=$Phase;status=if($errors.Count-eq 0){'PASS'}else{'FAIL'};source_record=$RecordPath.Replace('\','/');source_record_sha256=(Get-FileHash $recordFile -Algorithm SHA256).Hash.ToLowerInvariant();expected_counts=$expected;observed_counts=[ordered]@{};marker_count=$markerCount;record_count=$retained.Count;maximum_utf8_bytes=$maximumBytes;records=@($retained);wrapper=[ordered]@{status=$record.status;native_exit_code=$record.native_exit_code;cleanup_invocation_count=$record.cleanup_invocation_count;cleanup_order=@($record.cleanup_order);remaining_owned_pids=@($record.remaining_owned_pids);remaining_unproven_pids=@($record.remaining_unproven_pids);godot_before_count=$record.godot_before_count;godot_after_count=$record.godot_after_count;stderr=@($record.stderr)};errors=@($errors)}
foreach($prefix in $expected.Keys){$result.observed_counts[$prefix]=$payloads[$prefix].Count}
[IO.File]::WriteAllText($outputFile,($result|ConvertTo-Json -Depth 100)+"`n",$utf8)
Write-Output ('TASK_0024AE_CAPTURE_'+$result.status+' '+$outputFile)
if($errors.Count-ne 0){exit 1}
