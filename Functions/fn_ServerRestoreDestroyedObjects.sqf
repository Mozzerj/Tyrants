if (!isServer) exitWith {};

{
    if (_x isEqualType [] && {count _x >= 2}) then {
        private _class = _x # 0;
        private _pos = _x # 1;
        private _matches = nearestObjects [_pos, [_class], 8, true];
        if (count _matches > 0) then {
            (_matches # 0) setDamage [1, true];
        };
    };
} forEach (GameData # 2 # 0);

TYR_destroyedVehicleObjects = [];
{
    if (_x isEqualType [] && {count _x >= 3}) then {
        private _wreck = [_x # 0, _x # 2, _x # 1, TYR_destroyedVehicleObjects] call TYR_fnc_destroyedVehicle;
        TYR_destroyedVehicleObjects = _wreck;
    };
} forEach (GameData # 2 # 1);

{
    _x enableSimulationGlobal false;
} forEach TYR_destroyedVehicleObjects;
