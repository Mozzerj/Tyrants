params ["_factionId"];
if (!isServer) exitWith {createHashMap};
private _f = [_factionId] call TYR_fnc_StateGetFaction;
if (count _f isEqualTo 0) exitWith {createHashMap};

private _forcesState = TYR_State getOrDefault ["forces",createHashMap];
private _forcesRuntime = TYR_Runtime getOrDefault ["forces",createHashMap];
private _activeForces = [];
private _freeForces = [];
private _forcePositions = createHashMap;
{
    private _id = _x;
    private _rec = _forcesState get _id;
    if ((_rec getOrDefault ["faction",""]) isEqualTo _factionId && {_rec getOrDefault ["active",true]}) then {
        private _grp = _forcesRuntime getOrDefault [_id,grpNull];
        private _pos = +(_rec getOrDefault ["position",[]]);
        private _aliveCount = 0;
        if (!isNull _grp) then {
            private _alive = (units _grp) select {alive _x};
            _aliveCount = count _alive;
            if (_aliveCount > 0) then {_pos = getPosATL leader _grp};
        };
        if (_aliveCount > 0 || {isNull _grp}) then {
            _activeForces pushBack _id;
            _forcePositions set [_id,_pos];
            if ((_rec getOrDefault ["operation",""]) isEqualTo "") then {_freeForces pushBack _id};
        };
    };
} forEach keys _forcesState;

private _operations = TYR_State getOrDefault ["operations",createHashMap];
private _activeOperations = [];
{
    private _op = _operations get _x;
    if ((_op getOrDefault ["faction",""]) isEqualTo _factionId && {!((_op getOrDefault ["phase",""]) in ["complete","failed"])}) then {
        _activeOperations pushBack _x;
    };
} forEach keys _operations;

private _locations = TYR_State getOrDefault ["locations",createHashMap];
private _knowledge = _f getOrDefault ["knowledge",createHashMap];
private _knownLocations = _knowledge getOrDefault ["locations",createHashMap];
private _contactsMap = _knowledge getOrDefault ["contacts",createHashMap];
private _ownLocations = [];
private _believedFriendlyLocations = [];
private _knownHostile = [];
private _knownNeutral = [];
private _unknownLocations = [];

{
    private _id = _x;
    private _loc = _locations get _id;
    private _trueOwner = _loc getOrDefault ["owner","neutral"];
    private _pos = +(_loc getOrDefault ["position",[]]);
    private _value = _loc getOrDefault ["value",1];
    private _name = _loc getOrDefault ["name",_id];
    if (_trueOwner isEqualTo _factionId) then {
        // Current friendly ownership is own-state truth and therefore legitimate.
        _ownLocations pushBack [_id,_name,_pos,_value,0];
    } else {
        // For everything not currently ours, strategic classification comes only
        // from collected faction knowledge. This deliberately permits stale beliefs.
        private _intel = _knownLocations getOrDefault [_id,createHashMap];
        private _knownOwner = _intel getOrDefault ["owner","unknown"];
        private _seen = _intel getOrDefault ["seenServerTime",-1];
        private _age = if (_seen < 0) then {1e9} else {(serverTime - _seen) max 0};
        private _row = [_id,_name,_pos,_value,_knownOwner,_age];
        if (_knownOwner isEqualTo _factionId) then {
            _believedFriendlyLocations pushBack _row;
        } else {
            switch (_knownOwner) do {
                case "unknown": {_unknownLocations pushBack _row};
                case "neutral": {_knownNeutral pushBack _row};
                default {_knownHostile pushBack _row};
            };
        };
    };
} forEach keys _locations;

private _contacts = [];
{
    private _id = _x;
    private _c = _contactsMap get _id;
    private _seen = _c getOrDefault ["seenServerTime",-9999];
    private _age = (serverTime - _seen) max 0;
    _contacts pushBack [
        _id,
        _c getOrDefault ["targetFaction",""],
        _c getOrDefault ["kind","unknown"],
        _c getOrDefault ["label","CONTACT"],
        +(_c getOrDefault ["position",[]]),
        _age,
        _c getOrDefault ["exact",false],
        _c getOrDefault ["source",""],
        _c getOrDefault ["roleTag",""]
    ];
} forEach keys _contactsMap;

private _base = +(_f getOrDefault ["basePosition",[]]);
private _emergencyThreats = [];
{
    _x params ["_id","_enemyFaction","_kind","_label","_pos","_age","_exact","_source","_roleTag"];
    if (_age <= 150 && {count _pos >= 2}) then {
        if (count _base >= 2 && {_base distance2D _pos <= 2000}) then {
            _emergencyThreats pushBack ["hq",_id,_label,_pos,_age,_base distance2D _pos,"HQ"];
        };
        {
            _x params ["_locId","_locName","_locPos","_locValue"];
            private _dist = _locPos distance2D _pos;
            if (_dist <= (700 + (_locValue * 80))) then {
                _emergencyThreats pushBack ["location",_id,_label,_pos,_age,_dist,_locId];
            };
        } forEach _ownLocations;
    };
} forEach _contacts;

private _difficulty = (_f getOrDefault ["commander",createHashMap]) getOrDefault ["difficulty",1];
private _desiredForces = 2 + _difficulty;
private _network = [_factionId] call TYR_fnc_CommandNetworkGet;

createHashMapFromArray [
    ["faction",_factionId],
    ["base",_base],
    ["resources",_f getOrDefault ["resources",createHashMap]],
    ["research",_f getOrDefault ["research",createHashMap]],
    ["command",_f getOrDefault ["commander",createHashMap]],
    ["networkStatus",_network getOrDefault ["status","forming"]],
    ["activeForces",_activeForces],
    ["freeForces",_freeForces],
    ["forcePositions",_forcePositions],
    ["forceCount",count _activeForces],
    ["availableCount",count _freeForces],
    ["desiredForces",_desiredForces],
    ["activeOperations",_activeOperations],
    ["ownLocations",_ownLocations],
    ["believedFriendlyLocations",_believedFriendlyLocations],
    ["knownHostileLocations",_knownHostile],
    ["knownNeutralLocations",_knownNeutral],
    ["unknownLocations",_unknownLocations],
    ["contacts",_contacts],
    ["emergencyThreats",_emergencyThreats]
]
