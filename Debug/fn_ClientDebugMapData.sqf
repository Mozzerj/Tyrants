params [["_data",[]]];
if !(missionNamespace getVariable ["TYR_debugMode",false]) exitWith {};
if !(_data isEqualType [] && {count _data >= 5}) exitWith {};

missionNamespace setVariable ["TYR_DebugMapData",_data];
missionNamespace setVariable ["TYR_DebugServerTime",_data param [0,0]];
missionNamespace setVariable ["TYR_DebugAITraces",_data param [5,[]]];

[] spawn {
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

    [] call TYR_fnc_DebugMenuRefresh;

    if (isNil "TYR_debugMapRefreshHandle" || {scriptDone TYR_debugMapRefreshHandle}) then {
        TYR_debugMapRefreshHandle = [] spawn {
            while {missionNamespace getVariable ["TYR_debugMode",false] && {!isNull findDisplay 1700}} do {
                sleep 3;
                if (!isNull findDisplay 1700) then {
                    ["debugMap",[]] remoteExecCall ["TYR_fnc_ServerDebugAction",2];
                };
            };
        };
    };
};
