params ["_publicFaction"];
if !(_publicFaction isEqualType [] && {count _publicFaction >= 6}) exitWith {};
if (isNil "TYR_ClientState") then {TYR_ClientState = createHashMapFromArray [["factions",createHashMap],["locations",createHashMap]]};
private _factions = TYR_ClientState get "factions";
_factions set [_publicFaction # 0,_publicFaction];
if (!isNull findDisplay 1200) then {[] call TYR_fnc_PlayerMenuRefresh};
if (!isNull findDisplay 1700) then {[] call TYR_fnc_DebugMenuRefresh};
if (!isNull findDisplay 1205) then {[] call TYR_fnc_ResearchMenuUpdate};
