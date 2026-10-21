params ["_className"];
private _result = [];
if (isNil "GameData" || {count (GameData # 3) < 2}) exitWith {_result};
{
    private _index = _x findIf {(_x # 1) isEqualTo _className};
    if (_index >= 0) exitWith {
        _result = +(_x # _index);
    };
} forEach (GameData # 3 # 1);
_result
