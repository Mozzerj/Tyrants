params ["_mode"];
if (_mode isEqualTo 0) exitWith {
    private _display = findDisplay 1204;
    if (isNull _display) exitWith {};
    private _button = _display displayCtrl 11;
    _button ctrlSetText "ARMED - press LAUNCH";
};
private _asset = missionNamespace getVariable ["TYR_activeVLS", objNull];
if (isNull _asset) exitWith {hint "No VLS selected."};
[_asset] remoteExecCall ["TYR_fnc_ServerLaunchVLS", 2];
closeDialog 0;
