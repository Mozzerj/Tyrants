if (!isServer) exitWith {false};
if !(missionNamespace getVariable ["TYR_soloTestMode", false]) exitWith {false};

private _humans = allPlayers select {isPlayer _x};
if ((count _humans) isNotEqualTo 1) exitWith {false};

private _human = _humans # 0;
private _humanSideIndex = [west, east] find (side _human);
if (_humanSideIndex < 0) exitWith {false};

private _enemySideIndex = 1 - _humanSideIndex;
private _humanBase = GameData # 0 # (_humanSideIndex + 1) # 0;
private _enemyBase = GameData # 0 # (_enemySideIndex + 1) # 0;
if (_humanBase isEqualTo 0 || {_enemyBase isNotEqualTo 0}) exitWith {false};

private _divider = [] call TYR_fnc_GetDividerLine;
private _slope = _divider # 0;
private _intercept = _divider # 1;

private _isEnemyTerritory = {
    params ["_pos"];
    private _x = _pos # 0;
    private _y = _pos # 1;
    private _lineY = (_slope * _x) + _intercept;
    (_enemySideIndex isEqualTo 0 && {_y < _lineY}) ||
    (_enemySideIndex isEqualTo 1 && {_y > _lineY})
};

private _candidates = [];
{
    {
        if (_x isEqualType [] && {count _x > 4}) then {
            private _pos = +(_x # 4);
            if (!surfaceIsWater [_pos # 0, _pos # 1] && {[_pos] call _isEnemyTerritory}) then {
                _candidates pushBack _pos;
            };
        };
    } forEach _x;
} forEach (GameData # 1);

// If Altis location discovery gives us no usable point, fall back to a coarse land grid.
if (count _candidates isEqualTo 0) then {
    for "_gridX" from 1 to 9 do {
        for "_gridY" from 1 to 9 do {
            private _pos = [worldSize * (_gridX / 10), worldSize * (_gridY / 10), 0];
            if (!surfaceIsWater [_pos # 0, _pos # 1] && {[_pos] call _isEnemyTerritory}) then {
                _candidates pushBack _pos;
            };
        };
    };
};

if (count _candidates isEqualTo 0) exitWith {
    diag_log "[TYRANTS] Solo Test Mode could not find a valid opposing base position.";
    false
};

private _bestPos = _candidates # 0;
private _bestDistance = _humanBase distance2D _bestPos;
{
    private _distance = _humanBase distance2D _x;
    if (_distance > _bestDistance) then {
        _bestDistance = _distance;
        _bestPos = _x;
    };
} forEach _candidates;

_bestPos set [2, 0];
GameData # 0 # (_enemySideIndex + 1) set [0, +_bestPos];
[] call TYR_fnc_ServerBroadcastState;
[] call TYR_fnc_ServerSaveState;

[format ["Solo Test Mode: %1 base auto-placed for testing.", ["WEST", "EAST"] # _enemySideIndex]] remoteExecCall ["TYR_fnc_ClientHint", owner _human];
diag_log format ["[TYRANTS] Solo Test Mode auto-placed side %1 base at %2", _enemySideIndex, _bestPos];
true
