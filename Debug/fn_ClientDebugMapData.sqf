params [["_data",[]]];
if !(missionNamespace getVariable ["TYR_debugMode",false]) exitWith {};
if !(_data isEqualType [] && {count _data >= 5}) exitWith {};
missionNamespace setVariable ["TYR_DebugMapData",_data];
missionNamespace setVariable ["TYR_DebugServerTime",_data param [0,0]];
missionNamespace setVariable ["TYR_DebugAITraces",_data param [5,[]]];

disableSerialization;
private _display = findDisplay 1700;
if (isNull _display) exitWith {};
private _map = _display displayCtrl 1000;
if (!isNull _map && {!(_map getVariable ["TYR_debugDrawAttached",false])}) then {
    _map setVariable ["TYR_debugDrawAttached",true];
    _map ctrlAddEventHandler ["Draw",{_this call TYR_fnc_ClientDebugMapDraw}];
    _map ctrlAddEventHandler ["MouseButtonDown",{
        params ["_mapCtrl","_button","_mouseX","_mouseY"];
        if (_button isEqualTo 0 && {missionNamespace getVariable ["TYR_DebugMapTeleportMode",false]}) exitWith {
            private _world = _mapCtrl ctrlMapScreenToWorld [_mouseX,_mouseY];
            [_world] call TYR_fnc_DebugMapTeleport;
            true
        };
        false
    }];
    _map ctrlMapAnimAdd [0,0.08,[worldSize * 0.5,worldSize * 0.5,0]];
    ctrlMapAnimCommit _map;
};

[] call TYR_fnc_DebugMenuUpdateStatus;

// One lightweight polling loop per open console. Expensive full-map payloads are
// requested only while the truth map is visible. Other pages are event-driven.
if (isNil "TYR_debugMapRefreshHandle" || {scriptDone TYR_debugMapRefreshHandle}) then {
    TYR_debugMapRefreshHandle = [] spawn {
        private _lastMap = -100;
        private _lastTrace = -100;
        while {missionNamespace getVariable ["TYR_debugMode",false] && {missionNamespace getVariable ["TYR_debugMenuOpen",false]} && {!isNull findDisplay 1700}} do {
            private _view = missionNamespace getVariable ["TYR_debugView","map"];
            private _now = diag_tickTime;
            if (_view isEqualTo "flow" && {_now - _lastTrace >= 0.55}) then {
                _lastTrace = _now;
                ["debugTrace",[missionNamespace getVariable ["TYR_debugFaction",""]]] remoteExecCall ["TYR_fnc_ServerDebugAction",2];
            };
            if (_view isEqualTo "map" && {_now - _lastMap >= 4}) then {
                _lastMap = _now;
                ["debugMap",[]] remoteExecCall ["TYR_fnc_ServerDebugAction",2];
            };
            sleep 0.15;
        };
    };
};
