params ["_serverTime",["_records",[]]];
if !(missionNamespace getVariable ["TYR_debugMode",false]) exitWith {};
missionNamespace setVariable ["TYR_DebugServerTime",_serverTime];
missionNamespace setVariable ["TYR_DebugAITraces",_records];
[] call TYR_fnc_DebugMenuRefresh;
