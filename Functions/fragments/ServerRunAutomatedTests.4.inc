        [[3000 + (_i * 10), 3000 + (_i * 10), 0]] call TYR_fnc_ServerAddVLSTarget;
    };
    [(count (GameData # 0 # _teamIndex # 6)) isEqualTo 18, "VLS target storage cap", "Exactly 18 targets retained after 19 requests", format ["Stored %1 targets", count (GameData # 0 # _teamIndex # 6)]] call _check;
};

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

private _suppressedBroadcasts = missionNamespace getVariable ["TYR_testBroadcastCount", 0];
private _suppressedSaves = missionNamespace getVariable ["TYR_testSaveCount", 0];
[(_suppressedBroadcasts > 0) && {_suppressedSaves > 0}, "Test sandbox intercepted production side effects", format ["Broadcasts suppressed: %1, saves suppressed: %2", _suppressedBroadcasts, _suppressedSaves], "Production paths did not hit the save/broadcast interceptors"] call _check;

// Restore the real live campaign before reporting anything back to the client.
GameData = _realGameData;
missionNamespace setVariable ["TYR_testInProgress", false];
missionNamespace setVariable ["TYR_testBackupGameData", nil];
publicVariable "TYR_testInProgress";
[] call TYR_fnc_ServerBroadcastState;

private _duration = diag_tickTime - _startedAt;
private _meta = [
    ["serverTime", serverTime],
    ["duration", _duration],
    ["stage", _liveStage],
    ["side", str (side _caller)],
    ["solo", missionNamespace getVariable ["TYR_soloTestMode", false]]
];

[_results, _meta] remoteExecCall ["TYR_fnc_ClientShowTestReport", _ownerId];
diag_log format ["[TYRANTS TEST] Completed %1 checks in %2 seconds.", count _results, _duration];
