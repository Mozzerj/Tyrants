disableSerialization;
private _d = findDisplay 1700;
if (isNull _d) exitWith {};
private _defs = missionNamespace getVariable ["TYR_DebugTaskDefinitions",[]];
private _statusMap = missionNamespace getVariable ["TYR_DebugTaskStatus",createHashMap];
private _list = _d displayCtrl 2201;
private _selected = lbCurSel _list;
if (_selected < 0) then {_selected = 0};
lbClear _list;
private _passed = 0;
private _failed = 0;
{
    private _status = _statusMap getOrDefault [str _forEachIndex,""];
    if (_status isEqualTo "PASS") then {_passed = _passed + 1};
    if (_status isEqualTo "FAIL") then {_failed = _failed + 1};
    private _prefix = switch (_status) do {case "PASS":{"[PASS]"};case "FAIL":{"[FAIL]"};default{"[ ]"}};
    private _row = _list lbAdd format ["%1 %2",_prefix,_x # 0];
    if (_status isEqualTo "PASS") then {_list lbSetColor [_row,[0.45,0.85,0.50,1]]};
    if (_status isEqualTo "FAIL") then {_list lbSetColor [_row,[0.95,0.40,0.35,1]]};
} forEach _defs;
if (count _defs > 0) then {
    _selected = _selected min ((count _defs)-1);
    _list lbSetCurSel _selected;
    private _def = _defs # _selected;
    (_d displayCtrl 2202) ctrlSetText format ["%1\n\nSTATUS // %2",_def # 1,_statusMap getOrDefault [str _selected,"NOT TESTED"]];
};
(_d displayCtrl 2200) ctrlSetText format ["MANUAL TESTS // %1 PASS // %2 FAIL // %3 TOTAL",_passed,_failed,count _defs];
