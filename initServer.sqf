diag_log "[TYRANTS] Server initialisation started.";

addMissionEventHandler ["PlayerConnected", {
    params ["_id", "_uid", "_name", "_jip", "_owner", "_idStr"];
    if (_owner > 2 && {!isNil "GameData"}) then {
        _owner publicVariableClient "GameData";
    };
}];

[] call TYR_fnc_ServerLoadState;
[] call TYR_fnc_ServerBuildLocations;

addMissionEventHandler ["BuildingChanged", {
    params ["_from", "_to", "_isRuin"];
    if (_isRuin && {!isNull _from}) then {
        private _record = [typeOf _from, getPosWorld _from, getDir _from];
        (GameData # 2 # 0) pushBackUnique _record;
        [] call TYR_fnc_ServerSaveState;
    };
}];

if ((GameData # 0 # 0 # 0) < 3) then {
    [] spawn TYR_fnc_ServerStartSetup;
};

waitUntil {
    sleep 1;
    (GameData # 0 # 0 # 0) >= 3
};

// Stage 3 is base placement. Commanders submit their positions to the server.
waitUntil {
    sleep 1;
    (GameData # 0 # 1 # 0) isNotEqualTo 0 &&
    {(GameData # 0 # 2 # 0) isNotEqualTo 0}
};

GameData # 0 # 0 set [0, 4];
[] call TYR_fnc_ServerBroadcastState;
[] call TYR_fnc_ServerSaveState;

[0] call TYR_fnc_ServerInitBase;
[1] call TYR_fnc_ServerInitBase;

[] call TYR_fnc_ServerRestoreDestroyedObjects;
[] call TYR_fnc_ServerRestoreVehicles;

[] execVM "GameUpdate\GameLoop.sqf";
diag_log "[TYRANTS] Server initialisation complete.";
