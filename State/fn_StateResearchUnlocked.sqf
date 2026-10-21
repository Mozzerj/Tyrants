params ["_factionId", "_key"];
private _faction = [_factionId] call TYR_fnc_StateGetFaction;
if (count _faction isEqualTo 0) exitWith {false};
private _research = _faction getOrDefault ["research", createHashMap];
_research getOrDefault [_key, false]
