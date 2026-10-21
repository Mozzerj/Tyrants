if (!isServer) exitWith {};

private _caller = [remoteExecutedOwner] call TYR_fnc_FindPlayerByOwner;
if (isNull _caller) exitWith {};
private _profile = [_caller] call TYR_fnc_GetUnitProfile;
if (count _profile < 10) exitWith {};

missionNamespace setVariable [format ["TYR_arsenalBaseline_%1", remoteExecutedOwner], _profile];
