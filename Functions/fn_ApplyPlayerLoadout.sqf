if (isRemoteExecuted && {remoteExecutedOwner isNotEqualTo 2}) exitWith {};
params ["_profile"];
if !(_profile isEqualType [] && {count _profile >= 10}) exitWith {};

removeUniform player;
removeAllItems player;
removeAllWeapons player;
removeVest player;
removeBackpack player;
removeHeadgear player;

private _backpack = _profile # 2 # 0;
private _vest = _profile # 3 # 0;
private _uniform = _profile # 4 # 0;
private _headgear = _profile # 5;

if (_backpack isNotEqualTo "") then {player addBackpack _backpack};
if (_vest isNotEqualTo "") then {player addVest _vest};
if (_headgear isNotEqualTo "") then {player addHeadgear _headgear};
if (_uniform isNotEqualTo "") then {player forceAddUniform _uniform};

removeAllItems player;
removeAllWeapons player;

{player addItemToBackpack _x} forEach (_profile # 2 # 1);
{player addItemToVest _x} forEach (_profile # 3 # 1);
{player addItemToUniform _x} forEach (_profile # 4 # 1);

private _primary = _profile # 6 # 0;
if (_primary isNotEqualTo "") then {
    player addWeapon _primary;
    {player addPrimaryWeaponItem _x} forEach (_profile # 6 # 1);
};
private _secondary = _profile # 7 # 0;
if (_secondary isNotEqualTo "") then {
    player addWeapon _secondary;
    {player addSecondaryWeaponItem _x} forEach (_profile # 7 # 1);
};
private _handgun = _profile # 8 # 0;
if (_handgun isNotEqualTo "") then {
    player addWeapon _handgun;
    {player addHandgunItem _x} forEach (_profile # 8 # 1);
};

{
    private _magazine = _x # 0;
    private _rounds = _x # 1;
    private _container = _x param [4, ""];
    switch (_container) do {
        case "Backpack": {
            private _cargo = backpackContainer player;
            if (!isNull _cargo) then {_cargo addMagazineAmmoCargo [_magazine, 1, _rounds]};
        };
        case "Vest": {
            private _cargo = vestContainer player;
            if (!isNull _cargo) then {_cargo addMagazineAmmoCargo [_magazine, 1, _rounds]};
        };
        case "Uniform": {
            private _cargo = uniformContainer player;
            if (!isNull _cargo) then {_cargo addMagazineAmmoCargo [_magazine, 1, _rounds]};
        };
        default {
            if (_container isNotEqualTo "") then {
                player addWeaponItem [_container, [_magazine, _rounds], true];
            } else {
                player addMagazine [_magazine, _rounds];
            };
        };
    };
} forEach (_profile # 9);
