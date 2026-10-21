params ["_serverTime",["_records",[]]];
if !(missionNamespace getVariable ["TYR_debugMode",false]) exitWith {};
missionNamespace setVariable ["TYR_DebugServerTime",_serverTime];
missionNamespace setVariable ["TYR_DebugAITraces",_records];
if (!isNull findDisplay 1700 && {(missionNamespace getVariable ["TYR_debugView",""]) isEqualTo "flow"}) then {
    [] call TYR_fnc_DebugFlowRefresh;
};
