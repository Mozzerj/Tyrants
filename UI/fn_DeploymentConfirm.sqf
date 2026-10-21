private _pending = missionNamespace getVariable ["TYR_DeploymentPending",[]];
private _check = missionNamespace getVariable ["TYR_DeploymentLastCheck",[false,"SELECT AN HQ POSITION",0,0,0]];
if (count _pending < 2) exitWith {hint "Click the map to place the HQ footprint first."};
if !(_check # 0) exitWith {hint format ["HQ cannot be confirmed here: %1",_check # 1]};
[_pending] remoteExecCall ["TYR_fnc_ServerConfirmBase",2];
