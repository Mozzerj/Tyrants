systemChat "West Base Init";

WestAccGrp = createGroup West;
basePos = (GameData # 0 # 1 # 0);
WestAccountant = WestAccGrp createUnit ["C_man_polo_4_F", (basePos), [], 0, "NONE"];
WestBox = createVehicle ["virtualReammoBox_camonet_F", (basePos vectorAdd [1,0,0]), [], 0, "NONE"];
publicVariable "WestBox";


markerBLUFOR = createMarker ["respawn_west", gameData # 0 # 1 # 0];

WestAccountant addEventHandler ["HandleDamage", {
	params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint", "_directHit", "_context"];

    if ((isPlayer _instigator) and (side _instigator == east) and (_directHit)) then {
        
        _unit setDamage (damage _unit + _damage);

        if (damage _unit == 1) then {

            "The West's Accountant has been killed \n The west has succesfully defeated the Wests attempts at control" remoteExec ["hint"];


        };
        
    }

}];
WestAccountant disableAI "MOVE";
