params ["_index"];
if (_index < 0) exitWith {};
[missionNamespace getVariable ["TYR_vlsEmplacementId",""],_index] remoteExecCall ["TYR_fnc_ServerRemoveVLSTarget",2];
