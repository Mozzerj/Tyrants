params ["_vehicleClass"];
if (_vehicleClass isEqualTo "") exitWith {};

private _basePos = GameData # 0 # (Pside + 1) # 0;
if (player distance2D _basePos > 30) exitWith {hint "You must be at your own base to buy a vehicle."};

TYR_vehicleSpawnChosen = false;
TYR_vehicleSpawnPos = [0, 0, 0];
openMap [true, false];

onMapSingleClick {
    if (player distance2D _pos <= 60 && {!surfaceIsWater [_pos # 0, _pos # 1]}) then {
        TYR_vehicleSpawnPos = _pos;
        TYR_vehicleSpawnChosen = true;
        onMapSingleClick "";
    } else {
        hint "Choose a land position within 60 metres.";
    };
};

waitUntil {
    sleep 0.1;
    TYR_vehicleSpawnChosen
};
openMap [false, false];

[_vehicleClass, TYR_vehicleSpawnPos] remoteExecCall ["TYR_fnc_ServerBuyVehicle", 2];
