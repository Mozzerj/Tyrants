if (!isServer) exitWith {};
private _owner = remoteExecutedOwner;
private _player = [_owner] call TYR_fnc_FindPlayerByOwner;
if (isNull _player) exitWith {};
private _fid = [side _player] call TYR_fnc_SideFaction;
private _locations = TYR_State get "locations";
private _bestId = "";
private _bestDist = 1e9;
{
    private _l = _locations get _x;
    if ((_l getOrDefault ["kind",""]) isEqualTo "factory" && {(_l getOrDefault ["owner","neutral"]) isEqualTo _fid}) then {
        private _d = _player distance2D (_l get "position");
        if (_d < _bestDist) then {_bestDist = _d;_bestId = _x};
    };
} forEach keys _locations;
if (_bestId isEqualTo "" || {_bestDist > 80}) exitWith {
    [_player,"TYR_fnc_ClientHint",["No friendly factory within 80m."]] call TYR_fnc_ServerSendToPlayer;
};
private _l = _locations get _bestId;
private _stock = floor (_l getOrDefault ["stock",0]);
if (_stock <= 0) exitWith {[_player,"TYR_fnc_ClientHint",["Factory stockpile is empty."]] call TYR_fnc_ServerSendToPlayer};
private _resource = _l getOrDefault ["resource","steel"];
_l set ["stock",0];
[_fid,_resource,_stock,"factory-collect"] call TYR_fnc_StateChangeResource;
[_bestId,_fid] call TYR_fnc_ServerPublishLocation;
[_player,"TYR_fnc_ClientHint",[format ["Collected %1 %2.",_stock,toUpper _resource]]] call TYR_fnc_ServerSendToPlayer;
