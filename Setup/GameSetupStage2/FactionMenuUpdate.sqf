params ["_selectedIndex", "_mode"];
if (isNil "TYR_setupVehicleCatalog") exitWith {};

private _display = findDisplay 1102;
if (isNull _display) exitWith {};
private _availableFactions = _display displayCtrl 1;
private _selectedFactions = _display displayCtrl 2;
private _availableVehicles = _display displayCtrl 5;
private _chosenVehicles = _display displayCtrl 6;

private _getSelectedDlcs = {
    private _result = [];
    for "_i" from 0 to (lbSize _selectedFactions - 1) do {
        private _label = _selectedFactions lbText _i;
        _result pushBackUnique (if (_label isEqualTo "Vanilla") then {""} else {_label});
    };
    _result
};

private _rebuildVehicles = {
    private _selectedDlcs = call _getSelectedDlcs;

    // Drop chosen vehicles that no longer belong to a selected content set.
    for "_i" from ((lbSize _chosenVehicles) - 1) to 0 step -1 do {
        private _class = _chosenVehicles lbData _i;
        private _dlc = getText (configFile >> "CfgVehicles" >> _class >> "dlc");
        if !(_dlc in _selectedDlcs) then {_chosenVehicles lbDelete _i};
    };

    private _chosenClasses = [];
    for "_i" from 0 to (lbSize _chosenVehicles - 1) do {
        _chosenClasses pushBack (_chosenVehicles lbData _i);
    };

    lbClear _availableVehicles;
    {
        private _displayName = _x # 0;
        private _class = _x # 1;
        private _dlc = _x # 2;
        if (_dlc in _selectedDlcs && {!(_class in _chosenClasses)}) then {
            private _row = _availableVehicles lbAdd _displayName;
            _availableVehicles lbSetData [_row, _class];
        };
    } forEach (TYR_setupVehicleCatalog # 1);
};

switch (_mode) do {
    case 0: {
        if (_selectedIndex >= 0) then {
            private _text = _availableFactions lbText _selectedIndex;
            _availableFactions lbDelete _selectedIndex;
            if (_text isNotEqualTo "") then {_selectedFactions lbAdd _text};
        };
        call _rebuildVehicles;
    };
    case 1: {
        if (_selectedIndex >= 0) then {
            private _text = _selectedFactions lbText _selectedIndex;
            if (_text isNotEqualTo "Vanilla") then {
                _selectedFactions lbDelete _selectedIndex;
                if (_text isNotEqualTo "") then {_availableFactions lbAdd _text};
            };
        };
        call _rebuildVehicles;
    };
    case 2: {
        if (_selectedIndex >= 0) then {
            private _text = _availableVehicles lbText _selectedIndex;
            private _class = _availableVehicles lbData _selectedIndex;
            if (_class isNotEqualTo "") then {
                private _row = _chosenVehicles lbAdd _text;
                _chosenVehicles lbSetData [_row, _class];
                _availableVehicles lbDelete _selectedIndex;
            };
        };
    };
    case 3: {
        if (_selectedIndex >= 0) then {
            _chosenVehicles lbDelete _selectedIndex;
            call _rebuildVehicles;
        };
    };
    case 4: {
        for "_i" from 0 to (lbSize _availableVehicles - 1) do {
            private _row = _chosenVehicles lbAdd (_availableVehicles lbText _i);
            _chosenVehicles lbSetData [_row, _availableVehicles lbData _i];
        };
        lbClear _availableVehicles;
    };
    case 5: {
        lbClear _chosenVehicles;
        call _rebuildVehicles;
    };
    default {call _rebuildVehicles};
};
