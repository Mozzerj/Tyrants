// if "Tyrants" does not exist 
// 		VarCheck is returned then "Tyrants" will be made with GameData = [False]
//
// if "Tyrants" does exist
// 		GameData checked for False or True

if (str(profileNamespace getVariable ["Tyrants", "VarCheck"]) == "VarCheck") then {

	// Save Var to namespace to create save file
	TyrantsMain = [[name player,"Private",1],[         ],[                ]];
				// 0 PFP                         1 Tyrants   2 SniperShootout
	profileNamespace setVariable ["Tyrants", TyrantsMain];
	saveProfileNamespace;
};

// loads GameData from namespace

GameMode = "NotSelected";

TyrantsMain = profileNamespace getVariable ["Tyrants", False];