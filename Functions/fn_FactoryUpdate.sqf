FactoryData  = ((GameData # 1) # 2);
FactoryMultiplier = gameData # 0 # 0 # 1 # 7;

{
    FactoryPartGroupResourceData = (_x # 6);
    FactoryResource = 0;
    FactoryPartGroup = (_x # 5);
    {
        
        FactoryPart = _x;
        
        if (((str(FactoryPart)) find "dp_mainfactory_f") != -1) then {
            
            FactoryResource = FactoryResource + ((1-(damage FactoryPart)) * 250)
            
        };
        if (((str(FactoryPart)) find "factory_main_f") != -1) then {
            
            FactoryResource = FactoryResource + ((1-(damage FactoryPart)) * 250)
            
        };
        if (((str(FactoryPart)) find "dp_bigtank_f") != -1) then {
            
            FactoryResource = FactoryResource + ((1-(damage FactoryPart)) * 125)
            
        };
        if (((str(FactoryPart)) find "dp_smalltank_f") != -1) then {
            
            FactoryResource = FactoryResource + ((1-(damage FactoryPart)) * 75)
            
        };
        if (((str(FactoryPart)) find "storagetank_01_large_f") != -1) then {
            
            FactoryResource = FactoryResource + ((1-(damage FactoryPart)) * 125)
            
        };
        if (((str(FactoryPart)) find "storagetank_01_small_f") != -1) then {
            
            FactoryResource = FactoryResource + ((1-(damage FactoryPart)) * 75)
            
        };
        
    }forEach FactoryPartGroup;

    FactoryPartGroupResourceData = FactoryPartGroupResourceData + (FactoryPartGroupResourceData * FactoryMultiplier);
    
    if (FactoryPartGroupResourceData > 50000) then {
    
        FactoryPartGroupResourceData = 50000;
    
    };
    
    (FactoryData # _forEachIndex) set [6, FactoryPartGroupResourceData];
    
}forEach FactoryData;

(GameData # 1) set [2, FactoryData];
publicVariable "GameData";