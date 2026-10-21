params ["_position",["_edgeMargin",100]];
if !(_position isEqualType [] && {count _position >= 2}) exitWith {false};
private _x = _position # 0;
private _y = _position # 1;
if !(_x isEqualType 0 && {_y isEqualType 0}) exitWith {false};
if (_x < _edgeMargin || {_y < _edgeMargin} || {_x > worldSize - _edgeMargin} || {_y > worldSize - _edgeMargin}) exitWith {false};
private _ground = [_x,_y,0];
if (surfaceIsWater _ground) exitWith {false};
true
