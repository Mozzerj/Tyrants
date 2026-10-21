params [["_destroyedFaction",""]];
if (!isServer || {_destroyedFaction isEqualTo ""}) exitWith {};
private _f = [_destroyedFaction] call TYR_fnc_StateGetFaction;
if (count _f isEqualTo 0) exitWith {};
_f set ["eliminated",true];
_f set ["active",false];
["faction-eliminated",true] call TYR_fnc_StateMarkDirty;
[_destroyedFaction] call TYR_fnc_ServerPublishFaction;

private _alive = ([false] call TYR_fnc_FactionIds) select {
    private _xF = [_x] call TYR_fnc_StateGetFaction;
    (_xF getOrDefault ["active",false]) && {!(_xF getOrDefault ["eliminated",false])}
};
if (count _alive isEqualTo 1) then {
    private _winner = _alive # 0;
    [_winner] remoteExec ["TYR_fnc_ClientEndMission",0];
};
