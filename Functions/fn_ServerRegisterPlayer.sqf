if (!isServer) exitWith {};

private _caller = [remoteExecutedOwner] call TYR_fnc_FindPlayerByOwner;
if (isNull _caller) exitWith {};
private _profile = [_caller] call TYR_fnc_GetUnitProfile;
if (count _profile < 10) exitWith {};

private _uid = _profile # 0;
if (_uid isEqualTo "") exitWith {};
private _players = GameData # 0 # 3;
private _index = _players findIf {(_x # 0) isEqualTo _uid};
if (_index < 0) then {
    _players pushBack _profile;
    [] call TYR_fnc_ServerBroadcastState;
    [] call TYR_fnc_ServerSaveState;
};
