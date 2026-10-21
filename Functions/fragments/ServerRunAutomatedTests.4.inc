        [[3000 + (_i * 10), 3000 + (_i * 10), 0]] call TYR_fnc_ServerAddVLSTarget;
    };
    [(count (GameData # 0 # _teamIndex # 6)) isEqualTo 18, "VLS target storage cap", "Exactly 18 targets retained after 19 requests", format ["Stored %1 targets", count (GameData # 0 # _teamIndex # 6)]] call _check;

    // Removal must remove one valid target, reject an invalid index, then allow a replacement.
    private _targetsBeforeRemove = +(GameData # 0 # _teamIndex # 6);
    private _firstTarget = +(_targetsBeforeRemove # 0);
    [0] call TYR_fnc_ServerRemoveVLSTarget;
    private _targetsAfterRemove = +(GameData # 0 # _teamIndex # 6);
    private _validRemoveOK = (count _targetsAfterRemove) isEqualTo 17 && {(_targetsAfterRemove find _firstTarget) isEqualTo -1};
    [_validRemoveOK, "VLS valid target removal", "One stored target removed", format ["Target count after removal: %1", count _targetsAfterRemove]] call _check;

    private _countBeforeInvalidRemove = count _targetsAfterRemove;
    [-1] call TYR_fnc_ServerRemoveVLSTarget;
    [(count (GameData # 0 # _teamIndex # 6)) isEqualTo _countBeforeInvalidRemove, "VLS invalid removal is ignored", "Target count unchanged", "Invalid target index changed target storage"] call _check;

    [[9000, 9000, 0]] call TYR_fnc_ServerAddVLSTarget;
    [(count (GameData # 0 # _teamIndex # 6)) isEqualTo 18, "VLS target slot reusable after removal", "Returned to 18 stored targets", format ["Stored %1 targets", count (GameData # 0 # _teamIndex # 6)]] call _check;

    // Regression for the old strict-greater-than research bug: insufficient funds reject,
    // but an exact steel balance must be accepted and reduced to zero.
    GameData # 0 # _teamIndex set [1, 29999];
    ["intel.basic"] call TYR_fnc_ServerPurchaseResearch;
    private _insufficientOK = !([_sideIndex, "intel.basic"] call TYR_fnc_IsResearchUnlocked) && {(GameData # 0 # _teamIndex # 1) isEqualTo 29999};
    [_insufficientOK, "Research insufficient-funds rejection", "29,999 steel did not buy a 30,000-steel node", "Research unlocked or steel changed despite insufficient funds"] call _check;

    GameData # 0 # _teamIndex set [1, 30000];
    ["intel.basic"] call TYR_fnc_ServerPurchaseResearch;
    private _exactBalanceOK = [_sideIndex, "intel.basic"] call TYR_fnc_IsResearchUnlocked;
    _exactBalanceOK = _exactBalanceOK && {(GameData # 0 # _teamIndex # 1) isEqualTo 0};
    [_exactBalanceOK, "Research accepts exact steel balance", "30,000 steel bought a 30,000-steel node and left zero", "Exact-balance research purchase failed"] call _check;
};

// ----- Definition/schema checks -----
private _researchBranchSizes = [5, 6, 6];
private _badResearchDefinitions = [];
{
    private _bad = false;
    if !(_x isEqualType [] && {count _x >= 7}) then {
        _bad = true;
    } else {
        private _branchIndex = _x # 2;
        private _nodeIndex = _x # 3;
        _bad = !((_x # 0) isEqualType "") || {!((_x # 1) isEqualType "")} || {!(_branchIndex isEqualType 0)} || {!(_nodeIndex isEqualType 0)} || {!((_x # 4) isEqualType 0)} || {!((_x # 5) isEqualType [])};
        if (!_bad) then {
            _bad = _branchIndex < 0 || {_branchIndex >= count _researchBranchSizes} || {_nodeIndex < 0};
            if (!_bad) then {_bad = _nodeIndex >= (_researchBranchSizes # _branchIndex)};
        };
    };
    if (_bad) then {_badResearchDefinitions pushBack (_x param [0, format ["index %1", _forEachIndex]])};
} forEach _researchDefs;
[_badResearchDefinitions isEqualTo [], "Research definitions match runtime schema", "All branch/node positions and field types are valid", str _badResearchDefinitions] call _check;

private _nonPositiveResearchCosts = _researchDefs select {(_x # 4) <= 0};
[_nonPositiveResearchCosts isEqualTo [], "Research costs are positive", "Every research node has a positive steel cost", format ["Invalid costs: %1", _nonPositiveResearchCosts apply {_x # 0}]] call _check;

// Resolve the research graph from roots. If all nodes resolve, there are no cycles or
// impossible prerequisite chains among the known definitions.
private _resolvedResearch = [];
for "_passIndex" from 0 to (count _researchDefs) do {
    {
        private _key = _x # 0;
        if !(_key in _resolvedResearch) then {
            private _missingForGraph = (_x # 5) select {!(_x in _resolvedResearch)};
            if (_missingForGraph isEqualTo []) then {_resolvedResearch pushBack _key};
        };
    } forEach _researchDefs;
};
[(count _resolvedResearch) isEqualTo (count _researchDefs), "Research dependency graph is acyclic", format ["Resolved all %1 nodes", count _researchDefs], format ["Unresolved nodes: %1", _researchKeys select {!(_x in _resolvedResearch)}]] call _check;

private _badEmplacementDefinitions = [];
{
    private _bad = false;
    if !(_x isEqualType [] && {count _x >= 6}) then {
        _bad = true;
    } else {
        _bad = !((_x # 0) isEqualType "") || {!((_x # 1) isEqualType "")} || {!((_x # 2) in _researchKeys)} || {!((_x # 3) isEqualType 0)} || {(_x # 3) <= 0} || {!((_x # 4) isEqualType "")} || {!((_x # 5) isEqualType true)};
    };
    if (_bad) then {_badEmplacementDefinitions pushBack (_x param [0, format ["index %1", _forEachIndex]])};
} forEach _emplacementDefs;
[_badEmplacementDefinitions isEqualTo [], "Emplacement definitions match runtime schema", "Research links, costs, classes and implementation flags are valid", str _badEmplacementDefinitions] call _check;

// Security regression: only the validated remote endpoint may be remotely called.
// The mutation helper intentionally stays absent from CfgRemoteExec.
private _debugEndpointCfg = missionConfigFile >> "CfgRemoteExec" >> "Functions" >> "TYR_fnc_ServerDebugAction";
private _debugHelperCfg = missionConfigFile >> "CfgRemoteExec" >> "Functions" >> "TYR_fnc_ServerApplyDebugAction";
[isClass _debugEndpointCfg && {getNumber (_debugEndpointCfg >> "allowedTargets") isEqualTo 2}, "Debug endpoint is server-only", "TYR_fnc_ServerDebugAction is whitelisted only for the server", "Debug endpoint is missing or has the wrong allowedTargets"] call _check;
[!isClass _debugHelperCfg, "Debug mutation helper is not remotely exposed", "TYR_fnc_ServerApplyDebugAction is internal-only", "Internal debug helper unexpectedly appears in CfgRemoteExec"] call _check;

// Live player-record sanity using the snapshot captured before entering the sandbox.
private _livePlayerRecords = _realGameData # 0 # 3;
private _liveUIDs = _livePlayerRecords apply {_x param [0, ""]};
private _nonEmptyLiveUIDs = _liveUIDs select {_x isNotEqualTo ""};
private _uniqueLiveUIDs = _nonEmptyLiveUIDs arrayIntersect _nonEmptyLiveUIDs;
[(count _uniqueLiveUIDs) isEqualTo (count _nonEmptyLiveUIDs), "Player persistence has no duplicate UIDs", format ["Records: %1", count _livePlayerRecords], "Duplicate player UID records detected"] call _check;
[(getPlayerUID _caller) in _liveUIDs, "Current player has a persistence record", getPlayerUID _caller, "Current player UID is missing from campaign player records"] call _check;

// ----- Debug-mode mutation regression tests -----
// These call the same internal helper used by the network endpoint against sandboxed
// GameData, so they exercise real mutation logic without granting the tests remote access.
private _debugSide = if (_sideIndex in [0, 1]) then {_sideIndex} else {0};
private _debugTeamIndex = _debugSide + 1;
private _otherDebugSide = 1 - _debugSide;
private _otherDebugTeamIndex = _otherDebugSide + 1;

GameData # 0 # _debugTeamIndex set [1, 1000];
private _debugResult = [_debugSide, "resource", [_debugSide, 1, 250]] call TYR_fnc_ServerApplyDebugAction;
[(_debugResult # 0) && {(GameData # 0 # _debugTeamIndex # 1) isEqualTo 1250}, "Debug resource addition", "Added exactly 250 steel", format ["Steel: %1", GameData # 0 # _debugTeamIndex # 1]] call _check;

_debugResult = [_debugSide, "resource", [_debugSide, 1, -5000]] call TYR_fnc_ServerApplyDebugAction;
[(_debugResult # 0) && {(GameData # 0 # _debugTeamIndex # 1) isEqualTo 0}, "Debug resources cannot go negative", "Large subtraction clamped steel to zero", format ["Steel: %1", GameData # 0 # _debugTeamIndex # 1]] call _check;

GameData # 0 # _debugTeamIndex set [1, 0];
_debugResult = [_debugSide, "resource", [_debugSide, 1, 2000000]] call TYR_fnc_ServerApplyDebugAction;
[(_debugResult # 0) && {(GameData # 0 # _debugTeamIndex # 1) isEqualTo 1000000}, "Debug single-change safety clamp", "A +2,000,000 request was capped at +1,000,000", format ["Steel: %1", GameData # 0 # _debugTeamIndex # 1]] call _check;

GameData # 0 # _debugTeamIndex set [1, 222];
GameData # 0 # _otherDebugTeamIndex set [1, 111];
_debugResult = [_debugSide, "resource", [_otherDebugSide, 1, 333]] call TYR_fnc_ServerApplyDebugAction;
private _crossSideOK = (_debugResult # 0) && {(GameData # 0 # _otherDebugTeamIndex # 1) isEqualTo 444} && {(GameData # 0 # _debugTeamIndex # 1) isEqualTo 222};
[_crossSideOK, "Debug can target the opposing faction explicitly", "Only the selected faction changed", format ["Own %1 | Other %2", GameData # 0 # _debugTeamIndex # 1, GameData # 0 # _otherDebugTeamIndex # 1]] call _check;

private _beforeInvalidResource = [GameData # 0 # _debugTeamIndex # 1, GameData # 0 # _debugTeamIndex # 2, GameData # 0 # _debugTeamIndex # 3, GameData # 0 # _debugTeamIndex # 4];
_debugResult = [_debugSide, "resource", [_debugSide, 99, 500]] call TYR_fnc_ServerApplyDebugAction;
private _afterInvalidResource = [GameData # 0 # _debugTeamIndex # 1, GameData # 0 # _debugTeamIndex # 2, GameData # 0 # _debugTeamIndex # 3, GameData # 0 # _debugTeamIndex # 4];
[!(_debugResult # 0) && {_beforeInvalidResource isEqualTo _afterInvalidResource}, "Debug rejects invalid resource indices", "No resource changed", format ["Before %1 | After %2", _beforeInvalidResource, _afterInvalidResource]] call _check;

GameData # 0 # _debugTeamIndex set [1, 1];
GameData # 0 # _debugTeamIndex set [2, 2];
GameData # 0 # _debugTeamIndex set [3, 3];
GameData # 0 # _debugTeamIndex set [4, 4];
_debugResult = [_debugSide, "boostResources", [_debugSide]] call TYR_fnc_ServerApplyDebugAction;
private _boosted = [GameData # 0 # _debugTeamIndex # 1, GameData # 0 # _debugTeamIndex # 2, GameData # 0 # _debugTeamIndex # 3, GameData # 0 # _debugTeamIndex # 4];
[(_debugResult # 0) && {_boosted isEqualTo [100001,100002,100003,1004]}, "Debug resource boost uses expected amounts", str _boosted, "Boosted resources did not match expected values"] call _check;

_debugResult = [_debugSide, "maxResources", [_debugSide]] call TYR_fnc_ServerApplyDebugAction;
private _maxed = [GameData # 0 # _debugTeamIndex # 1, GameData # 0 # _debugTeamIndex # 2, GameData # 0 # _debugTeamIndex # 3, GameData # 0 # _debugTeamIndex # 4];
[(_debugResult # 0) && {_maxed isEqualTo [1000000,1000000,1000000,10000]}, "Debug max-resources preset", str _maxed, "Max-resources preset returned unexpected values"] call _check;

[_debugSide, "resetResearch", [_debugSide]] call TYR_fnc_ServerApplyDebugAction;
_debugResult = [_debugSide, "unlockResearch", [_debugSide]] call TYR_fnc_ServerApplyDebugAction;
private _allResearchUnlocked = (_researchDefs findIf {!([_debugSide, _x # 0] call TYR_fnc_IsResearchUnlocked)}) < 0;
private _gatedCategories = [1, 2, 4, 5, 6, 10, 11, 12, 13, 14];
private _allProcurementUnlocked = (_gatedCategories findIf {!([_debugSide, _x] call TYR_fnc_IsVehicleCategoryUnlocked)}) < 0;
[(_debugResult # 0) && {_allResearchUnlocked} && {_allProcurementUnlocked}, "Debug unlock-all research", "All 17 nodes and all gated procurement categories unlocked", "Unlock-all left research or procurement gates closed"] call _check;

_debugResult = [_debugSide, "resetResearch", [_debugSide]] call TYR_fnc_ServerApplyDebugAction;
private _allResearchReset = (_researchDefs findIf {[_debugSide, _x # 0] call TYR_fnc_IsResearchUnlocked}) < 0;
private _allProcurementReset = (_gatedCategories findIf {[_debugSide, _x] call TYR_fnc_IsVehicleCategoryUnlocked}) < 0;
[(_debugResult # 0) && {_allResearchReset} && {_allProcurementReset}, "Debug reset-all research", "All research and gated procurement returned to locked", "Reset-all left one or more research/procurement gates unlocked"] call _check;

private _unknownBefore = GameData # 0 # _debugTeamIndex # 1;
_debugResult = [_debugSide, "notARealAction", []] call TYR_fnc_ServerApplyDebugAction;
[!(_debugResult # 0) && {(GameData # 0 # _debugTeamIndex # 1) isEqualTo _unknownBefore}, "Unknown debug actions are non-mutating", "Unknown action was ignored", "Unknown action reported a mutation or changed resources"] call _check;

// Synthetic factory stockpile is safe because the sandbox location array is discarded.
private _syntheticFactory = ["Debug Factory", "Factory", 0, "ColorWEST", [worldSize / 2, worldSize / 2, 0], [], 123];
GameData # 1 set [2, [_syntheticFactory]];
_debugResult = [_debugSide, "fillFactories", []] call TYR_fnc_ServerApplyDebugAction;
[(_debugResult # 0) && {(GameData # 1 # 2 # 0 # 6) isEqualTo 50000}, "Debug fill-factories action", "Synthetic factory filled to the 50,000 cap", format ["Stock: %1", GameData # 1 # 2 # 0 # 6]] call _check;

// Exercise actual FactoryUpdate output and its +25% infrastructure bonus using one
// server-local factory object. It is deleted before the sandbox is restored.
private _factoryClass = "Land_DP_MainFactory_F";
if (isClass (configFile >> "CfgVehicles" >> _factoryClass)) then {
    private _factoryObject = createVehicleLocal [_factoryClass, [worldSize / 2, worldSize / 2, 1000], [], 0, "NONE"];
    if (!isNull _factoryObject) then {
        GameData # 1 set [2, [["Debug Production Factory", "Factory", 0, "ColorWEST", [worldSize / 2, worldSize / 2, 0], [_factoryObject], 0]]];
        [0, "resetResearch", [0]] call TYR_fnc_ServerApplyDebugAction;
        [0, "factoryTick", []] call TYR_fnc_ServerApplyDebugAction;
        private _baseFactoryOutput = GameData # 1 # 2 # 0 # 6;

        GameData # 1 # 2 # 0 set [6, 0];
        [0, "unlockResearch", [0]] call TYR_fnc_ServerApplyDebugAction;
        [0, "factoryTick", []] call TYR_fnc_ServerApplyDebugAction;
        private _upgradedFactoryOutput = GameData # 1 # 2 # 0 # 6;
        private _factoryResearchOK = _baseFactoryOutput > 0 && {_upgradedFactoryOutput > _baseFactoryOutput} && {abs (_upgradedFactoryOutput - (_baseFactoryOutput * 1.25)) < 0.1};
        [_factoryResearchOK, "Factory research production multiplier", format ["Base %1 | Upgraded %2", _baseFactoryOutput, _upgradedFactoryOutput], "Factory Production did not produce the expected +25% output"] call _check;
        deleteVehicle _factoryObject;
    } else {
        ["Factory research production multiplier", "WARN", "Factory class exists but a server-local test object could not be created"] call _record;
    };
} else {
    ["Factory research production multiplier", "WARN", format ["%1 is unavailable in the active game content", _factoryClass]] call _record;
};

private _saveCountBeforeDebugSave = missionNamespace getVariable ["TYR_testSaveCount", 0];
_debugResult = [_debugSide, "save", []] call TYR_fnc_ServerApplyDebugAction;
private _saveCountAfterDebugSave = missionNamespace getVariable ["TYR_testSaveCount", 0];
[!(_debugResult # 0) && {_saveCountAfterDebugSave isEqualTo (_saveCountBeforeDebugSave + 1)}, "Debug save-now reaches persistence layer", "Sandbox intercepted exactly one save request", format ["Save counter %1 -> %2", _saveCountBeforeDebugSave, _saveCountAfterDebugSave]] call _check;

// ----- Serialization checks -----
private _serialized = [] call TYR_fnc_SerializeGameState;
private _serializedShapeOK = _serialized isEqualType [] && {count _serialized isEqualTo 9} && {_serialized # 0 isEqualTo 3};
[_serializedShapeOK, "Serializer emits save format v3", "Nine-field v3 save generated", format ["Serialized shape: %1", if (_serialized isEqualType []) then {count _serialized} else {-1}]] call _check;

private _containsObject = {
    params ["_value"];
    if (_value isEqualType objNull) exitWith {true};
    if !(_value isEqualType []) exitWith {false};
    (_value findIf {[_x] call _containsObject}) >= 0
};
private _hasObject = [_serialized] call _containsObject;
[!_hasObject, "Serialized save contains no live object references", "Save is profileNamespace-safe", "A live OBJECT reference leaked into the serialized save"] call _check;

if (_sideIndex in [0, 1] && {_serializedShapeOK}) then {
    private _savedTeam = _serialized # 2 # _sideIndex;
    private _savedTargets = _savedTeam param [6, []];
    [(count _savedTargets) isEqualTo 18, "Strategic targets persist into save data", "18 sandbox targets serialized", format ["Serialized target count: %1", count _savedTargets]] call _check;
};

// A serialized snapshot must not track later scalar mutations to live GameData.
if (_serializedShapeOK) then {
    private _snapshotSteel = _serialized # 2 # _debugSide # 1;
    GameData # 0 # _debugTeamIndex set [1, _snapshotSteel + 777];
    [(_serialized # 2 # _debugSide # 1) isEqualTo _snapshotSteel, "Serialized snapshot is detached from later resource mutations", format ["Saved steel stayed at %1", _snapshotSteel], "Previously serialized steel changed when live state changed"] call _check;
};

private _suppressedBroadcasts = missionNamespace getVariable ["TYR_testBroadcastCount", 0];
private _suppressedSaves = missionNamespace getVariable ["TYR_testSaveCount", 0];
[(_suppressedBroadcasts > 0) && {_suppressedSaves > 0}, "Test sandbox intercepted production side effects", format ["Broadcasts suppressed: %1, saves suppressed: %2", _suppressedBroadcasts, _suppressedSaves], "Production paths did not hit the save/broadcast interceptors"] call _check;
