[CmdletBinding()]
param([string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path)

$ErrorActionPreference = 'Stop'
$manifestPath = Join-Path $RepoRoot 'tests\tools\task_0024t_core_mechanics_final_validation_manifest.json'
$driverPath = Join-Path $RepoRoot 'tests\tools\task_0024t_core_mechanics_final_validation.ps1'
$newTestPath = Join-Path $RepoRoot 'tests\simulation\task_0024t_v2_solver_replay_canonical_malformed.gd'
$wrapperRelative = 'tests/tools/run_owned_godot_headless.ps1'
$expectedCases = @(
    [pscustomobject]@{ id='aggregate_v1_formal_regression'; script='res://tests/run_all.gd'; marker='TASK_0003_TESTS_PASS'; policy='Allow' },
    [pscustomobject]@{ id='task_0012_standalone_regression'; script='res://tests/levels/task_0012_staggered_doors_validation.gd'; marker='TASK_0012_FOCUSED_PASS'; policy='ForbidNonempty' },
    [pscustomobject]@{ id='v2_focused_foundation'; script='res://tests/simulation/task_0023zx_core_mechanics_foundation.gd'; marker='TASK_0023ZX_PASS'; policy='ForbidNonempty' },
    [pscustomobject]@{ id='v2_complete_solver_replay_canonical_malformed'; script='res://tests/simulation/task_0024t_v2_solver_replay_canonical_malformed.gd'; marker='TASK_0024T_V2_COMPLETE_PASS'; policy='ForbidNonempty' }
)

function Assert-True([bool]$Condition, [string]$Message) {
    if (-not $Condition) { throw $Message }
}

function Convert-ResourcePath([string]$Path) {
    Assert-True ($Path.StartsWith('res://')) "Non-resource script path: $Path"
    return Join-Path $RepoRoot ($Path.Substring(6).Replace('/', '\'))
}

Assert-True (Test-Path -LiteralPath $manifestPath -PathType Leaf) 'Manifest is missing'
Assert-True (Test-Path -LiteralPath $driverPath -PathType Leaf) 'Final driver is missing'
Assert-True (Test-Path -LiteralPath $newTestPath -PathType Leaf) 'New v2 test is missing'
$manifest = Get-Content -Raw -LiteralPath $manifestPath | ConvertFrom-Json -Depth 20
Assert-True ($manifest.schema_version -eq 1 -and $manifest.task_id -eq '0024T') 'Manifest identity mismatch'
Assert-True (@($manifest.cases).Count -eq 4) 'Manifest must contain exactly four cases'

for ($index = 0; $index -lt $expectedCases.Count; $index++) {
    $actual = $manifest.cases[$index]
    $expected = $expectedCases[$index]
    Assert-True ($actual.id -ceq $expected.id) "Case order/id mismatch at $index"
    Assert-True ($actual.script -ceq $expected.script) "Case script mismatch at $index"
    Assert-True ($actual.required_marker -ceq $expected.marker) "Case marker mismatch at $index"
    Assert-True ($actual.stderr_policy -ceq $expected.policy) "Case stderr policy mismatch at $index"
    Assert-True ($actual.timeout_seconds -ge 1 -and $actual.timeout_seconds -le 600) "Case timeout out of bounds at $index"
    if ($index -eq 0) {
        Assert-True (@($actual.stderr_allowlist).Count -eq 1 -and $actual.stderr_allowlist[0] -ceq 'LEVEL_ID_MISMATCH') 'Aggregate stderr allowlist must be exact'
    }
    else {
        Assert-True (@($actual.stderr_allowlist).Count -eq 0) "Non-aggregate stderr allowlist must be empty at $index"
    }
    $scriptPath = Convert-ResourcePath $actual.script
    Assert-True (Test-Path -LiteralPath $scriptPath -PathType Leaf) "Declared script missing: $($actual.script)"
    $scriptText = Get-Content -Raw -LiteralPath $scriptPath
    $markerCount = ([regex]::Matches($scriptText, [regex]::Escape([string]$actual.required_marker))).Count
    Assert-True ($markerCount -eq 1) "Required marker must occur exactly once: $($actual.required_marker)"
    Assert-True (-not $scriptText.Contains('TASK_0023ZX_COMPLETE_MATRIX_PASS')) "Historical marker present in declared script: $($actual.script)"
    Assert-True (-not $scriptText.Contains('task_0023zx_core_mechanics_complete_matrix.gd')) "Historical script present in declared script: $($actual.script)"
}

$coverageIds = @($manifest.required_coverage_ids)
Assert-True ($coverageIds.Count -ge 40) 'Coverage ID inventory is unexpectedly incomplete'
Assert-True (@($coverageIds | Sort-Object -Unique).Count -eq $coverageIds.Count) 'Coverage IDs are not unique'
$newTestText = Get-Content -Raw -LiteralPath $newTestPath
foreach ($coverageId in $coverageIds) {
    $count = ([regex]::Matches($newTestText, [regex]::Escape([string]$coverageId))).Count
    Assert-True ($count -eq 1) "Coverage ID must occur exactly once: $coverageId"
}
$declaredCaseIds = @([regex]::Matches($newTestText, '_case\("([A-Z0-9_]+)"') | ForEach-Object { $_.Groups[1].Value })
Assert-True ($declaredCaseIds.Count -eq $coverageIds.Count) 'GDScript case-ID count differs from manifest coverage inventory'
Assert-True (@($declaredCaseIds | Where-Object { $coverageIds -notcontains $_ }).Count -eq 0) 'GDScript contains undeclared coverage IDs'

$driverText = Get-Content -Raw -LiteralPath $driverPath
Assert-True (-not $driverText.Contains('TASK_0023ZX_COMPLETE_MATRIX_PASS')) 'Historical marker present in driver'
Assert-True (-not $driverText.Contains('task_0023zx_core_mechanics_complete_matrix.gd')) 'Historical script present in driver'
Assert-True (([regex]::Matches($driverText, [regex]::Escape($wrapperRelative))).Count -eq 1) 'Driver must name the accepted wrapper exactly once'
Assert-True (([regex]::Matches($driverText, '& \$wrapperPath')).Count -eq 1) 'Driver must have exactly one wrapper invocation site'
Assert-True (([regex]::Matches($driverText, 'foreach \(\$case in \$manifest\.cases\)')).Count -eq 1) 'Driver must have exactly one ordered manifest-case loop'
Assert-True (-not [regex]::IsMatch($driverText, '(?im)^\s*(while|do)\b')) 'Driver contains a retry-capable while/do loop'
Assert-True (-not [regex]::IsMatch($driverText, '(?i)\bretry\b|fallback')) 'Driver contains retry/fallback language'
Assert-True ($driverText.Contains('$maxCaseResultBytes = 262144')) 'Driver case-result bound is missing'
Assert-True ($driverText.Contains('$maxSummaryBytes = 1048576')) 'Driver summary bound is missing'

foreach ($property in $manifest.frozen_files.psobject.Properties) {
    $path = Join-Path $RepoRoot ($property.Name.Replace('/', '\'))
    Assert-True (Test-Path -LiteralPath $path -PathType Leaf) "Frozen file missing: $($property.Name)"
    $actualHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $path).Hash.ToLowerInvariant()
    Assert-True ($actualHash -ceq ([string]$property.Value).ToLowerInvariant()) "Frozen hash drift: $($property.Name)"
}
$wrapperBlob = (& git -C $RepoRoot hash-object -- $wrapperRelative).Trim()
Assert-True ($LASTEXITCODE -eq 0 -and $wrapperBlob -ceq $manifest.accepted_wrapper_blob) 'Accepted wrapper blob mismatch'

$allowedDirty = @(
    'tests/tools/task_0024t_core_mechanics_final_validation_manifest.json',
    'tests/tools/task_0024t_core_mechanics_final_validation_static_validator.ps1',
    'tests/tools/task_0024t_core_mechanics_final_validation.ps1',
    'tests/simulation/task_0024t_v2_solver_replay_canonical_malformed.gd'
)
$statusLines = @(& git -C $RepoRoot status --short --untracked-files=all)
Assert-True ($LASTEXITCODE -eq 0) 'Unable to audit Git status'
foreach ($line in $statusLines) {
    Assert-True ($line.Length -ge 4) "Malformed Git status line: $line"
    $path = $line.Substring(3).Replace('\', '/')
    Assert-True ($allowedDirty -contains $path) "Unauthorized dirty path: $path"
}
$staged = @(& git -C $RepoRoot diff --cached --name-only)
Assert-True ($LASTEXITCODE -eq 0 -and $staged.Count -eq 0) 'Preparation must have zero staged paths'

[pscustomobject]@{
    status = 'PASS'
    cases = @($manifest.cases).Count
    coverage_ids = $coverageIds.Count
    frozen_files = @($manifest.frozen_files.psobject.Properties).Count
    dirty_paths = $statusLines.Count
    wrapper_blob = $wrapperBlob
} | ConvertTo-Json -Compress

