if (!isServer || {isNil "TYR_State"}) exitWith {};
private _owner = remoteExecutedOwner;
private _player = [_owner] call TYR_fnc_FindPlayerByOwner;
if (isNull _player) exitWith {
    diag_log format ["[TYRANTS NET] State request had no matching player for owner %1.",_owner];
};
private _viewer = [side _player] call TYR_fnc_SideFaction;
private _factionsOut = [];
{_factionsOut pushBack ([_x,_viewer] call TYR_fnc_StatePublicFaction)} forEach ([false] call TYR_fnc_FactionIds);
private _locationsOut = [];
private _locations = TYR_State getOrDefault ["locations",createHashMap];
private _ks = keys _locations;
_ks sort true;
{_locationsOut pushBack ([_x,_viewer] call TYR_fnc_StatePublicLocation)} forEach _ks;
private _knowledgeOut = [_viewer,_viewer] call TYR_fnc_StatePublicKnowledge;
[_player,"TYR_fnc_ClientReceiveSnapshot",[[["campaign",call TYR_fnc_StatePublicCampaign],["factions",_factionsOut],["locations",_locationsOut],["knowledge",_knowledgeOut]]]] call TYR_fnc_ServerSendToPlayer;
