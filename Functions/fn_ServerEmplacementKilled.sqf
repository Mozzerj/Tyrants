params ["_asset", "_sideIndex"];
if (!isServer || {!(_sideIndex in [0, 1])}) exitWith {};
private _records = GameData # 5 # _sideIndex;
private _index = _records findIf {(_x # 2) isEqualTo _asset};
if (_index >= 0) then {
    _records deleteAt _index;
    GameData # 5 set [_sideIndex, _records];
    [] call TYR_fnc_ServerBroadcastState;
    [] call TYR_fnc_ServerSaveState;
};
