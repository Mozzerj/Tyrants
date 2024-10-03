FactoryData  = ((GameData select 1) select 2);

{
    FactoryPartGroupResourceData = (_x select 6);

    FactoryPartGroup = (_x select 5);
    {
        
        FactoryPart = _x;
        
        if (((str(FactoryPart)) find "dp_mainfactory_f") != -1) then {
            
            FactoryPartGroupResourceData = FactoryPartGroupResourceData + ((1-(damage FactoryPart)) * 250)
            
        };
        if (((str(FactoryPart)) find "factory_main_f") != -1) then {
            
            FactoryPartGroupResourceData = FactoryPartGroupResourceData + ((1-(damage FactoryPart)) * 250)
            
        };
        if (((str(FactoryPart)) find "dp_bigtank_f") != -1) then {
            
            FactoryPartGroupResourceData = FactoryPartGroupResourceData + ((1-(damage FactoryPart)) * 125)
            
        };
        if (((str(FactoryPart)) find "dp_smalltank_f") != -1) then {
            
            FactoryPartGroupResourceData = FactoryPartGroupResourceData + ((1-(damage FactoryPart)) * 75)
            
        };
        if (((str(FactoryPart)) find "storagetank_01_large_f") != -1) then {
            
            FactoryPartGroupResourceData = FactoryPartGroupResourceData + ((1-(damage FactoryPart)) * 125)
            
        };
        if (((str(FactoryPart)) find "storagetank_01_small_f") != -1) then {
            
            FactoryPartGroupResourceData = FactoryPartGroupResourceData + ((1-(damage FactoryPart)) * 75)
            
        };
        
    }forEach FactoryPartGroup;
    
    if (FactoryPartGroupResourceData > 50000) then {
    
        FactoryPartGroupResourceData = 50000;
    
    };
    
    (FactoryData select _forEachIndex) set [6, FactoryPartGroupResourceData];
    
}forEach FactoryData;

(GameData select 1) set [2, FactoryData];
publicVariable "GameData";


