sleep 2;

if ((profileNamespace getVariable ["Tyrants", "VarCheck"]) isEqualTo "VarCheck") then {
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

waitUntil {(serverInit)};

TyrantsMain = profileNamespace getVariable ["Tyrants", False];
TyrantsPFP = TyrantsMain # 0;


switch (playerSide) do {
	case WEST: {Pside = 0;PColor = "ColorWest";PlayerOverlayColor =  [0.00, 0.30, 0.60, 1.00]};
	case EAST: {Pside = 1;PColor = "ColorEast";PlayerOverlayColor =  [0.50, 0.00, 0.00, 1.00]};
};

_PIDFound = false;

waitUntil {(GameData # 0 # 0 # 0 isNotEqualTo 0)};
waitUntil {(GameData # 1 isNotEqualTo 0)};

if (!isNil "commanderWest") then {

	if ((player == commanderWest) && (gameData # 0 # 1 # 0 isEqualTo 0)) then {execVM "Setup\player\playerBaseSelectionMap.sqf";};

};

if (!isNil "commanderEast") then {

	if ((player == commanderEast) && (gameData # 0 # 2 # 0 isEqualTo 0)) then {execVM "Setup\player\playerBaseSelectionMap.sqf";};

};

{
	if (_x # 0 == getPlayerUID player) exitwith {
		
		_PIDFound = true;
		PFPID = _forEachIndex;

			removeUniform player;
			removeAllItems player; // clears deafualt inventory
			removeAllWeapons player; // clears deafualt inventory
			removeVest player;
			removeBackpack player;

			_PFP = gameData # 0 # 3 # PFPID;

			player setPos (_PFP # 1); // set position from last save

			player AddBackpack (_PFP # 2 # 0); // adds backpack
			player addVest (_PFP # 3 # 0); // adds vest
			player addUniform (_PFP # 4 # 0); // adds uniform

			removeAllItems player; // clears deafualt inventory
			removeAllWeapons player; // clears deafualt inventory

			{player addItemToBackpack _x;} forEach (_PFP # 2 # 1); // adds items to backpack
			{player addItemToVest _x;} forEach (_PFP # 3 # 1); // adds items to backpack
			{player addItemToUniform _x;} forEach (_PFP # 4 # 1);

			player addWeapon _PFP # 5 # 0;
			{

				player addPrimaryWeaponItem _x;

			} forEach _PFP # 5 # 1;

			player addWeapon _PFP # 6 # 0;
			{

				player addPrimaryWeaponItem _x;

			} forEach _PFP # 6 # 1;

			player addWeapon _PFP # 7 # 0;
			{

				player addPrimaryWeaponItem _x;

			} forEach _PFP # 7 # 1;
	};
	
} forEach gameData # 0 # 3;

if (_PIDFound == false) then {

	PFPID = count (gameData # 0 # 3);

	gameData # 0 # 3 pushback[

		getPlayerUID player,
		getPos player,

		[backpack player,backpackItems player],

		[vest player,vestItems player],

		[uniform player,uniformItems player],

		[primaryWeapon player,primaryWeaponItems player],
		[secondaryWeapon player,secondaryWeaponItems player],
		[handgunWeapon player,handgunItems player]

	];

};

westBox addAction ["Open Arsenal", { 
    ["Open", [true]] call BIS_fnc_arsenal;

	playerLoadout = [
		
		[backpack player,backpackItems player],

        [vest player,vestItems player],

        [uniform player,uniformItems player],

        [primaryWeapon player,primaryWeaponItems player],
        [secondaryWeapon player,secondaryWeaponItems player],
        [handgunWeapon player,handgunItems player]
		
	];

	aresenalCloseID = addUserActionEventHandler ["ingamePause", "Activate", {
		
		removeUserActionEventHandler ["ingamePause", "Activate", aresenalCloseID];
		execVM "Functions\exitArsenal.sqf";

	}];

	},
	nil,
	1.5,
	true,
	true,
	"",
	"true",
	10
];


publicVariable "gameData";

execVM "Player\PlayerInit\PlayerMapCreation.sqf";