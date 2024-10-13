[] call TYR_fnc_gameReset

things to test before main branch release:

does loading in and out make any errors

Base:
    Can i murder my own accountant
    Does a explosion kill my accountant (only direct hits can kill to defend against artillery barrage ending game)
    does ammobox spawn at correct base

Vehicles:
    Can i buy a vehicle at my own base
    Can i buy a vehicle at enemy base
    does destroying a vehicle remove marker from map


_player = player; 
_pos = getPosATL _player; 
_dir = getDir _player; 
_distance = 5; // Distance in meters in front of the player 
_height = 1;   // Height in meters above the ground 

// Calculate position in front of the player at the specified height 
_newPos = _pos getPos [_distance, _dir]; 
_newPos set [2, (_newPos select 2) + _height]; // Set the height 

_ammo = "ammo_Missile_s750" createVehicle _newPos; 

// Disable simulation for the ammo 
_ammo enableSimulation false; 
_ammo setVelocity [0, 0, 0]; // Ensure the object is not affected by physics 
_ammo allowDamage false; // Prevent damage 

// Wait for the object to initialize
waitUntil {alive _ammo};

// Get the bounding box using boundingBoxReal
_boundingBox = boundingBoxReal [_ammo, 0];

// Check if bounding box data is valid
if (count _boundingBox == 2) then {
    _min = _boundingBox select 0;
    _max = _boundingBox select 1;

    _width = _max select 0 - _min select 0;
    _length = _max select 1 - _min select 1;
    _height = _max select 2 - _min select 2;

    // Calculate the volume
    _volumeBoundingBox = _width * _length * _height;

    // Display the volume using boundingBoxReal
    hint format ["Volume using boundingBoxReal: %1 m³", _volumeBoundingBox];
} else {
    hint "Failed to retrieve the bounding box dimensions using boundingBoxReal.";
};

// Get bounding box dimensions using BIS_fnc_boundingBoxDimensions
_dimensions = _ammo call BIS_fnc_boundingBoxDimensions;

// Check if dimensions are valid
if (count _dimensions == 3) then {
    _width = _dimensions select 0;
    _length = _dimensions select 1;
    _height = _dimensions select 2;

    // Calculate the volume
    _volumeBIS = _width * _length * _height;

    // Display the volume using BIS_fnc_boundingBoxDimensions
    hint format ["Volume using BIS_fnc_boundingBoxDimensions: %1 m³", _volumeBIS];
} else {
    hint "Failed to retrieve dimensions using BIS_fnc_boundingBoxDimensions.";
};

ammo_Missile_s750
rhs_ammo_TOWB_AT