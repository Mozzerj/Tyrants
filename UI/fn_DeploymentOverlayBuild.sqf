call TYR_fnc_DeploymentOverlayCleanup;
if (isNil "TYR_ClientState") exitWith {false};
private _campaign = TYR_ClientState getOrDefault ["campaign",[]];
if !(_campaign isEqualType [] && {count _campaign >= 2}) exitWith {false};
private _deployment = _campaign # 1;
if !(_deployment isEqualType [] && {count _deployment >= 3}) exitWith {false};
private _sectors = _deployment # 2;
private _buffer = _deployment # 1;
if !(_sectors isEqualType [] && {count _sectors > 0}) exitWith {false};

// Native local area markers are used for the colour wash instead of relying on
// drawTriangle fills. They render on every Arma map control, including embedded
// dialog maps, and exist only on this client while the deployment dialog is open.
private _grid = 20;
private _cell = worldSize / _grid;
private _halfCell = (_cell * 0.505) max 1;
private _centre = [worldSize * 0.5,worldSize * 0.5,0];
private _markers = [];
private _ownerTag = if (isMultiplayer) then {str clientOwner} else {"SP"};

for "_gx" from 0 to (_grid - 1) do {
    for "_gy" from 0 to (_grid - 1) do {
        private _px = (_gx + 0.5) * _cell;
        private _py = (_gy + 0.5) * _cell;
        private _dx = _px - (_centre # 0);
        private _dy = _py - (_centre # 1);
        private _bearing = ((_dx atan2 _dy) + 360) mod 360;

        private _bestFaction = "";
        private _bestDelta = 999;
        {
            if (_x isEqualType [] && {count _x >= 2}) then {
                private _fid = _x # 0;
                private _sector = _x # 1;
                if (_sector isEqualType [] && {count _sector >= 2}) then {
                    private _sectorCentre = _sector # 0;
                    private _delta = abs (((_bearing - _sectorCentre + 540) mod 360) - 180);
                    if (_delta < _bestDelta) then {
                        _bestDelta = _delta;
                        _bestFaction = _fid;
                    };
                };
            };
        } forEach _sectors;

        if (_bestFaction isNotEqualTo "") then {
            private _name = format ["TYR_DEPLOY_REGION_%1_%2_%3",_ownerTag,_gx,_gy];
            createMarkerLocal [_name,[_px,_py,0]];
            _name setMarkerShapeLocal "RECTANGLE";
            _name setMarkerBrushLocal "Solid";
            _name setMarkerSizeLocal [_halfCell,_halfCell];
            _name setMarkerColorLocal ([_bestFaction,false] call TYR_fnc_FactionColor);
            private _alpha = 0.17;
            if (!isNil "TYR_PlayerFaction" && {_bestFaction isEqualTo TYR_PlayerFaction}) then {
                _alpha = 0.30;
                // Visually mute the no-HQ buffer along the two radial borders of the player's sector.
                private _ownEntry = _sectors select {_x isEqualType [] && {count _x >= 2} && {(_x # 0) isEqualTo _bestFaction}};
                if (count _ownEntry > 0) then {
                    private _ownSector = (_ownEntry # 0) # 1;
                    private _half = _ownSector # 1;
                    private _delta = abs (((_bearing - (_ownSector # 0) + 540) mod 360) - 180);
                    private _radius = _centre distance2D [_px,_py,0];
                    private _marginAngle = _half - _delta;
                    private _borderDistance = if (_half >= 179) then {1e9} else {_radius * sin _marginAngle};
                    if (_borderDistance < _buffer) then {_alpha = 0.08};
                };
            };
            _name setMarkerAlphaLocal _alpha;
            _markers pushBack _name;
        };
    };
};

missionNamespace setVariable ["TYR_DeploymentOverlayMarkers",_markers];
missionNamespace setVariable ["TYR_DeploymentOverlayCount",count _sectors];
diag_log format ["[TYRANTS DEPLOYMENT] Client colour overlay built: %1 region(s), %2 local cells.",count _sectors,count _markers];
true
