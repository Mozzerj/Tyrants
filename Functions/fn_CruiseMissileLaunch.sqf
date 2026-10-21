params ["_vls", "_targetPos", ["_sideIndex", 0]];
if (!isServer || {isNull _vls}) exitWith {};
if !(_targetPos isEqualType [] && {count _targetPos >= 2}) exitWith {};

private _target = createVehicle ["ArtilleryTargetW", _targetPos, [], 0, "CAN_COLLIDE"];
private _missile = createVehicle ["ammo_Missile_Cruise_01", (getPosATL _vls) vectorAdd [0, 0, 2], [], 0, "CAN_COLLIDE"];
_missile setVelocity [0, 0, 12];

private _markerName = format ["TYR_missile_%1_%2", floor serverTime, floor random 1000000];
private _marker = createMarker [_markerName, getPosATL _missile];
_marker setMarkerType "mil_triangle";
_marker setMarkerColor "ColorRed";
_marker setMarkerText "Cruise Missile";

private _setDirection = {
    params ["_projectile", "_yaw", "_pitch"];
    _projectile setVectorDirAndUp [
        [sin _yaw * cos _pitch, cos _yaw * cos _pitch, sin _pitch],
        [[0, -sin _pitch, cos _pitch], -_yaw] call BIS_fnc_rotateVector2D
    ];
};

private _startTime = time;
private _initialDir = (getPosATL _missile) getDir _targetPos;
[_missile, _initialDir, 85] call _setDirection;
sleep 1.5;

while {alive _missile && {time - _startTime < 180} && {_missile distance2D _target > 35}} do {
    private _distance = _missile distance2D _target;
    private _missilePosATL = getPosATL _missile;
    private _targetATL = getPosATL _target;
    private _dir = _missilePosATL getDir _targetATL;
    private _pitch = 0;

    if (_distance > 3000) then {
        private _terrainASL = getTerrainHeightASL (_missilePosATL getPos [35, _dir]);
        private _heightASL = (getPosASL _missile) # 2;
        private _desiredASL = _terrainASL + 100;
        _pitch = (((_desiredASL - _heightASL) * 0.12) max -8) min 8;
    } else {
        if (_distance > 1000) then {
            private _desiredHeight = 500;
            _pitch = (((_desiredHeight - (_missilePosATL # 2)) * 0.08) max -15) min 15;
        } else {
            private _missileASL = getPosASL _missile;
            private _targetASL = getPosASL _target;
            private _diff = _targetASL vectorDiff _missileASL;
            _pitch = (_diff # 2) atan2 (sqrt ((_diff # 0)^2 + (_diff # 1)^2));
        };
    };

    [_missile, _dir, _pitch] call _setDirection;
    _missile setVelocityModelSpace [0, 190, 0];
    _marker setMarkerPos (getPosATL _missile);
    _marker setMarkerDir _dir;
    sleep 0.08;
};

if (alive _missile && {_missile distance2D _target <= 35}) then {
    // Let the projectile's own warhead resolve on the target area.
    _missile setVelocityModelSpace [0, 250, 0];
    sleep 1;
};
if (alive _missile && {time - _startTime >= 180}) then {deleteVehicle _missile};
deleteMarker _marker;
deleteVehicle _target;
