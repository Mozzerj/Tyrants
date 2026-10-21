if !(missionNamespace getVariable ["TYR_debugMode",false]) exitWith {
    hint "Developer Debug Mode is disabled.";
};

// Splendid Camera is intentionally a developer-only observation tool. Suppress
// normal intelligence reporting while display 314 (RscDisplayCamera) is open so
// flying the debug camera cannot contaminate faction knowledge.
missionNamespace setVariable ["TYR_DebugCameraActive",true];
closeDialog 0;

[] spawn {
    private _openedBy = diag_tickTime;
    [] call BIS_fnc_camera;

    // BIS_fnc_camera behaviour differs slightly depending on where it was
    // launched. Handle both blocking and immediate-return cases by watching the
    // engine camera display as well.
    waitUntil {
        uiSleep 0.05;
        !isNull findDisplay 314 || {(diag_tickTime - _openedBy) > 2}
    };
    if (!isNull findDisplay 314) then {
        waitUntil {uiSleep 0.15; isNull findDisplay 314};
    };

    missionNamespace setVariable ["TYR_DebugCameraActive",false];
    showChat true;
};
