createDialog "SetupMenuFactions";

_setupMenu = findDisplay 1002;

_FactionLB = _setupMenu displayCtrl 1;
_addFaction = _setupMenu displayCtrl 2;
_SelectedFactionLB = _setupMenu displayCtrl 3;

{

    if (_x == "") then {

        _FactionLB lbAdd "Vanilla";

    }
    else
    {

        _FactionLB lbAdd _x;

    };
    

} forEach gameData # 3 # 0;

