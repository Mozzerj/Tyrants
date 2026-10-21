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
    ["solo", missionNamespace getVariable ["TYR_soloTestMode", false]],
    ["debug", missionNamespace getVariable ["TYR_debugMode", false]],
    ["checks", count _results]
];

[_results, _meta] remoteExecCall ["TYR_fnc_ClientShowTestReport", _ownerId];
diag_log format ["[TYRANTS TEST] Completed %1 checks in %2 seconds.", count _results, _duration];
