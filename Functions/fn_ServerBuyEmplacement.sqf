params ["_emplacementKey", "_position"];
if (!isServer) exitWith {};
if !(_emplacementKey isEqualType "") exitWith {};
if !(_position isEqualType [] && {count _position >= 2}) exitWith {};

private _ownerId = remoteExecutedOwner;
private _caller = [_ownerId] call TYR_fnc_FindPlayerByOwner;
if (isNull _caller) exitWith {};
private _sideIndex = [west, east] find (side _caller);
if (_sideIndex < 0) exitWith {};

private _matches = ([] call TYR_fnc_GetEmplacementDefinitions) select {(_x # 0) isEqualTo _emplacementKey};
if (_matches isEqualTo []) exitWith {};
private _definition = _matches # 0;
if !(_definition # 5) exitWith {
    ["That emplacement was only a prototype in the 18/10/2024 build and is not implemented yet."] remoteExecCall ["TYR_fnc_ClientHint", _ownerId];
};
if !([_sideIndex, _definition # 2] call TYR_fnc_IsResearchUnlocked) exitWith {
    ["Required research has not been unlocked."] remoteExecCall ["TYR_fnc_ClientHint", _ownerId];
};

private _colour = ["ColorWEST", "ColorEAST"] # _sideIndex;
private _inTerritory = false;
{
    {
        if ((_x # 3) isEqualTo _colour && {(_x # 4) distance2D _position < 500}) exitWith {_inTerritory = true};
    } forEach _x;
    if (_inTerritory) exitWith {};
} forEach (GameData # 1);
if (!_inTerritory) exitWith {
    ["Choose a location within 500 metres of friendly captured territory."] remoteExecCall ["TYR_fnc_ClientHint", _ownerId];
};
if (count (_position nearObjects 10) > 0) exitWith {
    ["The selected emplacement position is obstructed."] remoteExecCall ["TYR_fnc_ClientHint", _ownerId];
};

private _teamIndex = _sideIndex + 1;
private _steel = GameData # 0 # _teamIndex # 1;
private _cost = _definition # 3;
if (_steel < _cost) exitWith {
    [format ["Not enough steel. Needed: %1", _cost]] remoteExecCall ["TYR_fnc_ClientHint", _ownerId];
};

private _class = _definition # 4;
if !(isClass (configFile >> "CfgVehicles" >> _class)) exitWith {
    [format ["Required emplacement class is unavailable: %1", _class]] remoteExecCall ["TYR_fnc_ClientHint", _ownerId];
};

private _asset = createVehicle [_class, _position, [], 0, "NONE"];
_asset setVariable ["TYR_sideIndex", _sideIndex, true];
_asset setVariable ["TYR_emplacementKey", _emplacementKey, true];
_asset addEventHandler ["Killed", {
    params ["_asset"];
    [_asset, _asset getVariable ["TYR_sideIndex", -1]] call TYR_fnc_ServerEmplacementKilled;
}];

private _record = [
    _emplacementKey,
    _class,
    _asset,
    _colour,
    getAllHitPointsDamage _asset,
    18,
    fuel _asset,
    getDir _asset,
    getPosATL _asset
];
(GameData # 5 # _sideIndex) pushBack _record;
GameData # 0 # _teamIndex set [1, _steel - _cost];

[_asset, _emplacementKey, _sideIndex] remoteExec ["TYR_fnc_ClientAttachEmplacementActions", 0, _asset];
[] call TYR_fnc_ServerBroadcastState;
[] call TYR_fnc_ServerSaveState;
[format ["%1 purchased for %2 steel.", _definition # 1, _cost]] remoteExecCall ["TYR_fnc_ClientHint", _ownerId];
