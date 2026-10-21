params ["_map"];
if ((missionNamespace getVariable ["TYR_debugView","map"]) isEqualTo "intel") exitWith {
    [_map] call TYR_fnc_ClientMapDraw;
};
private _data = missionNamespace getVariable ["TYR_DebugMapData",[]];
if !(_data isEqualType [] && {count _data >= 5}) exitWith {};

_data params ["_serverTime","_locations","_factions","_entities","_forces"];
private _scale = ctrlMapScale _map;
private _showLiveEntities = _scale < 0.055;
private _showUnits = _scale < 0.028;
private _showEntityLabels = _scale < 0.025;
private _showUnitLabels = _scale < 0.012;

// True strategic locations. These intentionally ignore faction intelligence.
{
    _x params ["_id","_name","_kind","_pos","_owner","_stock","_resource","_value",["_factoryType",""],["_queue",[]],["_inventory",[]],["_operational",true]];
    private _color = if (_owner in ["west","east","independent"]) then {[_owner,true] call TYR_fnc_FactionColor} else {[0.62,0.62,0.62,0.85]};
    private _icon = switch (_kind) do {
        case "factory": {"\A3\ui_f\data\map\markers\nato\b_installation.paa"};
        case "city": {"\A3\ui_f\data\map\markers\military\circle_CA.paa"};
        default {"\A3\ui_f\data\map\markers\military\dot_CA.paa"};
    };
    private _label = format ["%1 // %2",_name,toUpper _owner];
    if (_kind isEqualTo "factory") then {
        _label = format ["%1 // %2 // %3 // %4",_name,toUpper _owner,toUpper _factoryType,if (_operational) then {"ONLINE"} else {"PAUSED"}];
        if (count _queue > 0) then {_label = _label + (if (_operational) then {format [" // BUILD %1 ETA %2s",toUpper (_queue # 0),ceil (_queue # 1)]} else {format [" // QUEUED %1",toUpper (_queue # 0)]})};
        if (_scale < 0.08 && {count _inventory > 0}) then {
            private _stockText = [];
            {_stockText pushBack format ["%1:%2",toUpper (_x # 0),_x # 1]} forEach _inventory;
            _label = _label + format [" // STOCK %1",_stockText joinString ", "];
        };
    };
    _map drawIcon [_icon,_color,_pos,19,19,0,_label,1,0.028,"PuristaMedium","right"];
} forEach _locations;

// Faction HQs and strategic commander state.
{
    _x params ["_fid","_name","_active","_controller","_base","_confirmed","_eliminated","_personality","_objective"];
    if (_active && {count _base >= 2}) then {
        private _color = [_fid,true] call TYR_fnc_FactionColor;
        private _suffix = if (_eliminated) then {" // ELIMINATED"} else {format [" // %1 // OBJ %2",toUpper _controller,toUpper _objective]};
        _map drawIcon ["\A3\ui_f\data\map\markers\nato\b_hq.paa",_color,_base,34,34,0,format ["%1 HQ%2",toUpper _name,_suffix],1,0.04,"PuristaBold","right"];
    };
} forEach _factions;

// AI force-level markers remain visible at all zoom levels.
{
    _x params ["_id","_fid","_role","_operation","_pos","_count","_active"];
    if (_active && {count _pos >= 2}) then {
        private _color = [_fid,true] call TYR_fnc_FactionColor;
        private _opText = if (_operation isEqualTo "") then {"IDLE"} else {toUpper _operation};
        _map drawIcon ["\A3\ui_f\data\map\markers\nato\b_inf.paa",_color,_pos,22,22,0,format ["%1 // %2 // %3 // %4 UNITS",toUpper _id,toUpper _role,_opText,_count],1,0.027,"PuristaMedium","right"];
    };
} forEach _forces;

// Live entity truth is the most expensive overlay. At island/operational zoom the
// force-level markers above already show the useful picture, so individual entities
// are intentionally culled until the user zooms in. Infantry are culled even earlier.
if (_showLiveEntities) then {
    {
        _x params ["_kind","_fid","_class","_display","_pos","_dir","_alive","_damage","_extra"];
        if (_alive && {count _pos >= 2} && {(_kind isNotEqualTo "unit") || {_showUnits}}) then {
            private _color = if (_fid in ["west","east","independent"]) then {[_fid,true] call TYR_fnc_FactionColor} else {[0.7,0.7,0.7,0.9]};
            private _icon = switch (_kind) do {
                case "unit": {"\A3\ui_f\data\map\markers\nato\b_inf.paa"};
                case "emplacement": {"\A3\ui_f\data\map\markers\nato\b_art.paa"};
                default {"\A3\ui_f\data\map\markers\nato\b_motor_inf.paa"};
            };
            private _label = "";
            if (_kind isEqualTo "unit") then {
                if (_showUnitLabels) then {_label = format ["%1 // %2",_display,_extra]};
            } else {
                if (_showEntityLabels) then {_label = if (_extra isEqualTo "") then {_display} else {format ["%1 // %2",_display,toUpper _extra]}};
            };
            private _size = if (_kind isEqualTo "unit") then {10} else {15};
            _map drawIcon [_icon,_color,_pos,_size,_size,_dir,_label,0,0.021,"PuristaMedium","right"];
        };
    } forEach _entities;
};

// Physical command network: main commander -> officers -> force commanders.
// This is omniscient developer data only; normal faction intelligence never receives it.
private _commandNetworks = _data param [6,[]];
{
    _x params ["_fid","_status","_collapseSince","_replacementAt","_nodes","_links","_pendingOrders"];
    private _nodePositions = createHashMap;
    {
        _x params ["_id","_role","_name","_pos","_alive",["_extra",""]];
        if (count _pos >= 2) then {_nodePositions set [_id,_pos]};
    } forEach _nodes;

    {
        _x params ["_from","_to","_linkState"];
        private _a = _nodePositions getOrDefault [_from,[]];
        private _b = _nodePositions getOrDefault [_to,[]];
        if (count _a >= 2 && {count _b >= 2}) then {
            private _lineColor = if (_linkState isEqualTo "local") then {[0.75,0.25,0.18,0.75]} else {[0.80,0.68,0.22,0.8]};
            _map drawLine [_a,_b,_lineColor];
        };
    } forEach _links;

    {
        _x params ["_id","_role","_name","_pos","_alive",["_extra",""]];
        if (count _pos >= 2) then {
            private _base = [_fid,true] call TYR_fnc_FactionColor;
            private _nodeColor = if (_alive) then {[_base # 0,_base # 1,_base # 2,1]} else {[0.45,0.45,0.45,0.85]};
            private _icon = if (_role isEqualTo "commander") then {"\A3\ui_f\data\map\markers\nato\b_hq.paa"} else {"\A3\ui_f\data\map\markers\nato\b_inf.paa"};
            private _size = if (_role isEqualTo "commander") then {27} else {if (_role isEqualTo "officer") then {20} else {16}};
            private _roleText = switch (_role) do {case "commander":{"MAIN CMD"};case "officer":{"OFFICER"};default {"FORCE CMD"}};
            private _extraText = if (_extra isEqualTo "") then {""} else {format [" // %1",toUpper _extra]};
            _map drawIcon [_icon,_nodeColor,_pos,_size,_size,0,format ["%1 // %2%3",_roleText,_name,_extraText],1,0.025,"PuristaMedium","right"];
        };
    } forEach _nodes;

    private _f = (TYR_ClientState getOrDefault ["factions",createHashMap]) getOrDefault [_fid,[]];
    private _hq = if (count _f > 4) then {_f # 4} else {[]};
    if (count _hq < 2) then {
        {
            if ((_x # 1) isEqualTo "commander" && {count (_x # 3) >= 2}) exitWith {_hq = _x # 3};
        } forEach _nodes;
    };
    if (count _hq >= 2 && {_scale < 0.28}) then {
        private _collapseText = if (_collapseSince >= 0) then {format [" // COLLAPSE %1s",round (_serverTime - _collapseSince)]} else {""};
        _map drawIcon ["\A3\ui_f\data\map\markers\military\circle_CA.paa",[0.95,0.75,0.2,0.95],_hq,12,12,0,format ["COMMAND %1 // %2 // PENDING %3%4",toUpper _fid,toUpper _status,_pendingOrders,_collapseText],1,0.027,"PuristaBold","left"];
    };
} forEach _commandNetworks;

// Strategic AI intent and delivered/pending commands. This is developer-only
// omniscient telemetry: it shows exactly what the AI ordered, where it is going,
// and whether the physical command network has delivered the order yet.
private _forcePosMap = createHashMap;
{
    if (_x isEqualType [] && {count _x >= 5}) then {_forcePosMap set [_x # 0,+(_x # 4)]};
} forEach _forces;

private _aiOperations = _data param [7,[]];
private _orderFocus = missionNamespace getVariable ["TYR_DebugOrderFocus",false];
private _focusFaction = missionNamespace getVariable ["TYR_debugFaction",""];
{
    _x params ["_opId","_fid","_type","_phase","_targetType","_targetId","_targetName","_targetPos","_forceIds","_score","_reason","_created","_orderId"];
    if ((!_orderFocus || {_fid isEqualTo _focusFaction}) && {count _targetPos >= 2}) then {
        private _baseColor = [_fid,true] call TYR_fnc_FactionColor;
        private _lineColor = switch (_phase) do {
            case "command_pending": {[0.95,0.68,0.12,0.95]};
            case "capture": {[0.95,0.25,0.18,0.95]};
            case "search": {[0.68,0.46,0.95,0.95]};
            case "hold": {[0.25,0.78,0.95,0.95]};
            default {[_baseColor # 0,_baseColor # 1,_baseColor # 2,0.95]};
        };
        private _icon = switch (_type) do {
            case "defend": {"\A3\ui_f\data\map\markers\nato\b_hq.paa"};
            case "recon": {"\A3\ui_f\data\map\markers\nato\b_inf.paa"};
            case "probe": {"\A3\ui_f\data\map\markers\nato\b_inf.paa"};
            case "raid": {"\A3\ui_f\data\map\markers\nato\b_inf.paa"};
            default {"\A3\ui_f\data\map\markers\military\circle_CA.paa"};
        };
        private _intentLabel = format ["AI %1 // %2 // %3 // SCORE %4",toUpper _type,toUpper _targetName,toUpper _phase,round _score];
        if (_scale < 0.12 && {_reason isNotEqualTo ""}) then {_intentLabel = _intentLabel + format [" // WHY: %1",toUpper _reason]};
        _map drawIcon [_icon,_lineColor,_targetPos,24,24,0,_intentLabel,1,0.03,"PuristaBold","right"];
        {
            private _fp = _forcePosMap getOrDefault [_x,[]];
            if (count _fp >= 2) then {
                _map drawLine [_fp,_targetPos,_lineColor];
                private _mid = [((_fp # 0)+(_targetPos # 0))*0.5,((_fp # 1)+(_targetPos # 1))*0.5,0];
                _map drawIcon ["\A3\ui_f\data\map\markers\military\dot_CA.paa",_lineColor,_mid,2,2,0,format ["%1 -> %2",toUpper _x,toUpper _type],1,0.022,"PuristaMedium","right"];
            };
        } forEach _forceIds;
    };
} forEach _aiOperations;

private _allCommandNodePos = createHashMap;
{
    private _nodes = _x param [4,[]];
    {
        if (_x isEqualType [] && {count _x >= 4} && {count (_x # 3) >= 2}) then {_allCommandNodePos set [_x # 0,+(_x # 3)]};
    } forEach _nodes;
} forEach _commandNetworks;

private _debugOrders = _data param [8,[]];
{
    _x params ["_orderId","_fid","_forceId","_opId","_targetId","_issuedAt","_deliverAt","_status","_route","_reroutes"];
    if (!_orderFocus || {_fid isEqualTo _focusFaction}) then {
    private _routePoints = [];
    {
        private _p = _allCommandNodePos getOrDefault [_x,[]];
        if (count _p >= 2) then {_routePoints pushBack _p};
    } forEach _route;
    private _forcePos = _forcePosMap getOrDefault [_forceId,[]];
    if (count _forcePos >= 2) then {_routePoints pushBack _forcePos};
    if (count _routePoints >= 2) then {
        for "_i" from 0 to ((count _routePoints) - 2) do {
            _map drawLine [_routePoints # _i,_routePoints # (_i + 1),[1,0.78,0.12,1]];
        };
    };
    if (count _forcePos >= 2) then {
        private _eta = (_deliverAt - _serverTime) max 0;
        _map drawIcon ["\A3\ui_f\data\map\markers\military\warning_CA.paa",[1,0.78,0.12,1],_forcePos,16,16,0,format ["ORDER %1 // %2 // ETA %3s // REROUTES %4",toUpper _orderId,toUpper _opId,ceil _eta,_reroutes],1,0.024,"PuristaMedium","right"];
    };
    };
} forEach _debugOrders;


// Hybrid logistics telemetry. Dotted intent is represented by a route line; the
// label explicitly states whether the convoy is currently PHYSICAL or VIRTUAL.
private _logistics = _data param [9,[]];
{
    _x params ["_jobId","_fid","_status","_pos","_dest","_cargo","_reason","_originId","_destinationId"];
    if (count _pos >= 2 && {count _dest >= 2}) then {
        private _base = [_fid,true] call TYR_fnc_FactionColor;
        private _c = if (_status isEqualTo "physical") then {[1,0.72,0.16,0.95]} else {[_base # 0,_base # 1,_base # 2,0.72]};
        _map drawLine [_pos,_dest,_c];
        private _cargoText = [];
        {_cargoText pushBack format ["%1x%2",toUpper (_x # 0),_x # 1]} forEach _cargo;
        private _label = format ["LOG %1 // %2 // %3",toUpper _jobId,toUpper _status,_cargoText joinString ", "];
        if (_scale < 0.10 && {_reason isNotEqualTo ""}) then {_label = _label + format [" // %1",toUpper _reason]};
        _map drawIcon ["\A3\ui_f\data\map\markers\nato\b_support.paa",_c,_pos,18,18,0,_label,1,0.023,"PuristaMedium","right"];
    };
} forEach _logistics;
