params ["_factionId","_forceId","_operationId",["_targetId",""]];
if (!isServer) exitWith {false};
private _delayInfo = [_factionId] call TYR_fnc_CommandOrderDelay;
_delayInfo params ["_canIssue","_delay","_route"];
if (!_canIssue) exitWith {false};
private _forces = TYR_State getOrDefault ["forces",createHashMap];
private _operations = TYR_State getOrDefault ["operations",createHashMap];
private _force = _forces getOrDefault [_forceId,createHashMap];
private _op = _operations getOrDefault [_operationId,createHashMap];
if (count _force isEqualTo 0 || {count _op isEqualTo 0}) exitWith {false};
private _orderId = ["order"] call TYR_fnc_StateNextId;
private _orders = TYR_State getOrDefault ["commandOrders",createHashMap];
_orders set [_orderId,createHashMapFromArray [
    ["id",_orderId],["faction",_factionId],["force",_forceId],["operation",_operationId],
    ["target",_targetId],["issuedAt",serverTime],["deliverAt",serverTime + _delay],
    ["status","pending"],["route",+_route],["reroutes",0]
]];
_force set ["operation",_operationId];
_op set ["phase","command_pending"];
_op set ["orderId",_orderId];
_op set ["commandDelay",_delay];
["command-order-queued"] call TYR_fnc_StateMarkDirty;
true
