disableSerialization;
private _d = findDisplay 1700;
if (isNull _d) exitWith {};
missionNamespace setVariable ["TYR_debugMenuOpen",true];
if (isNil "TYR_debugFaction") then {TYR_debugFaction = TYR_PlayerFaction};
if !(TYR_debugFaction in ["west","east","independent"]) then {TYR_debugFaction = "west"};
missionNamespace setVariable ["TYR_debugPage",missionNamespace getVariable ["TYR_debugPage","movement"]];
missionNamespace setVariable ["TYR_debugView",missionNamespace getVariable ["TYR_debugView","map"]];

TYR_debugSend = {
    params ["_action",["_args",[]]];
    [_action,_args] remoteExecCall ["TYR_fnc_ServerDebugAction",2];
};
TYR_debugSelect = {
    params ["_fid"];
    if !(_fid in ["west","east","independent"]) exitWith {};
    TYR_debugFaction = _fid;
    [] call TYR_fnc_DebugMenuUpdateStatus;
    private _view = missionNamespace getVariable ["TYR_debugView","map"];
    if (_view isEqualTo "flow") then {
        ["debugTrace",[_fid]] call TYR_debugSend;
    } else {
        if (_view isEqualTo "map") then {["debugMap",[]] call TYR_debugSend};
    };
};
TYR_debugToggleMapTeleport = {
    private _enabled = !(missionNamespace getVariable ["TYR_DebugMapTeleportMode",false]);
    missionNamespace setVariable ["TYR_DebugMapTeleportMode",_enabled];
    [] call TYR_fnc_DebugMenuUpdateStatus;
    hint (if (_enabled) then {"Debug map teleport enabled: left-click the map."} else {"Debug map teleport disabled."});
};

if (isNil "TYR_DebugTaskDefinitions") then {
    missionNamespace setVariable ["TYR_DebugTaskDefinitions",[
        ["Visual contact appears","Look directly at an enemy infantryman or vehicle. Confirm a LAST SEEN contact appears on the faction map."],
        ["Contact freezes when lost","Create a contact, then look away while the enemy moves. Confirm the marker stays at the last observed position."],
        ["Reacquisition updates contact","Reacquire a stale contact and confirm its position/age updates."],
        ["Far contact stays broad","Observe at long range and confirm a broad classification rather than exact class."],
        ["Close/optical ID upgrades","Move close or use optics and confirm the contact upgrades to a more precise identity."],
        ["UAV visual intelligence","Put an enemy in a physical UAV view and confirm the faction contact updates."],
        ["Location ownership requires sight","Confirm an UNKNOWN enemy-held location changes only after real observation."],
        ["Truth versus knowledge","Compare TRUTH MAP with INTEL MAP. Unobserved enemies must exist only on truth."],
        ["AI force reconnaissance","Confirm AI force leaders create contacts only after physical line of sight."],
        ["Save/reload keeps last-known intel","Save/reload and confirm stale contacts persist until reacquired."],
        ["AI live decision trace","Run THINK + TRACE and confirm the 12-stage flow advances to a final decision."],
        ["AI unknown means reconnaissance","Keep a site unknown and confirm the AI can choose RECON/PROBE instead of hidden-truth attack."],
        ["AI order appears on map","Create an operation and confirm force-to-target intent and command route appear on ORDER MAP."],
        ["AI officer loss reroutes order","Kill an officer while an order is pending and confirm route/ETA/reroute changes."],
        ["AI collapse stops planning","Kill all command personnel and confirm the AI creates no new strategic operation."],
        ["Observed commander can be targeted","Observe an enemy commander legitimately and confirm it can become a raid candidate."]
    ]];
};
if (isNil "TYR_DebugTaskStatus") then {missionNamespace setVariable ["TYR_DebugTaskStatus",createHashMap]};

TYR_debugTaskSelectionChanged = {
    disableSerialization;
    private _display = findDisplay 1700;
    if (isNull _display) exitWith {};
    private _index = lbCurSel (_display displayCtrl 2201);
    private _defs = missionNamespace getVariable ["TYR_DebugTaskDefinitions",[]];
    if (_index < 0 || {_index >= count _defs}) exitWith {};
    private _statusMap = missionNamespace getVariable ["TYR_DebugTaskStatus",createHashMap];
    private _def = _defs # _index;
    (_display displayCtrl 2202) ctrlSetText format ["%1\n\nSTATUS // %2",_def # 1,_statusMap getOrDefault [str _index,"NOT TESTED"]];
};
TYR_debugTaskMark = {
    params ["_status"];
    disableSerialization;
    private _display = findDisplay 1700;
    if (isNull _display) exitWith {};
    private _index = lbCurSel (_display displayCtrl 2201);
    private _defs = missionNamespace getVariable ["TYR_DebugTaskDefinitions",[]];
    if (_index < 0 || {_index >= count _defs}) exitWith {};
    private _statusMap = missionNamespace getVariable ["TYR_DebugTaskStatus",createHashMap];
    _statusMap set [str _index,_status];
    missionNamespace setVariable ["TYR_DebugTaskStatus",_statusMap];
    [] call TYR_fnc_DebugTasksRefresh;
};
TYR_debugTaskReset = {
    missionNamespace setVariable ["TYR_DebugTaskStatus",createHashMap];
    [] call TYR_fnc_DebugTasksRefresh;
};

[missionNamespace getVariable ["TYR_debugPage","movement"]] call TYR_fnc_DebugMenuSetPage;
[missionNamespace getVariable ["TYR_debugView","map"]] call TYR_fnc_DebugMenuSetView;
[] call TYR_fnc_DebugMenuUpdateStatus;
["sync",[]] call TYR_debugSend;
["debugMap",[]] call TYR_debugSend;
