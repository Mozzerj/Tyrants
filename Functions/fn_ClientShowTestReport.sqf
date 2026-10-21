if (!hasInterface) exitWith {};
if (!isRemoteExecuted || {remoteExecutedOwner isNotEqualTo 2}) exitWith {};
params ["_results", ["_meta", []]];
if !(_results isEqualType []) exitWith {};

private _passes = {_x # 1 isEqualTo "PASS"} count _results;
private _fails = {_x # 1 isEqualTo "FAIL"} count _results;
private _warns = {_x # 1 isEqualTo "WARN"} count _results;

private _lines = [
    "TYRANTS AUTOMATED TEST REPORT",
    format ["PASS: %1 | FAIL: %2 | WARN: %3 | TOTAL: %4", _passes, _fails, _warns, count _results],
    ""
];
{
    private _detail = _x param [2, ""];
    _lines pushBack format ["[%1] %2%3", _x # 1, _x # 0, if (_detail isEqualTo "") then {""} else {format [" - %1", _detail]}];
} forEach _results;

TYR_lastTestReport = +_results;
TYR_lastTestReportMeta = +_meta;
TYR_lastTestReportText = _lines joinString toString [13, 10];
profileNamespace setVariable ["TYR_LastTestReport", TYR_lastTestReportText];
saveProfileNamespace;

diag_log "[TYRANTS TEST] ===== CLIENT REPORT =====";
{
    diag_log format ["[TYRANTS TEST] %1", _x];
} forEach _lines;
diag_log "[TYRANTS TEST] ===== END REPORT =====";

systemChat format ["Tyrants tests complete: %1 PASS, %2 FAIL, %3 WARN.", _passes, _fails, _warns];
if (_fails isEqualTo 0) then {
    hint parseText format [
        "<t size='1.25' color='#70db70'>Tyrants tests passed</t><br/><br/>%1 PASS<br/>%2 WARN<br/><br/>Use the action menu: <t color='#f0d060'>Copy Last Tyrants Test Report</t> for the full report.",
        _passes,
        _warns
    ];
} else {
    private _firstFailures = (_results select {_x # 1 isEqualTo "FAIL"}) select [0, 4];
    private _failureText = (_firstFailures apply {format ["• %1", _x # 0]}) joinString "<br/>";
    hint parseText format [
        "<t size='1.25' color='#ff6868'>Tyrants tests found failures</t><br/><br/>%1 PASS<br/>%2 FAIL<br/>%3 WARN<br/><br/>%4<br/><br/>Use <t color='#f0d060'>Copy Last Tyrants Test Report</t> for details.",
        _passes,
        _fails,
        _warns,
        _failureText
    ];
};
