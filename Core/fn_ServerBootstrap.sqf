if (!isServer) exitWith {};
[false] call TYR_fnc_ServerSetCombatState;

TYR_Runtime = createHashMapFromArray [
    ["vehicles",createHashMap],["emplacements",createHashMap],["forces",createHashMap],["bases",createHashMap],
    ["factoryParts",createHashMap],["captureSessions",createHashMap],["arsenal",createHashMap],["loadedLocations",createHashMap],
    ["aiDecisionTraces",createHashMap],["aiObjectiveScores",createHashMap],
    ["revision",0],["saveDirty",false],["saveUrgent",false],["dirtySince",-1],["lastDirtyAt",-1],["lastSaveAt",-9999],
    ["saveGeneration",0],["saveReasons",[]],["newCampaign",false]
];

private _resetCampaign = (["TYR_ResetCampaign",0] call BIS_fnc_getParamValue) isEqualTo 1;
if (_resetCampaign) then {
    call TYR_fnc_PersistenceReset;
    diag_log "[TYRANTS V4] RESET SAVED CAMPAIGN parameter enabled: both v4 checkpoints were cleared before loading.";
};

call TYR_fnc_PersistenceLoad;
call TYR_fnc_ServerBuildLocations;
private _campaign = TYR_State get "campaign";
private _phase = _campaign getOrDefault ["phase","deployment"];

if (_phase isEqualTo "deployment") then {
    [false] call TYR_fnc_ServerSetCombatState;
    call TYR_fnc_ServerGenerateDeployment;
    {
        private _f = [_x] call TYR_fnc_StateGetFaction;
        if ((_f getOrDefault ["active",false]) && {(_f getOrDefault ["controller","human"]) isEqualTo "ai"}) then {
            [_x] call TYR_fnc_ServerAutoSelectBase;
        };
    } forEach ([false] call TYR_fnc_FactionIds);
    call TYR_fnc_ServerFinalizeDeployment;
} else {
    [true] call TYR_fnc_ServerSetCombatState;
};

if (((TYR_State get "campaign") getOrDefault ["phase","deployment"]) isEqualTo "running") then {
    call TYR_fnc_ServerCreateBases;
    call TYR_fnc_ServerRestoreDestroyedBuildings;
    call TYR_fnc_ServerRestoreVehicles;
    call TYR_fnc_ServerRestoreEmplacements;
    call TYR_fnc_AIForceRestore;
    {
        private _obj = (TYR_Runtime get "emplacements") getOrDefault [_x,objNull];
        private _rec = (TYR_State get "emplacements") get _x;
        if (!isNull _obj && {(_rec getOrDefault ["key",""]) isEqualTo "vls"}) then {
            [_obj,"vls",_rec get "faction"] remoteExec ["TYR_fnc_ClientAttachEmplacementActions",0,_obj];
        };
    } forEach keys (TYR_State get "emplacements");
};

addMissionEventHandler ["BuildingChanged",{params ["_from","_to","_isRuin"];if (_isRuin && {!isNull _from}) then {[_from] call TYR_fnc_ServerRegisterDestroyedBuilding}}];
addMissionEventHandler ["HandleDisconnect",{
    params ["_unit","_id","_uid"];
    if (!isNull _unit && {_uid isNotEqualTo ""} && {!isNil "TYR_State"} && {((TYR_State get "campaign") getOrDefault ["phase","deployment"]) isEqualTo "running"}) then {
        private _players = TYR_State get "players";
        private _fid = [side _unit] call TYR_fnc_SideFaction;
        private _old = _players getOrDefault [_uid,createHashMap];
        private _pos = getPosATL _unit;
        if !([_pos] call TYR_fnc_IsValidLandPosition) then {
            private _f = [_fid] call TYR_fnc_StateGetFaction;
            _pos = [_old getOrDefault ["position",[]],_f getOrDefault ["basePosition",[]]] call TYR_fnc_FindSafeSpawnPosition;
        };
        if (count _pos >= 2) then {
            _players set [_uid,createHashMapFromArray [["uid",_uid],["faction",_fid],["position",_pos],["direction",getDir _unit],["loadout",getUnitLoadout _unit]]];
            ["disconnect",true] call TYR_fnc_StateMarkDirty;
        };
    };
    false
}];
addMissionEventHandler ["MPEnded",{if (!isNil "TYR_Runtime" && {TYR_Runtime getOrDefault ["saveDirty",false]}) then {[true] call TYR_fnc_PersistenceSave}}];

call TYR_fnc_PersistenceManager;
call TYR_fnc_ServerScheduler;
if (TYR_Runtime getOrDefault ["newCampaign",false]) then {["new-campaign",true] call TYR_fnc_StateMarkDirty};
diag_log format ["[TYRANTS V4] Online. phase=%1 factions=%2 locations=%3 vehicles=%4 forces=%5",(TYR_State get "campaign") get "phase",[true] call TYR_fnc_FactionIds,count keys (TYR_State get "locations"),count keys (TYR_State get "vehicles"),count keys (TYR_State get "forces")];
