disableSerialization;
private _d = findDisplay 1200;
if (isNull _d || {isNil "TYR_ClientState"} || {isNil "TYR_PlayerFaction"}) exitWith {};
private _f = (TYR_ClientState get "factions") getOrDefault [TYR_PlayerFaction,[]];
if (count _f < 6) exitWith {};
private _res = _f # 5;
(_d displayCtrl 1) ctrlSetText format ["%1 // %2",profileName,toUpper (_f # 1)];
(_d displayCtrl 2) ctrlSetText format ["Controller: %1",toUpper (_f # 3)];
(_d displayCtrl 20) ctrlSetText format ["Steel: %1",round (_res # 0)];
(_d displayCtrl 21) ctrlSetText format ["Ammo: %1",round (_res # 1)];
(_d displayCtrl 22) ctrlSetText format ["Fuel: %1",round (_res # 2)];
(_d displayCtrl 23) ctrlSetText format ["Manpower: %1",round (_res # 3)];

private _context = "No controlled factory in production range";
private _nearFactory = false;
{
    private _l = _x;
    if ((_l # 2) isEqualTo "factory" && {(_l # 4) isEqualTo TYR_PlayerFaction} && {player distance2D (_l # 3) < 80}) exitWith {
        _nearFactory = true;
        _context = format ["%1 // %2 // queue %3/3",_l # 1,toUpper (_l param [11,"factory"]),count (_l param [13,[]])];
    };
} forEach values (TYR_ClientState get "locations");
(_d displayCtrl 24) ctrlSetText _context;
(_d displayCtrl 4) ctrlEnable _nearFactory;
(_d displayCtrl 9) ctrlShow (missionNamespace getVariable ["TYR_debugMode",false]);
