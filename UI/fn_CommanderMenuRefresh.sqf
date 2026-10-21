disableSerialization;
private _d = findDisplay 1202;
if (isNull _d || {isNil "TYR_ClientState"}) exitWith {};
private _f = (TYR_ClientState get "factions") getOrDefault [TYR_PlayerFaction,[]];
if (count _f < 11) exitWith {};
private _cmd = _f # 10;
private _text = format [
    "%1 COMMAND\nStrategic controller: %2\nAI personality: %3\nPosture: %4\nCurrent objective: %5\n\nHuman players and AI commanders use the same force/economy services.",
    toUpper (_f # 1),toUpper (_f # 3),
    if (count _cmd > 0) then {_cmd # 0} else {"--"},
    if (count _cmd > 1) then {_cmd # 1} else {"--"},
    if (count _cmd > 2 && {(_cmd # 2) isNotEqualTo ""}) then {_cmd # 2} else {"None"}
];
(_d displayCtrl 2) ctrlSetText format ["%1 // FORCE COMMAND",toUpper (_f # 1)];
(_d displayCtrl 30) ctrlSetText _text;
