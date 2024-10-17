{
    _x setDamage [1, false];
    
} forEach gameData # 2 # 0;

destroyedVehicles = [];

{

    _position = _x # 2;

    _direction = _x # 1;
    
    _vehicleClass = _x # 0;

    destroyedVehicles = [_vehicleClass, _position, _direction, destroyedVehicles] call TYR_fnc_destroyedVehicle;

} forEach gameData # 2 # 1;

sleep 5;

{

    _x enableSimulationGlobal false;

} forEach destroyedVehicles;