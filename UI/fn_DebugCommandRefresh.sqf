disableSerialization;
private _d = findDisplay 1700;
if (isNull _d) exitWith {};
private _lastCommand = missionNamespace getVariable ["TYR_DebugLastCommand",""];
private _editor = _d displayCtrl 2401;
if ((ctrlText _editor) isEqualTo "" && {_lastCommand isNotEqualTo ""}) then {_editor ctrlSetText _lastCommand};
(_d displayCtrl 2404) ctrlSetText (missionNamespace getVariable ["TYR_DebugCommandResult","Result appears here. Script errors still appear in the Arma RPT."]);
