private _asset = missionNamespace getVariable ["TYR_activeVLS", objNull];
if (isNull _asset) exitWith {hint "No VLS selected."};
createDialog "TyrantsVLSMenu";
private _display = findDisplay 1204;
if (isNull _display) exitWith {};
private _list = _display displayCtrl 1;
private _targets = GameData # 0 # (Pside + 1) param [6, []];
{
    private _row = _list lbAdd format ["Target %1: %2", _forEachIndex + 1, _x];
    _list lbSetData [_row, str _forEachIndex];
    private _marker = createMarkerLocal [format ["TYR_VLS_Target_%1_%2", Pside, _forEachIndex], _x];
    _marker setMarkerTypeLocal "hd_destroy_noShadow";
    _marker setMarkerColorLocal PColor;
} forEach _targets;
waitUntil {sleep 0.25; isNull findDisplay 1204};
{
    deleteMarkerLocal format ["TYR_VLS_Target_%1_%2", Pside, _forEachIndex];
} forEach _targets;
