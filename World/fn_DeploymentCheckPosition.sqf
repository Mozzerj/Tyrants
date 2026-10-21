params ["_position","_sector",["_buffer",2500]];
if !(_position isEqualType [] && {count _position >= 2}) exitWith {[false,"INVALID POSITION",0,90]};
if !(_sector isEqualType [] && {count _sector >= 2}) exitWith {[false,"NO DEPLOYMENT SECTOR",0,90]};
private _x = _position # 0;
private _y = _position # 1;
if (_x < 100 || {_y < 100} || {_x > worldSize - 100} || {_y > worldSize - 100}) exitWith {[false,"OUTSIDE THE OPERATION AREA",0,90]};
if (surfaceIsWater _position) exitWith {[false,"POSITION IS IN WATER",0,90]};
if (isOnRoad _position) exitWith {[false,"POSITION IS ON A ROAD",0,90]};
if (count (nearestObjects [_position,["House"],35]) > 0) exitWith {[false,"AREA OBSTRUCTED BY BUILDINGS",0,90]};

private _normal = surfaceNormal _position;
private _nz = ((_normal # 2) max -1) min 1;
private _slope = acos _nz;
if (_slope > 14) exitWith {[false,format ["TERRAIN TOO STEEP (%1 deg)",round _slope],0,_slope]};

private _centre = [worldSize * 0.5,worldSize * 0.5,0];
private _dx = _x - (_centre # 0);
private _dy = _y - (_centre # 1);
private _bearing = ((_dx atan2 _dy) + 360) mod 360;
private _sectorCentre = _sector # 0;
private _half = _sector # 1;
private _delta = ((_bearing - _sectorCentre + 540) mod 360) - 180;
if (abs _delta > _half) exitWith {[false,"OUTSIDE YOUR DEPLOYMENT SECTOR",0,_slope]};

private _radius = _centre distance2D _position;
private _marginAngle = _half - abs _delta;
private _borderDistance = if (_half >= 179) then {1e9} else {_radius * sin _marginAngle};
if (_borderDistance < _buffer) exitWith {[false,format ["TOO CLOSE TO DEPLOYMENT BORDER (%1m MINIMUM)",round _buffer],_borderDistance,_slope]};
[true,"VALID HQ POSITION",_borderDistance,_slope]
