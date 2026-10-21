params ["_locationId",["_target",0]];
if (!isServer) exitWith {};
private _recipients = if (_target isEqualType "") then {
    allPlayers select {([side _x] call TYR_fnc_SideFaction) isEqualTo _target}
} else {
    if (_target isEqualType objNull) then {[_target]} else {
        if (_target isEqualType 0 && {_target > 0}) then {allPlayers select {owner _x isEqualTo _target}} else {+allPlayers}
    }
};
{
    private _viewer = [side _x] call TYR_fnc_SideFaction;
    private _payload = [_locationId,_viewer] call TYR_fnc_StatePublicLocation;
    if (count _payload > 0) then {[_x,"TYR_fnc_ClientReceiveLocation",[_payload]] call TYR_fnc_ServerSendToPlayer};
} forEach _recipients;
