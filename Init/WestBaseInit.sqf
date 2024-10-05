WestAccGrp = createGroup West;
basePos = (GameData # 0 # 1 # 0);
WestAccountant = WestAccGrp createUnit ["C_man_polo_4_F", (basePos), [], 0, "NONE"];
WestBox = createVehicle ["virtualReammoBox_camonet_F", (basePos vectorAdd [1,0,0]), [], 0, "NONE"];
publicVariable "WestBox";


markerBLUFOR = createMarker ["respawn_west", gameData # 0 # 1 # 0];

WestAccountant addEventHandler ["HandleDamage", {
	params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint", "_directHit", "_context"];

    if ((isPlayer _instigator) and (side _instigator == east) and (_directHit)) then {_unit setDamage _damage} else {_unit setDamage 0;}

}];
WestAccountant disableAI "MOVE";
