private _view = missionNamespace getVariable ["TYR_debugView","map"];
switch (_view) do {
    case "flow": {[] call TYR_fnc_DebugFlowRefresh};
    case "tasks": {[] call TYR_fnc_DebugTasksRefresh};
    case "log": {[] call TYR_fnc_DebugIntelLogRefresh};
    case "commands": {[] call TYR_fnc_DebugCommandRefresh};
};
