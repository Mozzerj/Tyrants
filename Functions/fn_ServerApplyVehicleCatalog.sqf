params ["_selectedDLCs", "_categories"];
if (!isServer) exitWith {};
if !(remoteExecutedOwner isEqualTo (missionNamespace getVariable ["TYR_setupOwnerId", -2])) exitWith {};
if ((GameData # 0 # 0 # 0) isNotEqualTo 1) exitWith {};
if !(_selectedDLCs isEqualType [] && {_categories isEqualType []}) exitWith {};

GameData set [3, [+_selectedDLCs, +_categories]];
GameData # 0 # 0 set [0, 3];

[] call TYR_fnc_ServerBroadcastState;
[] call TYR_fnc_ServerSaveState;
diag_log format ["[TYRANTS] Vehicle catalogue accepted (%1 categories).", count _categories];
