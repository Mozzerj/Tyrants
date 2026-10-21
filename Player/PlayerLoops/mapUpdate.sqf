disableSerialization;

TYR_vehicleMarkers = [];
TYR_vehicleMarkerCounter = 0;

private _colourToRGBA = {
    params ["_colour"];
    switch (_colour) do {
        case "ColorWEST": {[0.00, 0.30, 0.60, 1.00]};
        case "ColorEAST": {[0.50, 0.00, 0.00, 1.00]};
        default {[0.00, 0.50, 0.00, 1.00]};
    };
};

while {true} do {
    if (!isNil "TYR_mapMarks") then {
        {
            private _categoryIndex = _forEachIndex;
            {
                private _region = _x;
                private _markIndex = TYR_mapMarks findIf {(_x # 0) isEqualTo (_region # 0)};
                if (_markIndex >= 0) then {
                    private _mark = TYR_mapMarks # _markIndex;
                    private _header = _mark # 1;
                    private _background = _mark # 2;
                    _header ctrlSetBackgroundColor ([(_region # (Pside + 1))] call _colourToRGBA);
                    lbClear _background;
                    _background lbAdd "";

                    if (_categoryIndex < 2) then {
                        private _population = (count (nearestObjects [_region # 4, ["House"], 250])) * 3;
                        _background lbAdd format ["Pop: %1", _population];
                    } else {
                        _background lbAdd format ["Type: %1", _region # 7];
                        if (PColor isEqualTo (_region # 3)) then {
                            _background lbAdd format ["Stock: %1", round (_region # 6)];
                        };
                    };
                };
            } forEach _x;
        } forEach (GameData # 1);
    };

    private _currentObjects = [];
    {
        private _veh = _x # 1;
        if (!isNull _veh && {alive _veh}) then {
            _currentObjects pushBack _veh;
            private _markerIndex = TYR_vehicleMarkers findIf {(_x # 0) isEqualTo _veh};
            private _marker = "";
            if (_markerIndex < 0) then {
                _marker = createMarkerLocal [format ["TYR_vehicle_%1_%2", clientOwner, TYR_vehicleMarkerCounter], getPosATL _veh];
                TYR_vehicleMarkerCounter = TYR_vehicleMarkerCounter + 1;
                _marker setMarkerTypeLocal "mil_triangle";
                _marker setMarkerColorLocal PColor;
                _marker setMarkerTextLocal getText (configFile >> "CfgVehicles" >> typeOf _veh >> "displayName");
                TYR_vehicleMarkers pushBack [_veh, _marker];
            } else {
                _marker = TYR_vehicleMarkers # _markerIndex # 1;
            };
            _marker setMarkerDirLocal getDir _veh;
            _marker setMarkerPosLocal getPosATL _veh;
        };
    } forEach (GameData # 4 # Pside);

    if (count TYR_vehicleMarkers > 0) then {
        for "_i" from ((count TYR_vehicleMarkers) - 1) to 0 step -1 do {
            private _pair = TYR_vehicleMarkers # _i;
            if (isNull (_pair # 0) || {!((_pair # 0) in _currentObjects)}) then {
                deleteMarkerLocal (_pair # 1);
                TYR_vehicleMarkers deleteAt _i;
            };
        };
    };

    private _mapDisplay = findDisplay 12;
    if (!isNull _mapDisplay) then {
        private _baseBackground = _mapDisplay displayCtrl 3002;
        lbClear _baseBackground;
        _baseBackground lbAdd "";
        _baseBackground lbAdd format ["Steel: %1", round (GameData # 0 # (Pside + 1) # 1)];
        _baseBackground lbAdd format ["Ammo: %1", round (GameData # 0 # (Pside + 1) # 2)];
        _baseBackground lbAdd format ["Fuel: %1", round (GameData # 0 # (Pside + 1) # 3)];
        _baseBackground lbAdd format ["HR: %1", round (GameData # 0 # (Pside + 1) # 4)];
    };

    sleep 1;
};
