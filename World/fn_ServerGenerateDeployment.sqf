if (!isServer) exitWith {false};
private _campaign = TYR_State get "campaign";
private _deployment = _campaign getOrDefault ["deployment",createHashMap];
private _active = [true] call TYR_fnc_FactionIds;
private _count = count _active;
if (_count < 1) exitWith {diag_log "[TYRANTS DEPLOYMENT] No active factions.";false};
private _existing = _deployment getOrDefault ["sectors",createHashMap];
private _existingValid = (count keys _existing) isEqualTo _count;
if (_existingValid) then {
    {
        private _sector = _existing getOrDefault [_x,[]];
        if !(_sector isEqualType [] && {count _sector >= 2} && {(_sector # 0) isEqualType 0} && {(_sector # 1) isEqualType 0}) exitWith {_existingValid = false};
    } forEach _active;
};
if (_existingValid) exitWith {true};

private _half = if (_count <= 1) then {180} else {180 / _count};
private _centre = [worldSize * 0.5,worldSize * 0.5,0];
private _locations = values (TYR_State get "locations");

// Coarse one-off land samples make the split respect the shape of Altis as well as strategic sites.
private _landSamples = [];
private _step = worldSize / 16;
for "_gx" from (_step * 0.5) to (worldSize - _step * 0.5) step _step do {
    for "_gy" from (_step * 0.5) to (worldSize - _step * 0.5) step _step do {
        private _p = [_gx,_gy,0];
        if !(surfaceIsWater _p) then {_landSamples pushBack _p};
    };
};

private _bearing = {
    params ["_p"];
    (((( (_p # 0) - (_centre # 0)) atan2 ((_p # 1) - (_centre # 1))) + 360) mod 360)
};
private _indexFor = {
    params ["_angle","_rotation"];
    private _best = 0;
    private _bestAbs = 999;
    for "_i" from 0 to (_count - 1) do {
        private _c = (_rotation + (_i * (360 / _count))) mod 360;
        private _d = abs (((_angle - _c + 540) mod 360) - 180);
        if (_d < _bestAbs) then {_bestAbs=_d;_best=_i};
    };
    _best
};

private _scored = [];
private _rotationStep = if (_count isEqualTo 2) then {10} else {10};
for "_rotation" from 0 to 350 step _rotationStep do {
    private _weights = [];
    for "_i" from 0 to (_count - 1) do {_weights pushBack 0};
    {
        private _idx = [[_x] call _bearing,_rotation] call _indexFor;
        _weights set [_idx,(_weights # _idx) + 0.25];
    } forEach _landSamples;
    {
        private _pos = _x getOrDefault ["position",[0,0,0]];
        private _idx = [[_pos] call _bearing,_rotation] call _indexFor;
        private _value = _x getOrDefault ["value",1];
        if ((_x getOrDefault ["kind",""]) isEqualTo "factory") then {_value = _value + 2};
        _weights set [_idx,(_weights # _idx) + _value];
    } forEach _locations;
    private _min = selectMin _weights;
    private _max = selectMax _weights;
    private _balance = if (_max <= 0) then {0} else {_min / _max};
    // Random tie-breaker keeps equally balanced campaigns from always using one compass orientation.
    _scored pushBack [_balance,random 1,_rotation];
};
_scored sort false;
private _rotation = if (count _scored > 0) then {(_scored # 0) # 2} else {random 360};

private _sectors = createHashMap;
for "_i" from 0 to (_count - 1) do {
    _sectors set [_active # _i,[(_rotation + (_i * (360 / _count))) mod 360,_half]];
};
_deployment set ["rotation",_rotation];
_deployment set ["buffer",if (_count >= 2) then {2500} else {0}];
_deployment set ["sectors",_sectors];
_campaign set ["deployment",_deployment];
_campaign set ["phase","deployment"];
{
    private _f = [_x] call TYR_fnc_StateGetFaction;
    if !(_f getOrDefault ["baseConfirmed",false]) then {_f set ["basePosition",[]]};
} forEach _active;
["deployment-generated",true] call TYR_fnc_StateMarkDirty;
diag_log format ["[TYRANTS DEPLOYMENT] %1 sectors generated. rotation=%2 buffer=%3",_count,_rotation,_deployment get "buffer"];
true
