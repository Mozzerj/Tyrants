params ["_key"];
if (!isServer) exitWith {};
private _owner = remoteExecutedOwner;
private _player = [_owner] call TYR_fnc_FindPlayerByOwner;
if (isNull _player) exitWith {};
private _result = [[side _player] call TYR_fnc_SideFaction,_key] call TYR_fnc_ResearchPurchase;
[_player,"TYR_fnc_ClientHint",[_result # 1]] call TYR_fnc_ServerSendToPlayer;
