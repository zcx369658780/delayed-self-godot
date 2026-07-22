[CmdletBinding()]param([Parameter(Mandatory)][string]$GodotPath,[Parameter(Mandatory)][string]$ProjectPath,[Parameter(Mandatory)][string]$ManifestPath)
Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'
throw 'TASK_0024AH_FINAL_CYCLE_NOT_DECLARED: run only after qualification, PRE_FINAL audit, and a separately created immutable manifest.'
