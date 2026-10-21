if (!hasInterface) exitWith {};
[] spawn {
    private _lastTarget = objNull;
    private _lastReportAt = -9999;
    while {true} do {
        sleep 0.35;
        if (!isNull player && {alive player} && {!isNil "TYR_ClientState"} && {!isNil "TYR_PlayerFaction"}) then {
            private _campaign = TYR_ClientState getOrDefault ["campaign",[]];
            if (count _campaign > 0 && {(_campaign # 0) isEqualTo "running"}) then {
                private _target = cursorObject;
                if (isNull _target) then {_target = cursorTarget};
                if (!isNull _target && {alive _target}) then {
                    private _targetFaction = if (_target isKindOf "Man") then {[side group _target] call TYR_fnc_SideFaction} else {_target getVariable ["TYR_factionId",[side _target] call TYR_fnc_SideFaction]};
                    if (_targetFaction in ["west","east","independent"] && {_targetFaction isNotEqualTo TYR_PlayerFaction}) then {
                        if (_target isNotEqualTo _lastTarget || {(diag_tickTime - _lastReportAt) >= 1.1}) then {
                            private _uav = getConnectedUAV player;
                            private _observer = cameraOn;
                            if (isNull _observer) then {_observer = player};
                            if (!isNull _uav && {(_uav distance _target) < ((vehicle player) distance _target)}) then {_observer = _uav};
                            private _source = "player-visual";
                            if (!isNull _uav && {_observer isEqualTo _uav}) then {
                                _source = "uav-visual";
                            } else {
                                private _weapon = toLower currentWeapon player;
                                if ((_weapon find "binocular") >= 0 || {(_weapon find "rangefinder") >= 0} || {(_weapon find "laserdesignator") >= 0}) then {_source="player-optics"};
                            };
                            [_target,_observer,_source] remoteExecCall ["TYR_fnc_ServerReportVisualContact",2];
                            _lastTarget = _target;
                            _lastReportAt = diag_tickTime;
                        };
                    };
                };
            };
        };
    };
};
