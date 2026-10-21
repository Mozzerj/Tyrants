params ["_publicLocation"];
if !(_publicLocation isEqualType [] && {count _publicLocation >= 5}) exitWith {};
if (isNil "TYR_ClientState") then {TYR_ClientState = createHashMapFromArray [["factions",createHashMap],["locations",createHashMap]]};
(TYR_ClientState get "locations") set [_publicLocation # 0,_publicLocation];
