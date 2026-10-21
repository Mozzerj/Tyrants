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
} forEach _ids;
private _westPublicToEast = ["west","east"] call TYR_fnc_StatePublicFaction;
["Enemy HQ is absent from public faction replication",count _westPublicToEast > 4 && {count (_westPublicToEast # 4) isEqualTo 0}] call _check;
["Enemy resources are redacted",count _westPublicToEast > 5 && {(_westPublicToEast # 5) isEqualTo [-1,-1,-1,-1]}] call _check;
["Enemy research and VLS targets are redacted",count _westPublicToEast > 7 && {count (_westPublicToEast # 6) isEqualTo 0} && {count (_westPublicToEast # 7) isEqualTo 0}] call _check;
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

private _objective = "";
{
    private _f = [_x] call TYR_fnc_StateGetFaction;
    if ((_f getOrDefault ["active",false])) exitWith {_objective=[_x] call TYR_fnc_AISelectObjective};
} forEach _ids;
["Commander can score an objective",_objective isNotEqualTo "",_objective] call _check;

private _fail = {_x # 0 isEqualTo "FAIL"} count _checks;
private _lines = [format ["TYRANTS V4 AUTOTEST // %1 checks // %2 failed",count _checks,_fail]];
{_lines pushBack format ["[%1] %2 %3",_x # 0,_x # 1,_x # 2]} forEach _checks;
private _report = _lines joinString toString [10];
diag_log _report;
if (!isNull _player) then {[_player,"TYR_fnc_ClientShowTestReport",[_report]] call TYR_fnc_ServerSendToPlayer};
