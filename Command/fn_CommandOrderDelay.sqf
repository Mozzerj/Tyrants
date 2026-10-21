params ["_factionId"];
private _network = [_factionId] call TYR_fnc_CommandNetworkGet;
if (count _network isEqualTo 0) exitWith {[false,999,[]]};
private _status = _network getOrDefault ["status","forming"];
if (_status in ["collapsed","eliminated"]) exitWith {[false,999,[]]};

private _personnel = TYR_State getOrDefault ["commandPersonnel",createHashMap];
private _runtime = TYR_Runtime getOrDefault ["commandPersonnel",createHashMap];
private _route = [];
private _mainId = _network getOrDefault ["main",""];
if (_mainId isNotEqualTo "") then {
    private _main = _personnel getOrDefault [_mainId,createHashMap];
    private _obj = _runtime getOrDefault [_mainId,objNull];
    if (_main getOrDefault ["alive",false] && {!isNull _obj} && {alive _obj}) then {_route pushBack _mainId};
};
private _aliveOfficers = [];
{
    private _r = _personnel getOrDefault [_x,createHashMap];
    private _obj = _runtime getOrDefault [_x,objNull];
    if (_r getOrDefault ["alive",false] && {!isNull _obj} && {alive _obj}) then {_aliveOfficers pushBack _x};
} forEach (_network getOrDefault ["officers",[]]);
if (count _aliveOfficers > 0) then {_route pushBack (_aliveOfficers # 0)};

private _delay = switch (_status) do {
    case "operational": {3};
    case "degraded": {8};
    case "isolated": {14};
    case "succession": {18};
    case "forming": {8};
    default {12};
};
[true,_delay,_route]
