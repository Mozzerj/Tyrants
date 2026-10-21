if (!isServer) exitWith {};

while {true} do {
    for "_i" from 0 to 4 do {
        sleep 15;
        [] call TYR_fnc_VehicleUpdate;
    };

    [] call TYR_fnc_FactoryUpdate;

    for "_teamIndex" from 1 to 2 do {
        GameData # 0 # _teamIndex set [1, (GameData # 0 # _teamIndex # 1) + 250];
        GameData # 0 # _teamIndex set [2, (GameData # 0 # _teamIndex # 2) + 250];
        GameData # 0 # _teamIndex set [3, (GameData # 0 # _teamIndex # 3) + 250];
        GameData # 0 # _teamIndex set [4, (GameData # 0 # _teamIndex # 4) + 1];
    };

    [] call TYR_fnc_ServerBroadcastState;
    [] call TYR_fnc_ServerSaveState;
};
