if (!isServer) exitWith {};
private _jobs = TYR_State getOrDefault ["logistics",createHashMap];
private _runtime = TYR_Runtime getOrDefault ["logistics",createHashMap];
private _cleanup = [];
{
    private _id = _x;
    private _job = _jobs get _id;
    private _status = _job getOrDefault ["status","virtual"];
    if (_status isEqualTo "virtual") then {
        private _start = +(_job getOrDefault ["legStartPosition",_job getOrDefault ["currentPosition",[]]]);
        private _dest = [_job] call TYR_fnc_LogisticsResolveDestination;
        if (count _start >= 2 && {count _dest >= 2}) then {
            _job set ["destinationPosition",_dest];
            private _arrive = _job getOrDefault ["arriveAt",serverTime + 1];
            private _startAt = _job getOrDefault ["legStartAt",serverTime];
            private _den = (_arrive - _startAt) max 0.1;
            private _t = ((serverTime - _startAt) / _den) max 0 min 1;
            private _pos = [
                (_start # 0) + ((_dest # 0) - (_start # 0)) * _t,
                (_start # 1) + ((_dest # 1) - (_start # 1)) * _t,
                0
            ];
            _job set ["currentPosition",_pos];
            if ([_job,_pos] call TYR_fnc_LogisticsShouldPhysical) then {
                [_id] call TYR_fnc_LogisticsMaterialize;
            } else {
                if (serverTime >= _arrive) then {[_id] call TYR_fnc_LogisticsArrive};
            };
        };
    } else {
        if (_status isEqualTo "physical") then {
            private _rr = _runtime getOrDefault [_id,[]];
            if (count _rr < 3) then {
                _job set ["status","virtual"];
                _job set ["legStartAt",serverTime];
                _job set ["legStartPosition",+(_job getOrDefault ["currentPosition",[]])];
            } else {
                _rr params ["_truck","_escort","_grp"];
                if (isNull _truck || {!alive _truck}) then {
                    _job set ["status","destroyed"];
                    _job set ["cargoAlive",false];
                    _job set ["finishedAt",serverTime];
                } else {
                    private _pos = getPosATL _truck;
                    private _dest = [_job] call TYR_fnc_LogisticsResolveDestination;
                    _job set ["currentPosition",_pos];
                    _job set ["destinationPosition",_dest];
                    if (count _dest >= 2 && {_pos distance2D _dest <= 120}) then {
                        [_id] call TYR_fnc_LogisticsArrive;
                    } else {
                        if (count _dest >= 2 && {!isNull _grp}) then {
                            private _wp = waypointPosition [_grp,currentWaypoint _grp];
                            if (count _wp < 2 || {_wp distance2D _dest > 300}) then {
                                {deleteWaypoint _x} forEach waypoints _grp;
                                private _newWp = _grp addWaypoint [_dest,30];
                                _newWp setWaypointType "MOVE";
                            };
                        };
                        if (serverTime - (_job getOrDefault ["physicalSince",serverTime]) > 30 && {!([_job,_pos] call TYR_fnc_LogisticsShouldPhysical)}) then {
                            [_id] call TYR_fnc_LogisticsVirtualize;
                        };
                    };
                };
            };
        };
    };
    if ((_job getOrDefault ["status",""]) in ["delivered","destroyed"] && {serverTime - (_job getOrDefault ["finishedAt",serverTime]) > 180}) then {_cleanup pushBack _id};
} forEach +(keys _jobs);
{_jobs deleteAt _x; _runtime deleteAt _x} forEach _cleanup;
