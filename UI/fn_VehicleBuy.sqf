params ["_class"];
if (_class isEqualTo "") exitWith {};
[_class] remoteExecCall ["TYR_fnc_ServerPurchaseVehicle",2];
