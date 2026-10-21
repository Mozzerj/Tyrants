params [["_reason", "state"], ["_urgent", false]];
if (!isServer) exitWith {};
if (isNil "TYR_Runtime") exitWith {};
private _revision = (TYR_Runtime getOrDefault ["revision", 0]) + 1;
TYR_Runtime set ["revision", _revision];
TYR_Runtime set ["saveDirty", true];
if ((TYR_Runtime getOrDefault ["dirtySince", -1]) < 0) then {
    TYR_Runtime set ["dirtySince", serverTime];
};
TYR_Runtime set ["lastDirtyAt", serverTime];
if (_urgent) then {TYR_Runtime set ["saveUrgent", true]};
private _reasons = TYR_Runtime getOrDefault ["saveReasons", []];
_reasons pushBackUnique _reason;
TYR_Runtime set ["saveReasons", _reasons];
