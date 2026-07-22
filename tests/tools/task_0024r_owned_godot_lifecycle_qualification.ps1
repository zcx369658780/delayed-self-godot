[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$GodotPath,
    [Parameter(Mandatory)][string]$ProjectPath,
    [Parameter(Mandatory)][string]$SummaryPath
)

$ErrorActionPreference = 'Stop'
$wrapperPath = Join-Path $ProjectPath 'tests/tools/run_owned_godot_headless.ps1'
$helperPath = Join-Path $ProjectPath 'tests/tools/task_0024r_owned_godot_lifecycle_unproven_helper.ps1'
$powerShellPath = (Get-Process -Id $PID).Path
$caseResults = [Collections.Generic.List[object]]::new()
$pathIdentityResults = [Collections.Generic.List[object]]::new()

function Assert-Condition {
    param([bool]$Condition, [string]$Message)

    if (-not $Condition) {
        throw "QUALIFICATION_ASSERTION_FAILED: $Message"
    }
}

function ConvertTo-SingleQuotedLiteral {
    param([string]$Value)

    return "'" + $Value.Replace("'", "''") + "'"
}

function ConvertTo-ArrayLiteral {
    param([object[]]$Values)

    if ($Values.Count -eq 0) {
        return '@()'
    }
    return '@(' + (($Values | ForEach-Object { ConvertTo-SingleQuotedLiteral ([string]$_) }) -join ',') + ')'
}

function Get-GodotProcesses {
    return @(
        Get-CimInstance Win32_Process |
            Where-Object { [string]$_.Name -match '(?i)^godot.*\.exe$' }
    )
}

function Assert-ZeroGodot {
    param([string]$Boundary)

    $processes = @(Get-GodotProcesses)
    Assert-Condition ($processes.Count -eq 0) "$Boundary left $($processes.Count) Godot process(es)"
}

function Invoke-WrapperCase {
    param(
        [string]$Name,
        [string]$ScriptPath,
        [string]$ExpectedStatus,
        [object]$ExpectedNativeExitCode,
        [string]$RequiredMarker = '',
        [string]$StderrPolicy = 'ForbidNonempty',
        [int]$TimeoutSeconds = 10,
        [string[]]$ExtraArguments = @(),
        [string[]]$AllowedGodotDescendantTokens = @()
    )

    Assert-ZeroGodot "before $Name"
    $parts = [Collections.Generic.List[string]]::new()
    $parts.Add('& ' + (ConvertTo-SingleQuotedLiteral $wrapperPath))
    $parts.Add('-GodotPath ' + (ConvertTo-SingleQuotedLiteral $GodotPath))
    $parts.Add('-ProjectPath ' + (ConvertTo-SingleQuotedLiteral $ProjectPath))
    $parts.Add('-ScriptPath ' + (ConvertTo-SingleQuotedLiteral $ScriptPath))
    $parts.Add('-TimeoutSeconds ' + $TimeoutSeconds)
    $parts.Add('-GraceSeconds 3')
    $parts.Add('-RequiredMarker ' + (ConvertTo-SingleQuotedLiteral $RequiredMarker))
    $parts.Add('-StderrPolicy ' + (ConvertTo-SingleQuotedLiteral $StderrPolicy))
    $parts.Add('-ExtraArguments ' + (ConvertTo-ArrayLiteral $ExtraArguments))
    $parts.Add('-AllowedGodotDescendantTokens ' + (ConvertTo-ArrayLiteral $AllowedGodotDescendantTokens))
    $command = $parts -join ' '
    $encodedCommand = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($command))

    $startInfo = [Diagnostics.ProcessStartInfo]::new()
    $startInfo.FileName = $powerShellPath
    $startInfo.UseShellExecute = $false
    $startInfo.RedirectStandardOutput = $true
    $startInfo.RedirectStandardError = $true
    $startInfo.CreateNoWindow = $true
    foreach ($argument in @('-NoLogo', '-NoProfile', '-NonInteractive', '-EncodedCommand', $encodedCommand)) {
        [void]$startInfo.ArgumentList.Add($argument)
    }
    $hostProcess = [Diagnostics.Process]::new()
    $hostProcess.StartInfo = $startInfo
    [void]$hostProcess.Start()
    $stdoutTask = $hostProcess.StandardOutput.ReadToEndAsync()
    $stderrTask = $hostProcess.StandardError.ReadToEndAsync()
    if (-not $hostProcess.WaitForExit(30000)) {
        $hostProcess.Kill($true)
        throw "QUALIFICATION_WRAPPER_HOST_TIMEOUT: $Name"
    }
    $hostExitCode = [int]$hostProcess.ExitCode
    $hostStdout = $stdoutTask.GetAwaiter().GetResult()
    $hostStderr = $stderrTask.GetAwaiter().GetResult()
    $jsonLine = @($hostStdout -split "`r?`n" | Where-Object { $_.TrimStart().StartsWith('{') } | Select-Object -Last 1)
    Assert-Condition ($jsonLine.Count -eq 1) "$Name did not emit one parseable JSON result line; host stderr length=$($hostStderr.Length)"
    try {
        $result = $jsonLine[0] | ConvertFrom-Json -Depth 12
    }
    catch {
        throw "QUALIFICATION_JSON_PARSE_FAILED: $Name"
    }

    $expectedHostExitCode = if ($ExpectedStatus -eq 'PASS') { 0 } else { 1 }
    Assert-Condition ($hostExitCode -eq $expectedHostExitCode) "$Name host exit $hostExitCode != $expectedHostExitCode"
    Assert-Condition ($result.status -eq $ExpectedStatus) "$Name status $($result.status) != $ExpectedStatus; native=$($result.native_exit_code); underlying=$($result.underlying_status)"
    Assert-Condition ($result.cleanup_invocation_count -eq 1) "$Name cleanup count was not exactly one"
    Assert-Condition (@($result.remaining_owned_pids).Count -eq 0) "$Name retained owned processes"
    if ($null -ne $ExpectedNativeExitCode) {
        Assert-Condition ([int]$result.native_exit_code -eq [int]$ExpectedNativeExitCode) "$Name native exit mismatch"
    }
    Assert-ZeroGodot "after $Name"

    $caseResults.Add([pscustomobject]@{
        name = $Name
        status = [string]$result.status
        underlying_status = [string]$result.underlying_status
        native_exit_code = $result.native_exit_code
        timed_out = [bool]$result.timed_out
        marker_pass = [bool]$result.marker_pass
        stderr_pass = [bool]$result.stderr_pass
        cleanup_invocation_count = [int]$result.cleanup_invocation_count
        owned_record_count = @($result.owned_records).Count
        unproven_record_count = @($result.unproven_records).Count
        cleanup_order_depths = @(
            foreach ($pidValue in @($result.cleanup_order)) {
                @($result.owned_records | Where-Object { $_.pid -eq $pidValue })[0].depth
            }
        )
        zero_godot_after = $true
    })
    return $result
}

function Get-RecordSemantics {
    param($Result)

    return [ordered]@{
        status = [string]$Result.status
        underlying_status = [string]$Result.underlying_status
        owned_records = @(
            $Result.owned_records | ForEach-Object {
                [ordered]@{
                    depth = [int]$_.depth
                    ancestry_path = [string]$_.ancestry_path
                    direct = [bool]$_.direct
                    classification = [string]$_.classification
                    cleanup_eligible = [bool]$_.cleanup_eligible
                    project_path_parse_reason = [string]$_.project_path_parse_reason
                    script_parse_reason = [string]$_.script_parse_reason
                }
            }
        )
        unproven_records = @(
            $Result.unproven_records | ForEach-Object {
                [ordered]@{
                    depth = [int]$_.depth
                    ancestry_path = [string]$_.ancestry_path
                    direct = [bool]$_.direct
                    classification = [string]$_.classification
                    cleanup_eligible = [bool]$_.cleanup_eligible
                    project_path_parse_reason = [string]$_.project_path_parse_reason
                    script_parse_reason = [string]$_.script_parse_reason
                }
            }
        )
        cleanup_order_depths = @(
            foreach ($pidValue in @($Result.cleanup_order)) {
                @($Result.owned_records | Where-Object { $_.pid -eq $pidValue })[0].depth
            }
        )
    }
}

Assert-Condition (Test-Path -LiteralPath $GodotPath -PathType Leaf) 'Godot executable unavailable'
Assert-Condition (Test-Path -LiteralPath $wrapperPath -PathType Leaf) 'wrapper unavailable'
Assert-Condition (Test-Path -LiteralPath $helperPath -PathType Leaf) 'unproven helper unavailable'
Assert-ZeroGodot 'qualification start'

$wrapperText = Get-Content -LiteralPath $wrapperPath -Raw
$parseTokens = $null
$parseErrors = $null
$wrapperAst = [Management.Automation.Language.Parser]::ParseFile($wrapperPath, [ref]$parseTokens, [ref]$parseErrors)
Assert-Condition (@($parseErrors).Count -eq 0) 'wrapper has PowerShell parse errors'
$requiredPathFunctions = @(
    'Normalize-WindowsPathIdentity',
    'ConvertFrom-WindowsCommandLine',
    'Get-ExactGodotOptionArgument',
    'Get-GodotProjectPathIdentity'
)
$pathFunctionAsts = @(
    $wrapperAst.FindAll({
        param($node)
        $node -is [Management.Automation.Language.FunctionDefinitionAst] -and
            $requiredPathFunctions -contains $node.Name
    }, $true)
)
Assert-Condition ($pathFunctionAsts.Count -eq $requiredPathFunctions.Count) 'wrapper path-identity functions were not uniquely discoverable'
$pathFunctionSource = @(
    foreach ($functionName in $requiredPathFunctions) {
        @($pathFunctionAsts | Where-Object { $_.Name -eq $functionName })[0].Extent.Text
    }
) -join [Environment]::NewLine
. ([scriptblock]::Create($pathFunctionSource))

function Assert-PathIdentityCase {
    param(
        [string]$Name,
        [string]$CommandLine,
        [bool]$ExpectedValid,
        [bool]$ExpectedEquivalent,
        [string]$ExpectedReason
    )

    $result = Get-GodotProjectPathIdentity -CommandLine $CommandLine -ExpectedProjectPath $ProjectPath
    Assert-Condition ([bool]$result.valid -eq $ExpectedValid) "$Name path validity mismatch"
    Assert-Condition ([bool]$result.equivalent -eq $ExpectedEquivalent) "$Name path equivalence mismatch"
    Assert-Condition ([string]$result.reason -eq $ExpectedReason) "$Name path reason mismatch"
    $pathIdentityResults.Add([pscustomobject]@{
        name = $Name
        valid = [bool]$result.valid
        equivalent = [bool]$result.equivalent
        reason = [string]$result.reason
        option_count = [int]$result.option_count
    })
}

$staticChecks = [ordered]@{
    process_start_info = $wrapperText.Contains('[Diagnostics.ProcessStartInfo]::new()')
    separate_argument_list = $wrapperText.Contains('$startInfo.ArgumentList.Add($argument)')
    shell_execute_disabled = $wrapperText.Contains('$startInfo.UseShellExecute = $false')
    no_process_name_stop = $wrapperText -notmatch '(?i)Stop-Process\s+-(?:Name|InputObject)'
    no_wildcard_stop = $wrapperText -notmatch '(?i)Stop-Process[^\r\n]*[\*\?]'
    no_start_process_launch = $wrapperText -notmatch '(?i)Start-Process'
    exact_pid_stop_only = @([regex]::Matches($wrapperText, '(?i)Stop-Process\s+-Id\s+\(\[int\]\$record\.pid\)')).Count -eq 1
    no_process_name_enumerated_cleanup = $wrapperText -notmatch '(?is)Get-Process[^\r\n]*\|[^\r\n]*Stop-Process'
    exact_project_option_parser = @(
        $pathFunctionAsts |
            Where-Object { $_.Name -eq 'Get-GodotProjectPathIdentity' -and $_.Extent.Text -match '(?i)Get-ExactGodotOptionArgument\s+-CommandLine\s+\$CommandLine\s+-OptionName\s+''path''' }
    ).Count -eq 1
    canonical_windows_path_comparison = $wrapperText.Contains('[StringComparison]::OrdinalIgnoreCase')
    no_project_identity_substring_test = $wrapperText -notmatch 'Test-ContainsToken\s+-CommandLine\s+\$commandLine\s+-Token\s+\$Project'
}
foreach ($check in $staticChecks.GetEnumerator()) {
    Assert-Condition ([bool]$check.Value) "static safety check failed: $($check.Key)"
}

$forwardSlashPath = $ProjectPath.Replace('\', '/')
$lowerCasePath = $ProjectPath.ToLowerInvariant()
$trailingSeparatorPath = $ProjectPath.TrimEnd('\', '/') + '\'
$redundantDotPath = $ProjectPath.TrimEnd('\', '/') + '\.\'
Assert-PathIdentityCase -Name 'forward_slash_equivalence' -CommandLine ('godot.exe --headless --path=' + $forwardSlashPath + ' --script res://case.gd') -ExpectedValid $true -ExpectedEquivalent $true -ExpectedReason 'VALID'
Assert-PathIdentityCase -Name 'case_insensitive_equivalence' -CommandLine ('godot.exe --headless --path "' + $lowerCasePath + '" --script res://case.gd') -ExpectedValid $true -ExpectedEquivalent $true -ExpectedReason 'VALID'
Assert-PathIdentityCase -Name 'trailing_separator_equivalence' -CommandLine ('godot.exe --headless --path ' + $trailingSeparatorPath + ' --script res://case.gd') -ExpectedValid $true -ExpectedEquivalent $true -ExpectedReason 'VALID'
Assert-PathIdentityCase -Name 'redundant_dot_equivalence' -CommandLine ('godot.exe --headless --path ' + $redundantDotPath + ' --script res://case.gd') -ExpectedValid $true -ExpectedEquivalent $true -ExpectedReason 'VALID'
Assert-PathIdentityCase -Name 'deceptive_suffix_rejected' -CommandLine ('godot.exe --headless --path "' + $ProjectPath + '_Other" --script res://case.gd') -ExpectedValid $true -ExpectedEquivalent $false -ExpectedReason 'VALID'
Assert-PathIdentityCase -Name 'subproject_rejected' -CommandLine ('godot.exe --headless --path "' + (Join-Path $ProjectPath 'subproject') + '" --script res://case.gd') -ExpectedValid $true -ExpectedEquivalent $false -ExpectedReason 'VALID'
Assert-PathIdentityCase -Name 'backup_suffix_rejected' -CommandLine ('godot.exe --headless --path "' + $ProjectPath + '_backup" --script res://case.gd') -ExpectedValid $true -ExpectedEquivalent $false -ExpectedReason 'VALID'
Assert-PathIdentityCase -Name 'other_root_rejected' -CommandLine 'godot.exe --headless --path "D:\Other\Delayed_Self" --script res://case.gd' -ExpectedValid $true -ExpectedEquivalent $false -ExpectedReason 'VALID'
Assert-PathIdentityCase -Name 'missing_path_rejected' -CommandLine 'godot.exe --headless --script res://case.gd' -ExpectedValid $false -ExpectedEquivalent $false -ExpectedReason 'MISSING'
Assert-PathIdentityCase -Name 'duplicate_path_rejected' -CommandLine ('godot.exe --headless --path "' + $ProjectPath + '" --path=' + $forwardSlashPath + ' --script res://case.gd') -ExpectedValid $false -ExpectedEquivalent $false -ExpectedReason 'DUPLICATE'

$normal = Invoke-WrapperCase -Name 'normal_exit' -ScriptPath 'res://tests/tools/task_0024r_owned_godot_lifecycle_normal.gd' -ExpectedStatus 'PASS' -ExpectedNativeExitCode 0 -RequiredMarker 'TASK_0024R_NORMAL_MARKER'
Assert-Condition ($normal.marker_pass -and $normal.stderr_pass) 'normal policy facts failed'

$nonzero = Invoke-WrapperCase -Name 'nonzero_exit_7' -ScriptPath 'res://tests/tools/task_0024r_owned_godot_lifecycle_nonzero.gd' -ExpectedStatus 'NONZERO_EXIT' -ExpectedNativeExitCode 7 -RequiredMarker 'TASK_0024R_NONZERO_MARKER'
Assert-Condition ($nonzero.underlying_status -eq 'NONZERO_EXIT') 'nonzero underlying classification failed'

$timeout = Invoke-WrapperCase -Name 'timeout_exact_pid' -ScriptPath 'res://tests/tools/task_0024r_owned_godot_lifecycle_timeout.gd' -ExpectedStatus 'TIMEOUT' -ExpectedNativeExitCode $null -TimeoutSeconds 1
Assert-Condition ($timeout.timed_out -and @($timeout.cleanup_closed_pids).Count -eq 1) 'timeout exact direct PID cleanup failed'
Assert-Condition ($timeout.cleanup_closed_pids[0] -eq $timeout.owned_records[0].pid) 'timeout closed a PID other than the direct owned PID'

$stderr = Invoke-WrapperCase -Name 'stderr_forbidden' -ScriptPath 'res://tests/tools/task_0024r_owned_godot_lifecycle_stderr.gd' -ExpectedStatus 'STDERR_POLICY_FAILURE' -ExpectedNativeExitCode 0 -RequiredMarker 'TASK_0024R_STDERR_MARKER'
Assert-Condition ($stderr.marker_pass -and -not $stderr.stderr_pass -and -not $stderr.timed_out) 'stderr classification was not independent'

$marker = Invoke-WrapperCase -Name 'missing_marker' -ScriptPath 'res://tests/tools/task_0024r_owned_godot_lifecycle_missing_marker.gd' -ExpectedStatus 'MARKER_FAILURE' -ExpectedNativeExitCode 0 -RequiredMarker 'TASK_0024R_REQUIRED_BUT_ABSENT'
Assert-Condition (-not $marker.marker_pass -and $marker.stderr_pass) 'marker classification was not independent'

$ownedParameters = @{
    ScriptPath = 'res://tests/tools/task_0024r_owned_godot_lifecycle_owned_parent.gd'
    ExpectedStatus = 'TIMEOUT'
    ExpectedNativeExitCode = $null
    TimeoutSeconds = 1
    AllowedGodotDescendantTokens = @('res://tests/tools/task_0024r_owned_godot_lifecycle_owned_child.gd')
}
$ownedFirst = Invoke-WrapperCase -Name 'owned_descendant_first' @ownedParameters
$ownedSecond = Invoke-WrapperCase -Name 'owned_descendant_repeat' @ownedParameters
foreach ($ownedResult in @($ownedFirst, $ownedSecond)) {
    Assert-Condition (@($ownedResult.owned_records).Count -eq 2) 'owned descendant case did not record direct plus one descendant'
    Assert-Condition (@($ownedResult.unproven_records).Count -eq 0) 'owned descendant case produced unproven records'
    Assert-Condition ($ownedResult.owned_records[1].classification -eq 'OWNED_GODOT_DESCENDANT') 'owned descendant identity classification failed'
    Assert-Condition ($ownedResult.owned_records[1].parent_pid -eq $ownedResult.owned_records[0].pid) 'owned descendant ancestry did not reach direct PID'
    Assert-Condition ($ownedResult.cleanup_order[0] -eq $ownedResult.owned_records[1].pid) 'owned descendant was not cleaned before direct PID'
    Assert-Condition ($ownedResult.cleanup_order[-1] -eq $ownedResult.owned_records[0].pid) 'direct PID was not cleaned last'
}
$firstSemantics = Get-RecordSemantics $ownedFirst | ConvertTo-Json -Depth 8 -Compress
$secondSemantics = Get-RecordSemantics $ownedSecond | ConvertTo-Json -Depth 8 -Compress
Assert-Condition ($firstSemantics -ceq $secondSemantics) 'record-producing repeat changed schema/order semantics'

$unprovenExtraArguments = @(
    '--',
    ('--helper-executable=' + $powerShellPath),
    ('--helper-script=' + $helperPath)
)
$unproven = Invoke-WrapperCase -Name 'unproven_descendant_exclusion' -ScriptPath 'res://tests/tools/task_0024r_owned_godot_lifecycle_unproven_parent.gd' -ExpectedStatus 'UNPROVEN_DESCENDANT' -ExpectedNativeExitCode $null -TimeoutSeconds 1 -ExtraArguments $unprovenExtraArguments
Assert-Condition (@($unproven.unproven_records).Count -ge 1) 'unproven case did not record the controlled descendant chain'
$unprovenHelperRecords = @($unproven.unproven_records | Where-Object { ([string]$_.command_line).Contains('TASK_0024R_UNPROVEN_SELF_EXIT') })
Assert-Condition ($unprovenHelperRecords.Count -eq 1) 'controlled unproven helper identity was not recorded exactly once'
$unprovenRecord = $unprovenHelperRecords[0]
Assert-Condition ($unprovenRecord.classification -eq 'UNPROVEN_EXECUTABLE_IDENTITY') 'unproven descendant reason mismatch'
Assert-Condition ($unprovenRecord.alive_at_discovery) 'unproven descendant was not alive when exclusion was decided'
Assert-Condition (@($unproven.unproven_records | Where-Object { $_.cleanup_eligible }).Count -eq 0) 'an unproven descendant entered cleanup eligibility'
Assert-Condition (@($unproven.unproven_records | Where-Object { @($unproven.cleanup_closed_pids) -contains $_.pid }).Count -eq 0) 'wrapper closed an unproven descendant'
Assert-Condition (@($unproven.remaining_unproven_pids).Count -eq 0) 'unproven helper did not self-exit within the bounded grace interval'
Assert-ZeroGodot 'qualification end'

$summary = [ordered]@{
    schema_version = 1
    qualification = 'Task 0024S Windows path identity and focused owned Godot wrapper lifecycle qualification'
    result = 'PASS'
    case_count = $caseResults.Count
    cases = @($caseResults)
    path_identity_case_count = $pathIdentityResults.Count
    path_identity_cases = @($pathIdentityResults)
    deterministic_repeat_semantics_equal = $true
    static_safety = $staticChecks
    every_case_cleanup_exactly_once = @($caseResults | Where-Object { $_.cleanup_invocation_count -ne 1 }).Count -eq 0
    every_case_zero_godot_after = @($caseResults | Where-Object { -not $_.zero_godot_after }).Count -eq 0
    complete_core_mechanics_matrix_ran = $false
    terminal_marker = 'WINDOWS_PATH_IDENTITY_AND_OWNED_WRAPPER_QUALIFICATION_READY_FOR_GPT_REVIEW'
}
$summaryJson = [pscustomobject]$summary | ConvertTo-Json -Depth 10
[IO.File]::WriteAllText($SummaryPath, $summaryJson + [Environment]::NewLine, [Text.UTF8Encoding]::new($false))
Write-Output 'TASK_0024S_WINDOWS_PATH_AND_WRAPPER_QUALIFICATION_PASS'
