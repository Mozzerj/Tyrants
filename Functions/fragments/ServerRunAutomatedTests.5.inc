// ----- Remote debug endpoint guard checks -----
// Temporarily toggle the server-side debug flag without broadcasting it. This proves
// the network endpoint itself refuses mutations while disabled and works while enabled.
private _debugModeBeforeEndpointTest = missionNamespace getVariable ["TYR_debugMode", false];
GameData # 0 # _debugTeamIndex set [1, 100];
missionNamespace setVariable ["TYR_debugMode", false];
["resource", [_debugSide, 1, 50]] call TYR_fnc_ServerDebugAction;
[(GameData # 0 # _debugTeamIndex # 1) isEqualTo 100, "Debug endpoint is inert while Debug Mode is disabled", "Steel stayed unchanged at 100", format ["Steel changed to %1", GameData # 0 # _debugTeamIndex # 1]] call _check;

missionNamespace setVariable ["TYR_debugMode", true];
["resource", [_debugSide, 1, 50]] call TYR_fnc_ServerDebugAction;
[(GameData # 0 # _debugTeamIndex # 1) isEqualTo 150, "Debug endpoint mutates through validated server path when enabled", "Steel increased from 100 to 150", format ["Steel: %1", GameData # 0 # _debugTeamIndex # 1]] call _check;
missionNamespace setVariable ["TYR_debugMode", _debugModeBeforeEndpointTest];
