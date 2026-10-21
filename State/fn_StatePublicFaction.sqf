params ["_factionId",["_viewerFaction",""]];
private _f = [_factionId] call TYR_fnc_StateGetFaction;
if (count _f isEqualTo 0) exitWith {[]};
private _own = _viewerFaction isEqualTo _factionId;
private _r = _f get "resources";
private _research = _f getOrDefault ["research", createHashMap];
private _keys = keys _research;
_keys sort true;
private _unlocked = if (_own) then {_keys select {_research getOrDefault [_x, false]}} else {[]};
private _base = if (_own) then {+(_f getOrDefault ["basePosition",[]])} else {[]};
private _resources = if (_own) then {[
    _r getOrDefault ["steel",0],
    _r getOrDefault ["ammo",0],
    _r getOrDefault ["fuel",0],
    _r getOrDefault ["manpower",0]
]} else {[-1,-1,-1,-1]};
[
    _factionId,
    _f getOrDefault ["name", toUpper _factionId],
    _f getOrDefault ["active", false],
    _f getOrDefault ["controller", "ai"],
    _base,
    _resources,
    _unlocked,
    if (_own) then {+(_f getOrDefault ["vlsTargets", []])} else {[]},
    if (_own) then {+(_f getOrDefault ["vehiclePool", []])} else {[]},
    _f getOrDefault ["eliminated", false],
    if (_own) then {+(_f getOrDefault ["commanderPublic", []])} else {[]},
    _f getOrDefault ["baseConfirmed",false]
]
