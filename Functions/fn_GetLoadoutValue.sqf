params ["_loadout"];
if !(_loadout isEqualType [] && {count _loadout >= 10}) exitWith {0};

private _value = 0;

private _backpackClass = _loadout # 2 # 0;
if (_backpackClass isNotEqualTo "") then {
    private _cfg = configFile >> "CfgVehicles" >> _backpackClass;
    _value = _value + getNumber (_cfg >> "maximumLoad") + (getNumber (_cfg >> "mass") * 2);
};
{
    private _cfg = configFile >> "CfgWeapons" >> _x;
    _value = _value + (getNumber (_cfg >> "ItemInfo" >> "mass") / 10);
} forEach (_loadout # 2 # 1);

private _vestClass = _loadout # 3 # 0;
if (_vestClass isNotEqualTo "") then {
    private _cfg = configFile >> "CfgWeapons" >> _vestClass;
    _value = _value + (getNumber (_cfg >> "ItemInfo" >> "HitpointProtectionInfo" >> "Body") * 3) + (getNumber (_cfg >> "ItemInfo" >> "mass") * 3);
};
{
    private _cfg = configFile >> "CfgWeapons" >> _x;
    _value = _value + (getNumber (_cfg >> "ItemInfo" >> "mass") / 10);
} forEach (_loadout # 3 # 1);

private _uniformClass = _loadout # 4 # 0;
if (_uniformClass isNotEqualTo "") then {
    private _cfg = configFile >> "CfgWeapons" >> _uniformClass;
    _value = _value + getNumber (_cfg >> "ItemInfo" >> "mass");
};
{
    private _cfg = configFile >> "CfgWeapons" >> _x;
    _value = _value + (getNumber (_cfg >> "ItemInfo" >> "mass") / 10);
} forEach (_loadout # 4 # 1);

private _headgear = _loadout # 5;
if (_headgear isNotEqualTo "") then {
    private _cfg = configFile >> "CfgWeapons" >> _headgear;
    _value = _value + (getNumber (_cfg >> "ItemInfo" >> "HitpointProtectionInfo" >> "Head") * 3) + (getNumber (_cfg >> "ItemInfo" >> "mass") * 3);
};

private _weaponData = [
    [_loadout # 6 # 0, 1.25],
    [_loadout # 7 # 0, 2],
    [_loadout # 8 # 0, 1]
];
{
    private _weapon = _x # 0;
    if (_weapon isNotEqualTo "") then {
        private _cfg = configFile >> "CfgWeapons" >> _weapon;
        _value = _value + (getNumber (_cfg >> "maxRange") * (_x # 1)) + getNumber (_cfg >> "WeaponSlotsInfo" >> "mass");
    };
} forEach _weaponData;

{
    private _magClass = _x # 0;
    private _rounds = _x # 1;
    private _magCfg = configFile >> "CfgMagazines" >> _magClass;
    private _ammoClass = getText (_magCfg >> "ammo");
    private _ammoCost = getNumber (configFile >> "CfgAmmo" >> _ammoClass >> "cost");
    _value = _value + (_rounds * (_ammoCost / 10));
} forEach (_loadout # 9);

_value
