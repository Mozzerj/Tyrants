if (isNil "TYR_mapEH") then {
    TYR_mapEH = addMissionEventHandler ["Map",{
        params ["_open"];
        if (_open) then {
            [] spawn {
                disableSerialization;
                waitUntil {sleep 0.01;!isNull findDisplay 12};
                private _map = (findDisplay 12) displayCtrl 51;
                if !(_map getVariable ["TYR_drawAttached",false]) then {
                    _map setVariable ["TYR_drawAttached",true];
                    _map ctrlAddEventHandler ["Draw",{_this call TYR_fnc_ClientMapDraw}];
                };
            };
        };
    }];
};

[] spawn {
    private _lastRequested = "";
    private _nextRequest = 0;
    while {true} do {
        sleep 2;
        if (!isNil "TYR_ClientState" && {!isNil "TYR_PlayerFaction"}) then {
            private _best = "";
            private _bestD = 1e9;
            {
                private _l = _x;
                private _currentFriendly = (_l # 4) isEqualTo TYR_PlayerFaction && {count _l <= 10 || {_l # 10}};
                if (!_currentFriendly) then {
                    private _d = player distance2D (_l # 3);
                    if (_d < 175 && {_d < _bestD}) then {_bestD=_d;_best=_l # 0};
                };
            } forEach values (TYR_ClientState get "locations");
            if (_best isNotEqualTo "" && {(_best isNotEqualTo _lastRequested) || {diag_tickTime >= _nextRequest}}) then {
                [_best] remoteExecCall ["TYR_fnc_ServerBeginCapture",2];
                _lastRequested = _best;
                _nextRequest = diag_tickTime + 12;
            };
            if (_best isEqualTo "") then {_lastRequested=""};
        };
    };
};
