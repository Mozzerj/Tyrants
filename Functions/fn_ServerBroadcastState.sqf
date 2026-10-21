if (!isServer) exitWith {};
if (missionNamespace getVariable ["TYR_testInProgress", false]) exitWith {
    missionNamespace setVariable ["TYR_testBroadcastCount", (missionNamespace getVariable ["TYR_testBroadcastCount", 0]) + 1];
};
publicVariable "GameData";
