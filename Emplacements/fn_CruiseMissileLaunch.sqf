params ["_vls","_targetPos",["_factionId","west"]];
if (!isServer || {isNull _vls}) exitWith {};
private _target = createVehicle ["ArtilleryTargetW",_targetPos,[],0,"CAN_COLLIDE"];
private _missile = createVehicle ["ammo_Missile_Cruise_01",(getPosATL _vls) vectorAdd [0,0,2],[],0,"CAN_COLLIDE"];
_missile setVelocity [0,0,12];
private _start = time;
sleep 1;
while {alive _missile && {time-_start < 180} && {_missile distance2D _target > 30}} do {
    private _from = getPosASL _missile;
    private _to = getPosASL _target;
    private _d = _to vectorDiff _from;
    private _horizontal = sqrt ((_d#0)^2 + (_d#1)^2);
    private _yaw = (getPosATL _missile) getDir _targetPos;
    private _pitch = if (_horizontal > 1200) then {
        private _terrain = getTerrainHeightASL ((getPosATL _missile) getPos [80,_yaw]);
        (((_terrain + 120 - (_from#2)) * 0.08) max -8) min 8
    } else {
        (_d#2) atan2 (_horizontal max 1)
    };
    _missile setVectorDirAndUp [
        [sin _yaw * cos _pitch,cos _yaw * cos _pitch,sin _pitch],
        [[0,-sin _pitch,cos _pitch],-_yaw] call BIS_fnc_rotateVector2D
    ];
    _missile setVelocityModelSpace [0,210,0];
    sleep 0.1;
};
if (alive _missile && {time-_start >= 180}) then {deleteVehicle _missile};
deleteVehicle _target;
