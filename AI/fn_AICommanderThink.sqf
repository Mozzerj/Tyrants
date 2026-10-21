params ["_factionId"];
if (!isServer) exitWith {};
if (((TYR_State get "campaign") getOrDefault ["phase","deployment"]) isNotEqualTo "running") exitWith {};
private _f = [_factionId] call TYR_fnc_StateGetFaction;
if ((_f getOrDefault ["controller","human"]) isNotEqualTo "ai" || {!(_f getOrDefault ["active",false])}) exitWith {};

[_factionId] call TYR_fnc_AIEnsureForces;

private _cmd = _f get "commander";
private _personality = _cmd getOrDefault ["personality","balanced"];
private _posture = _cmd getOrDefault ["posture","balanced"];
private _trace = [format ["1 // INPUT\nPERSONALITY %1 // POSTURE %2",toUpper _personality,toUpper _posture]];

private _activeForces = [];
private _availableForces = [];
{
    private _fr = (TYR_State get "forces") get _x;
    if ((_fr getOrDefault ["faction",""]) isEqualTo _factionId && {_fr getOrDefault ["active",true]}) then {
        _activeForces pushBack _x;
        if ((_fr getOrDefault ["operation",""]) isEqualTo "") then {_availableForces pushBack _x};
    };
} forEach keys (TYR_State get "forces");
_trace pushBack format ["2 // FORCE STATE\nACTIVE %1 // AVAILABLE %2",count _activeForces,count _availableForces];

// Research opportunistically using the exact same prices/prerequisites as humans.
private _defs = call TYR_fnc_GetResearchDefinitions;
private _research = _f get "research";
private _r = _f get "resources";
private _candidates = _defs select {
    private _key = _x # 0;
    !(_research getOrDefault [_key,false]) &&
    {((_x # 4) findIf {!(_research getOrDefault [_x,false])}) < 0} &&
    {(_r getOrDefault ["steel",0]) >= ((_x # 3) * 1.35)}
};
private _researchText = "NO PURCHASE";
if (count _candidates > 0) then {
    private _def = selectRandom _candidates;
    [_factionId,_def # 0] call TYR_fnc_ResearchPurchase;
    _researchText = format ["UNLOCKED %1",toUpper (_def # 1)];
};
_trace pushBack format ["3 // RESEARCH\n%1 // %2 CANDIDATES",_researchText,count _candidates];

private _operations = TYR_State get "operations";
private _hasOperation = false;
private _activeOperationId = "";
{
    private _o = _operations get _x;
    if ((_o getOrDefault ["faction",""]) isEqualTo _factionId && {!((_o getOrDefault ["phase",""]) in ["complete","failed"])}) exitWith {
        _hasOperation = true;
        _activeOperationId = _x;
    };
} forEach keys _operations;
_trace pushBack format ["4 // OPERATION CHECK\n%1",if (_hasOperation) then {format ["ACTIVE // %1",toUpper _activeOperationId]} else {"NO ACTIVE OPERATION"}];

private _objective = "";
private _objectiveName = "NONE";
private _decisionText = "HOLD // EXISTING OPERATION";
if (!_hasOperation) then {
    _objective = [_factionId] call TYR_fnc_AISelectObjective;
    if (_objective isNotEqualTo "") then {
        private _loc = [_objective] call TYR_fnc_StateGetLocation;
        if (count _loc > 0) then {_objectiveName = _loc getOrDefault ["name",_objective]};
        if (count _availableForces > 0) then {
            private _opId = ["operation"] call TYR_fnc_StateNextId;
            private _forceId = _availableForces # 0;
            _operations set [_opId,createHashMapFromArray [
                ["id",_opId],["faction",_factionId],["type","attack"],["target",_objective],
                ["phase","move"],["forces",[_forceId]],["created",serverTime]
            ]];
            ((TYR_State get "forces") get _forceId) set ["operation",_opId];
            _cmd set ["objective",_objective];
            ["ai-operation"] call TYR_fnc_StateMarkDirty;
            _decisionText = format ["ASSIGN %1 -> %2",toUpper _forceId,toUpper _objectiveName];
        } else {
            _decisionText = format ["WAIT // NO FREE FORCE FOR %1",toUpper _objectiveName];
        };
    } else {
        _decisionText = "HOLD // NO VALID OBJECTIVE";
    };
} else {
    private _o = _operations getOrDefault [_activeOperationId,createHashMap];
    private _target = _o getOrDefault ["target",""];
    if (_target isNotEqualTo "") then {
        private _loc = [_target] call TYR_fnc_StateGetLocation;
        if (count _loc > 0) then {_objectiveName = _loc getOrDefault ["name",_target]};
    };
};
_trace pushBack format ["5 // OBJECTIVE\n%1",toUpper _objectiveName];
_trace pushBack format ["6 // DECISION\n%1",_decisionText];

private _traces = TYR_Runtime getOrDefault ["aiDecisionTraces",createHashMap];
_traces set [_factionId,[serverTime,_trace]];
TYR_Runtime set ["aiDecisionTraces",_traces];

private _obj = _cmd getOrDefault ["objective",""];
private _objName = "";
if (_obj isNotEqualTo "") then {
    private _l = [_obj] call TYR_fnc_StateGetLocation;
    if (count _l > 0) then {_objName = _l get "name"};
};
_f set ["commanderPublic",[
    _personality,
    _posture,
    _objName
]];
[_factionId] call TYR_fnc_ServerPublishFaction;
