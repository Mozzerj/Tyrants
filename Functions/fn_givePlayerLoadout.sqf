removeUniform player;                  // Remove uniform
removeAllItems player;                 // Clear default inventory
removeAllWeapons player;               // Clear default weapons
removeVest player;                     // Remove vest
removeBackpack player;                 // Remove backpack
removeHeadgear player;                 // Remove headgear

_PFP = gameData # 0 # 3 # PFPID;         // Set position from last save

player addBackpack (_PFP # 2 # 0);      // Add backpack
player addVest (_PFP # 3 # 0);          // Add vest       
player addHeadgear _PFP # 5;            // Add headgear
player forceAddUniform (_PFP # 4 # 0);       // Add uniform

removeAllItems player;                 // Clear default inventory
removeAllWeapons player;               // Clear default weapons

// Add items to backpack, vest, and uniform
{ player addItemToBackpack _x; } forEach (_PFP # 2 # 1);  // Add items to backpack
{ player addItemToVest _x; } forEach (_PFP # 3 # 1);      // Add items to vest
{ player addItemToUniform _x; } forEach (_PFP # 4 # 1);   // Add items to uniform

// Add primary weapon and its items
player addWeapon (_PFP # 6 # 0); 
{
    player addPrimaryWeaponItem _x;
} forEach (_PFP # 6 # 1);

// Add secondary weapon and its items
player addWeapon (_PFP # 7 # 0); 
{
    player addSecondaryWeaponItem _x;
} forEach (_PFP # 7 # 1);

// Add handgun and its items
player addWeapon (_PFP # 8 # 0); 
{
    player addHandgunItem _x;
} forEach (_PFP # 8 # 1);

// Add remaining items (magazines) to the correct container
{
    _item = _x select 0;          // Item class name
    _count = _x # 1;
    _container = _x select 4;     // Container type (e.g., Backpack, Vest, Uniform, Weapon)

    switch (_container) do {
        case "Backpack": {
            player addMagazine [_item, _count];   // Add to backpack
        };
        case "Vest": {
            player addMagazine [_item, _count];       // Add to vest
        };
        case "Uniform": {
            player addMagazine [_item, _count];    // Add to uniform
        };
        default {                // If matches handgun container
            player addWeaponItem [_container,[_item, _count],true]; 
        };
    };
} forEach _PFP # 9;  // Iterate through the saved magazines

_PFP;