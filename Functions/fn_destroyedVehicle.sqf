params ["_vehicleClass", "_position", "_direction", "_destroyedVehicles"];

private _wreck = createVehicle [_vehicleClass, _position, [], 0, "CAN_COLLIDE"];
_wreck setDir _direction;
_wreck setDamage [1, false];
_destroyedVehicles pushBack _wreck;

_destroyedVehicles
