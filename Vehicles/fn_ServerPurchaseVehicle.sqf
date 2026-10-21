params ["_class"];
if (!isServer) exitWith {};
private _owner = remoteExecutedOwner;
private _player = [_owner] call TYR_fnc_FindPlayerByOwner;
if (isNull _player) exitWith {};
private _fid = [side _player] call TYR_fnc_SideFaction;
private _result = [_fid,_class,false] call TYR_fnc_VehiclePurchase;
[_player,"TYR_fnc_ClientHint",[_result # 1]] call TYR_fnc_ServerSendToPlayer;
