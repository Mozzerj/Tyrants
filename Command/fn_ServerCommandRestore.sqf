if (!isServer) exitWith {};
{
    private _f = [_x] call TYR_fnc_StateGetFaction;
    if ((_f getOrDefault ["active",false]) && {!(_f getOrDefault ["eliminated",false])}) then {[_x] call TYR_fnc_ServerCommandCreate};
} forEach ["west","east","independent"];
{
    [_x] call TYR_fnc_ServerCommandAssignForce;
} forEach keys (TYR_State getOrDefault ["forces",createHashMap]);
call TYR_fnc_ServerCommandTick;
