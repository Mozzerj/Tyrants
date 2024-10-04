while {true} do {
    

    (gameData # 0 # 3) set [PFPID,[

        getPlayerUID player,
        getPos player,

        [backpack player,backpackItems player],

        [vest player,vestItems player],

        [uniform player,uniformItems player],

        [primaryWeapon player,primaryWeaponItems player],
        [secondaryWeapon player,secondaryWeaponItems player],
        [handgunWeapon player,handgunItems player]]

    ];

    publicVariable "gameData";
    sleep 15;
};