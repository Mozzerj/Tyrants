params ["_factionId",["_viewerFaction",""]];
if (_factionId isEqualTo "" || {_viewerFaction isNotEqualTo _factionId}) exitWith {[]};
private _f = [_factionId] call TYR_fnc_StateGetFaction;
if (count _f isEqualTo 0) exitWith {[]};
private _knowledge = _f getOrDefault ["knowledge",createHashMap];
private _contacts = _knowledge getOrDefault ["contacts",createHashMap];
private _ids = keys _contacts;
_ids sort true;
private _out = [];
{
    private _c = _contacts get _x;
    _out pushBack [
        _x,
        _c getOrDefault ["targetFaction",""],
        _c getOrDefault ["kind","unknown"],
        _c getOrDefault ["label","CONTACT"],
        _c getOrDefault ["exact",false],
        +(_c getOrDefault ["position",[]]),
        _c getOrDefault ["direction",0],
        +(_c getOrDefault ["observedAt",[]]),
        _c getOrDefault ["source",""],
        _c getOrDefault ["seenServerTime",0]
    ];
} forEach _ids;
private _log = +(_knowledge getOrDefault ["log",[]]);
[_factionId,serverTime,_out,_log]
