TYR_vehicleCategorySelection = 0;
private _lastSelection = -1;
private _vehicles = GameData # 3 # 1;
private _vehicleTypes = [
    "Cars", "Armored", "Artillery", "Motorcycle", "Tanks", "Helicopter", "Planes", "Static",
    "Ship", "Submarine", "UGV", "UGV Tank", "UAV Heli", "UAV", "UGV Static"
];

private _display = findDisplay 1201;
if (isNull _display) exitWith {};
private _vehicleList = _display displayCtrl 4;
private _details = _display displayCtrl 6;
private _picture = _display displayCtrl 5;
private _categoryLabel = _display displayCtrl 2;
private _multiplier = (GameData # 0 # 0 param [1, []]) param [7, 1];

private _unlockedCategories = [];
{
    if (count _x > 0 && {[Pside, _forEachIndex] call TYR_fnc_IsVehicleCategoryUnlocked}) then {
        _unlockedCategories pushBack _forEachIndex;
    };
} forEach _vehicles;
if (_unlockedCategories isEqualTo []) exitWith {
    hint "No researched vehicle categories are available in this campaign.";
    closeDialog 0;
};
TYR_vehicleCategorySelection = _unlockedCategories # 0;

while {!isNull findDisplay 1201} do {
    if (_lastSelection isNotEqualTo TYR_vehicleCategorySelection) then {
        private _direction = if (_lastSelection < 0 || {TYR_vehicleCategorySelection > _lastSelection}) then {1} else {-1};
        private _candidate = TYR_vehicleCategorySelection;
        private _attempts = 0;
        while {!(_candidate in _unlockedCategories) && {_attempts < count _vehicles}} do {
            _candidate = _candidate + _direction;
            if (_candidate >= count _vehicles) then {_candidate = 0};
            if (_candidate < 0) then {_candidate = (count _vehicles) - 1};
            _attempts = _attempts + 1;
        };
        TYR_vehicleCategorySelection = _candidate;
        lbClear _vehicleList;
        _categoryLabel ctrlSetText (_vehicleTypes param [TYR_vehicleCategorySelection, format ["Category %1", TYR_vehicleCategorySelection]]);
        {
            private _row = _vehicleList lbAdd (_x # 0);
            _vehicleList lbSetData [_row, _x # 1];
        } forEach (_vehicles # TYR_vehicleCategorySelection);
        _vehicleList lbSetCurSel 0;
        _lastSelection = TYR_vehicleCategorySelection;
    };

    private _rowIndex = lbCurSel _vehicleList;
    if (_rowIndex >= 0 && {_rowIndex < count (_vehicles # TYR_vehicleCategorySelection)}) then {
        private _data = _vehicles # TYR_vehicleCategorySelection # _rowIndex;
        private _className = _data # 1;
        private _cost = round ((_data # 8) * _multiplier);

        lbClear _details;
        _details lbAdd (_data # 0);
        _details lbAdd "";
        _details lbAdd format ["Cost: %1", _cost];
        _details lbAdd "";
        _details lbAdd format ["Passengers: %1", getNumber (configFile >> "CfgVehicles" >> _className >> "transportSoldier")];
        _details lbAdd format ["Armor: %1", _data # 5];
        _details lbAdd format ["Structural Armor: %1", _data # 6];
        _details lbAdd format ["Ammo Volume: %1", _data # 7];
        _details lbAdd "";
        _details lbAdd "Weapons";
        {
            private _name = getText (configFile >> "CfgWeapons" >> _x >> "displayName");
            if (_name isNotEqualTo "") then {_details lbAdd format ["    %1", _name]};
        } forEach (_data # 3);
        _details lbAdd "";
        _details lbAdd "Magazines";
        {
            private _name = getText (configFile >> "CfgMagazines" >> _x >> "displayName");
            if (_name isNotEqualTo "") then {_details lbAdd format ["    %1", _name]};
        } forEach (_data # 4);
        _picture ctrlSetText (_data # 2);
    };

    sleep 0.1;
};
