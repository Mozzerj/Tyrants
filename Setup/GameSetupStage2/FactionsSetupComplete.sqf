_setupMenu1002 = findDisplay 1002;

_selectedFactionLB = _setupMenu1002 displayCtrl 2;

_dlcs = [];
_configs = [];

for "_i" from 0 to (lbSize _selectedFactionLB - 1) do {
    private _item = _selectedFactionLB lbText _i;

    if (_item == "Vanilla") then {
        _dlcs pushBack ""; 
    } 
    else 
    {
        _dlcs pushBack _item; 
    };
};

{

    {

        if ((_x # 2) in _dlcs) then {

            _configs pushBack (configFile >> "cfgVehicles" >> (_x # 1));
            
        };
            
    } forEach _x;
    
} forEach gameData # 3 # 1;

_conlen = count _configs;

closeDialog 1002;
createDialog "SetupMenuVehicles";

spawnZone = getPos initZone;

_setupMenu = findDisplay 1001;
_progressbar = _setupMenu displayCtrl 1;
_ETA = _setupMenu displayCtrl 2;

getVehicleData = {
    params["_x"];
    
    _configName = _x;
    _displayName = getText(configFile >> "cfgVehicles" >> _configName >> "displayName");
    _editorPreview = getText(configFile >> "cfgVehicles" >> _configName >> "editorPreview");

    _armour = getNumber(configFile >> "cfgVehicles" >> _configName >> "armor");
    _armorStructural = getNumber(configFile >> "cfgVehicles" >> _configName >> "armorStructural");

    if (_armorStructural > 100) then {_armorStructural = (_armorStructural/100)};
    if (_armorStructural > 10) then {_armorStructural = (_armorStructural/10)};

    _VehicleWeapons = [];
    _VehicleMagazines = [];

    _DataVeh = createVehicle [_configName, spawnZone, [], 0, "CAN_COLLIDE"];
    _DataVeh enableSimulationGlobal false;

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

        _AmmoVeh = createVehicle [_AmmoType, (spawnZone vectorAdd [0,8,2]), [], 0, "NONE"];
        _AmmoSize = boundingBoxReal [_AmmoVeh,"Geometry"];
        deleteVehicle _AmmoVeh;

        _diff = (_AmmoSize select 1) vectorDiff (_AmmoSize select 0); 

        _width = _diff vectorDotProduct [1, 0, 0]; 
        _length = _diff vectorDotProduct [0, 1, 0]; 
        _height = _diff vectorDotProduct [0, 0, 1]; 

        _volume = _width * _length * _height; 

        _volume = _volume * 100;

        if (_volume == 0) then {
            _volume = getNumber(configFile >> "cfgAmmo" >> _AmmoType >> "cost");
            _volume = _volume / 1000;

        };

        for "_i" from 0 to _AmmoCount - 1 do {
            _ammoVolume = _ammoVolume + (_volume * exp(-(_ammoVolume / 1000)));
        };
        
    } forEach _VehicleMagazines;

    //_ammoVolume = round(_ammoVolume);

    _vehicleCost = (500 * _ammoVolume) + (100 * _armour) + (500 * _armorStructural);
    
    if (_configName isKindOf "Air") then {
        _vehicleCost = (500 * _ammoVolume) + (100 * _armour) + (500 * _armorStructural) + (100000);
    };

    _vehicleCost = _vehicleCost * 0.7;
    _vehicleCost = floor _vehicleCost;

    _dlc = getText(configfile >> "CfgVehicles" >> _configName >> "dlc");

    _categoryArray = [
        _displayName, 
        _configName, 
        _editorPreview, 
        _VehicleWeapons,
        _VehicleMagazines,
        _armour,
        _armorStructural,
        _ammoVolume,
        _vehicleCost,
        _dlc
    ];

    _categoryArray;
};

dlcCheck = {
    params["_veh"];

    _dlc = getText(configfile >> "CfgVehicles" >> configName _veh >> "dlc");

    if !(_Factions find _dlc >= 0) then {
        _Factions pushBack _dlc;
    };

};

artilleryCheck = {
    params["_veh","_vehicleData","_vehicleCategory"];

    if (getNumber(configfile >> "CfgVehicles" >> configName _veh >> "artilleryScanner") == 1) then {
        _ArtilleryVehicles pushBack _vehicleData;
    }
    else {
        _vehicleCategory pushBack _vehicleData;
    };


};

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

_Factions = [];
_checkedVehicles = [];

{
    _type = configName _x call BIS_fnc_objectType;

    _uniqueID = format ["%1", configfile >> "CfgVehicles" >> configName _x >> "Icon"];

    if !(_uniqueID in _checkedVehicles) then {
        _checkedVehicles pushBack _uniqueID;

        switch (str _type) do {
            case '["Vehicle","StaticWeapon"]': {
                _vehicleData = [configName _x] call getVehicleData;
                [_x] call dlcCheck;
                [_x, _vehicleData, _StaticWeaponVehicles] call artilleryCheck;
                sleep 0.01;
            };
            case '["VehicleAutonomous","StaticWeapon"]': {
                _vehicleData = [configName _x] call getVehicleData;
                [_x] call dlcCheck;
                [_x, _vehicleData, _StaticWeaponVehicles] call artilleryCheck;
                sleep 0.01;
            };
            case '["Vehicle","Helicopter"]': {
                _vehicleData = [configName _x] call getVehicleData;
                [_x] call dlcCheck;
                _HelicopterVehicles pushBack _vehicleData;
                sleep 0.01;
            };
            case '["Vehicle","Plane"]': {
                _vehicleData = [configName _x] call getVehicleData;
                [_x] call dlcCheck;
                _PlaneVehicles pushBack _vehicleData;
                sleep 0.01;
            };
            case '["Vehicle","TrackedAPC"]': {
                _vehicleData = [configName _x] call getVehicleData;
                [_x] call dlcCheck;
                _ArmoredVehicles pushBack _vehicleData;
                sleep 0.01;
            };
            case '["Vehicle","Tank"]': {
                _vehicleData = [configName _x] call getVehicleData;
                [_x] call dlcCheck;
                [_x, _vehicleData, _TankVehicles] call artilleryCheck;
                sleep 0.01;
            };
            case '["Vehicle","Ship"]': {
                _vehicleData = [configName _x] call getVehicleData;
                [_x] call dlcCheck;
                _ShipVehicles pushBack _vehicleData;
                sleep 0.01;
            };
            case '["Vehicle","Submarine"]': {
                _vehicleData = [configName _x] call getVehicleData;
                [_x] call dlcCheck;
                _SubmarineVehicles pushBack _vehicleData;
                sleep 0.01;
            };
            case '["Vehicle","Car"]': {
                _vehicleData = [configName _x] call getVehicleData;
                [_x] call dlcCheck;
                [_x, _vehicleData, _CarVehicles] call artilleryCheck;
                sleep 0.01;
            };
            case '["Vehicle","WheeledAPC"]': {
                _vehicleData = [configName _x] call getVehicleData;
                [_x] call dlcCheck;
                _ArmoredVehicles pushBack _vehicleData;
                sleep 0.01;
            };
            case '["VehicleAutonomous","Helicopter"]': {
                _vehicleData = [configName _x] call getVehicleData;
                [_x] call dlcCheck;
                _AutonomousHelicopterVehicles pushBack _vehicleData;
                sleep 0.01;
            };
            case '["VehicleAutonomous","Plane"]': {
                _vehicleData = [configName _x] call getVehicleData;
                [_x] call dlcCheck;
                _AutonomousPlaneVehicles pushBack _vehicleData;
                sleep 0.01;
            };
            case '["VehicleAutonomous","Car"]': {
                _vehicleData = [configName _x] call getVehicleData;
                [_x] call dlcCheck;
                [_x, _vehicleData, _AutonomousCarVehicles] call artilleryCheck;
                sleep 0.01;
            };
            case '["VehicleAutonomous","Tank"]': {
                _vehicleData = [configName _x] call getVehicleData;
                [_x] call dlcCheck;
                [_x, _vehicleData, _AutonomousTankVehicles] call artilleryCheck;
                sleep 0.01;
            };
            case '["Object","StaticWeapon"]': {
                _vehicleData = [configName _x] call getVehicleData;
                [_x] call dlcCheck;
                [_x, _vehicleData, _StaticWeaponVehicles] call artilleryCheck;
                sleep 0.01;
            };
        };
    };
        // Update ETA and progress bar
        _ETA ctrlSetText format ["ETA: %1", (_conlen - _forEachIndex)];
        _progressbar progressSetPosition (_forEachIndex / _conlen);
} forEach _configs;

_vehCategories = [
    _CarVehicles,
    _ArmoredVehicles,
    _ArtilleryVehicles,
    _MotorcycleVehicles,
    _TankVehicles,
    _HelicopterVehicles,
    _PlaneVehicles,
    _StaticWeaponVehicles,
    _ShipVehicles,
    _SubmarineVehicles,
    _AutonomousCarVehicles,
    _AutonomousTankVehicles,
    _AutonomousHelicopterVehicles,
    _AutonomousPlaneVehicles,
    _AutonomousStaticWeaponVehicles
];


gameData # 0 # 0 set [0, 3];
gameData # 3 set [1, _vehCategories];

_progressbar ctrlSetPositionY 1.5;
_progressbar ctrlCommit 1;

closeDialog 1001;