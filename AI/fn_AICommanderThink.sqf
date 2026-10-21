params ["_factionId",["_traceSlow",false]];
if (!isServer) exitWith {};
if (((TYR_State get "campaign") getOrDefault ["phase","deployment"]) isNotEqualTo "running") exitWith {};
private _f = [_factionId] call TYR_fnc_StateGetFaction;
if ((_f getOrDefault ["controller","human"]) isNotEqualTo "ai" || {!(_f getOrDefault ["active",false])} || {_f getOrDefault ["eliminated",false]}) exitWith {};

private _thinkLocks = TYR_Runtime getOrDefault ["aiThinkLocks",createHashMap];
if (_thinkLocks getOrDefault [_factionId,false]) exitWith {};
_thinkLocks set [_factionId,true];
TYR_Runtime set ["aiThinkLocks",_thinkLocks];
private _unlockThink = {
    private _locks = TYR_Runtime getOrDefault ["aiThinkLocks",createHashMap];
    _locks set [_factionId,false];
    TYR_Runtime set ["aiThinkLocks",_locks];
};

[_factionId] call TYR_fnc_AIEnsureForces;

private _cmd = _f getOrDefault ["commander",createHashMap];
private _personality = _cmd getOrDefault ["personality","balanced"];
private _started = serverTime;
private _nodes = [];
for "_i" from 1 to 12 do {_nodes pushBack [_i,"WAITING","","pending",""]};
private _candidateDebug = [];
private _decisionText = "NO DECISION";
private _posture = _cmd getOrDefault ["posture","hold"];
private _currentStep = 0;

private _storeTrace = {
    private _traceMap = TYR_Runtime getOrDefault ["aiDecisionTraces",createHashMap];
    _traceMap set [_factionId,createHashMapFromArray [
        ["started",_started],["updated",serverTime],["finished",-1],["currentStep",_currentStep],
        ["nodes",+_nodes],["candidates",+_candidateDebug],["decision",_decisionText],["posture",_posture]
    ]];
    TYR_Runtime set ["aiDecisionTraces",_traceMap];
};
private _step = {
    params ["_index","_title","_outcome",["_state","done"],["_detail",""]];
    _currentStep = _index;
    _nodes set [_index - 1,[_index,_title,_outcome,_state,_detail]];
    call _storeTrace;
    if (_traceSlow) then {sleep 0.55};
};
private _finish = {
    params ["_finalDecision",["_finalStep",12],["_outcome",""]];
    _decisionText = _finalDecision;
    _currentStep = _finalStep;
    if (_outcome isNotEqualTo "") then {
        private _n = _nodes # (_finalStep - 1);
        _n set [2,_outcome];
        _n set [3,"current"];
        _nodes set [_finalStep - 1,_n];
    };
    private _traceMap = TYR_Runtime getOrDefault ["aiDecisionTraces",createHashMap];
    _traceMap set [_factionId,createHashMapFromArray [
        ["started",_started],["updated",serverTime],["finished",serverTime],["currentStep",_currentStep],
        ["nodes",+_nodes],["candidates",+_candidateDebug],["decision",_decisionText],["posture",_posture]
    ]];
    TYR_Runtime set ["aiDecisionTraces",_traceMap];
};

private _network = [_factionId] call TYR_fnc_CommandNetworkGet;
private _commandStatus = _network getOrDefault ["status","forming"];
[1,"COMMAND STATE",format ["%1 // personality %2",toUpper _commandStatus,toUpper _personality],"done","Can strategic command issue new intent?"] call _step;
if (_commandStatus in ["collapsed","eliminated"]) exitWith {
    [2,"EMERGENCY OVERRIDE","COMMAND COLLAPSE // local force control only","blocked","No new strategic order can be created"] call _step;
    [3,"STRATEGIC PICTURE","SKIPPED","skipped",""] call _step;
    [4,"OPERATION REVIEW","Existing delivered orders continue locally","done",""] call _step;
    [5,"POSTURE","COLLAPSED","done",""] call _step;
    [6,"GENERATE ACTIONS","NONE","skipped",""] call _step;
    [7,"SCORE ACTIONS","NONE","skipped",""] call _step;
    [8,"VALIDATE","NO COMMAND ROUTE","blocked",""] call _step;
    [9,"CREATE ORDER","NONE","skipped",""] call _step;
    [10,"COMMAND ROUTE","DOWN","blocked",""] call _step;
    [11,"FORCE EXECUTION","LAST DELIVERED ORDERS ONLY","done",""] call _step;
    [12,"REVIEW / OUTCOME","HOLD LAST ORDERS","current",""] call _step;
    ["HOLD LAST ORDERS // COMMAND NETWORK DOWN",12,"HOLD LAST ORDERS"] call _finish;
    call _unlockThink;
};

private _picture = [_factionId] call TYR_fnc_AIBuildPicture;
private _threats = _picture getOrDefault ["emergencyThreats",[]];
[2,"EMERGENCY OVERRIDE",if (count _threats > 0) then {format ["YES // %1 known critical threat(s)",count _threats]} else {"NO // no known critical threat"},if (count _threats > 0) then {"branch"} else {"done"},"Uses faction-known contacts only"] call _step;

private _pictureSummary = format ["FORCES %1 (%2 free) // HOSTILE SITES %3 // UNKNOWN %4 // CONTACTS %5",
    _picture getOrDefault ["forceCount",0],_picture getOrDefault ["availableCount",0],
    count (_picture getOrDefault ["knownHostileLocations",[]]),count (_picture getOrDefault ["unknownLocations",[]]),count (_picture getOrDefault ["contacts",[]])];
[3,"STRATEGIC PICTURE",_pictureSummary,"done","Own truth + collected enemy intelligence; never hidden enemy state"] call _step;

private _review = [_factionId,_picture] call TYR_fnc_AIReassessOperations;
_review params ["_reviewState","_reviewRows","_reviewText"];
[4,"OPERATION REVIEW",format ["%1 // %2",toUpper _reviewState,_reviewText],if (_reviewState isEqualTo "aborted") then {"branch"} else {"done"},if (count _reviewRows > 0) then {str (_reviewRows # 0)} else {"No active operation"}] call _step;

// Rebuild the picture after reassessment because aborted operations may free forces.
_picture = [_factionId] call TYR_fnc_AIBuildPicture;
private _postureResult = [_factionId,_picture] call TYR_fnc_AIAssessPosture;
_posture = _postureResult # 0;
[5,"POSTURE",format ["%1 // %2",toUpper _posture,_postureResult # 1],"done","Emergency > defensive > consolidate > probe > offensive/exploit > hold"] call _step;

private _difficulty = _cmd getOrDefault ["difficulty",1];
private _maxOperations = 1 + floor (_difficulty / 2);
private _activeOps = count (_picture getOrDefault ["activeOperations",[]]);
private _candidates = [_factionId,_picture,_posture] call TYR_fnc_AIGenerateCandidates;
if (_activeOps >= _maxOperations) then {
    _candidates = _candidates select {(_x getOrDefault ["type",""]) in ["research","raise_force","hold"]};
};
[6,"GENERATE ACTIONS",format ["%1 legal possibilities // strategic slots %2/%3",count _candidates,_activeOps,_maxOperations],"done","Attack, raid, recon, probe, defence, force generation, research, hold"] call _step;

private _ranked = [_factionId,_picture,_posture,_candidates] call TYR_fnc_AIScoreCandidates;
_candidateDebug = [];
{
    if (_forEachIndex < 8) then {
        _candidateDebug pushBack [
            _x getOrDefault ["type",""],_x getOrDefault ["targetName",""],_x getOrDefault ["score",0],
            "unvalidated",_x getOrDefault ["reason",""],_x getOrDefault ["scoreBreakdown",""]
        ];
    };
} forEach _ranked;
[7,"SCORE ACTIONS",if (count _ranked > 0) then {format ["TOP // %1 -> %2 // %3 pts",toUpper ((_ranked # 0) getOrDefault ["type",""]),toUpper ((_ranked # 0) getOrDefault ["targetName",""]),round ((_ranked # 0) getOrDefault ["score",0])]} else {"NO CANDIDATES"},"done","Ranks strategic value against distance, stale intel, posture, command condition and reserve"] call _step;

private _selected = createHashMap;
private _selectedForce = "";
private _validationReason = "NO CANDIDATE PASSED";
{
    private _validation = [_factionId,_picture,_x] call TYR_fnc_AIValidateCandidate;
    private _valid = _validation # 0;
    private _reason = _validation # 1;
    if (_forEachIndex < count _candidateDebug) then {
        private _row = _candidateDebug # _forEachIndex;
        _row set [3,if (_valid) then {"valid"} else {"rejected"}];
        _row set [4,format ["%1 // %2",_row # 4,_reason]];
        _candidateDebug set [_forEachIndex,_row];
    };
    if (_valid && {count _selected isEqualTo 0}) then {
        _selected = _x;
        _selectedForce = _validation # 2;
        _validationReason = _reason;
    };
} forEach _ranked;
[8,"VALIDATE",if (count _selected > 0) then {format ["PASS // %1",_validationReason]} else {"FAIL // no candidate passed hard prerequisites"},if (count _selected > 0) then {"done"} else {"blocked"},"Checks real resources, reserve, intel age, force availability and command route"] call _step;

if (count _selected isEqualTo 0) exitWith {
    [9,"CREATE ORDER","NONE","skipped",""] call _step;
    [10,"COMMAND ROUTE","NO NEW ORDER","skipped",""] call _step;
    [11,"FORCE EXECUTION","CONTINUE EXISTING / LOCAL ACTIVITY","done",""] call _step;
    [12,"REVIEW / OUTCOME","HOLD // no valid strategic action","current",""] call _step;
    ["HOLD // NO VALID STRATEGIC ACTION",12,"HOLD"] call _finish;
    call _unlockThink;
};

private _selectedType = _selected getOrDefault ["type","hold"];
private _selectedName = _selected getOrDefault ["targetName","TARGET"];
[9,"CREATE ORDER",format ["SELECTED // %1 -> %2",toUpper _selectedType,toUpper _selectedName],"branch",_selected getOrDefault ["reason",""]] call _step;

private _execution = [_factionId,_picture,_posture,_selected,_selectedForce] call TYR_fnc_AIExecuteCandidate;
_execution params ["_executed","_executeText","_opId"];
private _routeText = if (_opId isNotEqualTo "") then {
    private _op = (TYR_State getOrDefault ["operations",createHashMap]) getOrDefault [_opId,createHashMap];
    private _orderId = _op getOrDefault ["orderId",""];
    private _order = (TYR_State getOrDefault ["commandOrders",createHashMap]) getOrDefault [_orderId,createHashMap];
    private _route = _order getOrDefault ["route",[]];
    format ["%1 HOPS // ETA %2s",count _route,round ((_order getOrDefault ["deliverAt",serverTime]) - serverTime)]
} else {"DIRECT STRATEGIC ACTION // no force order"};
[10,"COMMAND ROUTE",_routeText,if (_executed) then {"done"} else {"blocked"},"Main Commander -> officer -> force commander where required"] call _step;
[11,"FORCE EXECUTION",if (_opId isNotEqualTo "") then {format ["%1 waits for delivered intent then executes locally",toUpper _selectedForce]} else {_executeText},if (_executed) then {"done"} else {"blocked"},"Combat behaviour remains local after strategic intent is delivered"] call _step;

_decisionText = _executeText;
[12,"REVIEW / OUTCOME",_executeText,"current",if (_opId isNotEqualTo "") then {format ["Operation %1 will be reassessed on later commander ticks",toUpper _opId]} else {"Strategic action completed immediately"}] call _step;
[_executeText,12,_executeText] call _finish;

private _obj = _cmd getOrDefault ["objective",""];
private _objName = "";
if (_obj isNotEqualTo "") then {
    private _l = [_obj] call TYR_fnc_StateGetLocation;
    if (count _l > 0) then {_objName = _l getOrDefault ["name",_obj]};
};
_f set ["commanderPublic",[_personality,_posture,_objName]];
[_factionId] call TYR_fnc_ServerPublishFaction;
call _unlockThink;
