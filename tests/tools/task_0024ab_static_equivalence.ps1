[CmdletBinding()]
param([Parameter(Mandatory)][string]$OutputPath)

$ErrorActionPreference = 'Stop'
$root = 'D:\Delayed_Self'
$oldPath = Join-Path $root 'tests\levels\task_0024aa_identity_shift_bridge_validation.gd'
$newPath = Join-Path $root 'tests\levels\task_0024ab_identity_shift_bridge_validation.gd'
$candidatePath = Join-Path $root 'data\levels\identity_shift_bridge.json'
$historicalCommit = 'e2938b61a6207e970302675db8bb454c08c40cd3'
$expectedOldSha = 'bff20626fb4830f4a8fed2e3b7f4b485a172d443db358978d1d1eeafeebc5a82'
$expectedCandidateSha = '8856d3c64978cef7cff7f1680a7ae2f412c9b0cab058d598cbe3aee0225052e0'
$allowedNewFunctions = @('_emit_bounded_records','_compact_control','_compact_any_control','_compact_geometry_control','_emit_record')

function Get-Functions([string]$Source) {
    $result = [ordered]@{}
    foreach ($match in [regex]::Matches($Source, '(?ms)^func\s+([A-Za-z0-9_]+)\([^\r\n]*\).*?(?=^func\s+|\z)')) {
        $result[$match.Groups[1].Value] = $match.Value.TrimEnd("`r", "`n")
    }
    return $result
}

function Normalize-TaskMarker([string]$Text) { return $Text.Replace('TASK_0024AB', 'TASK_0024AA') }

$oldSource = Get-Content -LiteralPath $oldPath -Raw
$newSource = Get-Content -LiteralPath $newPath -Raw
$oldFunctions = Get-Functions $oldSource
$newFunctions = Get-Functions $newSource
$errors = [Collections.Generic.List[string]]::new()

$oldSha = (Get-FileHash -LiteralPath $oldPath -Algorithm SHA256).Hash.ToLowerInvariant()
$candidateSha = (Get-FileHash -LiteralPath $candidatePath -Algorithm SHA256).Hash.ToLowerInvariant()
if ($oldSha -ne $expectedOldSha) { $errors.Add('historical_validator_sha256') }
if ($candidateSha -ne $expectedCandidateSha) { $errors.Add('candidate_sha256') }

$oldSemanticNames = @($oldFunctions.Keys | Where-Object { $_ -ne '_init' } | Sort-Object)
$newSemanticNames = @($newFunctions.Keys | Where-Object { $_ -ne '_init' -and $_ -notin $allowedNewFunctions } | Sort-Object)
if (($oldSemanticNames -join '|') -ne ($newSemanticNames -join '|')) { $errors.Add('semantic_function_name_set') }
$functionMismatches = [Collections.Generic.List[string]]::new()
foreach ($name in $oldSemanticNames) {
    if (-not $newFunctions.Contains($name) -or (Normalize-TaskMarker $newFunctions[$name]) -cne $oldFunctions[$name]) { $functionMismatches.Add($name) }
}
if ($functionMismatches.Count -ne 0) { $errors.Add('semantic_function_bodies') }

$extraFunctions = @($newFunctions.Keys | Where-Object { -not $oldFunctions.Contains($_) } | Sort-Object)
if (($extraFunctions -join '|') -ne (($allowedNewFunctions | Sort-Object) -join '|')) { $errors.Add('extra_function_allowlist') }

$oldInit = $oldFunctions['_init']
$newInit = $newFunctions['_init']
$initChecks = [ordered]@{
    run_call_preserved = $oldInit.Contains("`t_run()") -and $newInit.Contains("`t_run()")
    failure_branch_preserved = $oldInit.Contains('if failures > 0:') -and $newInit.Contains('if failures > 0:') -and $newInit.Contains('TASK_0024AB_IDENTITY_SHIFT_BRIDGE_FAIL') -and $newInit.Contains("`t`tquit(1)")
    bounded_emitter_used = $newInit.Contains('_emit_bounded_records()')
    old_monolithic_prefix_absent = -not $newSource.Contains('TASK_0024AB_RESULT_JSON') -and -not $newSource.Contains('TASK_0024AB_CONTROL_JSON')
    pass_marker_preserved = $newInit.Contains('TASK_0024AB_IDENTITY_SHIFT_BRIDGE_PASS') -and $newInit.Contains("`tquit(0)")
}
foreach ($property in $initChecks.GetEnumerator()) { if (-not $property.Value) { $errors.Add("init_$($property.Key)") } }

$constantChecks = [ordered]@{}
foreach ($name in @('ACTIONS','LIMITS','FULL_MASK')) {
    $oldLine = [regex]::Match($oldSource, "(?m)^const $name := .+$").Value.TrimEnd("`r")
    $newLine = [regex]::Match($newSource, "(?m)^const $name := .+$").Value.TrimEnd("`r")
    $constantChecks[$name] = $oldLine -cne '' -and $oldLine -ceq $newLine
    if (-not $constantChecks[$name]) { $errors.Add("constant_$name") }
}

$candidateLiteral = 'res://data/levels/identity_shift_bridge.json'
$candidateChecks = [ordered]@{ old_count = ([regex]::Matches($oldSource, [regex]::Escape($candidateLiteral))).Count; new_count = ([regex]::Matches($newSource, [regex]::Escape($candidateLiteral))).Count }
if ($candidateChecks.old_count -ne 1 -or $candidateChecks.new_count -ne 1) { $errors.Add('candidate_path') }

$labelPattern = '_require\([^\r\n]*?,\s*"([^"]+)"\)'
$oldLabels = @([regex]::Matches($oldSource, $labelPattern) | ForEach-Object { $_.Groups[1].Value } | Sort-Object)
$newLabels = @([regex]::Matches($newSource, $labelPattern) | ForEach-Object { $_.Groups[1].Value } | Sort-Object)
if (($oldLabels -join '|') -ne ($newLabels -join '|')) { $errors.Add('assertion_label_set') }

$boundedPrefixes = @('TASK_0024AB_METRICS_JSON','TASK_0024AB_WITNESS_JSON','TASK_0024AB_EVENT_JSON','TASK_0024AB_ALL_SHORTEST_JSON','TASK_0024AB_CONTROL_IDENTITY_JSON','TASK_0024AB_CONTROL_GEOMETRY_JSON','TASK_0024AB_SHORTCUTS_JSON','TASK_0024AB_REPLAY_RESTART_JSON')
$missingPrefixes = @($boundedPrefixes | Where-Object { -not $newSource.Contains($_) })
if ($missingPrefixes.Count -ne 0) { $errors.Add('bounded_prefix_set') }

$historicalPaths = @((git -C $root ls-tree -r --name-only $historicalCommit) | Where-Object { $_ -like 'tests/tools/task_0024aa_*' }) + @('data/levels/identity_shift_bridge.json','tests/levels/task_0024aa_identity_shift_bridge_validation.gd','docs/level_design/validation/sequence_11_identity_shift_bridge_validation.json','docs/reports/0024AA_SEQUENCE_11_IDENTITY_SHIFT_BRIDGE_MACHINE_VALIDATION_REPORT.md')
$historicalMismatches = [Collections.Generic.List[string]]::new()
foreach ($relative in $historicalPaths) {
    $expectedBlob = (git -C $root rev-parse "$historicalCommit`:$relative").Trim()
    $actualBlob = (git -C $root hash-object -- $relative).Trim()
    if ($expectedBlob -ne $actualBlob) { $historicalMismatches.Add($relative) }
}
if ($historicalMismatches.Count -ne 0) { $errors.Add('historical_byte_identity') }

$selfSource = Get-Content -LiteralPath $MyInvocation.MyCommand.Path -Raw
$dynamicHeadToken = 'rev-parse ' + 'HEAD'
$dynamicHeadAbsent = -not $selfSource.Contains($dynamicHeadToken)
if (-not $dynamicHeadAbsent) { $errors.Add('dynamic_head_baseline') }

$result = [ordered]@{
    schema_version = 1
    task = '0024AB'
    status = if ($errors.Count -eq 0) { 'PASS' } else { 'FAIL' }
    historical_commit = $historicalCommit
    candidate_sha256 = $candidateSha
    historical_validator_sha256 = $oldSha
    semantic_function_count = $oldSemanticNames.Count
    semantic_function_mismatches = @($functionMismatches)
    extra_output_function_names = $extraFunctions
    assertion_label_count = $oldLabels.Count
    assertion_labels_exact = (($oldLabels -join '|') -eq ($newLabels -join '|'))
    constant_checks = $constantChecks
    candidate_path_checks = $candidateChecks
    init_checks = $initChecks
    bounded_prefixes = $boundedPrefixes
    missing_bounded_prefixes = $missingPrefixes
    historical_path_count = $historicalPaths.Count
    historical_mismatches = @($historicalMismatches)
    dynamic_head_baseline_absent = $dynamicHeadAbsent
    errors = @($errors)
}
$output = [IO.Path]::GetFullPath((Join-Path $root $OutputPath))
if (Test-Path -LiteralPath $output) { throw "Output already exists: $output" }
[IO.File]::WriteAllText($output, ($result | ConvertTo-Json -Depth 12) + "`n", [Text.UTF8Encoding]::new($false))
Write-Output ("TASK_0024AB_STATIC_EQUIVALENCE_" + $result.status + " " + $output)
if ($errors.Count -ne 0) { exit 1 }
