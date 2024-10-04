// if "Tyrants" does not exist 
// 		VarCheck is returned then "Tyrants" will be made with GameData = [False]
//
// if "Tyrants" does exist
// 		GameData checked for False or True

serverInit = false;
publicVariable "serverInit";

if (str(profileNamespace getVariable ["Tyrants", "VarCheck"]) == "VarCheck") then {

	// Save Var to namespace to create save file
      
	GameData = [
		
		[
			[
				0 // server started
			], 
			[ 
				0, // west base pos
			    0,  // resources
				0,  
				0 
			],
			[ 
				0,  // east base pos
			    0,  // resources
				0,  
				0
			],
			[
				[""] // player Location
			]
			
		],
		   0 // location data
	];

	TyrantsMain = [[name player,"Private",1],GameData,[                ]];
				// 0 PFP                         1 Tyrants   2 SniperShootout
	profileNamespace setVariable ["Tyrants", TyrantsMain];
	saveProfileNamespace;
};

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
    case 0: {execVM "Setup\LocationSetup.sqf";};
};

waitUntil {gameData # 0 # 0 # 0 isNotEqualTo 0};

serverInit = true;
publicVariable "serverInit";

execVM "GameUpdate\GameLoop.sqf";
