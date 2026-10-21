params ["_position","_sector",["_buffer",2500]];
if !(_position isEqualType [] && {count _position >= 2}) exitWith {[false,"INVALID POSITION",0,90,0]};
if !(_sector isEqualType [] && {count _sector >= 2}) exitWith {[false,"NO DEPLOYMENT SECTOR",0,90,0]};

private _x = _position # 0;
private _y = _position # 1;
private _halfWidth = 20;
private _halfDepth = 15;
if (_x < (_halfWidth + 25) || {_y < (_halfDepth + 25)} || {_x > worldSize - (_halfWidth + 25)} || {_y > worldSize - (_halfDepth + 25)}) exitWith {[false,"HQ FOOTPRINT IS OUTSIDE THE OPERATION AREA",0,90,0]};

// The chosen point is the exact centre of a 40 x 30 m HQ footprint. Do not
// silently move it. Sample the whole footprint so the map preview matches what
// the server will accept.
private _samples = [
    [0,0],
    [_halfWidth,0],[-_halfWidth,0],[0,_halfDepth],[0,-_halfDepth],
    [_halfWidth,_halfDepth],[_halfWidth,-_halfDepth],[-_halfWidth,_halfDepth],[-_halfWidth,-_halfDepth]
];
private _water = false;
{
    private _off = _x;
    private _p = [(_position # 0) + (_off # 0),(_position # 1) + (_off # 1),0];
    if (surfaceIsWater _p) exitWith {_water = true};
} forEach _samples;
if (_water) exitWith {[false,"HQ FOOTPRINT CROSSES WATER",0,90,0]};

private _normal = surfaceNormal _position;
private _nz = ((_normal # 2) max -1) min 1;
private _slope = acos _nz;
if (_slope > 14) exitWith {[false,format ["TERRAIN TOO STEEP (%1 deg)",round _slope],0,_slope,0]};

private _centre = [worldSize * 0.5,worldSize * 0.5,0];
private _dx = _x - (_centre # 0);
private _dy = _y - (_centre # 1);
private _bearing = ((_dx atan2 _dy) + 360) mod 360;
private _sectorCentre = _sector # 0;
private _half = _sector # 1;
private _delta = ((_bearing - _sectorCentre + 540) mod 360) - 180;
if (abs _delta > _half) exitWith {[false,"OUTSIDE YOUR DEPLOYMENT SECTOR",0,_slope,0]};

private _radius = _centre distance2D _position;
private _marginAngle = _half - abs _delta;
private _borderDistance = if (_half >= 179) then {1e9} else {_radius * sin _marginAngle};
if (_borderDistance < _buffer) exitWith {[false,format ["TOO CLOSE TO DEPLOYMENT BORDER (%1m MINIMUM)",round _buffer],_borderDistance,_slope,0]};

private _collisions = [_position,_halfWidth,_halfDepth] call TYR_fnc_DeploymentFindCollisions;
if (count _collisions > 0) exitWith {
    [false,format ["HQ FOOTPRINT HAS %1 COLLISION%2 // move the box until it is clear",count _collisions,if (count _collisions isEqualTo 1) then {""} else {"S"}],_borderDistance,_slope,count _collisions]
};

[true,"VALID HQ FOOTPRINT // exact clicked position",_borderDistance,_slope,0]
