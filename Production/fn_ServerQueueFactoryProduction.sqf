params ["_factoryId","_productId"];
if (!isServer) exitWith {};
private _owner = remoteExecutedOwner;
private _player = [_owner] call TYR_fnc_FindPlayerByOwner;
if (isNull _player) exitWith {};
private _fid = [side _player] call TYR_fnc_SideFaction;
private _loc = [_factoryId] call TYR_fnc_StateGetLocation;
if (count _loc isEqualTo 0 || {_player distance2D (_loc getOrDefault ["position",[0,0,0]]) > 120}) exitWith {
    [_player,"TYR_fnc_ClientHint",["Move within 120m of the factory to change its production queue."]] call TYR_fnc_ServerSendToPlayer;
};
private _r = [_fid,_factoryId,_productId,"Human production selection",name _player] call TYR_fnc_ProductionQueue;
[_player,"TYR_fnc_ClientHint",[_r # 1]] call TYR_fnc_ServerSendToPlayer;
