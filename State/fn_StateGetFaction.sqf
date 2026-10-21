params ["_factionId"];
if (isNil "TYR_State") exitWith {createHashMap};
(TYR_State getOrDefault ["factions", createHashMap]) getOrDefault [toLower _factionId, createHashMap]
