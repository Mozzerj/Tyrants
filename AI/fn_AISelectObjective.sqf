params ["_factionId"];
private _f = [_factionId] call TYR_fnc_StateGetFaction;
private _locations = TYR_State get "locations";

// Prefer frontier objectives. This is intentionally derived from strategic state only;
// it does not scan all units for every candidate, keeping commander thinking predictable.
private _owned = [];
{
    private _l = _locations get _x;
    if ((_l getOrDefault ["owner","neutral"]) isEqualTo _factionId) then {_owned pushBack (_l get "position")};
} forEach keys _locations;
private _base = _f getOrDefault ["basePosition",[worldSize*0.5,worldSize*0.5,0]];
if (count _owned isEqualTo 0) then {_owned pushBack _base};

private _best = "";
private _scoreBest = -1e9;
{
    private _l = _locations get _x;
    private _owner = _l getOrDefault ["owner","neutral"];
    if (_owner isNotEqualTo _factionId) then {
        private _pos = _l get "position";
        private _nearestOwn = 1e12;
        {_nearestOwn = _nearestOwn min (_x distance2D _pos)} forEach _owned;
        private _frontBonus = if (_nearestOwn < 3500) then {35} else {0};
        private _neutralBonus = if (_owner isEqualTo "neutral") then {10} else {0};
        private _value = _l getOrDefault ["value",1];
        private _score = (_value * 24) + _frontBonus + _neutralBonus - (_nearestOwn / 450) + random 10;
        if (_score > _scoreBest) then {_scoreBest = _score;_best = _x};
    };
} forEach keys _locations;
_best
