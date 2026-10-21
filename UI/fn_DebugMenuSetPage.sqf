params ["_page"];
disableSerialization;
private _d = findDisplay 1700;
if (isNull _d) exitWith {};
private _valid = ["movement","ai","command","economy","system"];
if !(_page in _valid) then {_page = "movement"};
missionNamespace setVariable ["TYR_debugPage",_page];

private _pages = createHashMapFromArray [
    ["movement",[281,282,283,284,285,286]],
    ["ai",[261,262,263,264]],
    ["command",[271,272,273,274,275,276,277]],
    ["economy",[221,222,223,224,225,226,227,241,242,228,229,230,231,232]],
    ["system",[131,301,302,303,304]]
];
private _all = [];
{_all append (_pages get _x)} forEach _valid;
{(_d displayCtrl _x) ctrlShow false} forEach _all;
{(_d displayCtrl _x) ctrlShow true} forEach (_pages get _page);

private _meta = switch (_page) do {
    case "ai": {["AI COMMAND","Run the strategic thinker, inspect its live path, or focus the map on issued orders."]};
    case "command": {["COMMAND NETWORK","Inspect and stress-test physical commander/officer routing and recovery."]};
    case "economy": {["PRODUCTION + LOGISTICS","Inspect depot stock, trigger production/logistics planning, and adjust legacy resources for testing."]};
    case "system": {["SYSTEM","Low-frequency state, save, performance and automated-test tools."]};
    default {["MOVEMENT","Fast navigation tools. Map teleport and camera are debug-only and do not create intelligence."]};
};
(_d displayCtrl 430) ctrlSetText (_meta # 0);
(_d displayCtrl 431) ctrlSetText (_meta # 1);

private _nav = [[401,"movement"],[402,"ai"],[403,"command"],[404,"economy"],[405,"system"]];
{
    (_d displayCtrl (_x # 0)) ctrlSetTextColor (if ((_x # 1) isEqualTo _page) then {[0.95,0.72,0.20,1]} else {[0.82,0.84,0.86,1]});
} forEach _nav;
[] call TYR_fnc_DebugMenuUpdateStatus;
