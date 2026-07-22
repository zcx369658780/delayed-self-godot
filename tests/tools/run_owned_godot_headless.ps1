[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$GodotPath,
    [Parameter(Mandatory)][string]$ProjectPath,
    [Parameter(Mandatory)][string]$ScriptPath,
    [int]$TimeoutSeconds = 60,
    [int]$GraceSeconds = 3,
    [string[]]$ExtraArguments = @(),
    [string]$RequiredMarker = '',
    [ValidateSet('Allow', 'ForbidNonempty')][string]$StderrPolicy = 'Allow',
    [string[]]$AllowedGodotDescendantTokens = @()
)

$ErrorActionPreference = 'Stop'
if ($PSVersionTable.PSVersion.Major -lt 7) {
    throw 'PowerShell 7 or newer is required for ProcessStartInfo.ArgumentList'
}

$maxDescendants = 64
$maxOutputLines = 200

function Normalize-PathIdentity {
    param([string]$Value)

    if ([string]::IsNullOrWhiteSpace($Value)) {
        return ''
    }
    return [IO.Path]::GetFullPath($Value).TrimEnd('\').ToLowerInvariant()
}

function Normalize-WindowsPathIdentity {
    param([Parameter(Mandatory)][string]$Value)

    $candidate = $Value
    if ($candidate.Length -ge 2 -and $candidate.StartsWith('"') -and $candidate.EndsWith('"')) {
        $candidate = $candidate.Substring(1, $candidate.Length - 2)
    }
    elseif ($candidate.StartsWith('"') -or $candidate.EndsWith('"')) {
        throw 'Unbalanced syntactic path quoting'
    }
    if ([string]::IsNullOrWhiteSpace($candidate)) {
        throw 'Path identity is empty'
    }
    $candidate = $candidate.Replace('/', '\')
    if (-not [IO.Path]::IsPathFullyQualified($candidate)) {
        throw 'Path identity is not fully qualified'
    }
    $fullPath = [IO.Path]::GetFullPath($candidate)
    $root = [IO.Path]::GetPathRoot($fullPath)
    if ($fullPath.Length -gt $root.Length) {
        $fullPath = $fullPath.TrimEnd('\')
    }
    return $fullPath
}

function ConvertFrom-WindowsCommandLine {
    param([Parameter(Mandatory)][string]$CommandLine)

    if ($null -eq ('OwnedGodotCommandLine.NativeMethods' -as [type])) {
        Add-Type -TypeDefinition @'
using System;
using System.Runtime.InteropServices;
namespace OwnedGodotCommandLine {
    public static class NativeMethods {
        [DllImport("shell32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
        public static extern IntPtr CommandLineToArgvW(string commandLine, out int argumentCount);
        [DllImport("kernel32.dll")]
        public static extern IntPtr LocalFree(IntPtr memory);
    }
}
'@
    }
    $argumentCount = 0
    $argumentVector = [OwnedGodotCommandLine.NativeMethods]::CommandLineToArgvW(
        $CommandLine,
        [ref]$argumentCount
    )
    if ($argumentVector -eq [IntPtr]::Zero -or $argumentCount -lt 1 -or $argumentCount -gt 256) {
        throw 'Windows command-line parsing failed or exceeded its bound'
    }
    try {
        $arguments = [Collections.Generic.List[string]]::new()
        for ($index = 0; $index -lt $argumentCount; $index++) {
            $pointer = [Runtime.InteropServices.Marshal]::ReadIntPtr(
                $argumentVector,
                $index * [IntPtr]::Size
            )
            $arguments.Add([Runtime.InteropServices.Marshal]::PtrToStringUni($pointer))
        }
        return @($arguments)
    }
    finally {
        [void][OwnedGodotCommandLine.NativeMethods]::LocalFree($argumentVector)
    }
}

function Get-ExactGodotOptionArgument {
    param(
        [Parameter(Mandatory)][string]$CommandLine,
        [Parameter(Mandatory)][ValidateSet('path', 'script')][string]$OptionName
    )

    $arguments = @(ConvertFrom-WindowsCommandLine $CommandLine)
    $separateOption = '--' + $OptionName
    $joinedPrefix = $separateOption + '='
    $optionCount = 0
    $malformed = $false
    $values = [Collections.Generic.List[string]]::new()
    for ($index = 1; $index -lt $arguments.Count; $index++) {
        $argument = [string]$arguments[$index]
        if ([string]::Equals($argument, $separateOption, [StringComparison]::OrdinalIgnoreCase)) {
            $optionCount++
            if ($index + 1 -ge $arguments.Count -or ([string]$arguments[$index + 1]).StartsWith('--')) {
                $malformed = $true
                continue
            }
            $index++
            $values.Add([string]$arguments[$index])
        }
        elseif ($argument.StartsWith($joinedPrefix, [StringComparison]::OrdinalIgnoreCase)) {
            $optionCount++
            $value = $argument.Substring($joinedPrefix.Length)
            if ([string]::IsNullOrEmpty($value)) {
                $malformed = $true
            }
            else {
                $values.Add($value)
            }
        }
    }
    if ($optionCount -eq 0) {
        return [pscustomobject]@{ valid = $false; reason = 'MISSING'; option_count = 0; value = '' }
    }
    if ($optionCount -ne 1) {
        return [pscustomobject]@{ valid = $false; reason = 'DUPLICATE'; option_count = $optionCount; value = '' }
    }
    if ($malformed -or $values.Count -ne 1) {
        return [pscustomobject]@{ valid = $false; reason = 'MALFORMED'; option_count = 1; value = '' }
    }
    return [pscustomobject]@{ valid = $true; reason = 'VALID'; option_count = 1; value = $values[0] }
}

function Get-GodotProjectPathIdentity {
    param(
        [Parameter(Mandatory)][string]$CommandLine,
        [Parameter(Mandatory)][string]$ExpectedProjectPath
    )

    $argument = Get-ExactGodotOptionArgument -CommandLine $CommandLine -OptionName 'path'
    if (-not $argument.valid) {
        return [pscustomobject]@{
            valid = $false
            reason = $argument.reason
            option_count = $argument.option_count
            observed = ''
            observed_canonical = ''
            expected_canonical = ''
            equivalent = $false
        }
    }
    try {
        $observedCanonical = Normalize-WindowsPathIdentity $argument.value
        $expectedCanonical = Normalize-WindowsPathIdentity $ExpectedProjectPath
    }
    catch {
        return [pscustomobject]@{
            valid = $false
            reason = 'CANONICALIZATION_FAILURE'
            option_count = 1
            observed = $argument.value
            observed_canonical = ''
            expected_canonical = ''
            equivalent = $false
        }
    }
    return [pscustomobject]@{
        valid = $true
        reason = 'VALID'
        option_count = 1
        observed = $argument.value
        observed_canonical = $observedCanonical
        expected_canonical = $expectedCanonical
        equivalent = [string]::Equals(
            $observedCanonical,
            $expectedCanonical,
            [StringComparison]::OrdinalIgnoreCase
        )
    }
}

function ConvertTo-BoundedLines {
    param([string]$Text, [int]$MaximumLines = 200, [int]$MaximumLineLength = 2048)

    return @(
        $Text -split "`r?`n" |
            Where-Object { $_ -ne '' } |
            Select-Object -First $MaximumLines |
            ForEach-Object { $_.Substring(0, [Math]::Min($MaximumLineLength, $_.Length)) }
    )
}

function Get-CreationUtc {
    param($Process)

    try {
        if ($Process.CreationDate -is [datetime]) {
            return ([datetime]$Process.CreationDate).ToUniversalTime()
        }
        return [Management.ManagementDateTimeConverter]::ToDateTime(
            [string]$Process.CreationDate
        ).ToUniversalTime()
    }
    catch {
        return [DateTime]::MinValue
    }
}

function Test-AlivePid {
    param([int]$ProcessId)

    return $null -ne (Get-Process -Id $ProcessId -ErrorAction SilentlyContinue)
}

function Get-DescendantCandidates {
    param([int]$RootPid)

    $allProcesses = @(Get-CimInstance Win32_Process)
    $records = [Collections.Generic.List[object]]::new()
    $queue = [Collections.Generic.Queue[object]]::new()
    $queue.Enqueue([pscustomobject]@{ pid = $RootPid; depth = 0; ancestry_path = 'direct' })

    while ($queue.Count -gt 0 -and $records.Count -lt $maxDescendants) {
        $parent = $queue.Dequeue()
        $children = @(
            $allProcesses |
                Where-Object { [int]$_.ParentProcessId -eq [int]$parent.pid } |
                Sort-Object @{ Expression = { Normalize-PathIdentity ([string]$_.ExecutablePath) } },
                    @{ Expression = { [string]$_.CommandLine } },
                    @{ Expression = { Get-CreationUtc $_ } }
        )
        $childOrdinal = 0
        foreach ($child in $children) {
            $childOrdinal++
            $path = '{0}/{1:D2}' -f $parent.ancestry_path, $childOrdinal
            $record = [pscustomobject]@{
                process = $child
                parent_pid = [int]$parent.pid
                depth = [int]$parent.depth + 1
                ancestry_path = $path
            }
            $records.Add($record)
            $queue.Enqueue([pscustomobject]@{
                pid = [int]$child.ProcessId
                depth = $record.depth
                ancestry_path = $path
            })
            if ($records.Count -ge $maxDescendants) {
                break
            }
        }
    }
    return @($records)
}

function New-IdentityEvidence {
    param(
        [Parameter(Mandatory)][string]$Classification,
        $ProjectEvidence = $null,
        $ScriptEvidence = $null
    )

    return [pscustomobject]@{
        classification = $Classification
        project_path_argument = if ($null -ne $ProjectEvidence) { [string]$ProjectEvidence.observed } else { '' }
        project_path_canonical = if ($null -ne $ProjectEvidence) { [string]$ProjectEvidence.observed_canonical } else { '' }
        expected_project_path_canonical = if ($null -ne $ProjectEvidence) { [string]$ProjectEvidence.expected_canonical } else { '' }
        project_path_option_count = if ($null -ne $ProjectEvidence) { [int]$ProjectEvidence.option_count } else { 0 }
        project_path_parse_reason = if ($null -ne $ProjectEvidence) { [string]$ProjectEvidence.reason } else { 'NOT_APPLICABLE' }
        script_argument = if ($null -ne $ScriptEvidence -and $ScriptEvidence.valid) { [string]$ScriptEvidence.value } else { '' }
        script_parse_reason = if ($null -ne $ScriptEvidence) { [string]$ScriptEvidence.reason } else { 'NOT_APPLICABLE' }
    }
}

function Get-IdentityClassification {
    param(
        $Candidate,
        [datetime]$InvocationUtc,
        [string]$GodotIdentity,
        [string]$ProjectPath,
        [string[]]$GodotTokens
    )

    $executable = Normalize-PathIdentity ([string]$Candidate.ExecutablePath)
    $commandLine = [string]$Candidate.CommandLine
    $creationUtc = Get-CreationUtc $Candidate
    if ($creationUtc -eq [DateTime]::MinValue -or $creationUtc -lt $InvocationUtc.AddSeconds(-1)) {
        return New-IdentityEvidence -Classification 'UNPROVEN_CREATION_TIME'
    }
    if ([string]::IsNullOrWhiteSpace($commandLine)) {
        return New-IdentityEvidence -Classification 'UNPROVEN_COMMAND_LINE'
    }
    try {
        $commandArguments = @(ConvertFrom-WindowsCommandLine $commandLine)
    }
    catch {
        return New-IdentityEvidence -Classification 'UNPROVEN_COMMAND_LINE'
    }
    $forbiddenArguments = @(
        $commandArguments | Where-Object {
            $_ -match '(?i)^--(?:editor|project-manager|export(?:-release|-debug)?|main-pack|scene)(?:=.*)?$' -or
            $_ -match '(?i)\.(?:tscn|scn)$'
        }
    )
    if ($forbiddenArguments.Count -gt 0) {
        return New-IdentityEvidence -Classification 'UNPROVEN_FORBIDDEN_MODE'
    }

    if ($executable -eq $GodotIdentity) {
        $projectEvidence = Get-GodotProjectPathIdentity -CommandLine $commandLine -ExpectedProjectPath $ProjectPath
        $scriptEvidence = Get-ExactGodotOptionArgument -CommandLine $commandLine -OptionName 'script'
        if ($GodotTokens.Count -ne 1) {
            return New-IdentityEvidence -Classification 'UNPROVEN_UNDECLARED_GODOT_DESCENDANT' -ProjectEvidence $projectEvidence -ScriptEvidence $scriptEvidence
        }
        if (@($commandArguments | Where-Object { [string]::Equals($_, '--headless', [StringComparison]::OrdinalIgnoreCase) }).Count -ne 1) {
            return New-IdentityEvidence -Classification 'UNPROVEN_NOT_HEADLESS' -ProjectEvidence $projectEvidence -ScriptEvidence $scriptEvidence
        }
        if (-not $projectEvidence.valid) {
            $classification = switch ($projectEvidence.reason) {
                'MISSING' { 'UNPROVEN_PROJECT_PATH_MISSING' }
                'DUPLICATE' { 'UNPROVEN_PROJECT_PATH_DUPLICATE' }
                'MALFORMED' { 'UNPROVEN_PROJECT_PATH_MALFORMED' }
                default { 'UNPROVEN_PROJECT_PATH_CANONICALIZATION' }
            }
            return New-IdentityEvidence -Classification $classification -ProjectEvidence $projectEvidence -ScriptEvidence $scriptEvidence
        }
        if (-not $projectEvidence.equivalent) {
            return New-IdentityEvidence -Classification 'UNPROVEN_PROJECT_IDENTITY' -ProjectEvidence $projectEvidence -ScriptEvidence $scriptEvidence
        }
        if (-not $scriptEvidence.valid -or -not [string]::Equals(
            [string]$scriptEvidence.value,
            [string]$GodotTokens[0],
            [StringComparison]::OrdinalIgnoreCase
        )) {
            return New-IdentityEvidence -Classification 'UNPROVEN_TEST_IDENTITY' -ProjectEvidence $projectEvidence -ScriptEvidence $scriptEvidence
        }
        return New-IdentityEvidence -Classification 'OWNED_GODOT_DESCENDANT' -ProjectEvidence $projectEvidence -ScriptEvidence $scriptEvidence
    }

    return New-IdentityEvidence -Classification 'UNPROVEN_EXECUTABLE_IDENTITY'
}

if (-not (Test-Path -LiteralPath $GodotPath -PathType Leaf)) {
    throw 'Godot executable is unavailable'
}
if (-not (Test-Path -LiteralPath $ProjectPath -PathType Container)) {
    throw 'Project path is unavailable'
}
if ($TimeoutSeconds -lt 1 -or $TimeoutSeconds -gt 600 -or $GraceSeconds -lt 1 -or $GraceSeconds -gt 30) {
    throw 'Timeout bounds are invalid'
}
if ($ExtraArguments.Count -gt 64 -or $AllowedGodotDescendantTokens.Count -gt 16) {
    throw 'Argument vector bounds are invalid'
}
$boundedInputs = @($GodotPath, $ProjectPath, $ScriptPath, $RequiredMarker) +
    @($ExtraArguments) + @($AllowedGodotDescendantTokens)
if (@($boundedInputs | Where-Object { $null -ne $_ -and ([string]$_).Length -gt 2048 }).Count -gt 0) {
    throw 'Argument value exceeds the evidence bound'
}

$normalizedProjectPath = Normalize-WindowsPathIdentity $ProjectPath
$normalizedGodotPath = Normalize-PathIdentity $GodotPath
$arguments = @('--headless', '--path', $ProjectPath, '--script', $ScriptPath) + @($ExtraArguments)
$startInfo = [Diagnostics.ProcessStartInfo]::new()
$startInfo.FileName = $GodotPath
$startInfo.UseShellExecute = $false
$startInfo.RedirectStandardOutput = $true
$startInfo.RedirectStandardError = $true
$startInfo.CreateNoWindow = $true
foreach ($argument in $arguments) {
    [void]$startInfo.ArgumentList.Add($argument)
}

$process = [Diagnostics.Process]::new()
$process.StartInfo = $startInfo
$stdoutTask = $null
$stderrTask = $null
$directPid = $null
$nativeExitCode = $null
$timedOut = $false
$wrapperError = ''
$cleanupError = ''
$cleanupInvocationCount = 0
$invocationUtc = [DateTime]::UtcNow
$ownedRecords = [Collections.Generic.List[object]]::new()
$unprovenRecords = [Collections.Generic.List[object]]::new()
$cleanupOrder = [Collections.Generic.List[int]]::new()
$cleanupClosedPids = [Collections.Generic.List[int]]::new()

try {
    if (-not $process.Start()) {
        throw 'Process.Start returned false'
    }
    $directPid = [int]$process.Id
    $directStartUtc = $process.StartTime.ToUniversalTime()
    $ownedRecords.Add([pscustomobject]@{
        pid = $directPid
        parent_pid = $null
        depth = 0
        ancestry_path = 'direct'
        direct = $true
        executable = $normalizedGodotPath
        start_utc = $directStartUtc.ToString('o')
        arguments = @($arguments)
        classification = 'DIRECT'
        alive_at_discovery = $true
        cleanup_eligible = $true
    })
    $stdoutTask = $process.StandardOutput.ReadToEndAsync()
    $stderrTask = $process.StandardError.ReadToEndAsync()
    if (-not $process.WaitForExit($TimeoutSeconds * 1000)) {
        $timedOut = $true
    }
    else {
        $nativeExitCode = [int]$process.ExitCode
    }
}
catch {
    $wrapperError = $_.Exception.GetType().Name
}
finally {
    $cleanupInvocationCount++
    try {
        if ($null -ne $directPid) {
            foreach ($candidateRecord in Get-DescendantCandidates -RootPid $directPid) {
                $candidate = $candidateRecord.process
                $identityParameters = @{
                    Candidate = $candidate
                    InvocationUtc = $invocationUtc
                    GodotIdentity = $normalizedGodotPath
                    ProjectPath = $normalizedProjectPath
                    GodotTokens = $AllowedGodotDescendantTokens
                }
                $identityEvidence = Get-IdentityClassification @identityParameters
                $classification = [string]$identityEvidence.classification
                $admitted = $classification.StartsWith('OWNED_', [StringComparison]::Ordinal)
                $record = [pscustomobject]@{
                    pid = [int]$candidate.ProcessId
                    parent_pid = [int]$candidateRecord.parent_pid
                    depth = [int]$candidateRecord.depth
                    ancestry_path = [string]$candidateRecord.ancestry_path
                    direct = $false
                    executable = Normalize-PathIdentity ([string]$candidate.ExecutablePath)
                    start_utc = (Get-CreationUtc $candidate).ToString('o')
                    arguments = @()
                    command_line = ([string]$candidate.CommandLine).Substring(0, [Math]::Min(2048, ([string]$candidate.CommandLine).Length))
                    classification = $classification
                    project_path_argument = $identityEvidence.project_path_argument
                    project_path_canonical = $identityEvidence.project_path_canonical
                    expected_project_path_canonical = $identityEvidence.expected_project_path_canonical
                    project_path_option_count = $identityEvidence.project_path_option_count
                    project_path_parse_reason = $identityEvidence.project_path_parse_reason
                    script_argument = $identityEvidence.script_argument
                    script_parse_reason = $identityEvidence.script_parse_reason
                    alive_at_discovery = Test-AlivePid ([int]$candidate.ProcessId)
                    cleanup_eligible = $admitted
                }
                if ($admitted) {
                    $ownedRecords.Add($record)
                }
                else {
                    $unprovenRecords.Add($record)
                }
            }

            $cleanupTargets = @(
                $ownedRecords |
                    Sort-Object @{ Expression = 'depth'; Descending = $true },
                        @{ Expression = 'ancestry_path'; Descending = $true },
                        @{ Expression = 'classification'; Descending = $false }
            )
            foreach ($record in $cleanupTargets) {
                $cleanupOrder.Add([int]$record.pid)
                if (Test-AlivePid ([int]$record.pid)) {
                    Stop-Process -Id ([int]$record.pid) -ErrorAction Stop
                    Wait-Process -Id ([int]$record.pid) -Timeout $GraceSeconds -ErrorAction SilentlyContinue
                    $cleanupClosedPids.Add([int]$record.pid)
                }
            }
        }
    }
    catch {
        $cleanupError = $_.Exception.GetType().Name
    }
}

$stdout = if ($null -ne $stdoutTask) {
    @(ConvertTo-BoundedLines -Text ($stdoutTask.GetAwaiter().GetResult()) -MaximumLines $maxOutputLines)
}
else {
    @()
}
$stderr = if ($null -ne $stderrTask) {
    @(ConvertTo-BoundedLines -Text ($stderrTask.GetAwaiter().GetResult()) -MaximumLines $maxOutputLines)
}
else {
    @()
}

if ($GraceSeconds -gt 0) {
    Start-Sleep -Seconds $GraceSeconds
}
$remainingOwnedPids = @($ownedRecords | Where-Object { Test-AlivePid ([int]$_.pid) } | ForEach-Object { [int]$_.pid })
$remainingUnprovenPids = @($unprovenRecords | Where-Object { Test-AlivePid ([int]$_.pid) } | ForEach-Object { [int]$_.pid })
$markerPass = [string]::IsNullOrEmpty($RequiredMarker) -or (($stdout -join "`n").Contains($RequiredMarker))
$stderrPass = $StderrPolicy -eq 'Allow' -or $stderr.Count -eq 0

$underlyingStatus = if ($wrapperError -ne '') {
    'WRAPPER_START_FAILURE'
}
elseif ($timedOut) {
    'TIMEOUT'
}
elseif ($nativeExitCode -ne 0) {
    'NONZERO_EXIT'
}
elseif (-not $stderrPass) {
    'STDERR_POLICY_FAILURE'
}
elseif (-not $markerPass) {
    'MARKER_FAILURE'
}
else {
    'PASS'
}

$status = if ($cleanupError -ne '' -or $remainingOwnedPids.Count -gt 0 -or $cleanupInvocationCount -ne 1) {
    'CLEANUP_FAILURE'
}
elseif ($unprovenRecords.Count -gt 0) {
    'UNPROVEN_DESCENDANT'
}
else {
    $underlyingStatus
}

$result = [ordered]@{
    schema_version = 2
    status = $status
    underlying_status = $underlyingStatus
    native_exit_code = $nativeExitCode
    timed_out = $timedOut
    marker_pass = $markerPass
    stderr_policy = $StderrPolicy
    stderr_pass = $stderrPass
    cleanup_invocation_count = $cleanupInvocationCount
    cleanup_order = @($cleanupOrder)
    cleanup_closed_pids = @($cleanupClosedPids)
    remaining_owned_pids = @($remainingOwnedPids)
    remaining_unproven_pids = @($remainingUnprovenPids)
    owned_records = @($ownedRecords)
    unproven_records = @($unprovenRecords)
    stdout = @($stdout)
    stderr = @($stderr)
    wrapper_error = $wrapperError
    cleanup_error = $cleanupError
}
[pscustomobject]$result | ConvertTo-Json -Depth 8 -Compress
if ($status -ne 'PASS') {
    exit 1
}
