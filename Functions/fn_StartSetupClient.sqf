if (isRemoteExecuted && {remoteExecutedOwner isNotEqualTo 2}) exitWith {};
params ["_stage"];
if (!hasInterface) exitWith {};

switch (_stage) do {
    case 0: {
        [] execVM "Setup\GameSetupStage0\DialogSetup.sqf";
    };
    case 1: {
        [] execVM "Setup\GameSetupStage1\VehicleSetup.sqf";
    };
    default {
        diag_log format ["[TYRANTS] Ignored unsupported client setup stage %1", _stage];
    };
};
