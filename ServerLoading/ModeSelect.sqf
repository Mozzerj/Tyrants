if ((_this # 0) == -1) exitwith {}; 

(findDisplay 1000) closeDisplay 1;

switch (_this # 0) do {

	case 0: {execVM "TyrantMain\TyrantMainInit.sqf"};
	case 1: {execVM "SniperShootout\SniperShootoutInit.sqf"};
	case 2: {execVM "AirInterdiction\AirInterdictionInit.sqf"};

	default {};
};