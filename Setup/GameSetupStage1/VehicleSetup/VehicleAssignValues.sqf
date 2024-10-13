{
    _categoryArray = [];

    {
        if ((getText(configFile >> "cfgVehicles" >> (configName _x) >> "editorPreview")) != "" && 
            ((configName _x find "base") == -1) && 
            ((configName _x find "Base") == -1)) then {

            _displayName = getText(configFile >> "cfgVehicles" >> (configName _x) >> "displayName");
            _configName = configName _x;
            _editorPreview = getText(configFile >> "cfgVehicles" >> _configName >> "editorPreview");

            _armour = getNumber(configFile >> "cfgVehicles" >> _configName >> "armor");
            _armorStructural = getNumber(configFile >> "cfgVehicles" >> _configName >> "armorStructural");


            _DataVeh = _configName createVehicle _spawnZone;

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

                _AmmoVeh = _AmmoType createVehicle _spawnZone;
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

            // cost calculation
            _vehicleCost = (500 * _ammoVolume) + (70 * _armour) + (4000 * _armorStructural);
            
            if (_configName isKindOf "Air") then {_vehicleCost = ((2 * _ammoVolume) + (100 * _armour) + (7500 * _armorStructural)) * 15};

            // cost calculation
            _vehicleCost = _vehicleCost * 0.7;
            _vehicleCost = floor _vehicleCost;

            _categoryArray pushBack [
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
        };
    } forEach (_vehs # _forEachIndex);

    _vehicleArray pushBack _categoryArray;
} forEach _vehTypes;
