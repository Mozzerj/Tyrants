params ["_veh"];
if (!isServer || {isNull _veh}) exitWith {};
private _id = _veh getVariable ["TYR_persistentId",""];
if (_id isEqualTo "") exitWith {};
(TYR_State get "vehicles") deleteAt _id;
(TYR_Runtime get "vehicles") deleteAt _id;
["vehicle-killed"] call TYR_fnc_StateMarkDirty;
