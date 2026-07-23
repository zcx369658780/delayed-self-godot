function Stop-Task0024ALParser {
    param([Parameter(Mandatory)][string]$AlParserReason)
    throw "TASK_0024AL_PARSER_FAIL:$AlParserReason"
}

function Get-Task0024ALSha256 {
    param([Parameter(Mandatory)][AllowEmptyCollection()][byte[]]$AlParserBytes)
    $AlParserAlgorithm = [Security.Cryptography.SHA256]::Create()
    try {
        -join ($AlParserAlgorithm.ComputeHash($AlParserBytes) | ForEach-Object { $_.ToString('x2') })
    }
    finally {
        $AlParserAlgorithm.Dispose()
    }
}

function Get-Task0024ALLiteralCount {
    param(
        [Parameter(Mandatory)][AllowEmptyCollection()][object[]]$AlParserValues,
        [Parameter(Mandatory)][string]$AlParserLiteral
    )
    if ([string]::IsNullOrEmpty($AlParserLiteral)) {
        Stop-Task0024ALParser 'MARKER_EMPTY'
    }
    $AlParserCount = 0
    foreach ($AlParserValue in @($AlParserValues)) {
        if ($AlParserValue -isnot [string]) {
            Stop-Task0024ALParser 'STDOUT_ITEM_NOT_STRING'
        }
        $AlParserText = [string]$AlParserValue
        $AlParserOffset = 0
        while ($AlParserOffset -le $AlParserText.Length - $AlParserLiteral.Length) {
            $AlParserFound = $AlParserText.IndexOf(
                $AlParserLiteral, $AlParserOffset, [StringComparison]::Ordinal
            )
            if ($AlParserFound -lt 0) { break }
            $AlParserCount++
            $AlParserOffset = $AlParserFound + $AlParserLiteral.Length
        }
    }
    [long]$AlParserCount
}

function Test-Task0024ALWrapperRecord {
    param(
        [Parameter(Mandatory)][pscustomobject]$AlParserRecord,
        [Parameter(Mandatory)][string]$AlParserRequiredMarker,
        [Parameter(Mandatory)][ValidateSet('RequireEmpty', 'AggregateMismatch')][string]$AlParserStderrPolicy
    )
    $AlParserRequirements = [ordered]@{
        schema_version = 'integer'; status = 'string'; underlying_status = 'string'
        native_exit_code = 'integer'; timed_out = 'boolean'; marker_pass = 'boolean'
        stderr_pass = 'boolean'; cleanup_invocation_count = 'integer'; cleanup_order = 'array'
        remaining_owned_pids = 'array'; remaining_unproven_pids = 'array'
        stdout = 'array'; stderr = 'array'; wrapper_error = 'string'; cleanup_error = 'string'
    }
    foreach ($AlParserRequirement in $AlParserRequirements.GetEnumerator()) {
        $AlParserProperty = $AlParserRecord.PSObject.Properties[$AlParserRequirement.Key]
        if ($null -eq $AlParserProperty -or $null -eq $AlParserProperty.Value) {
            Stop-Task0024ALParser "MISSING_OR_NULL:$($AlParserRequirement.Key)"
        }
        $AlParserValue = $AlParserProperty.Value
        $AlParserOkay = switch ($AlParserRequirement.Value) {
            'integer' { $AlParserValue -is [int] -or $AlParserValue -is [long] }
            'string' { $AlParserValue -is [string] }
            'boolean' { $AlParserValue -is [bool] }
            'array' { $AlParserValue -is [array] }
        }
        if (-not $AlParserOkay) {
            Stop-Task0024ALParser "WRONG_TYPE:$($AlParserRequirement.Key):$($AlParserRequirement.Value)"
        }
    }
    $AlParserMarkerCount = Get-Task0024ALLiteralCount `
        -AlParserValues @($AlParserRecord.stdout) -AlParserLiteral $AlParserRequiredMarker
    if ($AlParserMarkerCount -ne 1) {
        Stop-Task0024ALParser "REQUIRED_MARKER_OCCURRENCE_COUNT:$AlParserMarkerCount"
    }
    if ([int]$AlParserRecord.schema_version -ne 2 -or
        $AlParserRecord.status -ne 'PASS' -or $AlParserRecord.underlying_status -ne 'PASS' -or
        [int]$AlParserRecord.native_exit_code -ne 0 -or $AlParserRecord.timed_out -or
        -not $AlParserRecord.marker_pass -or -not $AlParserRecord.stderr_pass -or
        [int]$AlParserRecord.cleanup_invocation_count -ne 1 -or
        @($AlParserRecord.cleanup_order).Count -ne 1 -or
        @($AlParserRecord.remaining_owned_pids).Count -ne 0 -or
        @($AlParserRecord.remaining_unproven_pids).Count -ne 0 -or
        -not [string]::IsNullOrEmpty([string]$AlParserRecord.wrapper_error) -or
        -not [string]::IsNullOrEmpty([string]$AlParserRecord.cleanup_error)) {
        Stop-Task0024ALParser 'WRAPPER_PASS_CONTRACT_FAILED'
    }
    if ($AlParserStderrPolicy -eq 'RequireEmpty' -and @($AlParserRecord.stderr).Count -ne 0) {
        Stop-Task0024ALParser 'STDERR_NOT_EMPTY'
    }
    if ($AlParserStderrPolicy -eq 'AggregateMismatch' -and
        (@($AlParserRecord.stderr) -join "`n") -ne 'LEVEL_ID_MISMATCH') {
        Stop-Task0024ALParser 'AGGREGATE_STDERR_MISMATCH'
    }
    [long]$AlParserMarkerCount
}

function ConvertFrom-Task0024ALWrapperValues {
    param(
        [Parameter(Mandatory)][AllowEmptyCollection()][object[]]$AlParserValues,
        [Parameter(Mandatory)][string]$AlParserRequiredMarker,
        [Parameter(Mandatory)][ValidateSet('RequireEmpty', 'AggregateMismatch')][string]$AlParserStderrPolicy
    )
    $AlParserNonempty = @($AlParserValues | Where-Object {
        $_ -isnot [string] -or -not [string]::IsNullOrWhiteSpace([string]$_)
    })
    if ($AlParserNonempty.Count -ne 1) {
        Stop-Task0024ALParser "EXPECTED_ONE_NONEMPTY_VALUE:$($AlParserNonempty.Count)"
    }
    if ($AlParserNonempty[0] -isnot [string]) {
        Stop-Task0024ALParser 'RESULT_NOT_STRING'
    }
    $AlParserRaw = [string]$AlParserNonempty[0]
    if ($AlParserRaw -ne $AlParserRaw.Trim() -or $AlParserRaw -match '[\r\n]' -or
        -not $AlParserRaw.StartsWith('{') -or -not $AlParserRaw.EndsWith('}')) {
        Stop-Task0024ALParser 'RESULT_NOT_COMPACT_OBJECT'
    }
    try { $AlParserRecord = $AlParserRaw | ConvertFrom-Json -Depth 100 -ErrorAction Stop }
    catch { Stop-Task0024ALParser 'INVALID_JSON' }
    if ($AlParserRecord -is [array] -or $AlParserRecord -isnot [pscustomobject]) {
        Stop-Task0024ALParser 'RESULT_NOT_OBJECT'
    }
    $AlParserMarkerCount = Test-Task0024ALWrapperRecord `
        -AlParserRecord $AlParserRecord `
        -AlParserRequiredMarker $AlParserRequiredMarker `
        -AlParserStderrPolicy $AlParserStderrPolicy
    $AlParserBytes = [Text.Encoding]::UTF8.GetBytes($AlParserRaw)
    [pscustomobject][ordered]@{
        raw_json = $AlParserRaw
        raw_utf8_byte_count = [long]$AlParserBytes.Length
        raw_sha256 = Get-Task0024ALSha256 -AlParserBytes $AlParserBytes
        required_marker_occurrence_count = $AlParserMarkerCount
        parsed_record = $AlParserRecord
    }
}

function ConvertFrom-Task0024ALRouteRecord {
    param(
        [Parameter(Mandatory)][string]$AlParserRaw,
        [Parameter(Mandatory)][string]$AlParserRequiredMarker,
        [Parameter(Mandatory)][string]$AlParserExpectedScript
    )
    try { $AlParserRecord = $AlParserRaw | ConvertFrom-Json -Depth 100 -ErrorAction Stop }
    catch { Stop-Task0024ALParser 'ROUTE_INVALID_JSON' }
    if ($AlParserRecord -is [array] -or $AlParserRecord -isnot [pscustomobject]) {
        Stop-Task0024ALParser 'ROUTE_NOT_OBJECT'
    }
    $AlParserMarkerCount = Test-Task0024ALWrapperRecord `
        -AlParserRecord $AlParserRecord -AlParserRequiredMarker $AlParserRequiredMarker `
        -AlParserStderrPolicy 'RequireEmpty'
    foreach ($AlParserField in @(
        'wrapper_process_exit', 'case_script_path', 'qualification_flag',
        'required_marker', 'required_marker_count', 'godot_before_count', 'godot_after_count'
    )) {
        if ($null -eq $AlParserRecord.PSObject.Properties[$AlParserField] -or
            $null -eq $AlParserRecord.$AlParserField) {
            Stop-Task0024ALParser "ROUTE_MISSING_OR_NULL:$AlParserField"
        }
    }
    if ([int]$AlParserRecord.wrapper_process_exit -ne 0 -or
        $AlParserRecord.case_script_path -ne $AlParserExpectedScript -or
        $AlParserRecord.required_marker -ne $AlParserRequiredMarker -or
        [int]$AlParserRecord.required_marker_count -ne 1 -or
        [int]$AlParserRecord.godot_before_count -ne 0 -or
        [int]$AlParserRecord.godot_after_count -ne 0 -or
        [string]::IsNullOrWhiteSpace([string]$AlParserRecord.qualification_flag)) {
        Stop-Task0024ALParser 'ROUTE_CONTRACT_FAILED'
    }
    $AlParserBytes = [Text.Encoding]::UTF8.GetBytes($AlParserRaw)
    [pscustomobject][ordered]@{
        raw_json = $AlParserRaw
        raw_utf8_byte_count = [long]$AlParserBytes.Length
        raw_sha256 = Get-Task0024ALSha256 -AlParserBytes $AlParserBytes
        required_marker_occurrence_count = $AlParserMarkerCount
        parsed_record = $AlParserRecord
        route_facts = [ordered]@{
            qualification_flag = [string]$AlParserRecord.qualification_flag
            case_script_path = [string]$AlParserRecord.case_script_path
            godot_before_count = [int]$AlParserRecord.godot_before_count
            godot_after_count = [int]$AlParserRecord.godot_after_count
        }
    }
}

function ConvertFrom-Task0024ALEvidenceLines {
    param([Parameter(Mandatory)][AllowEmptyCollection()][string[]]$AlParserLines)
    $AlParserRequired = @(
        'multi_subagent_ledger','adapter_parser_qualification','static_preservation',
        'candidate_route_preflight','sensor_public_contract_inventory',
        'sensor_barrier_lifecycle','swapped_identity_wrong_actor_control',
        'lifecycle_signature_registry','crate_lifecycle','key_lock_inventory_lifecycle',
        'latch_lifecycle','fit_layering_v1_regression','summary'
    )
    $AlParserSeen = @{}
    $AlParserRecords = @()
    foreach ($AlParserLine in @($AlParserLines)) {
        if (-not $AlParserLine.StartsWith('TASK_0024AJ_EVIDENCE ')) { continue }
        $AlParserRaw = $AlParserLine.Substring('TASK_0024AJ_EVIDENCE '.Length)
        $AlParserBytes = [Text.Encoding]::UTF8.GetBytes($AlParserRaw)
        if ($AlParserBytes.Length -ge 1800) { Stop-Task0024ALParser 'EVIDENCE_OVER_BOUND' }
        try { $AlParserRecord = $AlParserRaw | ConvertFrom-Json -Depth 100 -ErrorAction Stop }
        catch { Stop-Task0024ALParser 'EVIDENCE_INVALID_JSON' }
        if ($AlParserRecord -isnot [pscustomobject] -or [int]$AlParserRecord.schema_version -ne 1 -or
            $AlParserRecord.kind -isnot [string] -or $AlParserRequired -notcontains $AlParserRecord.kind) {
            Stop-Task0024ALParser 'EVIDENCE_IDENTITY_INVALID'
        }
        if ($AlParserSeen.ContainsKey([string]$AlParserRecord.kind)) {
            Stop-Task0024ALParser "EVIDENCE_DUPLICATE:$($AlParserRecord.kind)"
        }
        $AlParserSeen[[string]$AlParserRecord.kind] = $AlParserRecord
        $AlParserRecords += [ordered]@{
            kind = [string]$AlParserRecord.kind
            raw_utf8_byte_count = [long]$AlParserBytes.Length
            raw_sha256 = Get-Task0024ALSha256 -AlParserBytes $AlParserBytes
            record = $AlParserRecord
        }
    }
    foreach ($AlParserKind in $AlParserRequired) {
        if (-not $AlParserSeen.ContainsKey($AlParserKind)) {
            Stop-Task0024ALParser "EVIDENCE_MISSING:$AlParserKind"
        }
    }
    $AlParserRegistry = $AlParserSeen['lifecycle_signature_registry']
    $AlParserSignatures = @($AlParserRegistry.label_to_signature.PSObject.Properties |
        ForEach-Object { [string]$_.Value })
    $AlParserRoute = $AlParserSeen['candidate_route_preflight']
    $AlParserControl = $AlParserSeen['swapped_identity_wrong_actor_control']
    $AlParserLifecycle = $AlParserSeen['sensor_barrier_lifecycle']
    $AlParserActions = @($AlParserLifecycle.per_group_actions)
    $AlParserAction10 = @($AlParserActions | Where-Object { [int]$_.action -eq 10 })
    $AlParserAction11 = @($AlParserActions | Where-Object { [int]$_.action -eq 11 })
    $AlParserAction12 = @($AlParserActions | Where-Object { [int]$_.action -eq 12 })
    $AlParserAction13 = @($AlParserActions | Where-Object { [int]$_.action -eq 13 })
    $AlParserAction11Occupied = @()
    if ($AlParserAction11.Count -eq 1) {
        $AlParserAction11Occupied = @($AlParserAction11[0].occupied_cells)
    }
    $AlParserAction12Occupied = @()
    if ($AlParserAction12.Count -eq 1) {
        $AlParserAction12Occupied = @($AlParserAction12[0].occupied_cells)
    }
    $AlParserSemanticDiagnostics = [ordered]@{
        record_count = $AlParserRecords.Count -ne 13
        registry_count = [int]$AlParserRegistry.count -ne 13
        signature_count = $AlParserSignatures.Count -ne 13
        signature_empty = @($AlParserSignatures | Where-Object {
            [string]::IsNullOrWhiteSpace($_)
        }).Count -ne 0
        signature_unique = @($AlParserSignatures | Sort-Object -Unique).Count -ne 13
        route_count = [int]$AlParserRoute.candidate_count -ne 4 -or
            @($AlParserRoute.records).Count -ne 4
        route_bad = @($AlParserRoute.records | Where-Object {
            -not $_.runtime_ready -or -not $_.snapshot_equal
        }).Count -ne 0
        control = -not $AlParserControl.action_10_reached -or
            $AlParserControl.block_action -ne 'RIGHT' -or
            -not $AlParserControl.block_player_unchanged -or
            $AlParserControl.control_digest -isnot [string] -or
            [string]$AlParserControl.control_digest -notmatch '^[0-9a-f]{64}$' -or
            $AlParserControl.sensor_echo.occupying_actor -ne 'ECHO' -or
            $AlParserControl.sensor_echo.required_activator -ne 'YOU_ONLY' -or
            $AlParserControl.sensor_echo.stable_id -ne 'sensor:sensor_echo' -or
            $AlParserControl.sensor_echo.signature -ne 'SENSOR_YOU_ONLY_INACTIVE_FRAME' -or
            $AlParserControl.sensor_you.occupying_actor -ne 'YOU' -or
            $AlParserControl.sensor_you.required_activator -ne 'ECHO_ONLY' -or
            $AlParserControl.sensor_you.stable_id -ne 'sensor:sensor_you' -or
            $AlParserControl.sensor_you.signature -ne 'SENSOR_ECHO_ONLY_INACTIVE_FRAME'
        action_counts = $AlParserAction10.Count -ne 1 -or $AlParserAction11.Count -ne 1 -or
            $AlParserAction12.Count -ne 1 -or $AlParserAction13.Count -ne 1 -or
            @($AlParserActions).Count -ne 4
        action_10 = if ($AlParserAction10.Count -eq 1) {
            -not $AlParserAction10[0].requested_open -or
            -not $AlParserAction10[0].effective_open -or
            $AlParserAction10[0].closure_deferred -or
            @($AlParserAction10[0].occupied_cells).Count -ne 0
        } else { $true }
        action_11 = if ($AlParserAction11.Count -eq 1) {
            $AlParserAction11[0].requested_open -or
            -not $AlParserAction11[0].effective_open -or
            -not $AlParserAction11[0].closure_deferred -or
            $AlParserAction11Occupied.Count -ne 1 -or
            @($AlParserAction11Occupied[0]).Count -ne 2 -or
            [int]$AlParserAction11Occupied[0][0] -ne 4 -or
            [int]$AlParserAction11Occupied[0][1] -ne 1
        } else { $true }
        action_12 = if ($AlParserAction12.Count -eq 1) {
            $AlParserAction12[0].requested_open -or
            -not $AlParserAction12[0].effective_open -or
            -not $AlParserAction12[0].closure_deferred -or
            $AlParserAction12Occupied.Count -ne 1 -or
            @($AlParserAction12Occupied[0]).Count -ne 2 -or
            [int]$AlParserAction12Occupied[0][0] -ne 5 -or
            [int]$AlParserAction12Occupied[0][1] -ne 1
        } else { $true }
        action_13 = if ($AlParserAction13.Count -eq 1) {
            $AlParserAction13[0].requested_open -or
            $AlParserAction13[0].effective_open -or
            $AlParserAction13[0].closure_deferred -or
            @($AlParserAction13[0].occupied_cells).Count -ne 0
        } else { $true }
    }
    $AlParserSemanticFailures = @($AlParserSemanticDiagnostics.GetEnumerator() |
        Where-Object { $_.Value } | ForEach-Object { $_.Key })
    if ($AlParserSemanticFailures.Count -ne 0) {
        Stop-Task0024ALParser "EVIDENCE_SEMANTIC_CONTRACT_FAILED:$($AlParserSemanticFailures -join ',')"
    }
    [pscustomobject][ordered]@{
        schema_version = 1; status = 'PASS'; record_count = 13
        records = $AlParserRecords
        lifecycle_signature_map = $AlParserRegistry.label_to_signature
    }
}

Export-ModuleMember -Function @(
    'ConvertFrom-Task0024ALWrapperValues',
    'ConvertFrom-Task0024ALRouteRecord',
    'ConvertFrom-Task0024ALEvidenceLines'
)
