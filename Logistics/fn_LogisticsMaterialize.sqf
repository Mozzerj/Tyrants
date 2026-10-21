params ["_jobId"];
if (!isServer) exitWith {false};
private _jobs = TYR_State getOrDefault ["logistics",createHashMap];
private _job = _jobs getOrDefault [_jobId,createHashMap];
if (count _job isEqualTo 0 || {(_job getOrDefault ["status",""]) isNotEqualTo "virtual"}) exitWith {false};
private _fid = _job getOrDefault ["faction",""];
private _side = [_fid] call TYR_fnc_FactionSide;
if (_side isEqualTo sideUnknown) exitWith {false};
private _pos = +(_job getOrDefault ["currentPosition",[]]);
if (count _pos < 2) exitWith {false};
private _safe = [_pos,_pos] call TYR_fnc_FindSafeSpawnPosition;
if (count _safe >= 2) then {_pos = _safe};
private _truckClass = switch (_fid) do {case "west":{"B_Truck_01_transport_F"};case "east":{"O_Truck_03_transport_F"};default {"I_Truck_02_transport_F"}};
private _escortClass = switch (_fid) do {case "west":{"B_MRAP_01_hmg_F"};case "east":{"O_MRAP_02_hmg_F"};default {"I_MRAP_03_hmg_F"}};
if !(isClass (configFile >> "CfgVehicles" >> _truckClass)) exitWith {false};
private _truck = createVehicle [_truckClass,_pos,[],0,"NONE"];
if (isNull _truck) exitWith {false};
createVehicleCrew _truck;
private _grp = group driver _truck;
_truck setVariable ["TYR_factionId",_fid,true];
_truck setVariable ["TYR_logisticsId",_jobId,true];
_truck setVariable ["TYR_logisticsRole","cargo",true];
_truck setVariable ["TYR_cargoManifest",+(_job getOrDefault ["cargo",[]]),true];
_truck addEventHandler ["Killed",{params ["_veh"];[_veh] call TYR_fnc_LogisticsVehicleKilled}];
{_x setVariable ["TYR_factionId",_fid,true]} forEach crew _truck;

private _escort = objNull;
if (isClass (configFile >> "CfgVehicles" >> _escortClass)) then {
    _escort = createVehicle [_escortClass,_pos vectorAdd [8,-8,0],[],0,"NONE"];
    if (!isNull _escort) then {
        createVehicleCrew _escort;
        {[_x] joinSilent _grp; _x setVariable ["TYR_factionId",_fid,true]} forEach crew _escort;
        _escort setVariable ["TYR_factionId",_fid,true];
        _escort setVariable ["TYR_logisticsId",_jobId,true];
        _escort setVariable ["TYR_logisticsRole","escort",true];
        _escort addEventHandler ["Killed",{params ["_veh"];[_veh] call TYR_fnc_LogisticsVehicleKilled}];
    };
};
private _dest = [_job] call TYR_fnc_LogisticsResolveDestination;
if (count _dest >= 2) then {
    private _wp = _grp addWaypoint [_dest,30];
    _wp setWaypointType "MOVE";
    _wp setWaypointSpeed "NORMAL";
    _wp setWaypointBehaviour "AWARE";
    _wp setWaypointCombatMode "YELLOW";
};
private _runtime = TYR_Runtime getOrDefault ["logistics",createHashMap];
_runtime set [_jobId,[_truck,_escort,_grp]];
_job set ["status","physical"];
_job set ["physicalSince",serverTime];
_job set ["lastStateChange",serverTime];
_job set ["currentPosition",getPosATL _truck];
["logistics-materialize"] call TYR_fnc_StateMarkDirty;
true
