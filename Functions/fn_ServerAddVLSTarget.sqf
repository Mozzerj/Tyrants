params ["_position"];
if (!isServer) exitWith {};
if !(_position isEqualType [] && {count _position >= 2}) exitWith {};
private _ownerId = remoteExecutedOwner;
private _caller = [_ownerId] call TYR_fnc_FindPlayerByOwner;
if (isNull _caller) exitWith {};
private _sideIndex = [west, east] find (side _caller);
if (_sideIndex < 0) exitWith {};
if !([_sideIndex, "infra.offensive"] call TYR_fnc_IsResearchUnlocked) exitWith {};

private _targets = +(GameData # 0 # (_sideIndex + 1) param [6, []]);
if (count _targets >= 18) exitWith {["Maximum of 18 stored VLS targets."] remoteExecCall ["TYR_fnc_ClientHint", _ownerId];};
_targets pushBack [_position # 0, _position # 1, _position param [2, 0]];
GameData # 0 # (_sideIndex + 1) set [6, _targets];
[] call TYR_fnc_ServerBroadcastState;
[] call TYR_fnc_ServerSaveState;
