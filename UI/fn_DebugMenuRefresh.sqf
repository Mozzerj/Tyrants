disableSerialization;
private _d = findDisplay 1700;
if (isNull _d || {isNil "TYR_ClientState"}) exitWith {};
if (isNil "TYR_debugFaction") then {TYR_debugFaction = TYR_PlayerFaction};
if !(TYR_debugFaction in ["west","east","independent"]) then {TYR_debugFaction = "west"};

TYR_debugSelect = {
    params ["_fid"];
    TYR_debugFaction = _fid;
    [] call TYR_fnc_DebugMenuRefresh;
    ["debugMap",[]] call TYR_debugSend;
};

TYR_debugSend = {
    params ["_action",["_args",[]]];
    [_action,_args] remoteExecCall ["TYR_fnc_ServerDebugAction",2];
};

TYR_debugToggleSection = {
    params ["_section"];
    private _current = missionNamespace getVariable ["TYR_debugOpenSection",""];
    missionNamespace setVariable ["TYR_debugOpenSection",if (_current isEqualTo _section) then {""} else {_section}];
    [] call TYR_fnc_DebugMenuRefresh;
};

TYR_debugSetView = {
    params ["_view"];
    if !(_view in ["map","flow"]) then {_view = "map"};
    missionNamespace setVariable ["TYR_debugView",_view];
    [] call TYR_fnc_DebugMenuRefresh;
};

private _open = missionNamespace getVariable ["TYR_debugOpenSection","views"];
private _sections = [
    ["faction",201,[202,203,204,205]],
    ["economy",220,[221,222,223,224,225,226,227]],
    ["research",240,[241,242]],
    ["ai",260,[261,262,263]],
    ["views",280,[281,282,283]],
    ["system",300,[301,302,303,304,131]]
];

// Accordion layout: only the selected section expands, keeping the left console compact.
private _y = safeZoneY + safeZoneH * 0.135;
{
    _x params ["_key","_headerId","_bodyIds"];
    private _header = _d displayCtrl _headerId;
    private _expanded = _open isEqualTo _key;
    _header ctrlSetText format ["%1 %2",if (_expanded) then {"-"} else {"+"},toUpper (switch (_key) do {
        case "faction": {"FACTION TARGET"};
        case "economy": {"ECONOMY"};
        case "research": {"RESEARCH"};
        case "ai": {"AI COMMAND"};
        case "views": {"VIEWS / MOVEMENT"};
        default {"SYSTEM"};
    })];
    _header ctrlSetPosition [safeZoneX+safeZoneW*0.04,_y,safeZoneW*0.25,safeZoneH*0.042];
    _header ctrlCommit 0;
    _y = _y + safeZoneH * 0.047;

    {
        private _ctrl = _d displayCtrl _x;
        _ctrl ctrlShow _expanded;
        if (_expanded) then {
            private _h = safeZoneH * 0.040;
            if (_x in [205,131]) then {_h = safeZoneH * 0.050};
            if (_x in [221,283]) then {_h = safeZoneH * 0.060};
            _ctrl ctrlSetPosition [safeZoneX+safeZoneW*0.04,_y,safeZoneW*0.25,_h];
            _ctrl ctrlCommit 0;
            _y = _y + _h + safeZoneH * 0.007;
        };
    } forEach _bodyIds;
} forEach _sections;

private _f = (TYR_ClientState get "factions") getOrDefault [TYR_debugFaction,[]];
if (count _f >= 6) then {
    private _r = _f # 5;
    (_d displayCtrl 205) ctrlSetText format ["TARGET // %1\n%2",toUpper (_f # 1),toUpper (_f # 3)];
    (_d displayCtrl 221) ctrlSetText format ["STEEL %1   AMMO %2\nFUEL %3   MANPOWER %4",round (_r # 0),round (_r # 1),round (_r # 2),round (_r # 3)];
};

(_d displayCtrl 130) ctrlSetText format ["SAVE %1 // %2",missionNamespace getVariable ["TYR_debugSaveGeneration",-1],toUpper TYR_debugFaction];
(_d displayCtrl 131) ctrlSetText format ["CLIENT FPS %1\nSERVER FPS %2",round diag_fps,round (missionNamespace getVariable ["TYR_debugServerFps",-1])];

// Swap the right-hand workspace between the live omniscient map and the AI decision-flow diagram.
private _view = missionNamespace getVariable ["TYR_debugView","map"];
private _mapIds = [1000,1001];
private _flowIds = [2099,2100,2101,2102,2103,2104,2105,2106,2111,2112,2113,2114,2115,2120];
{(_d displayCtrl _x) ctrlShow (_view isEqualTo "map")} forEach _mapIds;
{(_d displayCtrl _x) ctrlShow (_view isEqualTo "flow")} forEach _flowIds;

if (_view isEqualTo "flow") then {
    private _traces = missionNamespace getVariable ["TYR_DebugAITraces",[]];
    private _record = [];
    {
        if ((_x param [0,""]) isEqualTo TYR_debugFaction) exitWith {_record = _x};
    } forEach _traces;

    private _nodes = [];
    private _scores = [];
    private _stamp = -1;
    if (count _record >= 4) then {
        _stamp = _record # 1;
        _nodes = _record # 2;
        _scores = _record # 3;
    };

    for "_i" from 0 to 5 do {
        private _text = if (_i < count _nodes) then {_nodes # _i} else {if (_i isEqualTo 0) then {"NO AI DECISION TRACE\nRun COMMANDER THINK for this faction."} else {"WAITING"}};
        (_d displayCtrl (2101 + _i)) ctrlSetText _text;
    };

    private _scoreText = "OBJECTIVE SCORES // no scored candidates";
    if (count _scores > 0) then {
        private _parts = [];
        {
            _x params ["_name","_knownOwner","_score"];
            _parts pushBack format ["%1 %2 (%3)",toUpper _name,round _score,toUpper _knownOwner];
        } forEach _scores;
        _scoreText = format ["TOP OBJECTIVES // %1",_parts joinString "  |  "];
    };
    (_d displayCtrl 2120) ctrlSetText _scoreText;
    (_d displayCtrl 2100) ctrlSetText format ["AI DECISION FLOW // %1 // LAST THINK %2s AGO",toUpper TYR_debugFaction,if (_stamp < 0) then {"--"} else {round ((missionNamespace getVariable ["TYR_DebugServerTime",_stamp]) - _stamp)}];
};

if !(_d getVariable ["TYR_debugInitialRequested",false]) then {
    _d setVariable ["TYR_debugInitialRequested",true];
    ["sync",[]] call TYR_debugSend;
    ["debugMap",[]] call TYR_debugSend;
};
