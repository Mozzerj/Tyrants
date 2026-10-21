createDialog "TYR_SetupMenuVehicles";

private _setupMenu = findDisplay 1101;
if (isNull _setupMenu) exitWith {};
private _progressBar = _setupMenu displayCtrl 1;
private _eta = _setupMenu displayCtrl 2;

private _configs = "(getNumber (_x >> 'scope') isEqualTo 2) && {configName _x isKindOf 'AllVehicles'}" configClasses (configFile >> "CfgVehicles");
private _count = (count _configs) max 1;
private _entries = [];
private _dlcs = [];

{
    private _className = configName _x;
    private _displayName = getText (_x >> "displayName");
    if (_displayName isNotEqualTo "") then {
        private _dlc = getText (_x >> "dlc");
        _entries pushBack [_displayName, _className, _dlc];
        _dlcs pushBackUnique _dlc;
    };

    _eta ctrlSetText format ["Scanning vehicles: %1 / %2", _forEachIndex + 1, count _configs];
    _progressBar progressSetPosition ((_forEachIndex + 1) / _count);
    if ((_forEachIndex mod 50) isEqualTo 0) then {sleep 0.001};
} forEach _configs;

TYR_setupVehicleCatalog = [_dlcs, _entries];
closeDialog 0;
[] execVM "Setup\GameSetupStage2\FactionSetup.sqf";
