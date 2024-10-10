_vehicleData = _this # 0;
_Pside = _this # 1;
/*
_vehicleData structure:
    [
        _vehicle,        // vehicle class
        _veh,            // vehicle object
        Pcolor,          // side of vehicle
        getAllHitPointsDamage _veh,  // damage of vehicle
        magazinesAmmoFull _veh,      // magazines and ammo count (all turrets)
        fuel _veh,        // fuel
        getDir _veh,      // direction
        getPosASL _veh    // location
    ]
*/

_vehicle = _vehicleData # 0;
_side = _vehicleData # 2;
_damage = _vehicleData # 3;
_magCount = _vehicleData # 4; // magazinesAllTurrets
_fuel = _vehicleData # 5;
_dir = _vehicleData # 6;
_pos = _vehicleData # 7;

// Create the vehicle at the saved position
_veh = createVehicle [_vehicle, _pos];
_veh setDir _dir;
_veh setFuel _fuel;

// Remove all turret magazines from the vehicle
{
    _veh removeMagazinesTurret [_x select 0, _x select 1];
} forEach magazinesAllTurrets _veh;

// Add saved turret magazines and ammo count to the vehicle
{
    _veh addMagazineTurret [_x select 0, _x select 1, _x select 2];
} forEach _magCount;

// Restore vehicle damage
{
    _veh setHitPointDamage [_damage # 0 # _forEachIndex, _damage # 2 # _forEachIndex];

} forEach _damage # 0;

// Update _vehicleData with the current vehicle state
_vehicleData = [
    _vehicle, 
    _veh, 
    _side, 
    _damage, 
    _magCount, 
    _fuel, 
    _dir, 
    _pos,
    "undefined"
];

_vehicleData;