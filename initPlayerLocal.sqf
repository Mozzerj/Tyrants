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

// loads GameData from namespace

TyrantsMain = profileNamespace getVariable ["Tyrants", False];
TyrantsPFP = TyrantsMain # 0;


switch (playerSide) do {
	case WEST: {Pside = 0;PColor = "ColorWest";PlayerOverlayColor =  [0.00, 0.30, 0.60, 1.00]};
	case EAST: {Pside = 1;PColor = "ColorEast";PlayerOverlayColor =  [0.50, 0.00, 0.00, 1.00]};
};

{
	if (_x # 0 == getPlayerUID player) exitwith {

		PFPID = _forEachIndex;
		gameData # 0 # 3 set[PFPID,[

			getPlayerUID player,
			getPos player,

			[backpack player,backpackItems player],

			[vest player,vestItems player],

			[uniform player,uniformItems player],

			weaponsItems [player, true]]


		];

	};
	
} forEach gameData # 0 # 3;

publicVariable "gameData";

waitUntil {(GameData # 0 # 0 # 0 isNotEqualTo 0)};

execVM "Player\PlayerInit\PlayerMapCreation.sqf";

waitUntil {(GameData # 0 # 0 # 0 isNotEqualTo 0)};

execVM "Player\PlayerInit\PlayerSetLocation.sqf";