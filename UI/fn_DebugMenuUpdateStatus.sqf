disableSerialization;
private _d = findDisplay 1700;
if (isNull _d || {isNil "TYR_ClientState"}) exitWith {};
if (isNil "TYR_debugFaction") then {TYR_debugFaction = TYR_PlayerFaction};
if !(TYR_debugFaction in ["west","east","independent"]) then {TYR_debugFaction = "west"};

(_d displayCtrl 130) ctrlSetText format ["SERVER %1 FPS // CLIENT %2 FPS // SAVE %3 // %4",round (missionNamespace getVariable ["TYR_debugServerFps",-1]),round diag_fps,missionNamespace getVariable ["TYR_debugSaveGeneration",-1],toUpper TYR_debugFaction];

private _f = (TYR_ClientState get "factions") getOrDefault [TYR_debugFaction,[]];
if (count _f >= 6) then {
    private _r = _f # 5;
    (_d displayCtrl 205) ctrlSetText format ["TARGET // %1\n%2",toUpper (_f # 1),toUpper (_f # 3)];
    (_d displayCtrl 221) ctrlSetText format ["STEEL %1   AMMO %2\nFUEL %3   MANPOWER %4",round (_r # 0),round (_r # 1),round (_r # 2),round (_r # 3)];
};
(_d displayCtrl 131) ctrlSetText format ["CLIENT FPS %1\nSERVER FPS %2",round diag_fps,round (missionNamespace getVariable ["TYR_debugServerFps",-1])];

private _cmdText = "STATUS --\nMAIN -- // OFFICERS --";
private _debugMapData = missionNamespace getVariable ["TYR_DebugMapData",[]];
private _networks = if (_debugMapData isEqualType [] && {count _debugMapData >= 7}) then {_debugMapData # 6} else {[]};
{
    if ((_x param [0,""]) isEqualTo TYR_debugFaction) exitWith {
        private _nodes = _x param [4,[]];
        private _aliveMain = {_x # 1 isEqualTo "commander" && {_x # 4}} count _nodes;
        private _aliveOfficers = {_x # 1 isEqualTo "officer" && {_x # 4}} count _nodes;
        _cmdText = format ["STATUS %1 // PENDING %2\nMAIN %3 // OFFICERS %4",toUpper (_x param [1,"--"]),_x param [6,0],_aliveMain,_aliveOfficers];
    };
} forEach _networks;
(_d displayCtrl 271) ctrlSetText _cmdText;

private _tp = missionNamespace getVariable ["TYR_DebugMapTeleportMode",false];
(_d displayCtrl 285) ctrlSetText format ["MAP TELEPORT // %1",if (_tp) then {"ON"} else {"OFF"}];
(_d displayCtrl 286) ctrlSetText format ["LEFT CLICK TP // %1",if (_tp) then {"ENABLED"} else {"OFF"}];

private _view = missionNamespace getVariable ["TYR_debugView","map"];
if (_view in ["map","intel"]) then {
    private _instruction = if (_view isEqualTo "intel") then {
        "FACTION INTELLIGENCE // last-known contacts only // compare with TRUTH MAP"
    } else {
        if (missionNamespace getVariable ["TYR_DebugOrderFocus",false]) then {
            format ["AI ORDER MAP // %1 // force intent + operation + physical command delivery route",toUpper TYR_debugFaction]
        } else {
            "OMNISCIENT SERVER TRUTH // strategic detail at wide zoom // units appear when zoomed in"
        }
    };
    if (_tp) then {_instruction = _instruction + " // LEFT CLICK = TELEPORT"};
    (_d displayCtrl 1001) ctrlSetText _instruction;
};
