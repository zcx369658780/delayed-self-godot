function Stop-Task0024AKParser {
    param([Parameter(Mandatory)][string]$AkParserReason)
    throw "TASK_0024AK_PARSER_FAIL:$AkParserReason"
}

function Get-Task0024AKSha256 {
    param([Parameter(Mandatory)][AllowEmptyCollection()][byte[]]$AkParserBytes)
    $AkParserAlgorithm = [Security.Cryptography.SHA256]::Create()
    try {
        return -join ($AkParserAlgorithm.ComputeHash($AkParserBytes) | ForEach-Object { $_.ToString('x2') })
    }
    finally {
        $AkParserAlgorithm.Dispose()
    }
}

function Get-Task0024AKLiteralOccurrenceCount {
    param(
        [Parameter(Mandatory)][AllowEmptyCollection()][object[]]$AkParserStrings,
        [Parameter(Mandatory)][string]$AkParserLiteral
    )
    if ([string]::IsNullOrEmpty($AkParserLiteral)) {
        Stop-Task0024AKParser 'REQUIRED_MARKER_EMPTY'
    }
    $AkParserOccurrenceCount = 0
    foreach ($AkParserStringValue in @($AkParserStrings)) {
        if ($AkParserStringValue -isnot [string]) {
            Stop-Task0024AKParser 'STDOUT_ITEM_NOT_STRING'
        }
        $AkParserSearchText = [string]$AkParserStringValue
        $AkParserSearchStart = 0
        while ($AkParserSearchStart -le $AkParserSearchText.Length - $AkParserLiteral.Length) {
            $AkParserFoundAt = $AkParserSearchText.IndexOf(
                $AkParserLiteral,
                $AkParserSearchStart,
                [StringComparison]::Ordinal
            )
            if ($AkParserFoundAt -lt 0) {
                break
            }
            $AkParserOccurrenceCount++
            $AkParserSearchStart = $AkParserFoundAt + $AkParserLiteral.Length
        }
    }
    [long]$AkParserOccurrenceCount
}

function ConvertFrom-Task0024AKWrapperValues {
    param(
        [Parameter(Mandatory)][AllowEmptyCollection()][object[]]$AkParserValues,
        [string]$AkParserRequiredMarker = ''
    )
    $AkParserNormalized = [Collections.Generic.List[object]]::new()
    foreach ($AkParserValue in @($AkParserValues)) {
        if ($AkParserValue -isnot [string] -or -not [string]::IsNullOrWhiteSpace([string]$AkParserValue)) {
            $AkParserNormalized.Add($AkParserValue)
        }
    }
    if ($AkParserNormalized.Count -ne 1) {
        Stop-Task0024AKParser "EXPECTED_ONE_NONEMPTY_VALUE:$($AkParserNormalized.Count)"
    }
    $AkParserRaw = $AkParserNormalized[0]
    if ($AkParserRaw -isnot [string]) {
        Stop-Task0024AKParser "RESULT_NOT_STRING:$($AkParserRaw.GetType().FullName)"
    }
    $AkParserRaw = [string]$AkParserRaw
    $AkParserTrimmed = $AkParserRaw.Trim()
    if ($AkParserRaw -ne $AkParserTrimmed -or $AkParserRaw -match '[\r\n]' -or
        -not $AkParserTrimmed.StartsWith('{') -or -not $AkParserTrimmed.EndsWith('}')) {
        Stop-Task0024AKParser 'RESULT_NOT_JSON_OBJECT'
    }
    try {
        if ((Get-Command ConvertFrom-Json).Parameters.ContainsKey('Depth')) {
            $AkParserRecord = $AkParserRaw | ConvertFrom-Json -Depth 100 -ErrorAction Stop
        }
        else {
            $AkParserRecord = $AkParserRaw | ConvertFrom-Json -ErrorAction Stop
        }
    }
    catch {
        Stop-Task0024AKParser 'INVALID_JSON'
    }
    if ($AkParserRecord -is [array] -or $AkParserRecord -isnot [pscustomobject]) {
        Stop-Task0024AKParser 'RESULT_NOT_OBJECT'
    }
    $AkParserRequirements = [ordered]@{
        schema_version = 'integer'
        status = 'string'
        underlying_status = 'string'
        native_exit_code = 'integer'
        timed_out = 'boolean'
        marker_pass = 'boolean'
        stderr_policy = 'string'
        stderr_pass = 'boolean'
        cleanup_invocation_count = 'integer'
        cleanup_order = 'array'
        cleanup_closed_pids = 'array'
        remaining_owned_pids = 'array'
        remaining_unproven_pids = 'array'
        owned_records = 'array'
        unproven_records = 'array'
        stdout = 'array'
        stderr = 'array'
        wrapper_error = 'string'
        cleanup_error = 'string'
    }
    foreach ($AkParserRequirement in $AkParserRequirements.GetEnumerator()) {
        $AkParserProperty = $AkParserRecord.PSObject.Properties[$AkParserRequirement.Key]
        if ($null -eq $AkParserProperty -or $null -eq $AkParserProperty.Value) {
            Stop-Task0024AKParser "MISSING_OR_NULL:$($AkParserRequirement.Key)"
        }
        $AkParserValue = $AkParserProperty.Value
        $AkParserTypeOkay = switch ($AkParserRequirement.Value) {
            'integer' { $AkParserValue -is [int] -or $AkParserValue -is [long] }
            'string' { $AkParserValue -is [string] }
            'boolean' { $AkParserValue -is [bool] }
            'array' { $AkParserValue -is [array] }
        }
        if (-not $AkParserTypeOkay) {
            Stop-Task0024AKParser "WRONG_TYPE:$($AkParserRequirement.Key):$($AkParserRequirement.Value)"
        }
    }
    if ([int]$AkParserRecord.schema_version -ne 2) {
        Stop-Task0024AKParser 'SCHEMA_VERSION_NOT_2'
    }
    $AkParserMarkerOccurrenceCount = $null
    if (-not [string]::IsNullOrEmpty($AkParserRequiredMarker)) {
        $AkParserMarkerOccurrenceCount = Get-Task0024AKLiteralOccurrenceCount `
            -AkParserStrings @($AkParserRecord.stdout) `
            -AkParserLiteral $AkParserRequiredMarker
        if ($AkParserMarkerOccurrenceCount -ne 1) {
            Stop-Task0024AKParser "REQUIRED_MARKER_OCCURRENCE_COUNT:$AkParserMarkerOccurrenceCount"
        }
    }
    $AkParserUtf8 = [Text.Encoding]::UTF8.GetBytes($AkParserRaw)
    [pscustomobject][ordered]@{
        raw_wrapper_json = $AkParserRaw
        raw_utf8_byte_count = [long]$AkParserUtf8.Length
        raw_utf8_sha256 = Get-Task0024AKSha256 -AkParserBytes $AkParserUtf8
        required_marker_occurrence_count = $AkParserMarkerOccurrenceCount
        parsed_record = $AkParserRecord
    }
}

function ConvertFrom-Task0024AKEvidenceLines {
    param([Parameter(Mandatory)][AllowEmptyCollection()][string[]]$AkParserLines)
    $AkParserRequiredKinds = @(
        'multi_subagent_ledger',
        'adapter_parser_qualification',
        'static_preservation',
        'candidate_route_preflight',
        'sensor_public_contract_inventory',
        'sensor_barrier_lifecycle',
        'swapped_identity_wrong_actor_control',
        'lifecycle_signature_registry',
        'crate_lifecycle',
        'key_lock_inventory_lifecycle',
        'latch_lifecycle',
        'fit_layering_v1_regression',
        'summary'
    )
    $AkParserSeen = @{}
    $AkParserRecords = @()
    foreach ($AkParserLine in @($AkParserLines)) {
        if (-not $AkParserLine.StartsWith('TASK_0024AJ_EVIDENCE ')) {
            continue
        }
        $AkParserRaw = $AkParserLine.Substring('TASK_0024AJ_EVIDENCE '.Length)
        $AkParserUtf8 = [Text.Encoding]::UTF8.GetBytes($AkParserRaw)
        if ($AkParserUtf8.Length -ge 1800) {
            Stop-Task0024AKParser "EVIDENCE_OVER_BOUND:$($AkParserUtf8.Length)"
        }
        try {
            if ((Get-Command ConvertFrom-Json).Parameters.ContainsKey('Depth')) {
                $AkParserRecord = $AkParserRaw | ConvertFrom-Json -Depth 100 -ErrorAction Stop
            }
            else {
                $AkParserRecord = $AkParserRaw | ConvertFrom-Json -ErrorAction Stop
            }
        }
        catch {
            Stop-Task0024AKParser 'EVIDENCE_INVALID_JSON'
        }
        if ($AkParserRecord -is [array] -or $AkParserRecord -isnot [pscustomobject]) {
            Stop-Task0024AKParser 'EVIDENCE_NOT_OBJECT'
        }
        if ($AkParserRecord.schema_version -isnot [int] -and $AkParserRecord.schema_version -isnot [long]) {
            Stop-Task0024AKParser 'EVIDENCE_SCHEMA_WRONG_TYPE'
        }
        if ([int]$AkParserRecord.schema_version -ne 1 -or
            $AkParserRecord.kind -isnot [string] -or
            [string]::IsNullOrWhiteSpace([string]$AkParserRecord.kind)) {
            Stop-Task0024AKParser 'EVIDENCE_MISSING_SCHEMA_OR_KIND'
        }
        $AkParserKind = [string]$AkParserRecord.kind
        if ($AkParserRequiredKinds -notcontains $AkParserKind) {
            Stop-Task0024AKParser "EVIDENCE_UNKNOWN_KIND:$AkParserKind"
        }
        if ($AkParserSeen.ContainsKey($AkParserKind)) {
            Stop-Task0024AKParser "EVIDENCE_DUPLICATE_KIND:$AkParserKind"
        }
        $AkParserSeen[$AkParserKind] = $AkParserRecord
        $AkParserRecords += [ordered]@{
            kind = $AkParserKind
            utf8_byte_count = [long]$AkParserUtf8.Length
            utf8_sha256 = Get-Task0024AKSha256 -AkParserBytes $AkParserUtf8
            record = $AkParserRecord
        }
    }
    foreach ($AkParserKind in $AkParserRequiredKinds) {
        if (-not $AkParserSeen.ContainsKey($AkParserKind)) {
            Stop-Task0024AKParser "EVIDENCE_MISSING_KIND:$AkParserKind"
        }
    }
    if ($AkParserRecords.Count -ne 13) {
        Stop-Task0024AKParser "EVIDENCE_EXACT_COUNT_MISMATCH:$($AkParserRecords.Count)"
    }
    $AkParserRoute = $AkParserSeen['candidate_route_preflight']
    if (($AkParserRoute.candidate_count -isnot [int] -and $AkParserRoute.candidate_count -isnot [long]) -or
        [int]$AkParserRoute.candidate_count -ne 4 -or @($AkParserRoute.records).Count -ne 4 -or
        @($AkParserRoute.records | Where-Object { -not $_.runtime_ready -or -not $_.snapshot_equal }).Count -ne 0) {
        Stop-Task0024AKParser 'EVIDENCE_CANDIDATE_ROUTE_PREFLIGHT_INVALID'
    }
    $AkParserRegistry = $AkParserSeen['lifecycle_signature_registry']
    $AkParserSignatures = @($AkParserRegistry.label_to_signature.PSObject.Properties | ForEach-Object { [string]$_.Value })
    if ([int]$AkParserRegistry.count -ne 13 -or $AkParserSignatures.Count -ne 13 -or
        @($AkParserSignatures | Where-Object { [string]::IsNullOrWhiteSpace($_) }).Count -ne 0 -or
        @($AkParserSignatures | Sort-Object -Unique).Count -ne 13) {
        Stop-Task0024AKParser 'EVIDENCE_SIGNATURE_REGISTRY_INVALID'
    }
    $AkParserControl = $AkParserSeen['swapped_identity_wrong_actor_control']
    $AkParserControlPlayer = @($AkParserControl.occupancy.player)
    $AkParserControlEchoes = @($AkParserControl.occupancy.echoes)
    $AkParserControlEchoPosition = if ($AkParserControlEchoes.Count -eq 1) {
        @($AkParserControlEchoes[0].position)
    }
    else {
        @()
    }
    if ($AkParserControl.action_10_reached -isnot [bool] -or
        -not $AkParserControl.action_10_reached -or
        $AkParserControl.block_action -ne 'RIGHT' -or
        $AkParserControl.block_player_unchanged -isnot [bool] -or
        -not $AkParserControl.block_player_unchanged -or
        $AkParserControl.control_digest -isnot [string] -or
        [string]$AkParserControl.control_digest -notmatch '^[0-9a-f]{64}$' -or
        $AkParserControl.control_source -ne 'Task 0024AB literal stable-ID activator swap' -or
        $AkParserControlPlayer.Count -ne 2 -or
        [int]$AkParserControlPlayer[0] -ne 3 -or [int]$AkParserControlPlayer[1] -ne 1 -or
        $AkParserControlEchoes.Count -ne 1 -or
        $AkParserControlEchoes[0].id -ne 'echo_identity' -or
        $AkParserControlEchoPosition.Count -ne 2 -or
        [int]$AkParserControlEchoPosition[0] -ne 5 -or
        [int]$AkParserControlEchoPosition[1] -ne 5 -or
        $AkParserControl.occupancy.player -isnot [array] -or
        $AkParserControl.occupancy.echoes -isnot [array] -or
        $AkParserControl.occupancy.pressed_sensor_ids -isnot [array] -or
        @($AkParserControl.occupancy.pressed_sensor_ids).Count -ne 0 -or
        $AkParserControl.sensor_echo.occupying_actor -ne 'ECHO' -or
        $AkParserControl.sensor_echo.required_activator -ne 'YOU_ONLY' -or
        $AkParserControl.sensor_echo.signature -ne 'SENSOR_YOU_ONLY_INACTIVE_FRAME' -or
        $AkParserControl.sensor_echo.stable_id -ne 'sensor:sensor_echo' -or
        $AkParserControl.sensor_echo.state_variant -ne 'YOU_ONLY_INACTIVE' -or
        $AkParserControl.sensor_you.occupying_actor -ne 'YOU' -or
        $AkParserControl.sensor_you.required_activator -ne 'ECHO_ONLY' -or
        $AkParserControl.sensor_you.signature -ne 'SENSOR_ECHO_ONLY_INACTIVE_FRAME' -or
        $AkParserControl.sensor_you.stable_id -ne 'sensor:sensor_you' -or
        $AkParserControl.sensor_you.state_variant -ne 'ECHO_ONLY_INACTIVE') {
        Stop-Task0024AKParser 'EVIDENCE_SWAPPED_IDENTITY_CONTROL_INVALID'
    }
    $AkParserLifecycle = $AkParserSeen['sensor_barrier_lifecycle']
    $AkParserAction10 = @($AkParserLifecycle.per_group_actions | Where-Object { [int]$_.action -eq 10 })
    $AkParserAction11 = @($AkParserLifecycle.per_group_actions | Where-Object { [int]$_.action -eq 11 })
    $AkParserAction12 = @($AkParserLifecycle.per_group_actions | Where-Object { [int]$_.action -eq 12 })
    $AkParserAction13 = @($AkParserLifecycle.per_group_actions | Where-Object { [int]$_.action -eq 13 })
    $AkParserAction10States = @($AkParserLifecycle.action_10)
    if ($AkParserAction10States.Count -ne 2 -or
        $AkParserAction10States[0] -ne 'YOU_ONLY_ACTIVE' -or
        $AkParserAction10States[1] -ne 'ECHO_ONLY_ACTIVE' -or
        [int]$AkParserLifecycle.action_11_all_deferred -ne 2 -or
        [int]$AkParserLifecycle.action_12_all_deferred -ne 2 -or
        [int]$AkParserLifecycle.action_13_closed -ne 2 -or
        $AkParserAction10.Count -ne 1 -or
        $AkParserAction11.Count -ne 1 -or
        $AkParserAction12.Count -ne 1 -or
        $AkParserAction13.Count -ne 1) {
        Stop-Task0024AKParser 'EVIDENCE_SENSOR_BARRIER_LIFECYCLE_INVALID'
    }
    $AkParserAction10Record = $AkParserAction10[0]
    $AkParserAction11Record = $AkParserAction11[0]
    $AkParserAction12Record = $AkParserAction12[0]
    $AkParserAction13Record = $AkParserAction13[0]
    foreach ($AkParserActionRecord in @(
        $AkParserAction10Record,
        $AkParserAction11Record,
        $AkParserAction12Record,
        $AkParserAction13Record
    )) {
        if ($AkParserActionRecord.group_id -ne 'bridge_identity' -or
            [int]$AkParserActionRecord.descriptor_count -ne 2 -or
            [int]$AkParserActionRecord.public_cell_count -ne 2 -or
            $AkParserActionRecord.requested_open -isnot [bool] -or
            $AkParserActionRecord.effective_open -isnot [bool] -or
            $AkParserActionRecord.closure_deferred -isnot [bool] -or
            $AkParserActionRecord.occupied_cells -isnot [array] -or
            $AkParserActionRecord.actors_by_public_cell -isnot [pscustomobject] -or
            @($AkParserActionRecord.actors_by_public_cell.PSObject.Properties).Count -ne 2 -or
            $null -eq $AkParserActionRecord.actors_by_public_cell.PSObject.Properties['[4,1]'] -or
            $null -eq $AkParserActionRecord.actors_by_public_cell.PSObject.Properties['[5,1]'] -or
            $AkParserActionRecord.actors_by_public_cell.PSObject.Properties['[4,1]'].Value -isnot [array] -or
            $AkParserActionRecord.actors_by_public_cell.PSObject.Properties['[5,1]'].Value -isnot [array]) {
            Stop-Task0024AKParser 'EVIDENCE_SENSOR_BARRIER_LIFECYCLE_INVALID'
        }
    }
    $AkParserAction10LeftActors = @($AkParserAction10Record.actors_by_public_cell.PSObject.Properties['[4,1]'].Value)
    $AkParserAction10RightActors = @($AkParserAction10Record.actors_by_public_cell.PSObject.Properties['[5,1]'].Value)
    $AkParserAction11LeftActors = @($AkParserAction11Record.actors_by_public_cell.PSObject.Properties['[4,1]'].Value)
    $AkParserAction11RightActors = @($AkParserAction11Record.actors_by_public_cell.PSObject.Properties['[5,1]'].Value)
    $AkParserAction12LeftActors = @($AkParserAction12Record.actors_by_public_cell.PSObject.Properties['[4,1]'].Value)
    $AkParserAction12RightActors = @($AkParserAction12Record.actors_by_public_cell.PSObject.Properties['[5,1]'].Value)
    $AkParserAction13LeftActors = @($AkParserAction13Record.actors_by_public_cell.PSObject.Properties['[4,1]'].Value)
    $AkParserAction13RightActors = @($AkParserAction13Record.actors_by_public_cell.PSObject.Properties['[5,1]'].Value)
    $AkParserAction11Occupied = @($AkParserAction11Record.occupied_cells)
    $AkParserAction12Occupied = @($AkParserAction12Record.occupied_cells)
    if (-not $AkParserAction10Record.requested_open -or
        -not $AkParserAction10Record.effective_open -or
        $AkParserAction10Record.closure_deferred -or
        @($AkParserAction10Record.occupied_cells).Count -ne 0 -or
        $AkParserAction10LeftActors.Count -ne 0 -or $AkParserAction10RightActors.Count -ne 0 -or
        $AkParserAction11Record.requested_open -or
        -not $AkParserAction11Record.effective_open -or
        -not $AkParserAction11Record.closure_deferred -or
        $AkParserAction11Occupied.Count -ne 1 -or
        @($AkParserAction11Occupied[0]).Count -ne 2 -or
        [int]$AkParserAction11Occupied[0][0] -ne 4 -or
        [int]$AkParserAction11Occupied[0][1] -ne 1 -or
        $AkParserAction11LeftActors.Count -ne 1 -or $AkParserAction11LeftActors[0] -ne 'YOU' -or
        $AkParserAction11RightActors.Count -ne 0 -or
        $AkParserAction12Record.requested_open -or
        -not $AkParserAction12Record.effective_open -or
        -not $AkParserAction12Record.closure_deferred -or
        $AkParserAction12Occupied.Count -ne 1 -or
        @($AkParserAction12Occupied[0]).Count -ne 2 -or
        [int]$AkParserAction12Occupied[0][0] -ne 5 -or
        [int]$AkParserAction12Occupied[0][1] -ne 1 -or
        $AkParserAction12LeftActors.Count -ne 0 -or
        $AkParserAction12RightActors.Count -ne 1 -or $AkParserAction12RightActors[0] -ne 'YOU' -or
        $AkParserAction13Record.requested_open -or
        $AkParserAction13Record.effective_open -or
        $AkParserAction13Record.closure_deferred -or
        @($AkParserAction13Record.occupied_cells).Count -ne 0 -or
        $AkParserAction13LeftActors.Count -ne 0 -or $AkParserAction13RightActors.Count -ne 0) {
        Stop-Task0024AKParser 'EVIDENCE_SENSOR_BARRIER_CELL_DEFERRED_INVALID'
    }
    $AkParserSummary = $AkParserSeen['summary']
    if ([int]$AkParserSummary.failures -ne 0 -or [int]$AkParserSummary.candidate_count -ne 4 -or
        [int]$AkParserSummary.signature_count -ne 13) {
        Stop-Task0024AKParser 'EVIDENCE_SUMMARY_INVALID'
    }
    $AkParserTotal = [long]0
    foreach ($AkParserItem in $AkParserRecords) {
        $AkParserTotal += [long]$AkParserItem.utf8_byte_count
    }
    [pscustomobject][ordered]@{
        schema_version = 1
        status = 'PASS'
        record_count = 13
        records = $AkParserRecords
        total_utf8_bytes = $AkParserTotal
    }
}

Export-ModuleMember -Function @(
    'ConvertFrom-Task0024AKWrapperValues',
    'ConvertFrom-Task0024AKEvidenceLines'
)
