params ["_veh", "_sideIndex"];
if (!isServer) exitWith {};
if (isNull _veh || {!(_sideIndex in [0, 1])}) exitWith {};

(GameData # 2 # 1) pushBackUnique [typeOf _veh, getDir _veh, getPosATL _veh];
private _vehicles = GameData # 4 # _sideIndex;
private _index = _vehicles findIf {(_x # 1) isEqualTo _veh};
if (_index >= 0) then {
    _vehicles deleteAt _index;
};
GameData # 4 set [_sideIndex, _vehicles];

[] call TYR_fnc_ServerBroadcastState;
[] call TYR_fnc_ServerSaveState;
