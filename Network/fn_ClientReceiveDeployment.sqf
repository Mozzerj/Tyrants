params ["_campaign","_factionArray"];
if (isNil "TYR_ClientState") then {TYR_ClientState = createHashMapFromArray [["campaign",[]],["factions",createHashMap],["locations",createHashMap]]};
TYR_ClientState set ["campaign",+_campaign];
private _factions = TYR_ClientState getOrDefault ["factions",createHashMap];
{if (_x isEqualType [] && {count _x > 0}) then {_factions set [_x # 0,_x]}} forEach _factionArray;
TYR_ClientState set ["factions",_factions];
if (!isNull findDisplay 1300) then {[] call TYR_fnc_DeploymentOverlayBuild; [] call TYR_fnc_DeploymentMenuRefresh};
