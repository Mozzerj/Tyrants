while {true} do {
    
    sleep 15;
    _loadout = ([] call TYR_fnc_getPlayerLoadout);
    (gameData # 0 # 3) set [PFPID,_loadout];

    publicVariable "gameData";
};