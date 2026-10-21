params ["_factoryId"];
if (!isServer) exitWith {};

private _caller = [remoteExecutedOwner] call TYR_fnc_FindPlayerByOwner;
if (isNull _caller) exitWith {};
private _side = side _caller;
private _sideIndex = [west, east] find _side;
if (_sideIndex < 0) exitWith {};

private _factories = GameData # 1 # 2;
private _index = _factories findIf {(_x # 0) isEqualTo _factoryId};
if (_index < 0) exitWith {};
private _factory = _factories # _index;
private _colour = ["ColorWEST", "ColorEAST"] # _sideIndex;
if ((_factory # 3) isNotEqualTo _colour) exitWith {};
if ((_caller distance2D (_factory # 4)) > 75) exitWith {};

private _resourceIndex = switch (_factory # 7) do {
    case "Steel": {1};
    case "Ammo": {2};
    case "Fuel": {3};
    default {-1};
};
if (_resourceIndex < 0) exitWith {};

private _stock = _factory # 6;
if (_stock <= 0) exitWith {};
GameData # 0 # (_sideIndex + 1) set [_resourceIndex, (GameData # 0 # (_sideIndex + 1) # _resourceIndex) + _stock];
_factory set [6, 0];
(GameData # 1 # 2) set [_index, _factory];

[] call TYR_fnc_ServerBroadcastState;
[] call TYR_fnc_ServerSaveState;
