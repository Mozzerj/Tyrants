params ["_factionId"];
private _f = [_factionId] call TYR_fnc_StateGetFaction;
if ((_f getOrDefault ["controller","human"]) isNotEqualTo "ai") exitWith {};
private _forces = TYR_State getOrDefault ["forces",createHashMap];
private _count = 0;
{
    private _rec = _forces get _x;
    if ((_rec getOrDefault ["faction",""]) isEqualTo _factionId && {_rec getOrDefault ["active",true]}) then {_count = _count + 1};
} forEach keys _forces;

// The strategic AI now decides when to expand toward its desired force count.
// This helper only guarantees a faction can recover from having literally no force.
if (_count isEqualTo 0) then {[_factionId,"infantry",false] call TYR_fnc_AIForceCreate};
