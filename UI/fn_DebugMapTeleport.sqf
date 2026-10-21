params ["_position"];
if !(missionNamespace getVariable ["TYR_debugMode",false]) exitWith {};
if !(_position isEqualType [] && {count _position >= 2}) exitWith {};

private _pos = [_position # 0,_position # 1,0];
private _veh = vehicle player;
if (_veh isEqualTo player) then {
    player setPosATL _pos;
} else {
    if (local _veh) then {
        _veh setPosATL _pos;
    } else {
        moveOut player;
        player setPosATL _pos;
    };
};
missionNamespace setVariable ["TYR_DebugLastTeleport",_pos];
hint format ["Debug map teleport: %1 / %2",round (_pos # 0),round (_pos # 1)];
