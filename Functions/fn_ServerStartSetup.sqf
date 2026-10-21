if (!isServer) exitWith {};

while {(GameData # 0 # 0 # 0) < 3} do {
    waitUntil {
        sleep 1;
        (count allPlayers) > 0
    };

    private _setupPlayer = objNull;
    if (!isNil "commanderWest" && {isPlayer commanderWest}) then {_setupPlayer = commanderWest};
    if (isNull _setupPlayer && {!isNil "commanderEast"} && {isPlayer commanderEast}) then {_setupPlayer = commanderEast};
    if (isNull _setupPlayer) then {_setupPlayer = allPlayers # 0};

    private _stage = GameData # 0 # 0 # 0;
    TYR_setupOwnerId = owner _setupPlayer;
    [_stage] remoteExecCall ["TYR_fnc_StartSetupClient", TYR_setupOwnerId];
    diag_log format ["[TYRANTS] Setup stage %1 assigned to %2 (%3)", _stage, name _setupPlayer, TYR_setupOwnerId];

    waitUntil {
        sleep 1;
        (GameData # 0 # 0 # 0) isNotEqualTo _stage ||
        {isNull ([TYR_setupOwnerId] call TYR_fnc_FindPlayerByOwner)}
    };
};

TYR_setupOwnerId = -1;
