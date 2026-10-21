if (isNil "TYR_setupVehicleCatalog") exitWith {
    hint "Vehicle scan data was lost. Restarting vehicle setup.";
    [] execVM "Setup\GameSetupStage1\VehicleSetup.sqf";
};

createDialog "TYR_SetupMenuFactions";
private _setupMenu = findDisplay 1102;
if (isNull _setupMenu) exitWith {};

private _available = _setupMenu displayCtrl 1;
private _selected = _setupMenu displayCtrl 2;
{
    private _label = if (_x isEqualTo "") then {"Vanilla"} else {_x};
    if (_label isEqualTo "Vanilla") then {
        _selected lbAdd _label;
    } else {
        _available lbAdd _label;
    };
} forEach (TYR_setupVehicleCatalog # 0);

[-1, -1] execVM "Setup\GameSetupStage2\FactionMenuUpdate.sqf";
