[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateSet('Qualify', 'Execute')]
    [string]$Mode,

    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$EvidenceRoot,

    [ValidateRange(0, 2147483647)]
    [int]$AttemptNumber = 0,

    [string]$ScriptPath = '',

    [ValidateNotNullOrEmpty()]
    [string]$RepositoryRoot = 'D:\Delayed_Self',

    [ValidateNotNullOrEmpty()]
    [string]$GodotPath = 'D:\Program Files (x86)\Steam\steamapps\common\Godot Engine\godot.windows.opt.tools.64.exe'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$parserScript = 'res://tests/app/task_0023zd_full_matrix_parser_smoke.gd'
$fullMatrixScript = 'res://tests/app/task_0023zd_app_root_profile_session_full_matrix.gd'
$executionGuard = '--task-0023zn-fixture-execution'
$parserMarker = 'TASK_0023ZM_FULL_MATRIX_PARSER_SMOKE_PASS'
$fullMatrixMarker = 'TASK_0023ZN_APP_ROOT_PROFILE_SESSION_FULL_MATRIX_PASS'
$userDataRoot = Join-Path $env:APPDATA 'Godot\app_userdata\Delayed Self'
$productionProfile = Join-Path $userDataRoot 'delayed_self_profile.json'
$testRoot = Join-Path $userDataRoot 'delayed_self_test_profiles'
$futureFixtureDirectory = Join-Path $testRoot 'task_0023zn_app_root_profile_session'
$futureTarget = Join-Path $futureFixtureDirectory 'delayed_self_profile.json'

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

if ($Mode -eq 'Qualify') {
    if ($AttemptNumber -ne 0) {
        throw 'Qualify mode does not accept an attempt number.'
    }
    if (-not [string]::IsNullOrEmpty($ScriptPath) -and $ScriptPath -ne $parserScript) {
        throw 'Qualify mode may run only the parser smoke.'
    }
    $ScriptPath = $parserScript
}
else {
    if ($AttemptNumber -le 0) {
        throw 'Execute mode requires a positive attempt number.'
    }
    if ([string]::IsNullOrEmpty($ScriptPath)) {
        $ScriptPath = $fullMatrixScript
    }
    if ($ScriptPath -ne $fullMatrixScript) {
        throw 'Execute mode may run only the exact future full-matrix script.'
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

function Get-FutureFixtureExactState {
    $lines = @(
        'FixtureDirectoryExists=' + (Test-Path -LiteralPath $futureFixtureDirectory -PathType Container),
        'TargetExists=' + (Test-Path -LiteralPath $futureTarget -PathType Leaf)
    )
    foreach ($kind in @('temp', 'transaction', 'recovery')) {
        foreach ($index in 0..7) {
            $ownedPath = Join-Path $futureFixtureDirectory ('.delayed_self_0023w_{0}_{1}.json' -f $kind, $index)
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

function Get-Sha256Hex {
    param([Parameter(Mandatory = $true)][string]$Path)
    $stream = $null
    $sha256 = $null
    try {
        $stream = [System.IO.File]::OpenRead($Path)
        $sha256 = [System.Security.Cryptography.SHA256]::Create()
        $bytes = $sha256.ComputeHash($stream)
        return ([System.BitConverter]::ToString($bytes)).Replace('-', '').ToLowerInvariant()
    }
    catch {
        return ''
    }
    finally {
        if ($null -ne $sha256) {
            $sha256.Dispose()
        }
        if ($null -ne $stream) {
            $stream.Dispose()
        }
    }
}

if ($Mode -eq 'Qualify') {
    $prefix = 'capture_qualification'
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
    $inventoryPath = Join-Path $resolvedEvidenceRoot ($prefix + '_inventory.txt')

    $processBefore = @(Get-GodotProcessSnapshot)
    $productionBefore = @(Get-ProductionMetadata)
    $testRootBefore = Get-TestRootExists
    Write-Lines -Path $processBeforePath -Lines $processBefore
    Write-Lines -Path $productionBeforePath -Lines $productionBefore
    Write-Lines -Path $testRootBeforePath -Lines @($testRootBefore)
    Write-Lines -Path $commandPath -Lines @('godot --headless --path D:\Delayed_Self --script ' + $parserScript)

    $arguments = @('--headless', '--path', $resolvedRepositoryRoot, '--script', $parserScript)
    $process = Start-Process -FilePath $GodotPath -ArgumentList $arguments -Wait -PassThru -NoNewWindow -RedirectStandardOutput $stdoutPath -RedirectStandardError $stderrPath
    Write-Lines -Path $exitPath -Lines @($process.ExitCode.ToString())

    $processAfter = @(Get-GodotProcessSnapshot)
    $productionAfter = @(Get-ProductionMetadata)
    $testRootAfter = Get-TestRootExists
    Write-Lines -Path $processAfterPath -Lines $processAfter
    Write-Lines -Path $productionAfterPath -Lines $productionAfter
    Write-Lines -Path $testRootAfterPath -Lines @($testRootAfter)

    $qualificationFiles = @(
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
    Assert-Inventory -Paths $qualificationFiles
    $stdout = [System.IO.File]::ReadAllText($stdoutPath)
    $stderrLength = (Get-Item -LiteralPath $stderrPath).Length
    $markerCount = ([regex]::Matches($stdout, [regex]::Escape($parserMarker))).Count
    $portableHashPath = Join-Path $resolvedEvidenceRoot 'capture_qualification_portable_sha256.tmp'
    try {
        [System.IO.File]::WriteAllBytes($portableHashPath, [byte[]]@())
        $portableSha256Passed = (Get-Sha256Hex -Path $portableHashPath) -eq 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'
    }
    finally {
        if (Test-Path -LiteralPath $portableHashPath -PathType Leaf) {
            Remove-Item -LiteralPath $portableHashPath -Force
        }
    }
    $qualificationPassed = (
        $process.ExitCode -eq 0 -and
        $stderrLength -eq 0 -and
        $markerCount -eq 1 -and
        ($processBefore -join "`n") -eq 'Count=0' -and
        ($processAfter -join "`n") -eq 'Count=0' -and
        ($productionBefore -join "`n") -eq ($productionAfter -join "`n") -and
        $testRootBefore -eq $testRootAfter -and
        $portableSha256Passed
    )
    $inventoryLines = @(
        'Mode=Qualify',
        ('Script=' + $parserScript),
        'ExecutionGuardPassed=False',
        ('ExitCode=' + $process.ExitCode),
        ('StderrLength=' + $stderrLength),
        ('ParserMarkerCount=' + $markerCount),
        ('PortableSha256Passed=' + $portableSha256Passed),
        ('ProductionMetadataUnchanged=' + (($productionBefore -join "`n") -eq ($productionAfter -join "`n"))),
        ('TestRootExistenceUnchanged=' + ($testRootBefore -eq $testRootAfter)),
        ('ProcessBeforeZero=' + (($processBefore -join "`n") -eq 'Count=0')),
        ('ProcessAfterZero=' + (($processAfter -join "`n") -eq 'Count=0')),
        ('QualificationPassed=' + $qualificationPassed)
    )
    $inventoryLines += $qualificationFiles | ForEach-Object { 'File=' + [System.IO.Path]::GetFileName($_) }
    $inventoryLines += 'File=' + [System.IO.Path]::GetFileName($inventoryPath)
    Write-Lines -Path $inventoryPath -Lines $inventoryLines
    Assert-Inventory -Paths ($qualificationFiles + $inventoryPath)
    if (-not $qualificationPassed) {
        throw 'Parser capture qualification failed.'
    }
    Write-Output 'TASK_0023ZM_CAPTURE_QUALIFICATION_PASS'
    exit 0
}

$attemptPrefix = 'attempt_' + $AttemptNumber
$commandPath = Join-Path $resolvedEvidenceRoot ($attemptPrefix + '_command.txt')
$stdoutPath = Join-Path $resolvedEvidenceRoot ($attemptPrefix + '_stdout.txt')
$stderrPath = Join-Path $resolvedEvidenceRoot ($attemptPrefix + '_stderr.txt')
$exitPath = Join-Path $resolvedEvidenceRoot ($attemptPrefix + '_exit_code.txt')
$processBeforePath = Join-Path $resolvedEvidenceRoot ($attemptPrefix + '_process_before.txt')
$processAfterPath = Join-Path $resolvedEvidenceRoot ($attemptPrefix + '_process_after.txt')
$productionBeforePath = Join-Path $resolvedEvidenceRoot ($attemptPrefix + '_production_metadata_before.txt')
$productionAfterPath = Join-Path $resolvedEvidenceRoot ($attemptPrefix + '_production_metadata_after.txt')
$testRootBeforePath = Join-Path $resolvedEvidenceRoot ($attemptPrefix + '_test_root_exists_before.txt')
$testRootAfterPath = Join-Path $resolvedEvidenceRoot ($attemptPrefix + '_test_root_exists_after.txt')
$fixtureBeforePath = Join-Path $resolvedEvidenceRoot ($attemptPrefix + '_fixture_exact_state_before.txt')
$fixtureAfterPath = Join-Path $resolvedEvidenceRoot ($attemptPrefix + '_fixture_exact_state_after.txt')
$patchPath = Join-Path $resolvedEvidenceRoot ($attemptPrefix + '_worktree.patch')
$patchHashPath = Join-Path $resolvedEvidenceRoot ($attemptPrefix + '_worktree_patch_sha256.txt')
$stageSummaryPath = Join-Path $resolvedEvidenceRoot ($attemptPrefix + '_stage_summary.txt')
$classificationPath = Join-Path $resolvedEvidenceRoot ($attemptPrefix + '_classification.txt')
$inventoryPath = Join-Path $resolvedEvidenceRoot ($attemptPrefix + '_inventory.txt')

$processBefore = @(Get-GodotProcessSnapshot)
$productionBefore = @(Get-ProductionMetadata)
$testRootBefore = Get-TestRootExists
$fixtureBefore = @(Get-FutureFixtureExactState)
Write-Lines -Path $processBeforePath -Lines $processBefore
Write-Lines -Path $productionBeforePath -Lines $productionBefore
Write-Lines -Path $testRootBeforePath -Lines @($testRootBefore)
Write-Lines -Path $fixtureBeforePath -Lines $fixtureBefore
Write-Lines -Path $commandPath -Lines @('godot --headless --path D:\Delayed_Self --script ' + $fullMatrixScript + ' -- ' + $executionGuard)

$arguments = @('--headless', '--path', $resolvedRepositoryRoot, '--script', $fullMatrixScript, '--', $executionGuard)
$process = Start-Process -FilePath $GodotPath -ArgumentList $arguments -Wait -PassThru -NoNewWindow -RedirectStandardOutput $stdoutPath -RedirectStandardError $stderrPath
Write-Lines -Path $exitPath -Lines @($process.ExitCode.ToString())

$attemptFiles = @(
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
    $stageSummaryPath,
    $classificationPath
)
$captureIncomplete = $false
$playerDataSafetyFault = $false
$patchCaptured = $false
$hashValid = $false
$stderrLength = -1
$successMarkerCount = 0
$stdout = ''
$processAfter = @('POST_STATE_UNAVAILABLE')
$productionAfter = @('POST_STATE_UNAVAILABLE')
$testRootAfter = 'POST_STATE_UNAVAILABLE'
$fixtureAfter = @('POST_STATE_UNAVAILABLE')
$initialClassification = 'UNCLASSIFIED_NONPASS'
$classification = 'DIAGNOSTIC_CAPTURE_INCOMPLETE'

try {
    try {
        $processAfter = @(Get-GodotProcessSnapshot)
        Write-Lines -Path $processAfterPath -Lines $processAfter
    }
    catch {
        $captureIncomplete = $true
        Write-Lines -Path $processAfterPath -Lines @('POST_STATE_UNAVAILABLE')
    }
    try {
        $productionAfter = @(Get-ProductionMetadata)
        Write-Lines -Path $productionAfterPath -Lines $productionAfter
    }
    catch {
        $captureIncomplete = $true
        Write-Lines -Path $productionAfterPath -Lines @('POST_STATE_UNAVAILABLE')
    }
    try {
        $testRootAfter = Get-TestRootExists
        Write-Lines -Path $testRootAfterPath -Lines @($testRootAfter)
    }
    catch {
        $captureIncomplete = $true
        Write-Lines -Path $testRootAfterPath -Lines @('POST_STATE_UNAVAILABLE')
    }
    try {
        $fixtureAfter = @(Get-FutureFixtureExactState)
        Write-Lines -Path $fixtureAfterPath -Lines $fixtureAfter
    }
    catch {
        $captureIncomplete = $true
        Write-Lines -Path $fixtureAfterPath -Lines @('POST_STATE_UNAVAILABLE')
    }

    try {
        $stdout = [System.IO.File]::ReadAllText($stdoutPath)
        $stageLines = @($stdout -split "`r?`n" | Where-Object { $_ -match '^TASK_0023ZN_(BEHAVIOR_PROCESS_STARTED|STAGE_BEGIN=|STAGE_PASS=|ASSERT_FAIL|ABORT|ASSERTIONS=|APP_ROOT_PROFILE_SESSION_FULL_MATRIX_PASS)' })
        Write-Lines -Path $stageSummaryPath -Lines $stageLines
        $stderrLength = (Get-Item -LiteralPath $stderrPath).Length
        $successMarkerCount = ([regex]::Matches($stdout, [regex]::Escape($fullMatrixMarker))).Count
        $initialClassification = if ($stdout.Contains('TASK_0023ZN_ABORT')) { 'CONTROLLED_ABORT' } elseif ($stdout.Contains('TASK_0023ZN_ASSERT_FAIL')) { 'ASSERTION_FAILURE' } elseif ($process.ExitCode -ne 0 -or $stderrLength -ne 0) { 'PROCESS_OR_RUNTIME_FAILURE' } elseif ($process.ExitCode -eq 0 -and $stderrLength -eq 0 -and $successMarkerCount -eq 1) { 'PASS_CANDIDATE' } else { 'UNCLASSIFIED_NONPASS' }
        Write-Lines -Path $classificationPath -Lines @('Classification=INITIAL_' + $initialClassification)
    }
    catch {
        $captureIncomplete = $true
        Write-Lines -Path $stageSummaryPath -Lines @('STAGE_SUMMARY_UNAVAILABLE')
        Write-Lines -Path $classificationPath -Lines @('Classification=INITIAL_DIAGNOSTIC_CAPTURE_INCOMPLETE')
    }

    try {
        $patchProcess = Start-Process -FilePath 'git' -ArgumentList @('-C', $resolvedRepositoryRoot, 'diff', '--binary', '--no-ext-diff') -Wait -PassThru -NoNewWindow -RedirectStandardOutput $patchPath
        if ($patchProcess.ExitCode -ne 0) {
            throw 'PATCH_CAPTURE_FAILED'
        }
        $patchCaptured = $true
    }
    catch {
        $captureIncomplete = $true
        Write-Lines -Path $patchPath -Lines @('PATCH_CAPTURE_FAILED')
    }

    if ($patchCaptured) {
        $patchHash = Get-Sha256Hex -Path $patchPath
        $hashValid = $patchHash -match '^[0-9a-f]{64}$'
        if ($hashValid) {
            Write-Lines -Path $patchHashPath -Lines @($patchHash)
        }
        else {
            $captureIncomplete = $true
            Write-Lines -Path $patchHashPath -Lines @('HASH_UNAVAILABLE')
        }
    }
    else {
        Write-Lines -Path $patchHashPath -Lines @('HASH_UNAVAILABLE')
    }
}
finally {
    $productionUnchanged = ($productionBefore -join "`n") -eq ($productionAfter -join "`n")
    $testRootUnchanged = $testRootBefore -eq $testRootAfter
    $processAfterZero = ($processAfter -join "`n") -eq 'Count=0'
    if (-not $productionUnchanged -or -not $testRootUnchanged) {
        $playerDataSafetyFault = $true
    }
    $preInventoryComplete = @($attemptFiles | Where-Object { -not (Test-Path -LiteralPath $_ -PathType Leaf) }).Count -eq 0
    if (-not $preInventoryComplete) {
        $captureIncomplete = $true
    }
    $classification = if ($playerDataSafetyFault) {
        'PLAYER_DATA_SAFETY_FAULT'
    }
    elseif ($captureIncomplete -or -not $hashValid) {
        'DIAGNOSTIC_CAPTURE_INCOMPLETE'
    }
    else {
        $initialClassification
    }
    Write-Lines -Path $classificationPath -Lines @(
        ('Classification=' + $classification),
        ('InitialClassification=' + $initialClassification),
        ('ExitCode=' + $process.ExitCode),
        ('StderrLength=' + $stderrLength),
        ('SuccessMarkerCount=' + $successMarkerCount),
        ('PatchCaptured=' + $patchCaptured),
        ('PatchHashValid=' + $hashValid),
        ('ProductionMetadataUnchanged=' + $productionUnchanged),
        ('TestRootExistenceUnchanged=' + $testRootUnchanged),
        ('ProcessAfterZero=' + $processAfterZero),
        ('CaptureIncomplete=' + $captureIncomplete)
    )
    $inventoryLines = @(
        'Mode=Execute',
        ('AttemptNumber=' + $AttemptNumber),
        ('Script=' + $fullMatrixScript),
        'ExecutionGuardPassed=True',
        ('Classification=' + $classification),
        ('InventoryComplete=' + $preInventoryComplete)
    )
    $inventoryLines += $attemptFiles | ForEach-Object { 'File=' + [System.IO.Path]::GetFileName($_) }
    $inventoryLines += 'File=' + [System.IO.Path]::GetFileName($inventoryPath)
    Write-Lines -Path $inventoryPath -Lines $inventoryLines
}

Assert-Inventory -Paths ($attemptFiles + $inventoryPath)
if ($classification -ne 'PASS_CANDIDATE') {
    exit $(if ($process.ExitCode -ne 0) { $process.ExitCode } else { 1 })
}
exit 0
