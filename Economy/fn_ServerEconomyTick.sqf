if (!isServer) exitWith {};
private _locations = TYR_State get "locations";
private _income = createHashMap;
{
    _income set [_x,createHashMapFromArray [["steel",250],["ammo",250],["fuel",250],["manpower",1]]];
} forEach ([true] call TYR_fnc_FactionIds);

{
    private _l = _locations get _x;
    if ((_l getOrDefault ["kind",""]) isEqualTo "factory") then {
        private _owner = _l getOrDefault ["owner","neutral"];
        if (_owner in ([true] call TYR_fnc_FactionIds)) then {
            private _resource = _l getOrDefault ["resource","steel"];
            private _production = 250;
            if ([_owner,"infra.factory"] call TYR_fnc_StateResearchUnlocked) then {_production = _production * 1.25};
            _l set ["stock",(_l getOrDefault ["stock",0]) + _production];
            [_x,_owner] call TYR_fnc_ServerPublishLocation;
        };
    };
} forEach keys _locations;

{
    private _fid = _x;
    private _f = [_fid] call TYR_fnc_StateGetFaction;
    private _r = _f get "resources";
    private _inc = _income get _fid;
    {
        _r set [_x,(_r getOrDefault [_x,0]) + (_inc get _x)];
    } forEach ["steel","ammo","fuel","manpower"];
    [_fid] call TYR_fnc_ServerPublishFaction;
} forEach ([true] call TYR_fnc_FactionIds);
["economy"] call TYR_fnc_StateMarkDirty;
