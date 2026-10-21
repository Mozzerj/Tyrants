params [["_scope","SERVER"],["_result","nil"],["_command",""]];
if !(missionNamespace getVariable ["TYR_debugMode",false]) exitWith {};
private _text = format ["%1 RESULT // %2",toUpper _scope,_result];
missionNamespace setVariable ["TYR_DebugCommandResult",_text];
if (_command isNotEqualTo "") then {missionNamespace setVariable ["TYR_DebugLastCommand",_command]};

disableSerialization;
private _display = findDisplay 1700;
if (!isNull _display) then {
    (_display displayCtrl 2404) ctrlSetText _text;
};
