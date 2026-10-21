params ["_knowledge"];
if !(_knowledge isEqualType [] && {count _knowledge >= 4}) exitWith {};
if (isNil "TYR_ClientState") then {
    TYR_ClientState = createHashMapFromArray [["campaign",[]],["factions",createHashMap],["locations",createHashMap],["knowledge",[]]];
};
TYR_ClientState set ["knowledge",+_knowledge];
missionNamespace setVariable ["TYR_ClientKnowledgeReceivedAt",diag_tickTime];
if (!isNull findDisplay 1700) then {[] call TYR_fnc_DebugMenuUpdateStatus; if ((missionNamespace getVariable ["TYR_debugView",""]) isEqualTo "log") then {[] call TYR_fnc_DebugIntelLogRefresh}};
