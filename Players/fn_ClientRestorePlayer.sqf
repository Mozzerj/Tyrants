params ["_position","_direction","_loadout"];
if (_loadout isEqualType [] && {count _loadout > 0}) then {
    player setUnitLoadout _loadout;
};
private _safe = [_position,[]] call TYR_fnc_FindSafeSpawnPosition;
if (count _safe < 2) exitWith {
    diag_log format ["[TYRANTS SPAWN] Client rejected invalid restore position: %1",_position];
    missionNamespace setVariable ["TYR_PlayerRestored",false];
};
player setPosATL _safe;
player setDir _direction;
missionNamespace setVariable ["TYR_PlayerRestored",true];
