params [["_activeOnly", false]];
private _ids = ["west", "east", "independent"];
if (!_activeOnly || {isNil "TYR_State"}) exitWith {_ids};
private _factions = TYR_State getOrDefault ["factions", createHashMap];
_ids select {
    private _f = _factions getOrDefault [_x, createHashMap];
    _f getOrDefault ["active", false]
}
