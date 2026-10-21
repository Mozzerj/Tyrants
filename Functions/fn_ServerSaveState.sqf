if (!isServer) exitWith {};
if (isNil "GameData") exitWith {};
if (missionNamespace getVariable ["TYR_testInProgress", false]) exitWith {
    missionNamespace setVariable ["TYR_testSaveCount", (missionNamespace getVariable ["TYR_testSaveCount", 0]) + 1];
};
private _saveData = [] call TYR_fnc_SerializeGameState;
profileNamespace setVariable ["TYR_Save_v3", _saveData];
saveProfileNamespace;
missionNamespace setVariable ["TYR_lastSaveAt", serverTime];
diag_log format ["[TYRANTS] Saved v3 campaign state at serverTime %1", serverTime];
