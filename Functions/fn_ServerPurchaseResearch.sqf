params ["_researchKey"];
if (!isServer) exitWith {};
if !(_researchKey isEqualType "") exitWith {};

private _ownerId = remoteExecutedOwner;
private _caller = [_ownerId] call TYR_fnc_FindPlayerByOwner;
if (isNull _caller) exitWith {};
private _sideIndex = [west, east] find (side _caller);
if (_sideIndex < 0) exitWith {};

private _matches = ([] call TYR_fnc_GetResearchDefinitions) select {(_x # 0) isEqualTo _researchKey};
if (_matches isEqualTo []) exitWith {};
private _definition = _matches # 0;

if ([_sideIndex, _researchKey] call TYR_fnc_IsResearchUnlocked) exitWith {
    ["That research is already unlocked."] remoteExecCall ["TYR_fnc_ClientHint", _ownerId];
};

private _missing = (_definition # 5) select {!([_sideIndex, _x] call TYR_fnc_IsResearchUnlocked)};
if !(_missing isEqualTo []) exitWith {
    ["Research prerequisites are not yet complete."] remoteExecCall ["TYR_fnc_ClientHint", _ownerId];
};

private _teamIndex = _sideIndex + 1;
private _team = GameData # 0 # _teamIndex;
private _steel = _team # 1;
private _cost = _definition # 4;
if (_steel < _cost) exitWith {
    [format ["Not enough steel. Needed: %1", _cost]] remoteExecCall ["TYR_fnc_ClientHint", _ownerId];
};

private _progress = +(_team param [5, [[0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0]]]);
private _branch = +(_progress # (_definition # 2));
_branch set [_definition # 3, 1];
_progress set [_definition # 2, _branch];
_team set [5, _progress];
_team set [1, _steel - _cost];
(GameData # 0) set [_teamIndex, _team];

[] call TYR_fnc_ServerBroadcastState;
[] call TYR_fnc_ServerSaveState;
[format ["Research complete: %1", _definition # 1]] remoteExecCall ["TYR_fnc_ClientHint", _ownerId];
