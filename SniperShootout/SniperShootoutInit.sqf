createDialog "SniperShootoutSetup";

_display = findDisplay 1002;

_display displayCtrl 31 ctrlSetText (TyrantsMain # 0 # 0);
_display displayCtrl 32 ctrlSetText (TyrantsMain # 0 # 1);
_display displayCtrl 33 progressSetPosition (TyrantsMain # 0 # 2);

_display displayCtrl 41 ctrlSetText (name CommanderWest);
_display displayCtrl 42 ctrlSetText (name CommanderEast);

{
    if ((str _x find "West") != -1) then {
        _display displayCtrl 43 lbAdd (name _X);
    }
    else
    {
        _display displayCtrl 44 lbAdd (name _X);
    };
} forEach allPlayers;