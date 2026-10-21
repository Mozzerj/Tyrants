params ["_categoryIndex", "_regionIndex"];
if (!isServer) exitWith {};
if !(_categoryIndex in [0, 1, 2]) exitWith {};

private _caller = [remoteExecutedOwner] call TYR_fnc_FindPlayerByOwner;
if (isNull _caller) exitWith {};
private _side = side _caller;
if !(_side in [west, east]) exitWith {};

private _category = (GameData # 1) param [_categoryIndex, []];
if (_regionIndex < 0 || {_regionIndex >= count _category}) exitWith {};
private _region = _category # _regionIndex;
private _settings = GameData # 0 # 0 param [1, []];
private _captureRange = _settings param [1, 175];
private _regionPos = _region # 4;
if (_caller distance2D _regionPos > _captureRange) exitWith {};

private _entities = _regionPos nearEntities [["Man", "Car", "Tank"], _captureRange];
private _westCount = 0;
private _eastCount = 0;
{
    private _entitySide = if (_x isKindOf "Man") then {
        side _x
    } else {
        private _commander = effectiveCommander _x;
        if (isNull _commander) then {sideUnknown} else {side _commander};
    };

    if (_entitySide isEqualTo west) then {_westCount = _westCount + 1};
    if (_entitySide isEqualTo east) then {_eastCount = _eastCount + 1};
} forEach _entities;

private _changed = false;
if (_side isEqualTo west && {_westCount > _eastCount}) then {
    if ((_region # 3) isEqualTo "ColorEAST") then {_region set [2, "ColorWEST"]};
    _region set [1, "ColorWEST"];
    _region set [3, "ColorWEST"];
    _changed = true;
};
if (_side isEqualTo east && {_eastCount > _westCount}) then {
    if ((_region # 3) isEqualTo "ColorWEST") then {_region set [1, "ColorEAST"]};
    _region set [2, "ColorEAST"];
    _region set [3, "ColorEAST"];
    _changed = true;
};

if (_changed) then {
    (GameData # 1 # _categoryIndex) set [_regionIndex, _region];
    [] call TYR_fnc_ServerBroadcastState;
    [] call TYR_fnc_ServerSaveState;
};
