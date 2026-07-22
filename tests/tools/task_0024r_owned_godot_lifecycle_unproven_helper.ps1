[CmdletBinding()]
param(
    [Parameter(Mandatory)][ValidateRange(250, 10000)][int]$SleepMilliseconds,
    [Parameter(Mandatory)][ValidateSet('TASK_0024R_UNPROVEN_SELF_EXIT')][string]$CaseToken
)

$ErrorActionPreference = 'Stop'
Start-Sleep -Milliseconds $SleepMilliseconds
exit 0
