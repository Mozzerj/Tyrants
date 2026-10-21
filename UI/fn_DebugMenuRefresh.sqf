disableSerialization;
private _d = findDisplay 1700;
if (isNull _d || {isNil "TYR_ClientState"}) exitWith {};
if (isNil "TYR_debugFaction") then {TYR_debugFaction = TYR_PlayerFaction};
TYR_debugSelect = {
    params ["_fid"];
    TYR_debugFaction = _fid;
    [] call TYR_fnc_DebugMenuRefresh;
};
TYR_debugSend = {
    params ["_action",["_args",[]]];
    [_action,_args] remoteExecCall ["TYR_fnc_ServerDebugAction",2];
};
private _f = (TYR_ClientState get "factions") getOrDefault [TYR_debugFaction,[]];
if (count _f < 6) exitWith {};
private _r = _f # 5;
(_d displayCtrl 101) ctrlSetText format ["TARGET // %1 // %2",toUpper (_f # 1),toUpper (_f # 3)];
(_d displayCtrl 110) ctrlSetText format ["STEEL\n%1",round (_r # 0)];
(_d displayCtrl 111) ctrlSetText format ["AMMO\n%1",round (_r # 1)];
(_d displayCtrl 112) ctrlSetText format ["FUEL\n%1",round (_r # 2)];
(_d displayCtrl 113) ctrlSetText format ["MANPOWER\n%1",round (_r # 3)];
(_d displayCtrl 130) ctrlSetText format ["Save generation %1 // Target %2",missionNamespace getVariable ["TYR_debugSaveGeneration",-1],toUpper TYR_debugFaction];
(_d displayCtrl 131) ctrlSetText format ["Client FPS: %1 // Server FPS: %2",round diag_fps,round (missionNamespace getVariable ["TYR_debugServerFps",-1])];

if (isNil "TYR_debugInitialRequested") then {TYR_debugInitialRequested=true;["sync",[]] call TYR_debugSend};
