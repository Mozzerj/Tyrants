_vehicle = _this # 0; // Vehicle class
_cost = VehicleCost;

if ((gameData # 0 # (Pside + 1) # 3) > _cost) then {
    LocationChosen = false;
    playerClickPos = [0, 0, 0];

    openMap [true, false];

    while {!LocationChosen} do {
        onMapSingleClick "
            playerClickPos = _pos;
            if (player distance playerClickPos <= 50) then {
                LocationChosen = true;
            } else {
                hint 'Please select a location within 50 meters!';
            };
            onMapSingleClick '';
        ";
        waitUntil {LocationChosen};
    };

    waitUntil {LocationChosen};

    openMap [false, false];

    // Create the vehicle at the chosen position
    _veh = createVehicle [_vehicle, playerClickPos, [], 0, "NONE"];

    // Update gameData with the new structured vehicle data
    (gameData # 4 # Pside) pushBack [
        _vehicle,                             // Vehicle class
        _veh,                                 // Vehicle object
        Pcolor,                               // Side of vehicle
        getAllHitPointsDamage _veh,           // Damage of vehicle
        magazinesAllTurrets _veh,             // Magazines and ammo count (all turrets)
        fuel _veh,                            // Fuel
        getDir _veh,                          // Direction
        getPos _veh,                          // Location
        "undefined"                           // mark made 
    ];

    // Update the cost in gameData
    gameData # 0 # (Pside + 1) set [3, (gameData # 0 # (Pside + 1) # 3 - _cost)];
    publicVariable "gameData";

    _veh addEventHandler ["Killed", {
        params ["_veh"];

        gameData # 2 # 1 pushBack [typeOf _veh, getDir _veh, getPos _veh];
        
        {
            if (_x # 1 == _veh) then {

                deleteMarker (gameData # 4 # Pside # _forEachIndex # 8);
                gameData # 4 # Pside deleteAt _forEachIndex;
                
            };
        } forEach gameData # 4 # Pside;

        publicVariable "gameData";
    }];
} else {
    hint format ["Not Enough \n Needed: %1", _cost];
    sleep 2;
    hint "";
};
