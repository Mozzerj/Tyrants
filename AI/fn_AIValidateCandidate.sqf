params ["_factionId","_picture","_candidate"];
private _type = _candidate getOrDefault ["type","hold"];
private _score = _candidate getOrDefault ["score",-1e9];
if (_score < 10 && {_type isNotEqualTo "hold"}) exitWith {[false,"Score below strategic action threshold",""]};

if (_type isEqualTo "hold") exitWith {[true,"No action prerequisites",""]};
if (_type isEqualTo "research") exitWith {
    private _key = _candidate getOrDefault ["target",""];
    private _def = (call TYR_fnc_GetResearchDefinitions) select {(_x # 0) isEqualTo _key};
    if (count _def isEqualTo 0) then {[false,"Research definition unavailable",""]} else {
        private _f = [_factionId] call TYR_fnc_StateGetFaction;
        private _resources = _f get "resources";
        if ((_resources getOrDefault ["steel",0]) < ((_def # 0) # 3)) then {[false,"Insufficient steel for research",""]} else {[true,"Research prerequisites and resources available",""]}
    }
};
if (_type isEqualTo "raise_force") exitWith {
    private _r = ([_factionId] call TYR_fnc_StateGetFaction) get "resources";
    if ((_r getOrDefault ["steel",0]) < 1200 || {(_r getOrDefault ["ammo",0]) < 800} || {(_r getOrDefault ["manpower",0]) < 6}) then {
        [false,"Insufficient resources to raise infantry force",""]
    } else {[true,"Force-generation resources available",""]}
};

private _free = _picture getOrDefault ["freeForces",[]];
if (count _free isEqualTo 0) exitWith {[false,"No uncommitted force available",""]};
private _pos = _candidate getOrDefault ["targetPosition",[]];
if (count _pos < 2) exitWith {[false,"Candidate has no usable target position",""]};

private _delay = [_factionId] call TYR_fnc_CommandOrderDelay;
if !(_delay # 0) exitWith {[false,"No functioning command route for new strategic order",""]};

private _offensive = _type in ["attack","raid","exploit","probe"];
private _total = _picture getOrDefault ["forceCount",0];
private _reserveRatio = (([_factionId] call TYR_fnc_StateGetFaction) getOrDefault ["commander",createHashMap]) getOrDefault ["reserveRatio",0.2];
private _reserveNeeded = ceil (_total * _reserveRatio);
if (_offensive && {(count _free) <= _reserveNeeded}) exitWith {[false,format ["Reserve rule keeps %1 force(s) uncommitted",_reserveNeeded],""]};

private _targetType = _candidate getOrDefault ["targetType",""];
private _intelAge = _candidate getOrDefault ["intelAge",1e9];
if (_targetType isEqualTo "contact" && {_intelAge > 180}) exitWith {[false,format ["Contact intelligence is stale (%1s)",round _intelAge],""]};

private _positions = _picture getOrDefault ["forcePositions",createHashMap];
private _bestForce = "";
private _bestDist = 1e12;
{
    private _fp = _positions getOrDefault [_x,[]];
    if (count _fp >= 2) then {
        private _d = _fp distance2D _pos;
        if (_d < _bestDist) then {_bestDist = _d; _bestForce = _x};
    };
} forEach _free;
if (_bestForce isEqualTo "") then {_bestForce = _free # 0};
[true,format ["Validated // force %1 // command delay ~%2s",toUpper _bestForce,round (_delay # 1)],_bestForce]
