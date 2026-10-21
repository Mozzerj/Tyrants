disableSerialization;
private _d = findDisplay 1700;
if (isNull _d) exitWith {};
private _traces = missionNamespace getVariable ["TYR_DebugAITraces",[]];
private _record = [];
{
    if ((_x param [0,""]) isEqualTo (missionNamespace getVariable ["TYR_debugFaction",""])) exitWith {_record = _x};
} forEach _traces;

private _started = -1;
private _finished = -1;
private _currentStep = 0;
private _nodes = [];
private _candidates = [];
private _decision = "NO DECISION TRACE";
private _posture = "--";
if (count _record >= 8) then {
    _started = _record # 1;
    _finished = _record # 2;
    _currentStep = _record # 3;
    _nodes = _record # 4;
    _candidates = _record # 5;
    _decision = _record # 6;
    _posture = _record # 7;
};
private _defaultBg = [0.045,0.052,0.060,1];
private _doneBg = [0.055,0.12,0.075,1];
private _branchBg = [0.08,0.10,0.16,1];
private _blockedBg = [0.20,0.055,0.045,1];
private _currentBg = [0.25,0.16,0.035,1];
private _skippedBg = [0.035,0.038,0.042,1];
for "_i" from 0 to 11 do {
    private _ctrl = _d displayCtrl (2101 + _i);
    private _node = if (_i < count _nodes) then {_nodes # _i} else {[_i + 1,"WAITING","","pending",""]};
    _node params ["_stepNo","_title","_outcome","_state",["_detail",""]];
    _ctrl ctrlSetText format ["%1 // %2\n%3",_stepNo,toUpper _title,_outcome];
    private _bg = switch (_state) do {
        case "done": {_doneBg}; case "branch": {_branchBg}; case "blocked": {_blockedBg};
        case "current": {_currentBg}; case "skipped": {_skippedBg}; default {_defaultBg};
    };
    if (_stepNo isEqualTo _currentStep) then {_bg = _currentBg};
    _ctrl ctrlSetBackgroundColor _bg;
    _ctrl ctrlSetTextColor (if (_state isEqualTo "skipped") then {[0.42,0.45,0.48,1]} else {[0.90,0.92,0.94,1]});
};
for "_i" from 0 to 10 do {
    private _arrow = _d displayCtrl (2131 + _i);
    private _targetStep = _i + 2;
    private _arrowColor = [0.35,0.38,0.42,1];
    if (_targetStep < _currentStep) then {_arrowColor = [0.28,0.72,0.40,1]};
    if (_targetStep isEqualTo _currentStep) then {_arrowColor = [0.95,0.68,0.12,1]};
    if (_finished >= 0 && {_targetStep <= _currentStep}) then {_arrowColor = [0.28,0.72,0.40,1]};
    _arrow ctrlSetTextColor _arrowColor;
};
private _candidateLines = ["TOP CANDIDATES / VALIDATION"];
{
    if (_forEachIndex < 6) then {
        _x params ["_type","_name","_score","_validState","_reason",["_breakdown",""]];
        private _tag = switch (_validState) do {case "valid":{"PASS"};case "rejected":{"X"};default{"?"}};
        _candidateLines pushBack format ["%1  %2 -> %3  %4 pts",_tag,toUpper _type,toUpper _name,round _score];
    };
} forEach _candidates;
if (count _candidates isEqualTo 0) then {_candidateLines pushBack "No candidate data. Run THINK + TRACE."};
(_d displayCtrl 2150) ctrlSetText (_candidateLines joinString "\n");
(_d displayCtrl 2151) ctrlSetText format ["POSTURE\n%1\n\nDECISION\n%2",toUpper _posture,_decision];
private _serverNow = missionNamespace getVariable ["TYR_DebugServerTime",_started];
private _age = if (_started < 0) then {-1} else {round (_serverNow - _started)};
private _statusText = if (_finished < 0 && {_started >= 0}) then {format ["THINKING // STEP %1",_currentStep]} else {format ["LAST THINK %1s AGO",if (_age < 0) then {"--"} else {_age}]};
(_d displayCtrl 2100) ctrlSetText format ["AI STRATEGIC DECISION PATH // %1 // %2",toUpper (missionNamespace getVariable ["TYR_debugFaction","--"]),_statusText];
