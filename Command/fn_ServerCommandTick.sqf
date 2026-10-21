if (!isServer) exitWith {};
private _personnel = TYR_State getOrDefault ["commandPersonnel",createHashMap];
private _runtime = TYR_Runtime getOrDefault ["commandPersonnel",createHashMap];
private _forces = TYR_State getOrDefault ["forces",createHashMap];

{
    private _fid = _x;
    private _f = [_fid] call TYR_fnc_StateGetFaction;
    if ((_f getOrDefault ["active",false]) && {!(_f getOrDefault ["eliminated",false])}) then {
        [_fid] call TYR_fnc_ServerCommandCreate;
        private _network = [_fid] call TYR_fnc_CommandNetworkGet;
        private _oldStatus = _network getOrDefault ["status","forming"];
        private _mainId = _network getOrDefault ["main",""];
        private _officerIds = +(_network getOrDefault ["officers",[]]);

        // Keep living command personnel physical. If an alive record lost its runtime
        // object for a technical reason, restore that object rather than silently deleting the node.
        {
            private _rec = _personnel getOrDefault [_x,createHashMap];
            if (count _rec > 0 && {_rec getOrDefault ["alive",false]}) then {
                private _obj = _runtime getOrDefault [_x,objNull];
                if (isNull _obj) then {_obj = [_x] call TYR_fnc_ServerCommandSpawnPerson};
                if (!isNull _obj && {alive _obj}) then {_rec set ["position",getPosATL _obj]};
                if (!isNull _obj && {!alive _obj}) then {[_x,_obj] call TYR_fnc_ServerCommandPersonKilled};
            };
        } forEach ([_mainId] + _officerIds);

        private _mainRec = _personnel getOrDefault [_mainId,createHashMap];
        private _mainObj = _runtime getOrDefault [_mainId,objNull];
        private _mainAlive = _mainId isNotEqualTo "" && {_mainRec getOrDefault ["alive",false]} && {!isNull _mainObj} && {alive _mainObj};
        private _aliveOfficers = _officerIds select {
            private _r = _personnel getOrDefault [_x,createHashMap];
            private _obj = _runtime getOrDefault [_x,objNull];
            _r getOrDefault ["alive",false] && {!isNull _obj} && {alive _obj}
        };
        private _status = _oldStatus;

        if (!_mainAlive && {count _aliveOfficers > 0}) then {
            _status = "succession";
            private _successionAt = _network getOrDefault ["successionAt",-1];
            if (_successionAt < 0) then {_successionAt = serverTime + 30; _network set ["successionAt",_successionAt]};
            if (serverTime >= _successionAt) then {
                private _ranked = [];
                {
                    private _r = _personnel get _x;
                    _ranked pushBack [-(_r getOrDefault ["rank",0]),_x];
                } forEach _aliveOfficers;
                _ranked sort true;
                private _successorId = (_ranked # 0) # 1;
                private _successor = _personnel get _successorId;
                _successor set ["role","commander"];
                _successor set ["rank",100];
                _network set ["main",_successorId];
                _network set ["officers",_officerIds - [_successorId]];
                _network set ["successionAt",-1];
                private _obj = _runtime getOrDefault [_successorId,objNull];
                if (!isNull _obj) then {_obj setVariable ["TYR_commandRole","commander",true]};
                _mainId = _successorId;
                _mainAlive = true;
                _aliveOfficers = _aliveOfficers - [_successorId];
                _status = if (count _aliveOfficers >= 2) then {"operational"} else {if (count _aliveOfficers > 0) then {"degraded"} else {"isolated"}};
                _network set ["replacementAt",serverTime + 180];
                ["command-succession",true] call TYR_fnc_StateMarkDirty;
                diag_log format ["[TYRANTS COMMAND] %1 succession complete: %2 is now main commander.",toUpper _fid,_successor getOrDefault ["name",_successorId]];
            };
        };

        if (_mainAlive) then {
            _network set ["collapseSince",-1];
            _network set ["successionAt",-1];
            _status = if (count _aliveOfficers >= 2) then {"operational"} else {if (count _aliveOfficers > 0) then {"degraded"} else {"isolated"}};

            private _target = _network getOrDefault ["targetOfficers",3];
            if (count _aliveOfficers < _target) then {
                private _replaceAt = _network getOrDefault ["replacementAt",-1];
                if (_replaceAt < 0) then {_replaceAt = serverTime + 180; _network set ["replacementAt",_replaceAt]};
                if (serverTime >= _replaceAt) then {
                    private _res = _f get "resources";
                    if ((_res getOrDefault ["manpower",0]) >= 2) then {
                        _res set ["manpower",(_res get "manpower") - 2];
                        private _newId = ["cmd"] call TYR_fnc_StateNextId;
                        private _serial = (count _officerIds) + 1;
                        private _name = format ["REPLACEMENT OFFICER %1",_serial];
                        private _base = _f getOrDefault ["basePosition",[]];
                        _personnel set [_newId,createHashMapFromArray [
                            ["id",_newId],["faction",_fid],["role","officer"],["name",_name],["rank",50],
                            ["alive",true],["position",+_base],["class",""],["createdAt",serverTime],["deathAt",-1]
                        ]];
                        _officerIds pushBack _newId;
                        _network set ["officers",_officerIds];
                        [_newId] call TYR_fnc_ServerCommandSpawnPerson;
                        _network set ["replacementAt",if (count _aliveOfficers + 1 < _target) then {serverTime + 180} else {-1}];
                        ["command-officer-replacement",true] call TYR_fnc_StateMarkDirty;
                    } else {
                        _network set ["replacementAt",serverTime + 60];
                    };
                };
            } else {
                _network set ["replacementAt",-1];
            };
        } else {
            if (count _aliveOfficers isEqualTo 0) then {
                _status = "collapsed";
                private _collapseSince = _network getOrDefault ["collapseSince",-1];
                if (_collapseSince < 0) then {
                    _collapseSince = serverTime;
                    _network set ["collapseSince",_collapseSince];
                    _network set ["replacementAt",serverTime + 120];
                    ["command-collapse",true] call TYR_fnc_StateMarkDirty;
                };

                private _replaceAt = _network getOrDefault ["replacementAt",-1];
                if (_replaceAt > 0 && {serverTime >= _replaceAt}) then {
                    private _baseRec = (TYR_Runtime getOrDefault ["bases",createHashMap]) getOrDefault [_fid,createHashMap];
                    private _box = _baseRec getOrDefault ["box",objNull];
                    private _res = _f get "resources";
                    if (!isNull _box && {(_res getOrDefault ["manpower",0]) >= 5}) then {
                        _res set ["manpower",(_res get "manpower") - 5];
                        private _newId = ["cmd"] call TYR_fnc_StateNextId;
                        private _base = _f getOrDefault ["basePosition",[]];
                        _personnel set [_newId,createHashMapFromArray [
                            ["id",_newId],["faction",_fid],["role","commander"],["name","EMERGENCY COMMANDER"],["rank",100],
                            ["alive",true],["position",+_base],["class",""],["createdAt",serverTime],["deathAt",-1]
                        ]];
                        _network set ["main",_newId];
                        _network set ["collapseSince",-1];
                        _network set ["replacementAt",serverTime + 180];
                        [_newId] call TYR_fnc_ServerCommandSpawnPerson;
                        _status = "isolated";
                        ["command-emergency-replacement",true] call TYR_fnc_StateMarkDirty;
                    } else {
                        _network set ["replacementAt",serverTime + 60];
                    };
                };

                if ((_network getOrDefault ["collapseSince",-1]) >= 0 && {serverTime - (_network get "collapseSince") >= 240}) then {
                    if ([_fid,"command-collapse"] call TYR_fnc_ServerVictoryEvaluate) then {_status = "eliminated"};
                };
            };
        };

        if (_status isNotEqualTo _oldStatus) then {
            _network set ["status",_status];
            _network set ["lastStatusChange",serverTime];
            ["command-status"] call TYR_fnc_StateMarkDirty;
            [_fid] call TYR_fnc_ServerPublishFaction;
            diag_log format ["[TYRANTS COMMAND] %1 network %2 -> %3",toUpper _fid,toUpper _oldStatus,toUpper _status];
        } else {
            _network set ["status",_status];
        };

        {
            private _fr = _forces get _x;
            if ((_fr getOrDefault ["faction",""]) isEqualTo _fid && {_fr getOrDefault ["active",true]}) then {[_x] call TYR_fnc_ServerCommandAssignForce};
        } forEach keys _forces;
    };
} forEach ["west","east","independent"];

call TYR_fnc_ServerCommandDeliverOrders;
