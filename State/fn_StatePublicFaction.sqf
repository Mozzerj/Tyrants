params ["_factionId",["_viewerFaction",""]];
private _f = [_factionId] call TYR_fnc_StateGetFaction;
if (count _f isEqualTo 0) exitWith {[]};
private _own = _viewerFaction isEqualTo _factionId;
private _r = _f get "resources";
private _research = _f getOrDefault ["research", createHashMap];
private _keys = keys _research;
_keys sort true;
private _unlocked = if (_own) then {_keys select {_research getOrDefault [_x, false]}} else {[]};
private _base = if (_own) then {+(_f getOrDefault ["basePosition",[]])} else {[]};
private _commandSummary = [];
if (_own) then {
    private _network = _f getOrDefault ["commandNetwork",createHashMap];
    private _personnel = TYR_State getOrDefault ["commandPersonnel",createHashMap];
    private _mainId = _network getOrDefault ["main",""];
    private _main = _personnel getOrDefault [_mainId,createHashMap];
    private _aliveOfficers = 0;
    {
        private _rec = _personnel getOrDefault [_x,createHashMap];
        if (_rec getOrDefault ["alive",false]) then {_aliveOfficers = _aliveOfficers + 1};
    } forEach (_network getOrDefault ["officers",[]]);
    private _delayInfo = [_factionId] call TYR_fnc_CommandOrderDelay;
    private _collapseSince = _network getOrDefault ["collapseSince",-1];
    private _collapseRemaining = if (_collapseSince < 0) then {-1} else {(240 - (serverTime - _collapseSince)) max 0};
    private _commandNodes = [];
    {
        private _rec = _personnel getOrDefault [_x,createHashMap];
        if (count _rec > 0) then {
            _commandNodes pushBack [_x,_rec getOrDefault ["role","officer"],_rec getOrDefault ["name",_x],+(_rec getOrDefault ["position",[]]),_rec getOrDefault ["alive",false]];
        };
    } forEach ([_mainId] + (_network getOrDefault ["officers",[]]));
    _commandSummary = [
        _network getOrDefault ["status","forming"],
        _main getOrDefault ["name","NO COMMANDER"],
        _main getOrDefault ["alive",false],
        _aliveOfficers,
        _network getOrDefault ["targetOfficers",3],
        if (_delayInfo # 0) then {_delayInfo # 1} else {-1},
        _collapseRemaining,
        _commandNodes
    ];
};
private _resources = if (_own) then {[
    _r getOrDefault ["steel",0],
    _r getOrDefault ["ammo",0],
    _r getOrDefault ["fuel",0],
    _r getOrDefault ["manpower",0]
]} else {[-1,-1,-1,-1]};
[
    _factionId,
    _f getOrDefault ["name", toUpper _factionId],
    _f getOrDefault ["active", false],
    _f getOrDefault ["controller", "ai"],
    _base,
    _resources,
    _unlocked,
    if (_own) then {+(_f getOrDefault ["vlsTargets", []])} else {[]},
    if (_own) then {+(_f getOrDefault ["vehiclePool", []])} else {[]},
    _f getOrDefault ["eliminated", false],
    if (_own) then {+(_f getOrDefault ["commanderPublic", []])} else {[]},
    _f getOrDefault ["baseConfirmed",false],
    _commandSummary,
    if (_own) then {
        private _depot = _f getOrDefault ["depotInventory",createHashMap];
        private _dk = keys _depot; _dk sort true;
        private _out = []; {_out pushBack [_x,_depot getOrDefault [_x,0]]} forEach _dk;
        _out
    } else {[]}
]
