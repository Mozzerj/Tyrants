_spawnZone = getPos initZone;

_setupMenu = findDisplay 1001;
_progressbar = _setupMenu displayCtrl 1;

_configs = "(getNumber (configfile >> 'CfgVehicles' >> configName _x >> 'scope') isEqualTo 2) and (configName _x isKindOf 'AllVehicles')" configClasses (configFile >> "CfgVehicles");

{
    if (configName _x isKindOf "Armored") then { 
        _veh = createVehicle [configName _x, _spawnZone, [], 0, "CAN_COLLIDE"];
        deleteVehicle _veh;
        sleep 0.01;
    };
    
    if (configName _x isKindOf "Autonomous") then { 
        _veh = createVehicle [configName _x, _spawnZone, [], 0, "CAN_COLLIDE"];
        deleteVehicle _veh;
        sleep 0.01;
    };
    
    if (configName _x isKindOf "Car") then { 
        _veh = createVehicle [configName _x, _spawnZone, [], 0, "CAN_COLLIDE"];
        deleteVehicle _veh;
        sleep 0.01;
    };
    
    if (configName _x isKindOf "Ship") then { 
        _veh = createVehicle [configName _x, _spawnZone, [], 0, "CAN_COLLIDE"];
        deleteVehicle _veh;
        sleep 0.01;
    };
    
    if (configName _x isKindOf "Submarine") then { 
        _veh = createVehicle [configName _x, _spawnZone, [], 0, "CAN_COLLIDE"];
        deleteVehicle _veh;
        sleep 0.01;
    };
    
    if (configName _x isKindOf "Support") then { 
        _veh = createVehicle [configName _x, _spawnZone, [], 0, "CAN_COLLIDE"];
        deleteVehicle _veh;
        sleep 0.01;
    };
    
    if (configName _x isKindOf "Motorcycle") then { 
        _veh = createVehicle [configName _x, _spawnZone, [], 0, "CAN_COLLIDE"];
        deleteVehicle _veh;
        sleep 0.01;
    };
    
    if (configName _x isKindOf "Tank") then { 
        _veh = createVehicle [configName _x, _spawnZone, [], 0, "CAN_COLLIDE"];
        deleteVehicle _veh;
        sleep 0.01;
    };
    
    if (configName _x isKindOf "Helicopter") then { 
        _veh = createVehicle [configName _x, _spawnZone, [], 0, "CAN_COLLIDE"];
        deleteVehicle _veh;
        sleep 0.01;
    };
    
    if (configName _x isKindOf "Plane") then { 
        _veh = createVehicle [configName _x, _spawnZone, [], 0, "CAN_COLLIDE"];
        deleteVehicle _veh;
        sleep 0.01;
    };
    
    if (configName _x isKindOf "StaticWeapon") then { 
        _veh = createVehicle [configName _x, _spawnZone, [], 0, "CAN_COLLIDE"];
        deleteVehicle _veh;
        sleep 0.01;
    };
    
} forEach _configs;

gameData set [3, _configs];
publicVariable "gameData";
