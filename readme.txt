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



_zonePos = getPosATL initZone;

_cameraPos = [(_zonePos select 0) - 10, (_zonePos select 1) - 20, (_zonePos select 2) + 3];

_camera = "CAMERA" camCreate _cameraPos;

_camera cameraEffect ["Internal", "Back"];

_camera camSetTarget _zonePos;

_camera camCommit 0;

player disableAI "MOVE";
