params ["_forceId"];
if (!isServer) exitWith {false};
private _forces = TYR_State getOrDefault ["forces",createHashMap];
private _fr = _forces getOrDefault [_forceId,createHashMap];
if (count _fr isEqualTo 0) exitWith {false};
private _fid = _fr getOrDefault ["faction",""];
private _network = [_fid] call TYR_fnc_CommandNetworkGet;
private _personnel = TYR_State getOrDefault ["commandPersonnel",createHashMap];
private _runtimeCommand = TYR_Runtime getOrDefault ["commandPersonnel",createHashMap];
private _aliveOfficers = [];
{
    private _r = _personnel getOrDefault [_x,createHashMap];
    private _obj = _runtimeCommand getOrDefault [_x,objNull];
    if (_r getOrDefault ["alive",false] && {!isNull _obj} && {alive _obj}) then {_aliveOfficers pushBack _x};
} forEach (_network getOrDefault ["officers",[]]);
_aliveOfficers sort true;
private _routeId = _fr getOrDefault ["commandOfficer",""];
if !(_routeId in _aliveOfficers) then {
    _routeId = if (count _aliveOfficers > 0) then {_aliveOfficers # 0} else {_network getOrDefault ["main",""]};
};
private _routeRec = _personnel getOrDefault [_routeId,createHashMap];
private _routeObj = _runtimeCommand getOrDefault [_routeId,objNull];
private _connected = !((_network getOrDefault ["status","collapsed"]) in ["collapsed","eliminated"]) && {_routeRec getOrDefault ["alive",false]} && {!isNull _routeObj} && {alive _routeObj};
_fr set ["commandOfficer",_routeId];
_fr set ["commandState",if (_connected) then {"connected"} else {"local"}];

private _grp = (TYR_Runtime getOrDefault ["forces",createHashMap]) getOrDefault [_forceId,grpNull];
if (!isNull _grp && {count units _grp > 0}) then {
    private _leader = leader _grp;
    if (!isNull _leader) then {
        _leader setVariable ["TYR_commandRole","force_commander",true];
        _leader setVariable ["TYR_commandForce",_forceId,true];
        _leader setVariable ["TYR_commandRoute",_routeId,true];
    };
};
_connected
