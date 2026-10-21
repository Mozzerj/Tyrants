params ["_factionId"];
private _f = [_factionId] call TYR_fnc_StateGetFaction;
if ((_f getOrDefault ["controller","human"]) isNotEqualTo "ai") exitWith {};
private _forces = TYR_State get "forces";
private _count = 0;
{
    private _rec = _forces get _x;
    if ((_rec getOrDefault ["faction",""]) isEqualTo _factionId && {_rec getOrDefault ["active",true]}) then {_count = _count + 1};
} forEach keys _forces;
private _difficulty = (_f get "commander") getOrDefault ["difficulty",1];
private _desired = 2 + _difficulty;
for "_i" from _count to (_desired - 1) do {
    private _id = [_factionId,"infantry",false] call TYR_fnc_AIForceCreate;
    if (_id isEqualTo "") exitWith {};
};
