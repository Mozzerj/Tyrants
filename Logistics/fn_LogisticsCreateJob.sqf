params ["_factionId","_originType","_originId","_originPos","_destinationType","_destinationId","_destinationPos","_cargo",["_reason","Supply movement"]];
if (!isServer) exitWith {""};
if !(count _originPos >= 2 && {count _destinationPos >= 2} && {_cargo isEqualType []} && {count _cargo > 0}) exitWith {""};

private _source = createHashMap;
switch (_originType) do {
    case "factory": {
        private _loc = [_originId] call TYR_fnc_StateGetLocation;
        if (count _loc isEqualTo 0 || {(_loc getOrDefault ["owner","neutral"]) isNotEqualTo _factionId}) exitWith {};
        _source = _loc getOrDefault ["inventory",createHashMap];
    };
    case "depot": {
        private _f = [_factionId] call TYR_fnc_StateGetFaction;
        _source = _f getOrDefault ["depotInventory",createHashMap];
    };
};
if (count _source isEqualTo 0 && {_originType in ["factory","depot"]}) exitWith {""};
private _can = true;
{
    _x params ["_key","_qty"];
    if ((_source getOrDefault [_key,0]) < _qty) exitWith {_can = false};
} forEach _cargo;
if (!_can) exitWith {""};
{
    _x params ["_key","_qty"];
    _source set [_key,(_source getOrDefault [_key,0]) - _qty];
} forEach _cargo;
if (_originType isEqualTo "factory") then {
    private _loc = [_originId] call TYR_fnc_StateGetLocation;
    if (count _loc > 0) then {_loc set ["inventory",_source]; [_originId,_factionId] call TYR_fnc_ServerPublishLocation};
};
if (_originType isEqualTo "depot") then {
    private _f = [_factionId] call TYR_fnc_StateGetFaction;
    _f set ["depotInventory",_source];
    [_factionId] call TYR_fnc_ServerPublishFaction;
};

private _id = ["logistics"] call TYR_fnc_StateNextId;
private _distance = _originPos distance2D _destinationPos;
private _speed = 11; // virtual average metres/second; physical trucks take over in relevant areas.
private _duration = (_distance / _speed) max 20;
private _job = createHashMapFromArray [
    ["id",_id],["faction",_factionId],["originType",_originType],["originId",_originId],["originPosition",+_originPos],
    ["destinationType",_destinationType],["destinationId",_destinationId],["destinationPosition",+_destinationPos],
    ["cargo",+_cargo],["reason",_reason],["status","virtual"],["createdAt",serverTime],["legStartAt",serverTime],
    ["legStartPosition",+_originPos],["currentPosition",+_originPos],["arriveAt",serverTime + _duration],["virtualSpeed",_speed],
    ["physicalSince",-1],["lastStateChange",serverTime],["escortAlive",true],["cargoAlive",true],["finishedAt",-1]
];
(TYR_State getOrDefault ["logistics",createHashMap]) set [_id,_job];
["logistics-created"] call TYR_fnc_StateMarkDirty;
_id
