selection = 0;
_selector1 = 1;

_vehs = gameData # 3;
_vehTypes = ["Tanks", "Cars", "Planes", "Helis", "UAVs"];

while {!isNull findDisplay 1002} do {

    if (_selector1 != selection) then {

        if (selection > (count _vehs - 1)) then {selection = 0};
        if (selection < 0) then {selection = (count _vehs - 1)};

        lbClear 4;
        (findDisplay 1002 displayCtrl 4) lbSetSelected [1, true, true];

        ctrlSetText [2, (_vehTypes # selection)];

        _selector1 = selection;

        {
            _VehicleListBox = ((findDisplay 1002) displayCtrl 4);
            _VehicleListBox lbAdd (_x # 0);  // Add vehicle names without sorting
            lbSetData [4, (lbSize 4 - 1), _x # 1];
        } forEach (_vehs # selection);

        lbSetCurSel [4, 0];

    };

    _selected = lbText [4, lbCurSel 4];
    _VehConfigName = lbData[4, lbCurSel 4];

    lbClear 6;

    _vehdata = _vehs # selection # lbCurSel 4;

    lbAdd [6, _selected];

    lbAdd [6, ""];
    lbAdd [6, format ["Cost: %1", _vehdata # 8]];

    VehicleCost = _vehdata # 8;

    lbAdd [6, ""];
    lbAdd [6, format ["Passengers: %1", getNumber(configFile >> "cfgVehicles" >> _VehConfigName >> "transportSoldier")]];

    // Display armor
    lbAdd [6, ""];
    lbAdd [6, format ["Armor: %1", _vehdata # 5]];
    lbAdd [6, format ["Structural Armor: %1", _vehdata # 6]];

    
    lbAdd [6, ""];
    lbAdd [6, format ["Ammo Volume: %1", _vehdata # 7]];


    lbAdd [6, ""];
    lbAdd [6, "Weapons"];
    
    _weapons = _vehdata # 3;
    
    {
        _weaponDisplayName = getText(configFile >> "cfgWeapons" >> _x >> "displayName");
        lbAdd [6, format["    %1", _weaponDisplayName]];
    } forEach _weapons;

    lbAdd [6, ""];
    lbAdd [6, "Magazines"];
    
    _magazines = _vehdata # 4;
    
    {
        _magazineDisplayName = getText(configFile >> "cfgMagazines" >> _x >> "displayName");
        lbAdd [6, format["    %1", _magazineDisplayName]];
    } forEach _magazines;

    ctrlSetText [5, _vehs # selection # lbCurSel 4 # 2];

    sleep 0.1;
};