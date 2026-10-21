params ["_factionId","_picture","_posture","_candidate","_forceId"];
if (!isServer) exitWith {[false,"SERVER ONLY",""]};
private _type = _candidate getOrDefault ["type","hold"];
private _targetId = _candidate getOrDefault ["target",""];
private _targetName = _candidate getOrDefault ["targetName","TARGET"];

if (_type isEqualTo "hold") exitWith {[true,"HOLD // preserve reserve and continue observation",""]};
if (_type isEqualTo "research") exitWith {
    private _result = [_factionId,_targetId] call TYR_fnc_ResearchPurchase;
    if (_result param [0,false]) then {
        private _cmd = ([_factionId] call TYR_fnc_StateGetFaction) getOrDefault ["commander",createHashMap];
        _cmd set ["lastResearchAt",serverTime];
    };
    [_result param [0,false],if (_result param [0,false]) then {format ["RESEARCH // %1",toUpper _targetName]} else {format ["RESEARCH FAILED // %1",_result param [1,"UNKNOWN"]]},""]
};
if (_type isEqualTo "raise_force") exitWith {
    private _newId = [_factionId,"infantry",false] call TYR_fnc_AIForceCreate;
    [_newId isNotEqualTo "",if (_newId isEqualTo "") then {"FORCE GENERATION FAILED"} else {format ["RAISED NEW FORCE // %1",toUpper _newId]},""]
};

if (_forceId isEqualTo "") exitWith {[false,"NO FORCE SELECTED",""]};
private _opId = ["operation"] call TYR_fnc_StateNextId;
private _ops = TYR_State getOrDefault ["operations",createHashMap];
private _op = createHashMapFromArray [
    ["id",_opId],["faction",_factionId],["type",_type],["target",_targetId],
    ["targetType",_candidate getOrDefault ["targetType","location"]],
    ["targetName",_targetName],["targetPosition",+(_candidate getOrDefault ["targetPosition",[]])],
    ["phase","command_pending"],["forces",[_forceId]],["created",serverTime],
    ["score",_candidate getOrDefault ["score",0]],["reason",_candidate getOrDefault ["reason",""]],
    ["posture",_posture],["lastReview",serverTime],["outcomeReason",""]
];
_ops set [_opId,_op];
private _queued = [_factionId,_forceId,_opId,_targetId] call TYR_fnc_ServerCommandQueueOrder;
if (!_queued) exitWith {
    _ops deleteAt _opId;
    [false,format ["ORDER REJECTED // no route to %1",toUpper _forceId],""]
};
private _cmd = ([_factionId] call TYR_fnc_StateGetFaction) getOrDefault ["commander",createHashMap];
_cmd set ["objective",if ((_candidate getOrDefault ["targetType",""]) isEqualTo "location") then {_targetId} else {""}];
["ai-strategic-decision"] call TYR_fnc_StateMarkDirty;
private _delay = [_factionId] call TYR_fnc_CommandOrderDelay;
[true,format ["%1 %2 -> %3 // COMMAND_PENDING ~%4s",toUpper _type,toUpper _forceId,toUpper _targetName,round (_delay # 1)],_opId]
