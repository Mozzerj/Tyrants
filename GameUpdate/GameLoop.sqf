_markerBLUFOR = createMarker ["respawn_west", gameData # 0 # 1 # 0];
_markerOPFOR = createMarker ["respawn_east", gameData # 0 # 2 # 0];

baseLocUpdate = {

    _markerBLUFOR setMarkerPos gameData # 0 # 1 # 0;
    _markerOPFOR setMarkerPos gameData # 0 # 2 # 0;
};

while {True} do {

    sleep 60;
    call baseLocUpdate
    execVM "GameUpdate\FactoryUpdate.sqf";
    sleep 60;
    call baseLocUpdate
    execVM "GameUpdate\FactoryUpdate.sqf";
    sleep 60;
    call baseLocUpdate
    execVM "GameUpdate\FactoryUpdate.sqf";
    sleep 60;
    call baseLocUpdate
    execVM "GameUpdate\FactoryUpdate.sqf";
    sleep 60;
    call baseLocUpdate
    execVM "GameUpdate\FactoryUpdate.sqf";
    sleep 60;
    call baseLocUpdate
    execVM "GameUpdate\FactoryUpdate.sqf";
    sleep 60;
    call baseLocUpdate
    execVM "GameUpdate\FactoryUpdate.sqf";
    sleep 60;
    call baseLocUpdate
    execVM "GameUpdate\FactoryUpdate.sqf";
    sleep 60;
    call baseLocUpdate
    execVM "GameUpdate\FactoryUpdate.sqf";
    sleep 60;
    call baseLocUpdate
    execVM "GameUpdate\FactoryUpdate.sqf";
    
    
};