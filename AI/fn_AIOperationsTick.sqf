if (!isServer) exitWith {};
if (((TYR_State get "campaign") getOrDefault ["phase","deployment"]) isNotEqualTo "running") exitWith {};
private _ops = TYR_State get "operations";
private _forces = TYR_State get "forces";
private _runtime = TYR_Runtime get "forces";
private _sessions = TYR_Runtime get "captureSessions";

private _deadForces = [];
{
    private _id = _x;
    private _grp = _runtime getOrDefault [_id,grpNull];
    if (isNull _grp || {({alive _x} count (units _grp)) isEqualTo 0}) then {_deadForces pushBack _id};
} forEach keys _forces;
if (count _deadForces > 0) then {
    {
        private _grp = _runtime getOrDefault [_x,grpNull];
        if (!isNull _grp) then {deleteGroup _grp};
        _runtime deleteAt _x;
        _forces deleteAt _x;
    } forEach _deadForces;
    ["ai-force-loss"] call TYR_fnc_StateMarkDirty;
};

private _removeOps = [];
{
    private _opId = _x;
    private _op = _ops get _opId;
    if ((_op getOrDefault ["phase",""]) in ["complete","failed"]) then {
        _removeOps pushBack _opId;
    } else {
        private _targetId = _op getOrDefault ["target",""];
        private _l = [_targetId] call TYR_fnc_StateGetLocation;
        private _forceIds = (_op getOrDefault ["forces",[]]) select {_x in keys _forces};
        _op set ["forces",_forceIds];
        if (count _l isEqualTo 0 || {count _forceIds isEqualTo 0}) then {
            _op set ["phase","failed"];
        } else {
            private _fid = _op get "faction";
            if ((_l getOrDefault ["owner","neutral"]) isEqualTo _fid) then {
                _op set ["phase","complete"];
                {
                    private _fr = _forces getOrDefault [_x,createHashMap];
                    if (count _fr > 0) then {_fr set ["operation",""]};
                } forEach _forceIds;
            } else {
                private _targetPos = _l get "position";
                {
                    private _grp = _runtime getOrDefault [_x,grpNull];
                    if (!isNull _grp && {count units _grp > 0}) then {
                        private _leader = leader _grp;
                        if (_leader distance2D _targetPos > 140) then {
                            if (count waypoints _grp < 2) then {
                                private _wp = _grp addWaypoint [_targetPos,30];
                                _wp setWaypointType "MOVE";
                                _wp setWaypointBehaviour "AWARE";
                                _wp setWaypointCombatMode "RED";
                            };
                        } else {
                            if !(_targetId in keys _sessions) then {
                                _sessions set [_targetId,createHashMapFromArray [
                                    ["location",_targetId],["attacker",_fid],["owner",-1],["progress",0],["last",serverTime]
                                ]];
                            };
                        };
                    };
                } forEach _forceIds;
            };
        };
    };
} forEach keys _ops;

{
    private _o = _ops getOrDefault [_x,createHashMap];
    {
        private _fr = _forces getOrDefault [_x,createHashMap];
        if (count _fr > 0) then {_fr set ["operation",""]};
    } forEach (_o getOrDefault ["forces",[]]);
    _ops deleteAt _x;
} forEach _removeOps;
if (count _removeOps > 0) then {["ai-operation-cleanup"] call TYR_fnc_StateMarkDirty};
