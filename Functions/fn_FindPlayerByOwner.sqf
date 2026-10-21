params ["_ownerId"];
private _player = objNull;
{
    if (owner _x isEqualTo _ownerId) exitWith {
        _player = _x;
    };
} forEach allPlayers;
_player
