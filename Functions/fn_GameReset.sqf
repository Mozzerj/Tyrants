	GameData = [
		
		[
			[
				0 // server started
			], 
			[ 
				0,   // west base pos
			    0,   // steel
				0,   // ammo
				0,   // fuel
				0,    // HR
				[[0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0]] // Research
			],
			[ 
				0,   // east base pos
			    0,   // steel
				0,   // ammo
				0,   // fuel
				0,    // HR
				[[0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0]] // Research
			],
			[
				[[]] // player Location
			]
			
		],
		   0, // location data
		[
			[
				// destroyed buildings
			],
			[
				// destroyed vehicles
			]
		],
		[
			0 // vehicle data
		],
		[
			[],
			[]// purchased vehicles
		]
	];

	TyrantsMain = [[name player,"Private",1],GameData,[                ]];
				// 0 PFP                         1 Tyrants   2 SniperShootout
	profileNamespace setVariable ["Tyrants", TyrantsMain];
	saveProfileNamespace;

	["END1"] remoteExec ["endMission", 0, true];