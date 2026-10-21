params ["_factionId","_picture"];
if (!isServer) exitWith {["none",[],"SERVER ONLY"]};
private _ops = TYR_State getOrDefault ["operations",createHashMap];
private _forces = TYR_State getOrDefault ["forces",createHashMap];
private _orders = TYR_State getOrDefault ["commandOrders",createHashMap];
private _runtimeForces = TYR_Runtime getOrDefault ["forces",createHashMap];
private _active = +(_picture getOrDefault ["activeOperations",[]]);
private _threats = _picture getOrDefault ["emergencyThreats",[]];
private _contacts = ([_factionId] call TYR_fnc_StateGetFaction) getOrDefault ["knowledge",createHashMap];
private _contactMap = _contacts getOrDefault ["contacts",createHashMap];
private _outcomes = [];
private _aborted = 0;

{
    private _opId = _x;
    private _op = _ops getOrDefault [_opId,createHashMap];
    if (count _op > 0) then {
        private _type = _op getOrDefault ["type","attack"];
        private _phase = _op getOrDefault ["phase","move"];
        private _age = serverTime - (_op getOrDefault ["created",serverTime]);
        private _reason = "Operation remains viable";
        private _abort = false;
        private _forceIds = (_op getOrDefault ["forces",[]]) select {_x in keys _forces};
        if (count _forceIds isEqualTo 0) then {_abort = true; _reason = "No surviving assigned force"};
        if (!_abort && {_age > 900}) then {_abort = true; _reason = "Operation exceeded 15 minute strategic timeout"};
        if (!_abort && {count _threats > 0} && {!(_type in ["defend","reinforce","withdraw"])}) then {
            _abort = true; _reason = "Emergency threat overrides non-defensive operation";
        };
        if (!_abort && {(_op getOrDefault ["targetType","location"]) isEqualTo "contact"} && {!(_phase in ["search","complete"])}) then {
            private _contactId = _op getOrDefault ["target",""];
            private _c = _contactMap getOrDefault [_contactId,createHashMap];
            private _seen = _c getOrDefault ["seenServerTime",-9999];
            if ((serverTime - _seen) > 240) then {_abort = true; _reason = "Contact intelligence became too stale"};
        };

        if (_abort) then {
            _op set ["phase","failed"];
            _op set ["finishedAt",serverTime];
            _op set ["outcomeReason",_reason];
            {
                private _forceId = _x;
                private _fr = _forces getOrDefault [_forceId,createHashMap];
                if (count _fr > 0) then {_fr set ["operation",""]};
                private _grp = _runtimeForces getOrDefault [_forceId,grpNull];
                if (!isNull _grp) then {
                    {deleteWaypoint _x} forEach waypoints _grp;
                    if (count units _grp > 0) then {doStop leader _grp};
                };
            } forEach _forceIds;
            {
                private _order = _orders get _x;
                if ((_order getOrDefault ["operation",""]) isEqualTo _opId) then {_orders deleteAt _x};
            } forEach +(keys _orders);
            _aborted = _aborted + 1;
            _outcomes pushBack [_opId,"abort",_reason];
        } else {
            _outcomes pushBack [_opId,"continue",format ["%1 // %2",toUpper _type,toUpper _phase]];
        };
    };
} forEach _active;

if (_aborted > 0) then {["ai-operation-reassess"] call TYR_fnc_StateMarkDirty};
private _state = if (count _active isEqualTo 0) then {"none"} else {if (_aborted > 0) then {"aborted"} else {"continue"}};
[_state,_outcomes,format ["%1 active // %2 aborted",count _active,_aborted]]
