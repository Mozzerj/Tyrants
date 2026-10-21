params ["_sideIndex", "_position"];
if (!isServer) exitWith {};
if !(_sideIndex in [0, 1]) exitWith {};
if !(_position isEqualType [] && {count _position >= 2}) exitWith {};

private _caller = [remoteExecutedOwner] call TYR_fnc_FindPlayerByOwner;
if (isNull _caller) exitWith {};
private _expectedSide = [west, east] # _sideIndex;
if ((side _caller) isNotEqualTo _expectedSide) exitWith {};

private _x = _position # 0;
private _y = _position # 1;
if (_x < 0 || {_x > worldSize} || {_y < 0} || {_y > worldSize} || {surfaceIsWater [_x, _y]}) exitWith {};
private _divider = [] call TYR_fnc_GetDividerLine;
private _lineY = (_divider # 0) * _x + (_divider # 1);
private _validTerritory = (_sideIndex isEqualTo 0 && {_y < _lineY}) || (_sideIndex isEqualTo 1 && {_y > _lineY});
if (!_validTerritory) exitWith {};

private _commander = if (_sideIndex isEqualTo 0) then {
    missionNamespace getVariable ["commanderWest", objNull]
} else {
    missionNamespace getVariable ["commanderEast", objNull]
};
if (isPlayer _commander && {_caller isNotEqualTo _commander}) exitWith {};
if ((GameData # 0 # (_sideIndex + 1) # 0) isNotEqualTo 0) exitWith {};

GameData # 0 # (_sideIndex + 1) set [0, +_position];
[] call TYR_fnc_ServerBroadcastState;
[] call TYR_fnc_ServerSaveState;
diag_log format ["[TYRANTS] Base position set for side %1 by %2", _sideIndex, name _caller];
