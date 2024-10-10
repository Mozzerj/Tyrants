params["_vehicleClass","_position","_direction","_destroyedVehicles"];

_simpleVehicle = createVehicle [_vehicleClass, _position, [], 0, "CAN_COLLIDE"]; 
    
_simpleVehicle setDamage [1,false];
    
_simpleVehicle setDir _direction;

_destroyedVehicles pushBack _simpleVehicle;

_destroyedVehicles;