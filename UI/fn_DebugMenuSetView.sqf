params ["_view"];
disableSerialization;
private _d = findDisplay 1700;
if (isNull _d) exitWith {};
private _valid = ["map","flow","intel","tasks","log","commands"];
if !(_view in _valid) then {_view = "map"};
missionNamespace setVariable ["TYR_debugView",_view];

private _mapIds = [1000,1001];
private _flowIds = [2099,2100,2101,2102,2103,2104,2105,2106,2107,2108,2109,2110,2111,2112,2131,2132,2133,2134,2135,2136,2137,2138,2139,2140,2141,2150,2151];
private _taskIds = [2199,2200,2201,2202,2203,2204,2205];
private _logIds = [2299,2300,2301];
private _commandIds = [2399,2400,2401,2402,2403,2404,2405,2406];
{(_d displayCtrl _x) ctrlShow false} forEach (_mapIds + _flowIds + _taskIds + _logIds + _commandIds);
private _show = switch (_view) do {
    case "flow": {_flowIds};
    case "tasks": {_taskIds};
    case "log": {_logIds};
    case "commands": {_commandIds};
    default {_mapIds};
};
{(_d displayCtrl _x) ctrlShow true} forEach _show;

private _tabs = [[411,"map"],[412,"flow"],[413,"intel"],[414,"tasks"],[415,"log"],[416,"commands"]];
{
    (_d displayCtrl (_x # 0)) ctrlSetTextColor (if ((_x # 1) isEqualTo _view) then {[0.95,0.72,0.20,1]} else {[0.80,0.82,0.84,1]});
} forEach _tabs;

switch (_view) do {
    case "flow": {[] call TYR_fnc_DebugFlowRefresh; ["debugTrace",[missionNamespace getVariable ["TYR_debugFaction",""]]] call TYR_debugSend};
    case "tasks": {[] call TYR_fnc_DebugTasksRefresh};
    case "log": {[] call TYR_fnc_DebugIntelLogRefresh};
    case "commands": {[] call TYR_fnc_DebugCommandRefresh};
    case "map": {["debugMap",[]] call TYR_debugSend};
};
[] call TYR_fnc_DebugMenuUpdateStatus;
