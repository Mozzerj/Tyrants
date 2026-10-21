params ["_sideIndex"];
if (!isServer) exitWith {};
if !(_sideIndex in [0, 1]) exitWith {};

private _caller = [remoteExecutedOwner] call TYR_fnc_FindPlayerByOwner;
if (isNull _caller) exitWith {};
if ((side _caller) isNotEqualTo ([west, east] # _sideIndex)) exitWith {};

private _accountant = missionNamespace getVariable [["WestAccountant", "EastAccountant"] # _sideIndex, objNull];
if (isNull _accountant || {_caller distance2D _accountant > 5}) exitWith {};
_accountant attachTo [_caller, [0, 3, 0]];
