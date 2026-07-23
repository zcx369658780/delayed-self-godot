[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$AkAuditTaskStartHead,
    [Parameter(Mandatory)][string]$AkAuditExpectedConfigSha256,
    [ValidateSet('PRE_FINAL', 'POST_FINAL')][string]$AkAuditPhase = 'PRE_FINAL',
    [string]$AkAuditRepositoryRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path
)
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
function Stop-Task0024AKStaticAudit {
    param([Parameter(Mandatory)][string]$AkAuditReason)
    throw "TASK_0024AK_STATIC_PRESERVATION_FAIL:$AkAuditReason"
}
function Invoke-Task0024AKGit {
    param([Parameter(Mandatory)][string[]]$AkAuditArguments)
    $AkAuditOutput = @(& git -C $AkAuditRepositoryRoot @AkAuditArguments 2>&1)
    if ($LASTEXITCODE -ne 0) {
        Stop-Task0024AKStaticAudit "GIT_FAILED:$($AkAuditArguments -join ' ')"
    }
    @($AkAuditOutput | ForEach-Object { [string]$_ })
}
function Get-Task0024AKBlobIdentity {
    param(
        [Parameter(Mandatory)][string]$AkAuditRef,
        [Parameter(Mandatory)][string]$AkAuditPath
    )
    $AkAuditValues = @(Invoke-Task0024AKGit -AkAuditArguments @(
        'rev-parse', "$AkAuditRef`:$AkAuditPath"
    ))
    if ($AkAuditValues.Count -ne 1) {
        Stop-Task0024AKStaticAudit "EXPECTED_ONE_BLOB_IDENTITY:$AkAuditPath`:$($AkAuditValues.Count)"
    }
    [string]$AkAuditValues[0]
}
function Get-Task0024AKCurrentBlobIdentity {
    param([Parameter(Mandatory)][string]$AkAuditPath)
    $AkAuditValues = @(Invoke-Task0024AKGit -AkAuditArguments @(
        'hash-object', '--', $AkAuditPath
    ))
    if ($AkAuditValues.Count -ne 1) {
        Stop-Task0024AKStaticAudit "EXPECTED_ONE_CURRENT_BLOB_IDENTITY:$AkAuditPath`:$($AkAuditValues.Count)"
    }
    [string]$AkAuditValues[0]
}
function Test-Task0024AKProtectedPath {
    param([Parameter(Mandatory)][string]$AkAuditPath)
    $AkAuditProtectedPatterns = @(
        'project.godot',
        'scenes/*',
        'data/catalog/*',
        'data/levels/*',
        'scripts/*',
        'schemas/*',
        'tests/run_all.gd',
        'tests/simulation/*',
        'tests/levels/*',
        'tests/curriculum/*',
        'tests/playtest/*',
        'tests/presentation/*',
        'tests/tools/run_owned_godot_headless.ps1',
        'localization/*',
        'assets/*',
        'audio/*'
    )
    foreach ($AkAuditPattern in $AkAuditProtectedPatterns) {
        if ($AkAuditPath -like $AkAuditPattern) {
            return $true
        }
    }
    return $false
}
$AkAuditRoot = [IO.Path]::GetFullPath($AkAuditRepositoryRoot)
if ($AkAuditRoot.TrimEnd('\') -ne 'D:\Delayed_Self') {
    Stop-Task0024AKStaticAudit "ROOT_MISMATCH:$AkAuditRoot"
}
$AkAuditResolvedStartValues = @(Invoke-Task0024AKGit -AkAuditArguments @(
    'rev-parse', $AkAuditTaskStartHead
))
if ($AkAuditResolvedStartValues.Count -ne 1) {
    Stop-Task0024AKStaticAudit "EXPECTED_ONE_TASK_START_HEAD:$($AkAuditResolvedStartValues.Count)"
}
$AkAuditResolvedStart = [string]$AkAuditResolvedStartValues[0]
if ($AkAuditResolvedStart -ne $AkAuditTaskStartHead) {
    Stop-Task0024AKStaticAudit 'TASK_START_HEAD_NOT_FULL_EXACT'
}
$AkAuditAllowedExact = @(
    'tests/tools/task_0024ak_wrapper_capture.ps1',
    'tests/tools/task_0024ak_evidence_parser.psm1',
    'tests/tools/task_0024ak_scope_isolation_probes.ps1',
    'tests/tools/task_0024ak_wrapper_parser_probes.ps1',
    'tests/tools/task_0024ak_driver_preflight.ps1',
    'tests/tools/task_0024ak_static_preservation.ps1',
    'tests/tools/task_0024ak_final_cycle.ps1',
    'docs/reports/0024AK_LIBRARY_SCOPE_ISOLATED_RETAINED_DRIVER_AND_SCHEMA_V2_VISUAL_VALIDATION_REPORT.md',
    'docs/presentation/SCHEMA_V2_MINIMUM_OWNER_REVIEW_VISUAL_CONTRACT_CURRENT.md',
    'docs/playtest/SUBMISSION_CORE_1_12_OWNER_CURRICULUM_REVIEW_CURRENT.md',
    'docs/CODEX_ACTIVE_TASK_CURRENT.md',
    'docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md',
    'docs/DEVELOPMENT_PLAN_CURRENT.md',
    'docs/DOC_INDEX_CURRENT.md',
    'docs/HANDOFF_MASTER_CURRENT.md',
    'docs/project_memory.md',
    'docs/production/EXPANDED_CONTENT_SUBMISSION_ROADMAP_CURRENT.md'
)
$AkAuditPorcelain = @(Invoke-Task0024AKGit -AkAuditArguments @('status', '--porcelain=v1', '--untracked-files=all'))
$AkAuditChangedPaths = @($AkAuditPorcelain | ForEach-Object {
    if ($_.Length -lt 4) {
        Stop-Task0024AKStaticAudit "MALFORMED_PORCELAIN:$_"
    }
    $_.Substring(3).Replace('\', '/')
} | Where-Object { $_ -ne '.codex/config.toml' })
$AkAuditUnauthorizedPaths = @($AkAuditChangedPaths | Where-Object {
    $_ -notin $AkAuditAllowedExact -and $_ -notlike 'tests/tools/task_0024ak_*.json'
})
$AkAuditAllStartPaths = @(Invoke-Task0024AKGit -AkAuditArguments @(
    'ls-tree', '-r', '--name-only', $AkAuditTaskStartHead
))
$AkAuditHistoricalPaths = @($AkAuditAllStartPaths | Where-Object {
    $_ -match '(^|/)(task_0024a[f-j]_|0024A[F-J])'
})
$AkAuditHistoricalInventory = foreach ($AkAuditPath in $AkAuditHistoricalPaths) {
    [ordered]@{
        path = $AkAuditPath
        expected_blob = Get-Task0024AKBlobIdentity -AkAuditRef $AkAuditTaskStartHead -AkAuditPath $AkAuditPath
        current_blob = Get-Task0024AKCurrentBlobIdentity -AkAuditPath $AkAuditPath
    }
}
$AkAuditProtectedPaths = @($AkAuditAllStartPaths | Where-Object {
    Test-Task0024AKProtectedPath -AkAuditPath $_
})
$AkAuditProtectedInventory = foreach ($AkAuditPath in $AkAuditProtectedPaths) {
    [ordered]@{
        path = $AkAuditPath
        expected_blob = Get-Task0024AKBlobIdentity -AkAuditRef $AkAuditTaskStartHead -AkAuditPath $AkAuditPath
        current_blob = Get-Task0024AKCurrentBlobIdentity -AkAuditPath $AkAuditPath
    }
}
$AkAuditAjManifestFiles = @(
    'tests/tools/task_0024aj_retained_manifest.json',
    'tests/tools/task_0024aj_retained_manifest.json.consumed.json',
    'tests/tools/task_0024aj_retained_cycle_blocker.json'
)
$AkAuditAjManifestInventory = foreach ($AkAuditPath in $AkAuditAjManifestFiles) {
    [ordered]@{
        path = $AkAuditPath
        expected_blob = Get-Task0024AKBlobIdentity -AkAuditRef $AkAuditTaskStartHead -AkAuditPath $AkAuditPath
        current_blob = Get-Task0024AKCurrentBlobIdentity -AkAuditPath $AkAuditPath
    }
}
$AkAuditAjSidecar = Get-Content -Raw -LiteralPath (
    Join-Path $AkAuditRoot 'tests\tools\task_0024aj_retained_manifest.json.consumed.json'
) | ConvertFrom-Json -Depth 100 -ErrorAction Stop
$AkAuditAjConsumed = $AkAuditAjSidecar.status -eq 'CONSUMED_BEFORE_FIRST_CASE'
$AkAuditFrozenValidatorPath = 'tests/presentation/task_0024aj_sensor_contract_and_dynamic_signature_validation.gd'
$AkAuditFrozenValidator = [ordered]@{
    path = $AkAuditFrozenValidatorPath
    expected_blob = Get-Task0024AKBlobIdentity -AkAuditRef $AkAuditTaskStartHead -AkAuditPath $AkAuditFrozenValidatorPath
    current_blob = Get-Task0024AKCurrentBlobIdentity -AkAuditPath $AkAuditFrozenValidatorPath
}
$AkAuditWrapperPath = 'tests/tools/run_owned_godot_headless.ps1'
$AkAuditWrapperBlob = Get-Task0024AKCurrentBlobIdentity -AkAuditPath $AkAuditWrapperPath
$AkAuditConfigFile = Join-Path $AkAuditRoot '.codex\config.toml'
if (-not (Test-Path -LiteralPath $AkAuditConfigFile -PathType Leaf)) {
    Stop-Task0024AKStaticAudit 'CONFIG_MISSING'
}
$AkAuditConfigActual = (Get-FileHash -LiteralPath $AkAuditConfigFile -Algorithm SHA256).Hash.ToLowerInvariant()
$AkAuditConfigExpected = $AkAuditExpectedConfigSha256.ToLowerInvariant()
$AkAuditConfigStatus = @(Invoke-Task0024AKGit -AkAuditArguments @(
    'status', '--short', '--untracked-files=all', '--', '.codex/config.toml'
))
$AkAuditDriverFile = Join-Path $PSScriptRoot 'task_0024ak_final_cycle.ps1'
$AkAuditDriverTokens = $null
$AkAuditDriverErrors = $null
$AkAuditDriverAst = [Management.Automation.Language.Parser]::ParseFile(
    $AkAuditDriverFile, [ref]$AkAuditDriverTokens, [ref]$AkAuditDriverErrors
)
$AkAuditDriverDotInvocations = @($AkAuditDriverAst.FindAll({
    param($AkAuditNode)
    $AkAuditNode -is [Management.Automation.Language.CommandAst] -and
    $AkAuditNode.InvocationOperator -eq [Management.Automation.Language.TokenKind]::Dot
}, $true))
$AkAuditModuleFile = Join-Path $PSScriptRoot 'task_0024ak_evidence_parser.psm1'
$AkAuditModuleTokens = $null
$AkAuditModuleErrors = $null
$AkAuditModuleAst = [Management.Automation.Language.Parser]::ParseFile(
    $AkAuditModuleFile, [ref]$AkAuditModuleTokens, [ref]$AkAuditModuleErrors
)
$AkAuditTopLevelParamCount = if ($null -eq $AkAuditModuleAst.ParamBlock) { 0 } else { 1 }
$AkAuditGenericNames = @('GodotPath', 'ProjectPath', 'ManifestPath', 'ScriptPath', 'RequiredMarker')
$AkAuditGenericParameterHits = @($AkAuditModuleAst.FindAll({
    param($AkAuditNode)
    $AkAuditNode -is [Management.Automation.Language.ParameterAst] -and
    $AkAuditGenericNames -contains $AkAuditNode.Name.VariablePath.UserPath
}, $true) | ForEach-Object { $_.Name.VariablePath.UserPath })
$AkAuditLoadedModules = @(Import-Module -Name $AkAuditModuleFile -Force -Scope Local -PassThru -ErrorAction Stop)
if ($AkAuditLoadedModules.Count -ne 1) {
    Stop-Task0024AKStaticAudit "MODULE_IMPORT_CARDINALITY_INVALID:$($AkAuditLoadedModules.Count)"
}
$AkAuditLoadedModule = $AkAuditLoadedModules[0]
$AkAuditExpectedExports = @(
    'ConvertFrom-Task0024AKEvidenceLines',
    'ConvertFrom-Task0024AKWrapperValues'
)
$AkAuditActualExports = @($AkAuditLoadedModule.ExportedFunctions.Keys | Sort-Object)
$AkAuditCatalogFile = Join-Path $AkAuditRoot 'data\catalog\level_catalog_v1.json'
$AkAuditCatalog = Get-Content -Raw -LiteralPath $AkAuditCatalogFile |
    ConvertFrom-Json -Depth 100 -ErrorAction Stop
$AkAuditCatalogEntries = @($AkAuditCatalog.entries)
$AkAuditFinalEntries = @($AkAuditCatalogEntries | Where-Object { $_.final_level })
$AkAuditCatalogPass = $AkAuditCatalogEntries.Count -eq 8 -and
    $AkAuditFinalEntries.Count -eq 1 -and [int]$AkAuditFinalEntries[0].sequence -eq 8
$AkAuditMatrixPath = 'docs/level_design/validation/submission_core_1_12_curriculum_matrix.json'
$AkAuditMatrixFile = Join-Path $AkAuditRoot $AkAuditMatrixPath.Replace('/', '\')
$AkAuditMatrix = Get-Content -Raw -LiteralPath $AkAuditMatrixFile |
    ConvertFrom-Json -Depth 100 -ErrorAction Stop
$AkAuditLnPairs = @($AkAuditMatrix.levels | ForEach-Object {
    [ordered]@{
        sequence = [int]$_.sequence
        level_id = [string]$_.level_id
        l_star = $_.solver.l_star
        n_star = $_.solver.n_star
        n_status = [string]$_.solver.n_status
    }
})
$AkAuditMatrixPass = $AkAuditLnPairs.Count -eq 12 -and
    @($AkAuditLnPairs.sequence | Sort-Object -Unique).Count -eq 12 -and
    @($AkAuditLnPairs | Where-Object {
        $_.sequence -lt 1 -or $_.sequence -gt 12 -or $null -eq $_.l_star -or
        $null -eq $_.n_star -or $_.n_status -ne 'EXACT'
    }).Count -eq 0 -and
    (Get-Task0024AKBlobIdentity -AkAuditRef $AkAuditTaskStartHead -AkAuditPath $AkAuditMatrixPath) -eq
    (Get-Task0024AKCurrentBlobIdentity -AkAuditPath $AkAuditMatrixPath)
$AkAuditMismatchCount = @($AkAuditHistoricalInventory | Where-Object {
    $_.expected_blob -ne $_.current_blob
}).Count + @($AkAuditProtectedInventory | Where-Object {
    $_.expected_blob -ne $_.current_blob
}).Count + @($AkAuditAjManifestInventory | Where-Object {
    $_.expected_blob -ne $_.current_blob
}).Count
$AkAuditPass = $AkAuditUnauthorizedPaths.Count -eq 0 -and
    $AkAuditMismatchCount -eq 0 -and $AkAuditAjConsumed -and
    $AkAuditFrozenValidator.expected_blob -eq $AkAuditFrozenValidator.current_blob -and
    $AkAuditWrapperBlob -eq '5f14eb0feff903b40311c1c7283b20e2eabbffc2' -and
    $AkAuditConfigActual -eq $AkAuditConfigExpected -and
    $AkAuditConfigStatus.Count -eq 1 -and $AkAuditConfigStatus[0] -like '?? *' -and
    @($AkAuditDriverErrors).Count -eq 0 -and $AkAuditDriverDotInvocations.Count -eq 0 -and
    @($AkAuditModuleErrors).Count -eq 0 -and $AkAuditTopLevelParamCount -eq 0 -and
    $AkAuditGenericParameterHits.Count -eq 0 -and
    $AkAuditLoadedModule.ExportedVariables.Count -eq 0 -and
    @(Compare-Object $AkAuditExpectedExports $AkAuditActualExports).Count -eq 0 -and
    $AkAuditCatalogPass -and $AkAuditMatrixPass
$AkAuditResult = [ordered]@{
    schema_version = 1
    task_identity = '0024AK'
    phase = $AkAuditPhase
    status = if ($AkAuditPass) { 'PASS' } else { 'FAIL' }
    task_start_head = $AkAuditTaskStartHead
    changed_paths = $AkAuditChangedPaths
    unauthorized_changed_paths = $AkAuditUnauthorizedPaths
    historical_af_aj_inventory = $AkAuditHistoricalInventory
    protected_inventory = $AkAuditProtectedInventory
    historical_mismatch_count = $AkAuditMismatchCount
    aj_manifest_sidecar_blocker_inventory = $AkAuditAjManifestInventory
    aj_consumed_before_first_case = $AkAuditAjConsumed
    frozen_aj_validator = $AkAuditFrozenValidator
    wrapper_blob = $AkAuditWrapperBlob
    config_path = '.codex/config.toml'
    config_sha256_expected = $AkAuditConfigExpected
    config_sha256_actual = $AkAuditConfigActual
    config_untracked_only = $AkAuditConfigStatus.Count -eq 1 -and $AkAuditConfigStatus[0] -like '?? *'
    driver_ast_error_count = @($AkAuditDriverErrors).Count
    driver_dot_invocation_count = $AkAuditDriverDotInvocations.Count
    module_ast_error_count = @($AkAuditModuleErrors).Count
    module_top_level_param_count = $AkAuditTopLevelParamCount
    module_generic_parameter_hits = $AkAuditGenericParameterHits
    module_exported_functions = $AkAuditActualExports
    module_exported_variable_count = $AkAuditLoadedModule.ExportedVariables.Count
    production_catalog_count = $AkAuditCatalogEntries.Count
    production_finale_sequences = @($AkAuditFinalEntries.sequence)
    catalog_gate_pass = $AkAuditCatalogPass
    ad_12_l_n_pairs = $AkAuditLnPairs
    ad_matrix_gate_pass = $AkAuditMatrixPass
}
$AkAuditResult | ConvertTo-Json -Depth 100 -Compress
if (-not $AkAuditPass) {
    exit 1
}
