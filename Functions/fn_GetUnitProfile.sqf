params ["_unit"];
if (isNull _unit) exitWith {[]};

[
    getPlayerUID _unit,
    getPosATL _unit,
    [backpack _unit, (backpackItems _unit) - (magazines _unit)],
    [vest _unit, (vestItems _unit) - (magazines _unit)],
    [uniform _unit, (uniformItems _unit) - (magazines _unit)],
    headgear _unit,
    [primaryWeapon _unit, primaryWeaponItems _unit],
    [secondaryWeapon _unit, secondaryWeaponItems _unit],
    [handgunWeapon _unit, handgunItems _unit],
    magazinesAmmoFull _unit
]
