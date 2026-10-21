params ["_vehicleData", ["_sideIndex", 0]];

private _vehicleClass = _vehicleData # 0;
private _colour = _vehicleData # 2;
private _damage = _vehicleData # 3;
private _magCount = _vehicleData # 4;
private _fuel = _vehicleData # 5;
private _dir = _vehicleData # 6;
private _pos = _vehicleData # 7;

private _veh = createVehicle [_vehicleClass, _pos, [], 0, "NONE"];
_veh setDir _dir;
_veh setFuel _fuel;

{
    _veh removeMagazinesTurret [_x # 0, _x # 1];
} forEach magazinesAllTurrets _veh;
{
    _veh addMagazineTurret [_x # 0, _x # 1, _x # 2];
} forEach _magCount;

if (_damage isEqualType [] && {count _damage >= 3}) then {
    private _names = _damage # 0;
    private _values = _damage # 2;
    {
        if (_forEachIndex < count _values) then {
            _veh setHitPointDamage [_x, _values # _forEachIndex];
        };
    } forEach _names;
};

[
    _vehicleClass,
    _veh,
    _colour,
    getAllHitPointsDamage _veh,
    magazinesAllTurrets _veh,
    fuel _veh,
    getDir _veh,
    getPosATL _veh,
    "undefined"
]
