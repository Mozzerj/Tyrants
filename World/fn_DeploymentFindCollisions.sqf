params ["_position",["_halfWidth",20],["_halfDepth",15]];
if !(_position isEqualType [] && {count _position >= 2}) exitWith {[]};

private _radius = (sqrt ((_halfWidth * _halfWidth) + (_halfDepth * _halfDepth))) + 45;
private _objects = [];

// Hard terrain objects that should not be hidden underneath a newly selected HQ footprint.
// Vegetation is deliberately excluded: trees/bushes can be cleared by the eventual base build.
{
    _objects pushBackUnique _x;
} forEach (nearestTerrainObjects [
    _position,
    ["BUILDING","HOUSE","CHURCH","CHAPEL","BUNKER","FORTRESS","WALL","FENCE","ROCKS","FUELSTATION","HOSPITAL","TRANSMITTER","WATERTOWER"],
    _radius,
    false,
    true
]);

private _result = [];
private _hqRight = [1,0];
private _hqForward = [0,1];

{
    private _obj = _x;
    if (!isNull _obj) then {
        private _bb = boundingBoxReal _obj;
        if (_bb isEqualType [] && {count _bb >= 2}) then {
            private _min = _bb # 0;
            private _max = _bb # 1;
            if (_min isEqualType [] && {_max isEqualType []} && {count _min >= 2} && {count _max >= 2}) then {
                private _halfW = (((_max # 0) - (_min # 0)) * 0.5) max 0.75;
                private _halfD = (((_max # 1) - (_min # 1)) * 0.5) max 0.75;
                // Ignore obviously broken terrain bounding boxes; only hard physical obstructions are considered.
                if (_halfW <= 90 && {_halfD <= 90}) then {
                    private _localCentre = [((_min # 0) + (_max # 0)) * 0.5,((_min # 1) + (_max # 1)) * 0.5,0];
                    private _centre = _obj modelToWorld _localCentre;
                    private _dir = getDir _obj;
                    private _right = [cos _dir,-sin _dir];
                    private _forward = [sin _dir,cos _dir];
                    private _delta = [(_centre # 0) - (_position # 0),(_centre # 1) - (_position # 1)];
                    private _intersects = true;

                    {
                        private _axis = _x;
                        private _distance = abs (((_delta # 0) * (_axis # 0)) + ((_delta # 1) * (_axis # 1)));
                        private _hqExtent = (abs (((_hqRight # 0) * (_axis # 0)) + ((_hqRight # 1) * (_axis # 1))) * _halfWidth)
                            + (abs (((_hqForward # 0) * (_axis # 0)) + ((_hqForward # 1) * (_axis # 1))) * _halfDepth);
                        private _objExtent = (abs (((_right # 0) * (_axis # 0)) + ((_right # 1) * (_axis # 1))) * _halfW)
                            + (abs (((_forward # 0) * (_axis # 0)) + ((_forward # 1) * (_axis # 1))) * _halfD);
                        if (_distance > (_hqExtent + _objExtent)) exitWith {_intersects = false};
                    } forEach [_hqRight,_hqForward,_right,_forward];

                    if (_intersects) then {
                        private _kind = typeOf _obj;
                        if (_kind isEqualTo "") then {_kind = "TERRAIN OBJECT"};
                        _result pushBack [_obj,_kind,_centre,_halfW,_halfD,_dir];
                    };
                };
            };
        };
    };
} forEach _objects;

_result
