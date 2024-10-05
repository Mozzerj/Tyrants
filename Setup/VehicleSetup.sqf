_allApcs = "(
getNumber ( _x >> ""scope"" ) isEqualTo 2 && {
getNumber ( _x >> ""type"" ) isEqualTo 1 && {
getText ( _x >> ""simulation"" ) isEqualTo ""carx""
}})" configClasses ( configFile >> "cfgVehicles" );

_allPlanes = "(
getNumber ( _x >> ""scope"" ) isEqualTo 2 && {
getNumber ( _x >> ""type"" ) isEqualTo 2 && {
getText ( _x >> ""simulation"" ) isEqualTo ""airplanex""
}})" configClasses ( configFile >> "cfgVehicles" );

_allHelis = "(
getNumber ( _x >> ""scope"" ) isEqualTo 1 && {
getNumber ( _x >> ""type"" ) isEqualTo 2 && {
getText ( _x >> ""simulation"" ) isEqualTo ""helicopterrtd""
}})" configClasses ( configFile >> "cfgVehicles" );

systemChat str _allApcs;