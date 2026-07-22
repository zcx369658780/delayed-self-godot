[CmdletBinding()]
param([string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path)

$ErrorActionPreference = 'Stop'
$PSNativeCommandUseErrorActionPreference = $false
$maximumOutputBytes = 65536
$manifestPath = Join-Path $RepoRoot 'tests\tools\task_0024w_core_mechanics_final_validation_manifest.json'
$driverPath = Join-Path $RepoRoot 'tests\tools\task_0024w_core_mechanics_final_validation_driver.ps1'
$qualificationPath = Join-Path $RepoRoot 'tests\tools\task_0024w_driver_precondition_and_record_qualification.ps1'
$qualificationSummaryPath = Join-Path $RepoRoot 'tests\tools\task_0024w_driver_precondition_and_record_qualification_summary.json'
$evidenceBase = 'D:\Delayed_Self_Evidence'

function Assert-True([bool]$Condition, [string]$Message) {
    if (-not $Condition) { throw $Message }
}

function Get-Sha256([string]$Path) {
    return (Get-FileHash -Algorithm SHA256 -LiteralPath $Path).Hash.ToLowerInvariant()
}

function Get-GodotCount {
    return @(Get-CimInstance Win32_Process | Where-Object { $_.Name -like 'godot*' }).Count
}

function Assert-HashMap($Properties, [string]$BasePath) {
    $count = 0
    foreach ($property in $Properties) {
        $path = Join-Path $BasePath ($property.Name.Replace('/', '\'))
        Assert-True (Test-Path -LiteralPath $path -PathType Leaf) "Hash-bound file missing: $($property.Name)"
        Assert-True ((Get-Sha256 $path) -ceq ([string]$property.Value).ToLowerInvariant()) "Hash drift: $($property.Name)"
        $count++
    }
    return $count
}

function Get-DriverProcessAudit([string]$SourceText) {
    $tokens = $null
    $errors = $null
    $ast = [Management.Automation.Language.Parser]::ParseInput($SourceText,[ref]$tokens,[ref]$errors)
    Assert-True ($errors.Count -eq 0) 'Driver PowerShell parse failure'
    $comparisonTokens = @('-eq','-ne','-ceq','-cne','-gt','-ge','-lt','-le')
    $badCommands = @($ast.FindAll({
        param($node)
        if ($node -isnot [Management.Automation.Language.CommandAst]) { return $false }
        if ($node.GetCommandName() -cne 'Get-GodotCount') { return $false }
        return @($node.CommandElements | Where-Object { $comparisonTokens -contains $_.Extent.Text.ToLowerInvariant() }).Count -gt 0
    },$true))
    $assigned = [Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
    foreach ($assignment in @($ast.FindAll({ param($node) $node -is [Management.Automation.Language.AssignmentStatementAst] },$true))) {
        if ($assignment.Left -isnot [Management.Automation.Language.VariableExpressionAst]) { continue }
        $calls = @($assignment.Right.FindAll({ param($node) $node -is [Management.Automation.Language.CommandAst] -and $node.GetCommandName() -ceq 'Get-GodotCount' },$true))
        if ($calls.Count -eq 1 -and $calls[0].CommandElements.Count -eq 1) { [void]$assigned.Add($assignment.Left.VariablePath.UserPath) }
    }
    $compared = [Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
    foreach ($binary in @($ast.FindAll({ param($node) $node -is [Management.Automation.Language.BinaryExpressionAst] },$true))) {
        if ($binary.Left -is [Management.Automation.Language.VariableExpressionAst] -and $assigned.Contains($binary.Left.VariablePath.UserPath) -and $binary.Right.Extent.Text -ceq '0') {
            [void]$compared.Add($binary.Left.VariablePath.UserPath)
        }
    }
    $paired = $assigned.Count -eq $compared.Count
    if ($paired) { foreach ($name in $assigned) { if (-not $compared.Contains($name)) { $paired = $false } } }
    return [pscustomobject]@{ bad_commands=$badCommands.Count; assignments=$assigned.Count; comparisons=$compared.Count; paired=$paired }
}

$initialGodot = Get-GodotCount
Assert-True ($initialGodot -eq 0) 'Godot process exists before static validation'
Assert-True ((Resolve-Path -LiteralPath $RepoRoot).Path -ceq 'D:\Delayed_Self') 'Repository root mismatch'
foreach ($path in @($manifestPath,$driverPath,$qualificationPath,$qualificationSummaryPath)) {
    Assert-True (Test-Path -LiteralPath $path -PathType Leaf) "Task 0024W artifact missing: $path"
}
$manifest = Get-Content -Raw -LiteralPath $manifestPath | ConvertFrom-Json -Depth 60
Assert-True ($manifest.schema_version -eq 3 -and $manifest.task_id -ceq '0024W') 'Manifest identity mismatch'
Assert-True ($manifest.accepted_checkpoint -ceq '3058c03537361ab28e015c6a8a0b244b23db1d37') 'Accepted checkpoint mismatch'
Assert-True ($manifest.fixed_source_commit -ceq '5cd82fbc742bfe2664ea0b0b0df6d48bc8dd717a') 'Fixed source commit mismatch'
Assert-True ($manifest.wrapper.path -ceq 'tests/tools/run_owned_godot_headless.ps1' -and $manifest.wrapper.blob -ceq '5f14eb0feff903b40311c1c7283b20e2eabbffc2') 'Wrapper identity mismatch'
Assert-True (@($manifest.wrapper.extra_arguments).Count -eq 0 -and @($manifest.wrapper.allowed_godot_descendant_tokens).Count -eq 0) 'Wrapper argument contract mismatch'

$expectedCases = @(
    [pscustomobject]@{ id='aggregate_v1_formal_regression'; script='res://tests/run_all.gd'; marker='TASK_0003_TESTS_PASS'; exact='TASK_0003_TESTS_PASS assertions=621 vectors=9'; policy='Allow'; allow=@('LEVEL_ID_MISMATCH'); timeout=600 },
    [pscustomobject]@{ id='task_0012_standalone_regression'; script='res://tests/levels/task_0012_staggered_doors_validation.gd'; marker='TASK_0012_FOCUSED_PASS'; exact='TASK_0012_FOCUSED_PASS'; policy='ForbidNonempty'; allow=@(); timeout=600 },
    [pscustomobject]@{ id='v2_focused_foundation'; script='res://tests/simulation/task_0023zx_core_mechanics_foundation.gd'; marker='TASK_0023ZX_PASS'; exact='TASK_0023ZX_PASS'; policy='ForbidNonempty'; allow=@(); timeout=120 },
    [pscustomobject]@{ id='v2_complete_solver_replay_canonical_malformed'; script='res://tests/simulation/task_0024v_v2_solver_replay_canonical_malformed.gd'; marker='TASK_0024V_V2_COMPLETE_PASS'; exact='TASK_0024V_V2_COMPLETE_PASS'; policy='ForbidNonempty'; allow=@(); timeout=300 }
)
Assert-True (@($manifest.cases).Count -eq 4) 'Manifest case count mismatch'
for ($index=0; $index -lt 4; $index++) {
    $actual=$manifest.cases[$index]; $expected=$expectedCases[$index]
    Assert-True ($actual.id -ceq $expected.id -and $actual.script -ceq $expected.script) "Case identity mismatch at $index"
    Assert-True ($actual.required_marker -ceq $expected.marker -and $actual.exact_marker -ceq $expected.exact) "Case marker mismatch at $index"
    Assert-True ($actual.expected_native_exit -eq 0 -and $actual.stderr_policy -ceq $expected.policy -and $actual.timeout_seconds -eq $expected.timeout) "Case policy mismatch at $index"
    Assert-True (@($actual.stderr_allowlist).Count -eq @($expected.allow).Count) "Case allowlist count mismatch at $index"
    if (@($expected.allow).Count -eq 1) { Assert-True ($actual.stderr_allowlist[0] -ceq $expected.allow[0]) "Case allowlist mismatch at $index" }
    $scriptPath = Join-Path $RepoRoot ($actual.script.Substring(6).Replace('/','\'))
    Assert-True (Test-Path -LiteralPath $scriptPath -PathType Leaf) "Case script missing: $($actual.script)"
    $scriptText = Get-Content -Raw -LiteralPath $scriptPath
    Assert-True (([regex]::Matches($scriptText,[regex]::Escape([string]$actual.required_marker))).Count -eq 1) "Case marker source count mismatch: $($actual.id)"
    Assert-True (-not $scriptText.Contains('TASK_0023ZX_COMPLETE_MATRIX_PASS') -and -not $scriptText.Contains('task_0023zx_core_mechanics_complete_matrix.gd')) "Excluded historical matrix reference: $($actual.id)"
}

$aggregateText = Get-Content -Raw -LiteralPath (Join-Path $RepoRoot 'tests\run_all.gd')
Assert-True ($aggregateText.Contains('value = base.duplicate(true); value.schema_version = 3')) 'Aggregate schema-version 3 probe missing'
Assert-True (-not $aggregateText.Contains('value = base.duplicate(true); value.schema_version = 2')) 'Stale Aggregate schema-version 2 probe present'
$aggregateExpectCalls = @($aggregateText -split "`r?`n" | Where-Object { $_.TrimStart().StartsWith('_expect(') -or $_.TrimStart().StartsWith('_expect_code(') }).Count
Assert-True ($aggregateExpectCalls -eq 253) 'Aggregate expectation-call count mismatch'
Assert-True ($aggregateText.Contains('TASK_0003_TESTS_PASS assertions=%d vectors=9')) 'Aggregate runtime marker contract missing'

$coverage = @($manifest.required_coverage_ids)
Assert-True ($coverage.Count -eq 44 -and @($coverage | Sort-Object -Unique).Count -eq 44) 'Coverage manifest mismatch'
$completeText = Get-Content -Raw -LiteralPath (Join-Path $RepoRoot 'tests\simulation\task_0024v_v2_solver_replay_canonical_malformed.gd')
foreach ($id in $coverage) { Assert-True (([regex]::Matches($completeText,[regex]::Escape([string]$id))).Count -eq 1) "Coverage source count mismatch: $id" }

$frozenCount = Assert-HashMap $manifest.frozen_files.psobject.Properties $RepoRoot
$qualifiedTestCount = Assert-HashMap $manifest.qualified_tests.psobject.Properties $RepoRoot
$historicalTCount = Assert-HashMap $manifest.historical_0024t_files.psobject.Properties $RepoRoot
$historicalUCount = Assert-HashMap $manifest.historical_0024u_files.psobject.Properties $RepoRoot
$qualifiedVCount = Assert-HashMap $manifest.qualified_0024v_files.psobject.Properties $RepoRoot
$additionalHistoricalCount = Assert-HashMap $manifest.additional_historical_files.psobject.Properties $RepoRoot
$externalCount = Assert-HashMap $manifest.historical_external_evidence.psobject.Properties $evidenceBase
Assert-True ((& git -C $RepoRoot hash-object -- $manifest.wrapper.path).Trim() -ceq $manifest.wrapper.blob) 'Accepted wrapper blob drift'
& git -C $RepoRoot merge-base --is-ancestor $manifest.accepted_checkpoint HEAD
Assert-True ($LASTEXITCODE -eq 0) 'Accepted checkpoint ancestry failure'

$vBaselineText = Get-Content -Raw -LiteralPath (Join-Path $RepoRoot 'tests\tools\task_0024v_test_correction_baseline.json')
$vBaseline = $vBaselineText | ConvertFrom-Json -Depth 40
$vEquivalenceText = Get-Content -Raw -LiteralPath (Join-Path $RepoRoot 'tests\tools\task_0024v_test_correction_equivalence.py')
Assert-True ($vBaseline.aggregate.source_commit -ceq $manifest.fixed_source_commit) 'Task 0024V fixed source baseline mismatch'
Assert-True (-not $vEquivalenceText.Contains('HEAD:') -and $vEquivalenceText.Contains("aggregate['source_commit']")) 'Task 0024V equivalence source is dynamic'
$python = (Get-Command python -ErrorAction Stop).Source
$equivalenceLines = @(& $python (Join-Path $RepoRoot 'tests\tools\task_0024v_test_correction_equivalence.py') $RepoRoot)
Assert-True ($LASTEXITCODE -eq 0) 'Task 0024V equivalence helper failed'
$equivalence = ($equivalenceLines -join "`n") | ConvertFrom-Json -Depth 20
Assert-True ($equivalence.status -ceq 'PASS' -and $equivalence.coverage_ids -eq 44 -and $equivalence.aggregate_runtime_assertions -eq 621) 'Task 0024V equivalence result mismatch'

$driverText = Get-Content -Raw -LiteralPath $driverPath
$driverAudit = Get-DriverProcessAudit $driverText
Assert-True ($driverAudit.bad_commands -eq 0 -and $driverAudit.assignments -eq 4 -and $driverAudit.comparisons -eq 4 -and $driverAudit.paired) 'Driver assigned-scalar doctrine mismatch'
Assert-True (-not [regex]::IsMatch($driverText,'(?i)\b(retry|fallback|rerun)\b')) 'Driver contains alternate execution language'
Assert-True (([regex]::Matches($driverText,'& \$pwshPath @wrapperArguments')).Count -eq 1) 'Driver wrapper invocation site mismatch'
Assert-True (([regex]::Matches($driverText,[regex]::Escape('tests\tools\run_owned_godot_headless.ps1'))).Count -eq 1) 'Driver wrapper path count mismatch'
Assert-True ($driverText.Contains('Write-CreateNewJson $attemptPath') -and $driverText.IndexOf('Write-CreateNewJson $attemptPath') -lt $driverText.IndexOf('foreach ($case in $manifest.cases)')) 'Attempt record ordering mismatch'
foreach ($phase in @('ATTEMPT_CREATED','BEFORE_CASE','AFTER_CASE','BEFORE_FINAL_SUMMARY','AFTER_FINAL_SUMMARY')) { Assert-True ($driverText.Contains("'$phase'")) "Progress phase missing: $phase" }
Assert-True ($driverText.Contains('[IO.FileMode]::CreateNew') -and $driverText.Contains('[IO.File]::Move($temporaryPath,$Path,$true)')) 'Record write semantics mismatch'
Assert-True ($driverText.Contains('finally {') -and $driverText.Contains('$finalGodotCount = Get-GodotCount')) 'Final process audit path missing'
Assert-True ($driverText.Contains('$maxCaseResultBytes = 262144') -and $driverText.Contains('$maxRecordBytes = 1048576')) 'Driver bounds missing'
Assert-True (-not $driverText.Contains('HEAD:')) 'Driver contains dynamic historical source'

$summary = Get-Content -Raw -LiteralPath $qualificationSummaryPath | ConvertFrom-Json -Depth 30
Assert-True ($summary.status -ceq 'PASS' -and $summary.marker -ceq 'TASK_0024W_DRIVER_PRECONDITION_AND_RECORD_QUALIFICATION_PASS') 'Qualification summary mismatch'
$pwsh = (Get-Command pwsh -ErrorAction Stop).Source
$freshLines = @(& $pwsh -NoProfile -File $qualificationPath -RepoRoot $RepoRoot)
Assert-True ($LASTEXITCODE -eq 0) 'Fresh pure-PowerShell qualification failed'
$freshRaw = $freshLines -join "`n"
$fresh = $freshRaw | ConvertFrom-Json -Depth 30
Assert-True (($fresh | ConvertTo-Json -Depth 30 -Compress) -ceq ($summary | ConvertTo-Json -Depth 30 -Compress)) 'Qualification output is not deterministic'
Assert-True ($fresh.godot_or_wrapper_launches -eq 0 -and $fresh.final_external_artifacts_created -eq 0) 'Qualification launch/external-root contract failed'

$allowedDirty = @(
    'tests/tools/task_0024w_core_mechanics_final_validation_manifest.json',
    'tests/tools/task_0024w_core_mechanics_final_validation_static_validator.ps1',
    'tests/tools/task_0024w_core_mechanics_final_validation_driver.ps1',
    'tests/tools/task_0024w_driver_precondition_and_record_qualification.ps1',
    'tests/tools/task_0024w_driver_precondition_and_record_qualification_summary.json'
)
$statusLines = @(& git -C $RepoRoot status --short --untracked-files=all)
foreach ($line in $statusLines) { $dirty=$line.Substring(3).Replace('\','/'); Assert-True ($allowedDirty -contains $dirty) "Unauthorized dirty path: $dirty" }
$staged = @(& git -C $RepoRoot diff --cached --name-only)
Assert-True ($LASTEXITCODE -eq 0 -and $staged.Count -eq 0) 'Preparation must have zero staged paths'
Assert-True (-not (Test-Path -LiteralPath (Join-Path $evidenceBase '0024W_complete_core_mechanics_final_validation'))) 'Final evidence root exists before seal'
$finalGodot = Get-GodotCount
Assert-True ($finalGodot -eq 0) 'Godot process appeared during static validation'

$result = [pscustomobject][ordered]@{
    status='PASS'; task_id='0024W'; cases=4; coverage_ids=44; aggregate_expect_calls=$aggregateExpectCalls
    frozen_files=$frozenCount; qualified_tests=$qualifiedTestCount; historical_0024t_files=$historicalTCount
    historical_0024u_files=$historicalUCount; qualified_0024v_files=$qualifiedVCount; additional_historical_files=$additionalHistoricalCount; historical_external_files=$externalCount
    process_count_assignments=$driverAudit.assignments; process_count_comparisons=$driverAudit.comparisons
    record_qualification='PASS'; wrapper_blob=$manifest.wrapper.blob; wrapper_godot_launches=0
    godot_before=$initialGodot; godot_after=$finalGodot; deterministic=$true; marker='TASK_0024W_STATIC_VALIDATION_PASS'
}
$json=$result | ConvertTo-Json -Compress
Assert-True ([Text.Encoding]::UTF8.GetByteCount($json) -le $maximumOutputBytes) 'Static output bound exceeded'
$json
