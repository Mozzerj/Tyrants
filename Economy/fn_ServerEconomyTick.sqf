if (!isServer) exitWith {};
// Factories no longer create abstract steel/ammo/fuel. They manufacture real
// queued products in ServerProductionTick. This small baseline represents tax,
// recruitment and general rear-area support that is not tied to factory output.
{
    private _fid = _x;
    private _f = [_fid] call TYR_fnc_StateGetFaction;
    private _r = _f get "resources";
    _r set ["steel",(_r getOrDefault ["steel",0]) + 100];
    _r set ["fuel",(_r getOrDefault ["fuel",0]) + 100];
    _r set ["manpower",(_r getOrDefault ["manpower",0]) + 1];
    [_fid] call TYR_fnc_ServerPublishFaction;
} forEach ([true] call TYR_fnc_FactionIds);
["economy-baseline"] call TYR_fnc_StateMarkDirty;
