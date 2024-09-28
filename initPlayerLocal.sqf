if (isServer && !isNull (findDisplay 70)) then {
	
	sleep 1;

	createDialog "ServerGameModeSelect";

	_display = findDisplay 1000;

	_display displayCtrl 1 lbAdd "Tyrants";
	_display displayCtrl 1 lbAdd "Sniper Shootout";
	_display displayCtrl 1 lbAdd "Air Interdiction";

	_display displayCtrl 31 ctrlSetText (TyrantsMain # 0 # 0);
	_display displayCtrl 32 ctrlSetText (TyrantsMain # 0 # 1);
	_display displayCtrl 33 progressSetPosition (TyrantsMain # 0 # 2);

	_display displayCtrl 41 ctrlSetText (name CommanderWest);
	_display displayCtrl 42 ctrlSetText (name CommanderEast);

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

if (!isServer && !isNull (findDisplay 70)) then {
	
	sleep 2;

	createDialog "PlayerWaiting";

	_display = findDisplay 1001;

	_display displayCtrl 31 ctrlSetText (TyrantsMain # 0 # 0);
	_display displayCtrl 32 ctrlSetText (TyrantsMain # 0 # 1);
	_display displayCtrl 33 progressSetPosition (TyrantsMain # 0 # 2);

	_display displayCtrl 41 ctrlSetText (name CommanderWest);
	_display displayCtrl 42 ctrlSetText (name CommanderEast);
};

waitUntil {GameMode != "NotSelected"};

systemChat GameMode;

switch (GameMode) do {

	case "Tyrants": { };
	case "SniperShootout": {execVM "SniperShootout\PlayerSetup.sqf"};
	case "AirInterdiction": {execVM "AirInterdiction\PlayerSetup.sqf"};
	default { };
};