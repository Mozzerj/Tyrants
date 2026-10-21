params ["_factoryId"];
if (!isServer) exitWith {false};
private _partsMap = TYR_Runtime getOrDefault ["factoryParts",createHashMap];
private _parts = _partsMap getOrDefault [_factoryId,[]];
if (count _parts isEqualTo 0) exitWith {true};
private _working = 0;
{
    if (!isNull _x && {damage _x < 0.85}) then {_working = _working + 1};
} forEach _parts;
_working > 0
