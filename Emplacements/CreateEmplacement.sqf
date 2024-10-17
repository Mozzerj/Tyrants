params["_Selected"];

if (_selected == -1) exitWith {
    hint "None Selected";
    sleep 1:
    hint "";
};

Emplacementvalid = false;
playerClickPos = [0, 0, 0];

IsInTerritory = {

    params["_pos"];
    Emplacementvalid = false;

    {

        _types = _x;
        {

            if ((_x # 3 == Pcolor) && ((_x # 4 distance _pos) < 500) && (Emplacementvalid == false) && (count (_pos nearObjects 10) == 0)) then {
                
                Emplacementvalid = true;
            };


            
        } forEach _types;

    } forEach gameData # 1;

    Emplacementvalid;

};


LocationChosen = false;

onMapSingleClick "
    EmplacementPos = _pos;

    if ([EmplacementPos] call IsInTerritory) then {
        LocationChosen = true;
    } else {
        hint 'Please select a suitable location within 500m of captured location!';
        if (true)exitWith {};
    };

    onMapSingleClick '';
";

waitUntil {LocationChosen};


switch (_selected) do {
    case 0: {
        
        // CBR





    };
    case 1: { 

        // RoadBlock
    };
    case 2: {
        _Asset = "B_Ship_MRLS_01_F" createVehicle EmplacementPos;

        _Asset addAction [
            "Open Targeting System", // Display name for the action
            {
                // Code to execute when action is triggered
                [_this]execVM "Emplacements\VLS\VLSMenu.sqf";
            },
            [],
            6
        ];

        (gameData # 5 # Pside) pushBack [
            "B_Ship_MRLS_01_F",                             // Vehicle class
            _Asset,                                 // Vehicle object
            Pcolor,                               // Side of vehicle
            getAllHitPointsDamage _Asset,           // Damage of vehicle
            magazinesAllTurrets _Asset,             // Magazines and ammo count (all turrets)
            fuel _Asset,                            // Fuel
            getDir _Asset,                          // Direction
            getPos _Asset,                          // Location
            "undefined"                           // mark made 
        ];

    };

    default { };
};