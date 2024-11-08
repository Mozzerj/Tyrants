// player init and basic setup


titleCut ["", "BLACK IN", 4];

player setUnitTrait ["Medic", true];
player setUnitTrait ["UAVHacker", true];
player setUnitTrait ["explosiveSpecialist", true];
player setUnitTrait ["engineer", true];

[] call TYR_fnc_TYRVarCheck;

TyrantsMain = profileNamespace getVariable ["Tyrants", False];
TyrantsPFP = TyrantsMain # 0;


switch (playerSide) do {
	case WEST: {Pside = 0;PColor = "ColorWest";PlayerOverlayColor =  [0.00, 0.30, 0.60, 1.00]};
	case EAST: {Pside = 1;PColor = "ColorEast";PlayerOverlayColor =  [0.50, 0.00, 0.00, 1.00]};
};


// case 0: game is brand new nothing has been setup wait for server host to do setup
switch (gameData # 0 # 0 # 0) do {
	case 0: { execVM "Setup\GameSetupPlayer\GameInit.sqf"};
	case 1: { execVM "Setup\GameSetupPlayer\GameInit.sqf"};
	case 2: { execVM "Setup\GameSetupPlayer\GameInit.sqf"};
	case 3: { execVM "Setup\GameSetupPlayer\GameInit.sqf"};

};

waitUntil {(gameData # 0 # 0 # 0 == 4)};

execVM "Player\PlayerInit\PlayerMapCreation.sqf";

{
	if ((_x # 0) isEqualTo getPlayerUID player) exitwith {
		
		
		PFPID = _forEachIndex;
    	player setPos ([] call TYR_fnc_givePlayerLoadout) # 1;

	};
	
} forEach gameData # 0 # 3;

if (isNil "PFPID") then {

	PFPID = count (gameData # 0 # 3);
	gameData # 0 # 3 pushback ([] call TYR_fnc_getPlayerLoadout);


};

waitUntil { ((!isNil "WestBox") and (!isNil "EastBox")) };


switch (Pside) do {
	case 0: {

		westBox addAction ["Open Arsenal", { 
		["Open", [true]] call BIS_fnc_arsenal;

		playerLoadout = ([] call TYR_fnc_getPlayerLoadout);

		aresenalCloseID = addUserActionEventHandler ["ingamePause", "Activate", {

			removeUserActionEventHandler ["ingamePause", "Activate", aresenalCloseID];
			[playerLoadout] call TYR_fnc_exitArsenal;

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

		AccountantMove = {
			WestMoveAccID = WestAccountant addAction ["Move Accountant", {
				WestAccountant removeAction WestMoveAccID;
				WestAccountant attachTo [player, [0, 3, 0]];

				WestDropAccID = player addAction ['Drop Accountant', {
					GameData # 0 # (Pside + 1) set [0, getPos WestAccountant];
					publicVariable "GameData";
					detach WestAccountant;
					WestAccountant setPosATL (player modelToWorld [0, 3, 0]);
					westBox setPosATL (player modelToWorld [2, 3, 0]);
					player removeAction WestDropAccID;
					call AccountantMove;
				},
				nil,
				1.5,
				true,
				true,
				"",
				"true",
				10
				];
			}];
		};

		call AccountantMove;

	};
	case 1: {

		EastBox addAction ["Open Arsenal", { 
		["Open", [true]] call BIS_fnc_arsenal;

		playerLoadout = ([] call TYR_fnc_getPlayerLoadout);

		aresenalCloseID = addUserActionEventHandler ["ingamePause", "Activate", {

			removeUserActionEventHandler ["ingamePause", "Activate", aresenalCloseID];
			[playerLoadout] call TYR_fnc_exitArsenal;

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

		AccountantMove = {
			eastMoveAccID = eastAccountant addAction ["Move Accountant", {
				eastAccountant removeAction eastMoveAccID;
				eastAccountant attachTo [player, [0, 3, 0]];

				eastDropAccID = player addAction ['Drop Accountant', {
					GameData # 0 # (Pside + 1) set [0, getPos eastAccountant];
					publicVariable "GameData";
					detach eastAccountant;
					eastAccountant setPosATL (player modelToWorld [0, 3, 0]);
					eastBox setPosATL (player modelToWorld [2, 3, 0]);
					player removeAction eastDropAccID;
					call AccountantMove;
				},
				nil,
				1.5,
				true,
				true,
				"",
				"true",
				10
				];
			}];
		};

		call AccountantMove;
	};
};


// playermenu

findDisplay 46 displayAddEventHandler ["KeyDown", {
    params ["_unit", "_key"];

    if (_key == 21) then {

		if (isNull findDisplay 1001) then {
			
			createDialog "TyrPlayerMenu";

			_TyrPlayerMenu = findDisplay 1001;

			_TyrPlayerMenu displayCtrl 1 ctrlSetText (TyrantsPFP # 0);
			_TyrPlayerMenu displayCtrl 2 ctrlSetText str(TyrantsPFP # 1);
			_TyrPlayerMenu displayCtrl 3 progressSetPosition (TyrantsPFP # 2);



			// factory resource collection button

			_inrange = false;
			{

				_ResourceButton = ((findDisplay 1001) displayCtrl 4);
				if ((((getPos player) distance (_x # 4)) < 75) and (Pcolor == _x # 3)) then {

					_inrange = true;

				};

				if (_inrange) then {

					_ResourceButton ctrlSetPosition [safeZoneX + safeZoneW * 0.01375,safeZoneY + safeZoneH * 0.29777778];
					_ResourceButton ctrlCommit 0;
					
				}
				else
				{
					_ResourceButton ctrlSetPosition [-1,-1];
					_ResourceButton ctrlCommit 0;
				}

			}forEach gameData # 1 # 2;


			// buy vehicle button
			_buyvehicle = ((findDisplay 1001) displayCtrl 5);
			if ((getPos player) distance (gameData # 0 # (Pside + 1) # 0) < 25 ) then {

				_buyvehicle ctrlSetPosition [safeZoneX + safeZoneW * 0.01367188,safeZoneY + safeZoneH * 0.34722223];
				_buyvehicle ctrlCommit 0;

			}
			else
			{

				_buyvehicle ctrlSetPosition [-1,-1];
				_buyvehicle ctrlCommit 0;

			};
		};
    };
}];

publicVariable "gameData";