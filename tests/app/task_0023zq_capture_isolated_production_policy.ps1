param(
    [ValidateSet('Qualification', 'PostQualification', 'Attempt')]
    [string]$Mode = 'Attempt',

    [ValidateSet('attempt_1', 'attempt_2')]
    [string]$AttemptId = '',

    [Parameter(Mandatory = $true)]
    [string]$GodotExe
)

$ErrorActionPreference = 'Stop'
$RepoRoot = 'D:\Delayed_Self'
$HistoricalEvidenceRoot = 'D:\Delayed_Self_Evidence\0023ZQ_isolated_production_policy_matrix'
$RetryRoot = Join-Path $HistoricalEvidenceRoot '0023ZS_disclosure_scanner_retry'
$ManifestPath = Join-Path $RepoRoot 'tests\app\task_0023zq_isolated_production_policy_manifest.json'
$CaseScript = 'res://tests/app/task_0023zq_isolated_production_policy_case.gd'
$ParserScript = 'res://tests/app/task_0023zq_isolated_production_policy_parser_smoke.gd'
$AllowedOwnedNames = @('appdata', 'localappdata', 'case_data')

function Assert-ExactOwnedPath {
    param([string]$Path)
    $attemptFull = [IO.Path]::GetFullPath($AttemptRoot).TrimEnd('\')
    $pathFull = [IO.Path]::GetFullPath($Path).TrimEnd('\')
    if (-not $pathFull.StartsWith($attemptFull + '\', [StringComparison]::OrdinalIgnoreCase)) {
        throw 'Owned path escaped the attempt root.'
    }
    $leaf = Split-Path -Leaf $pathFull
    if ($AllowedOwnedNames -notcontains $leaf) {
        throw 'Owned cleanup path is not allowlisted.'
    }
}

function Remove-ExactOwnedTree {
    param([string]$Path)
    Assert-ExactOwnedPath -Path $Path
    if (Test-Path -LiteralPath $Path) {
        Remove-Item -LiteralPath $Path -Recurse -Force
    }
}

function New-ExactDirectory {
    param([string]$Path)
    if (-not (Test-Path -LiteralPath $Path)) {
        New-Item -ItemType Directory -Path $Path | Out-Null
    }
    $item = Get-Item -LiteralPath $Path -Force
    if (($item.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
        throw 'Reparse point is forbidden in an owned sandbox.'
    }
}

function Invoke-BoundedGodotProcess {
    param(
        [Parameter(Mandatory = $true)]
        [string[]]$GodotArguments,

        [hashtable]$ChildEnvironment = @{}
    )

    $psi = [System.Diagnostics.ProcessStartInfo]::new()
    $psi.FileName = $GodotExe
    $psi.WorkingDirectory = $RepoRoot
    $psi.UseShellExecute = $false
    $psi.CreateNoWindow = $true
    $psi.RedirectStandardOutput = $true
    $psi.RedirectStandardError = $true
    foreach ($argument in $GodotArguments) {
        [void]$psi.ArgumentList.Add([string]$argument)
    }
    foreach ($name in $ChildEnvironment.Keys) {
        $psi.EnvironmentVariables[[string]$name] = [string]$ChildEnvironment[$name]
    }

    $process = [System.Diagnostics.Process]::new()
    $process.StartInfo = $psi
    try {
        if (-not $process.Start()) { throw 'Godot process did not start.' }
        $stdoutTask = $process.StandardOutput.ReadToEndAsync()
        $stderrTask = $process.StandardError.ReadToEndAsync()
        $process.WaitForExit()
        return [pscustomobject]@{
            stdout = $stdoutTask.GetAwaiter().GetResult()
            stderr = $stderrTask.GetAwaiter().GetResult()
            exit_code = $process.ExitCode
        }
    }
    finally {
        $process.Dispose()
    }
}

function Count-Marker {
    param([string]$Text, [string]$Marker)
    return ([regex]::Matches($Text, [regex]::Escape($Marker))).Count
}

function Test-WindowsAbsoluteDrivePath {
    param([string]$Text)
    return [regex]::IsMatch($Text, '(?<![A-Za-z0-9+.\-])[A-Za-z]:[\\/]')
}

function Test-UncPath {
    param([string]$Text)
    return [regex]::IsMatch($Text, '\\\\[^\\/\s]+\\[^\\/\s]+')
}

function Test-ForbiddenDisclosure {
    param([string]$Text)
    if (Test-WindowsAbsoluteDrivePath $Text) { return $false }
    if (Test-UncPath $Text) { return $false }
    $forbidden = @(
        'delayed_self_profile.json',
        '.delayed_self_profile_',
        'profile_schema_version',
        '"progress"',
        '"settings"',
        'FileAccess',
        'DirAccess',
        'RefCounted#',
        'Object#',
        '=99'
    )
    foreach ($token in $forbidden) {
        if ($Text.Contains($token)) { return $false }
    }
    return $true
}

if ([IO.Path]::GetFullPath((Get-Location).Path).TrimEnd('\') -ne [IO.Path]::GetFullPath($RepoRoot).TrimEnd('\')) {
    throw 'Repository root mismatch.'
}
if (-not (Test-Path -LiteralPath $GodotExe -PathType Leaf)) {
    throw 'Godot executable missing.'
}
if (-not (Test-Path -LiteralPath $ManifestPath -PathType Leaf)) {
    throw 'Manifest missing.'
}
if ($Mode -in @('Qualification', 'PostQualification')) {
    if (-not $GodotExe.Contains(' ')) {
        throw 'Qualification requires a Godot executable path containing spaces.'
    }
    $isPreQualification = $Mode -eq 'Qualification'
    if ($isPreQualification -and (Test-Path -LiteralPath $RetryRoot)) {
        throw 'Fresh retry root must be absent during pre-qualification.'
    }
    if (-not $isPreQualification) {
        if (-not (Test-Path -LiteralPath $RetryRoot -PathType Container)) {
            throw 'Post-qualification requires the retry root.'
        }
        foreach ($attempt in @('attempt_1', 'attempt_2')) {
            $summaryPath = Join-Path $RetryRoot ($attempt + '\audit\attempt_summary.json')
            if (-not (Test-Path -LiteralPath $summaryPath -PathType Leaf)) {
                throw 'Post-qualification requires both attempt summaries.'
            }
            $summary = Get-Content -Raw -LiteralPath $summaryPath | ConvertFrom-Json
            if ($summary.classification -ne 'PASS_COMPLETE_MATRIX' -or -not [bool]$summary.cleanup_complete) {
                throw 'Post-qualification requires two complete cleaned attempts.'
            }
        }
    }
    $qualificationEvidenceRoot = $(if ($isPreQualification) { $HistoricalEvidenceRoot } else { $RetryRoot })
    $qualificationPrefix = $(if ($isPreQualification) { '0023zs_scanner_qualification' } else { 'post_scanner_qualification' })
    $qualificationStdout = Join-Path $qualificationEvidenceRoot ($qualificationPrefix + '.stdout.txt')
    $qualificationStderr = Join-Path $qualificationEvidenceRoot ($qualificationPrefix + '.stderr.txt')
    $qualificationAudit = Join-Path $qualificationEvidenceRoot ($qualificationPrefix + '.audit.json')
    $qualificationLog = Join-Path $qualificationEvidenceRoot ($qualificationPrefix + '.engine.txt')
    foreach ($path in @($qualificationStdout, $qualificationStderr, $qualificationAudit, $qualificationLog)) {
        if (Test-Path -LiteralPath $path) {
            throw 'Qualification evidence must be absent before the one authorized run.'
        }
    }
    $drivePositiveVectors = @(
        'C:\Users\player\profile.json',
        'D:/Sandbox/file.txt',
        'path=E:\x\y',
        '"F:/quoted/path"',
        'file:///C:/Users/player/file.txt'
    )
    $uncPositiveVectors = @('\\server\share\file.txt')
    $driveNegativeVectors = @(
        'https://godotengine.org',
        'http://example.invalid/a',
        'Godot Engine v4.x - https://godotengine.org',
        'res://scenes/app/app_root.tscn',
        'user://delayed_self_profile.json'
    )
    $scannerAssertions = 0
    $scannerFailures = 0
    foreach ($vector in $drivePositiveVectors) {
        $scannerAssertions += 1
        if (-not (Test-WindowsAbsoluteDrivePath $vector)) { $scannerFailures += 1 }
    }
    foreach ($vector in $uncPositiveVectors) {
        $scannerAssertions += 1
        if (-not (Test-UncPath $vector) -or (Test-WindowsAbsoluteDrivePath $vector)) { $scannerFailures += 1 }
    }
    foreach ($vector in $driveNegativeVectors) {
        $scannerAssertions += 1
        if (Test-WindowsAbsoluteDrivePath $vector) { $scannerFailures += 1 }
    }
    if ($scannerAssertions -ne 11 -or $scannerFailures -ne 0) {
        throw 'Disclosure scanner deterministic qualification failed.'
    }
    $qualificationArguments = @(
        '--headless',
        '--path', $RepoRoot,
        '--log-file', $qualificationLog,
        '--script', $ParserScript
    )
    $qualificationResult = Invoke-BoundedGodotProcess -GodotArguments $qualificationArguments
    [IO.File]::WriteAllText($qualificationStdout, [string]$qualificationResult.stdout, [Text.UTF8Encoding]::new($false))
    [IO.File]::WriteAllText($qualificationStderr, [string]$qualificationResult.stderr, [Text.UTF8Encoding]::new($false))
    $parserMarker = 'TASK_0023ZQ_ISOLATED_PRODUCTION_POLICY_PARSER_SMOKE_PASS'
    $qualificationChecks = @(
        ([int]$qualificationResult.exit_code -eq 0),
        ([string]$qualificationResult.stderr -eq ''),
        ((Count-Marker ([string]$qualificationResult.stdout) $parserMarker) -eq 1),
        ((Count-Marker ([string]$qualificationResult.stdout) 'TASK_0023ZQ_BEHAVIOR_STARTED') -eq 0),
        ((Count-Marker ([string]$qualificationResult.stdout) 'TASK_0023ZQ_SANDBOX_ATTESTED') -eq 0),
        ((Count-Marker ([string]$qualificationResult.stdout) 'TASK_0023ZQ_CASE_') -eq 0),
        (-not (Test-WindowsAbsoluteDrivePath ([string]$qualificationResult.stdout))),
        (Test-ForbiddenDisclosure ([string]$qualificationResult.stdout + "`n" + [string]$qualificationResult.stderr)),
        ($isPreQualification -eq (-not (Test-Path -LiteralPath $RetryRoot)))
    )
    $qualificationPass = -not ($qualificationChecks -contains $false)
    $argumentAudit = @()
    for ($index = 0; $index -lt $qualificationArguments.Count; $index++) {
        $argumentAudit += [ordered]@{index=$index; type=$qualificationArguments[$index].GetType().FullName}
    }
    [ordered]@{
        classification=$(if ($qualificationPass) { 'PASS_DISCLOSURE_SCANNER_AND_INVOCATION_BINDING' } else { 'FAILED_DISCLOSURE_SCANNER_OR_INVOCATION_BINDING' })
        qualification_phase=$(if ($isPreQualification) { 'PRE_BEHAVIOR' } else { 'POST_BEHAVIOR' })
        scanner_assertions=$scannerAssertions
        scanner_failures=$scannerFailures
        drive_positive_count=$drivePositiveVectors.Count
        unc_positive_count=$uncPositiveVectors.Count
        drive_negative_count=$driveNegativeVectors.Count
        banner_drive_path_hit=$(Test-WindowsAbsoluteDrivePath ([string]$qualificationResult.stdout))
        banner_forbidden_disclosure_hit=-not (Test-ForbiddenDisclosure ([string]$qualificationResult.stdout + "`n" + [string]$qualificationResult.stderr))
        godot_path_contains_space=$GodotExe.Contains(' ')
        argument_count=$qualificationArguments.Count
        arguments=$argumentAudit
        native_exit=[int]$qualificationResult.exit_code
        stderr_bytes=[Text.Encoding]::UTF8.GetByteCount([string]$qualificationResult.stderr)
        parser_marker_count=$(Count-Marker ([string]$qualificationResult.stdout) $parserMarker)
        behavior_marker_count=$(Count-Marker ([string]$qualificationResult.stdout) 'TASK_0023ZQ_BEHAVIOR_STARTED')
        sandbox_marker_count=$(Count-Marker ([string]$qualificationResult.stdout) 'TASK_0023ZQ_SANDBOX_ATTESTED')
        case_marker_count=$(Count-Marker ([string]$qualificationResult.stdout) 'TASK_0023ZQ_CASE_')
        retry_root_state_valid=($isPreQualification -eq (-not (Test-Path -LiteralPath $RetryRoot)))
    } | ConvertTo-Json -Depth 4 | Set-Content -Encoding UTF8 -LiteralPath $qualificationAudit
    if (-not $qualificationPass) {
        Write-Output 'TASK_0023ZS_DISCLOSURE_SCANNER_QUALIFICATION_FAIL'
        exit 1
    }
    Write-Output ('TASK_0023ZS_DISCLOSURE_SCANNER_ASSERTIONS=' + [string]$scannerAssertions)
    Write-Output 'TASK_0023ZS_DISCLOSURE_SCANNER_QUALIFICATION_PASS'
    exit 0
}
if ([string]::IsNullOrWhiteSpace($AttemptId)) {
    throw 'Attempt mode requires an attempt id.'
}
$AttemptRoot = Join-Path $RetryRoot $AttemptId
if (Test-Path -LiteralPath $AttemptRoot) {
    throw 'Attempt root must be absent.'
}
if ($AttemptId -eq 'attempt_2') {
    $attemptOneSummary = Join-Path $RetryRoot 'attempt_1\audit\attempt_summary.json'
    if (-not (Test-Path -LiteralPath $attemptOneSummary -PathType Leaf)) {
        throw 'Attempt 1 complete-pass evidence is required before Attempt 2.'
    }
    $attemptOne = Get-Content -LiteralPath $attemptOneSummary -Raw | ConvertFrom-Json
    if ($attemptOne.classification -ne 'PASS_COMPLETE_MATRIX' -or -not [bool]$attemptOne.cleanup_complete) {
        throw 'Attempt 1 did not complete or clean up.'
    }
}

$manifest = Get-Content -LiteralPath $ManifestPath -Raw | ConvertFrom-Json
$cases = @($manifest.cases)
if ($cases.Count -ne [int]$manifest.expected_assertion_count) {
    throw 'Manifest assertion cardinality mismatch.'
}

New-Item -ItemType Directory -Path $AttemptRoot | Out-Null
$stdoutRoot = Join-Path $AttemptRoot 'stdout'
$stderrRoot = Join-Path $AttemptRoot 'stderr'
$auditRoot = Join-Path $AttemptRoot 'audit'
$appdataRoot = Join-Path $AttemptRoot 'appdata'
$localappdataRoot = Join-Path $AttemptRoot 'localappdata'
$caseDataRoot = Join-Path $AttemptRoot 'case_data'
foreach ($path in @($stdoutRoot, $stderrRoot, $auditRoot)) {
    New-ExactDirectory -Path $path
}

@(
    "attempt=$AttemptId",
    'APPDATA=OWNED_ATTEMPT_APPDATA',
    'LOCALAPPDATA=OWNED_ATTEMPT_LOCALAPPDATA',
    'guard=TASK_0023ZQ_EXECUTE',
    'assignment_scope=CHILD_PROCESS_ONLY'
) | Set-Content -Encoding UTF8 -LiteralPath (Join-Path $auditRoot 'environment_assignments.txt')

$results = @()
$markerRows = @()
$classification = 'INCOMPLETE'
$cleanupComplete = $false
$failureMessage = ''

try {
    foreach ($case in $cases) {
        foreach ($owned in @($appdataRoot, $localappdataRoot, $caseDataRoot)) {
            Remove-ExactOwnedTree -Path $owned
            New-ExactDirectory -Path $owned
        }

        $caseId = [string]$case.id
        $stdoutPath = Join-Path $stdoutRoot ($caseId + '.stdout.txt')
        $stderrPath = Join-Path $stderrRoot ($caseId + '.stderr.txt')
        $engineLogPath = Join-Path $auditRoot ($caseId + '.engine.txt')

        $godotArguments = @(
            '--headless',
            '--path', $RepoRoot,
            '--log-file', $engineLogPath,
            '--script', $CaseScript
        )
        $childEnvironment = @{
            'APPDATA' = $appdataRoot
            'LOCALAPPDATA' = $localappdataRoot
            'DELAYED_SELF_0023ZQ_EXECUTION_GUARD' = 'TASK_0023ZQ_EXECUTE'
            'DELAYED_SELF_0023ZQ_ATTEMPT' = $AttemptId
            'DELAYED_SELF_0023ZQ_CASE' = $caseId
        }
        $processResult = Invoke-BoundedGodotProcess -GodotArguments $godotArguments -ChildEnvironment $childEnvironment
        $stdout = [string]$processResult.stdout
        $stderr = [string]$processResult.stderr
        $exitCode = [int]$processResult.exit_code
        [IO.File]::WriteAllText($stdoutPath, $stdout, [Text.UTF8Encoding]::new($false))
        [IO.File]::WriteAllText($stderrPath, $stderr, [Text.UTF8Encoding]::new($false))

        $counts = [ordered]@{
            sandbox_attested = Count-Marker $stdout 'TASK_0023ZQ_SANDBOX_ATTESTED'
            behavior_started = Count-Marker $stdout ('TASK_0023ZQ_BEHAVIOR_STARTED case=' + $caseId)
            stage = Count-Marker $stdout ('TASK_0023ZQ_STAGE=' + [string]$case.stage)
            assert_pass = Count-Marker $stdout ('TASK_0023ZQ_ASSERT_PASS case=' + $caseId)
            case_status = Count-Marker $stdout ('TASK_0023ZQ_CASE_STATUS=' + [string]$case.expected_status)
            case_pass = Count-Marker $stdout ('TASK_0023ZQ_CASE_PASS case=' + $caseId)
        }
        $markersOk = $true
        foreach ($markerName in $counts.Keys) {
            $expectedCount = [int]$manifest.expected_markers_per_case.$markerName
            $actualCount = [int]$counts[$markerName]
            if ($actualCount -ne $expectedCount) { $markersOk = $false }
            $markerRows += [pscustomobject]@{case_id=$caseId; marker=$markerName; expected=$expectedCount; actual=$actualCount; pass=($actualCount -eq $expectedCount)}
        }
        $bounded = Test-ForbiddenDisclosure ($stdout + "`n" + $stderr)
        $casePass = $exitCode -eq 0 -and $stderr.Length -eq 0 -and $markersOk -and $bounded -and -not $stdout.Contains('TASK_0023ZQ_ASSERT_FAIL') -and -not $stdout.Contains('TASK_0023ZQ_ABORT')
        $results += [pscustomobject]@{case_id=$caseId; stage=[string]$case.stage; expected_status=[string]$case.expected_status; exit=$exitCode; stderr_bytes=[Text.Encoding]::UTF8.GetByteCount($stderr); markers_ok=$markersOk; disclosure_ok=$bounded; pass=$casePass}
        if (-not $casePass) {
            throw ('Case failed: ' + $caseId)
        }

        $unexpectedAppdataFiles = @(Get-ChildItem -LiteralPath $appdataRoot -Recurse -Force -File -ErrorAction SilentlyContinue)
        $unexpectedLocalFiles = @(Get-ChildItem -LiteralPath $localappdataRoot -Recurse -Force -File -ErrorAction SilentlyContinue)
        if ($unexpectedAppdataFiles.Count -ne 0 -or $unexpectedLocalFiles.Count -ne 0) {
            throw ('Unexpected sandbox residue after case: ' + $caseId)
        }
    }
    $classification = 'PASS_COMPLETE_MATRIX'
}
catch {
    $failureMessage = 'BOUNDED_ATTEMPT_FAILURE'
    $classification = 'FAILED'
}
finally {
    $results | Export-Csv -NoTypeInformation -Encoding UTF8 -LiteralPath (Join-Path $auditRoot 'case_results.csv')
    $markerRows | Export-Csv -NoTypeInformation -Encoding UTF8 -LiteralPath (Join-Path $auditRoot 'marker_cardinality.csv')
    ('forbidden_disclosure_scan=' + ($(if (($results | Where-Object { -not $_.disclosure_ok }).Count -eq 0) { 'PASS' } else { 'FAIL' }))) | Set-Content -Encoding UTF8 -LiteralPath (Join-Path $auditRoot 'forbidden_disclosure.txt')
    foreach ($owned in @($appdataRoot, $localappdataRoot, $caseDataRoot)) {
        Remove-ExactOwnedTree -Path $owned
    }
    $cleanupComplete = -not (Test-Path -LiteralPath $appdataRoot) -and -not (Test-Path -LiteralPath $localappdataRoot) -and -not (Test-Path -LiteralPath $caseDataRoot)
    [ordered]@{attempt=$AttemptId; cleanup_complete=$cleanupComplete; retained_roots=@('stdout','stderr','audit')} | ConvertTo-Json | Set-Content -Encoding UTF8 -LiteralPath (Join-Path $auditRoot 'cleanup.json')
    [ordered]@{attempt=$AttemptId; classification=$classification; cases_expected=$cases.Count; cases_passed=@($results | Where-Object {$_.pass}).Count; assertions_expected=[int]$manifest.expected_assertion_count; cleanup_complete=$cleanupComplete; failure=$failureMessage} | ConvertTo-Json | Set-Content -Encoding UTF8 -LiteralPath (Join-Path $auditRoot 'attempt_summary.json')
}

foreach ($relative in @($manifest.required_attempt_evidence)) {
    if (-not (Test-Path -LiteralPath (Join-Path $AttemptRoot ([string]$relative)) -PathType Leaf)) {
        throw 'Required attempt evidence missing.'
    }
}
if ($classification -ne 'PASS_COMPLETE_MATRIX' -or -not $cleanupComplete) {
    Write-Output 'TASK_0023ZQ_ATTEMPT_ABORTED'
    exit 1
}

Write-Output ('TASK_0023ZQ_ATTEMPT=' + $AttemptId)
Write-Output ('TASK_0023ZQ_ASSERTIONS=' + [string]$manifest.expected_assertion_count)
Write-Output 'TASK_0023ZQ_ATTEMPT_CLASSIFICATION=PASS_COMPLETE_MATRIX'
exit 0
