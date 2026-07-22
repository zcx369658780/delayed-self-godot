[CmdletBinding()]
param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path,
    [switch]$LibraryMode
)

$ErrorActionPreference = 'Stop'

function Assert-True([bool]$Condition, [string]$Message) {
    if (-not $Condition) { throw $Message }
}

function Test-DriverPreconditionSource {
    param(
        [Parameter(Mandatory)][string]$SourceText,
        [switch]$RequireCompleteDriver
    )

    $tokens = $null
    $parseErrors = $null
    $ast = [Management.Automation.Language.Parser]::ParseInput(
        $SourceText,
        [ref]$tokens,
        [ref]$parseErrors
    )
    if ($parseErrors.Count -ne 0) {
        return [pscustomobject]@{
            valid = $false
            parse_errors = $parseErrors.Count
            bad_command_comparisons = 0
            process_count_assignments = 0
            process_count_comparisons = 0
            process_count_assertions = 0
        }
    }

    $comparisonTokens = @('-eq','-ne','-ceq','-cne','-gt','-ge','-lt','-le')
    $badCommands = @($ast.FindAll({
        param($node)
        if ($node -isnot [Management.Automation.Language.CommandAst]) { return $false }
        if ($node.GetCommandName() -cne 'Get-GodotCount') { return $false }
        $elements = @($node.CommandElements | ForEach-Object { $_.Extent.Text })
        return @($elements | Where-Object { $comparisonTokens -contains $_.ToLowerInvariant() }).Count -gt 0
    }, $true))

    $assignmentVariables = [Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
    $assignments = @($ast.FindAll({
        param($node)
        $node -is [Management.Automation.Language.AssignmentStatementAst]
    }, $true))
    foreach ($assignment in $assignments) {
        if ($assignment.Left -isnot [Management.Automation.Language.VariableExpressionAst]) { continue }
        $commands = @($assignment.Right.FindAll({
            param($node)
            $node -is [Management.Automation.Language.CommandAst] -and $node.GetCommandName() -ceq 'Get-GodotCount'
        }, $true))
        if ($commands.Count -eq 1 -and $commands[0].CommandElements.Count -eq 1) {
            [void]$assignmentVariables.Add($assignment.Left.VariablePath.UserPath)
        }
    }

    $comparedVariables = [Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
    $binaryComparisons = @($ast.FindAll({
        param($node)
        $node -is [Management.Automation.Language.BinaryExpressionAst]
    }, $true))
    foreach ($binary in $binaryComparisons) {
        if ($binary.Left -is [Management.Automation.Language.VariableExpressionAst] -and
            $assignmentVariables.Contains($binary.Left.VariablePath.UserPath) -and
            $binary.Right.Extent.Text -ceq '0') {
            [void]$comparedVariables.Add($binary.Left.VariablePath.UserPath)
        }
    }

    $processAssertions = 0
    $assertCommands = @($ast.FindAll({
        param($node)
        $node -is [Management.Automation.Language.CommandAst] -and $node.GetCommandName() -ceq 'Assert-True'
    }, $true))
    foreach ($assertCommand in $assertCommands) {
        if ($assertCommand.CommandElements.Count -lt 2) { continue }
        $conditionVariables = @($assertCommand.CommandElements[1].FindAll({
            param($node)
            $node -is [Management.Automation.Language.VariableExpressionAst] -and
                $assignmentVariables.Contains($node.VariablePath.UserPath)
        }, $true))
        if ($conditionVariables.Count -gt 0) { $processAssertions++ }
    }

    $requiredAssignmentCount = if ($RequireCompleteDriver) { 4 } else { 1 }
    $valid = $badCommands.Count -eq 0 -and
        $assignmentVariables.Count -eq $requiredAssignmentCount -and
        $comparedVariables.Count -eq $requiredAssignmentCount -and
        $processAssertions -ge 1
    return [pscustomobject]@{
        valid = $valid
        parse_errors = 0
        bad_command_comparisons = $badCommands.Count
        process_count_assignments = $assignmentVariables.Count
        process_count_comparisons = $comparedVariables.Count
        process_count_assertions = $processAssertions
    }
}

if ($LibraryMode) { return }

$manifestPath = Join-Path $RepoRoot 'tests\tools\task_0024u_core_mechanics_final_validation_manifest.json'
$driverPath = Join-Path $RepoRoot 'tests\tools\task_0024u_core_mechanics_final_validation_driver.ps1'
$qualificationPath = Join-Path $RepoRoot 'tests\tools\task_0024u_driver_precondition_qualification.ps1'
$summaryPath = Join-Path $RepoRoot 'tests\tools\task_0024u_driver_precondition_qualification_summary.json'
$completeV2Path = Join-Path $RepoRoot 'tests\simulation\task_0024t_v2_solver_replay_canonical_malformed.gd'
$expectedCases = @(
    [pscustomobject]@{ id='aggregate_v1_formal_regression'; script='res://tests/run_all.gd'; marker='TASK_0003_TESTS_PASS'; policy='Allow'; allowlist=@('LEVEL_ID_MISMATCH'); timeout=600 },
    [pscustomobject]@{ id='task_0012_standalone_regression'; script='res://tests/levels/task_0012_staggered_doors_validation.gd'; marker='TASK_0012_FOCUSED_PASS'; policy='ForbidNonempty'; allowlist=@(); timeout=600 },
    [pscustomobject]@{ id='v2_focused_foundation'; script='res://tests/simulation/task_0023zx_core_mechanics_foundation.gd'; marker='TASK_0023ZX_PASS'; policy='ForbidNonempty'; allowlist=@(); timeout=120 },
    [pscustomobject]@{ id='v2_complete_solver_replay_canonical_malformed'; script='res://tests/simulation/task_0024t_v2_solver_replay_canonical_malformed.gd'; marker='TASK_0024T_V2_COMPLETE_PASS'; policy='ForbidNonempty'; allowlist=@(); timeout=300 }
)

foreach ($path in @($manifestPath,$driverPath,$qualificationPath,$summaryPath,$completeV2Path)) {
    $exists = Test-Path -LiteralPath $path -PathType Leaf
    Assert-True $exists "Required Task 0024U artifact is missing: $path"
}
$manifest = Get-Content -Raw -LiteralPath $manifestPath | ConvertFrom-Json -Depth 30
Assert-True ($manifest.schema_version -eq 2 -and $manifest.task_id -ceq '0024U') 'Manifest identity mismatch'
Assert-True (@($manifest.cases).Count -eq 4) 'Manifest must contain exactly four cases'
Assert-True ($manifest.wrapper.path -ceq 'tests/tools/run_owned_godot_headless.ps1') 'Wrapper path mismatch'
Assert-True ($manifest.wrapper.blob -ceq '5f14eb0feff903b40311c1c7283b20e2eabbffc2') 'Wrapper blob mismatch'
Assert-True ($manifest.wrapper.grace_seconds -eq 3) 'Wrapper grace mismatch'
Assert-True (@($manifest.wrapper.extra_arguments).Count -eq 0) 'Wrapper extra arguments must be empty'
Assert-True (@($manifest.wrapper.allowed_godot_descendant_tokens).Count -eq 0) 'Wrapper descendant tokens must be empty'

for ($index = 0; $index -lt $expectedCases.Count; $index++) {
    $actual = $manifest.cases[$index]
    $expected = $expectedCases[$index]
    Assert-True ($actual.id -ceq $expected.id) "Case ID/order mismatch at $index"
    Assert-True ($actual.script -ceq $expected.script) "Case script mismatch at $index"
    Assert-True ($actual.required_marker -ceq $expected.marker) "Case marker mismatch at $index"
    Assert-True ($actual.stderr_policy -ceq $expected.policy) "Case stderr policy mismatch at $index"
    Assert-True ($actual.timeout_seconds -eq $expected.timeout) "Case timeout mismatch at $index"
    Assert-True (@($actual.stderr_allowlist).Count -eq @($expected.allowlist).Count) "Case allowlist count mismatch at $index"
    if (@($expected.allowlist).Count -eq 1) {
        Assert-True ($actual.stderr_allowlist[0] -ceq $expected.allowlist[0]) "Case allowlist mismatch at $index"
    }
    $scriptPath = Join-Path $RepoRoot ($actual.script.Substring(6).Replace('/', '\'))
    $scriptExists = Test-Path -LiteralPath $scriptPath -PathType Leaf
    Assert-True $scriptExists "Declared script missing: $($actual.script)"
    $scriptText = Get-Content -Raw -LiteralPath $scriptPath
    $markerCount = ([regex]::Matches($scriptText,[regex]::Escape([string]$actual.required_marker))).Count
    Assert-True ($markerCount -eq 1) "Required marker count mismatch: $($actual.required_marker)"
    Assert-True (-not $scriptText.Contains('TASK_0023ZX_COMPLETE_MATRIX_PASS')) "Historical marker in declared script: $($actual.script)"
    Assert-True (-not $scriptText.Contains('task_0023zx_core_mechanics_complete_matrix.gd')) "Historical path in declared script: $($actual.script)"
}

$coverageIds = @($manifest.required_coverage_ids)
Assert-True ($coverageIds.Count -eq 44) 'Coverage ID count must be 44'
Assert-True (@($coverageIds | Sort-Object -Unique).Count -eq 44) 'Coverage IDs must be unique'
$completeV2Text = Get-Content -Raw -LiteralPath $completeV2Path
foreach ($coverageId in $coverageIds) {
    $coverageCount = ([regex]::Matches($completeV2Text,[regex]::Escape([string]$coverageId))).Count
    Assert-True ($coverageCount -eq 1) "Coverage ID mismatch: $coverageId"
}

$driverText = Get-Content -Raw -LiteralPath $driverPath
$driverSafety = Test-DriverPreconditionSource -SourceText $driverText -RequireCompleteDriver
Assert-True $driverSafety.valid 'Driver assigned-scalar precondition doctrine failed'
Assert-True ($driverSafety.bad_command_comparisons -eq 0) 'Driver contains command-argument comparison tokens'
Assert-True (-not $driverText.Contains('Get-GodotCount -eq 0')) 'Historical bad PowerShell expression remains'
Assert-True (-not $driverText.Contains('TASK_0023ZX_COMPLETE_MATRIX_PASS')) 'Historical marker present in driver'
Assert-True (-not $driverText.Contains('task_0023zx_core_mechanics_complete_matrix.gd')) 'Historical path present in driver'
Assert-True (([regex]::Matches($driverText,[regex]::Escape('tests/tools/run_owned_godot_headless.ps1'))).Count -eq 1) 'Accepted wrapper path must occur once in driver'
Assert-True (([regex]::Matches($driverText,'& \$pwshPath @wrapperArguments')).Count -eq 1) 'Driver wrapper invocation site mismatch'
Assert-True (([regex]::Matches($driverText,'foreach \(\$case in \$manifest\.cases\)')).Count -eq 1) 'Driver case loop mismatch'
Assert-True (-not [regex]::IsMatch($driverText,'(?im)^\s*(while|do)\b')) 'Driver contains a repeated-attempt loop'
Assert-True (-not [regex]::IsMatch($driverText,'(?i)\bfallback\b|\bretry\b')) 'Driver contains alternate-attempt language'
Assert-True ($driverText.Contains('$maxCaseResultBytes = 262144')) 'Case result bound missing'
Assert-True ($driverText.Contains('$maxSummaryBytes = 1048576')) 'Summary bound missing'

$summary = Get-Content -Raw -LiteralPath $summaryPath | ConvertFrom-Json -Depth 20
Assert-True ($summary.status -ceq 'PASS') 'Precondition qualification summary is not PASS'
Assert-True ($summary.marker -ceq 'TASK_0024U_DRIVER_PRECONDITION_QUALIFICATION_PASS') 'Qualification marker mismatch'
Assert-True ($summary.zero_scalar_pass -eq $true -and $summary.one_scalar_fail -eq $true) 'Scalar behavior qualification failed'
Assert-True ($summary.validator_rejects_historical_bad -eq $true -and $summary.validator_accepts_corrected -eq $true) 'Validator behavior qualification failed'
Assert-True ($summary.driver_process_count_assignments -eq 4 -and $summary.driver_process_count_comparisons -eq 4) 'Driver process-count qualification mismatch'
Assert-True ($summary.godot_or_wrapper_launches -eq 0) 'Qualification launch count is nonzero'
Assert-True ($summary.external_artifacts_created -eq 0) 'Qualification created external artifacts'
Assert-True ($summary.output_bounded -eq $true -and $summary.deterministic -eq $true) 'Qualification output contract failed'

$pwshCommand = Get-Command pwsh -ErrorAction Stop
$pwshPath = $pwshCommand.Source
$qualificationLines = @(& $pwshPath -NoProfile -File $qualificationPath -RepoRoot $RepoRoot)
$qualificationExit = $LASTEXITCODE
Assert-True ($qualificationExit -eq 0) 'Fresh precondition qualification failed'
$qualificationRaw = $qualificationLines -join "`n"
$qualificationFresh = $qualificationRaw | ConvertFrom-Json -Depth 20
$summaryCanonical = $summary | ConvertTo-Json -Depth 20 -Compress
$freshCanonical = $qualificationFresh | ConvertTo-Json -Depth 20 -Compress
Assert-True ($summaryCanonical -ceq $freshCanonical) 'Qualification summary differs from fresh deterministic output'

foreach ($property in $manifest.frozen_files.psobject.Properties) {
    $path = Join-Path $RepoRoot ($property.Name.Replace('/', '\'))
    $actualHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $path).Hash.ToLowerInvariant()
    Assert-True ($actualHash -ceq ([string]$property.Value).ToLowerInvariant()) "Frozen hash drift: $($property.Name)"
}
foreach ($property in $manifest.historical_0024t_files.psobject.Properties) {
    $path = Join-Path $RepoRoot ($property.Name.Replace('/', '\'))
    $actualHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $path).Hash.ToLowerInvariant()
    Assert-True ($actualHash -ceq ([string]$property.Value).ToLowerInvariant()) "Historical 0024T hash drift: $($property.Name)"
    $currentBlob = (& git -C $RepoRoot hash-object -- $property.Name).Trim()
    $committedBlob = (& git -C $RepoRoot rev-parse "$($manifest.historical_0024t_commit):$($property.Name)").Trim()
    Assert-True ($currentBlob -ceq $committedBlob) "Historical 0024T committed blob drift: $($property.Name)"
}
$historicalSealExists = Test-Path -LiteralPath $manifest.historical_0024t_seal_path -PathType Leaf
Assert-True $historicalSealExists 'Historical 0024T seal missing'
$historicalSealHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $manifest.historical_0024t_seal_path).Hash.ToLowerInvariant()
Assert-True ($historicalSealHash -ceq $manifest.historical_0024t_seal_sha256) 'Historical 0024T seal drift'
$historicalSealReadOnly = ([IO.File]::GetAttributes($manifest.historical_0024t_seal_path) -band [IO.FileAttributes]::ReadOnly) -ne 0
Assert-True $historicalSealReadOnly 'Historical 0024T seal is not read-only'

$wrapperBlob = (& git -C $RepoRoot hash-object -- $manifest.wrapper.path).Trim()
Assert-True ($wrapperBlob -ceq $manifest.wrapper.blob) 'Accepted wrapper blob drift'
$allowedDirty = @(
    'tests/tools/task_0024u_core_mechanics_final_validation_manifest.json',
    'tests/tools/task_0024u_core_mechanics_final_validation_static_validator.ps1',
    'tests/tools/task_0024u_core_mechanics_final_validation_driver.ps1',
    'tests/tools/task_0024u_driver_precondition_qualification.ps1',
    'tests/tools/task_0024u_driver_precondition_qualification_summary.json'
)
$statusLines = @(& git -C $RepoRoot status --short --untracked-files=all)
foreach ($line in $statusLines) {
    $dirtyPath = $line.Substring(3).Replace('\','/')
    Assert-True ($allowedDirty -contains $dirtyPath) "Unauthorized dirty path: $dirtyPath"
}
$stagedPaths = @(& git -C $RepoRoot diff --cached --name-only)
Assert-True ($stagedPaths.Count -eq 0) 'Preparation must have zero staged paths'

[pscustomobject][ordered]@{
    status = 'PASS'
    cases = 4
    coverage_ids = 44
    frozen_files = @($manifest.frozen_files.psobject.Properties).Count
    historical_files = @($manifest.historical_0024t_files.psobject.Properties).Count
    process_count_assignments = $driverSafety.process_count_assignments
    process_count_comparisons = $driverSafety.process_count_comparisons
    wrapper_blob = $wrapperBlob
    marker = 'TASK_0024U_STATIC_VALIDATION_PASS'
} | ConvertTo-Json -Compress

