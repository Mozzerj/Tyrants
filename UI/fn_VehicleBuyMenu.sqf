disableSerialization;
waitUntil {!isNull findDisplay 1201};
private _d = findDisplay 1201;
if (isNil "TYR_vehicleCategorySelection") then {TYR_vehicleCategorySelection = 0};
private _categories = ["other","armored","heavy","rotary","artillery","fixed"];
missionNamespace setVariable ["TYR_vehicleCategories",_categories];

private _refresh = {
    disableSerialization;
    private _d = findDisplay 1201;
    if (isNull _d || {isNil "TYR_ClientState"}) exitWith {};
    private _cats = missionNamespace getVariable ["TYR_vehicleCategories",["other"]];
    TYR_vehicleCategorySelection = (TYR_vehicleCategorySelection max 0) min ((count _cats)-1);
    private _cat = _cats # TYR_vehicleCategorySelection;
    (_d displayCtrl 2) ctrlSetText toUpper _cat;
    private _list = _d displayCtrl 4;
    lbClear _list;
    private _f = (TYR_ClientState get "factions") getOrDefault [TYR_PlayerFaction,[]];
    if (count _f < 9) exitWith {};
    private _pool = _f # 8;
    private _unlocked = _f # 6;
    private _gate = switch (_cat) do {
        case "armored": {"proc.armored"};
        case "heavy": {"proc.heavy"};
        case "rotary": {"proc.rotary"};
        case "artillery": {"proc.artillery"};
        case "fixed": {"proc.fixed"};
        default {""};
    };
    if (_gate isNotEqualTo "" && {!(_gate in _unlocked)}) exitWith {
        _list lbAdd format ["LOCKED // %1 required",_gate];
    };
    {
        if (([_x] call TYR_fnc_VehicleCategory) isEqualTo _cat) then {
            private _name = getText (configFile >> "CfgVehicles" >> _x >> "displayName");
            private _i = _list lbAdd _name;
            _list lbSetData [_i,_x];
        };
    } forEach _pool;
    if (lbSize _list > 0) then {_list lbSetCurSel 0};
};
missionNamespace setVariable ["TYR_vehicleMenuRefresh",_refresh];
call _refresh;

[_d displayCtrl 4] spawn {
    disableSerialization;
    params ["_list"];
    private _last = -2;
    while {!isNull findDisplay 1201} do {
        private _sel = lbCurSel _list;
        if (_sel isNotEqualTo _last) then {
            _last = _sel;
            private _class = if (_sel >= 0) then {_list lbData _sel} else {""};
            private _d = findDisplay 1201;
            private _props = _d displayCtrl 6;
            lbClear _props;
            if (_class isNotEqualTo "" && {isClass (configFile >> "CfgVehicles" >> _class)}) then {
                (_d displayCtrl 5) ctrlSetText getText (configFile >> "CfgVehicles" >> _class >> "editorPreview");
                _props lbAdd format ["Class: %1",_class];
                _props lbAdd format ["Cost: %1 fuel",[_class] call TYR_fnc_VehicleCost];
                _props lbAdd format ["Category: %1",toUpper ([_class] call TYR_fnc_VehicleCategory)];
                _props lbAdd format ["Armour: %1",getNumber (configFile >> "CfgVehicles" >> _class >> "armor")];
                _props lbAdd format ["Max speed: %1",getNumber (configFile >> "CfgVehicles" >> _class >> "maxSpeed")];
            };
        };
        sleep 0.15;
        private _fn = missionNamespace getVariable ["TYR_vehicleMenuRefresh",{}];
        // Arrow buttons only change the index; pick that up without polling expensive data.
        private _cats = missionNamespace getVariable ["TYR_vehicleCategories",["other"]];
        private _clamped = (TYR_vehicleCategorySelection max 0) min ((count _cats)-1);
        if (_clamped isNotEqualTo TYR_vehicleCategorySelection) then {TYR_vehicleCategorySelection = _clamped};
    };
};

[] spawn {
    private _lastCat = TYR_vehicleCategorySelection;
    while {!isNull findDisplay 1201} do {
        if (TYR_vehicleCategorySelection isNotEqualTo _lastCat) then {
            _lastCat = TYR_vehicleCategorySelection;
            call (missionNamespace getVariable ["TYR_vehicleMenuRefresh",{}]);
        };
        sleep 0.1;
    };
};
