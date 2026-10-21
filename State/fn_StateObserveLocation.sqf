params ["_factionId","_locationId",["_source","visual"]];
if (!isServer) exitWith {false};
private _f = [_factionId] call TYR_fnc_StateGetFaction;
private _l = [_locationId] call TYR_fnc_StateGetLocation;
if (count _f isEqualTo 0 || {count _l isEqualTo 0}) exitWith {false};

private _knowledge = _f getOrDefault ["knowledge",createHashMapFromArray [["locations",createHashMap],["contacts",createHashMap],["log",[]]]];
if !("locations" in keys _knowledge) then {_knowledge set ["locations",createHashMap]};
if !("contacts" in keys _knowledge) then {_knowledge set ["contacts",createHashMap]};
if !("log" in keys _knowledge) then {_knowledge set ["log",[]]};
_f set ["knowledge",_knowledge];
private _knownLocations = _knowledge get "locations";
private _old = _knownLocations getOrDefault [_locationId,createHashMap];
private _owner = _l getOrDefault ["owner","neutral"];
private _changed = (count _old isEqualTo 0) || {(_old getOrDefault ["owner","unknown"]) isNotEqualTo _owner};

_knownLocations set [_locationId,createHashMapFromArray [
    ["owner",_owner],
    ["observedAt",+systemTimeUTC],
    ["seenServerTime",serverTime],
    ["source",_source]
]];

if (_changed) then {["intelligence-location"] call TYR_fnc_StateMarkDirty};
[_locationId,_factionId] call TYR_fnc_ServerPublishLocation;
true
