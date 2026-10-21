params ["_observer","_target",["_maxRange",2500],["_minDot",-2]];
if (isNull _observer || {isNull _target} || {!alive _observer} || {!alive _target}) exitWith {false};
if ((_observer distance _target) > _maxRange) exitWith {false};

private _from = if (_observer isKindOf "Man") then {
    eyePos _observer
} else {
    (getPosASL _observer) vectorAdd [0,0,1.5]
};
private _to = aimPos _target;
private _delta = _to vectorDiff _from;
if ((vectorMagnitude _delta) <= 0.01) exitWith {true};

if (_minDot > -1.5) then {
    private _look = if (_observer isKindOf "Man") then {eyeDirection _observer} else {vectorDir _observer};
    private _toward = vectorNormalized _delta;
    if (((vectorNormalized _look) vectorDotProduct _toward) < _minDot) exitWith {false};
};

(count (lineIntersectsSurfaces [_from,_to,_observer,_target,true,1,"VIEW","NONE"])) isEqualTo 0
