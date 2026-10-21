params ["_vehicle"];
if (!isServer || {isNull _vehicle}) exitWith {};
private _jobId = _vehicle getVariable ["TYR_logisticsId",""];
private _role = _vehicle getVariable ["TYR_logisticsRole",""];
if (_jobId isEqualTo "") exitWith {};
private _job = (TYR_State getOrDefault ["logistics",createHashMap]) getOrDefault [_jobId,createHashMap];
if (count _job isEqualTo 0) exitWith {};
if (_role isEqualTo "cargo") then {
    _job set ["status","destroyed"];
    _job set ["cargoAlive",false];
    _job set ["finishedAt",serverTime];
    _job set ["lastStateChange",serverTime];
} else {
    _job set ["escortAlive",false];
};
["logistics-loss",true] call TYR_fnc_StateMarkDirty;
