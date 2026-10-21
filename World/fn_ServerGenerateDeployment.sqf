if (!isServer) exitWith {false};
private _campaign = TYR_State get "campaign";
private _deployment = _campaign getOrDefault ["deployment",createHashMap];
private _active = [true] call TYR_fnc_FactionIds;
private _count = count _active;
if (_count < 1) exitWith {diag_log "[TYRANTS DEPLOYMENT] No active factions.";false};

private _layoutVersion = 2;
private _buffer = if (_count >= 2) then {2500} else {0};
private _existing = _deployment getOrDefault ["sectors",createHashMap];
private _existingValid = (_deployment getOrDefault ["layoutVersion",0]) >= _layoutVersion && {(count keys _existing) isEqualTo _count};
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

// Sample real land across the island. Rotation scoring uses only land that is
// actually outside the shared no-HQ border buffer, so every faction receives a
// useful deployment interior rather than merely an equal angular slice.
private _landSamples = [];
private _step = worldSize / 20;
for "_gx" from (_step * 0.5) to (worldSize - _step * 0.5) step _step do {
    for "_gy" from (_step * 0.5) to (worldSize - _step * 0.5) step _step do {
        private _p = [_gx,_gy,0];
        if !(surfaceIsWater _p) then {_landSamples pushBack _p};
    };
};

private _bearing = {
    params ["_p"];
    (((((_p # 0) - (_centre # 0)) atan2 ((_p # 1) - (_centre # 1))) + 360) mod 360)
};
private _indexFor = {
    params ["_angle","_rotation"];
    private _best = 0;
    private _bestAbs = 999;
    for "_i" from 0 to (_count - 1) do {
        private _c = (_rotation + (_i * (360 / _count))) mod 360;
        private _d = abs (((_angle - _c + 540) mod 360) - 180);
        if (_d < _bestAbs) then {_bestAbs = _d;_best = _i};
    };
    _best
};
private _borderDistanceFor = {
    params ["_p","_idx","_rotation"];
    if (_count <= 1) exitWith {1e9};
    private _angle = [_p] call _bearing;
    private _sectorCentre = (_rotation + (_idx * (360 / _count))) mod 360;
    private _delta = abs (((_angle - _sectorCentre + 540) mod 360) - 180);
    private _radius = _centre distance2D _p;
    private _marginAngle = (_half - _delta) max 0;
    _radius * sin _marginAngle
};

private _scored = [];
for "_rotation" from 0 to 355 step 5 do {
    private _landWeights = [];
    private _siteWeights = [];
    for "_i" from 0 to (_count - 1) do {
        _landWeights pushBack 0;
        _siteWeights pushBack 0;
    };

    {
        private _angle = [_x] call _bearing;
        private _idx = [_angle,_rotation] call _indexFor;
        private _borderDistance = [_x,_idx,_rotation] call _borderDistanceFor;
        if (_borderDistance >= _buffer) then {
            _landWeights set [_idx,(_landWeights # _idx) + 1];
        };
    } forEach _landSamples;

    {
        private _pos = _x getOrDefault ["position",[0,0,0]];
        private _angle = [_pos] call _bearing;
        private _idx = [_angle,_rotation] call _indexFor;
        private _borderDistance = [_pos,_idx,_rotation] call _borderDistanceFor;
        if (_borderDistance >= _buffer) then {
            private _value = _x getOrDefault ["value",1];
            if ((_x getOrDefault ["kind",""]) isEqualTo "factory") then {_value = _value + 2};
            _siteWeights set [_idx,(_siteWeights # _idx) + _value];
        };
    } forEach _locations;

    private _minLand = selectMin _landWeights;
    private _maxLand = selectMax _landWeights;
    private _landBalance = if (_maxLand <= 0) then {0} else {_minLand / _maxLand};
    private _minSites = selectMin _siteWeights;
    private _maxSites = selectMax _siteWeights;
    private _siteBalance = if (_maxSites <= 0) then {0} else {_minSites / _maxSites};

    // Highest minimum usable land wins first; balance and strategic sites break ties.
    _scored pushBack [_minLand,_landBalance,_minSites,_siteBalance,random 1,_rotation];
};
_scored sort false;
private _rotation = if (count _scored > 0) then {(_scored # 0) # 5} else {random 360};

private _sectors = createHashMap;
for "_i" from 0 to (_count - 1) do {
    _sectors set [_active # _i,[(_rotation + (_i * (360 / _count))) mod 360,_half]];
};
_deployment set ["layoutVersion",_layoutVersion];
_deployment set ["rotation",_rotation];
_deployment set ["buffer",_buffer];
_deployment set ["sectors",_sectors];
_campaign set ["deployment",_deployment];
_campaign set ["phase","deployment"];
{
    private _f = [_x] call TYR_fnc_StateGetFaction;
    if !(_f getOrDefault ["baseConfirmed",false]) then {_f set ["basePosition",[]]};
} forEach _active;
["deployment-generated",true] call TYR_fnc_StateMarkDirty;
diag_log format ["[TYRANTS DEPLOYMENT] %1 balanced sectors generated. rotation=%2 sharedBuffer=%3 usableLand=%4",_count,_rotation,_buffer,if (count _scored > 0) then {(_scored # 0) # 0} else {0}];
true
