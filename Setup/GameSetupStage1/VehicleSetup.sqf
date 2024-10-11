createDialog "SetupMenuVehicles";

spawnZone = getPos initZone;

// Initialize vehicle arrays
_ArmoredVehicles = [];
_ArtilleryVehicles = [];
_CarVehicles = [];
_AutonomousCarVehicles = [];
_ShipVehicles = [];
_SubmarineVehicles = [];
_MotorcycleVehicles = [];
_TankVehicles = [];
_AutonomousTankVehicles = [];
_HelicopterVehicles = [];
_AutonomousHelicopterVehicles = [];
_PlaneVehicles = [];
_AutonomousPlaneVehicles = [];
_StaticWeaponVehicles = [];
_AutonomousStaticWeaponVehicles = [];

_setupMenu = findDisplay 1001;
_progressbar = _setupMenu displayCtrl 1;
_ETA = _setupMenu displayCtrl 2;

_configs = "(getNumber (configfile >> 'CfgVehicles' >> configName _x >> 'scope') isEqualTo 2) and (configName _x isKindOf 'AllVehicles')" configClasses (configFile >> "CfgVehicles");
_conlen = count _configs;

getVehicleData = {
    params["_x"];
    
    _configName = _x;
    _displayName = getText(configFile >> "cfgVehicles" >> _configName >> "displayName");
    _editorPreview = getText(configFile >> "cfgVehicles" >> _configName >> "editorPreview");

    _armour = getNumber(configFile >> "cfgVehicles" >> _configName >> "armor");
    _armorStructural = getNumber(configFile >> "cfgVehicles" >> _configName >> "armorStructural");

    _DataVeh = createVehicle [_configName, spawnZone, [], 0, "CAN_COLLIDE"];

    _VehicleWeapons = [];
    _VehicleMagazines = [];

    {
        _VehicleWeapons = _VehicleWeapons + (_DataVeh weaponsTurret _x);
        _VehicleMagazines = _VehicleMagazines + (_DataVeh magazinesTurret _x);
    } forEach [[-1],[0],[1],[0,0],[0,1],[1,0]];

    deleteVehicle _DataVeh;

    // Ammo volume calculation
    _ammoVolume = 0;

    {
        _AmmoCount = getNumber(configFile >> "cfgMagazines" >> _x >> "count");
        _AmmoType = getText(configFile >> "cfgMagazines" >> _x >> "ammo");

        _AmmoVeh = createVehicle [_AmmoType, (spawnZone vectorAdd [0,8,2]), [], 0, "CAN_COLLIDE"];
        _AmmoSize = boundingBox _AmmoVeh;
        deleteVehicle _AmmoVeh;

        _max = _AmmoSize # 1;
        _min = _AmmoSize # 0;

        _width = _max # 0 - _min # 0;
        _height = _max # 1 - _min # 1;
        _depth = _max # 2 - _min # 2;

        _volume = _width * _height * _depth;

        // Fallback for zero volume
        if (_volume < 1) then {
            _volume = getNumber(configFile >> "cfgAmmo" >> _AmmoType >> "cost");
            _volume = _volume / 100;
        };

        // Adjust the ammo volume calculation with exponential decay
        _decayFactor = 1.1;
        _ammoVolume = _ammoVolume + (_volume * _AmmoCount) / (_decayFactor ^ _ammoVolume);
        
    } forEach _VehicleMagazines;

    _ammoVolume = round(_ammoVolume);

    // Cost calculation
    _vehicleCost = (500 * _ammoVolume) + (70 * _armour) + (4000 * _armorStructural);
    
    if (_configName isKindOf "Air") then {
        _vehicleCost = ((2 * _ammoVolume) + (100 * _armour) + (7500 * _armorStructural)) * 15;
    };

    _vehicleCost = _vehicleCost * 0.7;
    _vehicleCost = floor _vehicleCost;

    _categoryArray = [
        _displayName, 
        _configName, 
        _editorPreview, 
        _VehicleWeapons,
        _VehicleMagazines,
        _armour,
        _armorStructural,
        _ammoVolume,
        _vehicleCost
    ];

    _categoryArray;
};

{
    _type = configName _x call BIS_fnc_objectType;

    switch (str _type) do {
        case '["Vehicle","StaticWeapon"]': {
            _vehicleData = [configName _x] call getVehicleData;
            
            if (getNumber(configfile >> "CfgVehicles" >> configName _x >> "artilleryScanner") == 1) then {
                _vehicleData = [configName _x] call getVehicleData;
                _ArtilleryVehicles pushBack _vehicleData;
            }
            else {
                _StaticWeaponVehicles pushBack _vehicleData;
            };
            sleep 0.01;
        };
        case '["VehicleAutonomous","StaticWeapon"]': {
            _vehicleData = [configName _x] call getVehicleData;

            if (getNumber(configfile >> "CfgVehicles" >> configName _x >> "artilleryScanner") == 1) then {
                _vehicleData = [configName _x] call getVehicleData;
                _ArtilleryVehicles pushBack _vehicleData;
            }
            else {
                _AutonomousStaticWeaponVehicles pushBack _vehicleData;
            };
            sleep 0.01;
        };
        case '["Vehicle","Helicopter"]': {
            _vehicleData = [configName _x] call getVehicleData;
            _HelicopterVehicles pushBack _vehicleData;
            sleep 0.01;
        };
        case '["Vehicle","Plane"]': {
            _vehicleData = [configName _x] call getVehicleData;
            _PlaneVehicles pushBack _vehicleData;
            sleep 0.01;
        };
        case '["Vehicle","TrackedAPC"]': {
            _vehicleData = [configName _x] call getVehicleData;
            _ArmoredVehicles pushBack _vehicleData;
            sleep 0.01;
        };
        case '["Vehicle","Tank"]': {
            _vehicleData = [configName _x] call getVehicleData;

            if (getNumber(configfile >> "CfgVehicles" >> configName _x >> "artilleryScanner") == 1) then {
                _vehicleData = [configName _x] call getVehicleData;
                _ArtilleryVehicles pushBack _vehicleData;
            }
            else {
                _TankVehicles pushBack _vehicleData;
            };
            sleep 0.01;
        };
        case '["Vehicle","Ship"]': {
            _vehicleData = [configName _x] call getVehicleData;
            _ShipVehicles pushBack _vehicleData;
            sleep 0.01;
        };
        case '["Vehicle","Submarine"]': {
            _vehicleData = [configName _x] call getVehicleData;
            _SubmarineVehicles pushBack _vehicleData;
            sleep 0.01;
        };
        case '["Vehicle","Car"]': {
            _vehicleData = [configName _x] call getVehicleData;

            if (getNumber(configfile >> "CfgVehicles" >> configName _x >> "artilleryScanner") == 1) then {
                _vehicleData = [configName _x] call getVehicleData;
                _ArtilleryVehicles pushBack _vehicleData;
            }
            else {
                _CarVehicles pushBack _vehicleData;
            };
            sleep 0.01;
        };
        case '["Vehicle","WheeledAPC"]': {
            _vehicleData = [configName _x] call getVehicleData;
            _ArmoredVehicles pushBack _vehicleData;
            sleep 0.01;
        };
        case '["VehicleAutonomous","Helicopter"]': {
            _vehicleData = [configName _x] call getVehicleData;
            _AutonomousHelicopterVehicles pushBack _vehicleData;
            sleep 0.01;
        };
        case '["VehicleAutonomous","Plane"]': {
            _vehicleData = [configName _x] call getVehicleData;
            _AutonomousPlaneVehicles pushBack _vehicleData;
            sleep 0.01;
        };
        case '["VehicleAutonomous","Car"]': {
            _vehicleData = [configName _x] call getVehicleData;

            if (getNumber(configfile >> "CfgVehicles" >> configName _x >> "artilleryScanner") == 1) then {
                _vehicleData = [configName _x] call getVehicleData;
                _ArtilleryVehicles pushBack _vehicleData;
            }
            else {
                _AutonomousCarVehicles pushBack _vehicleData;
            };
            sleep 0.01;
        };
        case '["VehicleAutonomous","Tank"]': {
            _vehicleData = [configName _x] call getVehicleData;

            if (getNumber(configfile >> "CfgVehicles" >> configName _x >> "artilleryScanner") == 1) then {
                _vehicleData = [configName _x] call getVehicleData;
                _ArtilleryVehicles pushBack _vehicleData;
            }
            else {
                _AutonomousTankVehicles pushBack _vehicleData;
            };
            sleep 0.01;
        };
        case '["Object","StaticWeapon"]': {
            _vehicleData = [configName _x] call getVehicleData;

            if (getNumber(configfile >> "CfgVehicles" >> configName _x >> "artilleryScanner") == 1) then {
                _vehicleData = [configName _x] call getVehicleData;
                _ArtilleryVehicles pushBack _vehicleData;
            }
            else {
                _StaticWeaponVehicles pushBack _vehicleData;
            };
            sleep 0.01;
        };
    };

    _ETA ctrlSetText format ["ETA: %1",(_conlen - _forEachIndex)];
    _progressbar progressSetPosition (_forEachIndex/_conlen);
} forEach _configs;


// Collect all vehicle arrays into a single array
_allVehiclesData = [

    _ArmoredVehicles,
    _ArtilleryVehicles,
    _CarVehicles,
    _AutonomousCarVehicles,
    _ShipVehicles,
    _SubmarineVehicles,
    _MotorcycleVehicles,
    _TankVehicles,
    _AutonomousTankVehicles,
    _HelicopterVehicles,
    _AutonomousHelicopterVehicles,
    _PlaneVehicles,
    _AutonomousPlaneVehicles,
    _StaticWeaponVehicles,
    _AutonomousStaticWeaponVehicles

];

// Set gameData[3] to the array of all vehicle arrays
gameData set [3, _allVehiclesData];
publicVariable "gameData";

_progressbar ctrlSetPositionY 1.5;
_progressbar ctrlCommit 1;
