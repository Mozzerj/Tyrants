if (!isServer) exitWith {};
private _campaign = call TYR_fnc_StatePublicCampaign;
{
    private _player = _x;
    private _viewer = [side _player] call TYR_fnc_SideFaction;
    private _factions = [];
    {_factions pushBack ([_x,_viewer] call TYR_fnc_StatePublicFaction)} forEach ([false] call TYR_fnc_FactionIds);
    [_player,"TYR_fnc_ClientReceiveDeployment",[_campaign,_factions]] call TYR_fnc_ServerSendToPlayer;
} forEach allPlayers;
