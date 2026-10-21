params ["_factionId",["_target",0]];
if (!isServer) exitWith {};
private _recipients = if (_target isEqualType objNull) then {[_target]} else {
    if (_target isEqualType 0 && {_target > 0}) then {
        allPlayers select {owner _x isEqualTo _target && {([side _x] call TYR_fnc_SideFaction) isEqualTo _factionId}}
    } else {
        allPlayers select {([side _x] call TYR_fnc_SideFaction) isEqualTo _factionId}
    }
};
private _payload = [_factionId,_factionId] call TYR_fnc_StatePublicKnowledge;
if (count _payload isEqualTo 0) exitWith {};
{[_x,"TYR_fnc_ClientReceiveKnowledge",[_payload]] call TYR_fnc_ServerSendToPlayer} forEach _recipients;
