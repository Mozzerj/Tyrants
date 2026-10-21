if (!isServer || {isNil "TYR_State"}) exitWith {[]};

private _pairs = {
    params ["_map"];
    private _ks = keys _map;
    _ks sort true;
    private _out = [];
    {_out pushBack [_x, _map get _x]} forEach _ks;
    _out
};

// Refresh connected player persistence only once the campaign is live.
// Deployment units are staging entities and must never become saved player positions.
private _players = TYR_State get "players";
private _campaign = TYR_State get "campaign";
if ((_campaign getOrDefault ["phase","deployment"]) isEqualTo "running") then {
    {
        private _uid = getPlayerUID _x;
        if (_uid isNotEqualTo "") then {
            private _fid = [side _x] call TYR_fnc_SideFaction;
            private _rec = _players getOrDefault [_uid, createHashMap];
            _rec set ["uid", _uid];
            _rec set ["faction", _fid];
            private _livePos = getPosATL _x;
            if ([_livePos] call TYR_fnc_IsValidLandPosition) then {
                _rec set ["position",[_livePos # 0,_livePos # 1,0.2]];
            };
            _rec set ["direction", getDir _x];
            _rec set ["loadout", getUnitLoadout _x];
            _players set [_uid, _rec];
        };
    } forEach allPlayers;
};
private _settings = _campaign get "settings";
private _deployment = _campaign getOrDefault ["deployment",createHashMap];
private _sectorMap = _deployment getOrDefault ["sectors",createHashMap];
private _sectorIds = keys _sectorMap; _sectorIds sort true;
private _sectorPairs = []; {_sectorPairs pushBack [_x,+(_sectorMap get _x)]} forEach _sectorIds;
private _campaignOut = [
    ["id", _campaign get "id"],
    ["world", _campaign get "world"],
    ["created", +(_campaign get "created")],
    ["phase", _campaign getOrDefault ["phase","running"]],
    ["nextId", _campaign getOrDefault ["nextId",1]],
    ["deployment",[["rotation",_deployment getOrDefault ["rotation",0]],["buffer",_deployment getOrDefault ["buffer",2500]],["sectors",_sectorPairs]]],
    ["settings", [_settings] call _pairs]
];

private _factionsOut = [];
private _factions = TYR_State get "factions";
private _factionKeys = keys _factions;
_factionKeys sort true;
{
    private _f = _factions get _x;
    private _r = _f get "resources";
    private _research = _f get "research";
    private _rk = keys _research;
    _rk sort true;
    private _unlocked = _rk select {_research getOrDefault [_x, false]};
    private _commander = _f getOrDefault ["commander", createHashMap];
    private _commandNetwork = _f getOrDefault ["commandNetwork",createHashMap];
    private _successionAt = _commandNetwork getOrDefault ["successionAt",-1];
    private _replacementAt = _commandNetwork getOrDefault ["replacementAt",-1];
    private _collapseSince = _commandNetwork getOrDefault ["collapseSince",-1];
    private _lastLossAt = _commandNetwork getOrDefault ["lastLossAt",-1];
    private _lastStatusChange = _commandNetwork getOrDefault ["lastStatusChange",-1];
    private _commandNetworkOut = [
        ["status",_commandNetwork getOrDefault ["status","forming"]],
        ["main",_commandNetwork getOrDefault ["main",""]],
        ["officers",+(_commandNetwork getOrDefault ["officers",[]])],
        ["targetOfficers",_commandNetwork getOrDefault ["targetOfficers",3]],
        ["successionRemaining",if (_successionAt < 0) then {-1} else {(_successionAt - serverTime) max 0}],
        ["replacementRemaining",if (_replacementAt < 0) then {-1} else {(_replacementAt - serverTime) max 0}],
        ["collapseElapsed",if (_collapseSince < 0) then {-1} else {(serverTime - _collapseSince) max 0}],
        ["lastLossAge",if (_lastLossAt < 0) then {-1} else {(serverTime - _lastLossAt) max 0}],
        ["lastStatusAge",if (_lastStatusChange < 0) then {-1} else {(serverTime - _lastStatusChange) max 0}]
    ];
    private _knowledge = _f getOrDefault ["knowledge",createHashMap];
    private _knownLocations = _knowledge getOrDefault ["locations",createHashMap];
    private _knowledgeLocationIds = keys _knownLocations;
    _knowledgeLocationIds sort true;
    private _knowledgeLocationsOut = [];
    {
        private _k = _knownLocations get _x;
        _knowledgeLocationsOut pushBack [
            ["id",_x],
            ["owner",_k getOrDefault ["owner","unknown"]],
            ["observedAt",+(_k getOrDefault ["observedAt",[]])],
            ["source",_k getOrDefault ["source",""]]
        ];
    } forEach _knowledgeLocationIds;

    private _knownContacts = _knowledge getOrDefault ["contacts",createHashMap];
    private _knowledgeContactIds = keys _knownContacts;
    _knowledgeContactIds sort true;
    private _knowledgeContactsOut = [];
    {
        private _c = _knownContacts get _x;
        _knowledgeContactsOut pushBack [
            ["id",_x],
            ["targetFaction",_c getOrDefault ["targetFaction",""]],
            ["kind",_c getOrDefault ["kind","unknown"]],
            ["label",_c getOrDefault ["label","CONTACT"]],
            ["exact",_c getOrDefault ["exact",false]],
            ["class",_c getOrDefault ["class",""]],
            ["position",+(_c getOrDefault ["position",[]])],
            ["direction",_c getOrDefault ["direction",0]],
            ["observedAt",+(_c getOrDefault ["observedAt",[]])],
            ["source",_c getOrDefault ["source",""]],
            ["roleTag",_c getOrDefault ["roleTag",""]]
        ];
    } forEach _knowledgeContactIds;
    private _knowledgeLogOut = +(_knowledge getOrDefault ["log",[]]);
    _factionsOut pushBack [
        ["id",_x],
        ["name",_f getOrDefault ["name",toUpper _x]],
        ["active",_f getOrDefault ["active",false]],
        ["eliminated",_f getOrDefault ["eliminated",false]],
        ["controller",_f getOrDefault ["controller","ai"]],
        ["basePosition",+(_f getOrDefault ["basePosition",[]])],
        ["baseConfirmed",_f getOrDefault ["baseConfirmed",false]],
        ["resources",[
            ["steel",_r getOrDefault ["steel",0]],
            ["ammo",_r getOrDefault ["ammo",0]],
            ["fuel",_r getOrDefault ["fuel",0]],
            ["manpower",_r getOrDefault ["manpower",0]]
        ]],
        ["research",_unlocked],
        ["vlsTargets",+(_f getOrDefault ["vlsTargets",[]])],
        ["vehiclePool",+(_f getOrDefault ["vehiclePool",[]])],
        ["commander",[_commander] call _pairs],
        ["commandNetwork",_commandNetworkOut],
        ["knowledge",[["locations",_knowledgeLocationsOut],["contacts",_knowledgeContactsOut],["log",_knowledgeLogOut]]]
    ];
} forEach _factionKeys;

private _locationsOut = [];
private _locations = TYR_State get "locations";
private _locationKeys = keys _locations;
_locationKeys sort true;
{
    private _l = _locations get _x;
    _locationsOut pushBack [
        ["id",_x],
        ["owner",_l getOrDefault ["owner","neutral"]],
        ["stock",_l getOrDefault ["stock",0]]
    ];
} forEach _locationKeys;

private _playersOut = [];
private _playerKeys = keys _players;
_playerKeys sort true;
{
    private _p = _players get _x;
    private _pfid = _p getOrDefault ["faction",""];
    private _savedPos = +(_p getOrDefault ["position",[]]);
    if !([_savedPos] call TYR_fnc_IsValidLandPosition) then {
        private _pf = [_pfid] call TYR_fnc_StateGetFaction;
        _savedPos = [_savedPos,_pf getOrDefault ["basePosition",[]]] call TYR_fnc_FindSafeSpawnPosition;
    };
    _playersOut pushBack [
        ["uid",_x],
        ["faction",_pfid],
        ["position",_savedPos],
        ["direction",_p getOrDefault ["direction",0]],
        ["loadout",+(_p getOrDefault ["loadout",[]])]
    ];
} forEach _playerKeys;

private _vehiclesOut = [];
private _vehicleMap = TYR_State get "vehicles";
private _runtimeVehicles = TYR_Runtime getOrDefault ["vehicles",createHashMap];
private _vehicleKeys = keys _vehicleMap;
_vehicleKeys sort true;
{
    private _v = _vehicleMap get _x;
    private _obj = _runtimeVehicles getOrDefault [_x,objNull];
    private _pos = +(_v getOrDefault ["position",[0,0,0]]);
    private _dir = _v getOrDefault ["direction",0];
    private _damage = _v getOrDefault ["damage",0];
    private _fuel = _v getOrDefault ["fuel",1];
    private _ammo = _v getOrDefault ["ammo",1];
    private _cargo = _v getOrDefault ["cargo",[[],[],[],[]]];
    if (!isNull _obj) then {
        _pos = getPosATL _obj;
        _dir = getDir _obj;
        _damage = damage _obj;
        _fuel = fuel _obj;
        _ammo = vehicleAmmo _obj;
        _cargo = [getWeaponCargo _obj,getMagazineCargo _obj,getItemCargo _obj,getBackpackCargo _obj];
    };
    _vehiclesOut pushBack [
        ["id",_x],
        ["faction",_v get "faction"],
        ["class",_v get "class"],
        ["position",_pos],
        ["direction",_dir],
        ["damage",_damage],
        ["fuel",_fuel],
        ["ammo",_ammo],
        ["cargo",_cargo]
    ];
} forEach _vehicleKeys;

private _emplacementsOut = [];
private _empMap = TYR_State get "emplacements";
private _runtimeEmp = TYR_Runtime getOrDefault ["emplacements",createHashMap];
private _empKeys = keys _empMap;
_empKeys sort true;
{
    private _e = _empMap get _x;
    private _obj = _runtimeEmp getOrDefault [_x,objNull];
    private _pos = +(_e getOrDefault ["position",[0,0,0]]);
    private _dir = _e getOrDefault ["direction",0];
    private _damage = _e getOrDefault ["damage",0];
    private _ammo = _e getOrDefault ["ammo",1];
    if (!isNull _obj) then {
        _pos = getPosATL _obj;
        _dir = getDir _obj;
        _damage = damage _obj;
        _ammo = vehicleAmmo _obj;
    };
    _emplacementsOut pushBack [
        ["id",_x],
        ["faction",_e get "faction"],
        ["key",_e get "key"],
        ["class",_e get "class"],
        ["position",_pos],
        ["direction",_dir],
        ["damage",_damage],
        ["ammo",_ammo]
    ];
} forEach _empKeys;

private _forcesOut = [];
private _forces = TYR_State get "forces";
private _runtimeForces = TYR_Runtime getOrDefault ["forces",createHashMap];
private _forceKeys = keys _forces;
_forceKeys sort true;
{
    private _f = _forces get _x;
    private _grp = _runtimeForces getOrDefault [_x,grpNull];
    private _classes = +(_f getOrDefault ["unitClasses",[]]);
    private _pos = +(_f getOrDefault ["position",[0,0,0]]);
    if (!isNull _grp) then {
        private _alive = (units _grp) select {alive _x};
        _classes = _alive apply {typeOf _x};
        if (count _alive > 0) then {_pos = getPosATL leader _grp};
    };
    _forcesOut pushBack [
        ["id",_x],
        ["faction",_f get "faction"],
        ["role",_f getOrDefault ["role","infantry"]],
        ["position",_pos],
        ["unitClasses",_classes],
        ["operation",_f getOrDefault ["operation",""]],
        ["commandOfficer",_f getOrDefault ["commandOfficer",""]],
        ["commandState",_f getOrDefault ["commandState","local"]],
        ["active",count _classes > 0]
    ];
} forEach _forceKeys;

private _operationsOut = [];
private _operations = TYR_State get "operations";
private _operationKeys = keys _operations;
_operationKeys sort true;
{
    private _o = _operations get _x;
    _operationsOut pushBack [
        ["id",_x],
        ["faction",_o get "faction"],
        ["type",_o getOrDefault ["type","attack"]],
        ["target",_o getOrDefault ["target",""]],
        ["targetType",_o getOrDefault ["targetType","location"]],
        ["targetName",_o getOrDefault ["targetName",_o getOrDefault ["target",""]]],
        ["targetPosition",+(_o getOrDefault ["targetPosition",[]])],
        ["phase",_o getOrDefault ["phase","assemble"]],
        ["forces",+(_o getOrDefault ["forces",[]])],
        ["created",_o getOrDefault ["created",0]],
        ["score",_o getOrDefault ["score",0]],
        ["reason",_o getOrDefault ["reason",""]],
        ["posture",_o getOrDefault ["posture","hold"]],
        ["outcomeReason",_o getOrDefault ["outcomeReason",""]],
        ["orderId",_o getOrDefault ["orderId",""]],
        ["commandDelay",_o getOrDefault ["commandDelay",0]],
        ["commandDeliveredAt",_o getOrDefault ["commandDeliveredAt",-1]]
    ];
} forEach _operationKeys;

private _commandPersonnelOut = [];
private _commandPersonnel = TYR_State getOrDefault ["commandPersonnel",createHashMap];
private _runtimeCommand = TYR_Runtime getOrDefault ["commandPersonnel",createHashMap];
private _commandPersonIds = keys _commandPersonnel;
_commandPersonIds sort true;
{
    private _c = _commandPersonnel get _x;
    private _obj = _runtimeCommand getOrDefault [_x,objNull];
    private _pos = +(_c getOrDefault ["position",[]]);
    if (!isNull _obj) then {_pos = getPosATL _obj};
    _commandPersonnelOut pushBack [
        ["id",_x],["faction",_c getOrDefault ["faction",""]],["role",_c getOrDefault ["role","officer"]],
        ["name",_c getOrDefault ["name",_x]],["rank",_c getOrDefault ["rank",0]],["alive",_c getOrDefault ["alive",false]],
        ["position",_pos],["class",_c getOrDefault ["class",""]],["createdAt",_c getOrDefault ["createdAt",0]],
        ["deathAt",_c getOrDefault ["deathAt",-1]]
    ];
} forEach _commandPersonIds;

private _commandOrdersOut = [];
private _commandOrders = TYR_State getOrDefault ["commandOrders",createHashMap];
private _commandOrderIds = keys _commandOrders;
_commandOrderIds sort true;
{
    private _o = _commandOrders get _x;
    private _forceId = _o getOrDefault ["force",""];
    private _operationId = _o getOrDefault ["operation",""];
    if (_forceId in keys _forces && {_operationId in keys _operations}) then {
        _commandOrdersOut pushBack [
            ["id",_x],["faction",_o getOrDefault ["faction",""]],["force",_forceId],
            ["operation",_operationId],["target",_o getOrDefault ["target",""]],
            ["issuedAge",(serverTime - (_o getOrDefault ["issuedAt",serverTime])) max 0],
            ["remaining",((_o getOrDefault ["deliverAt",serverTime]) - serverTime) max 0],
            ["status",_o getOrDefault ["status","pending"]],["route",+(_o getOrDefault ["route",[]])],
            ["reroutes",_o getOrDefault ["reroutes",0]]
        ];
    };
} forEach _commandOrderIds;

[
    ["campaign",_campaignOut],
    ["factions",_factionsOut],
    ["locations",_locationsOut],
    ["players",_playersOut],
    ["vehicles",_vehiclesOut],
    ["emplacements",_emplacementsOut],
    ["forces",_forcesOut],
    ["operations",_operationsOut],
    ["commandPersonnel",_commandPersonnelOut],
    ["commandOrders",_commandOrdersOut],
    ["destroyedBuildings",+(TYR_State getOrDefault ["destroyedBuildings",[]])]
]
