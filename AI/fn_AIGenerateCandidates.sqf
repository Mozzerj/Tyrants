params ["_factionId","_picture","_posture"];
private _candidates = [];
private _activeTargets = [];
private _operations = TYR_State getOrDefault ["operations",createHashMap];
{
    private _op = _operations getOrDefault [_x,createHashMap];
    if (count _op > 0) then {_activeTargets pushBack (_op getOrDefault ["target",""])};
} forEach (_picture getOrDefault ["activeOperations",[]]);

private _push = {
    params ["_type","_targetType","_targetId","_targetName","_targetPos","_baseScore","_intelAge","_value","_reason"];
    _candidates pushBack (createHashMapFromArray [
        ["type",_type],["targetType",_targetType],["target",_targetId],["targetName",_targetName],["targetPosition",+_targetPos],
        ["baseScore",_baseScore],["intelAge",_intelAge],["value",_value],["reason",_reason],["score",-1e9],["valid",false],["rejectReason",""]
    ]);
};

private _threats = _picture getOrDefault ["emergencyThreats",[]];
if (count _threats > 0) then {
    private _t = _threats # 0;
    _t params ["_scope","_contactId","_label","_enemyPos","_age","_dist","_anchor"];
    if (_scope isEqualTo "location") then {
        private _loc = [_anchor] call TYR_fnc_StateGetLocation;
        if (count _loc > 0) then {
            ["defend","location",_anchor,_loc getOrDefault ["name",_anchor],_loc getOrDefault ["position",[]],900,_age,_loc getOrDefault ["value",1],format ["Known %1 threatens friendly location",_label]] call _push;
        };
    } else {
        ["defend","position","__HQ__","FACTION HQ",_picture getOrDefault ["base",[]],1000,_age,5,format ["Known %1 is %2m from HQ",_label,round _dist]] call _push;
    };
};

// When defensive/consolidating, protecting a valuable known-friendly site is a
// legitimate strategic alternative to attacking. This uses only own-state truth.
if (_posture in ["defensive","consolidate"] && {count (_picture getOrDefault ["ownLocations",[]]) > 0}) then {
    private _defRows = [];
    {
        _x params ["_id","_name","_pos","_value"];
        if !(_id in _activeTargets) then {_defRows pushBack [_value,_id,_name,_pos]};
    } forEach (_picture getOrDefault ["ownLocations",[]]);
    _defRows sort false;
    if (count _defRows > 0) then {
        private _r = _defRows # 0;
        _r params ["_value","_id","_name","_pos"];
        ["defend","location",_id,_name,_pos,36 + (_value * 9),0,_value,"Protect highest-value known friendly site"] call _push;
    };
};

// A second known critical threat may justify reinforcing rather than merely
// assigning one defending force, provided an operation is not already targeting it.
if (count _threats > 1) then {
    private _t = _threats # 1;
    _t params ["_scope","_contactId","_label","_enemyPos","_age","_dist","_anchor"];
    if (_scope isEqualTo "location" && {!(_anchor in _activeTargets)}) then {
        private _loc = [_anchor] call TYR_fnc_StateGetLocation;
        if (count _loc > 0) then {
            ["reinforce","location",_anchor,_loc getOrDefault ["name",_anchor],_loc getOrDefault ["position",[]],760,_age,_loc getOrDefault ["value",1],format ["Second known threat near %1",_label]] call _push;
        };
    };
};

// Known hostile/neutral strategic sites.
{
    _x params ["_id","_name","_pos","_value","_knownOwner","_age"];
    if !(_id in _activeTargets) then {
        private _type = if (_posture isEqualTo "exploit") then {"exploit"} else {"attack"};
        [_type,"location",_id,_name,_pos,55 + (_value * 10),_age,_value,format ["Observed control: %1",toUpper _knownOwner]] call _push;
    };
} forEach (_picture getOrDefault ["knownHostileLocations",[]]);
{
    _x params ["_id","_name","_pos","_value","_knownOwner","_age"];
    if !(_id in _activeTargets) then {
        ["attack","location",_id,_name,_pos,42 + (_value * 8),_age,_value,"Known neutral expansion objective"] call _push;
    };
} forEach (_picture getOrDefault ["knownNeutralLocations",[]]);

// Unknown locations are reconnaissance/probe objectives, never treated as secretly hostile.
private _unknownRows = [];
{
    _x params ["_id","_name","_pos","_value","_knownOwner","_age"];
    private _base = _picture getOrDefault ["base",[]];
    private _dist = if (count _base >= 2) then {_base distance2D _pos} else {worldSize};
    _unknownRows pushBack [(_value * 10000) - _dist,_id,_name,_pos,_value];
} forEach (_picture getOrDefault ["unknownLocations",[]]);
_unknownRows sort false;
{
    if (_forEachIndex < 8) then {
        _x params ["_sort","_id","_name","_pos","_value"];
        if !(_id in _activeTargets) then {
            private _type = if (_posture isEqualTo "probe") then {"probe"} else {"recon"};
            [_type,"location",_id,_name,_pos,30 + (_value * 6),1e9,_value,"Ownership unknown: gather real intelligence"] call _push;
        };
    };
} forEach _unknownRows;

// High-value recent contacts can be raided at their last-known position.
private _contactRows = [];
{
    _x params ["_id","_enemyFaction","_kind","_label","_pos","_age","_exact","_source","_roleTag"];
    if (_age <= 150 && {count _pos >= 2} && {_kind in ["command","emplacement","vehicle"]}) then {
        private _priority = switch (_kind) do {case "command": {95}; case "emplacement": {72}; default {48}};
        if (_roleTag isEqualTo "commander") then {_priority = 120};
        if (_roleTag isEqualTo "officer") then {_priority = 100};
        _contactRows pushBack [_priority - (_age * 0.2),_id,_label,_pos,_age,_kind,_roleTag];
    };
} forEach (_picture getOrDefault ["contacts",[]]);
_contactRows sort false;
{
    if (_forEachIndex < 5) then {
        _x params ["_sort","_id","_label","_pos","_age","_kind","_roleTag"];
        if !(_id in _activeTargets) then {
            ["raid","contact",_id,_label,_pos,65 + _sort,_age,4,format ["Recent %1 contact",toUpper _kind]] call _push;
        };
    };
} forEach _contactRows;

// Force generation is a real strategic option instead of being automatic every think tick.
private _forceCount = _picture getOrDefault ["forceCount",0];
private _desired = _picture getOrDefault ["desiredForces",3];
if (_forceCount < _desired) then {
    ["raise_force","none","","NEW INFANTRY FORCE",[],45 + ((_desired - _forceCount) * 35),0,1,format ["Force strength %1/%2",_forceCount,_desired]] call _push;
};

// Choose one research option that fits the current posture.
private _f = [_factionId] call TYR_fnc_StateGetFaction;
private _research = _f getOrDefault ["research",createHashMap];
private _resources = _f getOrDefault ["resources",createHashMap];
private _commander = _f getOrDefault ["commander",createHashMap];
private _lastResearchAt = _commander getOrDefault ["lastResearchAt",-9999];
private _defs = call TYR_fnc_GetResearchDefinitions;
private _researchRows = [];
if ((serverTime - _lastResearchAt) >= 180) then {
{
    _x params ["_key","_name","_category","_cost","_prereqs"];
    if !(_research getOrDefault [_key,false]) then {
        private _ready = (_prereqs findIf {!(_research getOrDefault [_x,false])}) < 0;
        if (_ready && {(_resources getOrDefault ["steel",0]) >= _cost}) then {
            private _fit = switch (_posture) do {
                case "defensive": {if (_category in ["intelligence","infrastructure"]) then {35} else {15}};
                case "probe": {if (_category isEqualTo "intelligence") then {45} else {15}};
                case "offensive": {if (_category isEqualTo "procurement") then {40} else {18}};
                case "exploit": {if (_category isEqualTo "procurement") then {50} else {15}};
                default {22};
            };
            _researchRows pushBack [_fit - (_cost / 20000),_key,_name,_cost,_category];
        };
    };
} forEach _defs;
};
_researchRows sort false;
if (count _researchRows > 0) then {
    private _r = _researchRows # 0;
    _r params ["_fit","_key","_name","_cost","_category"];
    ["research","research",_key,_name,[],20 + _fit,0,1,format ["%1 research // steel %2",toUpper _category,round _cost]] call _push;
};

["hold","none","","HOLD / OBSERVE",[],8,0,0,"Preserve reserve and await better information"] call _push;
_candidates
