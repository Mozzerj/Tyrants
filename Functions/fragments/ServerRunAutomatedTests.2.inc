    [_baseObjectsOK, "Base runtime objects initialized", "Arsenal boxes and accountants exist", "One or more base runtime objects are missing"] call _check;
};

private _catalogue = GameData # 3;
if (_catalogue isEqualType [] && {count _catalogue >= 2} && {(GameData # 3 # 1) isEqualType []} && {count (GameData # 3 # 1) > 0}) then {
    private _badEntries = 0;
    private _missingClasses = 0;
    private _vehicleClasses = [];
    {
        {
            if !(_x isEqualType [] && {count _x >= 9}) then {
                _badEntries = _badEntries + 1;
            } else {
                private _className = _x # 1;
                if !(isClass (configFile >> "CfgVehicles" >> _className)) then {_missingClasses = _missingClasses + 1};
                _vehicleClasses pushBack _className;
            };
        } forEach _x;
    } forEach (GameData # 3 # 1);
    [_badEntries isEqualTo 0, "Vehicle catalogue records valid", format ["Entries: %1", count _vehicleClasses], format ["Malformed entries: %1", _badEntries]] call _check;
    [_missingClasses isEqualTo 0, "Vehicle catalogue classes exist", "All selected classes exist in CfgVehicles", format ["Missing classes: %1", _missingClasses]] call _check;
    private _uniqueClasses = _vehicleClasses arrayIntersect _vehicleClasses;
    [(count _uniqueClasses) isEqualTo (count _vehicleClasses), "Vehicle catalogue has no duplicate classes", "", format ["Duplicate entries: %1", (count _vehicleClasses) - (count _uniqueClasses)]] call _check;
} else {
    ["Vehicle catalogue checks", "WARN", "Catalogue is empty or setup has not populated it yet"] call _record;
};

private _profile = [_caller] call TYR_fnc_GetUnitProfile;
private _loadoutValue = [_profile] call TYR_fnc_GetLoadoutValue;
[_loadoutValue isEqualType 0 && {_loadoutValue >= 0}, "Current loadout can be priced", format ["Computed value: %1", round _loadoutValue], "Loadout pricing returned an invalid value"] call _check;

private _savedV3 = profileNamespace getVariable ["TYR_Save_v3", []];
private _saveLooksV3 = _savedV3 isEqualType [] && {count _savedV3 >= 9} && {_savedV3 # 0 isEqualTo 3};
[_saveLooksV3, "Persistent save is v3", if (_saveLooksV3) then {"TYR_Save_v3 is present"} else {""}, "No valid v3 save is currently stored"] call _check;

// ----- Isolated production-state checks -----
missionNamespace setVariable ["TYR_testBackupGameData", _realGameData];
missionNamespace setVariable ["TYR_testInProgress", true];
missionNamespace setVariable ["TYR_testBroadcastCount", 0];
missionNamespace setVariable ["TYR_testSaveCount", 0];
publicVariable "TYR_testInProgress";

// Fail-safe: if a runtime error ever aborts this function before restoration,
// recover the live campaign as soon as the scheduler gets control again.
[] spawn {
    sleep 2;
    if (missionNamespace getVariable ["TYR_testInProgress", false]) then {
        private _backup = missionNamespace getVariable ["TYR_testBackupGameData", []];
        if (_backup isEqualType [] && {count _backup > 0}) then {
            GameData = _backup;
        };
        missionNamespace setVariable ["TYR_testInProgress", false];
        publicVariable "TYR_testInProgress";
        [] call TYR_fnc_ServerBroadcastState;
        diag_log "[TYRANTS TEST] FAIL-SAFE restored live GameData after an interrupted automated test.";
    };
};

GameData = [] call TYR_fnc_CreateDefaultGameData;
GameData # 0 # 0 set [0, 4];
GameData # 0 # 0 set [1, [60, 50, 5000, 15000, 15000, 15, 1, 1]];
GameData # 0 # 1 set [0, [1000, 1000, 0]];
GameData # 0 # 2 set [0, [worldSize - 1000, worldSize - 1000, 0]];
GameData # 0 # 1 set [1, 1000000];
GameData # 0 # 2 set [1, 1000000];
GameData # 0 # 1 set [2, 1000000];
GameData # 0 # 2 set [2, 1000000];
GameData # 0 # 1 set [3, 1000000];
GameData # 0 # 2 set [3, 1000000];
GameData # 0 # 1 set [4, 1000];
GameData # 0 # 2 set [4, 1000];

private _defaultShapeOK = count GameData isEqualTo 6 && {count (GameData # 0) >= 4} && {count (GameData # 0 # 1) >= 7} && {count (GameData # 5) isEqualTo 2};
[_defaultShapeOK, "Default GameData v3 shape", "Campaign, locations, destroyed, catalogue, vehicles and emplacements present", "Default state shape is incomplete"] call _check;

private _researchDefs = [] call TYR_fnc_GetResearchDefinitions;
private _researchKeys = _researchDefs apply {_x # 0};
[(count _researchDefs) isEqualTo 17, "Research definition count", "17 research nodes", format ["Found %1 nodes", count _researchDefs]] call _check;
[(count (_researchKeys arrayIntersect _researchKeys)) isEqualTo (count _researchKeys), "Research keys are unique", "", "Duplicate research keys found"] call _check;

private _badPrereqs = [];
{
    private _key = _x # 0;
    {
        if !(_x in _researchKeys) then {_badPrereqs pushBack format ["%1 -> %2", _key, _x]};
    } forEach (_x # 5);
} forEach _researchDefs;
[_badPrereqs isEqualTo [], "Research prerequisites resolve", "All prerequisite keys exist", str _badPrereqs] call _check;

