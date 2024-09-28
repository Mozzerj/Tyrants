_randomAngle = random 360;
_randomDistance = random range;

_offsetX = _randomDistance * cos(_randomAngle);
_offsetY = _randomDistance * sin(_randomAngle);

_newPos = [
    (ClickPos select 0) + _offsetX,  
    (ClickPos select 1) + _offsetY,  
    0                              
];

player setPos _newPos;

removeAllWeapons player;
removeAllItems player;
removeUniform player;

player forceAddUniform "U_B_GhillieSuit";

hint "Weapon added in 30 seconds";
sleep 2;
hint "";
sleep 28;

player addWeapon "srifle_LRR_F";
player addPrimaryWeaponItem "optic_LRPS";
for "_i" from 0 to 5 do {
    player addMagazine "7Rnd_408_Mag";
};


player unlinkItem "ItemMap";