params ["_locationId",["_viewerFaction",""]];
private _l = [_locationId] call TYR_fnc_StateGetLocation;
if (count _l isEqualTo 0) exitWith {[]};

private _trueOwner = _l getOrDefault ["owner","neutral"];
private _knownOwner = "unknown";
private _observedAt = [];
private _source = "";
private _current = false;
private _stock = -1;
private _factoryType = "";
private _inventoryOut = [];
private _queueOut = [];
private _factoryOperational = false;

if (_viewerFaction isNotEqualTo "" && {_trueOwner isEqualTo _viewerFaction}) then {
    _knownOwner = _viewerFaction;
    _source = "control";
    _current = true;
    _stock = _l getOrDefault ["stock",0];
    if ((_l getOrDefault ["kind",""]) isEqualTo "factory") then {
        _factoryType = _l getOrDefault ["factoryType","munitions"];
        _factoryOperational = _l getOrDefault ["productionOperational",true];
        private _inv = _l getOrDefault ["inventory",createHashMap];
        private _keys = keys _inv; _keys sort true;
        {_inventoryOut pushBack [_x,_inv getOrDefault [_x,0]]} forEach _keys;
        {
            _queueOut pushBack [
                _x getOrDefault ["id",""],_x getOrDefault ["product",""],_x getOrDefault ["display",""],
                _x getOrDefault ["amount",0],((_x getOrDefault ["finishAt",serverTime]) - serverTime) max 0,
                _x getOrDefault ["reason",""]
            ];
        } forEach (_l getOrDefault ["productionQueue",[]]);
    };
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
    _current,
    _factoryType,
    _inventoryOut,
    _queueOut,
    _factoryOperational
]
