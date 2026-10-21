if (!isServer) exitWith {false};
missionProfileNamespace setVariable ["TYRANTS_V4_A",nil];
missionProfileNamespace setVariable ["TYRANTS_V4_B",nil];
saveMissionProfileNamespace;
diag_log "[TYRANTS V4] Persistent campaign checkpoints cleared.";
true
