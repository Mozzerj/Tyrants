params [["_role","infantry"]];
if (!isServer) exitWith {};
private _owner = remoteExecutedOwner;
private _player = [_owner] call TYR_fnc_FindPlayerByOwner;
if (isNull _player) exitWith {};
private _fid = [side _player] call TYR_fnc_SideFaction;
private _id = [_fid,_role,false] call TYR_fnc_AIForceCreate;
if (_id isEqualTo "") then {
    [_player,"TYR_fnc_ClientHint",["Unable to deploy force: insufficient faction resources/manpower."]] call TYR_fnc_ServerSendToPlayer;
} else {
    [_player,"TYR_fnc_ClientHint",[format ["Force %1 deployed at HQ.",_id]]] call TYR_fnc_ServerSendToPlayer;
};
