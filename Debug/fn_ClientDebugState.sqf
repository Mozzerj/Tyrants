params [["_generation",-1],["_serverFps",-1]];
missionNamespace setVariable ["TYR_debugSaveGeneration",_generation];
missionNamespace setVariable ["TYR_debugServerFps",_serverFps];
if (!isNull findDisplay 1700) then {[] call TYR_fnc_DebugMenuUpdateStatus};
