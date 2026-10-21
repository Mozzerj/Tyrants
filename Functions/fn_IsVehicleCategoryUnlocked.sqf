params ["_sideIndex", "_categoryIndex"];
if !(_sideIndex in [0, 1]) exitWith {false};
if (_categoryIndex in [10, 11, 12, 13, 14]) exitWith {[_sideIndex, "proc.autonomous"] call TYR_fnc_IsResearchUnlocked};
switch (_categoryIndex) do {
    case 1: {[_sideIndex, "proc.armored"] call TYR_fnc_IsResearchUnlocked};
    case 4: {[_sideIndex, "proc.heavy"] call TYR_fnc_IsResearchUnlocked};
    case 5: {[_sideIndex, "proc.rotary"] call TYR_fnc_IsResearchUnlocked};
    case 2: {[_sideIndex, "proc.artillery"] call TYR_fnc_IsResearchUnlocked};
    case 6: {[_sideIndex, "proc.fixed"] call TYR_fnc_IsResearchUnlocked};
    default {true};
}
