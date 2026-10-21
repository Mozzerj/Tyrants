if (!hasInterface) exitWith {};
if (!isRemoteExecuted || {remoteExecutedOwner isNotEqualTo 2}) exitWith {};
params [["_ending", "END1", [""]]];
endMission _ending;
