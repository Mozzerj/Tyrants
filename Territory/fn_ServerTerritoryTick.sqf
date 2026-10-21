if (!isServer) exitWith {};
private _sessions = TYR_Runtime get "captureSessions";
if (count keys _sessions isEqualTo 0) exitWith {};
private _settings = (TYR_State get "campaign") get "settings";
private _range = _settings getOrDefault ["captureRange",175];
private _required = _settings getOrDefault ["captureTime",90];
private _remove = [];

{
    private _id = _x;
    private _s = _sessions get _id;
    private _l = [_id] call TYR_fnc_StateGetLocation;
    if (count _l isEqualTo 0) then {_remove pushBack _id} else {
        private _pos = _l get "position";
        private _attacker = _s get "attacker";
        private _near = _pos nearEntities [["Man","LandVehicle"],_range];
        private _present = createHashMapFromArray [["west",0],["east",0],["independent",0]];
        {
            private _side = if (_x isKindOf "Man") then {side group _x} else {side _x};
            private _fid = [_side] call TYR_fnc_SideFaction;
            if (_fid in ["west","east","independent"] && {alive _x}) then {
                _present set [_fid,(_present get _fid)+1];
            };
        } forEach _near;
        private _attackCount = _present getOrDefault [_attacker,0];
        private _enemyCount = 0;
        {
            if (_x isNotEqualTo _attacker) then {_enemyCount = _enemyCount + (_present getOrDefault [_x,0])};
        } forEach ["west","east","independent"];
        private _delta = (serverTime - (_s getOrDefault ["last",serverTime])) max 0 min 2;
        _s set ["last",serverTime];
        private _owner = _s getOrDefault ["owner",-1];
        private _capturePlayer = [_owner] call TYR_fnc_FindPlayerByOwner;

        if (_attackCount <= 0) then {
            if (!isNull _capturePlayer) then {[_capturePlayer,"TYR_fnc_ClientCaptureStatus",[_l get "name",_s get "progress",_required,"cancelled"]] call TYR_fnc_ServerSendToPlayer};
            _remove pushBack _id;
        } else {
            if (_enemyCount > 0) then {
                if (!isNull _capturePlayer) then {[_capturePlayer,"TYR_fnc_ClientCaptureStatus",[_l get "name",_s get "progress",_required,"contested"]] call TYR_fnc_ServerSendToPlayer};
            } else {
                private _p = (_s getOrDefault ["progress",0]) + _delta;
                _s set ["progress",_p];
                if (!isNull _capturePlayer) then {[_capturePlayer,"TYR_fnc_ClientCaptureStatus",[_l get "name",_p,_required,"capturing"]] call TYR_fnc_ServerSendToPlayer};
                if (_p >= _required) then {
                    _l set ["owner",_attacker];
                    _l set ["stock",0];
                    [_id] call TYR_fnc_ServerPublishLocation;
                    ["territory-capture",true] call TYR_fnc_StateMarkDirty;
                    if (!isNull _capturePlayer) then {[_capturePlayer,"TYR_fnc_ClientCaptureStatus",[_l get "name",_p,_required,"complete"]] call TYR_fnc_ServerSendToPlayer};
                    _remove pushBack _id;
                };
            };
        };
    };
} forEach keys _sessions;
{_sessions deleteAt _x} forEach _remove;
