params ["_selected"];
if !(_selected isEqualType [] && {count _selected >= 8}) exitWith {};

private _captureTimes = [60, 90, 120, 180];
private _captureRanges = [50, 100, 175, 250];
private _steel = [5000, 10000, 15000, 20000, 30000, 45000];
private _resources = [15000, 20000, 30000, 40000, 50000, 75000];
private _manpower = [15, 20, 30, 40, 50, 75];
private _multipliers = [0.5, 1, 1.5, 2, 2.5, 3];

private _safePick = {
    params ["_values", "_index", "_fallbackIndex"];
    if (_index < 0 || {_index >= count _values}) then {_values # _fallbackIndex} else {_values # _index};
};

private _settings = [
    [_captureTimes, _selected # 0, 2] call _safePick,
    [_captureRanges, _selected # 1, 2] call _safePick,
    [_steel, _selected # 2, 2] call _safePick,
    [_resources, _selected # 3, 2] call _safePick,
    [_resources, _selected # 4, 2] call _safePick,
    [_manpower, _selected # 5, 2] call _safePick,
    [_multipliers, _selected # 6, 1] call _safePick,
    [_multipliers, _selected # 7, 1] call _safePick
];

[_settings] remoteExecCall ["TYR_fnc_ServerApplySettings", 2];
closeDialog 0;
