if (!isServer) exitWith {};

private _ownerId = if (isNil "remoteExecutedOwner") then {0} else {remoteExecutedOwner};
private _allowed = _ownerId isEqualTo 0;
if (!_allowed) then {
    private _caller = [_ownerId] call TYR_fnc_FindPlayerByOwner;
    if (!isNull _caller) then {
        _allowed = _caller isEqualTo (missionNamespace getVariable ["commanderWest", objNull]) ||
                   {_caller isEqualTo (missionNamespace getVariable ["commanderEast", objNull])};
    };
};
if (!_allowed) exitWith {};

profileNamespace setVariable ["TYR_Save_v3", nil];
profileNamespace setVariable ["TYR_Save_v2", nil];
profileNamespace setVariable ["Tyrants", nil];
saveProfileNamespace;
["END1"] remoteExecCall ["TYR_fnc_ClientEndMission", [0, -2] select isDedicated];
