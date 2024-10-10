systemChat "Game Loop";
systemChat "FactoryUpdate";
systemChat "VehicleUpdate";

basicUpdate = {
    if (!isNil markerBLUFOR) then {markerBLUFOR setMarkerPos gameData # 0 # 1 # 0};
    if (!isNil markerOPFOR) then {markerOPFOR setMarkerPos gameData # 0 # 2 # 0};
    execVM "GameUpdate\FactoryUpdate.sqf";
};

vehicleUpdate = {
    execVM "GameUpdate\VehicleUpdate.sqf";
};

while {True} do {
    // Run the basic update every 60 seconds
    call basicUpdate;
    sleep 60;

    // Run the vehicle update every 15 seconds
    for "_i" from 0 to 3 do {
        call vehicleUpdate;
        sleep 15;
    };
};
