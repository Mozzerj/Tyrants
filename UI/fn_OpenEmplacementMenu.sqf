disableSerialization;
if (isNull findDisplay 1203) then {createDialog "TyrEmplacementMenu"};
waitUntil {!isNull findDisplay 1203};
private _d = findDisplay 1203;
private _list = _d displayCtrl 1;
lbClear _list;
private _f = (TYR_ClientState get "factions") getOrDefault [TYR_PlayerFaction,[]];
private _unlocked = if (count _f >= 7) then {_f # 6} else {[]};
{
    if ((_x # 5) && {(_x # 2) in _unlocked}) then {
        private _i = _list lbAdd format ["%1 // %2 steel",_x # 1,_x # 3];
        _list lbSetData [_i,_x # 0];
    };
} forEach call TYR_fnc_GetEmplacementDefinitions;
if (lbSize _list > 0) then {_list lbSetCurSel 0};

missionNamespace setVariable ["TYR_emplacementPendingPos",[]];
missionNamespace setVariable ["TYR_emplacementTargeting",false];
private _map = _d displayCtrl 1000;
_map ctrlMapAnimAdd [0,0.2,getPosATL player];
ctrlMapAnimCommit _map;
_map ctrlAddEventHandler ["MouseButtonDown",{
    params ["_ctrl","_button","_mx","_my"];
    if (_button isEqualTo 0 && {missionNamespace getVariable ["TYR_emplacementTargeting",false]}) then {
        private _pos = _ctrl ctrlMapScreenToWorld [_mx,_my];
        missionNamespace setVariable ["TYR_emplacementPendingPos",[_pos # 0,_pos # 1,0]];
        missionNamespace setVariable ["TYR_emplacementTargeting",false];
        private _d = findDisplay 1203;
        (_d displayCtrl 4) ctrlSetText format ["POSITION LOCKED // %1 / %2",round (_pos # 0),round (_pos # 1)];
    };
    false
}];
