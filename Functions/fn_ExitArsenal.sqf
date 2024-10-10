_playerCloseLoadout = [
    [backpack player, backpackItems player],
    [vest player, vestItems player],
    [uniform player, uniformItems player],
    [primaryWeapon player, primaryWeaponItems player],
    [secondaryWeapon player, secondaryWeaponItems player],
    [handgunWeapon player, handgunItems player],
    [headgear player]
];

handgunMultiplier = 1;
SecondaryMulitplier = 2;
PrimaryMulitplier = 1.25;

_playerOpenLoadout = _this # 0;

getLoadoutValue = {
    params["_Loadout", "_Multi","_LoadoutValue"];

    // Initialize variables
    _backpackCost = 0;
    _backpackItemCost = 0;

    _vestCost = 0;
    _vestItemCost = 0;

    _uniformCost = 0;
    _uniformItemCost = 0;

    _primaryWeaponCost = 0;
    _secondaryWeaponCost = 0;
    _handgunWeaponCost = 0;
    _headgearCost = 0;



    _backpack = _Loadout # 0 # 0;
    _backpackItems = _Loadout # 0 # 1;

    _vest = _Loadout # 1 # 0;
    _vestItems = _Loadout # 1 # 1;

    _uniform = _Loadout # 2 # 0;
    _uniformItems = _Loadout # 2 # 1;

    _primaryWeapon = _Loadout # 3 # 0;
    _primaryWeaponItems = _Loadout # 3 # 1;

    _secondaryWeapon = _Loadout # 4 # 0;
    _secondaryWeaponItems = _Loadout # 4 # 1;

    _handgunWeapon = _Loadout # 5 # 0;
    _handgunWeaponItems = _Loadout # 5 # 1;

    _headgear = _loadout # 6 # 0;

    _backpack = (configfile >> "CfgVehicles" >> _backpack);
    _backpackMaxLoad = getNumber(_backpack >> "maximumLoad");
    _backpackMass = getNumber(_backpack >> "mass");
    _backpackCost = (_backpackMaxLoad ) + (_backpackMass * 2);

    {
        
        _item = _x;

        _itemConfig = configfile >> "CfgWeapons" >> _item;
        _itemMass = getNumber(_itemConfig >> "iteminfo" >> "mass");

        _backpackItemCost = _backpackItemCost + (_itemMass/10);

        // if magazine
        if (isNil str _itemConfig) then {

            _itemConfig = (configfile >> "CfgMagazines" >> _item);

            _itemAmmo = getText(_itemConfig >> "ammo");

                _itemAmmoConfig = (configfile >> "CfgAmmo" >> _itemAmmo);
                _itemAmmoCost = getNumber(_itemAmmoConfig >> "Cost");

            _itemCount = getNumber (_itemConfig >> "mass");

            _backpackItemCost = _backpackItemCost + _itemCount * (_ItemAmmoCost/10);

        };

    } forEach _backpackItems;

    _vest = (configfile >> "CfgWeapons" >> _vest);
    _vestArmour = getNumber(_vest >> "ItemInfo" >> "HitpointProtectionInfo" >> "Body");
    _vestMass = getNumber(_vest >> "ItemInfo" >> "mass");
    _vestCost = (_vestArmour * 3) + (_vestMass * 3);

    {
        
        _item = _x;

        _itemConfig = configfile >> "CfgWeapons" >> _item;
        _itemMass = getNumber(_itemConfig >> "iteminfo" >> "mass");

        _vestItemCost = _vestItemCost + (_itemMass/10);

        // if magazine
        if (isNil str _itemConfig) then {

            _itemConfig = (configfile >> "CfgMagazines" >> _item);

            _itemAmmo = getText(_itemConfig >> "ammo");

                _itemAmmoConfig = (configfile >> "CfgAmmo" >> _itemAmmo);
                _itemAmmoCost = getNumber(_itemAmmoConfig >> "Cost");

            _itemCount = getNumber (_itemConfig >> "mass");

            _vestItemCost = _vestItemCost + _itemCount * (_ItemAmmoCost/10);

        };

    } forEach _vestItems;

    _uniform = (configfile >> "CfgWeapons" >> _uniform);
    _uniformMass = getNumber(_uniform >> "ItemInfo" >> "mass");
    _uniformCost = _uniformMass;

    {
        
        _item = _x;

        _itemConfig = configfile >> "CfgWeapons" >> _item;
        _itemMass = getNumber(_itemConfig >> "iteminfo" >> "mass");

        _uniformItemCost = _uniformItemCost + (_itemMass/10);

        // if magazine
        if (isNil str _itemConfig) then {

            _itemConfig = (configfile >> "CfgMagazines" >> _item);

            _itemAmmo = getText(_itemConfig >> "ammo");

                _itemAmmoConfig = (configfile >> "CfgAmmo" >> _itemAmmo);
                _itemAmmoCost = getNumber(_itemAmmoConfig >> "Cost");

            _itemCount = getNumber (_itemConfig >> "mass");

            _uniformItemCost = _uniformItemCost + _itemCount * (_ItemAmmoCost/10);

        };

    } forEach _uniformItems;

    _headgear = (configfile >> "CfgWeapons" >> _headgear);
    _headgearArmour = getNumber(_headgear >> "ItemInfo" >> "HitpointProtectionInfo" >> "Head");
    _headgearMass = getNumber(_headgear >> "ItemInfo" >> "mass");
    _headgearCost = (_headgearArmour * 3) + (_headgearMass * 3);

    // Primary Weapon
    if (_primaryWeapon != "") then {
        _primaryWeapon = (configfile >> "CfgWeapons" >> _primaryWeapon);
        _primaryWeaponRange = getNumber(_primaryWeapon >> "maxRange");
        _primaryWeaponMass = getNumber(_primaryWeapon >> "WeaponSlotsInfo" >> "mass");
        
        _primaryWeaponMagazine = (getArray(_primaryWeapon >> "magazines")) # 0;
        if (!isNil _primaryWeaponMagazine) then {
            _primaryWeaponMagazine = (configfile >> "CfgMagazines" >> _primaryWeaponMagazine);
            _primaryWeaponMagazineInitSpeed = getNumber(_primaryWeaponMagazine >> "initSpeed");
        } else {
            _primaryWeaponMagazineInitSpeed = 0;
        };
        
        _primaryWeaponCost = (_primaryWeaponRange * 1.25) + _primaryWeaponMass;  // Calculate cost if present
    };

    // Secondary Weapon
    if (_secondaryWeapon != "") then {
        _secondaryWeapon = (configfile >> "CfgWeapons" >> _secondaryWeapon);
        _secondaryWeaponRange = getNumber(_secondaryWeapon >> "maxRange");
        _secondaryWeaponMass = getNumber(_secondaryWeapon >> "WeaponSlotsInfo" >> "mass");
        
        _secondaryWeaponMagazine = (getArray(_secondaryWeapon >> "magazines")) # 0;
        if (!isNil _secondaryWeaponMagazine) then {
            _secondaryWeaponMagazine = (configfile >> "CfgMagazines" >> _secondaryWeaponMagazine);
            _secondaryWeaponMagazineInitSpeed = getNumber(_secondaryWeaponMagazine >> "initSpeed");
        } else {
            _secondaryWeaponMagazineInitSpeed = 0;
        };
        
        _secondaryWeaponCost = (_secondaryWeaponRange * 2) + _secondaryWeaponMass;  // Calculate cost if present
    };

    // Handgun Weapon
    if (_handgunWeapon != "") then {
        _handgunWeapon = (configfile >> "CfgWeapons" >> _handgunWeapon);
        _handgunWeaponRange = getNumber(_handgunWeapon >> "maxRange");
        _handgunWeaponMass = getNumber(_handgunWeapon >> "WeaponSlotsInfo" >> "mass");
        
        _handgunWeaponMagazine = (getArray(_handgunWeapon >> "magazines")) # 0;
        if (!isNil _handgunWeaponMagazine) then {
            _handgunWeaponMagazine = (configfile >> "CfgMagazines" >> _handgunWeaponMagazine);
            _handgunWeaponMagazineInitSpeed = getNumber(_handgunWeaponMagazine >> "initSpeed");
        } else {
            _handgunWeaponMagazineInitSpeed = 0;
        };

        _handgunWeaponCost = (_handgunWeaponRange * handgunMultiplier) + _handgunWeaponMass;  // Calculate cost if present
    };

    // Show all costs in the hint
    _totalCost = (_backpackCost + _backpackitemcost + _vestCost + _vestitemcost + _uniformCost + _uniformitemcost + _primaryWeaponCost + _secondaryWeaponCost + _handgunWeaponCost + _headgearCost);

    Loadoutinfo = format [
        "Loadout Costs:\n\n" +
        "Backpack Cost: %1\n" + 
        "Vest Cost: %2\n" + 
        "Uniform Cost: %3\n" + 
        "Primary Weapon Cost: %4\n" + 
        "Secondary Weapon Cost: %5\n" + 
        "Handgun Weapon Cost: %6\n" +
        "Headgear Cost: %7\n" +
        "Loadout Value: %8\n" + 
        "Cost: %9\n",
        _backpackCost,
        _vestCost,
        _uniformCost,
        _primaryWeaponCost,
        _secondaryWeaponCost,
        _handgunWeaponCost,
        _headgearCost,
        _totalCost,
        (_LoadoutValue + (_totalCost * _Multi))
    ];

    LoadoutValue = _LoadoutValue + (_totalCost * _Multi);
};

LoadoutValue = 0;
[_playerOpenLoadout, 1, LoadoutValue] call getLoadoutValue;
[_playerCloseLoadout, -1, LoadoutValue] call getLoadoutValue;

if (((gameData # 0 # (Pside + 1) # 2) + LoadoutValue) < 0) then {

    removeUniform player;
    removeAllItems player; // clears deafualt inventory
    removeAllWeapons player; // clears deafualt inventory
    removeVest player;
    removeBackpack player;
    removeHeadgear player;

    player AddBackpack (_playerOpenLoadout # 0 # 0); // adds backpack
    player addVest (_playerOpenLoadout # 1 # 0); // adds vest
    player addUniform (_playerOpenLoadout # 2  # 0); // adds uniform
    player addHeadgear (_playerOpenLoadout # 6 # 0); // adds uniform

    removeAllItems player; // clears deafualt inventory
    removeAllWeapons player; // clears deafualt inventory

    {player addItemToBackpack _x;} forEach (_playerOpenLoadout # 0 # 1); // adds items to backpack
    {player addItemToVest _x;} forEach (_playerOpenLoadout # 1 # 1); // adds items to backpack
    {player addItemToUniform _x;} forEach (_playerOpenLoadout # 2 # 1);

    player addWeapon _playerOpenLoadout # 3 # 0;
    {

        player addPrimaryWeaponItem _x;

    } forEach _playerOpenLoadout # 3 # 1;

    player addWeapon _playerOpenLoadout # 4 # 0;
    {

        player addPrimaryWeaponItem _x;

    } forEach _playerOpenLoadout # 4 # 1;

    player addWeapon _playerOpenLoadout # 5 # 0;
    {

        player addPrimaryWeaponItem _x;

    } forEach _playerOpenLoadout # 5 # 1;

    hint "Cost too much";
    hint format["Cost too much \n" + "Ammo remaining: %1\n" + "Loadout cost: %2",gameData # 0 # (Pside + 1) # 2,LoadoutValue];

}
else
{

    gameData # 0 # (Pside + 1) set [2,(gameData # 0 # (Pside + 1) # 2 + LoadoutValue)];

    publicVariable "gameData";

    hint format["%1 \nAmmo remaining: %2",Loadoutinfo, gameData # 0 # (Pside + 1) # 2];

};
