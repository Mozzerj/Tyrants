disableSerialization;
params [["_controlId",-1]];
private _map = createHashMapFromArray [
    [1000,"intel.basic"],[1100,"intel.comms"],[1200,"intel.trackers"],[1110,"intel.listening"],[1300,"intel.satellite"],
    [2000,"infra.basic"],[2100,"infra.strategic"],[2200,"infra.factory"],[2110,"infra.cbr"],[2120,"infra.roadblock"],[2300,"infra.offensive"],
    [3000,"proc.armored"],[3001,"proc.heavy"],[3002,"proc.rotary"],[3003,"proc.artillery"],[3004,"proc.fixed"],[3005,"proc.autonomous"]
];
if (_controlId isEqualTo 5) exitWith {
    private _key = missionNamespace getVariable ["TYR_researchSelected",""];
    if (_key isNotEqualTo "") then {[_key] remoteExecCall ["TYR_fnc_ServerPurchaseResearch",2]};
};
if (_controlId in keys _map) then {missionNamespace setVariable ["TYR_researchSelected",_map get _controlId]};

private _d = findDisplay 1205;
if (isNull _d || {isNil "TYR_ClientState"}) exitWith {};
private _f = (TYR_ClientState get "factions") getOrDefault [TYR_PlayerFaction,[]];
if (count _f < 7) exitWith {};
private _unlocked = _f # 6;
{
    private _key = _map get _x;
    private _ctrl = _d displayCtrl _x;
    if (!isNull _ctrl) then {
        if (_key in _unlocked) then {
            _ctrl ctrlSetTextColor [0.35,0.9,0.45,1];
        } else {
            _ctrl ctrlSetTextColor [0.9,0.92,0.94,1];
        };
    };
} forEach keys _map;

private _res = _f # 5;
(_d displayCtrl 2) ctrlSetText format ["Steel: %1",round (_res # 0)];
private _brief = _d displayCtrl 1;
lbClear _brief;
private _selected = missionNamespace getVariable ["TYR_researchSelected",""];
private _defs = call TYR_fnc_GetResearchDefinitions;
private _i = _defs findIf {(_x # 0) isEqualTo _selected};
if (_i >= 0) then {
    private _def = _defs # _i;
    _brief lbAdd (_def # 1);
    _brief lbAdd format ["Cost: %1 steel",_def # 3];
    _brief lbAdd format ["Branch: %1",toUpper (_def # 2)];
    _brief lbAdd format ["Requires: %1",if (count (_def # 4) isEqualTo 0) then {"None"} else {(_def # 4) joinString ", "}];
    _brief lbAdd format ["Status: %1",if (_selected in _unlocked) then {"UNLOCKED"} else {"LOCKED"}];
} else {
    _brief lbAdd "Select a research project.";
};
