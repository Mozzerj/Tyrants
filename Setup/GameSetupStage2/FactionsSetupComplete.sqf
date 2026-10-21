disableSerialization;

private _display = findDisplay 1102;
if (isNull _display || {isNil "TYR_setupVehicleCatalog"}) exitWith {};

private _selectedFactionList = _display displayCtrl 2;
private _selectedDlcs = [];
for "_i" from 0 to (lbSize _selectedFactionList - 1) do {
    private _label = _selectedFactionList lbText _i;
    _selectedDlcs pushBackUnique (if (_label isEqualTo "Vanilla") then {""} else {_label});
};

if (count _selectedDlcs isEqualTo 0) exitWith {
    hint "Select at least one faction/DLC set.";
};

private _configs = [];
{
    if ((_x # 2) in _selectedDlcs) then {
        private _config = configFile >> "CfgVehicles" >> (_x # 1);
        if (isClass _config) then {_configs pushBack _config};
    };
} forEach (TYR_setupVehicleCatalog # 1);

closeDialog 0;
createDialog "TYR_SetupMenuVehicles";
private _progressDisplay = findDisplay 1101;
if (isNull _progressDisplay) exitWith {};
private _progressBar = _progressDisplay displayCtrl 1;
private _status = _progressDisplay displayCtrl 2;
private _configCount = (count _configs) max 1;
private _spawnZone = getPosATL initZone;

private _getVehicleData = {
    params ["_config", "_spawnZone"];

    private _className = configName _config;
    private _displayName = getText (_config >> "displayName");
    private _editorPreview = getText (_config >> "editorPreview");
    private _armour = getNumber (_config >> "armor");
    private _structuralArmour = getNumber (_config >> "armorStructural");

    if (_structuralArmour > 100) then {_structuralArmour = _structuralArmour / 100};
    if (_structuralArmour > 10) then {_structuralArmour = _structuralArmour / 10};

    private _weapons = [];
    private _magazines = [];
    private _dataVehicle = createVehicleLocal [_className, _spawnZone, [], 0, "CAN_COLLIDE"];
    if (!isNull _dataVehicle) then {
        _dataVehicle allowDamage false;
        _dataVehicle enableSimulation false;

        private _turrets = [[-1]] + (allTurrets [_dataVehicle, true]);
        {
            _weapons append (_dataVehicle weaponsTurret _x);
            _magazines append (_dataVehicle magazinesTurret _x);
        } forEach _turrets;

        deleteVehicle _dataVehicle;
    } else {
        _weapons = getArray (_config >> "weapons");
        _magazines = getArray (_config >> "magazines");
    };

    // A stable, config-only ammunition metric. The old implementation spawned
    // live projectile classes purely to measure their bounding boxes.
    private _ammoMetric = 0;
    {
        private _magCfg = configFile >> "CfgMagazines" >> _x;
        if (isClass _magCfg) then {
            private _roundCount = (getNumber (_magCfg >> "count")) max 1;
            private _ammoClass = getText (_magCfg >> "ammo");
            private _ammoCost = (getNumber (configFile >> "CfgAmmo" >> _ammoClass >> "cost")) max 1;
            _ammoMetric = _ammoMetric + (_roundCount * (_ammoCost / 1000));
        };
    } forEach _magazines;

    private _vehicleCost = (500 * _ammoMetric) + (70 * _armour) + (40 * _structuralArmour);
    if (_className isKindOf "Air") then {
        _vehicleCost = (10 * _ammoMetric) + (100 * _armour) + (5000 * _structuralArmour) + 100000;
    };
    _vehicleCost = floor (_vehicleCost * 0.7);

    [
        _displayName,
        _className,
        _editorPreview,
        _weapons,
        _magazines,
        _armour,
        _structuralArmour,
        _ammoMetric,
        _vehicleCost,
        getText (_config >> "dlc")
    ]
};

private _categories = [];
for "_i" from 0 to 14 do {_categories pushBack []};

{
    private _config = _x;
    private _className = configName _config;
    private _type = str (_className call BIS_fnc_objectType);
    private _categoryIndex = -1;
    private _artilleryEligible = false;

    switch (_type) do {
        case '["Vehicle","Car"]': {_categoryIndex = 0; _artilleryEligible = true};
        case '["Vehicle","WheeledAPC"]': {_categoryIndex = 1};
        case '["Vehicle","TrackedAPC"]': {_categoryIndex = 1};
        case '["Vehicle","Motorcycle"]': {_categoryIndex = 3};
        case '["Vehicle","Tank"]': {_categoryIndex = 4; _artilleryEligible = true};
        case '["Vehicle","Helicopter"]': {_categoryIndex = 5};
        case '["Vehicle","Plane"]': {_categoryIndex = 6};
        case '["Vehicle","StaticWeapon"]': {_categoryIndex = 7; _artilleryEligible = true};
        case '["Object","StaticWeapon"]': {_categoryIndex = 7; _artilleryEligible = true};
        case '["Vehicle","Ship"]': {_categoryIndex = 8};
        case '["Vehicle","Submarine"]': {_categoryIndex = 9};
        case '["VehicleAutonomous","Car"]': {_categoryIndex = 10; _artilleryEligible = true};
        case '["VehicleAutonomous","Tank"]': {_categoryIndex = 11; _artilleryEligible = true};
        case '["VehicleAutonomous","Helicopter"]': {_categoryIndex = 12};
        case '["VehicleAutonomous","Plane"]': {_categoryIndex = 13};
        case '["VehicleAutonomous","StaticWeapon"]': {_categoryIndex = 14; _artilleryEligible = true};
    };

    if (_categoryIndex >= 0) then {
        private _vehicleData = [_config, _spawnZone] call _getVehicleData;
        if (_artilleryEligible && {getNumber (_config >> "artilleryScanner") isEqualTo 1}) then {
            (_categories # 2) pushBack _vehicleData;
        } else {
            (_categories # _categoryIndex) pushBack _vehicleData;
        };
    };

    _status ctrlSetText format ["Analysing vehicles: %1 / %2", _forEachIndex + 1, count _configs];
    _progressBar progressSetPosition ((_forEachIndex + 1) / _configCount);
    if ((_forEachIndex mod 10) isEqualTo 0) then {sleep 0.001};
} forEach _configs;

[_selectedDlcs, _categories] remoteExecCall ["TYR_fnc_ServerApplyVehicleCatalog", 2];
closeDialog 0;
