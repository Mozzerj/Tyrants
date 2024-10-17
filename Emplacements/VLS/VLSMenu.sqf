createDialog "VLSTargetMenu";
params["_Asset"];

_targetPos = [17430,13165,0] vectorAdd [random[-100,0,100],random[-100,0,100],0];
_VLS = (_Asset # 0);

setMissileDir = {
    params["_yaw","_pitch","_roll"];

    _missile setVectorDirAndUp [
        [sin _yaw * cos _pitch, cos _yaw * cos _pitch, sin _pitch],
        [[sin _roll, -sin _pitch, cos _roll * cos _pitch], -_yaw] call BIS_fnc_rotateVector2D
    ];
};



missileCruiseSystem = {
    params["_missile", "_target"];

    _minHeightATL = 25;
    _maxHeightATL = 30;
    _missileAlt = [0,0,75];

    _missilePitch = 0;

    // Create the triangle marker
    _marker = createMarker [format["missileMarker_%1",_missile], getPos _missile];
    _marker setMarkerType "mil_triangle";
    _marker setMarkerColor "ColorRed";

    while {(getPos _missile distance2D getPos _target) > 3000 && alive _missile} do {

        _dir = (getPos _missile) getDir (getPos _target);
        _dir = _dir + random [-2, 0, 2];

        _sensorHeight = getTerrainHeightASL (getPos _missile getPos[25, _dir]);
        _sensorPos = getPosASL _missile vectorAdd [0,0, - _sensorHeight];

        if (surfaceIsWater _sensorPos) then {
            _missileAlt = getPosASL _missile;
            _minHeightATL = -5;
            _maxHeightATL = 20;
        } else {
            _missileAlt = _sensorPos;
            _minHeightATL = 100;
            _maxHeightATL = 105;
        };

        // Update marker position and text
        _marker setMarkerPos (getPos _missile);
        _marker setMarkerDir _dir;

        if (_missileAlt # 2 < _minHeightATL) then {
            _missilePitch = _missilePitch + 1;
            _missilePitch = (10 min _missilePitch);
            [_dir, _missilePitch, 0] call setMissileDir;
        };
        if (_missileAlt # 2 > _maxHeightATL) then {
            _missilePitch = _missilePitch - 0.5;
            _missilePitch = (1 max _missilePitch);
            [_dir, _missilePitch, 0] call setMissileDir;
        };

        sleep 0.1;
    };
    while {(getPos _missile distance2D getPos _target) < 3000 && (getPos _missile distance2D getPos _target) > 1000 && alive _missile} do {
        systemChat "Stage 2";

        _minHeightATL = 500;
        _maxHeightATL = 505;

        _marker setMarkerPos (getPos _missile);
        _marker setMarkerDir _dir;

        if (_missileAlt # 2 < _minHeightATL) then {
            _missilePitch = _missilePitch + 1;
            _missilePitch = (20 min _missilePitch);
            [_dir, _missilePitch, 0] call setMissileDir;
        };
        if (_missileAlt # 2 > _maxHeightATL) then {
            _missilePitch = _missilePitch - 0.5;
            _missilePitch = (0 max _missilePitch);
            [_dir, _missilePitch, 0] call setMissileDir;
        };

        sleep 0.1;
    
    };
    while {(getPos _missile distance2D getPos _target) < 1000 && alive _missile} do {
        systemChat "Stage 3";

        _missilePos = getPosASL _missile;
        _targetPos = getPosASL _target;

        _dir = _missilePos getDir _targetPos;

        _diff = _targetPos vectorDiff _missilePos;
        _missilePitch = (_diff select 2) atan2 (sqrt ((_diff select 0)^2 + (_diff select 1)^2));

        [_dir, _missilePitch, 0] call setMissileDir;


        _marker setMarkerPos (getPos _missile);
        _marker setMarkerDir _dir;

        sleep 0.1;

    };

    deleteMarker _marker;

};





fireMissile = {
    params["_VLS","_targetPos"];

    _target = createVehicle ["ArtilleryTargetW", _targetPos, [], 0, "CAN_COLLIDE"];
    _missile = createVehicle ["ammo_Missile_Cruise_01", (getPos _VLS) vectorAdd [0,0,2], [], 0, "CAN_COLLIDE"];

    _missile setVelocity [0, 0, 7];

/*
    _FX_smoke_source = "#particlesource" createVehicleLocal (getpos _missile);
    _FX_smoke_source setParticleClass "Missile5";
    _FX_smoke_source attachto [_missile,[0,-1,0]];
*/

    _dir = getPos _missile getDir _targetPos;

    _dir = _dir + random [-10,0,10];

    [_dir, 90, 0] call setMissileDir;

    sleep 2;

    for "_i" from 0 to 85 do {

        
        [_dir, 90 - _i, 0] call setMissileDir;

        sleep 0.02;
        
    };

    sleep 1;

    [_missile,_target] call missileCruiseSystem;

};

for "_i" from 0 to 0 do {

    [_VLS,_targetPos] call fireMissile;

};