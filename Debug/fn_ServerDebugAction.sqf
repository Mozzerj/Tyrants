params ["_action",["_args",[]]];
if (!isServer) exitWith {};
if ((["TYR_DebugMode",0] call BIS_fnc_getParamValue) isNotEqualTo 1) exitWith {};
private _owner = remoteExecutedOwner;
private _player = [_owner] call TYR_fnc_FindPlayerByOwner;
if (isNull _player) exitWith {};

switch (_action) do {
    case "resource": {
        _args params ["_fid","_resource","_amount"];
        if (_fid in ["west","east","independent"] && {_resource in ["steel","ammo","fuel","manpower"]}) then {
            [_fid,_resource,(_amount max -1000000) min 1000000,"debug-resource"] call TYR_fnc_StateChangeResource;
        };
    };
    case "boost": {
        private _fid = _args param [0,""];
        {[_fid,_x,if (_x isEqualTo "manpower") then {1000} else {100000},"debug-boost"] call TYR_fnc_StateChangeResource} forEach ["steel","ammo","fuel","manpower"];
    };
    case "max": {
        private _fid = _args param [0,""];
        private _f = [_fid] call TYR_fnc_StateGetFaction;
        if (count _f > 0) then {
            private _r = _f get "resources";
            _r set ["steel",1000000];_r set ["ammo",1000000];_r set ["fuel",1000000];_r set ["manpower",10000];
            ["debug-max"] call TYR_fnc_StateMarkDirty;[_fid] call TYR_fnc_ServerPublishFaction;
        };
    };
    case "unlockResearch": {
        private _fid = _args param [0,""];
        private _f = [_fid] call TYR_fnc_StateGetFaction;
        if (count _f > 0) then {
            private _r = _f get "research";
            {_r set [_x # 0,true]} forEach call TYR_fnc_GetResearchDefinitions;
            ["debug-research"] call TYR_fnc_StateMarkDirty;[_fid] call TYR_fnc_ServerPublishFaction;
        };
    };
    case "resetResearch": {
        private _fid = _args param [0,""];
        private _f = [_fid] call TYR_fnc_StateGetFaction;
        if (count _f > 0) then {
            private _r = _f get "research";
            {_r set [_x # 0,false]} forEach call TYR_fnc_GetResearchDefinitions;
            ["debug-research"] call TYR_fnc_StateMarkDirty;[_fid] call TYR_fnc_ServerPublishFaction;
        };
    };
    case "factoryTick": {call TYR_fnc_ServerEconomyTick};
    case "spawnForce": {
        private _fid = _args param [0,""];
        [_fid,"infantry",true] call TYR_fnc_AIForceCreate;
    };
    case "think": {
        private _fid = _args param [0,""];
        [_fid] call TYR_fnc_AICommanderThink;
    };
    case "save": {[true] call TYR_fnc_PersistenceSave};
    case "sync": {
        {[_x,0] call TYR_fnc_ServerPublishFaction} forEach ([false] call TYR_fnc_FactionIds);
        {[_x,0] call TYR_fnc_ServerPublishLocation} forEach keys (TYR_State get "locations");
    };
};
[_player,"TYR_fnc_ClientDebugState",[TYR_Runtime getOrDefault ["saveGeneration",0],diag_fps]] call TYR_fnc_ServerSendToPlayer;
