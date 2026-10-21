params ["_obj"];
if (isNull _obj) exitWith {};
private _id = _obj getVariable ["TYR_persistentId",""];
if (_id isEqualTo "") exitWith {};
missionNamespace setVariable ["TYR_vlsEmplacementId",_id];
missionNamespace setVariable ["TYR_vlsObject",_obj];
missionNamespace setVariable ["TYR_vlsTargeting",false];
missionNamespace setVariable ["TYR_vlsCoverOpen",false];
if (isNull findDisplay 1204) then {createDialog "TyrantsVLSMenu"};
waitUntil {!isNull findDisplay 1204};
private _d = findDisplay 1204;
private _map = _d displayCtrl 1000;
_map ctrlMapAnimAdd [0,0.1,getPosATL _obj];
ctrlMapAnimCommit _map;
_map ctrlAddEventHandler ["MouseButtonDown",{
    params ["_ctrl","_button","_mx","_my"];
    if (_button isEqualTo 0 && {missionNamespace getVariable ["TYR_vlsTargeting",false]}) then {
        private _pos = _ctrl ctrlMapScreenToWorld [_mx,_my];
        missionNamespace setVariable ["TYR_vlsTargeting",false];
        [missionNamespace getVariable ["TYR_vlsEmplacementId",""],[_pos # 0,_pos # 1,0]] remoteExecCall ["TYR_fnc_ServerAddVLSTarget",2];
        (findDisplay 1204 displayCtrl 15) ctrlSetText "TARGET SENT // press ADD TARGET to designate another";
    };
    false
}];
[_id] remoteExecCall ["TYR_fnc_ServerGetVLSState",2];
[] call TYR_fnc_VLSMenuRefresh;
