if (!isServer) exitWith {};
if (!(missionNamespace getVariable ["TYR_debugMode", false])) exitWith {};

params [
    ["_action", "", [""]],
    ["_args", [], [[]]]
];

private _requester = [remoteExecutedOwner] call TYR_fnc_FindPlayerByOwner;
if (isNull _requester) exitWith {};

private _requesterSide = switch (side group _requester) do {
    case west: {0};
    case east: {1};
    default {-1};
};
if (_requesterSide < 0) exitWith {};

private _result = [_requesterSide, _action, _args] call TYR_fnc_ServerApplyDebugAction;
private _changed = _result param [0, false];
private _message = _result param [1, "Debug action completed."];

if (_changed) then {
    [] call TYR_fnc_ServerBroadcastState;
    [] call TYR_fnc_ServerSaveState;
};

[_message] remoteExecCall ["TYR_fnc_ClientHint", owner _requester];
