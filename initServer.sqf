[] call TYR_fnc_TYRVarCheck;

TyrantsMain = profileNamespace getVariable ["Tyrants", False];
GameData = TyrantsMain # 1;
publicVariable "GameData";

waitUntil {!isNull (findDisplay 70)};
sleep 1;

switch (gameData # 0 # 0 # 0) do {
    case 0: {
        
        sleep 0.5;

        while {gameData # 0 # 0 # 0 == 0} do {

            execVM "Setup\GameSetupStage0\DialogSetup.sqf";

            sleep 0.5;

            waitUntil {isNull findDisplay 1000};
        };
    };
	case 1: { execVM "Setup\GameSetupStage1\VehicleSetup.sqf";};
	case 2: { 
        
        sleep 0.5;

        while {gameData # 0 # 0 # 0 == 0} do {

            execVM "Setup\GameSetupStage2\FactionSetup.sqf";

            sleep 0.5;

            waitUntil {isNull findDisplay 1002};
        };
        
    };

};

switch (GameData # 1) do {
    case 0: {
		execVM "Setup\GameSetupStage0\LocationSetup.sqf";
	};
};





addMissionEventHandler ["BuildingChanged", {
	params ["_from", "_to", "_isRuin"];

	if (_isRuin) then {(gameData # 2 # 0)pushBack _from; publicVariable "gameData"};

	
}];

waitUntil {GameData # 0 # 1 # 0 isNotEqualTo 0};
waitUntil {GameData # 0 # 2 # 0 isNotEqualTo 0};

gameData # 0 # 0 set[0, 4];
publicVariable "gameData";

execVM "Init\EastBaseInit.sqf";
execVM "Init\WestBaseInit.sqf";


/*
waitUntil {!isNull (findDisplay 70)};
sleep 1;

switch ((GameData # 0 # 0 # 0)) do {
    case 0: {
        while {GameData # 0 # 0 # 0 isEqualTo 0} do {
            sleep 0.5;
            if (isNull findDisplay 1000) then {
                execVM "Setup\GameSetup.sqf";
            };
        };
    };

    default {
        if (GameData # 0 # 2 # 0 isNotEqualTo 0) then {
            execVM "init\EastBaseInit.sqf";
        };

        if (GameData # 0 # 1 # 0 isNotEqualTo 0) then {
            execVM "init\WestBaseInit.sqf"; 
        };
    };
};


switch (GameData # 1) do {
    case 0: {
		execVM "Setup\LocationSetup.sqf";
		execVM "Setup\VehicleSetup.sqf"
	};
};
waitUntil {gameData # 0 # 0 # 0 isNotEqualTo 0};
waitUntil {gameData # 0 # 1 # 0 isNotEqualTo 0};
waitUntil {gameData # 0 # 2 # 0 isNotEqualTo 0};

sleep 2;

execVM "GameUpdate\GameLoop.sqf";
execVM "Init\CreateVehicles.sqf";
execVM "Init\destroyedObjects.sqf";
