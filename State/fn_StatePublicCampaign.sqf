if (isNil "TYR_State") exitWith {[]};
private _campaign = TYR_State get "campaign";
private _deployment = _campaign getOrDefault ["deployment",createHashMap];
private _sectorsMap = _deployment getOrDefault ["sectors",createHashMap];
private _sectorIds = keys _sectorsMap;
_sectorIds sort true;
private _sectors = [];
{_sectors pushBack [_x,+(_sectorsMap get _x)]} forEach _sectorIds;
[
    _campaign getOrDefault ["phase","deployment"],
    [
        _deployment getOrDefault ["rotation",0],
        _deployment getOrDefault ["buffer",2500],
        _sectors
    ]
]
