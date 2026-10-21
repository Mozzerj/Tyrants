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
    if !(_view in ["map","intel","flow","tasks","log","commands"]) then {_view = "map"};
    missionNamespace setVariable ["TYR_debugView",_view];
    [] call TYR_fnc_DebugMenuRefresh;
};

TYR_debugToggleMapTeleport = {
    private _enabled = !(missionNamespace getVariable ["TYR_DebugMapTeleportMode",false]);
    missionNamespace setVariable ["TYR_DebugMapTeleportMode",_enabled];
    [] call TYR_fnc_DebugMenuRefresh;
    hint (if (_enabled) then {"Debug map teleport enabled: left-click the map to move instantly."} else {"Debug map teleport disabled."});
};

if (isNil "TYR_DebugTaskDefinitions") then {
    missionNamespace setVariable ["TYR_DebugTaskDefinitions",[
        ["Visual contact appears","Look directly at an enemy infantryman or vehicle. Confirm a LAST SEEN contact appears on the faction map. This proves the client visual report reaches the server and becomes faction knowledge."],
        ["Contact freezes when lost","Create a contact, then look away while the enemy moves. Confirm your faction marker stays at the last observed position instead of following the live enemy."],
        ["Reacquisition updates contact","After a contact has gone stale, visually find it again. Confirm the last-known position and age reset to the new observation."],
        ["Far contact stays broad","Observe an enemy from long range. Confirm the map shows a broad class such as ARMOURED VEHICLE, AIRCRAFT or INFANTRY rather than the exact class."],
        ["Close/optical ID upgrades","Move close or use binocular/rangefinder optics and reacquire the same target. Confirm the contact upgrades to an exact vehicle/unit display name."],
        ["UAV visual intelligence","Connect to a physical UAV and put an enemy in the UAV view. Confirm the faction contact updates from the UAV rather than from your player body's position."],
        ["Location ownership requires sight","Find an enemy-held strategic location that is UNKNOWN. Confirm it only changes to LAST OBS enemy control after you visually observe enemy presence at that site."],
        ["Truth versus knowledge","Compare OMNISCIENT MAP with FACTION INTEL MAP. Confirm unobserved enemy units exist only on omniscient truth and do not leak onto the faction map."],
        ["AI force reconnaissance","Let a friendly AI force leader encounter an enemy. Confirm the faction receives a contact only after physical line of sight, not simply because the server knows the enemy exists."],
        ["Save/reload keeps last-known intel","Save with one or more contacts, restart/reload, and confirm the contacts remain as stale last-known information until physically observed again."],
        ["AI live decision trace","Select an AI faction, open SHOW AI DECISION FLOW and press RUN THINK + TRACE. Confirm the real twelve-stage path advances node by node and the final outcome/candidate validation appears."],
        ["AI unknown means reconnaissance","Leave a strategic site unknown to the selected AI faction. Run a trace and confirm that site can produce RECON/PROBE rather than a hidden-truth attack."],
        ["AI order appears on map","Run a traced think that creates a force operation, then press SHOW AI ORDER MAP. Confirm the assigned-force-to-target line, operation type/phase/score and pending command route are visible."],
        ["AI officer loss reroutes order","Create a COMMAND_PENDING operation, kill one command officer before delivery, then run a command tick. Confirm the order route/ETA updates and reroute count increases."],
        ["AI command collapse stops planning","Kill all selected-faction command personnel, then RUN THINK + TRACE. Confirm planning branches to COMMAND COLLAPSE and creates no new force operation."],
        ["AI observed commander can be targeted","Legitimately observe an enemy Main Commander with faction intelligence, then run the observing AI faction. Confirm COMMAND PERSONNEL can become a high-value RAID candidate without revealing unobserved commanders."]
    ]];
};
if (isNil "TYR_DebugTaskStatus") then {
    missionNamespace setVariable ["TYR_DebugTaskStatus",createHashMap];
};

TYR_debugTaskSelectionChanged = {
    disableSerialization;
    private _display = findDisplay 1700;
    if (isNull _display) exitWith {};
    private _index = lbCurSel (_display displayCtrl 2201);
    private _defs = missionNamespace getVariable ["TYR_DebugTaskDefinitions",[]];
    if (_index < 0 || {_index >= count _defs}) exitWith {};
    private _statusMap = missionNamespace getVariable ["TYR_DebugTaskStatus",createHashMap];
    private _def = _defs # _index;
    private _status = _statusMap getOrDefault [str _index,"NOT TESTED"];
    (_display displayCtrl 2202) ctrlSetText format ["%1\n\nSTATUS // %2",_def # 1,_status];
};

TYR_debugTaskMark = {
    params ["_status"];
    disableSerialization;
    private _display = findDisplay 1700;
    if (isNull _display) exitWith {};
    private _index = lbCurSel (_display displayCtrl 2201);
    private _defs = missionNamespace getVariable ["TYR_DebugTaskDefinitions",[]];
    if (_index < 0 || {_index >= count _defs}) exitWith {};
    private _map = missionNamespace getVariable ["TYR_DebugTaskStatus",createHashMap];
    _map set [str _index,_status];
    missionNamespace setVariable ["TYR_DebugTaskStatus",_map];
    [] call TYR_fnc_DebugMenuRefresh;
};

TYR_debugTaskReset = {
    missionNamespace setVariable ["TYR_DebugTaskStatus",createHashMap];
    [] call TYR_fnc_DebugMenuRefresh;
};

private _open = missionNamespace getVariable ["TYR_debugOpenSection","views"];
private _sections = [
    ["faction",201,[202,203,204,205]],
    ["economy",220,[221,222,223,224,225,226,227]],
    ["research",240,[241,242]],
    ["ai",260,[261,262,263,264]],
    ["commandnet",270,[271,272,273,274,276,277,275]],
    ["views",280,[281,282,284,285,286,283]],
    ["testing",290,[291,292,293,294,295]],
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
        case "commandnet": {"COMMAND NETWORK"};
        case "views": {"VIEWS / MOVEMENT"};
        case "testing": {"TESTING"};
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
            if (_x in [221,271,283]) then {_h = safeZoneH * 0.060};
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
private _cmdText = "STATUS --\nCOMMAND NODES --";
private _debugMapData = missionNamespace getVariable ["TYR_DebugMapData",[]];
private _networks = if (_debugMapData isEqualType [] && {count _debugMapData >= 7}) then {_debugMapData # 6} else {[]};
{
    if ((_x param [0,""]) isEqualTo TYR_debugFaction) exitWith {
        private _nodes = _x param [4,[]];
        private _aliveMain = {_x # 1 isEqualTo "commander" && {_x # 4}} count _nodes;
        private _aliveOfficers = {_x # 1 isEqualTo "officer" && {_x # 4}} count _nodes;
        _cmdText = format ["STATUS %1 // PENDING %2\nMAIN %3 // OFFICERS %4",toUpper (_x param [1,"--"]),_x param [6,0],_aliveMain,_aliveOfficers];
    };
} forEach _networks;
(_d displayCtrl 271) ctrlSetText _cmdText;

(_d displayCtrl 130) ctrlSetText format ["SAVE %1 // %2",missionNamespace getVariable ["TYR_debugSaveGeneration",-1],toUpper TYR_debugFaction];
(_d displayCtrl 131) ctrlSetText format ["CLIENT FPS %1\nSERVER FPS %2",round diag_fps,round (missionNamespace getVariable ["TYR_debugServerFps",-1])];

// Swap the right-hand workspace between the live omniscient map and the AI decision-flow diagram.
private _view = missionNamespace getVariable ["TYR_debugView","map"];
private _mapIds = [1000,1001];
private _flowIds = [2099,2100,2101,2102,2103,2104,2105,2106,2107,2108,2109,2110,2111,2112,2131,2132,2133,2134,2135,2136,2137,2138,2139,2140,2141,2150,2151];
private _taskIds = [2199,2200,2201,2202,2203,2204,2205];
private _logIds = [2299,2300,2301];
private _commandIds = [2399,2400,2401,2402,2403,2404,2405,2406];
private _mapVisible = _view in ["map","intel"];
{(_d displayCtrl _x) ctrlShow _mapVisible} forEach _mapIds;
{(_d displayCtrl _x) ctrlShow (_view isEqualTo "flow")} forEach _flowIds;
{(_d displayCtrl _x) ctrlShow (_view isEqualTo "tasks")} forEach _taskIds;
{(_d displayCtrl _x) ctrlShow (_view isEqualTo "log")} forEach _logIds;
{(_d displayCtrl _x) ctrlShow (_view isEqualTo "commands")} forEach _commandIds;

private _mapTeleportEnabled = missionNamespace getVariable ["TYR_DebugMapTeleportMode",false];
(_d displayCtrl 285) ctrlSetText format ["MAP CLICK TELEPORT // %1",if (_mapTeleportEnabled) then {"ON"} else {"OFF"}];
(_d displayCtrl 286) ctrlSetText format ["LEFT-CLICK TP // %1",if (_mapTeleportEnabled) then {"ENABLED"} else {"OFF"}];

if (_mapVisible) then {
    private _instruction = if (_view isEqualTo "intel") then {
        "YOUR FACTION INTELLIGENCE // last-known contacts only // compare against omniscient truth"
    } else {
        if (missionNamespace getVariable ["TYR_DebugOrderFocus",false]) then {
            format ["AI ORDER MAP // %1 // force intent + operation phase + physical command delivery route",toUpper TYR_debugFaction]
        } else {
            "OMNISCIENT SERVER TRUTH // refresh 3s // intelligence restrictions intentionally bypassed"
        }
    };
    if (_mapTeleportEnabled) then {_instruction = _instruction + " // LEFT CLICK = TELEPORT"};
    (_d displayCtrl 1001) ctrlSetText _instruction;
};

if (_view isEqualTo "tasks") then {
    private _defs = missionNamespace getVariable ["TYR_DebugTaskDefinitions",[]];
    private _statusMap = missionNamespace getVariable ["TYR_DebugTaskStatus",createHashMap];
    private _list = _d displayCtrl 2201;
    private _selected = lbCurSel _list;
    if (_selected < 0) then {_selected = 0};
    lbClear _list;
    private _passed = 0;
    private _failed = 0;
    {
        private _status = _statusMap getOrDefault [str _forEachIndex,""];
        if (_status isEqualTo "PASS") then {_passed=_passed+1};
        if (_status isEqualTo "FAIL") then {_failed=_failed+1};
        private _prefix = switch (_status) do {case "PASS": {"[PASS]"}; case "FAIL": {"[FAIL]"}; default {"[ ]"}};
        private _row = _list lbAdd format ["%1 %2",_prefix,_x # 0];
        if (_status isEqualTo "PASS") then {_list lbSetColor [_row,[0.45,0.85,0.50,1]]};
        if (_status isEqualTo "FAIL") then {_list lbSetColor [_row,[0.95,0.40,0.35,1]]};
    } forEach _defs;
    if (count _defs > 0) then {
        _selected = _selected min ((count _defs)-1);
        _list lbSetCurSel _selected;
        private _def = _defs # _selected;
        private _status = _statusMap getOrDefault [str _selected,"NOT TESTED"];
        (_d displayCtrl 2202) ctrlSetText format ["%1\n\nSTATUS // %2",_def # 1,_status];
    } else {
        (_d displayCtrl 2202) ctrlSetText "No manual tasks configured.";
    };
    (_d displayCtrl 2200) ctrlSetText format ["MANUAL RUNTIME TEST TASKS // %1 PASS // %2 FAIL // %3 TOTAL",_passed,_failed,count _defs];
};

if (_view isEqualTo "log") then {
    private _list = _d displayCtrl 2301;
    lbClear _list;
    private _knowledge = TYR_ClientState getOrDefault ["knowledge",[]];
    private _log = if (_knowledge isEqualType [] && {count _knowledge >= 4}) then {+(_knowledge # 3)} else {[]};
    if (count _log > 0) then {
        for "_i" from ((count _log) - 1) to 0 step -1 do {
            private _entry = _log # _i;
            if (_entry isEqualType [] && {count _entry >= 7}) then {
                _entry params ["_stamp","_id","_targetFaction","_label","_pos","_source","_event"];
                private _timeText = "--:--:--";
                if (_stamp isEqualType [] && {count _stamp >= 6}) then {
                    _timeText = format ["%1:%2:%3",[_stamp # 3,2] call BIS_fnc_padNumber,[_stamp # 4,2] call BIS_fnc_padNumber,[floor (_stamp # 5),2] call BIS_fnc_padNumber];
                };
                _list lbAdd format ["%1 // %2 // %3 // %4 // %5",_timeText,_event,toUpper _targetFaction,toUpper _label,toUpper _source];
            };
        };
    };
    if (count _log isEqualTo 0) then {_list lbAdd "No collected intelligence yet. Observe an enemy to create the first entry."};
    (_d displayCtrl 2300) ctrlSetText format ["FACTION INTELLIGENCE LOG // %1 ENTRIES",count _log];
};

if (_view isEqualTo "commands") then {
    private _lastCommand = missionNamespace getVariable ["TYR_DebugLastCommand",""];
    private _editor = _d displayCtrl 2401;
    if ((ctrlText _editor) isEqualTo "" && {_lastCommand isNotEqualTo ""}) then {_editor ctrlSetText _lastCommand};
    (_d displayCtrl 2404) ctrlSetText (missionNamespace getVariable ["TYR_DebugCommandResult","Result appears here. Script errors still appear in the Arma RPT."]);
};

if (_view isEqualTo "flow") then {
    private _traces = missionNamespace getVariable ["TYR_DebugAITraces",[]];
    private _record = [];
    {
        if ((_x param [0,""]) isEqualTo TYR_debugFaction) exitWith {_record = _x};
    } forEach _traces;

    private _started = -1;
    private _finished = -1;
    private _currentStep = 0;
    private _nodes = [];
    private _candidates = [];
    private _decision = "NO DECISION TRACE";
    private _posture = "--";
    if (count _record >= 8) then {
        _started = _record # 1;
        _finished = _record # 2;
        _currentStep = _record # 3;
        _nodes = _record # 4;
        _candidates = _record # 5;
        _decision = _record # 6;
        _posture = _record # 7;
    };

    private _defaultBg = [0.045,0.052,0.060,1];
    private _doneBg = [0.055,0.12,0.075,1];
    private _branchBg = [0.08,0.10,0.16,1];
    private _blockedBg = [0.20,0.055,0.045,1];
    private _currentBg = [0.25,0.16,0.035,1];
    private _skippedBg = [0.035,0.038,0.042,1];
    for "_i" from 0 to 11 do {
        private _ctrl = _d displayCtrl (2101 + _i);
        private _node = if (_i < count _nodes) then {_nodes # _i} else {[_i + 1,"WAITING","","pending",""]};
        _node params ["_stepNo","_title","_outcome","_state",["_detail",""]];
        _ctrl ctrlSetText format ["%1 // %2\n%3",_stepNo,toUpper _title,_outcome];
        private _bg = switch (_state) do {
            case "done": {_doneBg};
            case "branch": {_branchBg};
            case "blocked": {_blockedBg};
            case "current": {_currentBg};
            case "skipped": {_skippedBg};
            default {_defaultBg};
        };
        if (_stepNo isEqualTo _currentStep) then {_bg = _currentBg};
        _ctrl ctrlSetBackgroundColor _bg;
        _ctrl ctrlSetTextColor (if (_state isEqualTo "skipped") then {[0.42,0.45,0.48,1]} else {[0.90,0.92,0.94,1]});
    };

    // The 11 connectors correspond to transitions 1->2 ... 11->12. Completed
    // transitions go green, the transition into the live step goes amber, and
    // future transitions remain grey so the actual traversed path reads visually.
    for "_i" from 0 to 10 do {
        private _arrow = _d displayCtrl (2131 + _i);
        private _targetStep = _i + 2;
        private _arrowColor = [0.35,0.38,0.42,1];
        if (_targetStep < _currentStep) then {_arrowColor = [0.28,0.72,0.40,1]};
        if (_targetStep isEqualTo _currentStep) then {_arrowColor = [0.95,0.68,0.12,1]};
        if (_finished >= 0 && {_targetStep <= _currentStep}) then {_arrowColor = [0.28,0.72,0.40,1]};
        _arrow ctrlSetTextColor _arrowColor;
    };

    private _candidateLines = ["TOP CANDIDATES / VALIDATION"];
    {
        if (_forEachIndex < 6) then {
            _x params ["_type","_name","_score","_validState","_reason",["_breakdown",""]];
            private _tag = switch (_validState) do {case "valid": {"PASS"}; case "rejected": {"X"}; default {"?"}};
            _candidateLines pushBack format ["%1  %2 -> %3  %4 pts",_tag,toUpper _type,toUpper _name,round _score];
        };
    } forEach _candidates;
    if (count _candidates isEqualTo 0) then {_candidateLines pushBack "No candidate data. Run COMMANDER THINK."};
    (_d displayCtrl 2150) ctrlSetText (_candidateLines joinString "\n");
    (_d displayCtrl 2151) ctrlSetText format ["POSTURE\n%1\n\nDECISION\n%2",toUpper _posture,_decision];

    private _serverNow = missionNamespace getVariable ["TYR_DebugServerTime",_started];
    private _age = if (_started < 0) then {-1} else {round (_serverNow - _started)};
    private _statusText = if (_finished < 0 && {_started >= 0}) then {format ["THINKING // STEP %1",_currentStep]} else {format ["LAST THINK %1s AGO",if (_age < 0) then {"--"} else {_age}]};
    (_d displayCtrl 2100) ctrlSetText format ["AI STRATEGIC DECISION PATH // %1 // %2",toUpper TYR_debugFaction,_statusText];
};

if !(_d getVariable ["TYR_debugInitialRequested",false]) then {
    _d setVariable ["TYR_debugInitialRequested",true];
    ["sync",[]] call TYR_debugSend;
    ["debugMap",[]] call TYR_debugSend;
};
