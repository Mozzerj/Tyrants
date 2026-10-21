params ["_selectedFaction", "_direction"];
if (isNil "TYR_setupVehicleCatalog") exitWith {};

private _setupMenu = findDisplay 1102;
if (isNull _setupMenu) exitWith {};
private _selectedList = _setupMenu displayCtrl 2;
private _availableList = _setupMenu displayCtrl 1;
private _vehicleList = _setupMenu displayCtrl 5;

if (_selectedFaction >= 0) then {
    switch (_direction) do {
        case 0: {
            private _text = _availableList lbText _selectedFaction;
            _availableList lbDelete _selectedFaction;
            if (_text isNotEqualTo "") then {_selectedList lbAdd _text};
        };
        case 1: {
            private _text = _selectedList lbText _selectedFaction;
            _selectedList lbDelete _selectedFaction;
            if (_text isNotEqualTo "") then {_availableList lbAdd _text};
        };
    };
};

private _dlcs = [];
for "_i" from 0 to (lbSize _selectedList - 1) do {
    private _item = _selectedList lbText _i;
    _dlcs pushBack (if (_item isEqualTo "Vanilla") then {""} else {_item});
};

lbClear _vehicleList;
{
    if ((_x # 2) in _dlcs) then {
        _vehicleList lbAdd (_x # 0);
    };
} forEach (TYR_setupVehicleCatalog # 1);
