[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateSet('GuardProof', 'Execute')]
    [string]$Mode,

    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$EvidenceRoot,

    [ValidateRange(0, 1)]
    [int]$AttemptNumber = 0,

    [string]$ScriptPath = '',

    [ValidateNotNullOrEmpty()]
    [string]$RepositoryRoot = 'D:\Delayed_Self',

    [ValidateNotNullOrEmpty()]
    [string]$GodotPath = 'D:\Program Files (x86)\Steam\steamapps\common\Godot Engine\godot.windows.opt.tools.64.exe'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$diagnosticScript = 'res://tests/app/task_0023zf_tutorial_persist_diagnostic.gd'
$executionGuard = '--task-0023zf-tutorial-persist-diagnostic'
$guardMarker = 'TASK_0023ZF_EXECUTION_GUARD_BLOCKED'
$observationPrefix = 'TASK_0023ZF_OBSERVATION '
$classificationPrefix = 'TASK_0023ZF_CLASSIFICATION='
$allowedClassifications = @(
    'EXPECTED_CONTRACT_OBSERVED',
    'ROUTE_FRAME_TIMING',
    'ROUTE_FAILURE_STABLE',
    'RUNTIME_PROGRESS_COMMIT_MISMATCH',
    'BEST_TURNS_MISMATCH',
    'PERSISTENCE_STATUS_MISMATCH',
    'ACTIVE_SCREEN_CONTRACT_MISMATCH',
    'UNRESOLVED_SUBCONDITION'
)
$userDataRoot = Join-Path $env:APPDATA 'Godot\app_userdata\Delayed Self'
$productionProfile = Join-Path $userDataRoot 'delayed_self_profile.json'
$testRoot = Join-Path $userDataRoot 'delayed_self_test_profiles'
$fixtureDirectory = Join-Path $testRoot 'task_0023zf_tutorial_persist_diagnostic'
$target = Join-Path $fixtureDirectory 'delayed_self_profile.json'

if (-not (Test-Path -LiteralPath $GodotPath -PathType Leaf)) {
    throw 'Pinned Godot executable is unavailable.'
}
if (-not (Test-Path -LiteralPath $RepositoryRoot -PathType Container)) {
    throw 'Repository root is unavailable.'
}
$resolvedRepositoryRoot = (Resolve-Path -LiteralPath $RepositoryRoot).Path
if ($resolvedRepositoryRoot -ne 'D:\Delayed_Self') {
    throw 'Repository root does not match the frozen root.'
}
if ($Mode -eq 'GuardProof') {
    if ($AttemptNumber -ne 0) {
        throw 'GuardProof does not accept an attempt number.'
    }
    if (-not [string]::IsNullOrEmpty($ScriptPath) -and $ScriptPath -ne $diagnosticScript) {
        throw 'GuardProof may run only the exact diagnostic script.'
    }
}
else {
    if ($AttemptNumber -ne 1) {
        throw 'Execute requires attempt number 1.'
    }
    if ([string]::IsNullOrEmpty($ScriptPath)) {
        $ScriptPath = $diagnosticScript
    }
    if ($ScriptPath -ne $diagnosticScript) {
        throw 'Execute may run only the exact diagnostic script.'
    }
}

New-Item -ItemType Directory -Force -Path $EvidenceRoot | Out-Null
$resolvedEvidenceRoot = (Resolve-Path -LiteralPath $EvidenceRoot).Path

function Write-Lines {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path,
        [Parameter(Mandatory = $true)]
        [AllowEmptyCollection()]
        [string[]]$Lines
    )
    [System.IO.File]::WriteAllLines($Path, $Lines, [System.Text.UTF8Encoding]::new($false))
}

function Get-ProductionMetadata {
    if (-not (Test-Path -LiteralPath $productionProfile -PathType Leaf)) {
        return @('Exists=False', 'Length=0', 'LastWriteTimeUtc=')
    }
    $item = Get-Item -LiteralPath $productionProfile
    return @(
        'Exists=True',
        ('Length=' + $item.Length),
        ('LastWriteTimeUtc=' + $item.LastWriteTimeUtc.ToString('o'))
    )
}

function Get-TestRootExists {
    return 'Exists=' + (Test-Path -LiteralPath $testRoot -PathType Container)
}

function Get-GodotProcessSnapshot {
    $processes = @(Get-Process | Where-Object { $_.ProcessName -like 'godot*' } | Sort-Object Id)
    $lines = @('Count=' + $processes.Count)
    foreach ($process in $processes) {
        $lines += 'Id=' + $process.Id
    }
    return $lines
}

function Get-FixtureExactState {
    $lines = @(
        'FixtureDirectoryExists=' + (Test-Path -LiteralPath $fixtureDirectory -PathType Container),
        'TargetExists=' + (Test-Path -LiteralPath $target -PathType Leaf)
    )
    foreach ($kind in @('temp', 'transaction', 'recovery')) {
        foreach ($index in 0..7) {
            $ownedPath = Join-Path $fixtureDirectory ('.delayed_self_0023w_{0}_{1}.json' -f $kind, $index)
            $lines += ('Owned_{0}_{1}_Exists=' -f $kind, $index) + (Test-Path -LiteralPath $ownedPath -PathType Leaf)
        }
    }
    return $lines
}

function Assert-Inventory {
    param(
        [Parameter(Mandatory = $true)]
        [string[]]$Paths
    )
    $missing = @($Paths | Where-Object { -not (Test-Path -LiteralPath $_ -PathType Leaf) })
    if ($missing.Count -ne 0) {
        throw 'Capture inventory is incomplete.'
    }
}

if ($Mode -eq 'GuardProof') {
    $commandPath = Join-Path $resolvedEvidenceRoot 'guard_command.txt'
    $stdoutPath = Join-Path $resolvedEvidenceRoot 'guard_stdout.txt'
    $stderrPath = Join-Path $resolvedEvidenceRoot 'guard_stderr.txt'
    $exitPath = Join-Path $resolvedEvidenceRoot 'guard_exit_code.txt'
    $processBeforePath = Join-Path $resolvedEvidenceRoot 'guard_process_before.txt'
    $processAfterPath = Join-Path $resolvedEvidenceRoot 'guard_process_after.txt'
    $productionBeforePath = Join-Path $resolvedEvidenceRoot 'guard_production_metadata_before.txt'
    $productionAfterPath = Join-Path $resolvedEvidenceRoot 'guard_production_metadata_after.txt'
    $testRootBeforePath = Join-Path $resolvedEvidenceRoot 'guard_test_root_exists_before.txt'
    $testRootAfterPath = Join-Path $resolvedEvidenceRoot 'guard_test_root_exists_after.txt'
    $inventoryPath = Join-Path $resolvedEvidenceRoot 'guard_inventory.txt'

    $processBefore = @(Get-GodotProcessSnapshot)
    $productionBefore = @(Get-ProductionMetadata)
    $testRootBefore = Get-TestRootExists
    Write-Lines -Path $processBeforePath -Lines $processBefore
    Write-Lines -Path $productionBeforePath -Lines $productionBefore
    Write-Lines -Path $testRootBeforePath -Lines @($testRootBefore)
    Write-Lines -Path $commandPath -Lines @('godot --headless --path D:\Delayed_Self --script ' + $diagnosticScript)

    $arguments = @('--headless', '--path', $resolvedRepositoryRoot, '--script', $diagnosticScript)
    $process = Start-Process -FilePath $GodotPath -ArgumentList $arguments -Wait -PassThru -NoNewWindow -RedirectStandardOutput $stdoutPath -RedirectStandardError $stderrPath
    Write-Lines -Path $exitPath -Lines @($process.ExitCode.ToString())

    $processAfter = @(Get-GodotProcessSnapshot)
    $productionAfter = @(Get-ProductionMetadata)
    $testRootAfter = Get-TestRootExists
    Write-Lines -Path $processAfterPath -Lines $processAfter
    Write-Lines -Path $productionAfterPath -Lines $productionAfter
    Write-Lines -Path $testRootAfterPath -Lines @($testRootAfter)

    $stdout = [System.IO.File]::ReadAllText($stdoutPath)
    $stderrLength = (Get-Item -LiteralPath $stderrPath).Length
    $guardCount = ([regex]::Matches($stdout, [regex]::Escape($guardMarker))).Count
    $observationCount = ([regex]::Matches($stdout, [regex]::Escape($observationPrefix))).Count
    $classificationCount = ([regex]::Matches($stdout, [regex]::Escape($classificationPrefix))).Count
    $passed = (
        $process.ExitCode -eq 2 -and
        $stderrLength -eq 0 -and
        $guardCount -eq 1 -and
        $observationCount -eq 0 -and
        $classificationCount -eq 0 -and
        ($productionBefore -join "`n") -eq ($productionAfter -join "`n") -and
        $testRootBefore -eq $testRootAfter -and
        ($processBefore -join "`n") -eq 'Count=0' -and
        ($processAfter -join "`n") -eq 'Count=0'
    )
    $files = @(
        $commandPath,
        $stdoutPath,
        $stderrPath,
        $exitPath,
        $processBeforePath,
        $processAfterPath,
        $productionBeforePath,
        $productionAfterPath,
        $testRootBeforePath,
        $testRootAfterPath
    )
    Assert-Inventory -Paths $files
    $inventoryLines = @(
        'Mode=GuardProof',
        ('ExitCode=' + $process.ExitCode),
        ('StderrLength=' + $stderrLength),
        ('GuardMarkerCount=' + $guardCount),
        ('ObservationMarkerCount=' + $observationCount),
        ('ClassificationMarkerCount=' + $classificationCount),
        ('ProductionMetadataUnchanged=' + (($productionBefore -join "`n") -eq ($productionAfter -join "`n"))),
        ('TestRootExistenceUnchanged=' + ($testRootBefore -eq $testRootAfter)),
        ('ProcessBeforeZero=' + (($processBefore -join "`n") -eq 'Count=0')),
        ('ProcessAfterZero=' + (($processAfter -join "`n") -eq 'Count=0')),
        ('GuardProofPassed=' + $passed)
    )
    $inventoryLines += $files | ForEach-Object { 'File=' + [System.IO.Path]::GetFileName($_) }
    $inventoryLines += 'File=' + [System.IO.Path]::GetFileName($inventoryPath)
    Write-Lines -Path $inventoryPath -Lines $inventoryLines
    Assert-Inventory -Paths ($files + $inventoryPath)
    if (-not $passed) {
        exit $(if ($process.ExitCode -ne 0) { $process.ExitCode } else { 1 })
    }
    Write-Output 'TASK_0023ZF_GUARD_PROOF_PASS'
    exit 0
}

$prefix = 'attempt_1'
$commandPath = Join-Path $resolvedEvidenceRoot ($prefix + '_command.txt')
$stdoutPath = Join-Path $resolvedEvidenceRoot ($prefix + '_stdout.txt')
$stderrPath = Join-Path $resolvedEvidenceRoot ($prefix + '_stderr.txt')
$exitPath = Join-Path $resolvedEvidenceRoot ($prefix + '_exit_code.txt')
$processBeforePath = Join-Path $resolvedEvidenceRoot ($prefix + '_process_before.txt')
$processAfterPath = Join-Path $resolvedEvidenceRoot ($prefix + '_process_after.txt')
$productionBeforePath = Join-Path $resolvedEvidenceRoot ($prefix + '_production_metadata_before.txt')
$productionAfterPath = Join-Path $resolvedEvidenceRoot ($prefix + '_production_metadata_after.txt')
$testRootBeforePath = Join-Path $resolvedEvidenceRoot ($prefix + '_test_root_exists_before.txt')
$testRootAfterPath = Join-Path $resolvedEvidenceRoot ($prefix + '_test_root_exists_after.txt')
$fixtureBeforePath = Join-Path $resolvedEvidenceRoot ($prefix + '_fixture_exact_state_before.txt')
$fixtureAfterPath = Join-Path $resolvedEvidenceRoot ($prefix + '_fixture_exact_state_after.txt')
$patchPath = Join-Path $resolvedEvidenceRoot ($prefix + '_worktree.patch')
$patchHashPath = Join-Path $resolvedEvidenceRoot ($prefix + '_worktree_patch_sha256.txt')
$observationPath = Join-Path $resolvedEvidenceRoot ($prefix + '_observation.txt')
$classificationPath = Join-Path $resolvedEvidenceRoot ($prefix + '_classification.txt')
$inventoryPath = Join-Path $resolvedEvidenceRoot ($prefix + '_inventory.txt')

$processBefore = @(Get-GodotProcessSnapshot)
$productionBefore = @(Get-ProductionMetadata)
$testRootBefore = Get-TestRootExists
$fixtureBefore = @(Get-FixtureExactState)
Write-Lines -Path $processBeforePath -Lines $processBefore
Write-Lines -Path $productionBeforePath -Lines $productionBefore
Write-Lines -Path $testRootBeforePath -Lines @($testRootBefore)
Write-Lines -Path $fixtureBeforePath -Lines $fixtureBefore
Write-Lines -Path $commandPath -Lines @('godot --headless --path D:\Delayed_Self --script ' + $diagnosticScript + ' -- ' + $executionGuard)

$arguments = @('--headless', '--path', $resolvedRepositoryRoot, '--script', $diagnosticScript, '--', $executionGuard)
$process = Start-Process -FilePath $GodotPath -ArgumentList $arguments -Wait -PassThru -NoNewWindow -RedirectStandardOutput $stdoutPath -RedirectStandardError $stderrPath
Write-Lines -Path $exitPath -Lines @($process.ExitCode.ToString())

$patchProcess = Start-Process -FilePath 'git' -ArgumentList @('-C', $resolvedRepositoryRoot, 'diff', '--binary', '--no-ext-diff') -Wait -PassThru -NoNewWindow -RedirectStandardOutput $patchPath
if ($patchProcess.ExitCode -ne 0) {
    throw 'Worktree patch capture failed.'
}
$patchHash = (Get-FileHash -LiteralPath $patchPath -Algorithm SHA256).Hash.ToLowerInvariant()
Write-Lines -Path $patchHashPath -Lines @($patchHash)

$processAfter = @(Get-GodotProcessSnapshot)
$productionAfter = @(Get-ProductionMetadata)
$testRootAfter = Get-TestRootExists
$fixtureAfter = @(Get-FixtureExactState)
Write-Lines -Path $processAfterPath -Lines $processAfter
Write-Lines -Path $productionAfterPath -Lines $productionAfter
Write-Lines -Path $testRootAfterPath -Lines @($testRootAfter)
Write-Lines -Path $fixtureAfterPath -Lines $fixtureAfter

$stdout = [System.IO.File]::ReadAllText($stdoutPath)
$observationLines = @($stdout -split "`r?`n" | Where-Object { $_.StartsWith($observationPrefix) })
$classificationLines = @($stdout -split "`r?`n" | Where-Object { $_.StartsWith($classificationPrefix) })
Write-Lines -Path $observationPath -Lines $observationLines
Write-Lines -Path $classificationPath -Lines $classificationLines
$stderrLength = (Get-Item -LiteralPath $stderrPath).Length
$classification = if ($classificationLines.Count -eq 1) { $classificationLines[0].Substring($classificationPrefix.Length) } else { '' }
$markerContract = $observationLines.Count -eq 1 -and $classificationLines.Count -eq 1 -and $allowedClassifications.Contains($classification)
$protectedContract = (
    ($productionBefore -join "`n") -eq ($productionAfter -join "`n") -and
    $testRootBefore -eq $testRootAfter -and
    ($processBefore -join "`n") -eq 'Count=0' -and
    ($processAfter -join "`n") -eq 'Count=0'
)

$files = @(
    $commandPath,
    $stdoutPath,
    $stderrPath,
    $exitPath,
    $processBeforePath,
    $processAfterPath,
    $productionBeforePath,
    $productionAfterPath,
    $testRootBeforePath,
    $testRootAfterPath,
    $fixtureBeforePath,
    $fixtureAfterPath,
    $patchPath,
    $patchHashPath,
    $observationPath,
    $classificationPath
)
Assert-Inventory -Paths $files
$inventoryLines = @(
    'Mode=Execute',
    'AttemptNumber=1',
    ('Script=' + $diagnosticScript),
    'ExecutionGuardPassed=True',
    ('ExitCode=' + $process.ExitCode),
    ('StderrLength=' + $stderrLength),
    ('ObservationMarkerCount=' + $observationLines.Count),
    ('ClassificationMarkerCount=' + $classificationLines.Count),
    ('Classification=' + $classification),
    ('ProtectedContractPassed=' + $protectedContract),
    'InventoryComplete=True'
)
$inventoryLines += $files | ForEach-Object { 'File=' + [System.IO.Path]::GetFileName($_) }
$inventoryLines += 'File=' + [System.IO.Path]::GetFileName($inventoryPath)
Write-Lines -Path $inventoryPath -Lines $inventoryLines
Assert-Inventory -Paths ($files + $inventoryPath)

if ($process.ExitCode -ne 0 -or $stderrLength -ne 0 -or -not $markerContract -or -not $protectedContract) {
    exit $(if ($process.ExitCode -ne 0) { $process.ExitCode } else { 1 })
}
Write-Output 'TASK_0023ZF_CAPTURE_EXECUTE_PASS'
exit 0
