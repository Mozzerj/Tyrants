systemChat "Create Vehicles";

//[_vehicle, _veh, Pcolor, _AllHitPointsDamage, magazines, fuel, dir, pos]

{
    _vehicleData = [

        _x select 0,                     // Vehicle type
        0,                               // Vehicle object
        _x select 2,                     // Color
        _x select 3,                     // Damage to hit points
        _x select 4,                     // Magazines (ammo)
        _x select 5,                     // Fuel level
        _x select 6,                     // Direction
        _x select 7                      // Position

    ];

    _vehicleData = [_vehicleData, 0] call TYR_fnc_VehicleCreate;

    gameData # 4 # 0 set [_forEachIndex, _vehicleData];
    publicVariable "gameData";


    _veh = _vehicleData # 1;

    _veh addEventHandler ["Killed", {
        params ["_veh", "_killer"];

        gameData # 2 # 1 pushBack [typeOf _veh, getDir _veh, getPos _veh];
        
        {
            
            if (_x # 1 == _veh) then {

                gameData # 4 # 0 deleteAt _forEachIndex;
                
            };
            
        } forEach gameData # 4 # 0;
        publicVariable "gameData";

    }];
    

} forEach gameData # 4 # 0;

{

    _vehicleData = [

        _x select 0,                     // Vehicle type
        0,                               // Vehicle object
        _x select 2,                     // Color
        _x select 3,                     // Damage to hit points
        _x select 4,                     // Magazines (ammo)
        _x select 5,                     // Fuel level
        _x select 6,                     // Direction
        _x select 7                      // Position

    ];

    _vehicleData = [_vehicleData, 0] call TYR_fnc_VehicleCreate;

    gameData # 4 # 1 set [_forEachIndex, _vehicleData];
    publicVariable "gameData";


    _veh = _vehicleData # 1;
    
    _veh addEventHandler ["Killed", {
        params ["_veh", "_killer"];

        gameData # 2 # 1 pushBack [typeOf _veh, getDir _veh, getPos _veh];
        
        {
            
            if (_x # 1 == _veh) then {

                gameData # 4 # 1 deleteAt _forEachIndex;
                
            };
            
        } forEach gameData # 4 # 1;
        publicVariable "gameData";

    }];
    

} forEach gameData # 4 # 1;

//execVM "Init\CreateVehicles.sqf"