createDialog "SetupMenuVehicles";

spawnZone = getPos initZone;

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

    _dlc = getText(configfile >> "CfgVehicles" >> _configName >> "dlc");

    _categoryArray = [
        _displayName, 
        _configName, 
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


// Collect all vehicle arrays into a single array
_allVehiclesData = [

    _Factions,
    [
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
    ]

];

// Set gameData[3] to the array of all vehicle arrays
gameData # 0 # 0 set [0, 2];
gameData set [3, _allVehiclesData];
publicVariable "gameData";

_progressbar ctrlSetPositionY 1.5;
_progressbar ctrlCommit 1;

closeDialog 1001;

while {gameData # 0 # 0 # 0 == 2} do {

    execVM "Setup\GameSetupStage2\FactionSetup.sqf";

    sleep 0.5;

    waitUntil {isNull findDisplay 1002};
};
