if (!isServer) exitWith {};
private _owner = remoteExecutedOwner;
private _player = [_owner] call TYR_fnc_FindPlayerByOwner;
if (isNull _player) exitWith {};
[_player,"TYR_fnc_ClientHint",["Factories now manufacture vehicles and ammunition. Use FACTORY PRODUCTION near a controlled factory."]] call TYR_fnc_ServerSendToPlayer;
