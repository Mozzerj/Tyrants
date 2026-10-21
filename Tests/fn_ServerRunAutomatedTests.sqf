if (!isServer) exitWith {};
private _owner = remoteExecutedOwner;
private _player = [_owner] call TYR_fnc_FindPlayerByOwner;
private _checks = [];
private _check = {
    params ["_name","_ok",["_detail",""]];
    _checks pushBack [if (_ok) then {"PASS"} else {"FAIL"},_name,_detail];
};

["No legacy GameData runtime",isNil "GameData"] call _check;
private _ids = [false] call TYR_fnc_FactionIds;
["Three faction records",_ids isEqualTo ["west","east","independent"],str _ids] call _check;
private _campaign = TYR_State get "campaign";
private _dep = _campaign getOrDefault ["deployment",createHashMap];
private _sectors = _dep getOrDefault ["sectors",createHashMap];
private _activeIds = [true] call TYR_fnc_FactionIds;
["Active factions have deployment sectors",(_activeIds findIf {!(_x in keys _sectors)}) < 0,str keys _sectors] call _check;
private _sectorShapeOk = (_activeIds findIf {
    private _s = _sectors getOrDefault [_x,[]];
    !(_s isEqualType [] && {count _s >= 2} && {(_s # 0) isEqualType 0} && {(_s # 1) isEqualType 0} && {(_s # 1) > 0})
}) < 0;
["Deployment sector geometry is valid",_sectorShapeOk,str _sectors] call _check;
private _publicCampaign = call TYR_fnc_StatePublicCampaign;
private _publicSectorCount = if (_publicCampaign isEqualType [] && {count _publicCampaign >= 2} && {(_publicCampaign # 1) isEqualType []} && {count (_publicCampaign # 1) >= 3}) then {count ((_publicCampaign # 1) # 2)} else {-1};
["Deployment sectors are present in public campaign replication",_publicSectorCount isEqualTo count _activeIds,str _publicCampaign] call _check;
{
    private _f = [_x] call TYR_fnc_StateGetFaction;
    [format ["Faction %1 has resources",_x],count (_f getOrDefault ["resources",createHashMap]) isEqualTo 4] call _check;
    [format ["Faction %1 has commander",_x],count (_f getOrDefault ["commander",createHashMap]) > 0] call _check;
    private _network = _f getOrDefault ["commandNetwork",createHashMap];
    [format ["Faction %1 has physical command-network state",_x],count _network > 0] call _check;
    if ((_campaign getOrDefault ["phase","deployment"]) isEqualTo "running" && {_f getOrDefault ["active",false]}) then {
        private _main = _network getOrDefault ["main",""];
        private _officers = _network getOrDefault ["officers",[]];
        [format ["Faction %1 has a main command node",_x],_main isNotEqualTo "",_main] call _check;
        [format ["Faction %1 has command officers",_x],count _officers > 0,str _officers] call _check;
    };
} forEach _ids;
private _westPublicToEast = ["west","east"] call TYR_fnc_StatePublicFaction;
["Enemy HQ is absent from public faction replication",count _westPublicToEast > 4 && {count (_westPublicToEast # 4) isEqualTo 0}] call _check;
["Enemy resources are redacted",count _westPublicToEast > 5 && {(_westPublicToEast # 5) isEqualTo [-1,-1,-1,-1]}] call _check;
["Enemy research and VLS targets are redacted",count _westPublicToEast > 7 && {count (_westPublicToEast # 6) isEqualTo 0} && {count (_westPublicToEast # 7) isEqualTo 0}] call _check;
["Enemy command network is redacted",count _westPublicToEast > 12 && {count (_westPublicToEast # 12) isEqualTo 0}] call _check;
["Enemy HQ depot stock is redacted",count _westPublicToEast > 13 && {count (_westPublicToEast # 13) isEqualTo 0}] call _check;
private _westPublicOwn = ["west","west"] call TYR_fnc_StatePublicFaction;
["Own command summary is available",count _westPublicOwn > 12 && {(_westPublicOwn # 12) isEqualType []} && {count (_westPublicOwn # 12) >= 7}] call _check;
["Own HQ depot inventory is available",count _westPublicOwn > 13 && {(_westPublicOwn # 13) isEqualType []}] call _check;
["Top-level logistics state exists",(TYR_State getOrDefault ["logistics",createHashMap]) isEqualType createHashMap] call _check;
private _munitionsCatalog = ["west","munitions"] call TYR_fnc_ProductionGetCatalog;
["Munitions production catalog contains general ammo",(_munitionsCatalog findIf {(_x # 0) isEqualTo "general_ammo"}) >= 0,str _munitionsCatalog] call _check;
private _unknownLocationOk = true;
private _westKnowledge = ["west","locations",""] call TYR_fnc_StateKnowledgeGet;
{
    private _l = [_x] call TYR_fnc_StateGetLocation;
    if ((_l getOrDefault ["owner","neutral"]) isNotEqualTo "west" && {!(_x in keys _westKnowledge)}) exitWith {
        private _public = [_x,"west"] call TYR_fnc_StatePublicLocation;
        _unknownLocationOk = count _public > 5 && {(_public # 4) isEqualTo "unknown"} && {(_public # 5) isEqualTo -1};
    };
} forEach keys (TYR_State get "locations");
["Unobserved enemy/neutral location truth is hidden",_unknownLocationOk] call _check;

// Intelligence-contact state test. This uses a temporary server-only target and restores
// the faction knowledge map afterwards so automated testing does not become gameplay intel.
private _westFaction = ["west"] call TYR_fnc_StateGetFaction;
private _westKnowledgeRecord = _westFaction getOrDefault ["knowledge",createHashMap];
private _savedContacts = _westKnowledgeRecord getOrDefault ["contacts",createHashMap];
private _savedIntelLog = +(_westKnowledgeRecord getOrDefault ["log",[]]);
_westKnowledgeRecord set ["contacts",createHashMap];
_westKnowledgeRecord set ["log",[]];
private _testTarget = createVehicle ["O_Quadbike_01_F",[worldSize * 0.5,worldSize * 0.5,0],[],0,"CAN_COLLIDE"];
_testTarget allowDamage false;
_testTarget setVariable ["TYR_factionId","east",false];
_testTarget setVariable ["TYR_intelContactId","AUTOTEST_CONTACT",false];

private _broadWritten = ["west",_testTarget,"autotest",objNull] call TYR_fnc_StateObserveContact;
private _testContactBroad = ["west","contacts","AUTOTEST_CONTACT"] call TYR_fnc_StateKnowledgeGet;
["Visual contact record can be created",_broadWritten && {count _testContactBroad > 0}] call _check;
["Far/unresolved contact stays broad",count _testContactBroad > 0 && {!(_testContactBroad getOrDefault ["exact",true])} && {(_testContactBroad getOrDefault ["label",""]) isEqualTo "WHEELED VEHICLE"},str _testContactBroad] call _check;

private _publicIntelOwn = ["west","west"] call TYR_fnc_StatePublicKnowledge;
private _publicIntelEnemy = ["west","east"] call TYR_fnc_StatePublicKnowledge;
["Faction knowledge publishes only to its own faction",count _publicIntelOwn >= 4 && {count (_publicIntelOwn # 2) isEqualTo 1} && {count _publicIntelEnemy isEqualTo 0}] call _check;

private _oldIntelPos = +(_testContactBroad getOrDefault ["position",[]]);
_testTarget setPosATL [(_oldIntelPos # 0) + 100,(_oldIntelPos # 1) + 50,_oldIntelPos param [2,0]];
private _frozenContact = ["west","contacts","AUTOTEST_CONTACT"] call TYR_fnc_StateKnowledgeGet;
["Last-known contact freezes without a new observation",(_frozenContact getOrDefault ["position",[]]) isEqualTo _oldIntelPos] call _check;

private _identifiedWritten = ["west",_testTarget,"autotest",_testTarget] call TYR_fnc_StateObserveContact;
private _testContactExact = ["west","contacts","AUTOTEST_CONTACT"] call TYR_fnc_StateKnowledgeGet;
["Optical/close reacquisition upgrades identification",_identifiedWritten && {_testContactExact getOrDefault ["exact",false]} && {(_testContactExact getOrDefault ["label",""]) isNotEqualTo "WHEELED VEHICLE"},str _testContactExact] call _check;
["Reobservation updates last-known position",((_testContactExact getOrDefault ["position",[]]) distance2D (getPosATL _testTarget)) < 1] call _check;
private _testIntelLog = _westKnowledgeRecord getOrDefault ["log",[]];
["Intelligence events create a faction log",count _testIntelLog >= 2,str _testIntelLog] call _check;

deleteVehicle _testTarget;
_westKnowledgeRecord set ["contacts",_savedContacts];
_westKnowledgeRecord set ["log",_savedIntelLog];
["west"] call TYR_fnc_ServerPublishKnowledge;

["Ocean/world-origin is rejected as player land position",!([[0,0,0]] call TYR_fnc_IsValidLandPosition)] call _check;
private _confirmedFaction = "";
{
    private _f = [_x] call TYR_fnc_StateGetFaction;
    if ((_f getOrDefault ["active",false]) && {_f getOrDefault ["baseConfirmed",false]} && {[_f getOrDefault ["basePosition",[]]] call TYR_fnc_IsValidLandPosition}) exitWith {_confirmedFaction=_x};
} forEach _ids;
if (_confirmedFaction isNotEqualTo "") then {
    private _cf = [_confirmedFaction] call TYR_fnc_StateGetFaction;
    private _safeFallback = [[0,0,0],_cf get "basePosition"] call TYR_fnc_FindSafeSpawnPosition;
    ["Invalid player position falls back to confirmed HQ land",[_safeFallback] call TYR_fnc_IsValidLandPosition,str _safeFallback] call _check;
};

private _snapshot = call TYR_fnc_PersistenceBuildSnapshot;
private _generation = (TYR_Runtime getOrDefault ["saveGeneration",0])+1;
private _record = ["TYRANTS_V4",2,_generation,worldName,systemTime,serverTime,_snapshot,hashValue str _snapshot];
["Save snapshot validates",[_record] call TYR_fnc_PersistenceValidateRecord] call _check;

private _objectLeak = false;
private _walk = {
    params ["_v"];
    if (_v isEqualType objNull || {_v isEqualType grpNull} || {_v isEqualType {}}) exitWith {_objectLeak=true};
    if (_v isEqualType []) then {{[_x] call _walk} forEach _v};
};
[_snapshot] call _walk;
["Save has no runtime object/group/code values",!_objectLeak] call _check;

private _locCount = count keys (TYR_State get "locations");
["Strategic world index exists",_locCount > 10,str _locCount] call _check;

private _aiPipelineOk = false;
private _aiPipelineDetail = "";
{
    private _f = [_x] call TYR_fnc_StateGetFaction;
    if ((_f getOrDefault ["active",false])) exitWith {
        private _picture = [_x] call TYR_fnc_AIBuildPicture;
        private _postureResult = [_x,_picture] call TYR_fnc_AIAssessPosture;
        private _candidates = [_x,_picture,_postureResult # 0] call TYR_fnc_AIGenerateCandidates;
        private _ranked = [_x,_picture,_postureResult # 0,_candidates] call TYR_fnc_AIScoreCandidates;
        _aiPipelineOk = count _picture > 0 && {count _candidates > 0} && {count _ranked > 0};
        _aiPipelineDetail = format ["%1 // %2 candidates // posture %3",_x,count _ranked,_postureResult # 0];
    };
} forEach _ids;
["Strategic AI can build picture, posture and ranked candidates",_aiPipelineOk,_aiPipelineDetail] call _check;

private _fail = {_x # 0 isEqualTo "FAIL"} count _checks;
private _lines = [format ["TYRANTS V4 AUTOTEST // %1 checks // %2 failed",count _checks,_fail]];
{_lines pushBack format ["[%1] %2 %3",_x # 0,_x # 1,_x # 2]} forEach _checks;
private _report = _lines joinString toString [10];
diag_log _report;
if (!isNull _player) then {[_player,"TYR_fnc_ClientShowTestReport",[_report]] call TYR_fnc_ServerSendToPlayer};
