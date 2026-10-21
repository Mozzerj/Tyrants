if (isServer) then {
    [] call TYR_fnc_ServerResetGame;
} else {
    [] remoteExecCall ["TYR_fnc_ServerResetGame", 2];
};
