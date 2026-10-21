if (!isServer) exitWith {};

private _caller = [remoteExecutedOwner] call TYR_fnc_FindPlayerByOwner;
if (isNull _caller) exitWith {};
private _uid = getPlayerUID _caller;
private _sideIndex = [west, east] find (side _caller);
if (_uid isEqualTo "" || {_sideIndex < 0}) exitWith {};

private _players = GameData # 0 # 3;
private _playerIndex = _players findIf {(_x # 0) isEqualTo _uid};
private _baselineKey = format ["TYR_arsenalBaseline_%1", remoteExecutedOwner];
private _before = missionNamespace getVariable [_baselineKey, []];
missionNamespace setVariable [_baselineKey, nil];

if (count _before < 10 && {_playerIndex >= 0}) then {
    _before = +(_players # _playerIndex);
};
if (count _before < 10) exitWith {};

private _after = [_caller] call TYR_fnc_GetUnitProfile;
if (count _after < 10) exitWith {};

private _oldValue = [_before] call TYR_fnc_GetLoadoutValue;
private _newValue = [_after] call TYR_fnc_GetLoadoutValue;
private _delta = _oldValue - _newValue;
private _ammo = GameData # 0 # (_sideIndex + 1) # 2;

if (_ammo + _delta < 0) exitWith {
    if (_playerIndex < 0) then {_players pushBack +_before} else {_players set [_playerIndex, +_before]};
    [_before] remoteExecCall ["TYR_fnc_ApplyPlayerLoadout", remoteExecutedOwner];
    [format ["Loadout costs %1 ammo; only %2 is available.", round (-_delta), round _ammo]] remoteExecCall ["TYR_fnc_ClientHint", remoteExecutedOwner];
    [] call TYR_fnc_ServerBroadcastState;
};

GameData # 0 # (_sideIndex + 1) set [2, _ammo + _delta];
if (_playerIndex < 0) then {_players pushBack +_after} else {_players set [_playerIndex, +_after]};

[] call TYR_fnc_ServerBroadcastState;
[] call TYR_fnc_ServerSaveState;
[format ["Loadout change: %1 ammo. Remaining: %2", round _delta, round (_ammo + _delta)]] remoteExecCall ["TYR_fnc_ClientHint", remoteExecutedOwner];
