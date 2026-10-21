if (!isServer) exitWith {false};
private _campaign = TYR_State get "campaign";
if ((_campaign getOrDefault ["phase","deployment"]) isNotEqualTo "deployment") exitWith {true};
private _active = [true] call TYR_fnc_FactionIds;
if ((_active findIf {!(([_x] call TYR_fnc_StateGetFaction) getOrDefault ["baseConfirmed",false])}) >= 0) exitWith {false};

private _locations = TYR_State get "locations";
private _changedLocations = [];
// Each faction starts with a small enclave, but its exact HQ remains private.
{
    private _fid = _x;
    private _base = ([_fid] call TYR_fnc_StateGetFaction) get "basePosition";
    private _ranked = [];
    {
        private _l = _locations get _x;
        _ranked pushBack [_base distance2D (_l get "position"),_x];
    } forEach keys _locations;
    _ranked sort true;
    private _claimed = 0;
    {
        if (_claimed >= 3) exitWith {};
        private _lid = _x # 1;
        private _l = _locations get _lid;
        if ((_l getOrDefault ["owner","neutral"]) isEqualTo "neutral") then {
            _l set ["owner",_fid];
            _changedLocations pushBackUnique _lid;
            _claimed = _claimed + 1;
        };
    } forEach _ranked;
} forEach _active;

_campaign set ["phase","running"];
[true] call TYR_fnc_ServerSetCombatState;
call TYR_fnc_ServerCreateBases;
["deployment-complete",true] call TYR_fnc_StateMarkDirty;
{[_x] call TYR_fnc_ServerPublishLocation} forEach _changedLocations;
call TYR_fnc_ServerPublishDeployment;
diag_log format ["[TYRANTS DEPLOYMENT] Campaign started with %1 active factions.",count _active];
true
