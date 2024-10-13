switch (_this # 0 # 0) do {
    case 0: {CTime = 60};
    case 1: {CTime = 90};
    case 2: {CTime = 120};
    case 3: {CTime = 180};
    default {CTime = 120};  // Middle value
};

switch (_this # 0 # 1) do {
    case 0: {CRange = 50};
    case 1: {CRange = 100};
    case 2: {CRange = 175};
    case 3: {CRange = 250};
    default {CRange = 175};  // Middle value
};

switch (_this # 0 # 2) do {
    case 0: {SteelInit = 15000};
    case 1: {SteelInit = 20000};
    case 2: {SteelInit = 30000};
    case 3: {SteelInit = 40000};
    case 4: {SteelInit = 50000};
    case 5: {SteelInit = 75000};
    default {SteelInit = 30000};  // Middle value
};

switch (_this # 0 # 3) do {
    case 0: {AmmoInit = 15000};
    case 1: {AmmoInit = 20000};
    case 2: {AmmoInit = 30000};
    case 3: {AmmoInit = 40000};
    case 4: {AmmoInit = 50000};
    case 5: {AmmoInit = 75000};
    default {AmmoInit = 30000};  // Middle value
};

switch (_this # 0 # 4) do {
    case 0: {FuelInit = 15000};
    case 1: {FuelInit = 20000};
    case 2: {FuelInit = 30000};
    case 3: {FuelInit = 40000};
    case 4: {FuelInit = 50000};
    case 5: {FuelInit = 75000};
    default {FuelInit = 30000};  // Middle value
};

switch (_this # 0 # 5) do {
    case 0: {HRinit = 15};
    case 1: {HRinit = 20};
    case 2: {HRinit = 30};
    case 3: {HRinit = 40};
    case 4: {HRinit = 50};
    case 5: {HRinit = 75};
    default {HRinit = 30};  // Middle value
};

switch (_this # 0 # 6) do {
    case 0: {FactoryProduction = 0.5};
    case 1: {FactoryProduction = 1};
    case 2: {FactoryProduction = 1.5};
    case 3: {FactoryProduction = 2};
    case 4: {FactoryProduction = 2.5};
    case 5: {FactoryProduction = 3};
    default {FactoryProduction = 1};  // Middle value
};

switch (_this # 0 # 7) do {
    case 0: {VehicleCost = 0.5};
    case 1: {VehicleCost = 1};
    case 2: {VehicleCost = 1.5};
    case 3: {VehicleCost = 2};
    case 4: {VehicleCost = 2.5};
    case 5: {VehicleCost = 3};
    default {VehicleCost = 1};  // Middle value
};

gameData # 0 # 1 set [1,SteelInit];
gameData # 0 # 1 set [2,AmmoInit];
gameData # 0 # 1 set [3,FuelInit];
gameData # 0 # 1 set [4,HRinit];

gameData # 0 # 2 set [1,SteelInit];
gameData # 0 # 2 set [2,AmmoInit];
gameData # 0 # 2 set [3,FuelInit];
gameData # 0 # 2 set [4,HRinit];

GameData # 0 # 0 set [0, 1];
GameData # 0 # 0 set [1, [CTime, CRange, SteelInit, AmmoInit, FuelInit, HRinit, FactoryProduction, VehicleCost]];
publicVariable "GameData";

closeDialog 1000;

execVM "Setup\VehicleSetup\VehicleSetup.sqf";