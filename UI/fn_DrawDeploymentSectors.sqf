params ["_map",["_alpha",0.09],["_labels",true]];
if (isNil "TYR_ClientState") exitWith {};
private _campaign = TYR_ClientState getOrDefault ["campaign",[]];
if !(_campaign isEqualType [] && {count _campaign >= 2}) exitWith {};
private _deployment = _campaign # 1;
if !(_deployment isEqualType [] && {count _deployment >= 3}) exitWith {};
private _sectors = _deployment # 2;
private _centre = [worldSize * 0.5,worldSize * 0.5,0];
private _radius = worldSize * 1.05;
{
    _x params ["_fid","_sector"];
    if (_sector isEqualType [] && {count _sector >= 2}) then {
        private _c = _sector # 0;
        private _half = _sector # 1;
        private _baseColor = [_fid,true] call TYR_fnc_FactionColor;
        private _color = [_baseColor # 0,_baseColor # 1,_baseColor # 2,_alpha];
        private _verts = [];
        private _width = _half * 2;
        private _slices = (ceil (_width / 10)) max 1;
        private _slice = _width / _slices;
        for "_i" from 0 to (_slices - 1) do {
            private _a1 = (_c - _half) + (_i * _slice);
            private _a2 = _a1 + _slice;
            private _p1 = [(_centre # 0) + (sin _a1) * _radius,(_centre # 1) + (cos _a1) * _radius,0];
            private _p2 = [(_centre # 0) + (sin _a2) * _radius,(_centre # 1) + (cos _a2) * _radius,0];
            _verts append [_centre,_p1,_p2];
        };
        _map drawTriangle [_verts,_color,"#(rgb,1,1,1)color(1,1,1,1)"];
        private _b = _c - _half;
        private _bp = [(_centre # 0)+(sin _b)*_radius,(_centre # 1)+(cos _b)*_radius,0];
        _map drawLine [_centre,_bp,[_baseColor # 0,_baseColor # 1,_baseColor # 2,0.95]];
        if (_labels) then {
            private _lp = [(_centre # 0)+(sin _c)*(worldSize*0.33),(_centre # 1)+(cos _c)*(worldSize*0.33),0];
            private _name = toUpper _fid;
            if (!isNil "TYR_ClientState") then {
                private _fr = (TYR_ClientState get "factions") getOrDefault [_fid,[]];
                if (count _fr > 1) then {_name = _fr # 1};
            };
            _map drawIcon ["\A3\ui_f\data\map\markers\military\circle_CA.paa",[_baseColor # 0,_baseColor # 1,_baseColor # 2,0.8],_lp,10,10,0,format ["%1 DEPLOYMENT REGION",toUpper _name],1,0.038,"PuristaMedium","center"];
        };
    };
} forEach _sectors;
