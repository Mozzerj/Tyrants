params ["_snapshot"];
private _factions = createHashMap;
private _locations = createHashMap;
private _campaign = [];
private _knowledge = [];
{
    if (_x isEqualType [] && {count _x >= 2}) then {
        switch (_x # 0) do {
            case "campaign": {_campaign = +(_x # 1)};
            case "factions": {{if (_x isEqualType [] && {count _x > 0}) then {_factions set [_x # 0,_x]}} forEach (_x # 1)};
            case "locations": {{if (_x isEqualType [] && {count _x > 0}) then {_locations set [_x # 0,_x]}} forEach (_x # 1)};
            case "knowledge": {_knowledge = +(_x # 1)};
        };
    };
} forEach _snapshot;
TYR_ClientState = createHashMapFromArray [["campaign",_campaign],["factions",_factions],["locations",_locations],["knowledge",_knowledge]];
missionNamespace setVariable ["TYR_ClientKnowledgeReceivedAt",diag_tickTime];
missionNamespace setVariable ["TYR_ClientStateReady",true];
if (!isNull findDisplay 1200) then {[] call TYR_fnc_PlayerMenuRefresh};
if (!isNull findDisplay 1300) then {[] call TYR_fnc_DeploymentOverlayBuild; [] call TYR_fnc_DeploymentMenuRefresh};
