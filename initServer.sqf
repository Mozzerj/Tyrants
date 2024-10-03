// if "Tyrants" does not exist 
// 		VarCheck is returned then "Tyrants" will be made with GameData = [False]
//
// if "Tyrants" does exist
// 		GameData checked for False or True

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

switch (GameData # 0 # 0 # 0) do {
    case 0: {
		
		createDialog "SetupMenu";

		_display = findDisplay 1000;

		_display displayCtrl 31 ctrlSetText (TyrantsMain # 0 # 0);
		_display displayCtrl 32 ctrlSetText (TyrantsMain # 0 # 1);
		_display displayCtrl 33 progressSetPosition (TyrantsMain # 0 # 2);

		if (!isNil "commanderWest") then {
		_display displayCtrl 41 ctrlSetText (name commanderWest);
		};

		if (!isNil "commanderEast") then {
			_display displayCtrl 42 ctrlSetText (name commanderEast);
		};

		{
			if ((str _x find "West") != -1) then {
				_display displayCtrl 43 lbAdd (name _X);
			}
			else
			{
				_display displayCtrl 44 lbAdd (name _X);
			};
		} forEach allPlayers;
	};
};
switch (GameData # 1) do {
    case 0: {execVM "Setup\LocationSetup.sqf";};
};

waitUntil {gameData # 0 # 0 # 0 isNotEqualTo 0};

execVM "GameUpdate\GameLoop.sqf";
