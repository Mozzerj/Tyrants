params ["_factionId","_factoryId","_productId",["_reason","Manual production order"],["_requestedBy","human"]];
if (!isServer) exitWith {[false,"Server only"]};
private _loc = [_factoryId] call TYR_fnc_StateGetLocation;
if (count _loc isEqualTo 0 || {(_loc getOrDefault ["kind",""]) isNotEqualTo "factory"}) exitWith {[false,"Factory not found"]};
if ((_loc getOrDefault ["owner","neutral"]) isNotEqualTo _factionId) exitWith {[false,"Factory is not controlled by this faction"]};
private _factoryType = _loc getOrDefault ["factoryType","munitions"];
private _catalog = [_factionId,_factoryType] call TYR_fnc_ProductionGetCatalog;
private _def = [];
{if ((_x # 0) isEqualTo _productId) exitWith {_def = _x}} forEach _catalog;
if (count _def isEqualTo 0) exitWith {[false,"Product is unavailable or research-locked"]};
private _queue = +(_loc getOrDefault ["productionQueue",[]]);
if (count _queue >= 3) exitWith {[false,"Factory queue is full"]};
_def params ["_pid","_display","_category","_amount","_duration","_gate","_class"];
private _startAt = serverTime;
if (count _queue > 0) then {
    private _last = _queue # ((count _queue)-1);
    _startAt = (_last getOrDefault ["finishAt",serverTime]) max serverTime;
};
private _id = ["production"] call TYR_fnc_StateNextId;
private _rec = createHashMapFromArray [
    ["id",_id],["product",_pid],["display",_display],["category",_category],["amount",_amount],["class",_class],
    ["queuedAt",serverTime],["startAt",_startAt],["finishAt",_startAt + _duration],["duration",_duration],
    ["reason",_reason],["requestedBy",_requestedBy]
];
_queue pushBack _rec;
_loc set ["productionQueue",_queue];
["production-queue"] call TYR_fnc_StateMarkDirty;
[_factoryId,_factionId] call TYR_fnc_ServerPublishLocation;
[true,format ["Queued %1 // %2s",_display,round _duration]]
