createDialog "SetupMenu";

private _setupMenu = findDisplay 1100;
if (isNull _setupMenu) exitWith {};

if (!isNil "commanderWest") then {
    _setupMenu displayCtrl 41 ctrlSetText (name commanderWest);
};
if (!isNil "commanderEast") then {
    _setupMenu displayCtrl 42 ctrlSetText (name commanderEast);
};

{
    private _target = if (side _x isEqualTo west) then {43} else {44};
    (_setupMenu displayCtrl _target) lbAdd (name _x);
} forEach allPlayers;

private _options = [
    [1, ["60", "90", "120", "180"], 2],
    [2, ["50", "100", "175", "250"], 2],
    [3, ["5000", "10000", "15000", "20000", "30000", "45000"], 2],
    [4, ["15000", "20000", "30000", "40000", "50000", "75000"], 2],
    [5, ["15000", "20000", "30000", "40000", "50000", "75000"], 2],
    [6, ["15", "20", "30", "40", "50", "75"], 2],
    [7, ["0.5x", "1.0x", "1.5x", "2.0x", "2.5x", "3.0x"], 1],
    [8, ["0.5x", "1.0x", "1.5x", "2.0x", "2.5x", "3.0x"], 1]
];

{
    private _ctrl = _setupMenu displayCtrl (_x # 0);
    {_ctrl lbAdd _x} forEach (_x # 1);
    _ctrl lbSetCurSel (_x # 2);
} forEach _options;
