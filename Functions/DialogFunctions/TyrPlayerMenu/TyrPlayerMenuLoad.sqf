_allApcs = "(getText ( _x >> ""simulation"" ) isEqualTo ""carx"")" configClasses ( configFile >> "cfgVehicles" );
_allPlanes = "(getText ( _x >> ""simulation"" ) isEqualTo ""airplanex"")" configClasses ( configFile >> "cfgVehicles" );
_allHelis = "(getText ( _x >> ""simulation"" ) isEqualTo ""helicopterrtd"")" configClasses ( configFile >> "cfgVehicles" );

_vehs = [_allApcs,_allPlanes,_allHelis];
{

    if (((str(configName _x) find "base") == -1) and ((str(configName _x) find "Base") == -1)) then {
        ((findDisplay 1002) displayCtrl 4) lbAdd 
    };
    
} forEach _allApcs;

//getText(configFile >> "cfgVehicles" >> (configName _x) >> "displayName");