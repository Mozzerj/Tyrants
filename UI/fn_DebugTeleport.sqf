params ["_factionId"];
if (isNil "TYR_ClientState") exitWith {};
private _f = (TYR_ClientState get "factions") getOrDefault [_factionId,[]];
if (count _f >= 5 && {count (_f # 4) >= 2}) then {player setPosATL ((_f # 4) vectorAdd [5,5,0])};
