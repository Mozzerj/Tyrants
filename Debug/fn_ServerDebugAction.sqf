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
    case "thinkTrace": {
        private _fid = _args param [0,""];
        if (_fid in ["west","east","independent"]) then {
            [_fid] spawn {params ["_fid"]; [_fid,true] call TYR_fnc_AICommanderThink};
        };
    };
    case "commandTick": {call TYR_fnc_ServerCommandTick};
    case "commandTp": {
        private _fid = _args param [0,""];
        private _network = [_fid] call TYR_fnc_CommandNetworkGet;
        private _mainId = _network getOrDefault ["main",""];
        private _rec = (TYR_State getOrDefault ["commandPersonnel",createHashMap]) getOrDefault [_mainId,createHashMap];
        private _obj = (TYR_Runtime getOrDefault ["commandPersonnel",createHashMap]) getOrDefault [_mainId,objNull];
        private _pos = if (!isNull _obj) then {getPosATL _obj} else {+(_rec getOrDefault ["position",[]])};
        if (count _pos >= 2) then {
            private _safe = [[(_pos # 0)+3,_pos # 1,0.2],_pos] call TYR_fnc_FindSafeSpawnPosition;
            [_player,"TYR_fnc_ClientDebugTeleport",[_safe,format ["%1 COMMAND",_fid]]] call TYR_fnc_ServerSendToPlayer;
        };
    };
    case "commandKillMain": {
        private _fid = _args param [0,""];
        private _network = [_fid] call TYR_fnc_CommandNetworkGet;
        private _id = _network getOrDefault ["main",""];
        private _obj = (TYR_Runtime getOrDefault ["commandPersonnel",createHashMap]) getOrDefault [_id,objNull];
        if (!isNull _obj && {alive _obj}) then {_obj setDamage 1};
    };
    case "commandKillOfficer": {
        private _fid = _args param [0,""];
        private _network = [_fid] call TYR_fnc_CommandNetworkGet;
        private _personnel = TYR_State getOrDefault ["commandPersonnel",createHashMap];
        private _runtimeCommand = TYR_Runtime getOrDefault ["commandPersonnel",createHashMap];
        private _id = "";
        {
            private _r = _personnel getOrDefault [_x,createHashMap];
            private _obj = _runtimeCommand getOrDefault [_x,objNull];
            if (_r getOrDefault ["alive",false] && {!isNull _obj} && {alive _obj}) exitWith {_id = _x};
        } forEach (_network getOrDefault ["officers",[]]);
        if (_id isNotEqualTo "") then {(_runtimeCommand get _id) setDamage 1};
    };
    case "commandKillAll": {
        private _fid = _args param [0,""];
        private _personnel = TYR_State getOrDefault ["commandPersonnel",createHashMap];
        private _runtimeCommand = TYR_Runtime getOrDefault ["commandPersonnel",createHashMap];
        {
            private _r = _personnel get _x;
            if ((_r getOrDefault ["faction",""]) isEqualTo _fid && {_r getOrDefault ["alive",false]}) then {
                private _obj = _runtimeCommand getOrDefault [_x,objNull];
                if (!isNull _obj && {alive _obj}) then {_obj setDamage 1};
            };
        } forEach keys _personnel;
    };
    case "commandFastTimer": {
        private _fid = _args param [0,""];
        private _f = [_fid] call TYR_fnc_StateGetFaction;
        private _network = [_fid] call TYR_fnc_CommandNetworkGet;
        private _status = _network getOrDefault ["status","forming"];
        if (_status isEqualTo "succession") then {_network set ["successionAt",serverTime]};
        if (_status in ["operational","degraded","isolated"] && {(_network getOrDefault ["replacementAt",-1]) > 0}) then {_network set ["replacementAt",serverTime]};
        if (_status isEqualTo "collapsed") then {
            private _res = _f getOrDefault ["resources",createHashMap];
            private _baseRec = (TYR_Runtime getOrDefault ["bases",createHashMap]) getOrDefault [_fid,createHashMap];
            private _box = _baseRec getOrDefault ["box",objNull];
            if (!isNull _box && {(_res getOrDefault ["manpower",0]) >= 5}) then {
                _network set ["replacementAt",serverTime];
            } else {
                _network set ["collapseSince",serverTime - 239];
            };
        };
        call TYR_fnc_ServerCommandTick;
    };
    case "teleport": {
        private _fid = _args param [0,""];
        if (_fid in ["west","east","independent"]) then {
            private _f = [_fid] call TYR_fnc_StateGetFaction;
            if (count _f > 0) then {
                private _base = _f getOrDefault ["basePosition",[]];
                private _safe = [_base,_base] call TYR_fnc_FindSafeSpawnPosition;
                if (count _safe >= 2) then {
                    [_player,"TYR_fnc_ClientDebugTeleport",[_safe,_fid]] call TYR_fnc_ServerSendToPlayer;
                } else {
                    [_player,"TYR_fnc_ClientHint",[format ["Debug teleport failed: %1 HQ is not deployed yet.",toUpper _fid]]] call TYR_fnc_ServerSendToPlayer;
                };
            };
        };
    };
    case "debugTrace": {
        private _fid = _args param [0,""];
        private _ids = if (_fid in ["west","east","independent"]) then {[_fid]} else {["west","east","independent"]};
        private _traceMap = TYR_Runtime getOrDefault ["aiDecisionTraces",createHashMap];
        private _aiTraces = [];
        {
            private _traceRecord = _traceMap getOrDefault [_x,createHashMap];
            _aiTraces pushBack [
                _x,
                _traceRecord getOrDefault ["started",-1],
                _traceRecord getOrDefault ["finished",-1],
                _traceRecord getOrDefault ["currentStep",0],
                +(_traceRecord getOrDefault ["nodes",[]]),
                +(_traceRecord getOrDefault ["candidates",[]]),
                _traceRecord getOrDefault ["decision",""],
                _traceRecord getOrDefault ["posture","hold"]
            ];
        } forEach _ids;
        [_player,"TYR_fnc_ClientDebugAITraceData",[serverTime,_aiTraces]] call TYR_fnc_ServerSendToPlayer;
    };
    case "debugMap": {
        private _locations = [];
        {
            private _l = (TYR_State get "locations") get _x;
            _locations pushBack [
                _x,
                _l getOrDefault ["name",_x],
                _l getOrDefault ["kind","town"],
                +(_l getOrDefault ["position",[]]),
                _l getOrDefault ["owner","neutral"],
                _l getOrDefault ["stock",0],
                _l getOrDefault ["resource",""],
                _l getOrDefault ["value",1]
            ];
        } forEach keys (TYR_State get "locations");

        private _factions = [];
        {
            private _f = [_x] call TYR_fnc_StateGetFaction;
            private _cmd = _f getOrDefault ["commander",createHashMap];
            _factions pushBack [
                _x,
                _f getOrDefault ["name",toUpper _x],
                _f getOrDefault ["active",false],
                _f getOrDefault ["controller","disabled"],
                +(_f getOrDefault ["basePosition",[]]),
                _f getOrDefault ["baseConfirmed",false],
                _f getOrDefault ["eliminated",false],
                _cmd getOrDefault ["personality",""],
                _cmd getOrDefault ["objective",""]
            ];
        } forEach ["west","east","independent"];

        private _entities = [];
        {
            if (!isNull _x) then {
                private _fid = _x getVariable ["TYR_factionId",[side _x] call TYR_fnc_SideFaction];
                if (_fid in ["west","east","independent"]) then {
                    private _display = getText (configFile >> "CfgVehicles" >> typeOf _x >> "displayName");
                    private _extra = if (isPlayer _x) then {name _x} else {str group _x};
                    _entities pushBack ["unit",_fid,typeOf _x,_display,getPosATL _x,getDir _x,alive _x,damage _x,_extra];
                };
            };
        } forEach allUnits;
        {
            if (!isNull _x) then {
                private _fid = _x getVariable ["TYR_factionId",""];
                if (_fid in ["west","east","independent"]) then {
                    private _key = _x getVariable ["TYR_emplacementKey",""];
                    private _kind = if (_key isEqualTo "") then {"vehicle"} else {"emplacement"};
                    private _display = getText (configFile >> "CfgVehicles" >> typeOf _x >> "displayName");
                    _entities pushBack [_kind,_fid,typeOf _x,_display,getPosATL _x,getDir _x,alive _x,damage _x,_key];
                };
            };
        } forEach vehicles;

        private _forces = [];
        {
            private _rec = (TYR_State get "forces") get _x;
            private _grp = (TYR_Runtime get "forces") getOrDefault [_x,grpNull];
            private _pos = +(_rec getOrDefault ["position",[]]);
            private _unitCount = 0;
            if (!isNull _grp) then {
                private _aliveUnits = (units _grp) select {alive _x};
                _unitCount = count _aliveUnits;
                if (_unitCount > 0) then {_pos = getPosATL leader _grp};
            };
            _forces pushBack [
                _x,
                _rec getOrDefault ["faction",""],
                _rec getOrDefault ["role","unknown"],
                _rec getOrDefault ["operation",""],
                _pos,
                _unitCount,
                _rec getOrDefault ["active",true]
            ];
        } forEach keys (TYR_State get "forces");

        private _aiTraces = [];
        private _traceMap = TYR_Runtime getOrDefault ["aiDecisionTraces",createHashMap];
        {
            private _traceRecord = _traceMap getOrDefault [_x,createHashMap];
            _aiTraces pushBack [
                _x,
                _traceRecord getOrDefault ["started",-1],
                _traceRecord getOrDefault ["finished",-1],
                _traceRecord getOrDefault ["currentStep",0],
                +(_traceRecord getOrDefault ["nodes",[]]),
                +(_traceRecord getOrDefault ["candidates",[]]),
                _traceRecord getOrDefault ["decision",""],
                _traceRecord getOrDefault ["posture","hold"]
            ];
        } forEach ["west","east","independent"];

        private _commandNetworks = [];
        private _commandPersonnel = TYR_State getOrDefault ["commandPersonnel",createHashMap];
        private _runtimeCommand = TYR_Runtime getOrDefault ["commandPersonnel",createHashMap];
        private _allForces = TYR_State getOrDefault ["forces",createHashMap];
        private _runtimeForces = TYR_Runtime getOrDefault ["forces",createHashMap];
        private _orders = TYR_State getOrDefault ["commandOrders",createHashMap];
        {
            private _fid = _x;
            private _network = [_fid] call TYR_fnc_CommandNetworkGet;
            private _nodes = [];
            private _links = [];
            private _nodeIds = [];
            {
                private _id = _x;
                private _rec = _commandPersonnel get _id;
                if ((_rec getOrDefault ["faction",""]) isEqualTo _fid) then {
                    private _obj = _runtimeCommand getOrDefault [_id,objNull];
                    private _pos = +(_rec getOrDefault ["position",[]]);
                    if (!isNull _obj) then {_pos = getPosATL _obj};
                    _nodes pushBack [_id,_rec getOrDefault ["role","officer"],_rec getOrDefault ["name",_id],_pos,_rec getOrDefault ["alive",false],""];
                    _nodeIds pushBack _id;
                };
            } forEach keys _commandPersonnel;

            private _mainId = _network getOrDefault ["main",""];
            {
                if (_mainId isNotEqualTo "" && {_x isNotEqualTo _mainId}) then {_links pushBack [_mainId,_x,"command"]};
            } forEach (_network getOrDefault ["officers",[]]);

            {
                private _forceId = _x;
                private _fr = _allForces get _forceId;
                if ((_fr getOrDefault ["faction",""]) isEqualTo _fid && {_fr getOrDefault ["active",true]}) then {
                    private _grp = _runtimeForces getOrDefault [_forceId,grpNull];
                    private _pos = +(_fr getOrDefault ["position",[]]);
                    private _alive = false;
                    if (!isNull _grp && {count units _grp > 0}) then {
                        private _ldr = leader _grp;
                        _pos = getPosATL _ldr;
                        _alive = alive _ldr;
                    };
                    private _nodeId = format ["force:%1",_forceId];
                    _nodes pushBack [_nodeId,"force_commander",format ["FORCE %1",toUpper _forceId],_pos,_alive,_fr getOrDefault ["commandState","local"]];
                    _nodeIds pushBack _nodeId;
                    private _route = _fr getOrDefault ["commandOfficer",""];
                    if (_route isNotEqualTo "") then {_links pushBack [_route,_nodeId,_fr getOrDefault ["commandState","local"]]};
                };
            } forEach keys _allForces;

            private _pending = 0;
            {
                private _order = _orders get _x;
                if ((_order getOrDefault ["faction",""]) isEqualTo _fid) then {_pending = _pending + 1};
            } forEach keys _orders;
            _commandNetworks pushBack [
                _fid,_network getOrDefault ["status","forming"],_network getOrDefault ["collapseSince",-1],
                _network getOrDefault ["replacementAt",-1],_nodes,_links,_pending
            ];
        } forEach ["west","east","independent"];

        private _aiOperations = [];
        private _operations = TYR_State getOrDefault ["operations",createHashMap];
        {
            private _op = _operations get _x;
            if !((_op getOrDefault ["phase",""]) in ["complete","failed"]) then {
                private _targetPos = +(_op getOrDefault ["targetPosition",[]]);
                private _targetName = _op getOrDefault ["targetName",_op getOrDefault ["target",""]];
                if ((_op getOrDefault ["targetType","location"]) isEqualTo "location") then {
                    private _loc = [_op getOrDefault ["target",""]] call TYR_fnc_StateGetLocation;
                    if (count _loc > 0) then {
                        _targetPos = +(_loc getOrDefault ["position",_targetPos]);
                        _targetName = _loc getOrDefault ["name",_targetName];
                    };
                };
                _aiOperations pushBack [
                    _x,_op getOrDefault ["faction",""],_op getOrDefault ["type","attack"],_op getOrDefault ["phase",""],
                    _op getOrDefault ["targetType","location"],_op getOrDefault ["target",""],_targetName,_targetPos,
                    +(_op getOrDefault ["forces",[]]),_op getOrDefault ["score",0],_op getOrDefault ["reason",""],
                    _op getOrDefault ["created",0],_op getOrDefault ["orderId",""]
                ];
            };
        } forEach keys _operations;

        private _debugOrders = [];
        {
            private _order = _orders get _x;
            _debugOrders pushBack [
                _x,_order getOrDefault ["faction",""],_order getOrDefault ["force",""],_order getOrDefault ["operation",""],
                _order getOrDefault ["target",""],_order getOrDefault ["issuedAt",0],_order getOrDefault ["deliverAt",0],
                _order getOrDefault ["status","pending"],+(_order getOrDefault ["route",[]]),_order getOrDefault ["reroutes",0]
            ];
        } forEach keys _orders;

        [_player,"TYR_fnc_ClientDebugMapData",[[serverTime,_locations,_factions,_entities,_forces,_aiTraces,_commandNetworks,_aiOperations,_debugOrders]]] call TYR_fnc_ServerSendToPlayer;
    };
    case "command": {
        private _code = _args param [0,""];
        if (_code isEqualType "" && {_code isNotEqualTo ""}) then {
            if ((count _code) > 8000) then {_code = _code select [0,8000]};
            diag_log format ["[TYRANTS DEBUG COMMAND][SERVER][%1] %2",name _player,_code];
            private _result = call compile _code;
            private _resultText = str _result;
            diag_log format ["[TYRANTS DEBUG COMMAND][SERVER] RESULT %1",_resultText];
            [_player,"TYR_fnc_ClientDebugCommandResult",["SERVER",_resultText,_code]] call TYR_fnc_ServerSendToPlayer;
        };
    };
    case "save": {[true] call TYR_fnc_PersistenceSave};
    case "sync": {
        {[_x,0] call TYR_fnc_ServerPublishFaction} forEach ([false] call TYR_fnc_FactionIds);
        {[_x,0] call TYR_fnc_ServerPublishLocation} forEach keys (TYR_State get "locations");
    };
};
[_player,"TYR_fnc_ClientDebugState",[TYR_Runtime getOrDefault ["saveGeneration",0],diag_fps]] call TYR_fnc_ServerSendToPlayer;
