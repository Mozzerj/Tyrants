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
    private _lastRevision = -1;
    while {!isNull findDisplay 1201} do {
        private _sel = lbCurSel _list;
        private _revision = missionNamespace getVariable ["TYR_ClientLocationRevision",0];
        if (_sel isNotEqualTo _last || {_revision isNotEqualTo _lastRevision}) then {
            _last = _sel;
            _lastRevision = _revision;
            private _class = if (_sel >= 0) then {_list lbData _sel} else {""};
            private _d = findDisplay 1201;
            private _props = _d displayCtrl 6;
            lbClear _props;
            (_d displayCtrl 7) ctrlEnable false;
            (_d displayCtrl 7) ctrlSetText "NO PRODUCED STOCK";
            if (_class isNotEqualTo "" && {isClass (configFile >> "CfgVehicles" >> _class)}) then {
                (_d displayCtrl 5) ctrlSetText getText (configFile >> "CfgVehicles" >> _class >> "editorPreview");
                private _ready = 0;
                private _productKey = format ["vehicle:%1",_class];
                {
                    private _l = _x;
                    if (_l isEqualType [] && {count _l > 12} && {(_l # 2) isEqualTo "factory"} && {(_l # 4) isEqualTo TYR_PlayerFaction} && {(_l param [11,""]) isEqualTo "vehicle"}) then {
                        {
                            if ((_x param [0,""]) isEqualTo _productKey) then {_ready = _ready + (_x param [1,0])};
                        } forEach (_l param [12,[]]);
                    };
                } forEach values (TYR_ClientState getOrDefault ["locations",createHashMap]);
                private _buildTime = -1;
                {
                    if ((_x # 0) isEqualTo _productKey) exitWith {_buildTime = _x # 4};
                } forEach ([TYR_PlayerFaction,"vehicle"] call TYR_fnc_ProductionGetCatalog);
                _props lbAdd format ["Class: %1",_class];
                _props lbAdd format ["Ready stock: %1 produced",_ready];
                _props lbAdd format ["Factory build time: %1",if (_buildTime >= 0) then {format ["%1s",round _buildTime]} else {"LOCKED"}];
                _props lbAdd "Release cost: 1 completed vehicle from factory stock";
                _props lbAdd format ["Category: %1",toUpper ([_class] call TYR_fnc_VehicleCategory)];
                _props lbAdd format ["Armour: %1",getNumber (configFile >> "CfgVehicles" >> _class >> "armor")];
                _props lbAdd format ["Max speed: %1",getNumber (configFile >> "CfgVehicles" >> _class >> "maxSpeed")];
                (_d displayCtrl 7) ctrlEnable (_ready > 0);
                (_d displayCtrl 7) ctrlSetText (if (_ready > 0) then {"RELEASE PRODUCED VEHICLE"} else {"NO PRODUCED STOCK"});
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
