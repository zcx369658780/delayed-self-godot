[CmdletBinding()]
param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path
)

$ErrorActionPreference = 'Stop'
$PSNativeCommandUseErrorActionPreference = $false
$maxOutputBytes = 65536
$baselinePath = Join-Path $RepoRoot 'tests\tools\task_0024v_test_correction_baseline.json'
$helperPath = Join-Path $RepoRoot 'tests\tools\task_0024v_test_correction_equivalence.py'
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

function Assert-HashMap($Properties, [string]$BasePath, [bool]$RequireCommitted) {
    $count = 0
    foreach ($property in $Properties) {
        $relative = $property.Name
        $path = Join-Path $BasePath ($relative.Replace('/', '\'))
        Assert-True (Test-Path -LiteralPath $path -PathType Leaf) "Hash-bound file missing: $relative"
        $actual = Get-Sha256 $path
        Assert-True ($actual -ceq ([string]$property.Value).ToLowerInvariant()) "Hash drift: $relative"
        if ($RequireCommitted) {
            & git -C $RepoRoot diff --quiet HEAD -- $relative
            Assert-True ($LASTEXITCODE -eq 0) "Committed historical/frozen artifact drift: $relative"
        }
        $count++
    }
    return $count
}

function Test-AuthorizedDirtyPath([string]$Path) {
    if ($Path -ceq 'tests/run_all.gd') { return $true }
    if ($Path -ceq 'tests/simulation/task_0024v_v2_solver_replay_canonical_malformed.gd') { return $true }
    if ($Path -like 'tests/tools/task_0024v_*.ps1' -or $Path -like 'tests/tools/task_0024v_*.py' -or $Path -like 'tests/tools/task_0024v_*.json') { return $true }
    return @(
        'docs/reports/0024V_TEST_CORRECTION_QUALIFICATION_REPORT.md',
        'docs/CODEX_ACTIVE_TASK_CURRENT.md',
        'docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md',
        'docs/DEVELOPMENT_PLAN_CURRENT.md',
        'docs/DOC_INDEX_CURRENT.md',
        'docs/HANDOFF_MASTER_CURRENT.md',
        'docs/project_memory.md',
        'docs/project_memory/HEADLESS_GODOT_TEST_PROCESS_LIFECYCLE_FAILURE_AND_POLICY_CURRENT.md',
        'docs/production/EXPANDED_CONTENT_SUBMISSION_ROADMAP_CURRENT.md'
    ) -ccontains $Path
}

$initialGodot = Get-GodotCount
Assert-True ($initialGodot -eq 0) 'Godot process exists before static validation'
Assert-True ((Resolve-Path -LiteralPath $RepoRoot).Path -ceq 'D:\Delayed_Self') 'Repository root mismatch'
Assert-True (Test-Path -LiteralPath $baselinePath -PathType Leaf) 'Task 0024V baseline is missing'
Assert-True (Test-Path -LiteralPath $helperPath -PathType Leaf) 'Task 0024V equivalence helper is missing'
$baseline = Get-Content -Raw -LiteralPath $baselinePath | ConvertFrom-Json -Depth 40
Assert-True ($baseline.schema_version -eq 1 -and $baseline.task_id -ceq '0024V') 'Task 0024V baseline identity mismatch'

$wrapperPath = Join-Path $RepoRoot ($baseline.accepted_wrapper.path.Replace('/', '\'))
$wrapperBlob = (& git -C $RepoRoot hash-object -- $baseline.accepted_wrapper.path).Trim()
Assert-True ($LASTEXITCODE -eq 0 -and $wrapperBlob -ceq $baseline.accepted_wrapper.blob) 'Accepted wrapper blob drift'
$frozenCount = Assert-HashMap $baseline.frozen_files.psobject.Properties $RepoRoot $true
$historicalTCount = Assert-HashMap $baseline.historical_0024t_files.psobject.Properties $RepoRoot $true
$historicalUCount = Assert-HashMap $baseline.historical_0024u_files.psobject.Properties $RepoRoot $true
$externalCount = Assert-HashMap $baseline.external_evidence.psobject.Properties $evidenceBase $false

$tSeal = Join-Path $evidenceBase '0024T_complete_core_mechanics_final_validation\pre_execution_seal.json'
$uSeal = Join-Path $evidenceBase '0024U_corrected_complete_core_mechanics_final_validation\pre_execution_seal.json'
$uAttempt = Join-Path $evidenceBase '0024U_corrected_complete_core_mechanics_final_validation\attempt_record.json'
foreach ($readOnlyPath in @($tSeal,$uSeal,$uAttempt)) {
    $readOnly = ([IO.File]::GetAttributes($readOnlyPath) -band [IO.FileAttributes]::ReadOnly) -ne 0
    Assert-True $readOnly "Historical immutable record is not read-only: $readOnlyPath"
}

$python = (Get-Command python -ErrorAction Stop).Source
$firstLines = @(& $python $helperPath $RepoRoot)
$firstExit = $LASTEXITCODE
$firstRaw = $firstLines -join "`n"
Assert-True ($firstExit -eq 0) 'Semantic-equivalence helper failed'
Assert-True ([Text.Encoding]::UTF8.GetByteCount($firstRaw) -le $maxOutputBytes) 'Semantic-equivalence output bound exceeded'
$equivalence = $firstRaw | ConvertFrom-Json -Depth 20
Assert-True ($equivalence.status -ceq 'PASS' -and $equivalence.marker -ceq 'TASK_0024V_EQUIVALENCE_PASS') 'Semantic-equivalence result mismatch'
Assert-True ($equivalence.aggregate_runtime_assertions -eq 621) 'Aggregate runtime assertion contract mismatch'
Assert-True ($equivalence.aggregate_expect_calls_before -eq $equivalence.aggregate_expect_calls_after) 'Aggregate assertion structure changed'
Assert-True ($equivalence.authorized_declaration_sites -eq 15) 'Complete-v2 declaration-site count mismatch'
Assert-True ($equivalence.coverage_ids -eq 44 -and @($equivalence.coverage_missing).Count -eq 0 -and @($equivalence.coverage_duplicates).Count -eq 0) 'Complete-v2 coverage mismatch'
$secondLines = @(& $python $helperPath $RepoRoot)
$secondExit = $LASTEXITCODE
$secondRaw = $secondLines -join "`n"
Assert-True ($secondExit -eq 0 -and $secondRaw -ceq $firstRaw) 'Semantic-equivalence output is not deterministic'

$statusLines = @(& git -C $RepoRoot status --short --untracked-files=all)
Assert-True ($LASTEXITCODE -eq 0) 'Unable to audit changed paths'
$dirtyPaths = @($statusLines | ForEach-Object { $_.Substring(3).Replace('\','/') })
foreach ($dirtyPath in $dirtyPaths) {
    Assert-True (Test-AuthorizedDirtyPath $dirtyPath) "Unauthorized dirty path: $dirtyPath"
}
$stagedPaths = @(& git -C $RepoRoot diff --cached --name-only)
Assert-True ($LASTEXITCODE -eq 0 -and $stagedPaths.Count -eq 0) 'Static qualification preparation requires zero staged paths'

$finalGodot = Get-GodotCount
Assert-True ($finalGodot -eq 0) 'Godot process appeared during static validation'
$result = [pscustomobject][ordered]@{
    status = 'PASS'
    task_id = '0024V'
    aggregate_runtime_assertions = 621
    aggregate_expect_calls = $equivalence.aggregate_expect_calls_after
    declaration_sites = 15
    coverage_ids = 44
    coverage_missing = 0
    coverage_duplicates = 0
    frozen_files = $frozenCount
    historical_0024t_files = $historicalTCount
    historical_0024u_files = $historicalUCount
    external_historical_files = $externalCount
    wrapper_blob = $wrapperBlob
    wrapper_launches = 0
    godot_before = $initialGodot
    godot_after = $finalGodot
    deterministic = $true
    marker = 'TASK_0024V_STATIC_VALIDATION_PASS'
}
$json = $result | ConvertTo-Json -Compress
Assert-True ([Text.Encoding]::UTF8.GetByteCount($json) -le $maxOutputBytes) 'Static-validator output bound exceeded'
$json
