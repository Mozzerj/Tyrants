params ["_factionId"];
if (!(missionNamespace getVariable ["TYR_debugMode",false])) exitWith {
    hint "Developer Debug Mode is disabled.";
};
if !(_factionId in ["west","east","independent"]) exitWith {};

// Enemy HQ positions are intentionally hidden from normal client state.
// Ask the authoritative server to perform developer teleportation instead.
["teleport",[_factionId]] remoteExecCall ["TYR_fnc_ServerDebugAction",2];
