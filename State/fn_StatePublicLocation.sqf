params ["_locationId"];
private _l = [_locationId] call TYR_fnc_StateGetLocation;
if (count _l isEqualTo 0) exitWith {[]};
[
    _locationId,
    _l getOrDefault ["name", _locationId],
    _l getOrDefault ["kind", "town"],
    +(_l getOrDefault ["position", [0,0,0]]),
    _l getOrDefault ["owner", "neutral"],
    _l getOrDefault ["stock", 0],
    _l getOrDefault ["resource", ""],
    _l getOrDefault ["value", 1]
]
