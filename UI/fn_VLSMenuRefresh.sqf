disableSerialization;
private _d = findDisplay 1204;
if (isNull _d) exitWith {};
private _targets = missionNamespace getVariable ["TYR_vlsTargets",[]];
private _ammo = missionNamespace getVariable ["TYR_vlsAmmo",-1];
private _list = _d displayCtrl 1;
private _selected = lbCurSel _list;
lbClear _list;
{
    private _i = _list lbAdd format ["TARGET %1 // %2,%3",_forEachIndex + 1,round (_x # 0),round (_x # 1)];
    _list lbSetData [_i,str _forEachIndex];
} forEach _targets;
if (count _targets > 0) then {_list lbSetCurSel ((_selected max 0) min ((count _targets)-1))};
(_d displayCtrl 12) ctrlSetText format ["MISSILES: %1",if (_ammo < 0) then {"--"} else {_ammo}];
(_d displayCtrl 13) ctrlSetText format ["TARGETS: %1 / 18",count _targets];
(_d displayCtrl 2) ctrlSetText "NETWORK READY // targets are faction-wide";
private _coverOpen = missionNamespace getVariable ["TYR_vlsCoverOpen",false];
(_d displayCtrl 10) ctrlEnable _coverOpen;
