params ["_locationId"];
if (!isServer) exitWith {};
if (((TYR_State get "campaign") getOrDefault ["phase","deployment"]) isNotEqualTo "running") exitWith {};
private _owner = remoteExecutedOwner;
private _player = [_owner] call TYR_fnc_FindPlayerByOwner;
if (isNull _player) exitWith {};
private _fid = [side _player] call TYR_fnc_SideFaction;
private _l = [_locationId] call TYR_fnc_StateGetLocation;
if (count _l isEqualTo 0) exitWith {};
if ((_l getOrDefault ["owner","neutral"]) isEqualTo _fid) exitWith {};
private _range = ((TYR_State get "campaign") get "settings") getOrDefault ["captureRange",175];
if (_player distance2D (_l get "position") > _range) exitWith {};
private _sessions = TYR_Runtime get "captureSessions";
if (_locationId in keys _sessions) exitWith {};
_sessions set [_locationId,createHashMapFromArray [
    ["location",_locationId],["attacker",_fid],["owner",_owner],["progress",0],["last",serverTime]
]];
[_player,"TYR_fnc_ClientHint",[format ["Capture started: %1",_l get "name"]]] call TYR_fnc_ServerSendToPlayer;
