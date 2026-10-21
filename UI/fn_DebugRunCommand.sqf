params [["_server",false]];
disableSerialization;
if !(missionNamespace getVariable ["TYR_debugMode",false]) exitWith {
    hint "Developer Debug Mode is disabled.";
};

private _display = findDisplay 1700;
if (isNull _display) exitWith {};
private _editor = _display displayCtrl 2401;
private _resultCtrl = _display displayCtrl 2404;
private _code = ctrlText _editor;
if (_code isEqualTo "") exitWith {
    _resultCtrl ctrlSetText "No command entered.";
};

missionNamespace setVariable ["TYR_DebugLastCommand",_code];
if (_server) exitWith {
    _resultCtrl ctrlSetText "SERVER // command sent...";
    ["command",[_code]] remoteExecCall ["TYR_fnc_ServerDebugAction",2];
};

private _result = call compile _code;
private _text = format ["LOCAL RESULT // %1",str _result];
missionNamespace setVariable ["TYR_DebugCommandResult",_text];
_resultCtrl ctrlSetText _text;
diag_log format ["[TYRANTS DEBUG COMMAND][LOCAL] %1 // RESULT %2",_code,str _result];
