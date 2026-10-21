params ["_factionId"];
private _f = [_factionId] call TYR_fnc_StateGetFaction;
if (count _f isEqualTo 0) exitWith {createHashMap};
_f getOrDefault ["commandNetwork",createHashMap]
