titleCut ["","BLACK FADED",0];
waitUntil {!isNull player};
TYR_PlayerFaction = [playerSide] call TYR_fnc_SideFaction;
if (TYR_PlayerFaction isEqualTo "") exitWith {
    titleCut ["","BLACK IN",1];
    hint "This player slot is not assigned to WEST, EAST or INDEPENDENT.";
};

TYR_debugMode = (["TYR_DebugMode",0] call BIS_fnc_getParamValue) isEqualTo 1;
missionNamespace setVariable ["TYR_ClientStateReady",false];
missionNamespace setVariable ["TYR_PlayerRestored",false];
missionNamespace setVariable ["TYR_DeploymentPending",[]];
missionNamespace setVariable ["TYR_DeploymentLastClicked",[]];
missionNamespace setVariable ["TYR_DeploymentLastCheck",[false,"CLICK INSIDE YOUR COLOURED REGION",0,0,0]];
missionNamespace setVariable ["TYR_DeploymentCollisions",[]];

// Never expose the staging spawn as live combat. If state is slow, the client stays protected and keeps retrying.
player allowDamage false;
private _nextStateRequest = 0;
private _warnAt = diag_tickTime + 12;
waitUntil {
    sleep 0.1;
    if (diag_tickTime >= _nextStateRequest) then {
        [] remoteExecCall ["TYR_fnc_ServerRequestState",2];
        _nextStateRequest = diag_tickTime + 1;
    };
    if (diag_tickTime >= _warnAt) then {
        hintSilent "Waiting for Tyrants server campaign state...";
        _warnAt = diag_tickTime + 10;
    };
    missionNamespace getVariable ["TYR_ClientStateReady",false]
};
hintSilent "";

private _campaign = TYR_ClientState getOrDefault ["campaign",[]];
if (count _campaign > 0 && {(_campaign # 0) isEqualTo "deployment"}) then {
    titleCut ["","BLACK IN",0.5];
    createDialog "TyrDeploymentMenu";
    private _nextPoll = diag_tickTime + 2;
    waitUntil {
        sleep 0.15;
        private _c = TYR_ClientState getOrDefault ["campaign",[]];
        private _running = count _c > 0 && {(_c # 0) isEqualTo "running"};
        if (!_running && {isNull findDisplay 1300}) then {createDialog "TyrDeploymentMenu"};
        if (!_running && {diag_tickTime >= _nextPoll}) then {
            [] remoteExecCall ["TYR_fnc_ServerRequestState",2];
            _nextPoll = diag_tickTime + 3;
        };
        _running
    };
};

// Campaign is now live. Hide staging, restore/register at the confirmed HQ, then enable combat.
titleCut ["","BLACK OUT",0.25];
if (!isNull findDisplay 1300) then {closeDialog 0};
[] remoteExecCall ["TYR_fnc_ServerRegisterPlayer",2];
private _deadline = diag_tickTime + 20;
waitUntil {
    sleep 0.1;
    missionNamespace getVariable ["TYR_PlayerRestored",false] || {diag_tickTime > _deadline}
};
if !(missionNamespace getVariable ["TYR_PlayerRestored",false]) then {
    private _f = (TYR_ClientState get "factions") getOrDefault [TYR_PlayerFaction,[]];
    if (count _f >= 5) then {
        private _fallback = [[],_f # 4] call TYR_fnc_FindSafeSpawnPosition;
        if (count _fallback >= 2) then {
            player setPosATL _fallback;
            diag_log format ["[TYRANTS SPAWN] Restore timed out; used safe HQ fallback %1.",_fallback];
        };
    };
};

player setUnitTrait ["Medic",true];
player setUnitTrait ["UAVHacker",true];
player setUnitTrait ["explosiveSpecialist",true];
player setUnitTrait ["engineer",true];
player allowDamage true;

[] call TYR_fnc_ClientMapInit;
[] call TYR_fnc_ClientObservationTick;
waitUntil {!isNull findDisplay 46};
(findDisplay 46) displayAddEventHandler ["KeyDown",{
    params ["_display","_key"];
    if (_key isEqualTo 21 && {isNull findDisplay 1200} && {isNull findDisplay 1700} && {isNull findDisplay 1204}) then {createDialog "TyrPlayerMenu"};
    false
}];
if (isNil "TYR_arsenalClosedEH") then {
    TYR_arsenalClosedEH = [missionNamespace,"arsenalClosed",{
        private _after = getUnitLoadout player;
        [_after] remoteExecCall ["TYR_fnc_ServerPurchaseLoadout",2];
    }] call BIS_fnc_addScriptedEventHandler;
};
[] spawn {while {true} do {sleep 30;[] remoteExecCall ["TYR_fnc_ServerSavePlayer",2]}};
titleCut ["","BLACK IN",1.25];
