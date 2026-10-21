if (!isServer) exitWith {false};
private _a = missionProfileNamespace getVariable ["TYRANTS_V4_A",[]];
private _b = missionProfileNamespace getVariable ["TYRANTS_V4_B",[]];
private _validA = [_a] call TYR_fnc_PersistenceValidateRecord;
private _validB = [_b] call TYR_fnc_PersistenceValidateRecord;
private _chosen = [];
if (_validA && _validB) then {
    _chosen = if ((_a # 2) >= (_b # 2)) then {_a} else {_b};
} else {
    if (_validA) then {_chosen = _a};
    if (_validB) then {_chosen = _b};
};
if (count _chosen isEqualTo 0) exitWith {
    TYR_State = call TYR_fnc_StateCreateCampaign;
    TYR_Runtime set ["saveGeneration",0];
    TYR_Runtime set ["newCampaign",true];
    diag_log "[TYRANTS V4] No valid checkpoint. New campaign created.";
    false
};
TYR_Runtime set ["saveGeneration",_chosen # 2];
TYR_Runtime set ["newCampaign",false];
private _ok = [_chosen # 6] call TYR_fnc_PersistenceApplySnapshot;
if (_ok) then {
    diag_log format ["[TYRANTS V4] Loaded checkpoint generation %1 from the new save system.",_chosen # 2];
} else {
    diag_log format ["[TYRANTS V4] Checkpoint generation %1 validated but could not be applied.",_chosen # 2];
};
_ok
