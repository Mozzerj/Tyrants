params [["_position",[]],["_factionId",""]];
if !(missionNamespace getVariable ["TYR_debugMode",false]) exitWith {};
if !(_position isEqualType [] && {count _position >= 2}) exitWith {
    hint "Debug teleport failed: target HQ has no valid position.";
};

closeDialog 0;
player setPosATL _position;
hint format ["Debug teleport: %1 HQ",toUpper _factionId];
