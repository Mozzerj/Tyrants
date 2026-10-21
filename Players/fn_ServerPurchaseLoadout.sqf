params ["_after"];
if (!isServer) exitWith {};
private _owner = remoteExecutedOwner;
private _player = [_owner] call TYR_fnc_FindPlayerByOwner;
if (isNull _player || {!(_after isEqualType [])}) exitWith {};
private _pending = TYR_Runtime getOrDefault ["arsenal",createHashMap];
private _key = str _owner;
private _before = _pending getOrDefault [_key,[]];
_pending deleteAt _key;
if (count _before isEqualTo 0) exitWith {
    [_player,"TYR_fnc_ClientHint",["Arsenal transaction expired. Re-open it from your HQ."]] call TYR_fnc_ServerSendToPlayer;
};
private _fid = [side _player] call TYR_fnc_SideFaction;
private _f = [_fid] call TYR_fnc_StateGetFaction;
if (count _f isEqualTo 0) exitWith {[_player,"TYR_fnc_ClientApplyLoadout",[_before]] call TYR_fnc_ServerSendToPlayer};
private _resources = _f get "resources";
private _beforeCost = [_before] call TYR_fnc_LoadoutCost;
private _afterCost = [_after] call TYR_fnc_LoadoutCost;
private _price = (_afterCost - _beforeCost) max 0;
private _ammo = _resources getOrDefault ["ammo",0];
if (_price > _ammo) exitWith {
    [_player,"TYR_fnc_ClientApplyLoadout",[_before]] call TYR_fnc_ServerSendToPlayer;
    [_player,"TYR_fnc_ClientHint",[format ["Arsenal purchase rejected. Need %1 ammo resources.",_price]]] call TYR_fnc_ServerSendToPlayer;
};
if (_price > 0) then {
    _resources set ["ammo",_ammo - _price];
    ["arsenal"] call TYR_fnc_StateMarkDirty;
    [_fid] call TYR_fnc_ServerPublishFaction;
};
