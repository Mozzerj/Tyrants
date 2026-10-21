params ["_pairs", "_key", ["_default", ""]];
if !(_pairs isEqualType []) exitWith {_default};
private _i = _pairs findIf {_x isEqualType [] && {count _x >= 2} && {(_x # 0) isEqualTo _key}};
if (_i < 0) exitWith {_default};
(_pairs # _i) # 1
