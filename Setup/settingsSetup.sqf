switch (_this # 0) do {
    case 0: {CTime = 60};
    case 1: {CTime = 90};
    case 2: {CTime = 120};
    case 3: {CTime = 180};
    default {CTime = 120};  // Middle value
};

switch (_this # 1) do {
    case 0: {CRange = 50};
    case 1: {CRange = 100};
    case 2: {CRange = 175};
    case 3: {CRange = 250};
    default {CRange = 175};  // Middle value
};

switch (_this # 2) do {
    case 0: {SteelInit = 5000};
    case 1: {SteelInit = 7500};
    case 2: {SteelInit = 10000};
    case 3: {SteelInit = 12500};
    case 4: {SteelInit = 15000};
    case 5: {SteelInit = 20000};
    default {SteelInit = 10000};  // Middle value
};

switch (_this # 3) do {
    case 0: {AmmoInit = 5000};
    case 1: {AmmoInit = 7500};
    case 2: {AmmoInit = 10000};
    case 3: {AmmoInit = 12500};
    case 4: {AmmoInit = 15000};
    case 5: {AmmoInit = 20000};
    default {AmmoInit = 10000};  // Middle value
};

switch (_this # 4) do {
    case 0: {FuelInit = 5000};
    case 1: {FuelInit = 7500};
    case 2: {FuelInit = 10000};
    case 3: {FuelInit = 12500};
    case 4: {FuelInit = 15000};
    case 5: {FuelInit = 20000};
    default {FuelInit = 10000};  // Middle value
};

switch (_this # 5) do {
    case 0: {FactoryProduction = 0.5};
    case 1: {FactoryProduction = 1};
    case 2: {FactoryProduction = 1.5};
    case 3: {FactoryProduction = 2};
    case 4: {FactoryProduction = 2.5};
    case 5: {FactoryProduction = 3};
    default {FactoryProduction = 1};  // Middle value
};

switch (_this # 6) do {
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

gameData # 0 # 2 set [1,SteelInit];
gameData # 0 # 2 set [2,AmmoInit];
gameData # 0 # 2 set [3,FuelInit];

GameData # 0 # 0 set [0, [CTime, CRange, SteelInit, AmmoInit, FuelInit, FactoryProduction, VehicleCost]];
publicVariable "GameData";
