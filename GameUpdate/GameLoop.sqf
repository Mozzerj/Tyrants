basicUpdate = {
    if (!isNil markerBLUFOR) then {markerBLUFOR setMarkerPos gameData # 0 # 1 # 0};
    if (!isNil markerOPFOR) then {markerOPFOR setMarkerPos gameData # 0 # 2 # 0};
    execVM "GameUpdate\FactoryUpdate.sqf";
};
basicIncome = {

    gameData # 0 # 1 set [1,(gameData # 0 # 1 # 1 + 500)];
    gameData # 0 # 1 set [2,(gameData # 0 # 1 # 2 + 500)];
    gameData # 0 # 1 set [3,(gameData # 0 # 1 # 3 + 500)];

    gameData # 0 # 2 set [1,(gameData # 0 # 2 # 1 + 500)];
    gameData # 0 # 2 set [2,(gameData # 0 # 2 # 2 + 500)];
    gameData # 0 # 2 set [3,(gameData # 0 # 2 # 3 + 500)];

};

vehicleUpdate = {
    execVM "GameUpdate\VehicleUpdate.sqf";
};

while {True} do {
    // Run the basic update every 60 seconds
    call basicUpdate;
    call basicIncome;

    // Run the vehicle update every 15 seconds
    for "_i" from 0 to 4 do {
        call vehicleUpdate;
        sleep 15;
    };
};
