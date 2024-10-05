baseLocUpdate = {

    if (!isNil markerBLUFOR) then {markerBLUFOR setMarkerPos gameData # 0 # 1 # 0};
    if (!isNil markerOPFOR) then {markerBLUFOR setMarkerPos gameData # 0 # 2 # 0};

};

while {True} do {

    sleep 60;
    call baseLocUpdate;
    execVM "GameUpdate\FactoryUpdate.sqf";
    sleep 60;
    call baseLocUpdate;
    execVM "GameUpdate\FactoryUpdate.sqf";
    sleep 60;
    call baseLocUpdate;
    execVM "GameUpdate\FactoryUpdate.sqf";
    sleep 60;
    call baseLocUpdate;
    execVM "GameUpdate\FactoryUpdate.sqf";
    sleep 60;
    call baseLocUpdate;
    execVM "GameUpdate\FactoryUpdate.sqf";
    sleep 60;
    call baseLocUpdate;
    execVM "GameUpdate\FactoryUpdate.sqf";
    sleep 60;
    call baseLocUpdate;
    execVM "GameUpdate\FactoryUpdate.sqf";
    sleep 60;
    call baseLocUpdate;
    execVM "GameUpdate\FactoryUpdate.sqf";
    sleep 60;
    call baseLocUpdate;
    execVM "GameUpdate\FactoryUpdate.sqf";
    sleep 60;
    call baseLocUpdate;
    execVM "GameUpdate\FactoryUpdate.sqf";
    
    
};