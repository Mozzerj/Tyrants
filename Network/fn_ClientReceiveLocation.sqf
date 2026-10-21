params ["_publicLocation"];
if !(_publicLocation isEqualType [] && {count _publicLocation >= 5}) exitWith {};
if (isNil "TYR_ClientState") then {TYR_ClientState = createHashMapFromArray [["factions",createHashMap],["locations",createHashMap]]};
(TYR_ClientState get "locations") set [_publicLocation # 0,_publicLocation];
private _received = missionNamespace getVariable ["TYR_ClientLocationReceivedAt",createHashMap];
_received set [_publicLocation # 0,diag_tickTime];
missionNamespace setVariable ["TYR_ClientLocationReceivedAt",_received];
missionNamespace setVariable ["TYR_ClientLocationRevision",(missionNamespace getVariable ["TYR_ClientLocationRevision",0]) + 1];

if (!isNull findDisplay 1450) then {[] call TYR_fnc_FactoryMenuRefresh};
