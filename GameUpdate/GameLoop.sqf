basicUpdate = {
    if (!isNil markerBLUFOR) then {markerBLUFOR setMarkerPos gameData # 0 # 1 # 0};
    if (!isNil markerOPFOR) then {markerOPFOR setMarkerPos gameData # 0 # 2 # 0};
    [] call TYR_fnc_FactoryUpdate;
};

basicIncome = {

    gameData # 0 # 1 set [1,(gameData # 0 # 1 # 1 + 250)];
    gameData # 0 # 1 set [2,(gameData # 0 # 1 # 2 + 250)];
    gameData # 0 # 1 set [3,(gameData # 0 # 1 # 3 + 250)];
    gameData # 0 # 1 set [4,(gameData # 0 # 1 # 4 + 1)];

    gameData # 0 # 2 set [1,(gameData # 0 # 2 # 1 + 250)];
    gameData # 0 # 2 set [2,(gameData # 0 # 2 # 2 + 250)];
    gameData # 0 # 2 set [3,(gameData # 0 # 2 # 3 + 250)];
    gameData # 0 # 2 set [4,(gameData # 0 # 2 # 4 + 1)];

};



while {True} do {

    for "_i" from 0 to 4 do {
        sleep 15;
        [] call TYR_fnc_vehicleUpdate;
    };

    call basicUpdate;
    call basicIncome;
};
