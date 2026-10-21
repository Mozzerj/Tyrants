params ["_preferred",["_fallback",[]]];
private _offsets = [
    [0,0],[5,0],[-5,0],[0,5],[0,-5],[5,5],[-5,5],[5,-5],[-5,-5],
    [10,0],[-10,0],[0,10],[0,-10],[10,10],[-10,10],[10,-10],[-10,-10]
];
private _result = [];
{
    private _anchor = _x;
    if ([_anchor] call TYR_fnc_IsValidLandPosition) then {
        {
            private _candidate = [(_anchor # 0) + (_x # 0),(_anchor # 1) + (_x # 1),0.2];
            if ([_candidate] call TYR_fnc_IsValidLandPosition) then {
                if ((count (nearestObjects [_candidate,["AllVehicles"],2.25])) isEqualTo 0) exitWith {_result = _candidate};
            };
        } forEach _offsets;
        if (count _result >= 2) exitWith {};
        _result = [_anchor # 0,_anchor # 1,0.2];
    };
    if (count _result >= 2) exitWith {};
} forEach [_preferred,_fallback];
_result
