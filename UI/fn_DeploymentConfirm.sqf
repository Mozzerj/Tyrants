private _pending = missionNamespace getVariable ["TYR_DeploymentPending",[]];
if (count _pending < 2) exitWith {hint "Select a valid HQ position inside your deployment region first."};
[_pending] remoteExecCall ["TYR_fnc_ServerConfirmBase",2];
