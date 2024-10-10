systemChat "East Base Init";

EastAccGrp = createGroup East;
basePos = (GameData # 0 # 2 # 0);
EastAccountant = EastAccGrp createUnit ["C_man_polo_4_F", (basePos), [], 0, "NONE"];
EastBox = createVehicle ["virtualReammoBox_camonet_F", (basePos vectorAdd [1,0,0]), [], 0, "NONE"];
publicVariable "EastBox";

markerOPFOR = createMarker ["respawn_east", gameData # 0 # 2 # 0];

EastAccountant addEventHandler ["HandleDamage", {
	params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint", "_directHit", "_context"];

    if ((isPlayer _instigator) and (side _instigator == west) and (_directHit)) then {_unit setDamage _damage} else {
        
        _unit setDamage (damage _unit + _damage);

        if (damage _unit == 1) then {

            "The East's Accountant has been killed \n The west has succesfully defeated the Easts attempts at control" remoteExec ["hint"];


        };
        
    }

}];

EastAccountant disableAI "MOVE";

