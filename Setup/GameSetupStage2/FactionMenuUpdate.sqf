params["_selectedFaction","_updown"];

_setupMenu = findDisplay 1002;

_selectedFactionLB = _setupMenu displayCtrl 2;
_FactionLB = _setupMenu displayCtrl 1;
_AvailableVehLB = _setupMenu displayCtrl 5;

switch (_updown) do {
    case 0: { 
        _selectedFactionText = _FactionLB lbText (_selectedFaction);
        _FactionLB lbDelete _selectedFaction;

        if (_selectedFactionText != "") then {
            _selectedFactionLB lbAdd _selectedFactionText;
        };
    };
    case 1: { 
        _selectedFactionText = _selectedFactionLB lbText (_selectedFaction);
        _selectedFactionLB lbDelete _selectedFaction;

        if (_selectedFactionText != "") then {
            _FactionLB lbAdd _selectedFactionText;
        };
    };
};

_dlcs = [];
lbClear _AvailableVehLB;

for "_i" from 0 to (lbSize _selectedFactionLB - 1) do {
    private _item = _selectedFactionLB lbText _i;

    if (_item == "Vanilla") then {
        _dlcs pushBack ""; 
    } 
    else 
    {
        _dlcs pushBack _item; 
    };
};


{

    {

        if ((_x # 2) in _dlcs) then {

            _AvailableVehLB lbAdd _x # 0;
            
        };
            
    } forEach _x;
    
} forEach gameData # 3 # 1;