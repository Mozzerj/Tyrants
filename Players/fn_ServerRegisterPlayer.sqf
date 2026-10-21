if (!isServer) exitWith {};
private _owner = remoteExecutedOwner;
private _player = [_owner] call TYR_fnc_FindPlayerByOwner;
if (isNull _player) exitWith {};
private _uid = getPlayerUID _player;
if (_uid isEqualTo "") exitWith {};
private _fid = [side _player] call TYR_fnc_SideFaction;
if (_fid isEqualTo "") exitWith {
    [_player,"TYR_fnc_ClientHint",["Your slot is not assigned to a Tyrants faction."]] call TYR_fnc_ServerSendToPlayer;
};
private _f = [_fid] call TYR_fnc_StateGetFaction;
if (count _f isEqualTo 0 || {!(_f getOrDefault ["active",false])}) exitWith {
    [_player,"TYR_fnc_ClientHint",["That faction is disabled in this campaign."]] call TYR_fnc_ServerSendToPlayer;
};

private _players = TYR_State get "players";
private _existing = _players getOrDefault [_uid,createHashMap];
private _base = _f getOrDefault ["basePosition",[]];
if !([_base] call TYR_fnc_IsValidLandPosition) exitWith {
    diag_log format ["[TYRANTS SPAWN] Refused to restore %1 because faction %2 has an invalid HQ position: %3",_uid,_fid,_base];
    [_player,"TYR_fnc_ClientHint",["Your faction HQ position is invalid. Reset the campaign from lobby parameters or choose the HQ again."]] call TYR_fnc_ServerSendToPlayer;
};
private _new = count _existing isEqualTo 0 || {(_existing getOrDefault ["faction",_fid]) isNotEqualTo _fid};
private _preferred = if (_new) then {_base vectorAdd [5,5,0]} else {_existing getOrDefault ["position",[]]};
private _spawn = [_preferred,_base] call TYR_fnc_FindSafeSpawnPosition;
if (count _spawn < 2) exitWith {
    diag_log format ["[TYRANTS SPAWN] Could not resolve a safe spawn for %1 / %2. preferred=%3 base=%4",_uid,_fid,_preferred,_base];
    [_player,"TYR_fnc_ClientHint",["Tyrants could not find a safe land spawn near your HQ."]] call TYR_fnc_ServerSendToPlayer;
};
if (_new) then {
    _existing = createHashMapFromArray [
        ["uid",_uid],["faction",_fid],["position",_spawn],
        ["direction",0],["loadout",getUnitLoadout _player]
    ];
    _players set [_uid,_existing];
    ["player-register",true] call TYR_fnc_StateMarkDirty;
} else {
    if !([_preferred] call TYR_fnc_IsValidLandPosition) then {
        _existing set ["position",_spawn];
        ["player-position-repaired",true] call TYR_fnc_StateMarkDirty;
        diag_log format ["[TYRANTS SPAWN] Repaired invalid saved position for %1. New spawn: %2",_uid,_spawn];
    };
};
_existing set ["faction",_fid];
[_player,"TYR_fnc_ClientRestorePlayer",[
    _spawn,
    _existing getOrDefault ["direction",0],
    +(_existing getOrDefault ["loadout",[]])
]] call TYR_fnc_ServerSendToPlayer;
