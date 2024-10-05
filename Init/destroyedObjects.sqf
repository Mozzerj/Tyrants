{
    _x setDamage [1, false];
    
} forEach gameData # 2 # 0;

{
    _x setDamage [1, false];
    
    _position = _x # 1;

    _direction = _x # 2;
    
    _vehicleClass = _x # 0;

    _simpleVehicle = createVehicle [_vehicleClass, _position, [], 0, "NONE"]; 
    
    _simpleVehicle setDamage [1,false];
    
    _simpleVehicle setDir _direction;

    _simpleVehicle enableSimulationGlobal false;

} forEach gameData # 2 # 1;