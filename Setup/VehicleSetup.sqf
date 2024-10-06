_allTanks = ("getText (_x >> 'vehicleClass') == 'Armored'") configClasses (configFile >> "cfgVehicles");
_allcar = ("getText (_x >> 'vehicleClass') == 'car'") configClasses (configFile >> "cfgVehicles");
_allPlanes = ("(getText (_x >> 'vehicleClass') == 'Air') and (getText (_x >> 'simulation') == 'airplanex')") configClasses (configFile >> "cfgVehicles");
_allUavs = ("getText (_x >> 'vehicleClass') == 'Autonomous'") configClasses (configFile >> "cfgVehicles");
_allHelis = ("getText (_x >> 'vehicleClass') isEqualTo 'Air' and (getText (_x >> 'simulation') == 'helicopterrtd')") configClasses (configFile >> "cfgVehicles");

_vehs = [_allTanks, _allcar, _allPlanes, _allHelis, _allUavs];
_vehTypes = ["Tanks", "Cars", "Planes", "Helis", "UAVs"];

_vehicleArray = [];

{
    _categoryArray = [];

    {
        if ((getText(configFile >> "cfgVehicles" >> (configName _x) >> "editorPreview")) != "" && 
            ((configName _x find "base") == -1) && 
            ((configName _x find "Base") == -1)) then {

            _displayName = getText(configFile >> "cfgVehicles" >> (configName _x) >> "displayName");
            _configName = configName _x;
            _editorPreview = getText(configFile >> "cfgVehicles" >> _configName >> "editorPreview");

            _MainTurretWeapons = getArray(configFile >> "cfgVehicles" >> _configName >> "Turrets" >> "MainTurret" >> "Weapons");
            _MainTurretMagazine = getArray(configFile >> "cfgVehicles" >> _configName >> "Turrets" >> "MainTurret" >> "Magazines");

            _GunnerTurretWeapons = getArray(configFile >> "cfgVehicles" >> _configName >> "Turrets" >> "GunnerTurret" >> "Weapons");
            _GunnerTurretMagazine = getArray(configFile >> "cfgVehicles" >> _configName >> "Turrets" >> "GunnerTurret" >> "Magazines");

            _CopilotTurretWeapons = getArray(configFile >> "cfgVehicles" >> _configName >> "Turrets" >> "CopilotTurret" >> "Weapons");
            _CopilotTurretMagazine = getArray(configFile >> "cfgVehicles" >> _configName >> "Turrets" >> "CopilotTurret" >> "Magazines");

            _CommanderOpticsWeapons = getArray(configFile >> "cfgVehicles" >> _configName >> "Turrets" >> "CommanderOptics" >> "Weapons");
            _CommanderOpticsMagazine = getArray(configFile >> "cfgVehicles" >> _configName >> "Turrets" >> "CommanderOptics" >> "Magazines");

            _armour = getNumber(configFile >> "cfgVehicles" >> _configName >> "armor");
            _armorStructural = getNumber(configFile >> "cfgVehicles" >> _configName >> "armorStructural");
            

            // ammo volume calculation
            _ammoVolume = 0;
            
            {

                {
                    
                    _AmmoCount = getNumber(configFile >> "cfgMagazines" >> _x >> "count");
                    _AmmoType =  getText(configFile >> "cfgMagazines" >> _x >> "ammo");

                    _AmmoVeh = _AmmoType createVehicle [0,0,0];
                    _AmmoSize = boundingBox _AmmoVeh;
                    deleteVehicle _AmmoVeh;

                    _max = _AmmoSize # 1;
                    _min = _AmmoSize # 0;

                    _width = _max # 0 - _min # 0;
                    _height = _max # 1 - _min # 1;
                    _depth = _max # 2 - _min # 2;

                    _volume = _width * _height * _depth;

                    if (_volume == 0) then {

                        _volume = (_AmmoSize # 2)/20;

                    };

                    _ammoVolume = _ammoVolume + (_volume * _AmmoCount);
                    
                } forEach _MainTurretMagazine;

                
            } forEach [_MainTurretMagazine,_GunnerTurretMagazine,_CopilotTurretMagazine,_CommanderOpticsMagazine];
            // ammo volume calculation

            // cost calculation

            _vehicleCost = (100 * _ammoVolume / 3) + (100 * _armour) + (2000 * _armorStructural);
            
            if (_configName isKindOf "Air") then {_vehicleCost = (50 * _ammoVolume / 3) + (200 * _armour) + (4000 * _armorStructural);};

            _categoryArray pushBack [
                _displayName, 
                _configName, 
                _editorPreview, 
                _MainTurretWeapons, 
                _MainTurretMagazine, 
                _GunnerTurretWeapons, 
                _GunnerTurretMagazine, 
                _CopilotTurretWeapons, 
                _CopilotTurretMagazine, 
                _CommanderOpticsWeapons, 
                _CommanderOpticsMagazine,
                _armour,
                _armorStructural,
                _ammoVolume,
                _vehicleCost
            ];
        };
    } forEach (_vehs # _forEachIndex);

    _vehicleArray pushBack _categoryArray;
} forEach _vehTypes;

gameData set [3, _vehicleArray];
publicVariable "gameData";
