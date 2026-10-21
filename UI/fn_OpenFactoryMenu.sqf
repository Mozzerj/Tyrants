if (isNil "TYR_ClientState" || {isNil "TYR_PlayerFaction"}) exitWith {};
private _best = "";
private _dist = 1e9;
{
    private _l = _x;
    if (_l isEqualType [] && {count _l > 11} && {(_l # 2) isEqualTo "factory"} && {(_l # 4) isEqualTo TYR_PlayerFaction}) then {
        private _d = player distance2D (_l # 3);
        if (_d < _dist) then {_dist = _d; _best = _l # 0};
    };
} forEach values (TYR_ClientState getOrDefault ["locations",createHashMap]);
if (_best isEqualTo "" || {_dist > 120}) exitWith {hint "Move within 120m of a controlled factory."};
missionNamespace setVariable ["TYR_factoryMenuId",_best];
createDialog "TyrFactoryMenu";
[] spawn {
    while {!isNull findDisplay 1450} do {
        [] call TYR_fnc_FactoryMenuRefresh;
        sleep 1;
    };
};
