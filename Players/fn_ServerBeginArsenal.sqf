if (!isServer) exitWith {};
private _owner = remoteExecutedOwner;
private _player = [_owner] call TYR_fnc_FindPlayerByOwner;
if (isNull _player) exitWith {};
private _fid = [side _player] call TYR_fnc_SideFaction;
private _f = [_fid] call TYR_fnc_StateGetFaction;
if (count _f isEqualTo 0 || {!(_f getOrDefault ["active",false])}) exitWith {};
private _base = _f getOrDefault ["basePosition",[]];
if (count _base < 2 || {_player distance2D _base > 25}) exitWith {
    [_player,"TYR_fnc_ClientHint",["Move to your faction HQ supply crate to use the Arsenal."]] call TYR_fnc_ServerSendToPlayer;
};
private _pending = TYR_Runtime getOrDefault ["arsenal",createHashMap];
_pending set [str _owner,getUnitLoadout _player];
TYR_Runtime set ["arsenal",_pending];
[_player,"TYR_fnc_ClientOpenArsenal",[]] call TYR_fnc_ServerSendToPlayer;
