params ["_locationId"];
if (isNil "TYR_State") exitWith {createHashMap};
(TYR_State getOrDefault ["locations", createHashMap]) getOrDefault [_locationId, createHashMap]
