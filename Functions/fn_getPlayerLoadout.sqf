_playerInventory = [

    getPlayerUID player,                                                      // Index 0: Player UID
    getPosATL player,                                                         // Index 1: Player position (ATL)

    [backpack player, (backpackItems player) - (magazines player)],   // Index 2: Backpack and non-magazine items
    [vest player, (vestItems player) - (magazines player)],               // Index 3: Vest and non-magazine items
    [uniform player, (uniformItems player) - (magazines player)],      // Index 4: Uniform and non-magazine items
    headgear player,                                                          // Index 5: Headgear

    [primaryWeapon player, primaryWeaponItems player],                        // Index 6: Primary weapon and its items
    [secondaryWeapon player, secondaryWeaponItems player],                    // Index 7: Secondary weapon and its items
    [handgunWeapon player, handgunItems player],                              // Index 8: Handgun and its items

    magazinesAmmoFull player                                                  // Index 9: Full magazine details (ammo and count)

];

_playerInventory;
