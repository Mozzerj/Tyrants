if (!isServer) exitWith {};
private _wanted = TYR_State getOrDefault ["destroyedBuildings",[]];
if (count _wanted isEqualTo 0) exitWith {};
private _center = [worldSize*0.5,worldSize*0.5,0];
{
    private _parts = _x splitString "@,";
    if (count _parts >= 3) then {
        private _class = _parts # 0;
        private _pos = [parseNumber (_parts # 1),parseNumber (_parts # 2),0];
        private _near = nearestObjects [_pos,[_class],20];
        if (count _near > 0) then {(_near # 0) setDamage [1,false]};
    };
} forEach _wanted;
