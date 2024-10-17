selection = 0;
_selector1 = 1;

_vehs = gameData # 3 # 1;

_Research = gameData # 0 # (Pside + 1) # 5 # 2;

_availableVehs = [_vehs # 0,_vehs # 1,_vehs # 2];

if (_Research # 0 == 1) then {_availableVehs pushBack _vehs # 3};
if (_Research # 1 == 1) then {_availableVehs pushBack _vehs # 4};
if (_Research # 2 == 1) then {_availableVehs pushBack _vehs # 5};
if (_Research # 3 == 1) then {_availableVehs pushBack _vehs # 6};
if (_Research # 4 == 1) then {_availableVehs pushBack _vehs # 7;_availableVehs pushBack _vehs # 8;_availableVehs pushBack _vehs # 9;_availableVehs pushBack _vehs # 10;_availableVehs pushBack _vehs # 11};

_vehTypes = [
    "Cars",
    "Ship",
    "Submarine"
];

if (_Research # 0 == 1) then {_vehTypes pushBack "Armoured"};
if (_Research # 1 == 1) then {_vehTypes pushBack "Tanks"};
if (_Research # 2 == 1) then {_vehTypes pushBack "Helicopters"};
if (_Research # 3 == 1) then {_vehTypes pushBack "Artillery"};
if (_Research # 4 == 1) then {_vehTypes pushBack "Planes"};
if (_Research # 4 == 1) then {_vehTypes pushBack "UAV",_vehTypes pushBack "UAV",_vehTypes pushBack "UAV",_vehTypes pushBack "UAV",_vehTypes pushBack "UAV"};

//if (_Research # 5 == 1) then {_availableVehs = _availableVehs + ("UGV","UGV Tank","UAV Heli","UAV")};

while {!isNull findDisplay 1002} do {

    if (_selector1 != selection) then {
        if (count(_availableVehs # selection) == 0) exitWith {selection = selection + 1};
        if (selection > (count _availableVehs - 1)) then {selection = 0};
        if (selection < 0) then {selection = (count _availableVehs)};
            

        lbClear 4;
        (findDisplay 1002 displayCtrl 4) lbSetSelected [1, true, true];

        ctrlSetText [2, (_vehTypes # selection)];

        _selector1 = selection;


        {


            _VehicleListBox = ((findDisplay 1002) displayCtrl 4);
            _VehicleListBox lbAdd (_x # 0);  // Add vehicle names without sorting
            lbSetData [4, (lbSize 4 - 1), _x # 1];
        } forEach (_availableVehs # selection);

        lbSetCurSel [4, 0];

    };

    _selected = lbText [4, lbCurSel 4];
    _VehConfigName = lbData[4, lbCurSel 4];

    lbClear 6;

    _vehdata = _availableVehs # selection # lbCurSel 4;

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

        if (_weaponDisplayName != "") then {
            lbAdd [6, format["    %1", _weaponDisplayName]];
        };
    } forEach _weapons;

    lbAdd [6, ""];
    lbAdd [6, "Magazines"];
    
    _magazines = _vehdata # 4;
    
    {
        _magazineDisplayName = getText(configFile >> "cfgMagazines" >> _x >> "displayName");
        if (_magazineDisplayName != "") then {
            lbAdd [6, format["    %1", _magazineDisplayName]];
        };
    } forEach _magazines;

    ctrlSetText [5, _availableVehs # selection # lbCurSel 4 # 2];

    sleep 0.1;
};