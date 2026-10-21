private _points = [];
if (!isNil "GameData" && {count (GameData # 1) > 0}) then {
    {
        {
            if (_x isEqualType [] && {count _x > 4}) then {
                _points pushBack (_x # 4);
            };
        } forEach _x;
    } forEach (GameData # 1);
};

private _slope = 0;
private _intercept = worldSize / 2;

if (count _points >= 2) then {
    private _n = count _points;
    private _sumX = 0;
    private _sumY = 0;
    private _sumXY = 0;
    private _sumX2 = 0;

    {
        private _xValue = _x # 0;
        private _yValue = _x # 1;
        _sumX = _sumX + _xValue;
        _sumY = _sumY + _yValue;
        _sumXY = _sumXY + (_xValue * _yValue);
        _sumX2 = _sumX2 + (_xValue * _xValue);
    } forEach _points;

    private _denominator = (_n * _sumX2) - (_sumX * _sumX);
    if (abs _denominator > 0.001) then {
        _slope = ((_n * _sumXY) - (_sumX * _sumY)) / _denominator;
        _intercept = (_sumY - (_slope * _sumX)) / _n;
    } else {
        _intercept = _sumY / _n;
    };
};

[_slope, _intercept]
