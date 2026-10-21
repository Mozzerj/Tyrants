if (!isServer) exitWith {};

{
    private _sideIndex = _forEachIndex;
    private _updated = [];
    {
        private _veh = _x # 1;
        if (!isNull _veh && {alive _veh}) then {
            _updated pushBack [
                _x # 0,
                _veh,
                _x # 2,
                getAllHitPointsDamage _veh,
                magazinesAllTurrets _veh,
                fuel _veh,
                getDir _veh,
                getPosATL _veh,
                "undefined"
            ];
        };
    } forEach _x;
    GameData # 4 set [_sideIndex, _updated];
} forEach (GameData # 4);
