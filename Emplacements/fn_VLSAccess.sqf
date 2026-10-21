params ["_owner","_emplacementId",["_range",25]];
if (!isServer || {_emplacementId isEqualTo ""}) exitWith {[]};
private _player = [_owner] call TYR_fnc_FindPlayerByOwner;
if (isNull _player) exitWith {[]};
private _fid = [side _player] call TYR_fnc_SideFaction;
private _e = (TYR_State get "emplacements") getOrDefault [_emplacementId,createHashMap];
if (count _e isEqualTo 0 || {(_e getOrDefault ["faction",""]) isNotEqualTo _fid} || {(_e getOrDefault ["key",""]) isNotEqualTo "vls"}) exitWith {[]};
private _obj = (TYR_Runtime get "emplacements") getOrDefault [_emplacementId,objNull];
if (isNull _obj || {!alive _obj} || {_player distance2D _obj > _range}) exitWith {[]};
[_player,_fid,_obj,_e]
