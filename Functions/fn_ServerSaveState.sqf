if (!isServer) exitWith {};
if (isNil "GameData") exitWith {};

private _saveData = [] call TYR_fnc_SerializeGameState;
profileNamespace setVariable ["TYR_Save_v2", _saveData];
saveProfileNamespace;

missionNamespace setVariable ["TYR_lastSaveAt", serverTime];
diag_log format ["[TYRANTS] Saved campaign state at serverTime %1", serverTime];
