[CmdletBinding()]
param()
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'task_0024ag_invoke_wrapper_case.ps1') -Library

$valid = '{"schema_version":2,"status":"PASS","underlying_status":"PASS","native_exit_code":0,"marker_pass":true,"stderr":[],"cleanup_invocation_count":1,"remaining_owned_pids":[],"remaining_unproven_pids":[],"stdout":["marker"]}'
$cases = @(
    @{ name = 'missing_record'; values = @(); expected = 'EXPECTED_ONE_NONEMPTY_VALUE' },
    @{ name = 'duplicate_records'; values = @($valid, $valid); expected = 'EXPECTED_ONE_NONEMPTY_VALUE' },
    @{ name = 'non_json_text'; values = @('not json'); expected = 'RESULT_NOT_JSON_OBJECT' },
    @{ name = 'truncated_json'; values = @('{"schema_version":2'); expected = 'RESULT_NOT_JSON_OBJECT' },
    @{ name = 'json_array'; values = @('[]'); expected = 'RESULT_NOT_JSON_OBJECT' },
    @{ name = 'null_required'; values = @($valid.Replace('"native_exit_code":0', '"native_exit_code":null')); expected = 'MISSING_OR_NULL:native_exit_code' },
    @{ name = 'wrong_schema'; values = @($valid.Replace('"schema_version":2', '"schema_version":1')); expected = 'SCHEMA_VERSION_NOT_2' },
    @{ name = 'wrong_field_type'; values = @($valid.Replace('"marker_pass":true', '"marker_pass":"true"')); expected = 'WRONG_TYPE:marker_pass:boolean' },
    @{ name = 'ambiguous_object_value'; values = @([pscustomobject]@{ schema_version = 2 }); expected = 'RESULT_NOT_STRING' }
)
$results = foreach ($case in $cases) {
    try { [void](ConvertFrom-Task0024AGWrapperValues -Values @($case.values)); throw "probe accepted: $($case.name)" }
    catch {
        $message = $_.Exception.Message
        if (-not $message.Contains($case.expected)) { throw "probe wrong rejection $($case.name): $message" }
        [ordered]@{ name = $case.name; rejected = $true; reason = $case.expected }
    }
}
$accepted = ConvertFrom-Task0024AGWrapperValues -Values @($valid)
if ($accepted.raw_utf8_byte_count -le 0 -or $accepted.raw_utf8_sha256.Length -ne 64) { throw 'valid parser probe did not retain raw UTF-8 identity' }
[ordered]@{ schema_version = 1; status = 'PASS'; probes = @($results); accepted_raw_utf8_byte_count = $accepted.raw_utf8_byte_count; accepted_raw_utf8_sha256 = $accepted.raw_utf8_sha256 } | ConvertTo-Json -Depth 10 -Compress
