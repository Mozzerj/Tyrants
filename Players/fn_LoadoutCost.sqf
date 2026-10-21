params ["_loadout"];
if !(_loadout isEqualType []) exitWith {0};
private _classes = [];
private _walk = {
    params ["_v"];
    if (_v isEqualType "") exitWith {
        if (_v isNotEqualTo "") then {_classes pushBack _v};
    };
    if (_v isEqualType []) then {{[_x] call _walk} forEach _v};
};
[_loadout] call _walk;
private _cost = 0;
{
    private _w = configFile >> "CfgWeapons" >> _x;
    private _m = configFile >> "CfgMagazines" >> _x;
    private _v = configFile >> "CfgVehicles" >> _x;
    if (isClass _w) then {_cost = _cost + 50 + getNumber (_w >> "WeaponSlotsInfo" >> "mass") * 2};
    if (isClass _m) then {
        private _ammo = getText (_m >> "ammo");
        _cost = _cost + 10 + getNumber (configFile >> "CfgAmmo" >> _ammo >> "cost");
    };
    if (isClass _v) then {_cost = _cost + 50 + getNumber (_v >> "maximumLoad")};
} forEach _classes;
round (_cost max 0)
