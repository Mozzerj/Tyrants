diag_log "[TYRANTS] Server initialisation started.";

TYR_testInProgress = false;
publicVariable "TYR_testInProgress";

TYR_soloTestMode = (["TYR_SoloTestMode", 0] call BIS_fnc_getParamValue) isEqualTo 1;
publicVariable "TYR_soloTestMode";
if (TYR_soloTestMode) then {
    diag_log "[TYRANTS] Solo Test Mode enabled.";
};

TYR_debugMode = (["TYR_DebugMode", 0] call BIS_fnc_getParamValue) isEqualTo 1;
publicVariable "TYR_debugMode";
if (TYR_debugMode) then {
    diag_log "[TYRANTS] Developer Debug Mode enabled.";
};

addMissionEventHandler ["PlayerConnected", {
    params ["_id", "_uid", "_name", "_jip", "_owner", "_idStr"];
    if (_owner > 2 && {!isNil "GameData"}) then {
        _owner publicVariableClient "GameData";
    };
    if (_owner > 2) then {
        _owner publicVariableClient "TYR_soloTestMode";
        _owner publicVariableClient "TYR_debugMode";
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

waitUntil {
    sleep 1;
    if (TYR_soloTestMode) then {
        [] call TYR_fnc_ServerEnsureSoloOpponent;
    };
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
[] call TYR_fnc_ServerRestoreEmplacements;

[] execVM "GameUpdate\GameLoop.sqf";
diag_log "[TYRANTS] Server initialisation complete.";