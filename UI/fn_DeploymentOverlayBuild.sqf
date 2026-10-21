call TYR_fnc_DeploymentOverlayCleanup;
if (isNil "TYR_ClientState") exitWith {false};
private _campaign = TYR_ClientState getOrDefault ["campaign",[]];
if !(_campaign isEqualType [] && {count _campaign >= 2}) exitWith {false};
private _deployment = _campaign # 1;
if !(_deployment isEqualType [] && {count _deployment >= 3}) exitWith {false};
private _sectors = _deployment # 2;
private _buffer = _deployment # 1;
if !(_sectors isEqualType [] && {count _sectors > 0}) exitWith {false};

// This is the proven v4.0.7 deployment-colour method: local area markers render
// reliably on Arma embedded maps. The improvement here is that the same grey
// no-HQ corridor is calculated on BOTH sides of EVERY faction border.
private _grid = 24;
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
        private _bestSector = [];
        private _bestDelta = 999;
        {
            if (_x isEqualType [] && {count _x >= 2}) then {
                private _fid = _x # 0;
                private _sector = _x # 1;
                if (_sector isEqualType [] && {count _sector >= 2}) then {
                    private _delta = abs (((_bearing - (_sector # 0) + 540) mod 360) - 180);
                    if (_delta < _bestDelta) then {
                        _bestDelta = _delta;
                        _bestFaction = _fid;
                        _bestSector = _sector;
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

            private _radius = _centre distance2D [_px,_py,0];
            private _half = _bestSector # 1;
            private _marginAngle = (_half - _bestDelta) max 0;
            private _borderDistance = if (_half >= 179) then {1e9} else {_radius * sin _marginAngle};
            private _inBuffer = _buffer > 0 && {_borderDistance < _buffer};

            if (_inBuffer) then {
                _name setMarkerColorLocal "ColorGrey";
                _name setMarkerAlphaLocal 0.34;
            } else {
                _name setMarkerColorLocal ([_bestFaction,false] call TYR_fnc_FactionColor);
                _name setMarkerAlphaLocal (if (!isNil "TYR_PlayerFaction" && {_bestFaction isEqualTo TYR_PlayerFaction}) then {0.30} else {0.17});
            };
            _markers pushBack _name;
        };
    };
};

missionNamespace setVariable ["TYR_DeploymentOverlayMarkers",_markers];
missionNamespace setVariable ["TYR_DeploymentOverlayCount",count _sectors];
diag_log format ["[TYRANTS DEPLOYMENT] Reliable local region overlay built: %1 region(s), %2 cells, symmetric border buffer.",count _sectors,count _markers];
true
