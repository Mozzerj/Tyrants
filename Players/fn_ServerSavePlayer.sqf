if (!isServer) exitWith {};
private _owner = remoteExecutedOwner;
private _player = [_owner] call TYR_fnc_FindPlayerByOwner;
if (isNull _player) exitWith {};
private _uid = getPlayerUID _player;
if (_uid isEqualTo "") exitWith {};
private _players = TYR_State get "players";
private _rec = _players getOrDefault [_uid,createHashMap];
private _fid = [side _player] call TYR_fnc_SideFaction;
private _pos = getPosATL _player;
_rec set ["uid",_uid];
_rec set ["faction",_fid];
if ([_pos] call TYR_fnc_IsValidLandPosition) then {
    _rec set ["position",[_pos # 0,_pos # 1,0.2]];
};
_rec set ["direction",getDir _player];
_rec set ["loadout",getUnitLoadout _player];
_players set [_uid,_rec];
["player"] call TYR_fnc_StateMarkDirty;
