createDialog "SetupMenu";

_setupMenu = findDisplay 1000;

if (!isNil "commanderWest") then {
_setupMenu displayCtrl 41 ctrlSetText (name commanderWest);
};

if (!isNil "commanderEast") then {
    _setupMenu displayCtrl 42 ctrlSetText (name commanderEast);
};

{
    if ((str _x find "West") != -1) then {
        _setupMenu displayCtrl 43 lbAdd (name _X);
    }
    else
    {
        _setupMenu displayCtrl 44 lbAdd (name _X);
    };
} forEach allPlayers;

_cb1 = _setupMenu displayCtrl 1;
_cb1 lbAdd "60";
_cb1 lbAdd "90";
_cb1 lbAdd "120";
_cb1 lbAdd "180";

_cb2 = _setupMenu displayCtrl 2;
_cb2 lbAdd "50";
_cb2 lbAdd "100";
_cb2 lbAdd "175";
_cb2 lbAdd "250";

_cb3 = _setupMenu displayCtrl 3;
_cb3 lbAdd "15000";
_cb3 lbAdd "20000";
_cb3 lbAdd "30000";
_cb3 lbAdd "40000";
_cb3 lbAdd "50000";
_cb3 lbAdd "75000";

_cb4 = _setupMenu displayCtrl 4;
_cb4 lbAdd "15000";
_cb4 lbAdd "20000";
_cb4 lbAdd "30000";
_cb4 lbAdd "40000";
_cb4 lbAdd "50000";
_cb4 lbAdd "75000";

_cb5 = _setupMenu displayCtrl 5;
_cb5 lbAdd "15000";
_cb5 lbAdd "20000";
_cb5 lbAdd "30000";
_cb5 lbAdd "40000";
_cb5 lbAdd "50000";
_cb5 lbAdd "75000";

_cb6 = _setupMenu displayCtrl 6;
_cb6 lbAdd "15";
_cb6 lbAdd "20";
_cb6 lbAdd "30";
_cb6 lbAdd "40";
_cb6 lbAdd "50";
_cb6 lbAdd "75";

_cb7 = _setupMenu displayCtrl 7;
_cb7 lbAdd "0.5x";
_cb7 lbAdd "1.0x";
_cb7 lbAdd "1.5x";
_cb7 lbAdd "2.0x";
_cb7 lbAdd "2.5x";
_cb7 lbAdd "3.0x";

_cb8 = _setupMenu displayCtrl 8;
_cb8 lbAdd "0.5x";
_cb8 lbAdd "1.0x";
_cb8 lbAdd "1.5x";
_cb8 lbAdd "2.0x";
_cb8 lbAdd "2.5x";
_cb8 lbAdd "3.0x";

