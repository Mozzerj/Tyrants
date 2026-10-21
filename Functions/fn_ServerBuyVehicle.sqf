params ["_className", "_position"];
if (!isServer) exitWith {};

private _caller = [remoteExecutedOwner] call TYR_fnc_FindPlayerByOwner;
if (isNull _caller) exitWith {};
private _sideIndex = [west, east] find (side _caller);
if (_sideIndex < 0) exitWith {};
if !(_position isEqualType [] && {count _position >= 2}) exitWith {};

private _basePos = GameData # 0 # (_sideIndex + 1) # 0;
if (_basePos isEqualTo 0 || {_caller distance2D _basePos > 30}) exitWith {
    ["You must be at your own base to buy a vehicle."] remoteExecCall ["TYR_fnc_ClientHint", remoteExecutedOwner];
};
if (_caller distance2D _position > 60) exitWith {
    ["Choose a spawn point within 60 metres."] remoteExecCall ["TYR_fnc_ClientHint", remoteExecutedOwner];
};

private _catalogEntry = [_className] call TYR_fnc_FindVehicleCatalogEntry;
if (count _catalogEntry < 9) exitWith {
    ["That vehicle is not available in this campaign."] remoteExecCall ["TYR_fnc_ClientHint", remoteExecutedOwner];
};

private _vehicleMultiplier = (GameData # 0 # 0 # 1) param [7, 1];
private _cost = round ((_catalogEntry # 8) * _vehicleMultiplier);
private _fuelIndex = 3;
private _fuelResource = GameData # 0 # (_sideIndex + 1) # _fuelIndex;
if (_fuelResource < _cost) exitWith {
    [format ["Not enough fuel. Needed: %1", _cost]] remoteExecCall ["TYR_fnc_ClientHint", remoteExecutedOwner];
};

private _veh = createVehicle [_className, _position, [], 0, "NONE"];
private _colour = ["ColorWEST", "ColorEAST"] # _sideIndex;
private _record = [
    _className,
    _veh,
    _colour,
    getAllHitPointsDamage _veh,
    magazinesAllTurrets _veh,
    fuel _veh,
    getDir _veh,
    getPosATL _veh,
    "undefined"
];
(GameData # 4 # _sideIndex) pushBack _record;
GameData # 0 # (_sideIndex + 1) set [_fuelIndex, _fuelResource - _cost];

_veh setVariable ["TYR_sideIndex", _sideIndex, true];
_veh addEventHandler ["Killed", {
    params ["_veh"];
    [_veh, _veh getVariable ["TYR_sideIndex", -1]] call TYR_fnc_ServerVehicleKilled;
}];

[] call TYR_fnc_ServerBroadcastState;
[] call TYR_fnc_ServerSaveState;
[format ["Vehicle purchased for %1 fuel.", _cost]] remoteExecCall ["TYR_fnc_ClientHint", remoteExecutedOwner];
