params ["_factionId",["_viewerFaction",""]];
private _f = [_factionId] call TYR_fnc_StateGetFaction;
if (count _f isEqualTo 0) exitWith {[]};
private _r = _f get "resources";
private _research = _f getOrDefault ["research", createHashMap];
private _keys = keys _research;
_keys sort true;
private _unlocked = _keys select {_research getOrDefault [_x, false]};
private _base = [];
// Exact HQ positions are faction intelligence. Never put an enemy HQ in ordinary replication.
if (_viewerFaction isEqualTo _factionId) then {_base = +(_f getOrDefault ["basePosition",[]])};
[
    _factionId,
    _f getOrDefault ["name", toUpper _factionId],
    _f getOrDefault ["active", false],
    _f getOrDefault ["controller", "ai"],
    _base,
    [
        _r getOrDefault ["steel",0],
        _r getOrDefault ["ammo",0],
        _r getOrDefault ["fuel",0],
        _r getOrDefault ["manpower",0]
    ],
    _unlocked,
    +(_f getOrDefault ["vlsTargets", []]),
    _f getOrDefault ["vehiclePool", []],
    _f getOrDefault ["eliminated", false],
    +(_f getOrDefault ["commanderPublic", []]),
    _f getOrDefault ["baseConfirmed",false]
]
