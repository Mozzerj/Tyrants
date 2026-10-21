params [["_destroyedFaction",""],["_reason",""]];
if (!isServer || {_destroyedFaction isEqualTo ""}) exitWith {false};
if (_reason isNotEqualTo "command-collapse") exitWith {
    diag_log format ["[TYRANTS VICTORY] Ignored legacy/non-command elimination request for %1 (%2).",_destroyedFaction,_reason];
    false
};
private _f = [_destroyedFaction] call TYR_fnc_StateGetFaction;
if (count _f isEqualTo 0 || {_f getOrDefault ["eliminated",false]}) exitWith {false};
private _network = _f getOrDefault ["commandNetwork",createHashMap];
if ((_network getOrDefault ["status",""]) isNotEqualTo "collapsed") exitWith {false};

_f set ["eliminated",true];
_f set ["active",false];
_network set ["status","eliminated"];
["faction-command-eliminated",true] call TYR_fnc_StateMarkDirty;
[_destroyedFaction] call TYR_fnc_ServerPublishFaction;
diag_log format ["[TYRANTS VICTORY] %1 eliminated after sustained command collapse.",toUpper _destroyedFaction];

private _alive = ([false] call TYR_fnc_FactionIds) select {
    private _xF = [_x] call TYR_fnc_StateGetFaction;
    (_xF getOrDefault ["active",false]) && {!(_xF getOrDefault ["eliminated",false])}
};
if (count _alive isEqualTo 1) then {
    private _winner = _alive # 0;
    [_winner] remoteExec ["TYR_fnc_ClientEndMission",0];
};
true
