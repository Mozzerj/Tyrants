if (!isServer) exitWith {};
private _orders = TYR_State getOrDefault ["commandOrders",createHashMap];
private _personnel = TYR_State getOrDefault ["commandPersonnel",createHashMap];
private _runtimeCommand = TYR_Runtime getOrDefault ["commandPersonnel",createHashMap];
private _forces = TYR_State getOrDefault ["forces",createHashMap];
private _operations = TYR_State getOrDefault ["operations",createHashMap];
private _remove = [];
private _changed = false;
{
    private _orderId = _x;
    private _order = _orders get _orderId;
    private _forceId = _order getOrDefault ["force",""];
    private _opId = _order getOrDefault ["operation",""];
    private _force = _forces getOrDefault [_forceId,createHashMap];
    private _op = _operations getOrDefault [_opId,createHashMap];
    if (count _force isEqualTo 0 || {count _op isEqualTo 0}) then {
        _remove pushBack _orderId;
        _changed = true;
    } else {
        private _fid = _order getOrDefault ["faction",""];
        private _delayInfo = [_fid] call TYR_fnc_CommandOrderDelay;
        _delayInfo params ["_canIssue","_delay","_newRoute"];
        if (_canIssue) then {
            private _oldRoute = _order getOrDefault ["route",[]];
            private _routeBroken = (_oldRoute findIf {
                private _r = _personnel getOrDefault [_x,createHashMap];
                private _obj = _runtimeCommand getOrDefault [_x,objNull];
                !(_r getOrDefault ["alive",false]) || {isNull _obj} || {!alive _obj}
            }) >= 0;
            if (_routeBroken) then {
                _order set ["route",+_newRoute];
                _order set ["deliverAt",serverTime + _delay];
                _order set ["reroutes",(_order getOrDefault ["reroutes",0]) + 1];
                _changed = true;
            } else {
                if (serverTime >= (_order getOrDefault ["deliverAt",1e12])) then {
                    _op set ["phase","move"];
                    _op set ["commandDeliveredAt",serverTime];
                    _force set ["commandState","connected"];
                    _remove pushBack _orderId;
                    _changed = true;
                    diag_log format ["[TYRANTS COMMAND] Order %1 delivered to %2 after %3 reroute(s).",_orderId,_forceId,_order getOrDefault ["reroutes",0]];
                };
            };
        } else {
            _force set ["commandState","local"];
        };
    };
} forEach keys _orders;
{_orders deleteAt _x} forEach _remove;
if (_changed) then {["command-orders"] call TYR_fnc_StateMarkDirty};
