/*
    Safe one-click automated test suite.

    The suite is deliberately non-destructive:
    - requires Solo Test Mode and exactly one human player;
    - snapshots the live GameData reference;
    - swaps in an isolated test GameData instance;
    - suppresses campaign saves/broadcasts while the sandbox is active;
    - restores the live GameData before sending the report.

    Engine/physics-heavy behaviour (for example an actual cruise-missile flight)
    is not launched here. Instead, all required classes/config and launch-state
    prerequisites are validated.
*/
if (!isServer) exitWith {};

private _ownerId = remoteExecutedOwner;
private _caller = [_ownerId] call TYR_fnc_FindPlayerByOwner;
if (isNull _caller) exitWith {};

if !(missionNamespace getVariable ["TYR_soloTestMode", false]) exitWith {
    ["Automated tests require Solo Test Mode to be enabled in mission parameters."] remoteExecCall ["TYR_fnc_ClientHint", _ownerId];
};

private _humans = allPlayers select {isPlayer _x};
if ((count _humans) isNotEqualTo 1) exitWith {
    ["Automated tests are restricted to a one-player Solo Test session so they cannot interfere with a live match."] remoteExecCall ["TYR_fnc_ClientHint", _ownerId];
};

if (missionNamespace getVariable ["TYR_testInProgress", false]) exitWith {
    ["A Tyrants automated test run is already in progress."] remoteExecCall ["TYR_fnc_ClientHint", _ownerId];
};

private _startedAt = diag_tickTime;
private _results = [];
private _record = {
    params ["_name", "_status", ["_detail", ""]];
    _results pushBack [_name, _status, _detail];
    diag_log format ["[TYRANTS TEST] %1 | %2 | %3", _status, _name, _detail];
};

private _pass = {
    params ["_name", ["_detail", ""]];
    [_name, "PASS", _detail] call _record;
};
private _fail = {
    params ["_name", ["_detail", ""]];
    [_name, "FAIL", _detail] call _record;
};
private _warn = {
    params ["_name", ["_detail", ""]];
    [_name, "WARN", _detail] call _record;
};
private _check = {
    params ["_condition", "_name", ["_passDetail", ""], ["_failDetail", ""]];
    if (_condition) then {
        [_name, _passDetail] call _pass;
    } else {
        [_name, _failDetail] call _fail;
    };
    _condition
};

private _realGameData = GameData;
private _liveStage = GameData # 0 # 0 # 0;
private _sideIndex = [west, east] find (side _caller);

// ----- Live-session checks (read-only) -----
[missionNamespace getVariable ["TYR_soloTestMode", false], "Solo Test Mode enabled"] call _check;
[(count _humans) isEqualTo 1, "Exactly one human player", format ["Player: %1", name _caller], format ["Humans detected: %1", count _humans]] call _check;
[_sideIndex in [0, 1], "Player is on WEST/EAST", str (side _caller), "Player side is unsupported"] call _check;
[_liveStage isEqualTo 4, "Campaign reached gameplay stage", format ["Stage %1", _liveStage], format ["Expected stage 4, got %1", _liveStage]] call _check;

private _locationDataOK = (GameData # 1) isEqualType [] && {count (GameData # 1) >= 3};
[_locationDataOK, "Location data built", if (_locationDataOK) then {format ["Towns %1, cities %2, factories %3", count (GameData # 1 # 0), count (GameData # 1 # 1), count (GameData # 1 # 2)]} else {""}, "Location arrays are missing"] call _check;

if (_locationDataOK) then {
    private _badRegions = 0;
    {
        {
            if !(_x isEqualType [] && {count _x >= 5} && {(_x # 4) isEqualType []} && {count (_x # 4) >= 2}) then {
                _badRegions = _badRegions + 1;
            } else {
                private _p = _x # 4;
                if ((_p # 0) < 0 || {(_p # 0) > worldSize} || {(_p # 1) < 0} || {(_p # 1) > worldSize}) then {
                    _badRegions = _badRegions + 1;
                };
            };
        } forEach _x;
    } forEach (GameData # 1);
    [_badRegions isEqualTo 0, "Location records are structurally valid", "All region positions are in world bounds", format ["Invalid records: %1", _badRegions]] call _check;
};

if (_liveStage >= 4) then {
    private _westBase = GameData # 0 # 1 # 0;
    private _eastBase = GameData # 0 # 2 # 0;
    private _basesPresent = _westBase isEqualType [] && {_eastBase isEqualType []} && {count _westBase >= 2} && {count _eastBase >= 2};
    [_basesPresent, "Both faction bases exist", if (_basesPresent) then {format ["WEST %1 | EAST %2", _westBase, _eastBase]} else {""}, "One or both base positions are missing"] call _check;

    if (_basesPresent) then {
        private _landOK = !surfaceIsWater [_westBase # 0, _westBase # 1] && {!surfaceIsWater [_eastBase # 0, _eastBase # 1]};
        [_landOK, "Both bases are on land", "", "At least one base is in water"] call _check;
        [(_westBase distance2D _eastBase) > 500, "Bases are separated", format ["Distance: %1 m", round (_westBase distance2D _eastBase)], "Bases are within 500 m"] call _check;
    };

    private _baseObjectsOK = !isNil "WestBox" && {!isNil "EastBox"} && {!isNil "WestAccountant"} && {!isNil "EastAccountant"};
