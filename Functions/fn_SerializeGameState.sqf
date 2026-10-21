if (!isServer) exitWith {[]};

private _setup = +((GameData # 0) # 0);
private _west = +((GameData # 0) # 1);
private _east = +((GameData # 0) # 2);
private _players = +((GameData # 0) # 3);

private _locationState = [];
{
    private _category = [];
    {
        private _stock = if ((count _x) > 6) then {_x # 6} else {0};
        _category pushBack [_x # 0, _x # 1, _x # 2, _x # 3, _stock];
    } forEach _x;
    _locationState pushBack _category;
} forEach (GameData # 1);

private _destroyed = [[], []];
{
    if (_x isEqualType [] && {count _x >= 2}) then {
        (_destroyed # 0) pushBack +_x;
    };
} forEach (GameData # 2 # 0);
{
    if (_x isEqualType [] && {count _x >= 3}) then {
        (_destroyed # 1) pushBack +_x;
    };
} forEach (GameData # 2 # 1);
private _catalogue = +(GameData # 3);

private _vehicleState = [[], []];
{
    private _teamIndex = _forEachIndex;
    {
        private _class = _x # 0;
        private _veh = _x # 1;
        private _colour = _x # 2;
        private _damage = _x # 3;
        private _magazines = _x # 4;
        private _fuel = _x # 5;
        private _dir = _x # 6;
        private _pos = _x # 7;

        if (!isNull _veh) then {
            _damage = getAllHitPointsDamage _veh;
            _magazines = magazinesAllTurrets _veh;
            _fuel = fuel _veh;
            _dir = getDir _veh;
            _pos = getPosATL _veh;
        };

        (_vehicleState # _teamIndex) pushBack [
            _class,
            _colour,
            _damage,
            _magazines,
            _fuel,
            _dir,
            _pos
        ];
    } forEach _x;
} forEach (GameData # 4);

[
    2,
    _setup,
    [_west, _east],
    _players,
    _locationState,
    _destroyed,
    _catalogue,
    _vehicleState
]
