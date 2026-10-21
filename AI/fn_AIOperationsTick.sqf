if (!isServer) exitWith {};
if (((TYR_State get "campaign") getOrDefault ["phase","deployment"]) isNotEqualTo "running") exitWith {};
private _ops = TYR_State getOrDefault ["operations",createHashMap];
private _forces = TYR_State getOrDefault ["forces",createHashMap];
private _runtime = TYR_Runtime getOrDefault ["forces",createHashMap];
private _sessions = TYR_Runtime getOrDefault ["captureSessions",createHashMap];

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
    private _phase = _op getOrDefault ["phase",""];
    if (_phase in ["complete","failed"]) then {
        if (serverTime - (_op getOrDefault ["finishedAt",serverTime]) > 15) then {_removeOps pushBack _opId};
    } else {
        private _type = _op getOrDefault ["type","attack"];
        private _targetType = _op getOrDefault ["targetType","location"];
        private _targetId = _op getOrDefault ["target",""];
        private _targetPos = +(_op getOrDefault ["targetPosition",[]]);
        private _location = createHashMap;
        if (_targetType isEqualTo "location") then {
            _location = [_targetId] call TYR_fnc_StateGetLocation;
            if (count _location > 0) then {_targetPos = +(_location getOrDefault ["position",_targetPos])};
        };

        private _forceIds = (_op getOrDefault ["forces",[]]) select {_x in keys _forces};
        _op set ["forces",_forceIds];
        if (count _targetPos < 2 || {count _forceIds isEqualTo 0}) then {
            _op set ["phase","failed"];
            _op set ["finishedAt",serverTime];
            _op set ["outcomeReason",if (count _targetPos < 2) then {"Target position unavailable"} else {"Assigned force destroyed"}];
        } else {
            private _fid = _op getOrDefault ["faction",""];
            if (_targetType isEqualTo "location" && {count _location > 0} && {(_location getOrDefault ["owner","neutral"]) isEqualTo _fid} && {_type in ["attack","exploit"]}) then {
                _op set ["phase","complete"];
                _op set ["finishedAt",serverTime];
                _op set ["outcomeReason","Objective captured"];
            } else {
                if (_phase isNotEqualTo "command_pending") then {
                    private _allArrived = true;
                    {
                        private _forceId = _x;
                        private _grp = _runtime getOrDefault [_forceId,grpNull];
                        if (!isNull _grp && {count units _grp > 0}) then {
                            private _leader = leader _grp;
                            private _dist = _leader distance2D _targetPos;
                            if (_dist > 130) then {
                                _allArrived = false;
                                private _wpPos = waypointPosition [_grp,currentWaypoint _grp];
                                if (count waypoints _grp < 2 || {_wpPos distance2D _targetPos > 180}) then {
                                    {deleteWaypoint _x} forEach waypoints _grp;
                                    private _wp = _grp addWaypoint [_targetPos,25];
                                    _wp setWaypointType "MOVE";
                                    _wp setWaypointSpeed (if (_type in ["exploit","withdraw"]) then {"FULL"} else {"NORMAL"});
                                    _wp setWaypointBehaviour (if (_type in ["recon","probe"]) then {"AWARE"} else {"COMBAT"});
                                    _wp setWaypointCombatMode (if (_type in ["recon","withdraw"]) then {"YELLOW"} else {"RED"});
                                };
                            };
                        };
                    } forEach _forceIds;

                    if (_allArrived) then {
                        switch (_type) do {
                            case "attack";
                            case "exploit": {
                                if (_targetType isEqualTo "location" && {!(_targetId in keys _sessions)}) then {
                                    _sessions set [_targetId,createHashMapFromArray [
                                        ["location",_targetId],["attacker",_fid],["owner",-1],["progress",0],["last",serverTime]
                                    ]];
                                    _op set ["phase","capture"];
                                };
                            };
                            case "defend";
                            case "reinforce": {
                                if (_phase isNotEqualTo "hold" || {!("holdUntil" in keys _op)}) then {_op set ["phase","hold"]; _op set ["holdUntil",serverTime + 150]};
                                if (serverTime >= (_op getOrDefault ["holdUntil",serverTime + 150])) then {
                                    _op set ["phase","complete"];
                                    _op set ["finishedAt",serverTime];
                                    _op set ["outcomeReason","Defensive deployment completed"];
                                };
                            };
                            case "recon";
                            case "probe";
                            case "raid": {
                                if (_phase isNotEqualTo "search" || {!("searchUntil" in keys _op)}) then {_op set ["phase","search"]; _op set ["searchUntil",serverTime + (if (_type isEqualTo "raid") then {75} else {45})]};
                                if (serverTime >= (_op getOrDefault ["searchUntil",serverTime + 45])) then {
                                    _op set ["phase","complete"];
                                    _op set ["finishedAt",serverTime];
                                    _op set ["outcomeReason",if (_type isEqualTo "raid") then {"Raid/search window completed"} else {"Reconnaissance sweep completed"}];
                                };
                            };
                            case "withdraw": {
                                _op set ["phase","complete"];
                                _op set ["finishedAt",serverTime];
                                _op set ["outcomeReason","Withdrawal completed"];
                            };
                        };
                    };
                };
            };
        };
    };
} forEach +(keys _ops);

{
    private _o = _ops getOrDefault [_x,createHashMap];
    {
        private _fr = _forces getOrDefault [_x,createHashMap];
        if (count _fr > 0) then {_fr set ["operation",""]};
    } forEach (_o getOrDefault ["forces",[]]);
    _ops deleteAt _x;
} forEach _removeOps;
if (count _removeOps > 0) then {["ai-operation-cleanup"] call TYR_fnc_StateMarkDirty};
