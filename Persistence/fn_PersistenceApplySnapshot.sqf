params ["_snapshot"];
if (!isServer) exitWith {false};

private _state = call TYR_fnc_StateCreateCampaign;
private _campaignSaved = [_snapshot,"campaign",[]] call TYR_fnc_RecordGet;
private _campaign = _state get "campaign";
_campaign set ["id",[_campaignSaved,"id",_campaign get "id"] call TYR_fnc_RecordGet];
_campaign set ["created",[_campaignSaved,"created",systemTime] call TYR_fnc_RecordGet];
_campaign set ["phase",[_campaignSaved,"phase","running"] call TYR_fnc_RecordGet];
_campaign set ["nextId",[_campaignSaved,"nextId",1] call TYR_fnc_RecordGet];
private _depSaved = [_campaignSaved,"deployment",[]] call TYR_fnc_RecordGet;
private _dep = createHashMapFromArray [["rotation",[_depSaved,"rotation",0] call TYR_fnc_RecordGet],["buffer",[_depSaved,"buffer",2500] call TYR_fnc_RecordGet],["sectors",createHashMap]];
{if (_x isEqualType [] && {count _x >= 2}) then {(_dep get "sectors") set [_x # 0,+(_x # 1)]}} forEach ([_depSaved,"sectors",[]] call TYR_fnc_RecordGet);
_campaign set ["deployment",_dep];
private _settingsSaved = [_campaignSaved,"settings",[]] call TYR_fnc_RecordGet;
private _settings = _campaign get "settings";
{_settings set [_x # 0,_x # 1]} forEach _settingsSaved;

private _defs = call TYR_fnc_GetResearchDefinitions;
private _factions = _state get "factions";
{
    private _id = [_x,"id",""] call TYR_fnc_RecordGet;
    if (_id in ["west","east","independent"]) then {
        private _f = _factions get _id;
        _f set ["name",[_x,"name",_f get "name"] call TYR_fnc_RecordGet];
        _f set ["active",[_x,"active",true] call TYR_fnc_RecordGet];
        _f set ["eliminated",[_x,"eliminated",false] call TYR_fnc_RecordGet];
        _f set ["controller",[_x,"controller","ai"] call TYR_fnc_RecordGet];
        _f set ["basePosition",+([_x,"basePosition",[]] call TYR_fnc_RecordGet)];
        _f set ["baseConfirmed",[_x,"baseConfirmed",false] call TYR_fnc_RecordGet];
        _f set ["vlsTargets",+([_x,"vlsTargets",[]] call TYR_fnc_RecordGet)];
        _f set ["vehiclePool",+([_x,"vehiclePool",[]] call TYR_fnc_RecordGet)];
        private _resSaved = [_x,"resources",[]] call TYR_fnc_RecordGet;
        private _r = _f get "resources";
        {
            _r set [_x,[_resSaved,_x,_r get _x] call TYR_fnc_RecordGet];
        } forEach ["steel","ammo","fuel","manpower"];
        private _research = createHashMap;
        {_research set [_x # 0,false]} forEach _defs;
        {if (_x in keys _research) then {_research set [_x,true]}} forEach ([_x,"research",[]] call TYR_fnc_RecordGet);
        _f set ["research",_research];
        private _cmd = _f get "commander";
        {if (_x isEqualType [] && {count _x >= 2}) then {_cmd set [_x # 0,_x # 1]}} forEach ([_x,"commander",[]] call TYR_fnc_RecordGet);
        private _network = _f getOrDefault ["commandNetwork",createHashMap];
        private _networkSaved = [_x,"commandNetwork",[]] call TYR_fnc_RecordGet;
        if (_networkSaved isEqualType [] && {count _networkSaved > 0}) then {
            _network set ["status",[_networkSaved,"status","forming"] call TYR_fnc_RecordGet];
            _network set ["main",[_networkSaved,"main",""] call TYR_fnc_RecordGet];
            _network set ["officers",+([_networkSaved,"officers",[]] call TYR_fnc_RecordGet)];
            _network set ["targetOfficers",[_networkSaved,"targetOfficers",3] call TYR_fnc_RecordGet];
            private _successionRemaining = [_networkSaved,"successionRemaining",-1] call TYR_fnc_RecordGet;
            private _replacementRemaining = [_networkSaved,"replacementRemaining",-1] call TYR_fnc_RecordGet;
            private _collapseElapsed = [_networkSaved,"collapseElapsed",-1] call TYR_fnc_RecordGet;
            private _lastLossAge = [_networkSaved,"lastLossAge",-1] call TYR_fnc_RecordGet;
            private _lastStatusAge = [_networkSaved,"lastStatusAge",-1] call TYR_fnc_RecordGet;
            _network set ["successionAt",if (_successionRemaining < 0) then {-1} else {serverTime + _successionRemaining}];
            _network set ["replacementAt",if (_replacementRemaining < 0) then {-1} else {serverTime + _replacementRemaining}];
            _network set ["collapseSince",if (_collapseElapsed < 0) then {-1} else {serverTime - _collapseElapsed}];
            _network set ["lastLossAt",if (_lastLossAge < 0) then {-1} else {serverTime - _lastLossAge}];
            _network set ["lastStatusChange",if (_lastStatusAge < 0) then {serverTime} else {serverTime - _lastStatusAge}];
        };
        _f set ["commandNetwork",_network];
        private _depot = createHashMap;
        {if (_x isEqualType [] && {count _x >= 2}) then {_depot set [_x # 0,_x # 1]}} forEach ([_x,"depotInventory",[]] call TYR_fnc_RecordGet);
        _f set ["depotInventory",_depot];
        private _knowledgeSaved = [_x,"knowledge",[]] call TYR_fnc_RecordGet;
        private _knowledge = createHashMapFromArray [["locations",createHashMap],["contacts",createHashMap],["log",[]]];
        private _knownLocations = _knowledge get "locations";
        {
            private _locationId = [_x,"id",""] call TYR_fnc_RecordGet;
            if (_locationId isNotEqualTo "") then {
                _knownLocations set [_locationId,createHashMapFromArray [
                    ["owner",[_x,"owner","unknown"] call TYR_fnc_RecordGet],
                    ["observedAt",+([_x,"observedAt",[]] call TYR_fnc_RecordGet)],
                    ["seenServerTime",-9999],
                    ["source",[_x,"source",""] call TYR_fnc_RecordGet]
                ]];
            };
        } forEach ([_knowledgeSaved,"locations",[]] call TYR_fnc_RecordGet);

        private _knownContacts = _knowledge get "contacts";
        {
            private _contactId = [_x,"id",""] call TYR_fnc_RecordGet;
            if (_contactId isNotEqualTo "") then {
                _knownContacts set [_contactId,createHashMapFromArray [
                    ["id",_contactId],
                    ["targetFaction",[_x,"targetFaction",""] call TYR_fnc_RecordGet],
                    ["kind",[_x,"kind","unknown"] call TYR_fnc_RecordGet],
                    ["label",[_x,"label","CONTACT"] call TYR_fnc_RecordGet],
                    ["exact",[_x,"exact",false] call TYR_fnc_RecordGet],
                    ["class",[_x,"class",""] call TYR_fnc_RecordGet],
                    ["position",+([_x,"position",[]] call TYR_fnc_RecordGet)],
                    ["direction",[_x,"direction",0] call TYR_fnc_RecordGet],
                    ["observedAt",+([_x,"observedAt",[]] call TYR_fnc_RecordGet)],
                    ["seenServerTime",-9999],
                    ["source",[_x,"source",""] call TYR_fnc_RecordGet],
                    ["roleTag",[_x,"roleTag",""] call TYR_fnc_RecordGet],
                    ["publishedAt",-9999]
                ]];
            };
        } forEach ([_knowledgeSaved,"contacts",[]] call TYR_fnc_RecordGet);
        private _savedLog = [_knowledgeSaved,"log",[]] call TYR_fnc_RecordGet;
        if (_savedLog isEqualType []) then {_knowledge set ["log",+_savedLog]};
        _f set ["knowledge",_knowledge];
    };
} forEach ([_snapshot,"factions",[]] call TYR_fnc_RecordGet);

private _loadedLocationState = createHashMap;
{
    private _id = [_x,"id",""] call TYR_fnc_RecordGet;
    if (_id isNotEqualTo "") then {
        private _inv = createHashMap;
        {if (_x isEqualType [] && {count _x >= 2}) then {_inv set [_x # 0,_x # 1]}} forEach ([_x,"inventory",[]] call TYR_fnc_RecordGet);
        private _queue = [];
        {
            _queue pushBack (createHashMapFromArray [
                ["id",[_x,"id",""] call TYR_fnc_RecordGet],["product",[_x,"product",""] call TYR_fnc_RecordGet],["display",[_x,"display",""] call TYR_fnc_RecordGet],
                ["category",[_x,"category",""] call TYR_fnc_RecordGet],["amount",[_x,"amount",0] call TYR_fnc_RecordGet],["class",[_x,"class",""] call TYR_fnc_RecordGet],
                ["startAt",serverTime + ([_x,"startRemaining",0] call TYR_fnc_RecordGet)],["finishAt",serverTime + ([_x,"finishRemaining",0] call TYR_fnc_RecordGet)],
                ["duration",[_x,"duration",0] call TYR_fnc_RecordGet],["reason",[_x,"reason",""] call TYR_fnc_RecordGet],["requestedBy",[_x,"requestedBy",""] call TYR_fnc_RecordGet]
            ]);
        } forEach ([_x,"productionQueue",[]] call TYR_fnc_RecordGet);
        private _lastAge = [_x,"lastProductionAge",-1] call TYR_fnc_RecordGet;
        _loadedLocationState set [_id,createHashMapFromArray [
            ["owner",[_x,"owner","neutral"] call TYR_fnc_RecordGet],["stock",0],
            ["factoryType",[_x,"factoryType",""] call TYR_fnc_RecordGet],["inventory",_inv],["productionQueue",_queue],
            ["lastProduction",if (_lastAge < 0) then {-1} else {serverTime-_lastAge}],["lastProductionText",[_x,"lastProductionText",""] call TYR_fnc_RecordGet]
        ]];
    };
} forEach ([_snapshot,"locations",[]] call TYR_fnc_RecordGet);
TYR_Runtime set ["loadedLocations",_loadedLocationState];

private _players = createHashMap;
{
    private _uid = [_x,"uid",""] call TYR_fnc_RecordGet;
    if (_uid isNotEqualTo "") then {
        private _loadedPos = +([_x,"position",[]] call TYR_fnc_RecordGet);
        if !([_loadedPos] call TYR_fnc_IsValidLandPosition) then {_loadedPos = []};
        _players set [_uid,createHashMapFromArray [
            ["uid",_uid],
            ["faction",[_x,"faction",""] call TYR_fnc_RecordGet],
            ["position",_loadedPos],
            ["direction",[_x,"direction",0] call TYR_fnc_RecordGet],
            ["loadout",+([_x,"loadout",[]] call TYR_fnc_RecordGet)]
        ]];
    };
} forEach ([_snapshot,"players",[]] call TYR_fnc_RecordGet);
_state set ["players",_players];

private _vehicles = createHashMap;
{
    private _id = [_x,"id",""] call TYR_fnc_RecordGet;
    if (_id isNotEqualTo "") then {
        _vehicles set [_id,createHashMapFromArray [
            ["id",_id],["faction",[_x,"faction",""] call TYR_fnc_RecordGet],["class",[_x,"class",""] call TYR_fnc_RecordGet],
            ["position",+([_x,"position",[0,0,0]] call TYR_fnc_RecordGet)],["direction",[_x,"direction",0] call TYR_fnc_RecordGet],
            ["damage",[_x,"damage",0] call TYR_fnc_RecordGet],["fuel",[_x,"fuel",1] call TYR_fnc_RecordGet],
            ["ammo",[_x,"ammo",1] call TYR_fnc_RecordGet],["cargo",+([_x,"cargo",[[],[],[],[]]] call TYR_fnc_RecordGet)]
        ]];
    };
} forEach ([_snapshot,"vehicles",[]] call TYR_fnc_RecordGet);
_state set ["vehicles",_vehicles];

private _emps = createHashMap;
{
    private _id = [_x,"id",""] call TYR_fnc_RecordGet;
    if (_id isNotEqualTo "") then {
        _emps set [_id,createHashMapFromArray [
            ["id",_id],["faction",[_x,"faction",""] call TYR_fnc_RecordGet],["key",[_x,"key",""] call TYR_fnc_RecordGet],
            ["class",[_x,"class",""] call TYR_fnc_RecordGet],["position",+([_x,"position",[0,0,0]] call TYR_fnc_RecordGet)],
            ["direction",[_x,"direction",0] call TYR_fnc_RecordGet],["damage",[_x,"damage",0] call TYR_fnc_RecordGet],
            ["ammo",[_x,"ammo",1] call TYR_fnc_RecordGet]
        ]];
    };
} forEach ([_snapshot,"emplacements",[]] call TYR_fnc_RecordGet);
_state set ["emplacements",_emps];

private _forces = createHashMap;
{
    private _id = [_x,"id",""] call TYR_fnc_RecordGet;
    if (_id isNotEqualTo "") then {
        private _supply = createHashMap;
        {if (_x isEqualType [] && {count _x >= 2}) then {_supply set [_x # 0,_x # 1]}} forEach ([_x,"supply",[["ammo",100],["fuel",100]]] call TYR_fnc_RecordGet);
        if (count _supply isEqualTo 0) then {_supply = createHashMapFromArray [["ammo",100],["fuel",100]]};
        _forces set [_id,createHashMapFromArray [
            ["id",_id],["faction",[_x,"faction",""] call TYR_fnc_RecordGet],["role",[_x,"role","infantry"] call TYR_fnc_RecordGet],
            ["position",+([_x,"position",[0,0,0]] call TYR_fnc_RecordGet)],["unitClasses",+([_x,"unitClasses",[]] call TYR_fnc_RecordGet)],
            ["operation",[_x,"operation",""] call TYR_fnc_RecordGet],["commandOfficer",[_x,"commandOfficer",""] call TYR_fnc_RecordGet],
            ["commandState",[_x,"commandState","local"] call TYR_fnc_RecordGet],["supply",_supply],["active",[_x,"active",true] call TYR_fnc_RecordGet]
        ]];
    };
} forEach ([_snapshot,"forces",[]] call TYR_fnc_RecordGet);
_state set ["forces",_forces];

private _operations = createHashMap;
{
    private _id = [_x,"id",""] call TYR_fnc_RecordGet;
    if (_id isNotEqualTo "") then {
        _operations set [_id,createHashMapFromArray [
            ["id",_id],["faction",[_x,"faction",""] call TYR_fnc_RecordGet],["type",[_x,"type","attack"] call TYR_fnc_RecordGet],
            ["target",[_x,"target",""] call TYR_fnc_RecordGet],["targetType",[_x,"targetType","location"] call TYR_fnc_RecordGet],
            ["targetName",[_x,"targetName",[_x,"target",""] call TYR_fnc_RecordGet] call TYR_fnc_RecordGet],
            ["targetPosition",+([_x,"targetPosition",[]] call TYR_fnc_RecordGet)],["phase",[_x,"phase","assemble"] call TYR_fnc_RecordGet],
            ["forces",+([_x,"forces",[]] call TYR_fnc_RecordGet)],["created",[_x,"created",0] call TYR_fnc_RecordGet],
            ["score",[_x,"score",0] call TYR_fnc_RecordGet],["reason",[_x,"reason",""] call TYR_fnc_RecordGet],
            ["posture",[_x,"posture","hold"] call TYR_fnc_RecordGet],["outcomeReason",[_x,"outcomeReason",""] call TYR_fnc_RecordGet],
            ["orderId",[_x,"orderId",""] call TYR_fnc_RecordGet],["commandDelay",[_x,"commandDelay",0] call TYR_fnc_RecordGet],
            ["commandDeliveredAt",[_x,"commandDeliveredAt",-1] call TYR_fnc_RecordGet]
        ]];
    };
} forEach ([_snapshot,"operations",[]] call TYR_fnc_RecordGet);
_state set ["operations",_operations];

private _commandPersonnel = createHashMap;
{
    private _id = [_x,"id",""] call TYR_fnc_RecordGet;
    if (_id isNotEqualTo "") then {
        _commandPersonnel set [_id,createHashMapFromArray [
            ["id",_id],["faction",[_x,"faction",""] call TYR_fnc_RecordGet],["role",[_x,"role","officer"] call TYR_fnc_RecordGet],
            ["name",[_x,"name",_id] call TYR_fnc_RecordGet],["rank",[_x,"rank",0] call TYR_fnc_RecordGet],
            ["alive",[_x,"alive",false] call TYR_fnc_RecordGet],["position",+([_x,"position",[]] call TYR_fnc_RecordGet)],
            ["class",[_x,"class",""] call TYR_fnc_RecordGet],["createdAt",[_x,"createdAt",0] call TYR_fnc_RecordGet],
            ["deathAt",[_x,"deathAt",-1] call TYR_fnc_RecordGet]
        ]];
    };
} forEach ([_snapshot,"commandPersonnel",[]] call TYR_fnc_RecordGet);
_state set ["commandPersonnel",_commandPersonnel];

private _commandOrders = createHashMap;
{
    private _id = [_x,"id",""] call TYR_fnc_RecordGet;
    if (_id isNotEqualTo "") then {
        _commandOrders set [_id,createHashMapFromArray [
            ["id",_id],["faction",[_x,"faction",""] call TYR_fnc_RecordGet],["force",[_x,"force",""] call TYR_fnc_RecordGet],
            ["operation",[_x,"operation",""] call TYR_fnc_RecordGet],["target",[_x,"target",""] call TYR_fnc_RecordGet],
            ["issuedAt",serverTime - ([_x,"issuedAge",0] call TYR_fnc_RecordGet)],
            ["deliverAt",serverTime + ([_x,"remaining",0] call TYR_fnc_RecordGet)],
            ["status",[_x,"status","pending"] call TYR_fnc_RecordGet],["route",+([_x,"route",[]] call TYR_fnc_RecordGet)],
            ["reroutes",[_x,"reroutes",0] call TYR_fnc_RecordGet]
        ]];
    };
} forEach ([_snapshot,"commandOrders",[]] call TYR_fnc_RecordGet);
_state set ["commandOrders",_commandOrders];

private _logistics = createHashMap;
{
    private _id = [_x,"id",""] call TYR_fnc_RecordGet;
    if (_id isNotEqualTo "") then {
        private _remaining = [_x,"remaining",30] call TYR_fnc_RecordGet;
        private _pos = +([_x,"currentPosition",[]] call TYR_fnc_RecordGet);
        _logistics set [_id,createHashMapFromArray [
            ["id",_id],["faction",[_x,"faction",""] call TYR_fnc_RecordGet],["originType",[_x,"originType",""] call TYR_fnc_RecordGet],["originId",[_x,"originId",""] call TYR_fnc_RecordGet],
            ["originPosition",+([_x,"originPosition",[]] call TYR_fnc_RecordGet)],["destinationType",[_x,"destinationType","hq"] call TYR_fnc_RecordGet],["destinationId",[_x,"destinationId",""] call TYR_fnc_RecordGet],
            ["destinationPosition",+([_x,"destinationPosition",[]] call TYR_fnc_RecordGet)],["cargo",+([_x,"cargo",[]] call TYR_fnc_RecordGet)],["reason",[_x,"reason",""] call TYR_fnc_RecordGet],
            ["status",[_x,"status","virtual"] call TYR_fnc_RecordGet],["createdAt",serverTime],["legStartAt",serverTime],["legStartPosition",_pos],["currentPosition",_pos],
            ["arriveAt",serverTime + (_remaining max 10)],["virtualSpeed",[_x,"virtualSpeed",11] call TYR_fnc_RecordGet],["physicalSince",-1],["lastStateChange",serverTime],
            ["escortAlive",[_x,"escortAlive",true] call TYR_fnc_RecordGet],["cargoAlive",[_x,"cargoAlive",true] call TYR_fnc_RecordGet],["finishedAt",-1]
        ]];
    };
} forEach ([_snapshot,"logistics",[]] call TYR_fnc_RecordGet);
_state set ["logistics",_logistics];

_state set ["destroyedBuildings",+([_snapshot,"destroyedBuildings",[]] call TYR_fnc_RecordGet)];
TYR_State = _state;
true
