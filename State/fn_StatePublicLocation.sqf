params ["_locationId",["_viewerFaction",""]];
private _l = [_locationId] call TYR_fnc_StateGetLocation;
if (count _l isEqualTo 0) exitWith {[]};

private _trueOwner = _l getOrDefault ["owner","neutral"];
private _knownOwner = "unknown";
private _observedAt = [];
private _source = "";
private _current = false;
private _stock = -1;

if (_viewerFaction isNotEqualTo "" && {_trueOwner isEqualTo _viewerFaction}) then {
    _knownOwner = _viewerFaction;
    _source = "control";
    _current = true;
    _stock = _l getOrDefault ["stock",0];
} else {
    private _intel = [_viewerFaction,"locations",_locationId] call TYR_fnc_StateKnowledgeGet;
    if (count _intel > 0) then {
        _knownOwner = _intel getOrDefault ["owner","unknown"];
        _observedAt = +(_intel getOrDefault ["observedAt",[]]);
        _source = _intel getOrDefault ["source",""];
    };
};

[
    _locationId,
    _l getOrDefault ["name", _locationId],
    _l getOrDefault ["kind", "town"],
    +(_l getOrDefault ["position", [0,0,0]]),
    _knownOwner,
    _stock,
    _l getOrDefault ["resource", ""],
    _l getOrDefault ["value", 1],
    _observedAt,
    _source,
    _current
]
