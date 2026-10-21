params ["_map"];
if ((missionNamespace getVariable ["TYR_debugView","map"]) isEqualTo "intel") exitWith {
    [_map] call TYR_fnc_ClientMapDraw;
};
private _data = missionNamespace getVariable ["TYR_DebugMapData",[]];
if !(_data isEqualType [] && {count _data >= 5}) exitWith {};

_data params ["_serverTime","_locations","_factions","_entities","_forces"];
private _scale = ctrlMapScale _map;
private _showEntityLabels = _scale < 0.16;
private _showUnitLabels = _scale < 0.075;

// True strategic locations. These intentionally ignore faction intelligence.
{
    _x params ["_id","_name","_kind","_pos","_owner","_stock","_resource","_value"];
    private _color = if (_owner in ["west","east","independent"]) then {[_owner,true] call TYR_fnc_FactionColor} else {[0.62,0.62,0.62,0.85]};
    private _icon = switch (_kind) do {
        case "factory": {"\A3\ui_f\data\map\markers\nato\b_installation.paa"};
        case "city": {"\A3\ui_f\data\map\markers\military\circle_CA.paa"};
        default {"\A3\ui_f\data\map\markers\military\dot_CA.paa"};
    };
    private _label = format ["%1 // %2",_name,toUpper _owner];
    if (_kind isEqualTo "factory") then {
        _label = format ["%1 // %2 // %3 STOCK %4",_name,toUpper _owner,toUpper _resource,round _stock];
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

// Live entity truth. Infantry labels are suppressed while zoomed out to avoid turning the map into solid text.
{
    _x params ["_kind","_fid","_class","_display","_pos","_dir","_alive","_damage","_extra"];
    if (_alive && {count _pos >= 2}) then {
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
