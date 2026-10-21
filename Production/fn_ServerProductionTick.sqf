if (!isServer) exitWith {};
private _locations = TYR_State getOrDefault ["locations",createHashMap];
{
    private _id = _x;
    private _loc = _locations get _id;
    if ((_loc getOrDefault ["kind",""]) isEqualTo "factory") then {
        private _now = serverTime;
        private _last = _loc getOrDefault ["productionLastTick",_now];
        private _dt = ((_now - _last) max 0) min 5;
        _loc set ["productionLastTick",_now];
        private _queue = +(_loc getOrDefault ["productionQueue",[]]);
        private _operational = [_id] call TYR_fnc_ProductionFactoryOperational;
        private _wasOperational = _loc getOrDefault ["productionOperational",true];
        if (_operational isNotEqualTo _wasOperational) then {
            _loc set ["productionOperational",_operational];
            private _owner = _loc getOrDefault ["owner","neutral"];
            if (_owner in ["west","east","independent"]) then {[_id,_owner] call TYR_fnc_ServerPublishLocation};
        };
        if (count _queue > 0) then {
            if (_operational) then {
                private _first = _queue # 0;
                if (_now >= (_first getOrDefault ["finishAt",_now + 1])) then {
                    _queue deleteAt 0;
                    _loc set ["productionQueue",_queue];
                    [_id,_first] call TYR_fnc_ProductionComplete;
                };
            } else {
                // Destroyed/disabled factory capacity pauses the clock instead of silently finishing.
                {
                    _x set ["startAt",(_x getOrDefault ["startAt",_now]) + _dt];
                    _x set ["finishAt",(_x getOrDefault ["finishAt",_now]) + _dt];
                } forEach _queue;
                _loc set ["productionQueue",_queue];
            };
        };
    };
} forEach keys _locations;
