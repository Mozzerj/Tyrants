params ["_jobId"];
if (!isServer) exitWith {false};
private _jobs = TYR_State getOrDefault ["logistics",createHashMap];
private _job = _jobs getOrDefault [_jobId,createHashMap];
if (count _job isEqualTo 0 || {!(_job getOrDefault ["status",""] in ["virtual","physical"])}) exitWith {false};
private _fid = _job getOrDefault ["faction",""];
private _cargo = +(_job getOrDefault ["cargo",[]]);
private _destType = _job getOrDefault ["destinationType","hq"];
private _destId = _job getOrDefault ["destinationId",""];
switch (_destType) do {
    case "hq": {
        private _f = [_fid] call TYR_fnc_StateGetFaction;
        private _depot = _f getOrDefault ["depotInventory",createHashMap];
        {_x params ["_key","_qty"]; _depot set [_key,(_depot getOrDefault [_key,0]) + _qty]} forEach _cargo;
        _f set ["depotInventory",_depot];
        [_fid] call TYR_fnc_ServerPublishFaction;
    };
    case "force": {
        private _fr = (TYR_State getOrDefault ["forces",createHashMap]) getOrDefault [_destId,createHashMap];
        if (count _fr > 0) then {
            private _supply = _fr getOrDefault ["supply",createHashMapFromArray [["ammo",100],["fuel",100]]];
            {
                _x params ["_key","_qty"];
                if (_key isEqualTo "general_ammo") then {_supply set ["ammo",((_supply getOrDefault ["ammo",0]) + (_qty / 5)) min 100]};
                if (_key isEqualTo "fuel_supply") then {_supply set ["fuel",((_supply getOrDefault ["fuel",0]) + (_qty / 5)) min 100]};
            } forEach _cargo;
            _fr set ["supply",_supply];
        };
    };
    case "factory": {
        private _loc = [_destId] call TYR_fnc_StateGetLocation;
        if (count _loc > 0) then {
            private _inv = _loc getOrDefault ["inventory",createHashMap];
            {_x params ["_key","_qty"]; _inv set [_key,(_inv getOrDefault [_key,0]) + _qty]} forEach _cargo;
            _loc set ["inventory",_inv];
            [_destId,_fid] call TYR_fnc_ServerPublishLocation;
        };
    };
};
private _runtime = TYR_Runtime getOrDefault ["logistics",createHashMap];
private _rr = _runtime getOrDefault [_jobId,[]];
if (count _rr >= 3) then {
    _rr params ["_truck","_escort","_grp"];
    if (!isNull _escort) then {{deleteVehicle _x} forEach crew _escort; deleteVehicle _escort};
    if (!isNull _truck) then {{deleteVehicle _x} forEach crew _truck; deleteVehicle _truck};
    if (!isNull _grp) then {deleteGroup _grp};
    _runtime deleteAt _jobId;
};
_job set ["status","delivered"];
_job set ["finishedAt",serverTime];
_job set ["currentPosition",[_job] call TYR_fnc_LogisticsResolveDestination];
["logistics-delivered",true] call TYR_fnc_StateMarkDirty;
true
