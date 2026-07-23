[CmdletBinding()]
param()
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
function Stop-Task0024AKScopeProbe {
    param([Parameter(Mandatory)][string]$AkScopeReason)
    throw "TASK_0024AK_SCOPE_PROBE_FAIL:$AkScopeReason"
}
function Get-Task0024AKDotSourcedPs1 {
    param([Parameter(Mandatory)][string]$AkScopeFile)
    $AkScopeTokens = $null
    $AkScopeErrors = $null
    $AkScopeAst = [Management.Automation.Language.Parser]::ParseFile(
        $AkScopeFile, [ref]$AkScopeTokens, [ref]$AkScopeErrors
    )
    if (@($AkScopeErrors).Count -ne 0) {
        Stop-Task0024AKScopeProbe "AST_PARSE_ERROR:$AkScopeFile"
    }
    @($AkScopeAst.FindAll({
        param($AkScopeNode)
        if ($AkScopeNode -isnot [Management.Automation.Language.CommandAst] -or
            $AkScopeNode.InvocationOperator -ne [Management.Automation.Language.TokenKind]::Dot) {
            return $false
        }
        return $true
    }, $true))
}
$AkScopeModule = Join-Path $PSScriptRoot 'task_0024ak_evidence_parser.psm1'
$AkScopeAdapter = Join-Path $PSScriptRoot 'task_0024ak_wrapper_capture.ps1'
$AkScopeDriver = Join-Path $PSScriptRoot 'task_0024ak_final_cycle.ps1'
foreach ($AkScopeFile in @($AkScopeModule, $AkScopeAdapter, $AkScopeDriver)) {
    if (-not (Test-Path -LiteralPath $AkScopeFile -PathType Leaf)) {
        Stop-Task0024AKScopeProbe "FILE_MISSING:$AkScopeFile"
    }
}
$GodotPath = 'sentinel::GodotPath'
$ProjectPath = 'sentinel::ProjectPath'
$ManifestPath = 'sentinel::ManifestPath'
$ScriptPath = 'sentinel::ScriptPath'
$RequiredMarker = 'sentinel::RequiredMarker'
$AkDriverGodotExecutable = 'sentinel::AkDriverGodotExecutable'
$AkDriverProjectRoot = 'sentinel::AkDriverProjectRoot'
$AkDriverManifestPath = 'sentinel::AkDriverManifestPath'
$AkScopeExpectedSentinels = [ordered]@{
    GodotPath = $GodotPath
    ProjectPath = $ProjectPath
    ManifestPath = $ManifestPath
    ScriptPath = $ScriptPath
    RequiredMarker = $RequiredMarker
    AkDriverGodotExecutable = $AkDriverGodotExecutable
    AkDriverProjectRoot = $AkDriverProjectRoot
    AkDriverManifestPath = $AkDriverManifestPath
}
function Assert-Task0024AKSentinels {
    foreach ($AkScopeEntry in $AkScopeExpectedSentinels.GetEnumerator()) {
        $AkScopeActual = (Get-Variable -Name $AkScopeEntry.Key -Scope Script -ErrorAction Stop).Value
        if (-not [string]::Equals([string]$AkScopeActual, [string]$AkScopeEntry.Value, [StringComparison]::Ordinal)) {
            Stop-Task0024AKScopeProbe "SENTINEL_CHANGED:$($AkScopeEntry.Key)"
        }
    }
}
Import-Module -Name $AkScopeModule -Force -Scope Local -ErrorAction Stop
Assert-Task0024AKSentinels
Import-Module -Name $AkScopeModule -Force -Scope Local -ErrorAction Stop
Assert-Task0024AKSentinels
$AkScopeLoaded = Get-Module | Where-Object { $_.Path -eq $AkScopeModule } | Select-Object -First 1
if ($null -eq $AkScopeLoaded) {
    Stop-Task0024AKScopeProbe 'MODULE_NOT_LOADED'
}
$AkScopeExpectedFunctions = @(
    'ConvertFrom-Task0024AKEvidenceLines',
    'ConvertFrom-Task0024AKWrapperValues'
)
$AkScopeActualFunctions = @($AkScopeLoaded.ExportedFunctions.Keys | Sort-Object)
if (@(Compare-Object $AkScopeExpectedFunctions $AkScopeActualFunctions).Count -ne 0) {
    Stop-Task0024AKScopeProbe "UNEXPECTED_EXPORTS:$($AkScopeActualFunctions -join ',')"
}
if ($AkScopeLoaded.ExportedVariables.Count -ne 0) {
    Stop-Task0024AKScopeProbe "EXPORTED_VARIABLES:$($AkScopeLoaded.ExportedVariables.Keys -join ',')"
}
$AkScopeAdapterTokens = $null
$AkScopeAdapterErrors = $null
$AkScopeAdapterAst = [Management.Automation.Language.Parser]::ParseFile(
    $AkScopeAdapter, [ref]$AkScopeAdapterTokens, [ref]$AkScopeAdapterErrors
)
if (@($AkScopeAdapterErrors).Count -ne 0) {
    Stop-Task0024AKScopeProbe 'ADAPTER_AST_PARSE_ERROR'
}
$AkScopeAdapterParameters = @($AkScopeAdapterAst.ParamBlock.Parameters | ForEach-Object {
    $_.Name.VariablePath.UserPath
})
if ($AkScopeAdapterParameters -contains 'Library') {
    Stop-Task0024AKScopeProbe 'ADAPTER_EXPOSES_LIBRARY'
}
if (@(Get-Task0024AKDotSourcedPs1 -AkScopeFile $AkScopeDriver).Count -ne 0) {
    Stop-Task0024AKScopeProbe 'DRIVER_CONTAINS_DOT_INVOCATION'
}
[ordered]@{
    schema_version = 1
    task_identity = '0024AK'
    status = 'PASS'
    powershell_version = $PSVersionTable.PSVersion.ToString()
    import_count = 2
    sentinel_names = @($AkScopeExpectedSentinels.Keys)
    exported_functions = $AkScopeActualFunctions
    exported_variable_count = $AkScopeLoaded.ExportedVariables.Count
    adapter_parameters = $AkScopeAdapterParameters
    adapter_library_parameter = $false
    driver_dot_invocation_count = 0
} | ConvertTo-Json -Depth 10 -Compress
