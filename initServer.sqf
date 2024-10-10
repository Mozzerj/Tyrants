// if "Tyrants" does not exist 
// 		VarCheck is returned then "Tyrants" will be made with GameData = [False]
//
// if "Tyrants" does exist
// 		GameData checked for False or True

addMissionEventHandler ["BuildingChanged", {
	params ["_from", "_to", "_isRuin"];

	if (_isRuin) then {(gameData # 2 # 0)pushBack _from; publicVariable "gameData"};

	
}];

[] call TYR_fnc_TYRVarCheck;

TyrantsMain = profileNamespace getVariable ["Tyrants", False];
GameData = TyrantsMain # 1;
publicVariable "GameData";

//                     00   010 010 011 012   020 020 021 022        10   11   12          
//GameData = [ [ 0, [ 0,  0,  0,  0 ],[ 0,  0,  0,  0]],    [[[],[[]],[[]]]    ];
//                     GameMode and Team Data                        Location Data     

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
