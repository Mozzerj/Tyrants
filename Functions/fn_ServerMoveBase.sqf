params ["_sideIndex", "_position"];
if (!isServer) exitWith {};
if !(_sideIndex in [0, 1]) exitWith {};

private _caller = [remoteExecutedOwner] call TYR_fnc_FindPlayerByOwner;
if (isNull _caller) exitWith {};
if ((side _caller) isNotEqualTo ([west, east] # _sideIndex)) exitWith {};
if ((_caller distance2D _position) > 10) exitWith {};

private _accountant = missionNamespace getVariable [["WestAccountant", "EastAccountant"] # _sideIndex, objNull];
private _box = missionNamespace getVariable [["WestBox", "EastBox"] # _sideIndex, objNull];
if (isNull _accountant || {isNull _box}) exitWith {};

detach _accountant;
GameData # 0 # (_sideIndex + 1) set [0, +_position];
_accountant setPosATL _position;
_box setPosATL (_position vectorAdd [2, 0, 0]);
private _markerName = ["respawn_west", "respawn_east"] # _sideIndex;
_markerName setMarkerPos _position;

[] call TYR_fnc_ServerBroadcastState;
[] call TYR_fnc_ServerSaveState;
