params ["_selected"];
if (_selected < 0) exitWith {hint "Select a target first."};
[_selected] remoteExecCall ["TYR_fnc_ServerRemoveVLSTarget", 2];
closeDialog 0;
