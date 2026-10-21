params [["_force",false]];
if (!isServer || {isNil "TYR_State"} || {isNil "TYR_Runtime"}) exitWith {false};
if (!_force && {!(TYR_Runtime getOrDefault ["saveDirty",false])}) exitWith {true};

private _revision = TYR_Runtime getOrDefault ["revision",0];
private _snapshot = call TYR_fnc_PersistenceBuildSnapshot;
if (_revision isNotEqualTo (TYR_Runtime getOrDefault ["revision",0])) exitWith {
    diag_log "[TYRANTS V4 SAVE] State changed during snapshot construction; deferred.";
    false
};

private _generation = (TYR_Runtime getOrDefault ["saveGeneration",0]) + 1;
private _record = ["TYRANTS_V4",2,_generation,worldName,systemTime,serverTime,_snapshot,hashValue (str _snapshot)];
if !([_record] call TYR_fnc_PersistenceValidateRecord) exitWith {
    diag_log "[TYRANTS V4 SAVE] Snapshot failed validation. Existing checkpoint was not overwritten.";
    false
};

private _slot = if ((_generation mod 2) isEqualTo 1) then {"TYRANTS_V4_A"} else {"TYRANTS_V4_B"};
missionProfileNamespace setVariable [_slot,_record];
private _ok = saveMissionProfileNamespace;
if (!_ok) exitWith {
    diag_log format ["[TYRANTS V4 SAVE] missionProfileNamespace write failed for %1.",_slot];
    false
};

TYR_Runtime set ["saveGeneration",_generation];
TYR_Runtime set ["saveDirty",false];
TYR_Runtime set ["saveUrgent",false];
TYR_Runtime set ["dirtySince",-1];
TYR_Runtime set ["lastSaveAt",serverTime];
private _reasons = +(TYR_Runtime getOrDefault ["saveReasons",[]]);
TYR_Runtime set ["saveReasons",[]];
diag_log format ["[TYRANTS V4 SAVE] generation=%1 slot=%2 reasons=%3",_generation,_slot,_reasons];
true
