params ["_locationId",["_target",0]];
if (!isServer) exitWith {};
private _payload = [_locationId] call TYR_fnc_StatePublicLocation;
if (count _payload isEqualTo 0) exitWith {};
[_payload] remoteExecCall ["TYR_fnc_ClientReceiveLocation",_target];
