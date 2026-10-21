params ["_factionId",["_domain","locations"],["_id",""]];
private _f = [_factionId] call TYR_fnc_StateGetFaction;
if (count _f isEqualTo 0) exitWith {createHashMap};
private _knowledge = _f getOrDefault ["knowledge",createHashMap];
private _domainMap = _knowledge getOrDefault [_domain,createHashMap];
if (_id isEqualTo "") exitWith {_domainMap};
_domainMap getOrDefault [_id,createHashMap]
