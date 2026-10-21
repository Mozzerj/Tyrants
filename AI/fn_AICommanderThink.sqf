params ["_factionId"];
if (!isServer) exitWith {};
if (((TYR_State get "campaign") getOrDefault ["phase","deployment"]) isNotEqualTo "running") exitWith {};
private _f = [_factionId] call TYR_fnc_StateGetFaction;
if ((_f getOrDefault ["controller","human"]) isNotEqualTo "ai" || {!(_f getOrDefault ["active",false])}) exitWith {};

[_factionId] call TYR_fnc_AIEnsureForces;

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
if (count _candidates > 0) then {
    private _def = selectRandom _candidates;
    [_factionId,_def # 0] call TYR_fnc_ResearchPurchase;
};

private _operations = TYR_State get "operations";
private _hasOperation = false;
{
    private _o = _operations get _x;
    if ((_o getOrDefault ["faction",""]) isEqualTo _factionId && {!((_o getOrDefault ["phase",""]) in ["complete","failed"])}) exitWith {_hasOperation=true};
} forEach keys _operations;

private _objective = "";
if (!_hasOperation) then {
    _objective = [_factionId] call TYR_fnc_AISelectObjective;
    if (_objective isNotEqualTo "") then {
        private _available = [];
        {
            private _fr = (TYR_State get "forces") get _x;
            if ((_fr getOrDefault ["faction",""]) isEqualTo _factionId && {_fr getOrDefault ["active",true]} && {(_fr getOrDefault ["operation",""]) isEqualTo ""}) then {
                _available pushBack _x;
            };
        } forEach keys (TYR_State get "forces");
        if (count _available > 0) then {
            private _opId = ["operation"] call TYR_fnc_StateNextId;
            private _forceId = _available # 0;
            _operations set [_opId,createHashMapFromArray [
                ["id",_opId],["faction",_factionId],["type","attack"],["target",_objective],
                ["phase","move"],["forces",[_forceId]],["created",serverTime]
            ]];
            ((TYR_State get "forces") get _forceId) set ["operation",_opId];
            ((_f get "commander")) set ["objective",_objective];
            ["ai-operation"] call TYR_fnc_StateMarkDirty;
        };
    };
};

private _cmd = _f get "commander";
private _obj = _cmd getOrDefault ["objective",""];
private _objName = "";
if (_obj isNotEqualTo "") then {
    private _l = [_obj] call TYR_fnc_StateGetLocation;
    if (count _l > 0) then {_objName = _l get "name"};
};
_f set ["commanderPublic",[
    _cmd getOrDefault ["personality","balanced"],
    _cmd getOrDefault ["posture","balanced"],
    _objName
]];
[_factionId] call TYR_fnc_ServerPublishFaction;
